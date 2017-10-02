From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Mon,  2 Oct 2017 17:51:52 +0200
Subject: [PATCH v4 3/4] clocksource: stm32: add clocksource support
In-Reply-To: <1506959513-16851-1-git-send-email-benjamin.gaignard@linaro.org>
References: <1506959513-16851-1-git-send-email-benjamin.gaignard@linaro.org>
Message-ID: <1506959513-16851-4-git-send-email-benjamin.gaignard@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rework driver code to be able to implement clocksource and clockevent
on the same hardware block.
Before this patch only the counter of the hardware block was used to
generate clock events. Now counter will be used to provide a 32 bits
clock source and a comparator will provide clock events.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
---
 drivers/clocksource/timer-stm32.c | 104 ++++++++++++++++++++++++++++----------
 1 file changed, 76 insertions(+), 28 deletions(-)

diff --git a/drivers/clocksource/timer-stm32.c b/drivers/clocksource/timer-stm32.c
index f7e4eec..fb84252 100644
--- a/drivers/clocksource/timer-stm32.c
+++ b/drivers/clocksource/timer-stm32.c
@@ -16,6 +16,8 @@
 #include <linux/of_irq.h>
 #include <linux/clk.h>
 #include <linux/reset.h>
+#include <linux/sched_clock.h>
+#include <linux/slab.h>
 
 #include "timer-of.h"
 
@@ -23,16 +25,16 @@
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
 
@@ -40,30 +42,34 @@ static int stm32_clock_event_shutdown(struct clock_event_device *evt)
 {
 	struct timer_of *to = to_timer_of(evt);
 
-	writel_relaxed(0, timer_of_base(to) + TIM_CR1);
+	writel_relaxed(0, timer_of_base(to) + TIM_DIER);
+
 	return 0;
 }
 
-static int stm32_clock_event_set_periodic(struct clock_event_device *evt)
+static int stm32_clock_event_set_next_event(unsigned long evt,
+					    struct clock_event_device *clkevt)
 {
-	struct timer_of *to = to_timer_of(evt);
+	struct timer_of *to = to_timer_of(clkevt);
+	unsigned long cnt;
 
-	writel_relaxed(timer_of_period(to), timer_of_base(to) + TIM_ARR);
-	writel_relaxed(TIM_CR1_ARPE | TIM_CR1_CEN, timer_of_base(to) + TIM_CR1);
+	cnt = readl_relaxed(timer_of_base(to) + TIM_CNT);
+	writel_relaxed(cnt + evt, timer_of_base(to) + TIM_CCR1);
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
 
-	return 0;
+static int stm32_clock_event_set_oneshot(struct clock_event_device *evt)
+{
+	return stm32_clock_event_set_next_event(0, evt);
 }
 
 static irqreturn_t stm32_clock_event_handler(int irq, void *dev_id)
@@ -73,12 +79,57 @@ static irqreturn_t stm32_clock_event_handler(int irq, void *dev_id)
 
 	writel_relaxed(0, timer_of_base(to) + TIM_SR);
 
+	if (clockevent_state_periodic(evt))
+		stm32_clock_event_set_periodic(evt);
+	else
+		stm32_clock_event_shutdown(evt);
+
 	evt->event_handler(evt);
 
 	return IRQ_HANDLED;
 }
 
-static int __init stm32_clockevent_init(struct device_node *node)
+static void __init stm32_clockevent_init(struct timer_of *to)
+{
+	writel_relaxed(0, timer_of_base(to) + TIM_DIER);
+	writel_relaxed(0, timer_of_base(to) + TIM_SR);
+
+	clockevents_config_and_register(&to->clkevt,
+					timer_of_rate(to), 0x60, ~0U);
+}
+
+static void __iomem *stm32_timer_cnt __read_mostly;
+static u64 notrace stm32_read_sched_clock(void)
+{
+	return readl_relaxed(stm32_timer_cnt);
+}
+
+static int __init stm32_clocksource_init(struct timer_of *to)
+{
+	writel_relaxed(~0U, timer_of_base(to) + TIM_ARR);
+	writel_relaxed(0, timer_of_base(to) + TIM_PSC);
+	writel_relaxed(0, timer_of_base(to) + TIM_SR);
+	writel_relaxed(0, timer_of_base(to) + TIM_DIER);
+	writel_relaxed(0, timer_of_base(to) + TIM_SR);
+	writel_relaxed(TIM_CR1_ARPE | TIM_CR1_UDIS,
+		       timer_of_base(to) + TIM_CR1);
+
+	/* Make sure that registers are updated */
+	writel_relaxed(TIM_EGR_UG, timer_of_base(to) + TIM_EGR);
+
+	/* Enable controller */
+	writel_relaxed(TIM_CR1_ARPE | TIM_CR1_UDIS | TIM_CR1_CEN,
+		       timer_of_base(to) + TIM_CR1);
+
+	stm32_timer_cnt = timer_of_base(to) + TIM_CNT;
+	sched_clock_register(stm32_read_sched_clock, 32, timer_of_rate(to));
+
+	return clocksource_mmio_init(stm32_timer_cnt, "stm32_timer",
+				     timer_of_rate(to), 250, 32,
+				     clocksource_mmio_readl_up);
+}
+
+static int __init stm32_timer_init(struct device_node *node)
 {
 	struct reset_control *rstc;
 	unsigned long max_arr;
@@ -90,12 +141,13 @@ static int __init stm32_clockevent_init(struct device_node *node)
 		return -ENOMEM;
 
 	to->flags = TIMER_OF_IRQ | TIMER_OF_CLOCK | TIMER_OF_BASE;
+
 	to->clkevt.name = "stm32_clockevent";
 	to->clkevt.rating = 200;
-	to->clkevt.features = CLOCK_EVT_FEAT_PERIODIC;
+	to->clkevt.features = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC;
 	to->clkevt.set_state_shutdown = stm32_clock_event_shutdown;
 	to->clkevt.set_state_periodic = stm32_clock_event_set_periodic;
-	to->clkevt.set_state_oneshot = stm32_clock_event_shutdown;
+	to->clkevt.set_state_oneshot = stm32_clock_event_set_oneshot;
 	to->clkevt.tick_resume = stm32_clock_event_shutdown;
 	to->clkevt.set_next_event = stm32_clock_event_set_next_event;
 
@@ -119,17 +171,13 @@ static int __init stm32_clockevent_init(struct device_node *node)
 		return -EINVAL;
 	}
 
-	writel_relaxed(0, timer_of_base(to) + TIM_ARR);
-
-	writel_relaxed(0, timer_of_base(to) + TIM_PSC);
-	writel_relaxed(TIM_EGR_UG, timer_of_base(to) + TIM_EGR);
-	writel_relaxed(TIM_DIER_UIE, timer_of_base(to) + TIM_DIER);
-	writel_relaxed(0, timer_of_base(to) + TIM_SR);
+	ret = stm32_clocksource_init(to);
+	if (ret)
+		return ret;
 
-	clockevents_config_and_register(&to->clkevt,
-					timer_of_period(to), 0x60, ~0U);
+	stm32_clockevent_init(to);
 
 	return 0;
 }
 
-TIMER_OF_DECLARE(stm32, "st,stm32-timer", stm32_clockevent_init);
+TIMER_OF_DECLARE(stm32, "st,stm32-timer", stm32_timer_init);
-- 
2.7.4
