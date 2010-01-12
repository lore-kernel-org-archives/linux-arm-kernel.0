From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 12 Jan 2010 16:42:02 +0100
Subject: [RESEND PATCH] genirq: warn about IRQF_SHARED|IRQF_DISABLED at the
	right place
In-Reply-To: <1259578067-29169-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1259578067-29169-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1263310922-5251-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For shared irqs IRQF_DISABLED is only guaranteed for the first handler.
So only warn starting at the second registration.

The warning is moved to __setup_irq having the additional benefit of
catching actions registered using setup_irq not only register_irq.

This doesn't fix the cases where setup order is wrong but it should
report the broken cases more reliably.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: David Brownell <dbrownell@users.sourceforge.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Nicolas Pitre <nico@marvell.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: John Stultz <johnstul@us.ibm.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Remy Bohmer <linux@bohmer.net>
Cc: Hugh Dickins <hugh.dickins@tiscali.co.uk>
Cc: Andrea Gallo <andrea.gallo@stericsson.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jamie Lokier <jamie@shareable.org>
Cc: linux-arm-kernel at lists.infradead.org
---
Hello,

until Thomas or Peter get round to dump IRQF_DISABLED completely this
patch removes some false positive warnings and adds a valid warning in
some situations that weren't catched before.

Best regards
Uwe

 kernel/irq/manage.c |   23 ++++++++++-------------
 1 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index bde4c66..d8f7415 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -702,6 +702,16 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 			goto mismatch;
 #endif
 
+		/*
+		 * handle_IRQ_event() only honors IRQF_DISABLED for the _first_
+		 * irqaction.  As the first handler might reenable irqs all bets
+		 * are off for the later handlers even if the first one has
+		 * IRQF_DISABLED, too.
+		 */
+		if (new->flags & IRQF_DISABLED)
+			pr_warning("IRQ %d/%s: IRQF_DISABLED is not guaranteed "
+					"on shared IRQs\n", irq, new->name);
+
 		/* add new interrupt at end of irq queue */
 		do {
 			old_ptr = &old->next;
@@ -1008,19 +1018,6 @@ int request_threaded_irq(unsigned int irq, irq_handler_t handler,
 	struct irq_desc *desc;
 	int retval;
 
-	/*
-	 * handle_IRQ_event() always ignores IRQF_DISABLED except for
-	 * the _first_ irqaction (sigh).  That can cause oopsing, but
-	 * the behavior is classified as "will not fix" so we need to
-	 * start nudging drivers away from using that idiom.
-	 */
-	if ((irqflags & (IRQF_SHARED|IRQF_DISABLED)) ==
-					(IRQF_SHARED|IRQF_DISABLED)) {
-		pr_warning(
-		  "IRQ %d/%s: IRQF_DISABLED is not guaranteed on shared IRQs\n",
-			irq, devname);
-	}
-
 #ifdef CONFIG_LOCKDEP
 	/*
 	 * Lockdep wants atomic interrupt handlers:
-- 
1.6.6
