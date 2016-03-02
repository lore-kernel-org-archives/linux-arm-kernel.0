From: cmetcalf@ezchip.com (Chris Metcalf)
Date: Wed, 2 Mar 2016 15:09:35 -0500
Subject: [PATCH v10 11/12] arm64: factor work_pending state machine to C
In-Reply-To: <1456949376-4910-1-git-send-email-cmetcalf@ezchip.com>
References: <1456949376-4910-1-git-send-email-cmetcalf@ezchip.com>
Message-ID: <1456949376-4910-12-git-send-email-cmetcalf@ezchip.com>
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

Signed-off-by: Chris Metcalf <cmetcalf@ezchip.com>
---
 arch/arm64/kernel/entry.S  | 12 ++++--------
 arch/arm64/kernel/signal.c | 30 ++++++++++++++++++++++--------
 2 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 1f7f5a2b61bf..966d0d4308f2 100644
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
index e18c48cb6db1..3432e14b7d6e 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -402,15 +402,29 @@ static void do_signal(struct pt_regs *regs)
 asmlinkage void do_notify_resume(struct pt_regs *regs,
 				 unsigned int thread_flags)
 {
-	if (thread_flags & _TIF_SIGPENDING)
-		do_signal(regs);
+	while (true) {
 
-	if (thread_flags & _TIF_NOTIFY_RESUME) {
-		clear_thread_flag(TIF_NOTIFY_RESUME);
-		tracehook_notify_resume(regs);
-	}
+		if (thread_flags & _TIF_NEED_RESCHED) {
+			schedule();
+		} else {
+			local_irq_enable();
+
+			if (thread_flags & _TIF_SIGPENDING)
+				do_signal(regs);
 
-	if (thread_flags & _TIF_FOREIGN_FPSTATE)
-		fpsimd_restore_current_state();
+			if (thread_flags & _TIF_NOTIFY_RESUME) {
+				clear_thread_flag(TIF_NOTIFY_RESUME);
+				tracehook_notify_resume(regs);
+			}
+
+			if (thread_flags & _TIF_FOREIGN_FPSTATE)
+				fpsimd_restore_current_state();
+		}
 
+		local_irq_disable();
+
+		thread_flags = READ_ONCE(current_thread_info()->flags);
+		if (!(thread_flags & _TIF_WORK_MASK))
+			break;
+	}
 }
-- 
2.1.2
