From: hector@marcansoft.com (hector at marcansoft.com)
Date: Tue, 23 Feb 2010 14:57:17 +0100
Subject: [PATCH] Clean up ARM compressed loader
Message-ID: <1266933437-4876-1-git-send-email-hector@marcansoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hector Martin <hector@marcansoft.com>

The -Dstatic= stuff in the Makefile is a hack and subtly breaks the
current inflate implementation, because the fixed inflate tables are
included into a function and removing static places them in the stack,
which bloats the stack and breaks references after the function returns.
So get rid of the hack.

Instead, clean up the stub loader so PIC vs ROM mode is handled sanely
now. You can build two notably different versions now:

CONFIG_ZBOOT_ROM=y
 - Non-PIC: loader will halt if it finds itself at the wrong address.
 - Separate ROM and RAM bases (CONFIG_ZBOOT_ROM_TEXT and
   CONFIG_ZBOOT_ROM_BSS, the latter being a slight misnomer now).
 - Proper initialized data handling. Initialized data is copied from ROM
   to RAM on boot (VMA != LMA in linker script).
 - Assumes that the decompressed kernel will not overlap with the
   RAM used by the decompressor itself (CONFIG_ZBOOT_ROM_BSS should be
   somewhere after the loaded kernel address, e.g. near the end of RAM).
   No post-decompression relocation is done.

CONFIG_ZBOOT_ROM=n
 - PIC code: you can load this anywhere
 - Single blob, data follows code.
 - The loaded kernel may overlap with the loader, in which case it is
   relocated after compression as usual.

As far as I can tell, ROM PIC would've never worked with the existing
code (because, among other things, the GOT ends up in ROM), so this
shouldn't break anything.

This is untested on a real ROM platform, but has been tested using RAM
as fake ROM.

Cc: Segher Boessenkool <segher@kernel.crashing.org>
Signed-off-by: Hector Martin <hector@marcansoft.com>
---
 arch/arm/Kconfig                        |   10 ++-
 arch/arm/boot/compressed/Makefile       |   25 +++----
 arch/arm/boot/compressed/head.S         |  129 ++++++++++++++++--------------
 arch/arm/boot/compressed/misc.c         |    3 +-
 arch/arm/boot/compressed/vmlinux.lds.in |   29 ++++++--
 5 files changed, 110 insertions(+), 86 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 184a6bd..deb9eef 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1278,8 +1278,8 @@ config ZBOOT_ROM_BSS
 	help
 	  The base address of an area of read/write memory in the target
 	  for the ROM-able zImage which must be available while the
-	  decompressor is running. It must be large enough to hold the
-	  entire decompressed kernel plus an additional 128 KiB.
+	  decompressor is running. It must be able to hold at least 128 KiB
+	  of data and it must not overlap with the loaded kernel.
 	  Platforms which normally make use of ROM-able zImage formats
 	  normally set this to a suitable value in their defconfig file.
 
@@ -1290,7 +1290,11 @@ config ZBOOT_ROM
 	depends on ZBOOT_ROM_TEXT != ZBOOT_ROM_BSS
 	help
 	  Say Y here if you intend to execute your compressed kernel image
-	  (zImage) directly from ROM or flash.  If unsure, say N.
+	  (zImage) directly from ROM or flash. If you say Y, then the zImage
+	  will only run from the ZBOOT_ROM_TEXT address (it will not be
+	  position-independent).
+
+	  If unsure, say N.
 
 config CMDLINE
 	string "Default kernel command string"
diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 2d4d88b..acfd324 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -48,20 +48,22 @@ else
 endif
 endif
 
-#
-# We now have a PIC decompressor implementation.  Decompressors running
-# from RAM should not define ZTEXTADDR.  Decompressors running directly
-# from ROM or Flash must define ZTEXTADDR (preferably via the config)
-# FIXME: Previous assignment to ztextaddr-y is lost here. See SHARK
+# RAM builds should disable CONFIG_ZBOOT_ROM. The decompressor will be
+# built as position independent code and can be loaded at any address.
+# ROM builds should enable CONFIG_ZBOOT_ROM and set CONFIG_ZBOOT_ROM_TEXT
+# and CONFIG_ZBOOT_ROM_BSS. They will be built as position dependent code
+# and will only run when loaded at CONFIG_ZBOOT_ROM_TEXT.
 ifeq ($(CONFIG_ZBOOT_ROM),y)
 ZTEXTADDR	:= $(CONFIG_ZBOOT_ROM_TEXT)
-ZBSSADDR	:= $(CONFIG_ZBOOT_ROM_BSS)
+ZDATAADDR	:= $(CONFIG_ZBOOT_ROM_BSS)
+EXTRA_CFLAGS	:= -fno-builtin
 else
 ZTEXTADDR	:= 0
-ZBSSADDR	:= ALIGN(4)
+ZDATAADDR	:= ALIGN(4)
+EXTRA_CFLAGS	:= -fpic -fno-builtin
 endif
 
