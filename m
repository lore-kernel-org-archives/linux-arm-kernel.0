From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 17 Jul 2015 21:33:28 +0200
Subject: [PATCH 3/3] clocksource: atmel-pit: Remove irq handler when clock
 event is unused
In-Reply-To: <1437161608-26782-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1437161608-26782-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1437161608-26782-4-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Setup and remove the interrupt handler in clock event mode selection.
This avoids calling the (shared) interrupt handler when the device is not
used.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/clocksource/timer-atmel-pit.c | 86 +++++++++++++++++++----------------
 1 file changed, 46 insertions(+), 40 deletions(-)

diff --git a/drivers/clocksource/timer-atmel-pit.c b/drivers/clocksource/timer-atmel-pit.c
index e64af62a186c..c77aafa7846e 100644
--- a/drivers/clocksource/timer-atmel-pit.c
+++ b/drivers/clocksource/timer-atmel-pit.c
@@ -96,15 +96,61 @@ static int pit_clkevt_shutdown(struct clock_event_device *dev)
 
 	/* disable irq, leaving the clocksource active */
 	pit_write(data->base, AT91_PIT_MR, (data->cycle - 1) | AT91_PIT_PITEN);
+
+	if (clockevent_state_periodic(dev))
+		free_irq(data->irq, data);
+
 	return 0;
 }
 
 /*
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
+	if (clockevent_state_periodic(&data->clkevt) &&
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
+/*
  * Clockevent device:  interrupts every 1/HZ (== pit_cycles * MCK/16)
  */
 static int pit_clkevt_set_periodic(struct clock_event_device *dev)
 {
 	struct pit_data *data = clkevt_to_pit_data(dev);
+	int		ret;
+
+	/* Set up irq handler */
+	ret = request_irq(data->irq, at91sam926x_pit_interrupt,
+			  IRQF_SHARED | IRQF_TIMER | IRQF_IRQPOLL,
+			  "at91_tick", data);
+	if (ret) {
+		pr_alert("Unable to setup IRQ\n");
+		return ret;
+	}
 
 	/* update clocksource counter */
 	data->cnt += data->cycle * PIT_PICNT(pit_read(data->base, AT91_PIT_PIVR));
@@ -143,38 +189,6 @@ static void at91sam926x_pit_resume(struct clock_event_device *cedev)
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
-	if (clockevent_state_periodic(&data->clkevt) &&
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
 static void __init at91sam926x_pit_dt_init(struct device_node *node)
@@ -182,7 +196,6 @@ static void __init at91sam926x_pit_dt_init(struct device_node *node)
 	struct pit_data *data;
 	unsigned long	pit_rate;
 	unsigned	bits;
-	int		ret;
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -228,13 +241,6 @@ static void __init at91sam926x_pit_dt_init(struct device_node *node)
 	data->clksrc.flags = CLOCK_SOURCE_IS_CONTINUOUS,
 	clocksource_register_hz(&data->clksrc, pit_rate);
 
-	/* Set up irq handler */
-	ret = request_irq(data->irq, at91sam926x_pit_interrupt,
-			  IRQF_SHARED | IRQF_TIMER | IRQF_IRQPOLL,
-			  "at91_tick", data);
-	if (ret)
-		panic(pr_fmt("Unable to setup IRQ\n"));
-
 	/* Set up and register clockevents */
 	data->clkevt.name = "pit";
 	data->clkevt.features = CLOCK_EVT_FEAT_PERIODIC;
-- 
2.1.4
