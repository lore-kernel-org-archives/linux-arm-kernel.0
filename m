From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue,  6 Jun 2017 14:44:12 +0200
Subject: [PATCH 2/2] clocksource/drivers/keystone: Use the timer-of common
 routine
In-Reply-To: <1496753054-7489-1-git-send-email-daniel.lezcano@linaro.org>
References: <1496753054-7489-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1496753054-7489-2-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The previous patch provided a common init routine for the OF drivers.

The keystone driver is given as example on the improvement and usage of the
common initialization routine.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig          |   1 +
 drivers/clocksource/timer-keystone.c | 117 +++++++++++++----------------------
 2 files changed, 44 insertions(+), 74 deletions(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 4ba230d..f1ed520 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -216,6 +216,7 @@ config KEYSTONE_TIMER
 	depends on GENERIC_CLOCKEVENTS
 	depends on ARM || ARM64
 	select CLKSRC_MMIO
+	select TIMER_OF
 	help
 	  Enables support for the Keystone timer.
 
diff --git a/drivers/clocksource/timer-keystone.c b/drivers/clocksource/timer-keystone.c
index 0eee032..84b2523 100644
--- a/drivers/clocksource/timer-keystone.c
+++ b/drivers/clocksource/timer-keystone.c
@@ -18,6 +18,8 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 
+#include "timer-of.h"
+
 #define TIMER_NAME			"timer-keystone"
 
 /* Timer register offsets */
@@ -37,26 +39,16 @@
 #define TGCR_TIM_UNRESET_MASK		0x03
 #define INTCTLSTAT_ENINT_MASK		0x01
 
-/**
- * struct keystone_timer: holds timer's data
- * @base: timer memory base address
- * @hz_period: cycles per HZ period
- * @event_dev: event device based on timer
- */
-static struct keystone_timer {
-	void __iomem *base;
-	unsigned long hz_period;
-	struct clock_event_device event_dev;
-} timer;
+static struct timer_of to;
 
 static inline u32 keystone_timer_readl(unsigned long rg)
 {
-	return readl_relaxed(timer.base + rg);
+	return readl_relaxed(timer_of_base(&to) + rg);
 }
 
 static inline void keystone_timer_writel(u32 val, unsigned long rg)
 {
-	writel_relaxed(val, timer.base + rg);
+	writel_relaxed(val, timer_of_base(&to) + rg);
 }
 
 /**
@@ -123,6 +115,7 @@ static irqreturn_t keystone_timer_interrupt(int irq, void *dev_id)
 	struct clock_event_device *evt = dev_id;
 
 	evt->event_handler(evt);
+
 	return IRQ_HANDLED;
 }
 
@@ -140,43 +133,42 @@ static int keystone_shutdown(struct clock_event_device *evt)
 
 static int keystone_set_periodic(struct clock_event_device *evt)
 {
-	keystone_timer_config(timer.hz_period, TCR_ENAMODE_PERIODIC_MASK);
+	struct timer_of *to = to_timer_of(evt);
+
+	keystone_timer_config(timer_of_period(to), TCR_ENAMODE_PERIODIC_MASK);
+
 	return 0;
 }
 
+static struct timer_of to = {
+	.flags = TIMER_OF_IRQ |
+		TIMER_OF_CLOCK |
+		TIMER_OF_BASE,
+
+	.clkevt = {
+		.features = CLOCK_EVT_FEAT_PERIODIC |
+			CLOCK_EVT_FEAT_ONESHOT,
+		.set_next_event = keystone_set_next_event,
+		.set_state_shutdown = keystone_shutdown,
+		.set_state_periodic = keystone_set_periodic,
+		.set_state_oneshot = keystone_shutdown,
+		.cpumask = cpu_all_mask,
+		.owner = THIS_MODULE,
+		.name = TIMER_NAME,
+	},
+
+	.of_irq = {
+		.handler = keystone_timer_interrupt,
+	},
+};
+
 static int __init keystone_timer_init(struct device_node *np)
 {
-	struct clock_event_device *event_dev = &timer.event_dev;
-	unsigned long rate;
-	struct clk *clk;
-	int irq, error;
-
-	irq  = irq_of_parse_and_map(np, 0);
-	if (!irq) {
-		pr_err("%s: failed to map interrupts\n", __func__);
-		return -EINVAL;
-	}
-
-	timer.base = of_iomap(np, 0);
-	if (!timer.base) {
-		pr_err("%s: failed to map registers\n", __func__);
-		return -ENXIO;
-	}
-
-	clk = of_clk_get(np, 0);
-	if (IS_ERR(clk)) {
-		pr_err("%s: failed to get clock\n", __func__);
-		iounmap(timer.base);
-		return PTR_ERR(clk);
-	}
-
-	error = clk_prepare_enable(clk);
-	if (error) {
-		pr_err("%s: failed to enable clock\n", __func__);
-		goto err;
-	}
-
-	rate = clk_get_rate(clk);
+	int ret;
+
+	ret = timer_of_init(np, &to);
+	if (ret)
+		return ret;
 
 	/* disable, use internal clock source */
 	keystone_timer_writel(0, TCR);
@@ -193,38 +185,15 @@ static int __init keystone_timer_init(struct device_node *np)
 	keystone_timer_writel(0, TIM12);
 	keystone_timer_writel(0, TIM34);
 
-	timer.hz_period = DIV_ROUND_UP(rate, HZ);
-
 	/* enable timer interrupts */
 	keystone_timer_writel(INTCTLSTAT_ENINT_MASK, INTCTLSTAT);
 
-	error = request_irq(irq, keystone_timer_interrupt, IRQF_TIMER,
-			    TIMER_NAME, event_dev);
-	if (error) {
-		pr_err("%s: failed to setup irq\n", __func__);
-		goto err;
-	}
-
-	/* setup clockevent */
-	event_dev->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
-	event_dev->set_next_event = keystone_set_next_event;
-	event_dev->set_state_shutdown = keystone_shutdown;
-	event_dev->set_state_periodic = keystone_set_periodic;
-	event_dev->set_state_oneshot = keystone_shutdown;
-	event_dev->cpumask = cpu_all_mask;
-	event_dev->owner = THIS_MODULE;
-	event_dev->name = TIMER_NAME;
-	event_dev->irq = irq;
-
-	clockevents_config_and_register(event_dev, rate, 1, ULONG_MAX);
-
-	pr_info("keystone timer clock @%lu Hz\n", rate);
+	clockevents_config_and_register(&to.clkevt, timer_of_rate(&to),
+					1, ULONG_MAX);
+
+	pr_info("keystone timer clock @%lu Hz\n", timer_of_rate(&to));
+
 	return 0;
-err:
-	clk_put(clk);
-	iounmap(timer.base);
-	return error;
 }
 
-TIMER_OF_DECLARE(keystone_timer, "ti,keystone-timer",
-			   keystone_timer_init);
+TIMER_OF_DECLARE(keystone_timer, "ti,keystone-timer", keystone_timer_init);
-- 
2.7.4
