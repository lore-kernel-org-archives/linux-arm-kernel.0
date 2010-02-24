From: hector@marcansoft.com (Hector Martin)
Date: Wed, 24 Feb 2010 03:23:37 +0100
Subject: [PATCH] Clean up ARM compressed loader
Message-ID: <1266978217-7023-1-git-send-email-hector@marcansoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The -Dstatic= stuff in the Makefile is a hack and subtly breaks the
current inflate implementation, because the fixed inflate tables are
included into a function and removing static places them in the stack,
which bloats the stack and breaks references after the function returns.
So get rid of the hack.

Instead, clean up the stub loader and unify it. The loader is now
exactly the same regardless of whether you've enabled CONFIG_ZBOOT_ROM
or not, and runs from RAM in PIC mode. CONFIG_ZBOOT_ROM simply enables
an extra section of stub code that lets the zImage boot from ROM by
copying itself to RAM first.

The old TEXT/BSS settings for the ROM mode are replaced by
CONFIG_ZBOOT_ROM_START and CONFIG_ZBOOT_ROM_END. These simply define a
ROM address space area that lets the loader know when it should copy
itself to RAM. The zImage can be burned into ROM/Flash anywhere within
this space - it's still relocatable. It will also run from RAM.

When running from ROM, the copy is done to the kernel base address. This
gets overwritten with the decompressed kernel later by the existing
relocation code that's already used for RAM zImages loaded where the
final kernel should be. This isn't fully optimal, but the code needs to
be there anyway for RAM use, and this way we don't have to worry about
finding a suitable non-overlapping region of RAM to copy the zImage.

The disadvantage of copying zImage to RAM is requiring enough RAM to fit
both the compressed and uncompressed kernel image. This shouldn't be a
problem in practical systems.

This is untested on a real ROM platform, but has been tested using RAM
as fake ROM.

Signed-off-by: Hector Martin <hector@marcansoft.com>
Cc: Segher Boessenkool <segher@kernel.crashing.org>
---
 arch/arm/Kconfig                        |   35 +++---
 arch/arm/boot/Makefile                  |    2 +-
 arch/arm/boot/compressed/.gitignore     |    1 -
 arch/arm/boot/compressed/Makefile       |   27 +-----
 arch/arm/boot/compressed/head.S         |  173 ++++++++++++++++++-------------
 arch/arm/boot/compressed/misc.c         |    3 +-
 arch/arm/boot/compressed/vmlinux.lds    |   71 +++++++++++++
 arch/arm/boot/compressed/vmlinux.lds.in |   61 -----------
 8 files changed, 195 insertions(+), 178 deletions(-)
 create mode 100644 arch/arm/boot/compressed/vmlinux.lds
 delete mode 100644 arch/arm/boot/compressed/vmlinux.lds.in

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 184a6bd..183aa0e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1259,38 +1259,39 @@ endmenu
 
 menu "Boot options"
 
-# Compressed boot loader in ROM.  Yes, we really want to ask about
-# TEXT and BSS so we preserve their values in the config files.
-config ZBOOT_ROM_TEXT
-	hex "Compressed ROM boot loader base address"
+config ZBOOT_ROM_START
+	hex "ROM/flash start address (for compressed ROM boot)"
 	default "0"
 	help
-	  The physical address at which the ROM-able zImage is to be
-	  placed in the target.  Platforms which normally make use of
-	  ROM-able zImage formats normally set this to a suitable
+	  The physical address of the ROM in the target. This setting is
+	  used by the compressed loader to determine whether it is running
+	  from ROM or RAM. This does not have to be the address of the zImage in
+	  ROM; it can be the start of the ROM chip. Platforms which normally
+	  make use of ROM-able zImage formats normally set this to a suitable
 	  value in their defconfig file.
 
 	  If ZBOOT_ROM is not enabled, this has no effect.
 
-config ZBOOT_ROM_BSS
-	hex "Compressed ROM boot loader BSS address"
+config ZBOOT_ROM_SIZE
+	hex "ROM/flash size (for compressed ROM boot)"
 	default "0"
 	help
-	  The base address of an area of read/write memory in the target
-	  for the ROM-able zImage which must be available while the
-	  decompressor is running. It must be large enough to hold the
-	  entire decompressed kernel plus an additional 128 KiB.
-	  Platforms which normally make use of ROM-able zImage formats
-	  normally set this to a suitable value in their defconfig file.
+	  The size of the ROM chip in your target. You may place the zImage in
+	  ROM anywhere within the span defined by ZBOOT_ROM_START and
+	  ZBOOT_ROM_SIZE. Platforms which normally make use of ROM-able zImage
+	  formats normally set this to a suitable value in their defconfig file.
 
 	  If ZBOOT_ROM is not enabled, this has no effect.
 
 config ZBOOT_ROM
 	bool "Compressed boot loader in ROM/flash"
