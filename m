From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 20 May 2016 17:42:17 +0200 (CEST)
Subject: [PATCH] arm: Enable interrupts before calling schedule()
Message-ID: <alpine.DEB.2.11.1605201740320.3639@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

do_work_pending() calls schedule() with interrupts disabled, which is just
wrong. Fix it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/arm/kernel/signal.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -573,6 +573,7 @@ do_work_pending(struct pt_regs *regs, un
 	trace_hardirqs_off();
 	do {
 		if (likely(thread_flags & _TIF_NEED_RESCHED)) {
+			local_irq_enable();
 			schedule();
 		} else {
 			if (unlikely(!user_mode(regs)))
