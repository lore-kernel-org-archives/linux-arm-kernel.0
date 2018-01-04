From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu,  4 Jan 2018 13:50:20 +0100
Subject: [PATCH 04/12] clocksource/drivers/stm32: Convert the driver to
 timer-of
In-Reply-To: <1515070228-10481-1-git-send-email-daniel.lezcano@linaro.org>
References: <1515070228-10481-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1515070228-10481-5-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Benjamin Gaignard <benjamin.gaignard@st.com>

Convert the driver to use the timer_of helpers. This allows to remove custom
proprietary structure, factors out and simplifies the code.

[Daniel Lezcano] : Respin against the critical fix patch and massaged the
		   changelog.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig       |   1 +
 drivers/clocksource/timer-stm32.c | 187 +++++++++++++++-----------------------
 2 files changed, 74 insertions(+), 114 deletions(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 9a6b087..786db7a 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -269,6 +269,7 @@ config CLKSRC_STM32
 	bool "Clocksource for STM32 SoCs" if !ARCH_STM32
 	depends on OF && ARM && (ARCH_STM32 || COMPILE_TEST)
 	select CLKSRC_MMIO
+	select TIMER_OF
 
 config CLKSRC_MPS2
 	bool "Clocksource for MPS2 SoCs" if COMPILE_TEST
diff --git a/drivers/clocksource/timer-stm32.c b/drivers/clocksource/timer-stm32.c
index 4bfeb99..3e4ab07 100644
--- a/drivers/clocksource/timer-stm32.c
+++ b/drivers/clocksource/timer-stm32.c
@@ -16,6 +16,9 @@
 #include <linux/of_irq.h>
 #include <linux/clk.h>
 #include <linux/reset.h>
+#include <linux/slab.h>
+
+#include "timer-of.h"
 
 #define TIM_CR1		0x00
 #define TIM_DIER	0x0c
@@ -34,162 +37,118 @@
 
 #define TIM_EGR_UG	BIT(0)
 
-struct stm32_clock_event_ddata {
-	struct clock_event_device evtdev;
-	unsigned periodic_top;
-	void __iomem *base;
-};
-
-static int stm32_clock_event_shutdown(struct clock_event_device *evtdev)
+static int stm32_clock_event_shutdown(struct clock_event_device *clkevt)
 {
-	struct stm32_clock_event_ddata *data =
-		container_of(evtdev, struct stm32_clock_event_ddata, evtdev);
-	void *base = data->base;
+	struct timer_of *to = to_timer_of(clkevt);
+
+	writel_relaxed(0, timer_of_base(to) + TIM_CR1);
 
-	writel_relaxed(0, base + TIM_CR1);
 	return 0;
 }
 
-static int stm32_clock_event_set_periodic(struct clock_event_device *evtdev)
+static int stm32_clock_event_set_periodic(struct clock_event_device *clkevt)
 {
-	struct stm32_clock_event_ddata *data =
-		container_of(evtdev, struct stm32_clock_event_ddata, evtdev);
-	void *base = data->base;
+	struct timer_of *to = to_timer_of(clkevt);
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
+	struct clock_event_device *clkevt = (struct clock_event_device *)dev_id;
+	struct timer_of *to = to_timer_of(clkevt);
 
-	writel_relaxed(0, data->base + TIM_SR);
+	writel_relaxed(0, timer_of_base(to) + TIM_SR);
 
-	data->evtdev.event_handler(&data->evtdev);
+	clkevt->event_handler(clkevt);
 
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
+static void __init stm32_clockevent_init(struct timer_of *to)
 {
-	struct stm32_clock_event_ddata *data = &clock_event_ddata;
-	struct clk *clk;
-	struct reset_control *rstc;
-	unsigned long rate, max_delta;
-	int irq, ret, bits, prescaler = 1;
-
-	data = kmemdup(&clock_event_ddata, sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
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
-	if (!IS_ERR(rstc)) {
-		reset_control_assert(rstc);
-		reset_control_deassert(rstc);
-	}
-
-	data->base = of_iomap(np, 0);
-	if (!data->base) {
-		ret = -ENXIO;
-		pr_err("failed to map registers for clockevent\n");
-		goto err_iomap;
-	}
+	unsigned long max_delta;
+	int prescaler;
 
-	irq = irq_of_parse_and_map(np, 0);
-	if (!irq) {
-		ret = -EINVAL;
-		pr_err("%pOF: failed to get irq.\n", np);
-		goto err_get_irq;
-	}
+	to->clkevt.name = "stm32_clockevent";
+	to->clkevt.features = CLOCK_EVT_FEAT_PERIODIC;
+	to->clkevt.set_state_shutdown = stm32_clock_event_shutdown;
+	to->clkevt.set_state_periodic = stm32_clock_event_set_periodic;
+	to->clkevt.set_state_oneshot = stm32_clock_event_shutdown;
+	to->clkevt.tick_resume = stm32_clock_event_shutdown;
+	to->clkevt.set_next_event = stm32_clock_event_set_next_event;
 
 	/* Detect whether the timer is 16 or 32 bits */
-	writel_relaxed(~0U, data->base + TIM_ARR);
-	max_delta = readl_relaxed(data->base + TIM_ARR);
+	writel_relaxed(~0U, timer_of_base(to) + TIM_ARR);
+	max_delta = readl_relaxed(timer_of_base(to) + TIM_ARR);
 	if (max_delta == ~0U) {
 		prescaler = 1;
-		bits = 32;
+		to->clkevt.rating = 250;
 	} else {
 		prescaler = 1024;
-		bits = 16;
+		to->clkevt.rating = 100;
 	}
-	writel_relaxed(0, data->base + TIM_ARR);
+	writel_relaxed(0, timer_of_base(to) + TIM_ARR);
 
-	writel_relaxed(prescaler - 1, data->base + TIM_PSC);
-	writel_relaxed(TIM_EGR_UG, data->base + TIM_EGR);
-	writel_relaxed(0, data->base + TIM_SR);
-	writel_relaxed(TIM_DIER_UIE, data->base + TIM_DIER);
+	writel_relaxed(prescaler - 1, timer_of_base(to) + TIM_PSC);
+	writel_relaxed(TIM_EGR_UG, timer_of_base(to) + TIM_EGR);
+	writel_relaxed(0, timer_of_base(to) + TIM_SR);
+	writel_relaxed(TIM_DIER_UIE, timer_of_base(to) + TIM_DIER);
 
-	data->periodic_top = DIV_ROUND_CLOSEST(rate, prescaler * HZ);
+	/* Adjust rate and period given the prescaler value */
+	to->of_clk.rate = DIV_ROUND_CLOSEST(to->of_clk.rate, prescaler);
+	to->of_clk.period = DIV_ROUND_UP(to->of_clk.rate, HZ);
 
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
+					timer_of_rate(to), 0x1, max_delta);
 
 	pr_info("%pOF: STM32 clockevent driver initialized (%d bits)\n",
-			np, bits);
+		to->np, max_delta == UINT_MAX ? 32 : 16);
+}
 
-	return ret;
+static int __init stm32_timer_init(struct device_node *node)
+{
+	struct reset_control *rstc;
+	struct timer_of *to;
+	int ret;
+
+	to = kzalloc(sizeof(*to), GFP_KERNEL);
+	if (!to)
+		return -ENOMEM;
+
+	to->flags = TIMER_OF_IRQ | TIMER_OF_CLOCK | TIMER_OF_BASE;
+	to->of_irq.handler = stm32_clock_event_handler;
+
+	ret = timer_of_init(node, to);
+	if (ret)
+		goto err;
 
-err_get_irq:
-	iounmap(data->base);
-err_iomap:
-	clk_disable_unprepare(clk);
-err_clk_enable:
-	clk_put(clk);
-err_clk_get:
-	kfree(data);
+	rstc = of_reset_control_get(node, NULL);
+	if (!IS_ERR(rstc)) {
+		reset_control_assert(rstc);
+		reset_control_deassert(rstc);
+	}
+
+	stm32_clockevent_init(to);
+	return 0;
+err:
+	kfree(to);
 	return ret;
 }
 
-TIMER_OF_DECLARE(stm32, "st,stm32-timer", stm32_clockevent_init);
+TIMER_OF_DECLARE(stm32, "st,stm32-timer", stm32_timer_init);
-- 
2.7.4
