From: cmetcalf@mellanox.com (Chris Metcalf)
Date: Tue, 5 Apr 2016 13:38:41 -0400
Subject: [PATCH v12 12/13] arm64: factor work_pending state machine to C
In-Reply-To: <1459877922-15512-1-git-send-email-cmetcalf@mellanox.com>
References: <1459877922-15512-1-git-send-email-cmetcalf@mellanox.com>
Message-ID: <1459877922-15512-13-git-send-email-cmetcalf@mellanox.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently ret_fast_syscall, work_pending, and ret_to_user form an ad-hoc
state machine that can be difficult to reason about due to duplicated
code and a large number of branch targets.

This patch factors the common logic out into the existing
do_notify_resume function, converting the code to C in the process,
making the code more legible.

This patch tries to closely mirror the existing behaviour while using
the usual C control flow primitives. As local_irq_{disable,enable} may
be instrumented, we balance exception entry (where we will almost most
likely enable IRQs) with a call to trace_hardirqs_on just before the
return to userspace.

Signed-off-by: Chris Metcalf <cmetcalf@mellanox.com>
---
 arch/arm64/kernel/entry.S  | 12 ++++--------
 arch/arm64/kernel/signal.c | 36 ++++++++++++++++++++++++++----------
 2 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 12e8d2bcb3f9..d70a9e44b7d6 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -674,18 +674,13 @@ ret_fast_syscall_trace:
  * Ok, we need to do extra processing, enter the slow path.
  */
 work_pending:
-	tbnz	x1, #TIF_NEED_RESCHED, work_resched
-	/* TIF_SIGPENDING, TIF_NOTIFY_RESUME or TIF_FOREIGN_FPSTATE case */
 	mov	x0, sp				// 'regs'
-	enable_irq				// enable interrupts for do_notify_resume()
 	bl	do_notify_resume
-	b	ret_to_user
-work_resched:
 #ifdef CONFIG_TRACE_IRQFLAGS
-	bl	trace_hardirqs_off		// the IRQs are off here, inform the tracing code
+	bl	trace_hardirqs_on		// enabled while in userspace
 #endif
-	bl	schedule
-
+	ldr	x1, [tsk, #TI_FLAGS]		// re-check for single-step
+	b	finish_ret_to_user
 /*
  * "slow" syscall return path.
  */
@@ -694,6 +689,7 @@ ret_to_user:
 	ldr	x1, [tsk, #TI_FLAGS]
 	and	x2, x1, #_TIF_WORK_MASK
 	cbnz	x2, work_pending
+finish_ret_to_user:
 	enable_step_tsk x1, x2
 	kernel_exit 0
 ENDPROC(ret_to_user)
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index a8eafdbc7cb8..404dd67080b9 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -402,15 +402,31 @@ static void do_signal(struct pt_regs *regs)
 asmlinkage void do_notify_resume(struct pt_regs *regs,
 				 unsigned int thread_flags)
 {
-	if (thread_flags & _TIF_SIGPENDING)
-		do_signal(regs);
-
-	if (thread_flags & _TIF_NOTIFY_RESUME) {
-		clear_thread_flag(TIF_NOTIFY_RESUME);
-		tracehook_notify_resume(regs);
-	}
-
-	if (thread_flags & _TIF_FOREIGN_FPSTATE)
-		fpsimd_restore_current_state();
+	/*
+	 * The assembly code enters us with IRQs off, but it hasn't
+	 * informed the tracing code of that for efficiency reasons.
+	 * Update the trace code with the current status.
+	 */
+	trace_hardirqs_off();
+	do {
+		if (thread_flags & _TIF_NEED_RESCHED) {
+			schedule();
+		} else {
+			local_irq_enable();
+
+			if (thread_flags & _TIF_SIGPENDING)
+				do_signal(regs);
+
+			if (thread_flags & _TIF_NOTIFY_RESUME) {
+				clear_thread_flag(TIF_NOTIFY_RESUME);
+				tracehook_notify_resume(regs);
+			}
+
+			if (thread_flags & _TIF_FOREIGN_FPSTATE)
+				fpsimd_restore_current_state();
+		}
 
+		local_irq_disable();
+		thread_flags = READ_ONCE(current_thread_info()->flags);
+	} while (thread_flags & _TIF_WORK_MASK);
 }
-- 
2.7.2
