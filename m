From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Mon, 18 Sep 2017 11:02:14 +0200
Subject: [PATCH v2 1/2] clocksource: stm32: rework driver to use only one timer
In-Reply-To: <1505725335-27081-1-git-send-email-benjamin.gaignard@linaro.org>
References: <1505725335-27081-1-git-send-email-benjamin.gaignard@linaro.org>
Message-ID: <1505725335-27081-2-git-send-email-benjamin.gaignard@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rework driver code to use only one timer for both clocksource
and clockevent.
This patch also forbid to use 16 bits timers because they are
not enough accurate.
Do some clean up in structure and functions names too.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/clocksource/timer-stm32.c | 259 +++++++++++++++++++++++---------------
 1 file changed, 155 insertions(+), 104 deletions(-)

diff --git a/drivers/clocksource/timer-stm32.c b/drivers/clocksource/timer-stm32.c
index 8f24237..e517e24 100644
--- a/drivers/clocksource/timer-stm32.c
+++ b/drivers/clocksource/timer-stm32.c
@@ -16,175 +16,226 @@
 #include <linux/of_irq.h>
 #include <linux/clk.h>
 #include <linux/reset.h>
+#include <linux/sched_clock.h>
+#include <linux/slab.h>
 
 #define TIM_CR1		0x00
 #define TIM_DIER	0x0c
 #define TIM_SR		0x10
 #define TIM_EGR		0x14
+#define TIM_CNT		0x24
 #define TIM_PSC		0x28
 #define TIM_ARR		0x2c
+#define TIM_CCR1	0x34
 
 #define TIM_CR1_CEN	BIT(0)
-#define TIM_CR1_OPM	BIT(3)
+#define TIM_CR1_UDIS	BIT(1)
 #define TIM_CR1_ARPE	BIT(7)
 
-#define TIM_DIER_UIE	BIT(0)
-
-#define TIM_SR_UIF	BIT(0)
+#define TIM_DIER_CC1IE	BIT(1)
 
 #define TIM_EGR_UG	BIT(0)
 
