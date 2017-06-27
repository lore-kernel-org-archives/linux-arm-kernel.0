From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 27 Jun 2017 11:26:57 +0200
Subject: [PATCH 2/5] clocksource/drivers/sun4i: Switch to the timer-of common
 init
In-Reply-To: <1498555620-25094-1-git-send-email-daniel.lezcano@linaro.org>
References: <20170627092239.GE2479@mai>
 <1498555620-25094-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1498555620-25094-2-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Previously a framework to factor out the drivers init function has been
merged.

Use this common framework in this driver, we get:

Before:

text    data     bss     dec   hex filename
1787     384      12    2183   887 drivers/clocksource/sun4i_timer.o

After:

text    data     bss     dec   hex filename
1407     512       0    1919   77f drivers/clocksource/sun4i_timer.o

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Tested-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clocksource/Kconfig       |   1 +
 drivers/clocksource/sun4i_timer.c | 171 +++++++++++++++++---------------------
 2 files changed, 78 insertions(+), 94 deletions(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 4be163b..88818a4 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -108,6 +108,7 @@ config SUN4I_TIMER
 	depends on GENERIC_CLOCKEVENTS
 	depends on HAS_IOMEM
 	select CLKSRC_MMIO
+	select TIMER_OF
 	help
 	  Enables support for the Sun4i timer.
 
diff --git a/drivers/clocksource/sun4i_timer.c b/drivers/clocksource/sun4i_timer.c
index 3e4bc64..6e0180a 100644
--- a/drivers/clocksource/sun4i_timer.c
+++ b/drivers/clocksource/sun4i_timer.c
@@ -24,6 +24,8 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 
+#include "timer-of.h"
+
 #define TIMER_IRQ_EN_REG	0x00
 #define TIMER_IRQ_EN(val)		BIT(val)
 #define TIMER_IRQ_ST_REG	0x04
@@ -39,38 +41,37 @@
 
 #define TIMER_SYNC_TICKS	3
 
-static void __iomem *timer_base;
-static u32 ticks_per_jiffy;
-
 /*
  * When we disable a timer, we need to wait at least for 2 cycles of
  * the timer source clock. We will use for that the clocksource timer
  * that is already setup and runs at the same frequency than the other
  * timers, and we never will be disabled.
  */
-static void sun4i_clkevt_sync(void)
+static void sun4i_clkevt_sync(void __iomem *base)
 {
-	u32 old = readl(timer_base + TIMER_CNTVAL_REG(1));
+	u32 old = readl(base + TIMER_CNTVAL_REG(1));
 
-	while ((old - readl(timer_base + TIMER_CNTVAL_REG(1))) < TIMER_SYNC_TICKS)
+	while ((old - readl(base + TIMER_CNTVAL_REG(1))) < TIMER_SYNC_TICKS)
 		cpu_relax();
 }
 
-static void sun4i_clkevt_time_stop(u8 timer)
+static void sun4i_clkevt_time_stop(void __iomem *base, u8 timer)
 {
-	u32 val = readl(timer_base + TIMER_CTL_REG(timer));
-	writel(val & ~TIMER_CTL_ENABLE, timer_base + TIMER_CTL_REG(timer));
-	sun4i_clkevt_sync();
+	u32 val = readl(base + TIMER_CTL_REG(timer));
+	writel(val & ~TIMER_CTL_ENABLE, base + TIMER_CTL_REG(timer));
+	sun4i_clkevt_sync(base);
 }
 
-static void sun4i_clkevt_time_setup(u8 timer, unsigned long delay)
+static void sun4i_clkevt_time_setup(void __iomem *base, u8 timer,
+				    unsigned long delay)
 {
-	writel(delay, timer_base + TIMER_INTVAL_REG(timer));
+	writel(delay, base + TIMER_INTVAL_REG(timer));
 }
 
-static void sun4i_clkevt_time_start(u8 timer, bool periodic)
+static void sun4i_clkevt_time_start(void __iomem *base, u8 timer,
+				    bool periodic)
 {
-	u32 val = readl(timer_base + TIMER_CTL_REG(timer));
+	u32 val = readl(base + TIMER_CTL_REG(timer));
 
 	if (periodic)
 		val &= ~TIMER_CTL_ONESHOT;
@@ -78,115 +79,106 @@ static void sun4i_clkevt_time_start(u8 timer, bool periodic)
 		val |= TIMER_CTL_ONESHOT;
 
 	writel(val | TIMER_CTL_ENABLE | TIMER_CTL_RELOAD,
-	       timer_base + TIMER_CTL_REG(timer));
+	       base + TIMER_CTL_REG(timer));
 }
 
 static int sun4i_clkevt_shutdown(struct clock_event_device *evt)
 {
-	sun4i_clkevt_time_stop(0);
+	struct timer_of *to = to_timer_of(evt);
+
+	sun4i_clkevt_time_stop(timer_of_base(to), 0);
+
 	return 0;
 }
 
 static int sun4i_clkevt_set_oneshot(struct clock_event_device *evt)
 {
-	sun4i_clkevt_time_stop(0);
-	sun4i_clkevt_time_start(0, false);
+	struct timer_of *to = to_timer_of(evt);
+
+	sun4i_clkevt_time_stop(timer_of_base(to), 0);
+	sun4i_clkevt_time_start(timer_of_base(to), 0, false);
+
 	return 0;
 }
 
 static int sun4i_clkevt_set_periodic(struct clock_event_device *evt)
 {
-	sun4i_clkevt_time_stop(0);
-	sun4i_clkevt_time_setup(0, ticks_per_jiffy);
-	sun4i_clkevt_time_start(0, true);
+	struct timer_of *to = to_timer_of(evt);
+
+	sun4i_clkevt_time_stop(timer_of_base(to), 0);
+	sun4i_clkevt_time_setup(timer_of_base(to), 0, timer_of_period(to));
+	sun4i_clkevt_time_start(timer_of_base(to), 0, true);
+
 	return 0;
 }
 
 static int sun4i_clkevt_next_event(unsigned long evt,
-				   struct clock_event_device *unused)
+				   struct clock_event_device *clkevt)
 {
-	sun4i_clkevt_time_stop(0);
-	sun4i_clkevt_time_setup(0, evt - TIMER_SYNC_TICKS);
-	sun4i_clkevt_time_start(0, false);
+	struct timer_of *to = to_timer_of(clkevt);
+
+	sun4i_clkevt_time_stop(timer_of_base(to), 0);
+	sun4i_clkevt_time_setup(timer_of_base(to), 0, evt - TIMER_SYNC_TICKS);
+	sun4i_clkevt_time_start(timer_of_base(to), 0, false);
 
 	return 0;
 }
 
