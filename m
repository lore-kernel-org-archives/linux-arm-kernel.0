From: stefan@agner.ch (Stefan Agner)
Date: Sat, 23 May 2015 01:25:48 +0200
Subject: [PATCH v2] ARM: nommu: avoid deprecated source register on mov
Message-ID: <1432337148-9894-1-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In Thumb2 mode, the stack register r13 is deprecated if the
destination register is the program counter (r15). Similar to
head.S, head-nommu.S uses r13 to store the return address used
after configuring the CPU's CP15 register. However, since we do
not enable a MMU, there will be no address switch and it is
possible to use branch with link instruction to call
__after_proc_init.

Avoid using r13 completely by using bl to call __after_proc_init
and get rid of __secondary_switched.

Beside removing unnecessary complexity, this also fixes a
compiler warning when compiling a !MMU kernel:
Warning: Use of r13 as a source register is deprecated when r15
is the destination register.

Suggested-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
Changes in v2:
- Load r7 outside CONFIG_ARM_MPU since its used outside later on

 arch/arm/kernel/head-nommu.S | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
index c966016..9b8c5a1 100644
--- a/arch/arm/kernel/head-nommu.S
+++ b/arch/arm/kernel/head-nommu.S
@@ -77,13 +77,13 @@ ENTRY(stext)
 	orr	r6, r6, #(1 << MPU_RSR_EN)	@ Set region enabled bit
 	bl	__setup_mpu
 #endif
-	ldr	r13, =__mmap_switched		@ address to jump to after
-						@ initialising sctlr
+
 	badr	lr, 1f				@ return (PIC) address
 	ldr	r12, [r10, #PROCINFO_INITFUNC]
 	add	r12, r12, r10
 	ret	r12
- 1:	b	__after_proc_init
+1:	bl	__after_proc_init
+	b	__mmap_switched
 ENDPROC(stext)
 
 #ifdef CONFIG_SMP
@@ -106,8 +106,7 @@ ENTRY(secondary_startup)
 	movs	r10, r5				@ invalid processor?
 	beq	__error_p			@ yes, error 'p'
 
-	adr	r4, __secondary_data
-	ldmia	r4, {r7, r12}
+	ldr	r7, __secondary_data
 
 #ifdef CONFIG_ARM_MPU
 	/* Use MPU region info supplied by __cpu_up */
@@ -115,23 +114,19 @@ ENTRY(secondary_startup)
 	bl      __setup_mpu			@ Initialize the MPU
 #endif
 
-	badr	lr, __after_proc_init		@ return address
-	mov	r13, r12			@ __secondary_switched address
+	badr	lr, 1f				@ return (PIC) address
 	ldr	r12, [r10, #PROCINFO_INITFUNC]
 	add	r12, r12, r10
 	ret	r12
-ENDPROC(secondary_startup)
-
-ENTRY(__secondary_switched)
+1:	bl	__after_proc_init
 	ldr	sp, [r7, #12]			@ set up the stack pointer
 	mov	fp, #0
 	b	secondary_start_kernel
-ENDPROC(__secondary_switched)
+ENDPROC(secondary_startup)
 
 	.type	__secondary_data, %object
 __secondary_data:
 	.long	secondary_data
-	.long	__secondary_switched
 #endif /* CONFIG_SMP */
 
 /*
@@ -164,7 +159,7 @@ __after_proc_init:
 #endif
 	mcr	p15, 0, r0, c1, c0, 0		@ write control reg
 #endif /* CONFIG_CPU_CP15 */
-	ret	r13
+	ret	lr
 ENDPROC(__after_proc_init)
 	.ltorg
 
-- 
2.4.1
