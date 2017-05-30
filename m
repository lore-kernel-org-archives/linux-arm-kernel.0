From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 30 May 2017 23:51:29 +0200
Subject: [PATCH 48/58] clocksource/drivers: timer-atmel-tcbclksrc: add
 clockevent device on separate channel
In-Reply-To: <20170530215139.9983-1-alexandre.belloni@free-electrons.com>
References: <20170530215139.9983-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170530215139.9983-49-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an other clockevent device that uses a separate TCB channel when
available.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/clocksource/timer-atmel-tcbclksrc.c | 177 +++++++++++++++++++++++++++-
 1 file changed, 173 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/timer-atmel-tcbclksrc.c b/drivers/clocksource/timer-atmel-tcbclksrc.c
index 462b04e9fed8..e117c11b4d1c 100644
--- a/drivers/clocksource/timer-atmel-tcbclksrc.c
+++ b/drivers/clocksource/timer-atmel-tcbclksrc.c
@@ -32,6 +32,167 @@ static struct atmel_tcb_clksrc {
 	},
 };
 
+static struct tc_clkevt_device {
+	char name[20];
+	struct clock_event_device clkevt;
+	struct regmap *regmap;
+	struct clk *slow_clk;
+	struct clk *clk;
+	int channel;
+	int irq;
+	bool registered;
+} tce = {
+	.clkevt	= {
+		.features		= CLOCK_EVT_FEAT_PERIODIC |
+					  CLOCK_EVT_FEAT_ONESHOT,
+		/*
+		 * Should be lower than at91rm9200's system timer
+		 * but higher than tc.clkevt.rating
+		 */
+		.rating			= 140,
+	},
+};
+
+static int tc_clkevt2_shutdown(struct clock_event_device *d)
+{
+	regmap_write(tce.regmap, ATMEL_TC_IDR(tce.channel), 0xff);
+	regmap_write(tce.regmap, ATMEL_TC_CCR(tce.channel),
+		     ATMEL_TC_CCR_CLKDIS);
+	if (!clockevent_state_detached(d))
+		clk_disable(tce.clk);
+
+	return 0;
+}
+
+/* For now, we always use the 32K clock ... this optimizes for NO_HZ,
+ * because using one of the divided clocks would usually mean the
+ * tick rate can never be less than several dozen Hz (vs 0.5 Hz).
+ *
+ * A divided clock could be good for high resolution timers, since
+ * 30.5 usec resolution can seem "low".
+ */
+static int tc_clkevt2_set_oneshot(struct clock_event_device *d)
+{
+	if (clockevent_state_oneshot(d) || clockevent_state_periodic(d))
+		tc_clkevt2_shutdown(d);
+
+	clk_enable(tce.clk);
+
+	/* slow clock, count up to RC, then irq and stop */
+	regmap_write(tce.regmap, ATMEL_TC_CMR(tce.channel),
+		     ATMEL_TC_CMR_TCLK(4) | ATMEL_TC_CMR_CPCSTOP |
+		     ATMEL_TC_CMR_WAVE | ATMEL_TC_CMR_WAVESEL_UPRC);
+	regmap_write(tce.regmap, ATMEL_TC_IER(tce.channel),
+		     ATMEL_TC_CPCS);
+
+	return 0;
+}
+
+static int tc_clkevt2_set_periodic(struct clock_event_device *d)
+{
+	if (clockevent_state_oneshot(d) || clockevent_state_periodic(d))
+		tc_clkevt2_shutdown(d);
+
+	/* By not making the gentime core emulate periodic mode on top
+	 * of oneshot, we get lower overhead and improved accuracy.
+	 */
+	clk_enable(tce.clk);
+
+	/* slow clock, count up to RC, then irq and restart */
+	regmap_write(tce.regmap, ATMEL_TC_CMR(tce.channel),
+		     ATMEL_TC_CMR_TCLK(4) | ATMEL_TC_CMR_WAVE |
+		     ATMEL_TC_CMR_WAVESEL_UPRC);
+	regmap_write(tce.regmap, ATMEL_TC_RC(tce.channel),
+		     (32768 + HZ / 2) / HZ);
+
+	/* Enable clock and interrupts on RC compare */
+	regmap_write(tce.regmap, ATMEL_TC_IER(tce.channel), ATMEL_TC_CPCS);
+	regmap_write(tce.regmap, ATMEL_TC_CCR(tce.channel),
+		     ATMEL_TC_CCR_CLKEN | ATMEL_TC_CCR_SWTRG);
+
+	return 0;
+}
+
+static int tc_clkevt2_next_event(unsigned long delta, struct clock_event_device *d)
+{
+	regmap_write(tce.regmap, ATMEL_TC_RC(tce.channel), delta);
+	regmap_write(tce.regmap, ATMEL_TC_CCR(tce.channel),
+		     ATMEL_TC_CCR_CLKEN | ATMEL_TC_CCR_SWTRG);
+
+	return 0;
+}
+
+static irqreturn_t tc_clkevt2_irq(int irq, void *handle)
+{
+	unsigned int sr;
+
+	regmap_read(tce.regmap, ATMEL_TC_SR(tce.channel), &sr);
+	if (sr & ATMEL_TC_CPCS) {
+		tce.clkevt.event_handler(&tce.clkevt);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+static int __init tc_clkevt_register(struct device_node *node,
+				     struct regmap *regmap, int channel,
+				     int irq, int bits)
+{
+	int ret;
+
+	tce.regmap = regmap;
+	tce.channel = channel;
+	tce.irq = irq;
+
+	tce.slow_clk = of_clk_get_by_name(node->parent, "slow_clk");
+	if (IS_ERR(tce.slow_clk))
+		return PTR_ERR(tce.slow_clk);
+
+	ret = clk_prepare_enable(tce.slow_clk);
+	if (ret)
+		return ret;
+
+	tce.clk = tcb_clk_get(node, tce.channel);
+	if (IS_ERR(tce.clk)) {
+		ret = PTR_ERR(tce.clk);
+		goto err_slow;
+	}
+
+	snprintf(tce.name, sizeof(tce.name), "%s:%d",
+		 kbasename(node->parent->full_name), channel);
+	tce.clkevt.cpumask = cpumask_of(0);
+	tce.clkevt.name = tce.name;
+	tce.clkevt.set_next_event = tc_clkevt2_next_event,
+	tce.clkevt.set_state_shutdown = tc_clkevt2_shutdown,
+	tce.clkevt.set_state_periodic = tc_clkevt2_set_periodic,
+	tce.clkevt.set_state_oneshot = tc_clkevt2_set_oneshot,
+
+	/* try to enable clk to avoid future errors in mode change */
+	ret = clk_prepare_enable(tce.clk);
+	if (ret)
+		goto err_slow;
+	clk_disable(tce.clk);
+
+	clockevents_config_and_register(&tce.clkevt, 32768, 1, bits - 1);
+
+	ret = request_irq(tce.irq, tc_clkevt2_irq, IRQF_TIMER | IRQF_SHARED,
+			  tce.clkevt.name, &tce);
+	if (ret)
+		goto err_clk;
+
+	tce.registered = true;
+
+	return 0;
+
+err_clk:
+	clk_unprepare(tce.clk);
+err_slow:
+	clk_disable_unprepare(tce.slow_clk);
+
+	return ret;
+}
+
 static u64 tc_get_cycles(struct clocksource *cs)
 {
 	u32		lower, upper, tmp;
@@ -299,7 +460,7 @@ static int __init tcb_clksrc_init(struct device_node *node)
 	u32 channel;
 	int bits, irq, err, chan1 = -1;
 
-	if (tc.registered)
+	if (tc.registered && tce.registered)
 		return -ENODEV;
 
 	regmap = syscon_node_to_regmap(node->parent);
@@ -318,12 +479,20 @@ static int __init tcb_clksrc_init(struct device_node *node)
 	if (irq < 0)
 		return irq;
 
+	if (tc.registered)
+		return tc_clkevt_register(node, regmap, channel, irq, bits);
+
 	if (bits == 16) {
 		of_property_read_u32_index(node, "reg", 1, &chan1);
 		if (chan1 == -1) {
-			pr_err("%s: clocksource needs two channels\n",
-			       node->parent->full_name);
-			return -EINVAL;
+			if (tce.registered) {
+				pr_err("%s: clocksource needs two channels\n",
+				       node->parent->full_name);
+				return -EINVAL;
+			} else {
+				return tc_clkevt_register(node, regmap, channel,
+							  irq, bits);
+			}
 		}
 	}
 
-- 
2.11.0
