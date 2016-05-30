From: shijie.huang@arm.com (Huang Shijie)
Date: Mon, 30 May 2016 10:52:30 +0800
Subject: [PATCH 9/9] arm64: entry: remove the duplicated hardirq flags trace
 code
In-Reply-To: <1464576750-25160-1-git-send-email-shijie.huang@arm.com>
References: <1464576750-25160-1-git-send-email-shijie.huang@arm.com>
Message-ID: <1464576750-25160-10-git-send-email-shijie.huang@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have added the trace code to the interrupt enable/disable macros,
so the trace code in work_pending and do_notify_resume are
duplicated, just remove them.

Signed-off-by: Huang Shijie <shijie.huang@arm.com>
---
 arch/arm64/kernel/entry.S  | 3 ---
 arch/arm64/kernel/signal.c | 6 ------
 2 files changed, 9 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 7005789..b6edb55 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -691,9 +691,6 @@ ret_fast_syscall_trace:
 work_pending:
 	mov	x0, sp				// 'regs'
 	bl	do_notify_resume
-#ifdef CONFIG_TRACE_IRQFLAGS
-	bl	trace_hardirqs_on		// enabled while in userspace
-#endif
 	ldr	x1, [tsk, #TI_FLAGS]		// re-check for single-step
 	b	finish_ret_to_user
 /*
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 404dd67..56fdcb2 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -402,12 +402,6 @@ static void do_signal(struct pt_regs *regs)
 asmlinkage void do_notify_resume(struct pt_regs *regs,
 				 unsigned int thread_flags)
 {
-	/*
-	 * The assembly code enters us with IRQs off, but it hasn't
-	 * informed the tracing code of that for efficiency reasons.
-	 * Update the trace code with the current status.
-	 */
-	trace_hardirqs_off();
 	do {
 		if (thread_flags & _TIF_NEED_RESCHED) {
 			schedule();
-- 
2.5.5
