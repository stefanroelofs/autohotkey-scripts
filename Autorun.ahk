;; This script is used to start programs (etc.) after windows has started and user has logged in
;; Author: Andreas Bader, August 2016
;; Revised by: Stefan Roelofs, March 2018
;; https://github.com/baderas/autohotkey-scripts

#NoEnv							; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance force			; FORCE skips the dialog box and replaces the old instance automatically, which is similar in effect to the Reload command.

#Include %A_LineFile%\..\WindowPlacementFunctions.ahk

{
	SetTitleMatchMode, 2		; Match mode 2: A window's title can contain WinTitle anywhere inside it to be a match.
	
	WorkWeekActive := A_WDay > 1 and A_WDay < 7 and A_Hour > 7 and A_Hour < 18
	
	ChromePath := "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
	OutlookPath := "C:\Program Files (x86)\Microsoft Office\root\Office16\OUTLOOK.EXE"
	DirectoryOpusPath := "C:\Program Files\GPSoftware\Directory Opus\dopus.exe"
	VisualStudioPath := "C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\Common7\IDE\devenv.exe"
	ThunderbirdPath := "C:\Program Files (x86)\Mozilla Thunderbird\thunderbird.exe"
	SkypePath := "C:\Program Files (x86)\Skype\Phone\Skype.exe"
	
	if (!WinExist("Google Chrome") and FileExist(ChromePath))
		Run, %ChromePath%
	
	if (!WinExist("Mozilla Thunderbird") and FileExist(ThunderbirdPath))
		Run, %ThunderbirdPath%
	
	if (!WinExist("Skype") and FileExist(SkypePath))
		Run, %SkypePath%
		
	if (WorkWeekActive)
	{
		if !WinExist("ahk_class rctrl_renwnd32") and FileExist(OutlookPath)
			Run, %OutlookPath%

		if !WinExist("ahk_class dopus.lister") and FileExist(DirectoryOpusPath)
			Run, %DirectoryOpusPath%

		if !WinExist("ahk_exe devenv.exe") and FileExist(VisualStudioPath)
			Run, %VisualStudioPath%
	}
	
	IfWinNotExist,KeePass
	{
		; Delete old cygwinsocket if still existing
		; (KeePass + KeeAgent)
		IfWinNotExist,  database.kdbx - KeePass
		{
			FileDelete, C:\Users\%USERNAME%\.ssh\cygwinsocket
		}
	}
	
	return
}
