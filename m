From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Mon,  2 Oct 2017 17:51:51 +0200
Subject: [PATCH v4 2/4] clocksource: stm32: only use 32 bits timers
In-Reply-To: <1506959513-16851-1-git-send-email-benjamin.gaignard@linaro.org>
References: <1506959513-16851-1-git-send-email-benjamin.gaignard@linaro.org>
Message-ID: <1506959513-16851-3-git-send-email-benjamin.gaignard@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

16 bits hardware are not enough accure to be used.
Do no allow them to be probed by tested max counter value.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
---
 drivers/clocksource/timer-stm32.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/clocksource/timer-stm32.c b/drivers/clocksource/timer-stm32.c
index abff21c..f7e4eec 100644
--- a/drivers/clocksource/timer-stm32.c
+++ b/drivers/clocksource/timer-stm32.c
@@ -81,9 +81,9 @@ static irqreturn_t stm32_clock_event_handler(int irq, void *dev_id)
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
@@ -113,26 +113,21 @@ static int __init stm32_clockevent_init(struct device_node *node)
 
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
+		return -EINVAL;
 	}
+
 	writel_relaxed(0, timer_of_base(to) + TIM_ARR);
 
-	writel_relaxed(prescaler - 1, timer_of_base(to) + TIM_PSC);
+	writel_relaxed(0, timer_of_base(to) + TIM_PSC);
 	writel_relaxed(TIM_EGR_UG, timer_of_base(to) + TIM_EGR);
 	writel_relaxed(TIM_DIER_UIE, timer_of_base(to) + TIM_DIER);
 	writel_relaxed(0, timer_of_base(to) + TIM_SR);
 
 	clockevents_config_and_register(&to->clkevt,
-					timer_of_period(to), 0x60, max_delta);
-
-	pr_info("%pOF: STM32 clockevent driver initialized (%d bits)\n",
-			node, bits);
+					timer_of_period(to), 0x60, ~0U);
 
 	return 0;
 }
-- 
2.7.4