-SEDFLAGS	= s/TEXT_START/$(ZTEXTADDR)/;s/BSS_START/$(ZBSSADDR)/
+SEDFLAGS	= s/TEXT_START/$(ZTEXTADDR)/;s/DATA_START/$(ZDATAADDR)/
 
 suffix_$(CONFIG_KERNEL_GZIP) = gzip
 suffix_$(CONFIG_KERNEL_LZO)  = lzo
@@ -75,7 +77,6 @@ ORIG_CFLAGS := $(KBUILD_CFLAGS)
 KBUILD_CFLAGS = $(subst -pg, , $(ORIG_CFLAGS))
 endif
 
-EXTRA_CFLAGS  := -fpic -fno-builtin
 EXTRA_AFLAGS  := -Wa,-march=all
 
 # Supply ZRELADDR, INITRD_PHYS and PARAMS_PHYS to the decompressor via
@@ -106,10 +107,6 @@ lib1funcs = $(obj)/lib1funcs.o
 $(obj)/lib1funcs.S: $(srctree)/arch/$(SRCARCH)/lib/lib1funcs.S FORCE
 	$(call cmd,shipped)
 
-# Don't allow any static data in misc.o, which
-# would otherwise mess up our GOT table
-CFLAGS_misc.o := -Dstatic=
-
 $(obj)/vmlinux: $(obj)/vmlinux.lds $(obj)/$(HEAD) $(obj)/piggy.$(suffix_y).o \
 	 	$(addprefix $(obj)/, $(OBJS)) $(lib1funcs) FORCE
 	$(call if_changed,ld)
@@ -120,8 +117,6 @@ $(obj)/piggy.$(suffix_y): $(obj)/../Image FORCE
 
 $(obj)/piggy.$(suffix_y).o:  $(obj)/piggy.$(suffix_y) FORCE
 
-CFLAGS_font.o := -Dstatic=
-
 $(obj)/font.c: $(FONTC)
 	$(call cmd,shipped)
 
diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 4fddc50..dd7050b 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -169,69 +169,79 @@ not_angel:
 		 */
 
 		.text
