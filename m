From: manabian@gmail.com (Joachim Eastwood)
Date: Sat, 27 Sep 2014 13:25:49 +0200
Subject: =?UTF-8?q?=5BPATCH=20v4=5D=20ARM=3A=20zImage=3A=20add=20support=20for=20ARMv7-M?=
In-Reply-To: <1411057343-20861-1-git-send-email-manabian@gmail.com>
References: <1411057343-20861-1-git-send-email-manabian@gmail.com>
Message-ID: <1411817149-5135-1-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch makes it possible to enter zImage in Thumb mode for ARMv7M
(Cortex-M) CPUs that does not support ARM mode. The kernel entry is
also made in Thumb mode.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
Hi,

Updated patch with comments from Uwe Kleine-K?nig.

Changes
v4: Preserve r1/r2. Add comment about class A/R.
v3: Use defines for ARMv7M CPU registers.
v2: Introduce AR_CLASS/M_CLASS macros. This reduces the amount
    of ifdefs needed in compressed/head.S.

Successfully tested on NXP LPC4357 (Cortex-M4).

regards,
Joachim Eastwood

 arch/arm/boot/compressed/head.S | 28 ++++++++++++++++++++++------
 arch/arm/include/asm/unified.h  |  8 ++++++++
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 413fd94b5301..0afcbb1e1d7d 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -10,8 +10,11 @@
  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/v7m.h>
+
+ AR_CLASS(	.arch	armv7-a	)
+ M_CLASS(	.arch	armv7-m	)
 
-	.arch	armv7-a
 /*
  * Debugging stuff
  *
@@ -114,7 +117,12 @@
  * sort out different calling conventions
  */
 		.align
-		.arm				@ Always enter in ARM state
+		/*
+		 * Always enter in ARM state for CPUs that support the ARM ISA.
+		 * As of today (2014) that's exactly the members of the A and R
+		 * classes.
+		 */
+ AR_CLASS(	.arm	)
 start:
 		.type	start,#function
 		.rept	7
@@ -132,14 +140,15 @@ start:
 
  THUMB(		.thumb			)
 1:
- ARM_BE8(	setend	be )			@ go BE8 if compiled for BE8
-		mrs	r9, cpsr
+ ARM_BE8(	setend	be		)	@ go BE8 if compiled for BE8
+ AR_CLASS(	mrs	r9, cpsr	)
 #ifdef CONFIG_ARM_VIRT_EXT
 		bl	__hyp_stub_install	@ get into SVC mode, reversibly
 #endif
 		mov	r7, r1			@ save architecture ID
 		mov	r8, r2			@ save atags pointer
 
+#ifndef CONFIG_CPU_V7M
 		/*
 		 * Booting from Angel - need to enter SVC mode and disable
 		 * FIQs/IRQs (numeric definitions from angel arm.h source).
@@ -155,6 +164,7 @@ not_angel:
 		safe_svcmode_maskall r0
 		msr	spsr_cxsf, r9		@ Save the CPU boot mode in
 						@ SPSR
+#endif
 		/*
 		 * Note that some cache flushing and other stuff may
 		 * be needed here - is there an Angel SWI call for this?
@@ -790,6 +800,9 @@ __common_mmu_cache_on:
 call_cache_fn:	adr	r12, proc_types
 #ifdef CONFIG_CPU_CP15
 		mrc	p15, 0, r9, c0, c0	@ get processor ID
+#elif defined(CONFIG_CPU_V7M)
+		ldr	r9, =BASEADDR_V7M_SCB
+		ldr	r9, [r9, V7M_SCB_CPUID]
 #else
 		ldr	r9, =CONFIG_PROCESSOR_ID
 #endif
@@ -945,11 +958,13 @@ proc_types:
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
@@ -1277,8 +1292,9 @@ __hyp_reentry_vectors:
 
 __enter_kernel:
 		mov	r0, #0			@ must be 0
- ARM(		mov	pc, r4	)		@ call kernel
- THUMB(		bx	r4	)		@ entry point is always ARM
+ ARM(		mov	pc, r4		)	@ call kernel
+ M_CLASS(	add	r4, r4, #1	)	@ enter in Thumb mode for M class
+ THUMB(		bx	r4		)	@ entry point is always ARM for A/R classes
 
 reloc_code_end:
 
diff --git a/arch/arm/include/asm/unified.h b/arch/arm/include/asm/unified.h
index b88beaba6b4a..200f9a7cd623 100644
--- a/arch/arm/include/asm/unified.h
+++ b/arch/arm/include/asm/unified.h
@@ -24,6 +24,14 @@
 	.syntax unified
 #endif
 
+#ifdef CONFIG_CPU_V7M
+#define AR_CLASS(x...)
+#define M_CLASS(x...)	x
+#else
+#define AR_CLASS(x...)	x
+#define M_CLASS(x...)
+#endif
+
 #ifdef CONFIG_THUMB2_KERNEL
 
 #if __GNUC__ < 4
-- 
1.8.0
