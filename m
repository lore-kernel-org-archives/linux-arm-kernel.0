From: tglx@linutronix.de (Thomas Gleixner)
Date: Sat, 23 Jul 2011 19:15:17 +0200 (CEST)
Subject: [PATCH] arm: Call do_notify_resume() with interrupts enabled
Message-ID: <alpine.LFD.2.02.1107231914050.2702@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a signal is delivered from do_notify_resume() __put_user() is
currently called with interrupts disabled.

When the access faults then the fault code trips over the interrupts
disabled check in might_sleep(). No biscuit!

Enable interrupts before calling do_notify_resume().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/arm/kernel/entry-common.S |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6/arch/arm/kernel/entry-common.S
===================================================================
--- linux-2.6.orig/arch/arm/kernel/entry-common.S
+++ linux-2.6/arch/arm/kernel/entry-common.S
@@ -49,6 +49,7 @@ work_pending:
 	bne	work_resched
 	tst	r1, #_TIF_SIGPENDING|_TIF_NOTIFY_RESUME
 	beq	no_work_pending
+	enable_irq
 	mov	r0, sp				@ 'regs'
 	mov	r2, why				@ 'syscall'
 	tst	r1, #_TIF_SIGPENDING		@ delivering a signal?
