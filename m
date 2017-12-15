From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Fri, 15 Dec 2017 09:52:46 +0100
Subject: [PATCH 3/4] clocksource: stm32: add clocksource support
In-Reply-To: <20171215085247.14946-1-benjamin.gaignard@st.com>
References: <20171215085247.14946-1-benjamin.gaignard@st.com>
Message-ID: <20171215085247.14946-4-benjamin.gaignard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The stm32 timer hardware is currently only used as a clock event device,
but it can be used as a clocksource as well.

Implement this by enabling the free running counter in the hardware block
and converting the clock event part from a count down event timer to a
comparator based timer.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/clocksource/timer-stm32.c | 114 ++++++++++++++++++++++++++++----------
 1 file changed, 86 insertions(+), 28 deletions(-)

diff --git a/drivers/clocksource/timer-stm32.c b/drivers/clocksource/timer-stm32.c
index de721d318065..38eb59bb7f8a 100644
--- a/drivers/clocksource/timer-stm32.c
+++ b/drivers/clocksource/timer-stm32.c
@@ -16,6 +16,7 @@
 #include <linux/of_irq.h>
 #include <linux/clk.h>
 #include <linux/reset.h>
+#include <linux/sched_clock.h>
 #include <linux/slab.h>
 
 #include "timer-of.h"
@@ -24,17 +25,15 @@
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
-
-#define TIM_DIER_UIE	BIT(0)
-
-#define TIM_SR_UIF	BIT(0)
-
+#define TIM_DIER_CC1IE	BIT(1)
 #define TIM_EGR_UG	BIT(0)
 
 #define MAX_TIM_PSC	0xFFFF
@@ -46,29 +45,44 @@ static int stm32_clock_event_shutdown(struct clock_event_device *evt)
 {
 	struct timer_of *to = to_timer_of(evt);
 
-	writel_relaxed(0, timer_of_base(to) + TIM_CR1);
+	writel_relaxed(0, timer_of_base(to) + TIM_DIER);
 
 	return 0;
 }
 
-static int stm32_clock_event_set_periodic(struct clock_event_device *evt)
+static int stm32_clock_event_set_next_event(unsigned long evt,
+					    struct clock_event_device *clkevt)
 {
-	struct timer_of *to = to_timer_of(evt);
+	struct timer_of *to = to_timer_of(clkevt);
+	unsigned long now, next;
+
+	next = readl_relaxed(timer_of_base(to) + TIM_CNT) + evt;
+	writel_relaxed(next, timer_of_base(to) + TIM_CCR1);
+	now = readl_relaxed(timer_of_base(to) + TIM_CNT);
+
+	if ((next - now) > evt)
+		return -ETIME;
 
-	writel_relaxed(timer_of_period(to), timer_of_base(to) + TIM_ARR);
-	writel_relaxed(TIM_CR1_ARPE | TIM_CR1_CEN, timer_of_base(to) + TIM_CR1);
+	writel_relaxed(TIM_DIER_CC1IE, timer_of_base(to) + TIM_DIER);
 
 	return 0;
 }
 
-static int stm32_clock_event_set_next_event(unsigned long evt,
-					    struct clock_event_device *clkevt)
+static int stm32_clock_event_set_periodic(struct clock_event_device *evt)
 {
-	struct timer_of *to = to_timer_of(clkevt);
+	struct timer_of *to = to_timer_of(evt);
 
-	writel_relaxed(evt, timer_of_base(to) + TIM_ARR);
-	writel_relaxed(TIM_CR1_ARPE | TIM_CR1_OPM | TIM_CR1_CEN,
-		       timer_of_base(to) + TIM_CR1);
+	return stm32_clock_event_set_next_event(timer_of_period(to), evt);
+}
+
+static int stm32_clock_event_set_oneshot(struct clock_event_device *evt)
+{
+	struct timer_of *to = to_timer_of(evt);
+	unsigned long val;
+
+	val = readl_relaxed(timer_of_base(to) + TIM_CNT);
+	writel_relaxed(val, timer_of_base(to) + TIM_CCR1);
+	writel_relaxed(TIM_DIER_CC1IE, timer_of_base(to) + TIM_DIER);
 
 	return 0;
 }
@@ -80,6 +94,11 @@ static irqreturn_t stm32_clock_event_handler(int irq, void *dev_id)
 
 	writel_relaxed(0, timer_of_base(to) + TIM_SR);
 
+	if (clockevent_state_periodic(evt))
+		stm32_clock_event_set_periodic(evt);
+	else
+		stm32_clock_event_shutdown(evt);
+
 	evt->event_handler(evt);
 
 	return IRQ_HANDLED;
