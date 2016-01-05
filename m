From: mark.rutland@arm.com (Mark Rutland)
Date: Tue,  5 Jan 2016 17:33:35 +0000
Subject: [PATCH 2/2] arm64: factor work_pending state machine to C
In-Reply-To: <20160105172106.GA7088@leverpostej>
References: <20160105172106.GA7088@leverpostej>
Message-ID: <1452015215-29506-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently ret_fast_syscall, work_pending, and ret_to_user form an ad-hoc
state machine that can be difficult to reason about due to duplicated
code and a large number of branch targets.

This patch factors the common logic out into the existing
do_notify_resume function, converting the code to C in the process,
making the code more legible.

This patch tries to mirror the existing behaviour as closely as possible
while using the usual C control flow primitives. There should be no
functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Chris Metcalf <cmetcalf@ezchip.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/entry.S  | 24 +++---------------------
 arch/arm64/kernel/signal.c | 36 ++++++++++++++++++++++++++----------
 2 files changed, 29 insertions(+), 31 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 6b30ab1..41f5dfc 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -612,35 +612,17 @@ ret_fast_syscall:
 	ldr	x1, [tsk, #TI_FLAGS]		// re-check for syscall tracing
 	and	x2, x1, #_TIF_SYSCALL_WORK
 	cbnz	x2, ret_fast_syscall_trace
-	and	x2, x1, #_TIF_WORK_MASK
-	cbnz	x2, work_pending
-	enable_step_tsk x1, x2
-	kernel_exit 0
+	b	ret_to_user
 ret_fast_syscall_trace:
 	enable_irq				// enable interrupts
 	b	__sys_trace_return_skipped	// we already saved x0
 
 /*
- * Ok, we need to do extra processing, enter the slow path.
- */
-work_pending:
-	tbnz	x1, #TIF_NEED_RESCHED, work_resched
-	/* TIF_SIGPENDING, TIF_NOTIFY_RESUME or TIF_FOREIGN_FPSTATE case */
-	mov	x0, sp				// 'regs'
-	enable_irq				// enable interrupts for do_notify_resume()
-	bl	do_notify_resume
-	b	ret_to_user
-work_resched:
-	bl	schedule
-
-/*
  * "slow" syscall return path.
  */
 ret_to_user:
-	disable_irq				// disable interrupts
-	ldr	x1, [tsk, #TI_FLAGS]
-	and	x2, x1, #_TIF_WORK_MASK
-	cbnz	x2, work_pending
+	bl	do_notify_resume
+	ldr	x1, [tsk, #TI_FLAGS]		// re-check for single-step
 	enable_step_tsk x1, x2
 	kernel_exit 0
 ENDPROC(ret_to_user)
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index e18c48c..3a6c60b 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -399,18 +399,34 @@ static void do_signal(struct pt_regs *regs)
 	restore_saved_sigmask();
 }
 
-asmlinkage void do_notify_resume(struct pt_regs *regs,
-				 unsigned int thread_flags)
+asmlinkage void do_notify_resume(void)
 {
-	if (thread_flags & _TIF_SIGPENDING)
-		do_signal(regs);
+	struct pt_regs *regs = task_pt_regs(current);
+	unsigned long thread_flags;
 
-	if (thread_flags & _TIF_NOTIFY_RESUME) {
-		clear_thread_flag(TIF_NOTIFY_RESUME);
-		tracehook_notify_resume(regs);
-	}
+	for (;;) {
+		local_irq_disable();
+
+		thread_flags = READ_ONCE(current_thread_info()->flags);
+		if (!(thread_flags & _TIF_WORK_MASK))
+			break;
+
+		if (thread_flags & _TIF_NEED_RESCHED) {
+			schedule();
+			continue;
+		}
 
-	if (thread_flags & _TIF_FOREIGN_FPSTATE)
-		fpsimd_restore_current_state();
+		local_irq_enable();
 
+		if (thread_flags & _TIF_SIGPENDING)
+			do_signal(regs);
+
+		if (thread_flags & _TIF_NOTIFY_RESUME) {
+			clear_thread_flag(TIF_NOTIFY_RESUME);
+			tracehook_notify_resume(regs);
+		}
+
+		if (thread_flags & _TIF_FOREIGN_FPSTATE)
+			fpsimd_restore_current_state();
+	}
 }
-- 
1.9.1
