From: davidcdueck@googlemail.com (David Dueck)
Date: Fri,  3 Jul 2015 17:33:29 +0200
Subject: [PATCH 2/2] at91: use request_irq/free_irq instead of
 setup_irq/remove_irq
In-Reply-To: <1435937609-18623-1-git-send-email-davidcdueck@googlemail.com>
References: <1435937609-18623-1-git-send-email-davidcdueck@googlemail.com>
Message-ID: <1435937609-18623-2-git-send-email-davidcdueck@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes a warning when using RT-Preempt.

WARNING: CPU: 0 PID: 0 at kernel/irq/manage.c:1406 __free_irq+0xa4/0x210()
Trying to free already-free IRQ 0
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted 4.0.0-rt4+ #198
Hardware name: Atmel SAMA5
[<c0013008>] (unwind_backtrace) from [<c0010e90>] (show_stack+0x10/0x14)
[<c0010e90>] (show_stack) from [<c001a8c8>] (warn_slowpath_common+0x80/0xac)
[<c001a8c8>] (warn_slowpath_common) from [<c001a924>] (warn_slowpath_fmt+0x30/0x40)
[<c001a924>] (warn_slowpath_fmt) from [<c00473e8>] (__free_irq+0xa4/0x210)
[<c00473e8>] (__free_irq) from [<c0060820>] (clockevents_set_mode+0x28/0x5c)
[<c0060820>] (clockevents_set_mode) from [<c0060b40>] (clockevents_exchange_device+0x84/0x9c)
[<c0060b40>] (clockevents_exchange_device) from [<c006113c>] (tick_check_new_device+0x8c/0xac)
[<c006113c>] (tick_check_new_device) from [<c0060060>] (clockevents_register_device+0x5c/0x118)
[<c0060060>] (clockevents_register_device) from [<c067459c>] (clocksource_of_init+0x4c/0x8c)
[<c067459c>] (clocksource_of_init) from [<c065cb10>] (start_kernel+0x268/0x3c0)
[<c065cb10>] (start_kernel) from [<20008070>] (0x20008070)
---[ end trace 0000000000000001 ]---

Signed-off-by: David Dueck <davidcdueck@googlemail.com>
---
 drivers/clocksource/timer-atmel-pit.c | 76 ++++++++++++++++++-----------------
 1 file changed, 40 insertions(+), 36 deletions(-)

diff --git a/drivers/clocksource/timer-atmel-pit.c b/drivers/clocksource/timer-atmel-pit.c
index d9c0b72..1de1ac8 100644
--- a/drivers/clocksource/timer-atmel-pit.c
+++ b/drivers/clocksource/timer-atmel-pit.c
@@ -90,7 +90,38 @@ static cycle_t read_pit_clk(struct clocksource *cs)
 	return elapsed;
 }
 
-static struct irqaction at91sam926x_pit_irq;
+/*
+ * IRQ handler for the timer.
+ */
+static irqreturn_t at91sam926x_pit_interrupt(int irq, void *dev_id)
+{
+	struct pit_data *data = dev_id;
+
+	/*
+	 * irqs should be disabled here, but as the irq is shared they are only
+	 * guaranteed to be off if the timer irq is registered first.
+	 */
+	WARN_ON_ONCE(!irqs_disabled());
+
+	/* The PIT interrupt may be disabled, and is shared */
+	if ((data->clkevt.mode == CLOCK_EVT_MODE_PERIODIC) &&
+	    (pit_read(data->base, AT91_PIT_SR) & AT91_PIT_PITS)) {
+		unsigned nr_ticks;
+
+		/* Get number of ticks performed before irq, and ack it */
+		nr_ticks = PIT_PICNT(pit_read(data->base, AT91_PIT_PIVR));
+		do {
+			data->cnt += data->cycle;
+			data->clkevt.event_handler(&data->clkevt);
+			nr_ticks--;
+		} while (nr_ticks);
+
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
 /*
  * Clockevent device:  interrupts every 1/HZ (== pit_cycles * MCK/16)
  */
@@ -98,11 +129,16 @@ static void
 pit_clkevt_mode(enum clock_event_mode mode, struct clock_event_device *dev)
 {
 	struct pit_data *data = clkevt_to_pit_data(dev);
+	int ret;
 
 	switch (mode) {
 	case CLOCK_EVT_MODE_PERIODIC:
-		/* Set up irq handler */
-		setup_irq(at91sam926x_pit_irq.irq, &at91sam926x_pit_irq);
+		ret = request_irq(data->irq, at91sam926x_pit_interrupt,
+				  IRQF_SHARED | IRQF_TIMER | IRQF_IRQPOLL,
+				  "at91_tick", data);
+		if (ret)
+			pr_warn("Unable to request PIT irq!\n");
+
 		/* update clocksource counter */
 		data->cnt += data->cycle * PIT_PICNT(pit_read(data->base, AT91_PIT_PIVR));
 		pit_write(data->base, AT91_PIT_MR,
@@ -116,7 +152,7 @@ pit_clkevt_mode(enum clock_event_mode mode, struct clock_event_device *dev)
 		/* disable irq, leaving the clocksource active */
 		pit_write(data->base, AT91_PIT_MR,
 			  (data->cycle - 1) | AT91_PIT_PITEN);
-		remove_irq(at91sam926x_pit_irq.irq, &at91sam926x_pit_irq);
+		free_irq(data->irq, data);
 		break;
 	case CLOCK_EVT_MODE_RESUME:
 		break;
@@ -153,38 +189,6 @@ static void at91sam926x_pit_resume(struct clock_event_device *cedev)
 }
 
 /*
- * IRQ handler for the timer.
- */
-static irqreturn_t at91sam926x_pit_interrupt(int irq, void *dev_id)
-{
-	struct pit_data *data = dev_id;
-
-	/*
-	 * irqs should be disabled here, but as the irq is shared they are only
-	 * guaranteed to be off if the timer irq is registered first.
-	 */
-	WARN_ON_ONCE(!irqs_disabled());
-
-	/* The PIT interrupt may be disabled, and is shared */
-	if ((data->clkevt.mode == CLOCK_EVT_MODE_PERIODIC) &&
-	    (pit_read(data->base, AT91_PIT_SR) & AT91_PIT_PITS)) {
-		unsigned nr_ticks;
-
-		/* Get number of ticks performed before irq, and ack it */
-		nr_ticks = PIT_PICNT(pit_read(data->base, AT91_PIT_PIVR));
-		do {
-			data->cnt += data->cycle;
-			data->clkevt.event_handler(&data->clkevt);
-			nr_ticks--;
-		} while (nr_ticks);
-
-		return IRQ_HANDLED;
-	}
-
-	return IRQ_NONE;
-}
-
-/*
  * Set up both clocksource and clockevent support.
  */
 static void __init at91sam926x_pit_common_init(struct pit_data *data)
-- 
2.4.4