-struct stm32_clock_event_ddata {
+struct stm32_clock_event {
 	struct clock_event_device evtdev;
 	unsigned periodic_top;
-	void __iomem *base;
+	void __iomem *regs;
 };
 
 static int stm32_clock_event_shutdown(struct clock_event_device *evtdev)
 {
-	struct stm32_clock_event_ddata *data =
-		container_of(evtdev, struct stm32_clock_event_ddata, evtdev);
-	void *base = data->base;
+	struct stm32_clock_event *ce =
+		container_of(evtdev, struct stm32_clock_event, evtdev);
+
+	writel_relaxed(0, ce->regs + TIM_DIER);
 
-	writel_relaxed(0, base + TIM_CR1);
 	return 0;
 }
 
-static int stm32_clock_event_set_periodic(struct clock_event_device *evtdev)
+static int stm32_clock_event_set_next_event(unsigned long evt,
+					    struct clock_event_device *evtdev)
 {
-	struct stm32_clock_event_ddata *data =
-		container_of(evtdev, struct stm32_clock_event_ddata, evtdev);
-	void *base = data->base;
+	struct stm32_clock_event *ce =
+		container_of(evtdev, struct stm32_clock_event, evtdev);
+	unsigned long cnt;
+
+	cnt = readl_relaxed(ce->regs + TIM_CNT);
+	writel_relaxed(cnt + evt, ce->regs + TIM_CCR1);
+	writel_relaxed(TIM_DIER_CC1IE, ce->regs + TIM_DIER);
 
-	writel_relaxed(data->periodic_top, base + TIM_ARR);
-	writel_relaxed(TIM_CR1_ARPE | TIM_CR1_CEN, base + TIM_CR1);
 	return 0;
 }
 
-static int stm32_clock_event_set_next_event(unsigned long evt,
-					    struct clock_event_device *evtdev)
+static int stm32_clock_event_set_periodic(struct clock_event_device *evtdev)
 {
-	struct stm32_clock_event_ddata *data =
-		container_of(evtdev, struct stm32_clock_event_ddata, evtdev);
+	struct stm32_clock_event *ce =
+		container_of(evtdev, struct stm32_clock_event, evtdev);
 
-	writel_relaxed(evt, data->base + TIM_ARR);
-	writel_relaxed(TIM_CR1_ARPE | TIM_CR1_OPM | TIM_CR1_CEN,
-		       data->base + TIM_CR1);
+	return stm32_clock_event_set_next_event(ce->periodic_top, evtdev);
+}
 
-	return 0;
+static int stm32_clock_event_set_oneshot(struct clock_event_device *evtdev)
+{
+	return stm32_clock_event_set_next_event(0, evtdev);
 }
 
 static irqreturn_t stm32_clock_event_handler(int irq, void *dev_id)
 {
-	struct stm32_clock_event_ddata *data = dev_id;
+	struct stm32_clock_event *ce = dev_id;
+
+	writel_relaxed(0, ce->regs + TIM_SR);
 
-	writel_relaxed(0, data->base + TIM_SR);
+	if (clockevent_state_periodic(&ce->evtdev))
+		stm32_clock_event_set_periodic(&ce->evtdev);
 
-	data->evtdev.event_handler(&data->evtdev);
+	if (clockevent_state_oneshot(&ce->evtdev))
+		stm32_clock_event_shutdown(&ce->evtdev);
+
+	ce->evtdev.event_handler(&ce->evtdev);
 
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
+static int __init stm32_clockevent_init(struct device_node *np,
+					void __iomem *base,
+					struct clk *clk, int irq)
+{
+	struct stm32_clock_event *ce;
+	unsigned long rate;
+	int err;
+
+	ce = kzalloc(sizeof(*ce), GFP_KERNEL);
+	if (!ce)
+		return -ENOMEM;
+
+	ce->regs = base;
+	ce->evtdev.name = "stm32_clockevent";
+	ce->evtdev.features = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC;
+	ce->evtdev.set_state_shutdown = stm32_clock_event_shutdown;
+	ce->evtdev.set_state_periodic = stm32_clock_event_set_periodic;
+	ce->evtdev.set_state_oneshot = stm32_clock_event_set_oneshot;
+	ce->evtdev.tick_resume = stm32_clock_event_shutdown;
+	ce->evtdev.set_next_event = stm32_clock_event_set_next_event;
+	ce->evtdev.rating = 200;
 
-static int __init stm32_clockevent_init(struct device_node *np)
+	rate = clk_get_rate(clk);
+	ce->periodic_top = DIV_ROUND_CLOSEST(rate, HZ);
+
+	writel_relaxed(0, ce->regs + TIM_DIER);
+	writel_relaxed(0, ce->regs + TIM_SR);
+
+	err = request_irq(irq, stm32_clock_event_handler, IRQF_TIMER,
+			  "stm32 clockevent", ce);
+	if (err) {
+		kfree(ce);
+		return err;
+	}
+
+	clockevents_config_and_register(&ce->evtdev, rate, 0x60, ~0U);
+
+	return 0;
+}
+
+static void __iomem *stm32_timer_cnt __read_mostly;
+static u64 notrace stm32_read_sched_clock(void)
+{
+	return readl_relaxed(stm32_timer_cnt);
+}
+
+static int __init stm32_clocksource_init(struct device_node *node,
+					 void __iomem *regs,
+					 struct clk *clk)
+{
+	unsigned long rate;
+
+	rate = clk_get_rate(clk);
+
+	writel_relaxed(~0U, regs + TIM_ARR);
+	writel_relaxed(0, regs + TIM_PSC);
+	writel_relaxed(0, regs + TIM_SR);
+	writel_relaxed(0, regs + TIM_DIER);
+	writel_relaxed(0, regs + TIM_SR);
+	writel_relaxed(TIM_CR1_ARPE | TIM_CR1_UDIS, regs + TIM_CR1);
+
+	/* Make sure that registers are updated */
+	writel_relaxed(TIM_EGR_UG, regs + TIM_EGR);
+
+	/* Enable controller */
+	writel_relaxed(TIM_CR1_ARPE | TIM_CR1_UDIS | TIM_CR1_CEN,
+		       regs + TIM_CR1);
+
+	stm32_timer_cnt = regs + TIM_CNT;
+	sched_clock_register(stm32_read_sched_clock, 32, rate);
+
+	return clocksource_mmio_init(stm32_timer_cnt, "stm32_timer",
+				     rate, 250, 32, clocksource_mmio_readl_up);
+}
+
+static int __init stm32_timer_init(struct device_node *node)
 {
-	struct stm32_clock_event_ddata *data = &clock_event_ddata;
-	struct clk *clk;
 	struct reset_control *rstc;
-	unsigned long rate, max_delta;
-	int irq, ret, bits, prescaler = 1;
+	void __iomem *timer_base;
+	unsigned long max_arr;
+	struct clk *clk;
+	int irq, err = -EINVAL;
 
-	clk = of_clk_get(np, 0);
-	if (IS_ERR(clk)) {
-		ret = PTR_ERR(clk);
-		pr_err("failed to get clock for clockevent (%d)\n", ret);
-		goto err_clk_get;
+	timer_base = of_io_request_and_map(node, 0, of_node_full_name(node));
+	if (IS_ERR(timer_base)) {
+		pr_err("Can't map registers\n");
+		goto out;
 	}
 
-	ret = clk_prepare_enable(clk);
-	if (ret) {
-		pr_err("failed to enable timer clock for clockevent (%d)\n",
-		       ret);
-		goto err_clk_enable;
+	irq = irq_of_parse_and_map(node, 0);
+	if (irq <= 0) {
+		pr_err("Can't parse IRQ\n");
+		goto out_unmap;
 	}
 
-	rate = clk_get_rate(clk);
+	clk = of_clk_get(node, 0);
+	if (IS_ERR(clk)) {
+		pr_err("Can't get timer clock\n");
+		goto out_unmap;
+	}
 
-	rstc = of_reset_control_get(np, NULL);
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
+	err = clk_prepare_enable(clk);
+	if (err) {
+		pr_err("Couldn't enable parent clock\n");
+		goto out_clk;
 	}
 
 	/* Detect whether the timer is 16 or 32 bits */
-	writel_relaxed(~0U, data->base + TIM_ARR);
-	max_delta = readl_relaxed(data->base + TIM_ARR);
-	if (max_delta == ~0U) {
-		prescaler = 1;
-		bits = 32;
-	} else {
-		prescaler = 1024;
-		bits = 16;
+	writel_relaxed(~0U, timer_base + TIM_ARR);
+	max_arr = readl_relaxed(timer_base + TIM_ARR);
+	if (max_arr != ~0U) {
+		err = -EINVAL;
+		pr_err("32 bits timer is needed\n");
+		goto out_unprepare;
 	}
-	writel_relaxed(0, data->base + TIM_ARR);
-
-	writel_relaxed(prescaler - 1, data->base + TIM_PSC);
-	writel_relaxed(TIM_EGR_UG, data->base + TIM_EGR);
-	writel_relaxed(TIM_DIER_UIE, data->base + TIM_DIER);
-	writel_relaxed(0, data->base + TIM_SR);
-
-	data->periodic_top = DIV_ROUND_CLOSEST(rate, prescaler * HZ);
 
-	clockevents_config_and_register(&data->evtdev,
-					DIV_ROUND_CLOSEST(rate, prescaler),
-					0x1, max_delta);
+	err = stm32_clocksource_init(node, timer_base, clk);
+	if (err)
+		goto out_unprepare;
 
-	ret = request_irq(irq, stm32_clock_event_handler, IRQF_TIMER,
-			"stm32 clockevent", data);
-	if (ret) {
-		pr_err("%pOF: failed to request irq.\n", np);
-		goto err_get_irq;
-	}
-
-	pr_info("%pOF: STM32 clockevent driver initialized (%d bits)\n",
-			np, bits);
+	err = stm32_clockevent_init(node, timer_base, clk, irq);
+	if (err)
+		goto out_unprepare;
 
-	return ret;
+	return 0;
 
-err_get_irq:
-	iounmap(data->base);
-err_iomap:
+out_unprepare:
 	clk_disable_unprepare(clk);
-err_clk_enable:
+out_clk:
 	clk_put(clk);
-err_clk_get:
-	return ret;
+out_unmap:
+	iounmap(timer_base);
+out:
+	return err;
 }
 
-TIMER_OF_DECLARE(stm32, "st,stm32-timer", stm32_clockevent_init);
+CLOCKSOURCE_OF_DECLARE(stm32, "st,stm32-timer", stm32_timer_init);
-- 
2.7.4