@@ -88,22 +107,46 @@ static irqreturn_t stm32_clock_event_handler(int irq, void *dev_id)
 static void __init stm32_clockevent_init(struct timer_of *to)
 {
 	unsigned long max_delta;
-	unsigned long prescaler;
 
 	to->clkevt.name = "stm32_clockevent";
-	to->clkevt.features = CLOCK_EVT_FEAT_PERIODIC;
+	to->clkevt.features = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC;
 	to->clkevt.set_state_shutdown = stm32_clock_event_shutdown;
 	to->clkevt.set_state_periodic = stm32_clock_event_set_periodic;
-	to->clkevt.set_state_oneshot = stm32_clock_event_shutdown;
+	to->clkevt.set_state_oneshot = stm32_clock_event_set_oneshot;
 	to->clkevt.tick_resume = stm32_clock_event_shutdown;
 	to->clkevt.set_next_event = stm32_clock_event_set_next_event;
 
 	/* Detect whether the timer is 16 or 32 bits */
+	max_delta = readl_relaxed(timer_of_base(to) + TIM_ARR);
+
+	clockevents_config_and_register(&to->clkevt,
+					timer_of_rate(to), 0x1, max_delta);
+}
+
+static void __iomem *stm32_timer_cnt __read_mostly;
+
+static u64 notrace stm32_read_sched_clock(void)
+{
+	return readl_relaxed(stm32_timer_cnt);
+}
+
+static int __init stm32_clocksource_init(struct timer_of *to)
+{
+	unsigned long max_delta, prescaler;
+	int bits = 16;
+
 	writel_relaxed(~0U, timer_of_base(to) + TIM_ARR);
+	writel_relaxed(0, timer_of_base(to) + TIM_SR);
+	writel_relaxed(0, timer_of_base(to) + TIM_DIER);
+
+	/* Detect whether the timer is 16 or 32 bits */
 	max_delta = readl_relaxed(timer_of_base(to) + TIM_ARR);
+
 	to->clkevt.rating = 50;
-	if (max_delta == ~0U)
+	if (max_delta == ~0U) {
+		bits = 32;
 		to->clkevt.rating = 250;
+	}
 
 	/*
 	 * Get the highest possible prescaler value to be as close
@@ -113,18 +156,27 @@ static void __init stm32_clockevent_init(struct timer_of *to)
 	if (prescaler > MAX_TIM_PSC)
 		prescaler = MAX_TIM_PSC;
 
-	writel_relaxed(0, timer_of_base(to) + TIM_ARR);
 	writel_relaxed(prescaler - 1, timer_of_base(to) + TIM_PSC);
-	writel_relaxed(TIM_EGR_UG, timer_of_base(to) + TIM_EGR);
-	writel_relaxed(TIM_DIER_UIE, timer_of_base(to) + TIM_DIER);
-	writel_relaxed(0, timer_of_base(to) + TIM_SR);
 
-	/* adjust rate and period given the prescaler value */
+	/* Adjust rate and period given the prescaler value */
 	to->of_clk.rate = DIV_ROUND_CLOSEST(to->of_clk.rate, prescaler);
 	to->of_clk.period = DIV_ROUND_UP(to->of_clk.rate, HZ);
 
-	clockevents_config_and_register(&to->clkevt,
-					timer_of_rate(to), 0x1, max_delta);
+	/* Make sure that registers are updated */
+	writel_relaxed(TIM_EGR_UG, timer_of_base(to) + TIM_EGR);
+
+	/* Enable controller */
+	writel_relaxed(TIM_CR1_ARPE | TIM_CR1_UDIS | TIM_CR1_CEN,
+		       timer_of_base(to) + TIM_CR1);
+
+	stm32_timer_cnt = timer_of_base(to) + TIM_CNT;
+	sched_clock_register(stm32_read_sched_clock, bits, timer_of_rate(to));
+
+	return clocksource_mmio_init(stm32_timer_cnt, "stm32_timer",
+				     timer_of_rate(to),
+				     to->clkevt.rating,
+				     bits,
+				     clocksource_mmio_readl_up);
 }
 
 static int __init stm32_timer_init(struct device_node *node)
@@ -150,10 +202,16 @@ static int __init stm32_timer_init(struct device_node *node)
 		reset_control_deassert(rstc);
 	}
 
+	ret = stm32_clocksource_init(to);
+	if (ret)
+		goto deinit;
+
 	stm32_clockevent_init(to);
 
 	return 0;
 
+deinit:
+	timer_of_cleanup(to);
 err:
 	kfree(to);
 	return ret;
-- 
2.15.0