-	depends on ZBOOT_ROM_TEXT != ZBOOT_ROM_BSS
+	depends on ZBOOT_ROM_SIZE != 0
 	help
 	  Say Y here if you intend to execute your compressed kernel image
-	  (zImage) directly from ROM or flash.  If unsure, say N.
+	  (zImage) directly from ROM or flash. You need to specify the ROM start
+	  address and size. The resulting zImage will still boot from RAM.
+
+	  If unsure, say N.
 
 config CMDLINE
 	string "Default kernel command string"
diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
index 4a590f4..f2a598a 100644
--- a/arch/arm/boot/Makefile
+++ b/arch/arm/boot/Makefile
@@ -65,7 +65,7 @@ quiet_cmd_uimage = UIMAGE  $@
 		   -n 'Linux-$(KERNELRELEASE)' -d $< $@
 
 ifeq ($(CONFIG_ZBOOT_ROM),y)
-$(obj)/uImage: LOADADDR=$(CONFIG_ZBOOT_ROM_TEXT)
+$(obj)/uImage: LOADADDR=$(CONFIG_ZBOOT_ROM_START)
 else
 $(obj)/uImage: LOADADDR=$(ZRELADDR)
 endif
diff --git a/arch/arm/boot/compressed/.gitignore b/arch/arm/boot/compressed/.gitignore
index ab204db..3bc9fc2 100644
--- a/arch/arm/boot/compressed/.gitignore
+++ b/arch/arm/boot/compressed/.gitignore
@@ -1,3 +1,2 @@
 font.c
 piggy.gz
-vmlinux.lds
diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 2d4d88b..809ddba 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -48,25 +48,12 @@ else
 endif
 endif
 
-#
-# We now have a PIC decompressor implementation.  Decompressors running
-# from RAM should not define ZTEXTADDR.  Decompressors running directly
-# from ROM or Flash must define ZTEXTADDR (preferably via the config)
-# FIXME: Previous assignment to ztextaddr-y is lost here. See SHARK
-ifeq ($(CONFIG_ZBOOT_ROM),y)
-ZTEXTADDR	:= $(CONFIG_ZBOOT_ROM_TEXT)
-ZBSSADDR	:= $(CONFIG_ZBOOT_ROM_BSS)
-else
-ZTEXTADDR	:= 0
-ZBSSADDR	:= ALIGN(4)
-endif
-
-SEDFLAGS	= s/TEXT_START/$(ZTEXTADDR)/;s/BSS_START/$(ZBSSADDR)/
+EXTRA_CFLAGS	:= -fpic -fno-builtin
 
 suffix_$(CONFIG_KERNEL_GZIP) = gzip
 suffix_$(CONFIG_KERNEL_LZO)  = lzo
 
-targets       := vmlinux vmlinux.lds \
+targets       := vmlinux \
 		 piggy.$(suffix_y) piggy.$(suffix_y).o \
 		 font.o font.c head.o misc.o $(OBJS)
 
@@ -75,7 +62,6 @@ ORIG_CFLAGS := $(KBUILD_CFLAGS)
 KBUILD_CFLAGS = $(subst -pg, , $(ORIG_CFLAGS))
 endif
 
-EXTRA_CFLAGS  := -fpic -fno-builtin
 EXTRA_AFLAGS  := -Wa,-march=all
 
 # Supply ZRELADDR, INITRD_PHYS and PARAMS_PHYS to the decompressor via
@@ -106,10 +92,6 @@ lib1funcs = $(obj)/lib1funcs.o
 $(obj)/lib1funcs.S: $(srctree)/arch/$(SRCARCH)/lib/lib1funcs.S FORCE
 	$(call cmd,shipped)
 
-# Don't allow any static data in misc.o, which
-# would otherwise mess up our GOT table
-CFLAGS_misc.o := -Dstatic=
-
 $(obj)/vmlinux: $(obj)/vmlinux.lds $(obj)/$(HEAD) $(obj)/piggy.$(suffix_y).o \
 	 	$(addprefix $(obj)/, $(OBJS)) $(lib1funcs) FORCE
 	$(call if_changed,ld)
@@ -120,10 +102,5 @@ $(obj)/piggy.$(suffix_y): $(obj)/../Image FORCE
 
 $(obj)/piggy.$(suffix_y).o:  $(obj)/piggy.$(suffix_y) FORCE
 
