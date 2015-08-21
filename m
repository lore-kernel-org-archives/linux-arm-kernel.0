From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 21 Aug 2015 14:48:25 +0100
Subject: [PATCH 3/4] ARM: entry: efficiency cleanups
In-Reply-To: <20150821134630.GW7557@n2100.arm.linux.org.uk>
References: <20150821134630.GW7557@n2100.arm.linux.org.uk>
Message-ID: <E1ZSmgD-00044a-FE@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make the "fast" syscall return path fast again.  The addition of IRQ
tracing and context tracking has made this path grossly inefficient.
We can do much better if these options are enabled if we save the
syscall return code on the stack - we then don't need to save a bunch
of registers around every single callout to C code.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/assembler.h   | 16 +++++++---
 arch/arm/include/asm/thread_info.h | 20 +++++--------
 arch/arm/kernel/entry-common.S     | 61 ++++++++++++++++++++++++++++----------
 arch/arm/kernel/signal.c           |  6 ++++
 4 files changed, 71 insertions(+), 32 deletions(-)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 742495eb5526..5a5504f90d5f 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -108,29 +108,37 @@
 	.endm
 #endif
 
-	.macro asm_trace_hardirqs_off
+	.macro asm_trace_hardirqs_off, save=1
 #if defined(CONFIG_TRACE_IRQFLAGS)
+	.if \save
 	stmdb   sp!, {r0-r3, ip, lr}
+	.endif
 	bl	trace_hardirqs_off
+	.if \save
 	ldmia	sp!, {r0-r3, ip, lr}
+	.endif
 #endif
 	.endm
 
-	.macro asm_trace_hardirqs_on, cond=al
+	.macro asm_trace_hardirqs_on, cond=al, save=1
 #if defined(CONFIG_TRACE_IRQFLAGS)
 	/*
 	 * actually the registers should be pushed and pop'd conditionally, but
 	 * after bl the flags are certainly clobbered
 	 */
+	.if \save
 	stmdb   sp!, {r0-r3, ip, lr}
+	.endif
 	bl\cond	trace_hardirqs_on
+	.if \save
 	ldmia	sp!, {r0-r3, ip, lr}
+	.endif
 #endif
 	.endm
 
-	.macro disable_irq
+	.macro disable_irq, save=1
 	disable_irq_notrace
-	asm_trace_hardirqs_off
+	asm_trace_hardirqs_off \save
 	.endm
 
 	.macro enable_irq
diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index bd32eded3e50..71e0ffcedf8e 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -136,22 +136,18 @@ extern int vfp_restore_user_hwstate(struct user_vfp __user *,
 
 /*
  * thread information flags:
- *  TIF_SYSCALL_TRACE	- syscall trace active
- *  TIF_SYSCAL_AUDIT	- syscall auditing active
- *  TIF_SIGPENDING	- signal pending
- *  TIF_NEED_RESCHED	- rescheduling necessary
- *  TIF_NOTIFY_RESUME	- callback before returning to user
  *  TIF_USEDFPU		- FPU was used by this task this quantum (SMP)
  *  TIF_POLLING_NRFLAG	- true if poll_idle() is polling TIF_NEED_RESCHED
  */
-#define TIF_SIGPENDING		0
-#define TIF_NEED_RESCHED	1
+#define TIF_SIGPENDING		0	/* signal pending */
+#define TIF_NEED_RESCHED	1	/* rescheduling necessary */
 #define TIF_NOTIFY_RESUME	2	/* callback before returning to user */
-#define TIF_UPROBE		7
-#define TIF_SYSCALL_TRACE	8
-#define TIF_SYSCALL_AUDIT	9
-#define TIF_SYSCALL_TRACEPOINT	10
-#define TIF_SECCOMP		11	/* seccomp syscall filtering active */
+#define TIF_UPROBE		3	/* breakpointed or singlestepping */
+#define TIF_SYSCALL_TRACE	4	/* syscall trace active */
+#define TIF_SYSCALL_AUDIT	5	/* syscall auditing active */
+#define TIF_SYSCALL_TRACEPOINT	6	/* syscall tracepoint instrumentation */
+#define TIF_SECCOMP		7	/* seccomp syscall filtering active */
+
 #define TIF_NOHZ		12	/* in adaptive nohz mode */
 #define TIF_USING_IWMMXT	17
 #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 92828a1dec80..dd3721d1185e 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -24,35 +24,55 @@
 
 
 	.align	5
+#if !(IS_ENABLED(CONFIG_TRACE_IRQFLAGS) || IS_ENABLED(CONFIG_CONTEXT_TRACKING))
 /*
- * This is the fast syscall return path.  We do as little as
- * possible here, and this includes saving r0 back into the SVC
- * stack.
+ * This is the fast syscall return path.  We do as little as possible here,
+ * such as avoiding writing r0 to the stack.  We only use this path if we
+ * have tracing and context tracking disabled - the overheads from those
+ * features make this path too inefficient.
  */
 ret_fast_syscall:
  UNWIND(.fnstart	)
  UNWIND(.cantunwind	)
-	disable_irq				@ disable interrupts
+	disable_irq_notrace			@ disable interrupts
 	ldr	r1, [tsk, #TI_FLAGS]		@ re-check for syscall tracing
-	tst	r1, #_TIF_SYSCALL_WORK
-	bne	__sys_trace_return
-	tst	r1, #_TIF_WORK_MASK
+	tst	r1, #_TIF_SYSCALL_WORK | _TIF_WORK_MASK
 	bne	fast_work_pending
-	asm_trace_hardirqs_on
 
 	/* perform architecture specific actions before user return */
 	arch_ret_to_user r1, lr
-	ct_user_enter
 
 	restore_user_regs fast = 1, offset = S_OFF
  UNWIND(.fnend		)
+ENDPROC(ret_fast_syscall)
 
-/*
- * Ok, we need to do extra processing, enter the slow path.
- */
+	/* Ok, we need to do extra processing, enter the slow path. */
 fast_work_pending:
 	str	r0, [sp, #S_R0+S_OFF]!		@ returned r0
-work_pending:
+	/* fall through to work_pending */
+#else
+/*
+ * The "replacement" ret_fast_syscall for when tracing or context tracking
+ * is enabled.  As we will need to call out to some C functions, we save
+ * r0 first to avoid needing to save registers around each C function call.
+ */
+ret_fast_syscall:
+ UNWIND(.fnstart	)
+ UNWIND(.cantunwind	)
+	str	r0, [sp, #S_R0 + S_OFF]!	@ save returned r0
+	disable_irq_notrace			@ disable interrupts
+	ldr	r1, [tsk, #TI_FLAGS]		@ re-check for syscall tracing
+	tst	r1, #_TIF_SYSCALL_WORK | _TIF_WORK_MASK
+	beq	no_work_pending
+ UNWIND(.fnend		)
+ENDPROC(ret_fast_syscall)
+
+	/* Slower path - fall through to work_pending */
+#endif
+
+	tst	r1, #_TIF_SYSCALL_WORK
+	bne	__sys_trace_return_nosave
+slow_work_pending:
 	mov	r0, sp				@ 'regs'
 	mov	r2, why				@ 'syscall'
 	bl	do_work_pending
@@ -64,16 +84,19 @@ work_pending:
 
 /*
  * "slow" syscall return path.  "why" tells us if this was a real syscall.
+ * IRQs may be enabled here, so always disable them.  Note that we use the
+ * "notrace" version to avoid calling into the tracing code unnecessarily.
+ * do_work_pending() will update this state if necessary.
  */
 ENTRY(ret_to_user)
 ret_slow_syscall:
-	disable_irq				@ disable interrupts
+	disable_irq_notrace			@ disable interrupts
 ENTRY(ret_to_user_from_irq)
 	ldr	r1, [tsk, #TI_FLAGS]
 	tst	r1, #_TIF_WORK_MASK
-	bne	work_pending
+	bne	slow_work_pending
 no_work_pending:
-	asm_trace_hardirqs_on
+	asm_trace_hardirqs_on save = 0
 
 	/* perform architecture specific actions before user return */
 	arch_ret_to_user r1, lr
@@ -251,6 +274,12 @@ __sys_trace_return:
 	bl	syscall_trace_exit
 	b	ret_slow_syscall
 
+__sys_trace_return_nosave:
+	asm_trace_hardirqs_off save=0
+	mov	r0, sp
+	bl	syscall_trace_exit
+	b	ret_slow_syscall
+
 	.align	5
 #ifdef CONFIG_ALIGNMENT_TRAP
 	.type	__cr_alignment, #object
diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index 423663e23791..b6cda06b455f 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -562,6 +562,12 @@ static int do_signal(struct pt_regs *regs, int syscall)
 asmlinkage int
 do_work_pending(struct pt_regs *regs, unsigned int thread_flags, int syscall)
 {
+	/*
+	 * The assembly code enters us with IRQs off, but it hasn't
+	 * informed the tracing code of that for efficiency reasons.
+	 * Update the trace code with the current status.
+	 */
+	trace_hardirqs_off();
 	do {
 		if (likely(thread_flags & _TIF_NEED_RESCHED)) {
 			schedule();
-- 
2.1.0