-static struct clock_event_device sun4i_clockevent = {
-	.name = "sun4i_tick",
-	.rating = 350,
-	.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
-	.set_state_shutdown = sun4i_clkevt_shutdown,
-	.set_state_periodic = sun4i_clkevt_set_periodic,
-	.set_state_oneshot = sun4i_clkevt_set_oneshot,
-	.tick_resume = sun4i_clkevt_shutdown,
-	.set_next_event = sun4i_clkevt_next_event,
-};
-
-static void sun4i_timer_clear_interrupt(void)
+static void sun4i_timer_clear_interrupt(void __iomem *base)
 {
-	writel(TIMER_IRQ_EN(0), timer_base + TIMER_IRQ_ST_REG);
+	writel(TIMER_IRQ_EN(0), base + TIMER_IRQ_ST_REG);
 }
 
 static irqreturn_t sun4i_timer_interrupt(int irq, void *dev_id)
 {
 	struct clock_event_device *evt = (struct clock_event_device *)dev_id;
+	struct timer_of *to = to_timer_of(evt);
 
-	sun4i_timer_clear_interrupt();
+	sun4i_timer_clear_interrupt(timer_of_base(to));
 	evt->event_handler(evt);
 
 	return IRQ_HANDLED;
 }
 
-static struct irqaction sun4i_timer_irq = {
-	.name = "sun4i_timer0",
-	.flags = IRQF_TIMER | IRQF_IRQPOLL,
-	.handler = sun4i_timer_interrupt,
-	.dev_id = &sun4i_clockevent,
+static struct timer_of to = {
+	.flags = TIMER_OF_IRQ | TIMER_OF_CLOCK | TIMER_OF_BASE,
+
+	.clkevt = {
+		.name = "sun4i_tick",
+		.rating = 350,
+		.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
+		.set_state_shutdown = sun4i_clkevt_shutdown,
+		.set_state_periodic = sun4i_clkevt_set_periodic,
+		.set_state_oneshot = sun4i_clkevt_set_oneshot,
+		.tick_resume = sun4i_clkevt_shutdown,
+		.set_next_event = sun4i_clkevt_next_event,
+		.cpumask = cpu_possible_mask,
+	},
+
+	.of_irq = {
+		.handler = sun4i_timer_interrupt,
+		.flags = IRQF_TIMER | IRQF_IRQPOLL,
+	},
 };
 
 static u64 notrace sun4i_timer_sched_read(void)
 {
-	return ~readl(timer_base + TIMER_CNTVAL_REG(1));
+	return ~readl(timer_of_base(&to) + TIMER_CNTVAL_REG(1));
 }
 
 static int __init sun4i_timer_init(struct device_node *node)
 {
-	unsigned long rate = 0;
-	struct clk *clk;
-	int ret, irq;
+	int ret;
 	u32 val;
 
-	timer_base = of_iomap(node, 0);
-	if (!timer_base) {
-		pr_crit("Can't map registers\n");
-		return -ENXIO;
-	}
-
-	irq = irq_of_parse_and_map(node, 0);
-	if (irq <= 0) {
-		pr_crit("Can't parse IRQ\n");
-		return -EINVAL;
-	}
-
-	clk = of_clk_get(node, 0);
-	if (IS_ERR(clk)) {
-		pr_crit("Can't get timer clock\n");
-		return PTR_ERR(clk);
-	}
-
-	ret = clk_prepare_enable(clk);
-	if (ret) {
-		pr_err("Failed to prepare clock\n");
+	ret = timer_of_init(node, &to);
+	if (ret)
 		return ret;
-	}
-
-	rate = clk_get_rate(clk);
 
-	writel(~0, timer_base + TIMER_INTVAL_REG(1));
+	writel(~0, timer_of_base(&to) + TIMER_INTVAL_REG(1));
 	writel(TIMER_CTL_ENABLE | TIMER_CTL_RELOAD |
 	       TIMER_CTL_CLK_SRC(TIMER_CTL_CLK_SRC_OSC24M),
-	       timer_base + TIMER_CTL_REG(1));
+	       timer_of_base(&to) + TIMER_CTL_REG(1));
 
 	/*
 	 * sched_clock_register does not have priorities, and on sun6i and
@@ -195,41 +187,32 @@ static int __init sun4i_timer_init(struct device_node *node)
 	if (of_machine_is_compatible("allwinner,sun4i-a10") ||
 	    of_machine_is_compatible("allwinner,sun5i-a13") ||
 	    of_machine_is_compatible("allwinner,sun5i-a10s"))
-		sched_clock_register(sun4i_timer_sched_read, 32, rate);
+		sched_clock_register(sun4i_timer_sched_read, 32,
+				     timer_of_rate(&to));
 
-	ret = clocksource_mmio_init(timer_base + TIMER_CNTVAL_REG(1), node->name,
-				    rate, 350, 32, clocksource_mmio_readl_down);
+	ret = clocksource_mmio_init(timer_of_base(&to) + TIMER_CNTVAL_REG(1),
+				    node->name, timer_of_rate(&to), 350, 32,
+				    clocksource_mmio_readl_down);
 	if (ret) {
 		pr_err("Failed to register clocksource\n");
 		return ret;
 	}
 
-	ticks_per_jiffy = DIV_ROUND_UP(rate, HZ);
-
 	writel(TIMER_CTL_CLK_SRC(TIMER_CTL_CLK_SRC_OSC24M),
-	       timer_base + TIMER_CTL_REG(0));
+	       timer_of_base(&to) + TIMER_CTL_REG(0));
 
 	/* Make sure timer is stopped before playing with interrupts */
-	sun4i_clkevt_time_stop(0);
+	sun4i_clkevt_time_stop(timer_of_base(&to), 0);
 
 	/* clear timer0 interrupt */
-	sun4i_timer_clear_interrupt();
-
-	sun4i_clockevent.cpumask = cpu_possible_mask;
-	sun4i_clockevent.irq = irq;
+	sun4i_timer_clear_interrupt(timer_of_base(&to));
 
-	clockevents_config_and_register(&sun4i_clockevent, rate,
+	clockevents_config_and_register(&to.clkevt, timer_of_rate(&to),
 					TIMER_SYNC_TICKS, 0xffffffff);
 
-	ret = setup_irq(irq, &sun4i_timer_irq);
-	if (ret) {
-		pr_err("failed to setup irq %d\n", irq);
-		return ret;
-	}
-
 	/* Enable timer0 interrupt */
-	val = readl(timer_base + TIMER_IRQ_EN_REG);
-	writel(val | TIMER_IRQ_EN(0), timer_base + TIMER_IRQ_EN_REG);
+	val = readl(timer_of_base(&to) + TIMER_IRQ_EN_REG);
+	writel(val | TIMER_IRQ_EN(0), timer_of_base(&to) + TIMER_IRQ_EN_REG);
 
 	return ret;
 }
-- 
2.7.4