-CFLAGS_font.o := -Dstatic=
-
 $(obj)/font.c: $(FONTC)
 	$(call cmd,shipped)
-
-$(obj)/vmlinux.lds: $(obj)/vmlinux.lds.in arch/arm/boot/Makefile .config
-	@sed "$(SEDFLAGS)" < $< > $@
diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 4fddc50..174955b 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -133,8 +133,8 @@ start:
 
 		b	1f
 		.word	0x016f2818		@ Magic numbers to help the loader
-		.word	start			@ absolute load/run zImage address
-		.word	_edata			@ zImage end address
+		.word	0			@ absolute load/run zImage address
+		.word	__zimage_size		@ zImage end address
 1:		mov	r7, r1			@ save architecture ID
 		mov	r8, r2			@ save atags pointer
 
@@ -169,77 +169,121 @@ not_angel:
 		 */
 
 		.text
-		adr	r0, LC0
- ARM(		ldmia	r0, {r1, r2, r3, r4, r5, r6, ip, sp}	)
- THUMB(		ldmia	r0, {r1, r2, r3, r4, r5, r6, ip}	)
- THUMB(		ldr	sp, [r0, #28]				)
-		subs	r0, r0, r1		@ calculate the delta offset
+		/*
+		 * Set up a stack. This needs to have an offset added later.
+		 */
+		ldr	sp, =__stack_end
 
-						@ if delta is zero, we are
-		beq	not_relocated		@ running at the address we
-						@ were linked at.
+		/*
+		 * This is used throughout the following code, and also in
+		 * the cache_on code to set up the page tables.
+		 */
+		ldr	r4, =zreladdr
 
+here:
+		adr	r0, here		@ calculate the delta offset.
+		ldr	r1, =here		@ this is the load address since
+		sub	r5, r0, r1		@ we're linked at address 0.
+
+#ifdef CONFIG_ZBOOT_ROM
 		/*
-		 * We're running at a different address.  We need to fix
-		 * up various pointers:
-		 *   r5 - zImage base address
-		 *   r6 - GOT start
-		 *   ip - GOT end
+		 * Check to see if we're running from ROM by seeing if our load
+		 * address is within the ROM space
 		 */
-		add	r5, r5, r0
-		add	r6, r6, r0
-		add	ip, ip, r0
+		ldr	r0, =CONFIG_ZBOOT_ROM_START
+		ldr	r1, =CONFIG_ZBOOT_ROM_SIZE
+		cmp	r5, r0
+		blo	in_ram
+		add	r1, r0, r1
+		cmp	r5, r1
+		bhs	in_ram
 
-#ifndef CONFIG_ZBOOT_ROM
 		/*
-		 * If we're running fully PIC === CONFIG_ZBOOT_ROM = n,
-		 * we need to fix up pointers into the BSS region.
-		 *   r2 - BSS start
-		 *   r3 - BSS end
-		 *   sp - stack pointer
+		 * Relocate ourselves to the kernel load address. This is a
+		 * known good RAM address. The overlap code later will perform
+		 * the final relocation of the decompressed kernel on top of us.
 		 */
-		add	r2, r2, r0
-		add	r3, r3, r0
-		add	sp, sp, r0
+		add	sp, sp, r4
 
 		/*
-		 * Relocate all entries in the GOT table.
+		 * Turn on caches to speed up copy
 		 */
-1:		ldr	r1, [r6, #0]		@ relocate entries in the GOT
-		add	r1, r1, r0		@ table.  This fixes up the
-		str	r1, [r6], #4		@ C references.
-		cmp	r6, ip
-		blo	1b
-#else
+		bl	cache_on
 
 		/*
-		 * Relocate entries in the GOT table.  We only relocate
-		 * the entries that are outside the (relocated) BSS region.
+		 * Do the copy
 		 */
-1:		ldr	r1, [r6, #0]		@ relocate entries in the GOT
-		cmp	r1, r2			@ entry < bss_start ||
-		cmphs	r3, r1			@ _end < entry
-		addlo	r1, r1, r0		@ table.  This fixes up the
-		str	r1, [r6], #4		@ C references.
-		cmp	r6, ip
+
+		mov	r0, r5			@ from (ROM)
+		mov	r1, r4			@ to (RAM)
+		ldr	r2, =__zimage_size	@ size
+		add	r2, r0, r2		@ ROM image end
+1:		ldmia	r0!, {r3, r10, r11, r12}
+		stmia	r1!, {r3, r10, r11, r12}
+		ldmia	r0!, {r3, r10, r11, r12}
+		stmia	r1!, {r3, r10, r11, r12}
+		cmp	r0, r2
 		blo	1b
+
+		bl	cache_clean_flush
+
+		/*
+		 * Load our new base (kernel load address) and continue running
+		 * from there.
+		 */
+		mov	r5, r4
+		ldr	r0, =fixup
+		add	r0, r0, r5
+		mov	pc, r0
+
 #endif
 
-not_relocated:	mov	r0, #0
-1:		str	r0, [r2], #4		@ clear bss
-		str	r0, [r2], #4
-		str	r0, [r2], #4
-		str	r0, [r2], #4
-		cmp	r2, r3
-		blo	1b
+in_ram:
 
 		/*
-		 * The C runtime environment should now be setup
-		 * sufficiently.  Turn the cache on, set up some
-		 * pointers, and start decompressing.
+		 * If we're running from RAM then just offset the stack and
+		 * enable caches.
 		 */
+
+		add	sp, sp, r5
 		bl	cache_on
 
+fixup:
+		cmp	r5, #0			@ if delta is zero, we are
+		beq	not_relocated		@ running@the address we
+						@ were linked at.
+
+		/*
+		 * Fix up the GOT address
+		 */
+		ldr	r1, =_got_start
+		add	r1, r1, r5
+		ldr	r2, =_got_end
+		add	r2, r2, r5
+
+		/*
+		 * Relocate all entries in the GOT table.
+		 */
+1:		ldr	r0, [r1]		@ relocate entries in the GOT
+		add	r0, r0, r5		@ table.  This fixes up the
+		str	r0, [r1], #4		@ C references.
+		cmp	r1, r2
+		blo	1b
+
+not_relocated:
+		ldr	r1, =__bss_start
+		add	r1, r1, r5
+		ldr	r2, =__bss_end
+		add	r2, r2, r5
+
+		mov	r0, #0
+1:		str	r0, [r1], #4		@ clear bss
+		str	r0, [r1], #4
+		str	r0, [r1], #4
+		str	r0, [r1], #4
+		cmp	r1, r2
+		blo	1b
+
 		mov	r1, sp			@ malloc space above stack
 		add	r2, sp, #0x10000	@ 64k max
 
@@ -278,7 +322,7 @@ not_relocated:	mov	r0, #0
  */
 		add	r1, r5, r0		@ end of decompressed kernel
 		adr	r2, reloc_start
-		ldr	r3, LC1
+		ldr	r3, reloc_size
 		add	r3, r2, r3
 1:		ldmia	r2!, {r9 - r12, r14}	@ copy relocation code
 		stmia	r1!, {r9 - r12, r14}
@@ -294,6 +338,9 @@ not_relocated:	mov	r0, #0
  THUMB(		add	r12, r5, r0		)
  THUMB(		mov	pc, r12			) @ call relocation code
 
+reloc_size:
+		.word reloc_end - reloc_start
+
 /*
  * We're not in danger of overwriting ourselves.  Do this the simple way.
  *
@@ -305,26 +352,13 @@ wont_overwrite:	mov	r0, r4
 		bl	decompress_kernel
 		b	call_kernel
 
-		.align	2
-		.type	LC0, #object
-LC0:		.word	LC0			@ r1
-		.word	__bss_start		@ r2
-		.word	_end			@ r3
-		.word	zreladdr		@ r4
-		.word	_start			@ r5
-		.word	_got_start		@ r6
-		.word	_got_end		@ ip
-		.word	user_stack+4096		@ sp
-LC1:		.word	reloc_end - reloc_start
-		.size	LC0, . - LC0
-
 #ifdef CONFIG_ARCH_RPC
 		.globl	params
 params:		ldr	r0, =params_phys
 		mov	pc, lr
-		.ltorg
 		.align
 #endif
+		.ltorg
 
 /*
  * Turn on the cache.  We need to setup some page tables so that we
@@ -548,6 +582,7 @@ __common_mmu_cache_on:
  * r9-r12,r14 = corrupted
  */
 		.align	5
+
 reloc_start:	add	r9, r5, r0
 		sub	r9, r9, #128		@ do not copy the stack
 		debug_reloc_start
@@ -1076,7 +1111,3 @@ memdump:	mov	r12, r0
 
 		.ltorg
 reloc_end:
-
-		.align
-		.section ".stack", "w"
-user_stack:	.space	4096
diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
index 56a0d11..97018f8 100644
--- a/arch/arm/boot/compressed/misc.c
+++ b/arch/arm/boot/compressed/misc.c
@@ -23,7 +23,6 @@ unsigned int __machine_arch_type;
 #include <linux/compiler.h>	/* for inline */
 #include <linux/types.h>	/* for size_t */
 #include <linux/stddef.h>	/* for NULL */
-#include <asm/string.h>
 #include <linux/linkage.h>
 
 #include <asm/unaligned.h>
@@ -166,7 +165,7 @@ void __memzero (__ptr_t s, size_t n)
 		*u.ucp++ = 0;
 }
 
-static inline __ptr_t memcpy(__ptr_t __dest, __const __ptr_t __src,
+static __ptr_t memcpy(__ptr_t __dest, __const __ptr_t __src,
 			    size_t __n)
 {
 	int i = 0;
diff --git a/arch/arm/boot/compressed/vmlinux.lds b/arch/arm/boot/compressed/vmlinux.lds
new file mode 100644
index 0000000..2ea7af5
--- /dev/null
+++ b/arch/arm/boot/compressed/vmlinux.lds
@@ -0,0 +1,71 @@
+/*
+ *  linux/arch/arm/boot/compressed/vmlinux.lds.in
+ *
+ *  Copyright (C) 2000 Russell King
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+OUTPUT_ARCH(arm)
+ENTRY(_start)
+SECTIONS
+{
+  /DISCARD/ : {
+    *(.ARM.exidx*)
+    *(.ARM.extab*)
+  }
+
+  /* Note: should always build at 0 for relocatable stub */
+  . = 0;
+
+  .text : {
+    _start = .;
+    *(.start)
+    *(.text)
+    *(.text.*)
+    *(.fixup)
+    *(.gnu.warning)
+    *(.rodata)
+    *(.rodata.*)
+    *(.glue_7)
+    *(.glue_7t)
+    *(.piggydata)
+    . = ALIGN(4);
+  }
+
+  /* The GOT is only for PIC builds, so it should not exist in the ROM build */
+  _got_start = .;
+  .got			: { *(.got) }
+  _got_end = .;
+  .got.plt		: { *(.got.plt) }
+
+  . = ALIGN(16);
+
+  .data : {
+    *(.data)
+    . = ALIGN(16);
+  }
+
+  __zimage_size = .;
+
+  __bss_start = .;
+  .bss : { *(.bss) }
+  . = ALIGN(16);
+  __bss_end = .;
+
+  .stack : {
+    __stack_start = .;
+    . += 4096;
+    __stack_end = .;
+  }
+
+  .stab 0		: { *(.stab) }
+  .stabstr 0		: { *(.stabstr) }
+  .stab.excl 0		: { *(.stab.excl) }
+  .stab.exclstr 0	: { *(.stab.exclstr) }
+  .stab.index 0		: { *(.stab.index) }
+  .stab.indexstr 0	: { *(.stab.indexstr) }
+  .comment 0		: { *(.comment) }
+}
+
diff --git a/arch/arm/boot/compressed/vmlinux.lds.in b/arch/arm/boot/compressed/vmlinux.lds.in
deleted file mode 100644
index a5924b9..0000000
--- a/arch/arm/boot/compressed/vmlinux.lds.in
+++ /dev/null
@@ -1,61 +0,0 @@
-/*
- *  linux/arch/arm/boot/compressed/vmlinux.lds.in
- *
- *  Copyright (C) 2000 Russell King
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-OUTPUT_ARCH(arm)
-ENTRY(_start)
-SECTIONS
-{
-  /DISCARD/ : {
-    *(.ARM.exidx*)
-    *(.ARM.extab*)
-  }
-
-  . = TEXT_START;
-  _text = .;
-
-  .text : {
-    _start = .;
-    *(.start)
-    *(.text)
-    *(.text.*)
-    *(.fixup)
-    *(.gnu.warning)
-    *(.rodata)
-    *(.rodata.*)
-    *(.glue_7)
-    *(.glue_7t)
-    *(.piggydata)
-    . = ALIGN(4);
-  }
-
-  _etext = .;
-
-  _got_start = .;
-  .got			: { *(.got) }
-  _got_end = .;
-  .got.plt		: { *(.got.plt) }
-  .data			: { *(.data) }
-  _edata = .;
-
-  . = BSS_START;
-  __bss_start = .;
-  .bss			: { *(.bss) }
-  _end = .;
-
-  .stack (NOLOAD)	: { *(.stack) }
-
-  .stab 0		: { *(.stab) }
-  .stabstr 0		: { *(.stabstr) }
-  .stab.excl 0		: { *(.stab.excl) }
-  .stab.exclstr 0	: { *(.stab.exclstr) }
-  .stab.index 0		: { *(.stab.index) }
-  .stab.indexstr 0	: { *(.stab.indexstr) }
-  .comment 0		: { *(.comment) }
-}
-
-- 
1.6.4.4
