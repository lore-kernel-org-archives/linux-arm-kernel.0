From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Fri, 13 May 2016 11:48:57 +0100
Subject: [PATCH 1/3] ARM: rename S_FRAME_SIZE to PT_REGS_SIZE
In-Reply-To: <20160513104802.GU19428@n2100.arm.linux.org.uk>
References: <20160513104802.GU19428@n2100.arm.linux.org.uk>
Message-ID: <E1b1AeO-0005DE-W5@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

S_FRAME_SIZE is no longer the size of the kernel stack frame, so this
name is misleading.  It is the size of the kernel pt_regs structure.
Name it so.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/include/asm/assembler.h |  4 ++--
 arch/arm/kernel/asm-offsets.c    |  2 +-
 arch/arm/kernel/entry-armv.S     | 12 ++++++------
 arch/arm/kernel/entry-common.S   |  2 +-
 arch/arm/kernel/entry-header.S   |  8 ++++----
 arch/arm/kernel/entry-v7m.S      |  2 +-
 6 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index b2bc8e11471d..60d9c5471eb6 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -480,13 +480,13 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
 	.macro	uaccess_save, tmp
 #ifdef CONFIG_CPU_SW_DOMAIN_PAN
 	mrc	p15, 0, \tmp, c3, c0, 0
