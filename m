From: js@sig21.net (Johannes Stezenbach)
Date: Fri, 4 Jun 2010 12:38:51 +0200
Subject: [PATCH RFC] fix placement of the .note.gnu.build-id section
Message-ID: <20100604103851.GA5616@sig21.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I've brought up the issue before but there was no conclusion:
http://lists.infradead.org/pipermail/linux-arm-kernel/2010-May/015994.html

Now there was a thread on lkml that brought to my attention
that perf uses the build-id to match perf record files
to the matching vmlinux ELF file:
http://lkml.org/lkml/2010/6/3/445

I'm not sure about the state of perf on ARM, but I guess we
should follow x86, thus I'm proposing the following patch.

-------------
ARM: fix placement of the .note.gnu.build-id section

The build-id and other ELF notes should be made available
at runtime in /sys/kernel/notes because it is used by perf
to match record files to the vmlinux ELF file.

Correcting the placement of the build-id section in the vmlinux
ELF file also avoids problems for JTAG debuggers which cannot
load the ELF file with the misplaced section into target RAM.

Old layout:

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


New layout:

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


Signed-off-by: Johannes Stezenbach <js@sig21.net>

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 64ba313..f938736 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -15,7 +15,7 @@ ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
 LDFLAGS_vmlinux	+= --be8
 endif
 
-OBJCOPYFLAGS	:=-O binary -R .note -R .note.gnu.build-id -R .comment -S
+OBJCOPYFLAGS	:=-O binary -R .comment -S
 GZFLAGS		:=-9
 #KBUILD_CFLAGS	+=-pipe
 # Explicitly specifiy 32-bit ARM ISA since toolchain default can be -mthumb:
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index b16c079..2fca978 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -17,6 +17,12 @@ jiffies = jiffies_64;
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
@@ -52,7 +58,7 @@ SECTIONS
 		__init_begin = _stext;
 		INIT_DATA
 #endif
-	}
+	} :text
 
 	PERCPU(PAGE_SIZE)
 
@@ -104,6 +110,8 @@ SECTIONS
 
 	RO_DATA(PAGE_SIZE)
 
+	NOTES :text :note
+
 	_etext = .;			/* End of text and rodata section */
 
 #ifdef CONFIG_ARM_UNWIND
@@ -115,7 +123,7 @@ SECTIONS
 		__start_unwind_idx = .;
 		*(.ARM.exidx*)
 		__stop_unwind_idx = .;
-	}
+	} :text
 	.ARM.unwind_tab : {
 		__start_unwind_tab = .;
 		*(.ARM.extab*)
@@ -169,7 +177,7 @@ SECTIONS
 		CONSTRUCTORS
 
 		_edata = .;
-	}
+	} :data
 	_edata_loc = __data_loc + SIZEOF(.data);
 
 #ifdef CONFIG_HAVE_TCM
