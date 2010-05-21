From: js@sig21.net (Johannes Stezenbach)
Date: Fri, 21 May 2010 15:36:12 +0200
Subject: RFC: fix misplaced .note.gnu.build-id section
Message-ID: <20100521133612.GA30171@sig21.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

when building with a binutils version which supports --build-id
the .note.gnu.build-id section is placed at address 0 in the
resulting vmlinux ELF file:

Program Header:
    LOAD off    0x00008000 vaddr 0x00000000 paddr 0x00000000 align 2**15
         filesz 0x00000024 memsz 0x00000024 flags r--
    LOAD off    0x00010000 vaddr 0xc0008000 paddr 0xc0008000 align 2**15
         filesz 0x0033cb60 memsz 0x0036df04 flags rwx
    NOTE off    0x00008000 vaddr 0x00000000 paddr 0x00000000 align 2**2
         filesz 0x00000024 memsz 0x00000024 flags r--

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  0 .note.gnu.build-id 00000024  00000000  00000000  00008000  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA, LINK_ONCE_DISCARD


Commit 1e621a8e3752367d4aae78a8ab00a18fb2793f34 fixes this up
when generating the binary image via OBJCOPYFLAGS "-R .note.gnu.build-id",
but .note.gnu.build-id is left in the vmlinux ELF file.  This causes
problems when trying to load the ELF file using a JTAG debugger.

I fixed this up locally with the changes shown below, which are similar
to what x86 does, but since I don't understand the subtleties of the ARM
linker script I can't be sure it's correct.
If my changes are OK I would submit a proper patch for inclusion.

After my changes the ELF headers look like this:

Program Header:
    LOAD off    0x00008000 vaddr 0xc0008000 paddr 0xc0008000 align 2**15
         filesz 0x0031b024 memsz 0x0031b024 flags r-x
    LOAD off    0x00324000 vaddr 0xc0324000 paddr 0xc0324000 align 2**15
         filesz 0x00020b60 memsz 0x00051f04 flags rwx
    NOTE off    0x00323000 vaddr 0xc0323000 paddr 0xc0323000 align 2**2
         filesz 0x00000024 memsz 0x00000024 flags ---

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  7 .notes        00000024  c0323000  c0323000  00323000  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA, LINK_ONCE_DISCARD

Thanks
Johannes


Index: src/arch/arm/kernel/vmlinux.lds.S
===================================================================
--- src/arch/arm/kernel/vmlinux.lds.S	(revision 273885)
+++ src/arch/arm/kernel/vmlinux.lds.S	(working copy)
@@ -17,6 +17,12 @@
 jiffies = jiffies_64 + 4;
 #endif
 
+PHDRS {
+	text PT_LOAD FLAGS(5);		/* R_E */
+	data PT_LOAD FLAGS(7);		/* RWE */
+	note PT_NOTE FLAGS(0);		/* ___ */
+}
+
 SECTIONS
 {
 #ifdef CONFIG_XIP_KERNEL
@@ -28,7 +34,7 @@
 		_stext = .;
 		_sinittext = .;
 		*(.text.head)
-	}
+	} :text
 
 	.init : {			/* Init code and data		*/
 			INIT_TEXT
@@ -122,6 +128,8 @@
 
 	RO_DATA(PAGE_SIZE)
 
+	NOTES :text :note
+
 	_etext = .;			/* End of text and rodata section */
 
 #ifdef CONFIG_ARM_UNWIND
@@ -133,7 +141,7 @@
 		__start_unwind_idx = .;
 		*(.ARM.exidx*)
 		__stop_unwind_idx = .;
-	}
+	} :text
 	.ARM.unwind_tab : {
 		__start_unwind_tab = .;
 		*(.ARM.extab*)
@@ -196,7 +204,7 @@
 		CONSTRUCTORS
 
 		_edata = .;
-	}
+	} :data
 	_edata_loc = __data_loc + SIZEOF(.data);
 
 #ifdef CONFIG_HAVE_TCM
