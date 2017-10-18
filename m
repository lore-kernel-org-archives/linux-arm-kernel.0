From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Wed, 18 Oct 2017 09:43:31 +0200
Subject: [PATCH v5 1/4] clocksource: stm32: convert driver to timer_of
In-Reply-To: <1508312614-27750-1-git-send-email-benjamin.gaignard@linaro.org>
References: <1508312614-27750-1-git-send-email-benjamin.gaignard@linaro.org>
Message-ID: <1508312614-27750-2-git-send-email-benjamin.gaignard@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert driver to use timer_of helpers. This allow to remove
custom proprietary structure.

Increase min delta value because if it is too small it could
generate too much interrupts and the system will not be able
to catch them all.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
---
 drivers/clocksource/Kconfig       |   1 +
 drivers/clocksource/timer-stm32.c | 162 +++++++++++++-------------------------
 2 files changed, 57 insertions(+), 106 deletions(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index cc60620..755c0cc 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -289,6 +289,7 @@ config CLKSRC_STM32
 	bool "Clocksource for STM32 SoCs" if !ARCH_STM32
 	depends on OF && ARM && (ARCH_STM32 || COMPILE_TEST)
 	select CLKSRC_MMIO
+	select TIMER_OF
 
 config CLKSRC_MPS2
 	bool "Clocksource for MPS2 SoCs" if COMPILE_TEST
diff --git a/drivers/clocksource/timer-stm32.c b/drivers/clocksource/timer-stm32.c
index 8f24237..abff21c 100644
--- a/drivers/clocksource/timer-stm32.c
+++ b/drivers/clocksource/timer-stm32.c
@@ -17,6 +17,8 @@
 #include <linux/clk.h>
 #include <linux/reset.h>
 
+#include "timer-of.h"
+
 #define TIM_CR1		0x00
 #define TIM_DIER	0x0c
 #define TIM_SR		0x10
@@ -34,117 +36,84 @@
 
 #define TIM_EGR_UG	BIT(0)
 
-struct stm32_clock_event_ddata {
-	struct clock_event_device evtdev;
-	unsigned periodic_top;
-	void __iomem *base;
-};
-
-static int stm32_clock_event_shutdown(struct clock_event_device *evtdev)
+static int stm32_clock_event_shutdown(struct clock_event_device *evt)
 {
-	struct stm32_clock_event_ddata *data =
-		container_of(evtdev, struct stm32_clock_event_ddata, evtdev);
-	void *base = data->base;
+	struct timer_of *to = to_timer_of(evt);
 
-	writel_relaxed(0, base + TIM_CR1);
+	writel_relaxed(0, timer_of_base(to) + TIM_CR1);
 	return 0;
 }
 
-static int stm32_clock_event_set_periodic(struct clock_event_device *evtdev)
+static int stm32_clock_event_set_periodic(struct clock_event_device *evt)
 {
-	struct stm32_clock_event_ddata *data =
-		container_of(evtdev, struct stm32_clock_event_ddata, evtdev);
-	void *base = data->base;
+	struct timer_of *to = to_timer_of(evt);
+
+	writel_relaxed(timer_of_period(to), timer_of_base(to) + TIM_ARR);
+	writel_relaxed(TIM_CR1_ARPE | TIM_CR1_CEN, timer_of_base(to) + TIM_CR1);
 
-	writel_relaxed(data->periodic_top, base + TIM_ARR);
-	writel_relaxed(TIM_CR1_ARPE | TIM_CR1_CEN, base + TIM_CR1);
 	return 0;
 }
 
 static int stm32_clock_event_set_next_event(unsigned long evt,
-					    struct clock_event_device *evtdev)
+					    struct clock_event_device *clkevt)
 {
-	struct stm32_clock_event_ddata *data =
-		container_of(evtdev, struct stm32_clock_event_ddata, evtdev);
+	struct timer_of *to = to_timer_of(clkevt);
 
-	writel_relaxed(evt, data->base + TIM_ARR);
+	writel_relaxed(evt, timer_of_base(to) + TIM_ARR);
 	writel_relaxed(TIM_CR1_ARPE | TIM_CR1_OPM | TIM_CR1_CEN,
-		       data->base + TIM_CR1);
+		       timer_of_base(to) + TIM_CR1);
 
 	return 0;
 }
 
 static irqreturn_t stm32_clock_event_handler(int irq, void *dev_id)
 {
-	struct stm32_clock_event_ddata *data = dev_id;
+	struct clock_event_device *evt = (struct clock_event_device *)dev_id;
+	struct timer_of *to = to_timer_of(evt);
 
-	writel_relaxed(0, data->base + TIM_SR);
+	writel_relaxed(0, timer_of_base(to) + TIM_SR);
 
-	data->evtdev.event_handler(&data->evtdev);
+	evt->event_handler(evt);
 
 	return IRQ_HANDLED;
 }
 
