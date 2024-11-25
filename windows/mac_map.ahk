#Requires AutoHotkey v2.0
; Set the working directory to the script's directory
SetWorkingDir A_ScriptDir

; Initialize global variable
global altTabOpen := false

; Define hotkeys
~LCtrl & Tab::AltTabMenu()
~LCtrl Up::ExitAltTab()

AltTabMenu() {
    global altTabOpen  ; Declare global inside function
    if !altTabOpen {
        altTabOpen := true
        if GetKeyState("Shift") {
            Send "{Alt down}{Shift down}{Tab}"
        } else {
            Send "{Alt down}{Tab}"
        }
    } else {
        if GetKeyState("Shift") {
            Send "{Shift down}{Tab}{Shift up}"
        } else {
            Send "{Tab}"
        }
    }
}

ExitAltTab() {
    global altTabOpen  ; Declare global inside function
    altTabOpen := false
    Send "{Alt up}"
}

!Tab::Send "^Tab"
!+Tab::Send "^+Tab"
^Space::Send "^{Esc}"
^Left::Send "{Home}"
^Right::Send "{End}"
^+Left::Send "+{Home}"
^+Right::Send "+{End}"
^Up::Send "^{Home}"
^Down::Send "^{End}"
^+Up::Send "^+{Home}"
^+Down::Send "^+{End}"

; Cycle through windows of the same application
~LCtrl & `::CycleAppWindows()

CycleAppWindows() {
    ; Get the process name of the active window
    activeProcess := WinGetProcessName("A")
    ; Retrieve a list of all windows matching the process name
    winList := WinGetList("ahk_exe " activeProcess)
    ; If only one window is found, do nothing
    if winList.Length <= 1
        return
    ; Get the ID of the currently active window
    activeWinID := WinGetID("A")
    ; Find the index of the active window in the list
    currentIndex := GetArrayValueIndex(winList, activeWinID)
    ; Determine the next window to activate
    nextIndex := (currentIndex + 1) > winList.Length ? 1 : currentIndex + 1
    nextWinID := winList[nextIndex]
    ; Activate the next window
    WinActivate nextWinID
}

; Custom function to find the index of a value in an array
GetArrayValueIndex(arr, val) {
    for index, element in arr {
        if element == val
            return index
    }
    return 0  ; Return 0 if the value is not found
}