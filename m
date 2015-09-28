From: cmetcalf@ezchip.com (Chris Metcalf)
Date: Mon, 28 Sep 2015 11:17:23 -0400
Subject: [PATCH v7 08/11] arch/arm64: adopt prepare_exit_to_usermode() model
 from x86
In-Reply-To: <1443453446-7827-1-git-send-email-cmetcalf@ezchip.com>
References: <1443453446-7827-1-git-send-email-cmetcalf@ezchip.com>
Message-ID: <1443453446-7827-9-git-send-email-cmetcalf@ezchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This change is a prerequisite change for TASK_ISOLATION but also
stands on its own for readability and maintainability.  The existing
arm64 do_notify_resume() is called in a loop from assembly on
the slow path; this change moves the loop into C code as well.
For the x86 version see commit c5c46f59e4e7 ("x86/entry: Add new,
comprehensible entry and exit handlers written in C").

Signed-off-by: Chris Metcalf <cmetcalf@ezchip.com>
---
 arch/arm64/kernel/entry.S  |  6 +++---
 arch/arm64/kernel/signal.c | 32 ++++++++++++++++++++++----------
 2 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 4306c937b1ff..6fcbf8ea307b 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -628,9 +628,8 @@ work_pending:
 	mov	x0, sp				// 'regs'
 	tst	x2, #PSR_MODE_MASK		// user mode regs?
 	b.ne	no_work_pending			// returning to kernel
-	enable_irq				// enable interrupts for do_notify_resume()
-	bl	do_notify_resume
-	b	ret_to_user
+	bl	prepare_exit_to_usermode
+	b	no_user_work_pending
 work_resched:
 	bl	schedule
 
@@ -642,6 +641,7 @@ ret_to_user:
 	ldr	x1, [tsk, #TI_FLAGS]
 	and	x2, x1, #_TIF_WORK_MASK
 	cbnz	x2, work_pending
+no_user_work_pending:
 	enable_step_tsk x1, x2
 no_work_pending:
 	kernel_exit 0
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index e18c48cb6db1..fde59c1139a9 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -399,18 +399,30 @@ static void do_signal(struct pt_regs *regs)
 	restore_saved_sigmask();
 }
 
-asmlinkage void do_notify_resume(struct pt_regs *regs,
-				 unsigned int thread_flags)
+asmlinkage void prepare_exit_to_usermode(struct pt_regs *regs,
+					 unsigned int thread_flags)
 {
-	if (thread_flags & _TIF_SIGPENDING)
-		do_signal(regs);
+	do {
+		local_irq_enable();
 
-	if (thread_flags & _TIF_NOTIFY_RESUME) {
-		clear_thread_flag(TIF_NOTIFY_RESUME);
-		tracehook_notify_resume(regs);
-	}
+		if (thread_flags & _TIF_NEED_RESCHED)
+			schedule();
+
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
+
+		local_irq_disable();
 
-	if (thread_flags & _TIF_FOREIGN_FPSTATE)
-		fpsimd_restore_current_state();
+		thread_flags = READ_ONCE(current_thread_info()->flags) &
+			_TIF_WORK_MASK;
 
+	} while (thread_flags);
 }
-- 
2.1.2
