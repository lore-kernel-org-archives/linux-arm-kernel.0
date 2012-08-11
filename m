From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 11 Aug 2012 12:04:33 +0100
Subject: [PATCH 3/7] ARM: zImage/virt: hyp mode entry support for the zImage
 loader
In-Reply-To: <1344683077-12841-1-git-send-email-marc.zyngier@arm.com>
References: <1344683077-12841-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1344683077-12841-4-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dave Martin <dave.martin@linaro.org>

The zImage loader needs to turn on the MMU in order to take
advantage of caching while decompressing the zImage.  Running this
in hyp mode would require the LPAE pagetable format to be
supported; to avoid this complexity, this patch switches out of hyp
mode, and returns back to hyp mode just before booting the kernel.

This implementation assumes that the Hyp mode view of memory and the
PL1 view of memory are coherent, providing that the MMU and caches
are off in both, as required by the boot protocol.  The zImage
decompression code must drain the write buffer on completion anyway, and
entry into Hyp mode should flush any prefetch buffer, avoiding hazards
associated with local write buffers and the pipeline.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/boot/compressed/.gitignore |    1 +
 arch/arm/boot/compressed/Makefile   |    9 ++++-
 arch/arm/boot/compressed/head.S     |   71 +++++++++++++++++++++++++++++++---
 arch/arm/kernel/hyp-stub.S          |   18 +++++++++
 4 files changed, 91 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/compressed/.gitignore b/arch/arm/boot/compressed/.gitignore
index d0d441c..f79a08e 100644
--- a/arch/arm/boot/compressed/.gitignore
+++ b/arch/arm/boot/compressed/.gitignore
@@ -1,6 +1,7 @@
 ashldi3.S
 font.c
 lib1funcs.S
+hyp-stub.S
 piggy.gzip
 piggy.lzo
 piggy.lzma
diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index bb26756..a517153 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -30,6 +30,10 @@ FONTC	= $(srctree)/drivers/video/console/font_acorn_8x8.c
 OBJS		+= string.o
 CFLAGS_string.o	:= -Os
 
+ifeq ($(CONFIG_ARM_VIRT_EXT),y)
+OBJS		+= hyp-stub.o
+endif
+
 #
 # Architecture dependencies
 #
@@ -126,7 +130,7 @@ KBUILD_CFLAGS = $(subst -pg, , $(ORIG_CFLAGS))
 endif
 
 ccflags-y := -fpic -fno-builtin -I$(obj)
