From: tixy@yxit.co.uk (Tixy)
Date: Sat,  9 Jul 2011 11:56:56 +0100
Subject: [PATCH 09/51] ARM: kprobes: Make kprobes framework work on Thumb-2
	kernels
In-Reply-To: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
References: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310209058-20980-10-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

Fix up kprobes framework so that it builds and correctly interworks on
Thumb-2 kernels.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes.c |   37 +++++++++++++++++++++++++++++++++++--
 1 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/kprobes.c b/arch/arm/kernel/kprobes.c
index 3ba5f8d..0e47d3d 100644
--- a/arch/arm/kernel/kprobes.c
+++ b/arch/arm/kernel/kprobes.c
@@ -302,7 +302,11 @@ void __naked __kprobes kretprobe_trampoline(void)
 		"bl	trampoline_handler	\n\t"
 		"mov	lr, r0			\n\t"
 		"ldmia	sp!, {r0 - r11}		\n\t"
+#ifdef CONFIG_THUMB2_KERNEL
+		"bx	lr			\n\t"
+#else
 		"mov	pc, lr			\n\t"
+#endif
 		: : : "memory");
 }
 
@@ -380,11 +384,22 @@ int __kprobes setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
 	struct jprobe *jp = container_of(p, struct jprobe, kp);
 	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
 	long sp_addr = regs->ARM_sp;
+	long cpsr;
 
 	kcb->jprobe_saved_regs = *regs;
 	memcpy(kcb->jprobes_stack, (void *)sp_addr, MIN_STACK_SIZE(sp_addr));
 	regs->ARM_pc = (long)jp->entry;
-	regs->ARM_cpsr |= PSR_I_BIT;
+
+	cpsr = regs->ARM_cpsr | PSR_I_BIT;
+#ifdef CONFIG_THUMB2_KERNEL
+	/* Set correct Thumb state in cpsr */
+	if (regs->ARM_pc & 1)
+		cpsr |= PSR_T_BIT;
+	else
+		cpsr &= ~PSR_T_BIT;
+#endif
+	regs->ARM_cpsr = cpsr;
+
 	preempt_disable();
 	return 1;
 }
@@ -406,7 +421,12 @@ void __kprobes jprobe_return(void)
 		 * This is to prevent any simulated instruction from writing
 		 * over the regs when they are accessing the stack.
 		 */
+#ifdef CONFIG_THUMB2_KERNEL
+		"sub    r0, %0, %1		\n\t"
+		"mov    sp, r0			\n\t"
+#else
 		"sub    sp, %0, %1		\n\t"
+#endif
 		"ldr    r0, ="__stringify(JPROBE_MAGIC_ADDR)"\n\t"
 		"str    %0, [sp, %2]		\n\t"
 		"str    r0, [sp, %3]		\n\t"
@@ -417,15 +437,28 @@ void __kprobes jprobe_return(void)
 		 * Return to the context saved by setjmp_pre_handler
 		 * and restored by longjmp_break_handler.
 		 */
+#ifdef CONFIG_THUMB2_KERNEL
+		"ldr	lr, [sp, %2]		\n\t" /* lr = saved sp */
+		"ldrd	r0, r1, [sp, %5]	\n\t" /* r0,r1 = saved lr,pc */
+		"ldr	r2, [sp, %4]		\n\t" /* r2 = saved psr */
+		"stmdb	lr!, {r0, r1, r2}	\n\t" /* push saved lr and */
+						      /* rfe context */
+		"ldmia	sp, {r0 - r12}		\n\t"
+		"mov	sp, lr			\n\t"
+		"ldr	lr, [sp], #4		\n\t"
+		"rfeia	sp!			\n\t"
+#else
 		"ldr	r0, [sp, %4]		\n\t"
 		"msr	cpsr_cxsf, r0		\n\t"
 		"ldmia	sp, {r0 - pc}		\n\t"
+#endif
 		:
 		: "r" (kcb->jprobe_saved_regs.ARM_sp),
 		  "I" (sizeof(struct pt_regs) * 2),
 		  "J" (offsetof(struct pt_regs, ARM_sp)),
 		  "J" (offsetof(struct pt_regs, ARM_pc)),
-		  "J" (offsetof(struct pt_regs, ARM_cpsr))
+		  "J" (offsetof(struct pt_regs, ARM_cpsr)),
+		  "J" (offsetof(struct pt_regs, ARM_lr))
 		: "memory", "cc");
 }
 
-- 
1.7.2.5
