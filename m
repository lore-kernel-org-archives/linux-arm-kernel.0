From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 30 May 2017 23:51:28 +0200
Subject: [PATCH 47/58] clocksource/drivers: timer-atmel-tcbclksrc: add
 clockevent device
In-Reply-To: <20170530215139.9983-1-alexandre.belloni@free-electrons.com>
References: <20170530215139.9983-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170530215139.9983-48-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is possible to compare and get interrupts on the channel that is used
for the clocksource. Enable that to have a solution using only one TCB
channel.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/clocksource/timer-atmel-tcbclksrc.c | 81 +++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/clocksource/timer-atmel-tcbclksrc.c b/drivers/clocksource/timer-atmel-tcbclksrc.c
index f18d177bfdea..462b04e9fed8 100644
--- a/drivers/clocksource/timer-atmel-tcbclksrc.c
+++ b/drivers/clocksource/timer-atmel-tcbclksrc.c
@@ -12,6 +12,7 @@
 static struct atmel_tcb_clksrc {
 	char name[20];
 	struct clocksource clksrc;
+	struct clock_event_device clkevt;
 	struct regmap *regmap;
 	struct clk *clk[2];
 	int channels[2];
@@ -24,6 +25,11 @@ static struct atmel_tcb_clksrc {
 		.mask		= CLOCKSOURCE_MASK(32),
 		.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 	},
+	.clkevt	= {
+		.features	= CLOCK_EVT_FEAT_ONESHOT,
+		/* Should be lower than at91rm9200's system timer */
+		.rating		= 125,
+	},
 };
 
 static u64 tc_get_cycles(struct clocksource *cs)
@@ -58,6 +64,72 @@ static u64 notrace tc_sched_clock_read32(void)
 	return tc_get_cycles32(&tc.clksrc);
 }
 
+static int tcb_clkevt_next_event(unsigned long delta,
+				 struct clock_event_device *d)
+{
+	u32 old, next, cur;
+
+
+	regmap_read(tc.regmap, ATMEL_TC_CV(tc.channels[0]), &old);
+	next = old + delta;
+	regmap_write(tc.regmap, ATMEL_TC_RC(tc.channels[0]), next);
+	regmap_read(tc.regmap, ATMEL_TC_CV(tc.channels[0]), &cur);
+
+	/* check whether the delta elapsed while setting the register */
+	if ((next < old && cur < old && cur > next) ||
+	    (next > old && (cur < old || cur > next))) {
+		/*
+		 * Clear the CPCS bit in the status register to avoid
+		 * generating a spurious interrupt next time a valid
+		 * timer event is configured.
+		 */
+		regmap_read(tc.regmap, ATMEL_TC_SR(tc.channels[0]), &old);
+		return -ETIME;
+	}
+
+	regmap_write(tc.regmap, ATMEL_TC_IER(tc.channels[0]), ATMEL_TC_CPCS);
+
+	return 0;
+}
+
+static irqreturn_t tc_clkevt_irq(int irq, void *handle)
+{
+	unsigned int sr;
+
+	regmap_read(tc.regmap, ATMEL_TC_SR(tc.channels[0]), &sr);
+	if (sr & ATMEL_TC_CPCS) {
+		tc.clkevt.event_handler(&tc.clkevt);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+static int tcb_clkevt_oneshot(struct clock_event_device *dev)
+{
+	if (clockevent_state_oneshot(dev))
+		return 0;
+
+	/*
+	 * Because both clockevent devices may share the same IRQ, we don't want
+	 * the less likely one to stay requested
+	 */
+	return request_irq(tc.irq, tc_clkevt_irq, IRQF_TIMER | IRQF_SHARED,
+			   tc.name, &tc);
+}
+
+static int tcb_clkevt_shutdown(struct clock_event_device *dev)
+{
+	regmap_write(tc.regmap, ATMEL_TC_IDR(tc.channels[0]), 0xff);
+	if (tc.bits == 16)
+		regmap_write(tc.regmap, ATMEL_TC_IDR(tc.channels[1]), 0xff);
+
+	if (!clockevent_state_detached(dev))
+		free_irq(tc.irq, &tc);
+
+	return 0;
+}
+
 static void __init tcb_setup_dual_chan(struct atmel_tcb_clksrc *tc,
 				       int mck_divisor_idx)
 {
@@ -188,6 +260,15 @@ static int __init tcb_clksrc_register(struct device_node *node,
 
 	tc.registered = true;
 
+	/* Set up and register clockevents */
+	tc.clkevt.name = tc.name;
+	tc.clkevt.cpumask = cpumask_of(0);
+	tc.clkevt.set_next_event = tcb_clkevt_next_event;
+	tc.clkevt.set_state_oneshot = tcb_clkevt_oneshot;
+	tc.clkevt.set_state_shutdown = tcb_clkevt_shutdown;
+	clockevents_config_and_register(&tc.clkevt, divided_rate, 1,
+					BIT(tc.bits) - 1);
+
 	return 0;
 
 err_disable_t1:
-- 
2.11.0
