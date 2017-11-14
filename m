From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Tue, 14 Nov 2017 09:52:41 +0100
Subject: [PATCH v8 4/6] clocksource: stm32: only use 32 bits timers
In-Reply-To: <1510649563-22975-1-git-send-email-benjamin.gaignard@linaro.org>
References: <1510649563-22975-1-git-send-email-benjamin.gaignard@linaro.org>
Message-ID: <1510649563-22975-5-git-send-email-benjamin.gaignard@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clock driving counters is at 90MHz so the maximum period
for 16 bis counters is around 750 ms which is a short period
for a clocksource. For 32 bits counters this period is close
47 secondes which is more acceptable.

This patch remove 16 bits counters support and makes sure that
they won't be probed anymore.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
---
 drivers/clocksource/timer-stm32.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/clocksource/timer-stm32.c b/drivers/clocksource/timer-stm32.c
index ae41a19..8173bcf 100644
--- a/drivers/clocksource/timer-stm32.c
+++ b/drivers/clocksource/timer-stm32.c
@@ -83,9 +83,9 @@ static irqreturn_t stm32_clock_event_handler(int irq, void *dev_id)
 static int __init stm32_clockevent_init(struct device_node *node)
 {
 	struct reset_control *rstc;
-	unsigned long max_delta;
-	int ret, bits, prescaler = 1;
+	unsigned long max_arr;
 	struct timer_of *to;
+	int ret;
 
 	to = kzalloc(sizeof(*to), GFP_KERNEL);
 	if (!to)
@@ -115,29 +115,27 @@ static int __init stm32_clockevent_init(struct device_node *node)
 
 	/* Detect whether the timer is 16 or 32 bits */
 	writel_relaxed(~0U, timer_of_base(to) + TIM_ARR);
-	max_delta = readl_relaxed(timer_of_base(to) + TIM_ARR);
-	if (max_delta == ~0U) {
-		prescaler = 1;
-		bits = 32;
-	} else {
-		prescaler = 1024;
-		bits = 16;
+	max_arr = readl_relaxed(timer_of_base(to) + TIM_ARR);
+	if (max_arr != ~0U) {
+		pr_err("32 bits timer is needed\n");
+		ret = -EINVAL;
+		goto deinit;
 	}
+
 	writel_relaxed(0, timer_of_base(to) + TIM_ARR);
 
-	writel_relaxed(prescaler - 1, timer_of_base(to) + TIM_PSC);
+	writel_relaxed(0, timer_of_base(to) + TIM_PSC);
 	writel_relaxed(TIM_EGR_UG, timer_of_base(to) + TIM_EGR);
 	writel_relaxed(TIM_DIER_UIE, timer_of_base(to) + TIM_DIER);
 	writel_relaxed(0, timer_of_base(to) + TIM_SR);
 
 	clockevents_config_and_register(&to->clkevt,
-					timer_of_period(to), MIN_DELTA, max_delta);
-
-	pr_info("%pOF: STM32 clockevent driver initialized (%d bits)\n",
-			node, bits);
+					timer_of_period(to), MIN_DELTA, ~0U);
 
 	return 0;
 
+deinit:
+	timer_of_exit(to);
 err:
 	kfree(to);
 	return ret;
-- 
2.7.4