-asflags-y := -Wa,-march=all
+asflags-y := -Wa,-march=all -DZIMAGE
 
 # Supply kernel BSS size to the decompressor via a linker symbol.
 KBSS_SZ = $(shell $(CROSS_COMPILE)size $(obj)/../../../../vmlinux | \
@@ -198,3 +202,6 @@ $(obj)/font.c: $(FONTC)
 
 $(obj)/vmlinux.lds: $(obj)/vmlinux.lds.in arch/arm/boot/Makefile $(KCONFIG_CONFIG)
 	@sed "$(SEDFLAGS)" < $< > $@
+
+$(obj)/hyp-stub.S: $(srctree)/arch/$(SRCARCH)/kernel/hyp-stub.S
+	$(call cmd,shipped)
diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index b8c64b8..0749a61 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -9,6 +9,7 @@
  * published by the Free Software Foundation.
  */
 #include <linux/linkage.h>
+#include <asm/assembler.h>
 
 /*
  * Debugging stuff
@@ -132,7 +133,12 @@ start:
 		.word	start			@ absolute load/run zImage address
 		.word	_edata			@ zImage end address
  THUMB(		.thumb			)
-1:		mov	r7, r1			@ save architecture ID
+1:
+		mrs	r9, cpsr
+#ifdef CONFIG_ARM_VIRT_EXT
+		bl	__hyp_stub_install	@ get into SVC mode, reversibly
+#endif
+		mov	r7, r1			@ save architecture ID
 		mov	r8, r2			@ save atags pointer
 
 #ifndef __ARM_ARCH_2__
@@ -148,9 +154,9 @@ start:
  ARM(		swi	0x123456	)	@ angel_SWI_ARM
  THUMB(		svc	0xab		)	@ angel_SWI_THUMB
 not_angel:
-		mrs	r2, cpsr		@ turn off interrupts to
-		orr	r2, r2, #0xc0		@ prevent angel from running
-		msr	cpsr_c, r2
+		safe_svcmode_maskall r0
+		msr	spsr_cxsf, r9		@ Save the CPU boot mode in
+						@ SPSR
 #else
 		teqp	pc, #0x0c000003		@ turn off interrupts
 #endif
@@ -350,6 +356,20 @@ dtb_check_done:
 		adr	r5, restart
 		bic	r5, r5, #31
 
+/* Relocate the hyp vector base if necessary */
+#ifdef CONFIG_ARM_VIRT_EXT
+		mrs	r0, spsr
+		and	r0, r0, #MODE_MASK
+		cmp	r0, #HYP_MODE
+		bne	1f
+
+		bl	__hyp_get_vectors
+		sub	r0, r0, r5
+		add	r0, r0, r10
+		bl	__hyp_set_vectors
+1:
+#endif
+
 		sub	r9, r6, r5		@ size to copy
 		add	r9, r9, #31		@ rounded up to a multiple
 		bic	r9, r9, #31		@ ... of 32 bytes
@@ -458,11 +478,29 @@ not_relocated:	mov	r0, #0
 		bl	decompress_kernel
 		bl	cache_clean_flush
 		bl	cache_off
-		mov	r0, #0			@ must be zero
 		mov	r1, r7			@ restore architecture number
 		mov	r2, r8			@ restore atags pointer
- ARM(		mov	pc, r4	)		@ call kernel
- THUMB(		bx	r4	)		@ entry point is always ARM
+
+#ifdef CONFIG_ARM_VIRT_EXT
+		mrs	r0, spsr		@ Get saved CPU boot mode
+		and	r0, r0, #MODE_MASK
+		cmp	r0, #HYP_MODE		@ if not booted in HYP mode...
+		bne	__enter_kernel		@ boot kernel directly
+
+		adr	r12, .L__hyp_reentry_vectors_offset
+		ldr	r0, [r12]
+		add	r0, r0, r12
+
+		bl	__hyp_set_vectors
+		__HVC(0)			@ otherwise bounce to hyp mode
+
+		b	.			@ should never be reached
+
+		.align	2
+.L__hyp_reentry_vectors_offset:	.long	__hyp_reentry_vectors - .
+#else
+		b	__enter_kernel
+#endif
 
 		.align	2
 		.type	LC0, #object
@@ -1191,6 +1229,25 @@ memdump:	mov	r12, r0
 #endif
 
 		.ltorg
+
+#ifdef CONFIG_ARM_VIRT_EXT
+.align 5
+__hyp_reentry_vectors:
+		W(b)	.			@ reset
+		W(b)	.			@ undef
+		W(b)	.			@ svc
+		W(b)	.			@ pabort
+		W(b)	.			@ dabort
+		W(b)	__enter_kernel		@ hyp
+		W(b)	.			@ irq
+		W(b)	.			@ fiq
+#endif /* CONFIG_ARM_VIRT_EXT */
+
+__enter_kernel:
+		mov	r0, #0			@ must be 0
+ ARM(		mov	pc, r4	)		@ call kernel
+ THUMB(		bx	r4	)		@ entry point is always ARM
+
 reloc_code_end:
 
 		.align
diff --git a/arch/arm/kernel/hyp-stub.S b/arch/arm/kernel/hyp-stub.S
index 2d529d6..4ff46fa 100644
--- a/arch/arm/kernel/hyp-stub.S
+++ b/arch/arm/kernel/hyp-stub.S
@@ -21,6 +21,7 @@
 #include <asm/assembler.h>
 #include <asm/virt.h>
 
+#ifndef ZIMAGE
 /*
  * For the kernel proper, we need to find out the CPU boot mode long after
  * boot, so we need to store it in a writable variable.
@@ -59,6 +60,21 @@ ENTRY(__boot_cpu_mode)
 	strne	r7, [r5, r6]		@ record what happened and give up
 	.endm
 
+#else	/* ZIMAGE */
+
+	.macro	store_primary_cpu_mode	reg1:req, reg2:req, reg3:req
+	.endm
+
+/*
+ * The zImage loader only runs on one CPU, so we don't bother with mult-CPU
+ * consistency checking:
+ */
+	.macro	compare_cpu_mode_with_primary mode, reg1, reg2, reg3
+	cmp	\mode, \mode
+	.endm
+
+#endif /* ZIMAGE */
+
 /*
  * Hypervisor stub installation functions.
  *
@@ -169,9 +185,11 @@ ENTRY(__hyp_set_vectors)
 	bx	lr
 ENDPROC(__hyp_set_vectors)
 
+#ifndef ZIMAGE
 .align 2
 .L__boot_cpu_mode_offset:
 	.long	__boot_cpu_mode - .
+#endif
 
 .align 5
 __hyp_stub_vectors:
-- 
1.7.8.6