-		adr	r0, LC0
- ARM(		ldmia	r0, {r1, r2, r3, r4, r5, r6, ip, sp}	)
- THUMB(		ldmia	r0, {r1, r2, r3, r4, r5, r6, ip}	)
- THUMB(		ldr	sp, [r0, #28]				)
-		subs	r0, r0, r1		@ calculate the delta offset
+		ldr	sp, =__stack_end
+
+here:
+		adr	r0, here
+		ldr	r1, =here
+		subs	r12, r0, r1		@ calculate the delta offset
 
 						@ if delta is zero, we are
 		beq	not_relocated		@ running at the address we
 						@ were linked at.
 
+#ifndef CONFIG_ZBOOT_ROM
+
 		/*
-		 * We're running at a different address.  We need to fix
-		 * up various pointers:
-		 *   r5 - zImage base address
-		 *   r6 - GOT start
-		 *   ip - GOT end
+		 * We're running at a different address. Fix up the stack.
 		 */
-		add	r5, r5, r0
-		add	r6, r6, r0
-		add	ip, ip, r0
+		add	sp, sp, r12
 
-#ifndef CONFIG_ZBOOT_ROM
 		/*
-		 * If we're running fully PIC === CONFIG_ZBOOT_ROM = n,
-		 * we need to fix up pointers into the BSS region.
-		 *   r2 - BSS start
-		 *   r3 - BSS end
-		 *   sp - stack pointer
+		 * Fix up the GOT address
 		 */
-		add	r2, r2, r0
-		add	r3, r3, r0
-		add	sp, sp, r0
+		ldr	r1, =_got_start
+		add	r1, r1, r12
+		ldr	r2, =_got_end
+		add	r2, r2, r12
 
 		/*
 		 * Relocate all entries in the GOT table.
 		 */
-1:		ldr	r1, [r6, #0]		@ relocate entries in the GOT
-		add	r1, r1, r0		@ table.  This fixes up the
-		str	r1, [r6], #4		@ C references.
-		cmp	r6, ip
+1:		ldr	r0, [r1]		@ relocate entries in the GOT
+		add	r0, r0, r12		@ table.  This fixes up the
+		str	r0, [r1], #4		@ C references.
+		cmp	r1, r2
 		blo	1b
+
 #else
+		/*
+		 * This ROM build is running from the wrong address, panic
+		 */
+		b	.
+#endif
+
+not_relocated:
+		ldr	r1, =__bss_start
+		add	r1, r1, r12
+		ldr	r2, =__bss_end
+		add	r2, r2, r12
 
+		mov	r0, #0
+1:		str	r0, [r1], #4		@ clear bss
+		str	r0, [r1], #4
+		str	r0, [r1], #4
+		str	r0, [r1], #4
+		cmp	r1, r2
+		blo	1b
+
+#ifdef CONFIG_ZBOOT_ROM
 		/*
-		 * Relocate entries in the GOT table.  We only relocate
-		 * the entries that are outside the (relocated) BSS region.
+		 * Copy the initialized data from ROM to RAM (LMA to VMA)
 		 */
-1:		ldr	r1, [r6, #0]		@ relocate entries in the GOT
-		cmp	r1, r2			@ entry < bss_start ||
-		cmphs	r3, r1			@ _end < entry
-		addlo	r1, r1, r0		@ table.  This fixes up the
-		str	r1, [r6], #4		@ C references.
-		cmp	r6, ip
+		ldr	r1, =__data_start
+		ldr	r2, =__data_end
+		ldr	r3, =__data_lma
+
+1:
+		ldmia	r3!, {r0, r4, r5, r6}
+		stmia	r1!, {r0, r4, r5, r6}
+		cmp	r1, r2
 		blo	1b
+
 #endif
 
-not_relocated:	mov	r0, #0
-1:		str	r0, [r2], #4		@ clear bss
-		str	r0, [r2], #4
-		str	r0, [r2], #4
-		str	r0, [r2], #4
-		cmp	r2, r3
-		blo	1b
+		ldr	r4, =zreladdr
 
 		/*
 		 * The C runtime environment should now be setup
@@ -244,6 +254,12 @@ not_relocated:	mov	r0, #0
 		add	r2, sp, #0x10000	@ 64k max
 
 /*
+ * It is assumed that in ROM builds the decompressed kernel will not overwrite
+ * our RAM .data/.bss/stack/malloc area
+ */
+#ifndef CONFIG_ZBOOT_ROM
+
+/*
  * Check to see if we will overwrite ourselves.
  *   r4 = final kernel address
  *   r5 = start of this image
@@ -252,6 +268,8 @@ not_relocated:	mov	r0, #0
  *   r4 >= r2 -> OK
  *   r4 + image length <= r5 -> OK
  */
+		ldr	r5, =_start
+		add	r5, r5, r12
 		cmp	r4, r2
 		bhs	wont_overwrite
 		sub	r3, sp, r5		@ > compressed kernel size
@@ -278,7 +296,7 @@ not_relocated:	mov	r0, #0
  */
 		add	r1, r5, r0		@ end of decompressed kernel
 		adr	r2, reloc_start
-		ldr	r3, LC1
+		ldr	r3, reloc_size
 		add	r3, r2, r3
 1:		ldmia	r2!, {r9 - r12, r14}	@ copy relocation code
 		stmia	r1!, {r9 - r12, r14}
@@ -294,6 +312,11 @@ not_relocated:	mov	r0, #0
  THUMB(		add	r12, r5, r0		)
  THUMB(		mov	pc, r12			) @ call relocation code
 
+reloc_size:
+		.word reloc_end - reloc_start
+
+#endif
+
 /*
  * We're not in danger of overwriting ourselves.  Do this the simple way.
  *
@@ -305,26 +328,13 @@ wont_overwrite:	mov	r0, r4
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
@@ -548,6 +558,8 @@ __common_mmu_cache_on:
  * r9-r12,r14 = corrupted
  */
 		.align	5
+
+#ifndef CONFIG_ZBOOT_ROM
 reloc_start:	add	r9, r5, r0
 		sub	r9, r9, #128		@ do not copy the stack
 		debug_reloc_start
@@ -563,6 +575,7 @@ reloc_start:	add	r9, r5, r0
 		mov	sp, r1
 		add	sp, sp, #128		@ relocate the stack
 		debug_reloc_end
+#endif
 
 call_kernel:	bl	cache_clean_flush
 		bl	cache_off
@@ -1076,7 +1089,3 @@ memdump:	mov	r12, r0
 
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
diff --git a/arch/arm/boot/compressed/vmlinux.lds.in b/arch/arm/boot/compressed/vmlinux.lds.in
index a5924b9..46efdf4 100644
--- a/arch/arm/boot/compressed/vmlinux.lds.in
+++ b/arch/arm/boot/compressed/vmlinux.lds.in
@@ -36,19 +36,36 @@ SECTIONS
 
   _etext = .;
 
+  /* The GOT is only for PIC builds, so it should not exist in the ROM build */
   _got_start = .;
   .got			: { *(.got) }
   _got_end = .;
   .got.plt		: { *(.got.plt) }
-  .data			: { *(.data) }
-  _edata = .;
 
-  . = BSS_START;
+  . = ALIGN(16);
+
+  __data_lma = .;
+
+  . = DATA_START;
+
+  __data_start = .;
+  .data : AT(__data_lma) {
+    *(.data)
+    . = ALIGN(16);
+  }
+  __data_end = .;
+  _edata = __data_lma + __data_end - __data_start;
+
   __bss_start = .;
-  .bss			: { *(.bss) }
-  _end = .;
+  .bss : { *(.bss) }
+  . = ALIGN(16);
+  __bss_end = .;
 
-  .stack (NOLOAD)	: { *(.stack) }
+  .stack : {
+    __stack_start = .;
+    . += 4096;
+    __stack_end = .;
+  }
 
   .stab 0		: { *(.stab) }
   .stabstr 0		: { *(.stabstr) }
-- 
1.6.4.4
