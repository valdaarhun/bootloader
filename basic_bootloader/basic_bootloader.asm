;A simple bootloader for the x86 architecture
;We follow the method used in legacy booting

;BIOS loads the bootloader from the first sector of the bootable drive (boot sector) and into the RAM (location => 0000:7c00)
;The boot sector is 512 bytes in size
;Once loaded into memory, BIOS executes this code

;directive to tell the assembler to use 0x7c00 as the offset for addresses
org 0x7c00

;directive to tell the assembler to generate 16-bit instructions
;This is because the CPU starts in real mode which operates using 16-bit constructs in x86 architecture
bits 16

;According to the OSDev wiki, removing the infinite loop causes BIOS to throw an "OS not found" error. But I personally did not witness this when using qemu.
loop:
    jmp loop

    ;$ gives offset of the current position
    ;$$ gives offset of the section's starting position
    times 510-($-$$) db 0

    ;0xaa55 is the signature that BIOS uses to indentify the boot sector
    ;Stored in little endian format
    dw 0xaa55