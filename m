From: manabian@gmail.com (Joachim Eastwood)
Date: Thu, 18 Sep 2014 18:22:22 +0200
Subject: [PATCH] ARM: zImage: add support for ARMv7-M
Message-ID: <1411057343-20861-1-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch makes it possible to enter zImage in Thumb mode for ARMv7M
(Cortex-M) CPUs that does not support ARM mode. The kernel entry is
also made in Thumb mode.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
Hi,

This patch is loosely based on the Cortex-M old support patch by
Catalin Marinas. A lot has happend to compressed/head.S since 2010
but the general placement of some of ifdefs are the same.

Successfully tested on NXP LPC4357 (Cortex-M4).

I just noticed that there is CONFIG_CPU_THUMBONLY config symbol.
Would it be better to use that in this file?

regards
Joachim Eastwood

 arch/arm/boot/compressed/head.S | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 413fd94b5301..6ffccb5283e6 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -11,7 +11,12 @@
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 
+#ifdef CONFIG_CPU_V7M
+	.arch	armv7-m
+#else
 	.arch	armv7-a
+#endif
+
 /*
  * Debugging stuff
  *
@@ -114,7 +119,9 @@
  * sort out different calling conventions
  */
 		.align
-		.arm				@ Always enter in ARM state
+#ifndef CONFIG_CPU_V7M
+		.arm			@ Always enter in ARM state for non ARMv7M CPUs
+#endif
 start:
 		.type	start,#function
 		.rept	7
@@ -133,6 +140,7 @@ start:
  THUMB(		.thumb			)
 1:
  ARM_BE8(	setend	be )			@ go BE8 if compiled for BE8
+#ifndef CONFIG_CPU_V7M
 		mrs	r9, cpsr
 #ifdef CONFIG_ARM_VIRT_EXT
 		bl	__hyp_stub_install	@ get into SVC mode, reversibly
@@ -155,6 +163,7 @@ not_angel:
 		safe_svcmode_maskall r0
 		msr	spsr_cxsf, r9		@ Save the CPU boot mode in
 						@ SPSR
+#endif
 		/*
 		 * Note that some cache flushing and other stuff may
 		 * be needed here - is there an Angel SWI call for this?
@@ -790,6 +799,9 @@ __common_mmu_cache_on:
 call_cache_fn:	adr	r12, proc_types
 #ifdef CONFIG_CPU_CP15
 		mrc	p15, 0, r9, c0, c0	@ get processor ID
+#elif defined(CONFIG_CPU_V7M)
+		ldr	r9, =0xe000ed00		@ CPUID register address
+		ldr	r9, [r9]
 #else
 		ldr	r9, =CONFIG_PROCESSOR_ID
 #endif
@@ -945,11 +957,13 @@ proc_types:
 		W(b)	__armv4_mmu_cache_off
 		W(b)	__armv6_mmu_cache_flush
 
+#ifndef CONFIG_CPU_V7M
 		.word	0x000f0000		@ new CPU Id
 		.word	0x000f0000
 		W(b)	__armv7_mmu_cache_on
 		W(b)	__armv7_mmu_cache_off
 		W(b)	__armv7_mmu_cache_flush
+#endif
 
 		.word	0			@ unrecognised type
 		.word	0
@@ -1278,7 +1292,10 @@ __hyp_reentry_vectors:
 __enter_kernel:
 		mov	r0, #0			@ must be 0
  ARM(		mov	pc, r4	)		@ call kernel
- THUMB(		bx	r4	)		@ entry point is always ARM
+#ifdef CONFIG_CPU_V7M
+		add	r4, r4, #1		@ enter in Thumb mode for ARMv7M
+#endif
+ THUMB(		bx	r4	)		@ entry point is always ARM for non ARMv7M CPUs
 
 reloc_code_end:
 
-- 
1.8.0
