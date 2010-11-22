From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 22 Nov 2010 18:13:51 +0000
Subject: [PATCH] ARM: Allow SMP_ON_UP to work with Thumb-2 kernels.
Message-ID: <1290449631-29100-1-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  * __fixup_smp_on_up has been modified with support for the THUMB2_KERNEL
	case.  For THUMB2_KERNEL only, fixups are split into halfwords in
	case of misalignment, since we can't rely on unaligned accesses
	working before turning the MMU on.

	No attempt is made to optimise the aligned case, since the number
	of fixups is typically small, and it seems best to keep the code
	as simple as possible.

  * Add an assembly-time sanity-check to ALT_UP() to ensure that the
	content really is the right size (4 bytes).

	(No check is done for ALT_SMP().  Possibly, this could be fixed
	by splitting the two uses ot ALT_SMP() (ALT_SMP...SMP_UP versus
	ALT_SMP...SMP_UP_B) into two macros.  In the first case,
	ALT_SMP needs to expand to >= 4 bytes, not == 4.)

  * A "mode" parameter has been added to smp_dmb:

	smp_dmp arm	@ assumes 4-byte instructions (for ARM code, e.g. kuser)
	smp_dmp		@ uses W() to ensure 4-byte instructions for ALT_SMP()

	This avoids assembly failures due to use of W() inside smp_dmb,
	when assembling pure-ARM code in the vectors page.

	There might be a better way to achieve this.

  * Kconfig: make SMP_ON_UP depend on (!THUMB2_KERNEL || !BIG_ENDIAN)
	i.e., THUMB2_KERNEL is now supported, but only if !BIG_ENDIAN
	(The fixup code for Thumb-2 currently assumes little-endian order.)

Applies to 2.6.37-rc3

Tested using a single generic realview kernel on:
	ARM RealView PB-A8
	ARM RealView PBX-A9 (SMP)

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/Kconfig                 |    2 +-
 arch/arm/include/asm/assembler.h |   22 +++++++++++++++++++---
 arch/arm/include/asm/smp_mpidr.h |    2 +-
 arch/arm/kernel/entry-armv.S     |    4 ++--
 arch/arm/kernel/head.S           |   10 +++++++---
 5 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index db524e7..cd2f644 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1229,7 +1229,7 @@ config SMP
 config SMP_ON_UP
 	bool "Allow booting SMP kernel on uniprocessor systems (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
-	depends on SMP && !XIP && !THUMB2_KERNEL
+	depends on SMP && !XIP && (!THUMB2_KERNEL || !CPU_BIG_ENDIAN)
 	default y
 	help
 	  SMP kernels contain instructions which fail on non-SMP processors.
diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 062b58c..cb5eed4 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -157,16 +157,24 @@
 #ifdef CONFIG_SMP
 #define ALT_SMP(instr...)					\
 9998:	instr
+/*
+ * Note: if you get assembler errors from ALT_UP() when building with
+ * CONFIG_THUMB2_KERNEL, you almost certainly need to use
+ * ALT_SMP( W(instr) ... )
+ */
 #define ALT_UP(instr...)					\
 	.pushsection ".alt.smp.init", "a"			;\
 	.long	9998b						;\
-	instr							;\
+9997:	instr							;\
+	.if . - 9997b != 4					;\
+		.error "ALT_UP() content must assemble to exactly 4 bytes";\
+	.endif							;\
 	.popsection
 #define ALT_UP_B(label)					\
 	.equ	up_b_offset, label - 9998b			;\
 	.pushsection ".alt.smp.init", "a"			;\
 	.long	9998b						;\
-	b	. + up_b_offset					;\
+	W(b)	. + up_b_offset					;\
 	.popsection
 #else
 #define ALT_SMP(instr...)
@@ -177,16 +185,24 @@
 /*
  * SMP data memory barrier
  */
-	.macro	smp_dmb
+	.macro	smp_dmb mode
 #ifdef CONFIG_SMP
 #if __LINUX_ARM_ARCH__ >= 7
+	.ifeqs "\mode","arm"
 	ALT_SMP(dmb)
+	.else
+	ALT_SMP(W(dmb))
+	.endif
 #elif __LINUX_ARM_ARCH__ == 6
 	ALT_SMP(mcr	p15, 0, r0, c7, c10, 5)	@ dmb
 #else
 #error Incompatible SMP platform
 #endif
+	.ifeqs "\mode","arm"
 	ALT_UP(nop)
+	.else
+	ALT_UP(W(nop))
+	.endif
 #endif
 	.endm
 
diff --git a/arch/arm/include/asm/smp_mpidr.h b/arch/arm/include/asm/smp_mpidr.h
index 6a9307d..09c9add 100644
--- a/arch/arm/include/asm/smp_mpidr.h
+++ b/arch/arm/include/asm/smp_mpidr.h
@@ -8,7 +8,7 @@
 			"1:	mrc p15, 0, %0, c0, c0, 5\n"		\
 			"	.pushsection \".alt.smp.init\", \"a\"\n"\
 			"	.long	1b\n"				\
-			"	mov	%0, #0\n"			\
+			"	W(mov)	%0, #0\n"			\
 			"	.popsection"				\
 			: "=r" (cpunum));				\
 		cpunum &= 0x0F;						\
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index c09e357..7a8f70d 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -842,7 +842,7 @@ __kuser_helper_start:
  */
 
 __kuser_memory_barrier:				@ 0xffff0fa0
-	smp_dmb
+	smp_dmb	arm
 	usr_ret	lr
 
 	.align	5
@@ -959,7 +959,7 @@ kuser_cmpxchg_fixup:
 
 #else
 
-	smp_dmb
+	smp_dmb	arm
 1:	ldrex	r3, [r2]
 	subs	r3, r3, r0
 	strexeq	r3, r1, [r2]
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index dd6b369..064fb63 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -407,10 +407,14 @@ __fixup_smp_on_up:
 	add	r6, r6, r3
 	add	r7, r7, r3
 2:	cmp	r6, r7
+	movhs	pc, lr
 	ldmia	r6!, {r0, r4}
-	strlo	r4, [r0, r3]
-	blo	2b
-	mov	pc, lr
+ ARM(	str	r4, [r0, r3]	)
+ THUMB(	add	r0, r0, r3	)
+ THUMB(	strh	r4, [r0], #2	)	@ For Thumb-2, store as two halfwords
+ THUMB(	mov	r4, r4, lsr #16	)	@ to be robust against misaligned r3.
+ THUMB(	strh	r4, [r0]	)	@ NOTE: currently assumes little-endian.
+	b	2b
 ENDPROC(__fixup_smp)
 
 1:	.word	.
-- 
1.7.1
