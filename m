From: julien.grall@linaro.org (Julien Grall)
Date: Mon, 07 Apr 2014 14:59:53 +0100
Subject: [RFC] Extend zImage format to support notes
Message-ID: <5342AF59.3030405@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

Currently ELF is supporting notes (see include/linux/elfnote.h) which
is used by Xen to know the feature supported by the kernel.

On ARM world, the zImage format is mainly used by the distribution.
Rather than ELF, it's currently not possible to add notes on it.

==== Current zImage format ====

The header starts at offset 0x24:
    uint32_t  magic      /* Magic number: 0x016f2818 */
    uint32_t  start      /* absolute load/run zImage address */
    uint32_t  end        /* zImage end address */

==== Extension proposed to zImage format ===

The header stays compatible with the current format and starts at offset 0x24:
    uint32_t  magic0     /* Magic number : 0x16f2818 */
    uint32_t  start      /* absolute load/run zImage address */
    uint32_t  end        /* zImage end address */
    uint32_t  magic1     /* Magic number : "ARM\x32" */
    uint32_t  note_start /* Notes section offset */
    uint32_t  note_end   /* Notes sections end */

I was thinking to also add a version field in case we might want to extend the
format in the future.

The notes section will contains a list of note (see description below).

==== Format of a note ====

The format is compatible with ELF note:

Name size : 4 bytes
Desc size : 4 bytes
Type :  4 bytes: identify the type of the note
Name : variable size, padded to 4 byte boundary
Desc : variable size, padded to 4 byte boundary : contains data related to the note type.

The "Name size", "Desc size" and "Type" fields are interpreted as an integer.

I wrote a quick patch to show what would be the modification on Linux side (see below).

Comments and questions are welcomed.

Sincerely yours,

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 066b034..104d862 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -133,6 +138,12 @@ start:
                .word   0x016f2818              @ Magic numbers to help the loader
                .word   start                   @ absolute load/run zImage address
                .word   _edata                  @ zImage end address
+               .byte   0x41                    @ Magic number, "ARM\x32"
+               .byte   0x52
+               .byte   0x4d
+               .byte   0x32
+               .word   _note_start             @ Notes section offset
+               .word   _note_end               @ Notes section end
  THUMB(                .thumb                  )
 1:
  ARM_BE8(      setend  be )                    @ go BE8 if compiled for BE8
diff --git a/arch/arm/boot/compressed/vmlinux.lds.in b/arch/arm/boot/compressed/vmlinux.lds.in
index 4919f2a..d3287ff 100644
--- a/arch/arm/boot/compressed/vmlinux.lds.in
+++ b/arch/arm/boot/compressed/vmlinux.lds.in
@@ -52,6 +52,10 @@ SECTIONS
   .got                 : { *(.got) }
   _got_end = .;
 
+  _note_start = .;
+  .note                        : { *(.note*) }
+  _note_end = .;
+
   /* ensure the zImage file size is always a multiple of 64 bits */
   /* (without a dummy byte, ld just ignores the empty section) */
   .pad                 : { BYTE(0); . = ALIGN(8); }
diff --git a/include/linux/elfnote.h b/include/linux/elfnote.h
index 278e3ef..9ad4488 100644
--- a/include/linux/elfnote.h
+++ b/include/linux/elfnote.h
@@ -39,7 +39,7 @@
  *      ELFNOTE(XYZCo, 12, .long, 0xdeadbeef)
  */
 #define ELFNOTE_START(name, type, flags)       \
-.pushsection .note.name, flags, at note   ;       \
+.pushsection .note.name, flags,%note   ;       \
   .balign 4                            ;       \
   .long 2f - 1f                /* namesz */    ;       \
   .long 4484f - 3f     /* descsz */    ;       \


-- 
Julien Grall