-static struct stm32_clock_event_ddata clock_event_ddata = {
-	.evtdev = {
-		.name = "stm32 clockevent",
-		.features = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC,
-		.set_state_shutdown = stm32_clock_event_shutdown,
-		.set_state_periodic = stm32_clock_event_set_periodic,
-		.set_state_oneshot = stm32_clock_event_shutdown,
-		.tick_resume = stm32_clock_event_shutdown,
-		.set_next_event = stm32_clock_event_set_next_event,
-		.rating = 200,
-	},
-};
-
-static int __init stm32_clockevent_init(struct device_node *np)
+static int __init stm32_clockevent_init(struct device_node *node)
 {
-	struct stm32_clock_event_ddata *data = &clock_event_ddata;
-	struct clk *clk;
 	struct reset_control *rstc;
-	unsigned long rate, max_delta;
-	int irq, ret, bits, prescaler = 1;
-
-	clk = of_clk_get(np, 0);
-	if (IS_ERR(clk)) {
-		ret = PTR_ERR(clk);
-		pr_err("failed to get clock for clockevent (%d)\n", ret);
-		goto err_clk_get;
-	}
-
-	ret = clk_prepare_enable(clk);
-	if (ret) {
-		pr_err("failed to enable timer clock for clockevent (%d)\n",
-		       ret);
-		goto err_clk_enable;
-	}
-
-	rate = clk_get_rate(clk);
-
-	rstc = of_reset_control_get(np, NULL);
+	unsigned long max_delta;
+	int ret, bits, prescaler = 1;
+	struct timer_of *to;
+
+	to = kzalloc(sizeof(*to), GFP_KERNEL);
+	if (!to)
+		return -ENOMEM;
+
+	to->flags = TIMER_OF_IRQ | TIMER_OF_CLOCK | TIMER_OF_BASE;
+	to->clkevt.name = "stm32_clockevent";
+	to->clkevt.rating = 200;
+	to->clkevt.features = CLOCK_EVT_FEAT_PERIODIC;
+	to->clkevt.set_state_shutdown = stm32_clock_event_shutdown;
+	to->clkevt.set_state_periodic = stm32_clock_event_set_periodic;
+	to->clkevt.set_state_oneshot = stm32_clock_event_shutdown;
+	to->clkevt.tick_resume = stm32_clock_event_shutdown;
+	to->clkevt.set_next_event = stm32_clock_event_set_next_event;
+
+	to->of_irq.handler = stm32_clock_event_handler;
+
+	ret = timer_of_init(node, to);
+	if (ret)
+		return ret;
+
+	rstc = of_reset_control_get(node, NULL);
 	if (!IS_ERR(rstc)) {
 		reset_control_assert(rstc);
 		reset_control_deassert(rstc);
 	}
 
-	data->base = of_iomap(np, 0);
-	if (!data->base) {
-		ret = -ENXIO;
-		pr_err("failed to map registers for clockevent\n");
-		goto err_iomap;
-	}
-
-	irq = irq_of_parse_and_map(np, 0);
-	if (!irq) {
-		ret = -EINVAL;
-		pr_err("%pOF: failed to get irq.\n", np);
-		goto err_get_irq;
-	}
-
 	/* Detect whether the timer is 16 or 32 bits */
-	writel_relaxed(~0U, data->base + TIM_ARR);
-	max_delta = readl_relaxed(data->base + TIM_ARR);
+	writel_relaxed(~0U, timer_of_base(to) + TIM_ARR);
+	max_delta = readl_relaxed(timer_of_base(to) + TIM_ARR);
 	if (max_delta == ~0U) {
 		prescaler = 1;
 		bits = 32;
@@ -152,39 +121,20 @@ static int __init stm32_clockevent_init(struct device_node *np)
 		prescaler = 1024;
 		bits = 16;
 	}
-	writel_relaxed(0, data->base + TIM_ARR);
-
-	writel_relaxed(prescaler - 1, data->base + TIM_PSC);
-	writel_relaxed(TIM_EGR_UG, data->base + TIM_EGR);
-	writel_relaxed(TIM_DIER_UIE, data->base + TIM_DIER);
-	writel_relaxed(0, data->base + TIM_SR);
+	writel_relaxed(0, timer_of_base(to) + TIM_ARR);
 
-	data->periodic_top = DIV_ROUND_CLOSEST(rate, prescaler * HZ);
+	writel_relaxed(prescaler - 1, timer_of_base(to) + TIM_PSC);
+	writel_relaxed(TIM_EGR_UG, timer_of_base(to) + TIM_EGR);
+	writel_relaxed(TIM_DIER_UIE, timer_of_base(to) + TIM_DIER);
+	writel_relaxed(0, timer_of_base(to) + TIM_SR);
 
-	clockevents_config_and_register(&data->evtdev,
-					DIV_ROUND_CLOSEST(rate, prescaler),
-					0x1, max_delta);
-
-	ret = request_irq(irq, stm32_clock_event_handler, IRQF_TIMER,
-			"stm32 clockevent", data);
-	if (ret) {
-		pr_err("%pOF: failed to request irq.\n", np);
-		goto err_get_irq;
-	}
+	clockevents_config_and_register(&to->clkevt,
+					timer_of_period(to), 0x60, max_delta);
 
 	pr_info("%pOF: STM32 clockevent driver initialized (%d bits)\n",
-			np, bits);
-
-	return ret;
-
-err_get_irq:
-	iounmap(data->base);
-err_iomap:
-	clk_disable_unprepare(clk);
-err_clk_enable:
-	clk_put(clk);
-err_clk_get:
-	return ret;
+			node, bits);
+
+	return 0;
 }
 
 TIMER_OF_DECLARE(stm32, "st,stm32-timer", stm32_clockevent_init);
-- 
2.7.4