-	str	\tmp, [sp, #S_FRAME_SIZE]
+	str	\tmp, [sp, #PT_REGS_SIZE]
 #endif
 	.endm
 
 	.macro	uaccess_restore
 #ifdef CONFIG_CPU_SW_DOMAIN_PAN
-	ldr	r0, [sp, #S_FRAME_SIZE]
+	ldr	r0, [sp, #PT_REGS_SIZE]
 	mcr	p15, 0, r0, c3, c0, 0
 #endif
 	.endm
diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index 27d05813ff09..2841c9980bcd 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -107,7 +107,7 @@ int main(void)
   DEFINE(S_PC,			offsetof(struct pt_regs, ARM_pc));
   DEFINE(S_PSR,			offsetof(struct pt_regs, ARM_cpsr));
   DEFINE(S_OLD_R0,		offsetof(struct pt_regs, ARM_ORIG_r0));
-  DEFINE(S_FRAME_SIZE,		sizeof(struct pt_regs));
+  DEFINE(PT_REGS_SIZE,		sizeof(struct pt_regs));
   BLANK();
 #ifdef CONFIG_CACHE_L2X0
   DEFINE(L2X0_R_PHY_BASE,	offsetof(struct l2x0_regs, phy_base));
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index e2550500486d..a6cb019d9920 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -92,7 +92,7 @@
  * Invalid mode handlers
  */
 	.macro	inv_entry, reason
-	sub	sp, sp, #S_FRAME_SIZE
+	sub	sp, sp, #PT_REGS_SIZE
  ARM(	stmib	sp, {r1 - lr}		)
  THUMB(	stmia	sp, {r0 - r12}		)
  THUMB(	str	sp, [sp, #S_SP]		)
@@ -152,7 +152,7 @@ ENDPROC(__und_invalid)
 	.macro	svc_entry, stack_hole=0, trace=1, uaccess=1
  UNWIND(.fnstart		)
  UNWIND(.save {r0 - pc}		)
-	sub	sp, sp, #(S_FRAME_SIZE + 8 + \stack_hole - 4)
+	sub	sp, sp, #(PT_REGS_SIZE + 8 + \stack_hole - 4)
 #ifdef CONFIG_THUMB2_KERNEL
  SPFIX(	str	r0, [sp]	)	@ temporarily saved
  SPFIX(	mov	r0, sp		)
@@ -167,7 +167,7 @@ ENDPROC(__und_invalid)
 	ldmia	r0, {r3 - r5}
 	add	r7, sp, #S_SP - 4	@ here for interlock avoidance
 	mov	r6, #-1			@  ""  ""      ""       ""
-	add	r2, sp, #(S_FRAME_SIZE + 8 + \stack_hole - 4)
+	add	r2, sp, #(PT_REGS_SIZE + 8 + \stack_hole - 4)
  SPFIX(	addeq	r2, r2, #4	)
 	str	r3, [sp, #-4]!		@ save the "real" r0 copied
 					@ from the exception stack
@@ -366,17 +366,17 @@ ENDPROC(__fiq_abt)
 /*
  * User mode handlers
  *
- * EABI note: sp_svc is always 64-bit aligned here, so should S_FRAME_SIZE
+ * EABI note: sp_svc is always 64-bit aligned here, so should PT_REGS_SIZE
  */
 
-#if defined(CONFIG_AEABI) && (__LINUX_ARM_ARCH__ >= 5) && (S_FRAME_SIZE & 7)
+#if defined(CONFIG_AEABI) && (__LINUX_ARM_ARCH__ >= 5) && (PT_REGS_SIZE & 7)
 #error "sizeof(struct pt_regs) must be a multiple of 8"
 #endif
 
 	.macro	usr_entry, trace=1, uaccess=1
  UNWIND(.fnstart	)
  UNWIND(.cantunwind	)	@ don't unwind the user space
-	sub	sp, sp, #S_FRAME_SIZE
+	sub	sp, sp, #PT_REGS_SIZE
  ARM(	stmib	sp, {r1 - r12}	)
  THUMB(	stmia	sp, {r0 - r12}	)
 
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 30a7228eaceb..10c3283d6c19 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -145,7 +145,7 @@ ENTRY(vector_swi)
 #ifdef CONFIG_CPU_V7M
 	v7m_exception_entry
 #else
-	sub	sp, sp, #S_FRAME_SIZE
+	sub	sp, sp, #PT_REGS_SIZE
 	stmia	sp, {r0 - r12}			@ Calling r0 - r12
  ARM(	add	r8, sp, #S_PC		)
  ARM(	stmdb	r8, {sp, lr}^		)	@ Calling sp, lr
diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index 0d22ad206d52..5e1d029147cb 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -90,7 +90,7 @@
 	@ Linux expects to have irqs off. Do it here before taking stack space
 	cpsid	i
 
-	sub	sp, #S_FRAME_SIZE-S_IP
+	sub	sp, #PT_REGS_SIZE-S_IP
 	stmdb	sp!, {r0-r11}
 
 	@ load saved r12, lr, return address and xPSR.
@@ -160,7 +160,7 @@
 	ldmia	sp!, {r0-r11}
 
 	@ restore main sp
-	add	sp, sp, #S_FRAME_SIZE-S_IP
+	add	sp, sp, #PT_REGS_SIZE-S_IP
 
 	cpsie	i
 	bx	lr
@@ -307,7 +307,7 @@
 	.endif
 	mov	r0, r0				@ ARMv5T and earlier require a nop
 						@ after ldm {}^
-	add	sp, sp, #\offset + S_FRAME_SIZE
+	add	sp, sp, #\offset + PT_REGS_SIZE
 	movs	pc, lr				@ return & move spsr_svc into cpsr
 #elif defined(CONFIG_CPU_V7M)
 	@ V7M restore.
@@ -334,7 +334,7 @@
 	.else
 	ldmdb	sp, {r0 - r12}			@ get calling r0 - r12
 	.endif
-	add	sp, sp, #S_FRAME_SIZE - S_SP
+	add	sp, sp, #PT_REGS_SIZE - S_SP
 	movs	pc, lr				@ return & move spsr_svc into cpsr
 #endif	/* !CONFIG_THUMB2_KERNEL */
 	.endm
diff --git a/arch/arm/kernel/entry-v7m.S b/arch/arm/kernel/entry-v7m.S
index 907534f97053..abcf47848525 100644
--- a/arch/arm/kernel/entry-v7m.S
+++ b/arch/arm/kernel/entry-v7m.S
@@ -73,7 +73,7 @@ __irq_entry:
 	@ correctness they don't need to be restored. So only r8-r11 must be
 	@ restored here. The easiest way to do so is to restore r0-r7, too.
 	ldmia	sp!, {r0-r11}
-	add	sp, #S_FRAME_SIZE-S_IP
+	add	sp, #PT_REGS_SIZE-S_IP
 	cpsie	i
 	bx	lr
 ENDPROC(__irq_entry)
-- 
2.1.0
