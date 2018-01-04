From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu,  4 Jan 2018 13:50:22 +0100
Subject: [PATCH 06/12] clocksource/drivers/stm32: Encapsulate the timer width
 sorting out function
In-Reply-To: <1515070228-10481-1-git-send-email-daniel.lezcano@linaro.org>
References: <1515070228-10481-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1515070228-10481-7-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to clarify and encapsulate the code for the next changes move the
timer width check into a function and add some documentation.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-stm32.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/clocksource/timer-stm32.c b/drivers/clocksource/timer-stm32.c
index 14b7a2b..862134e 100644
--- a/drivers/clocksource/timer-stm32.c
+++ b/drivers/clocksource/timer-stm32.c
@@ -80,9 +80,27 @@ static irqreturn_t stm32_clock_event_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+/**
+ * stm32_timer_width - Sort out the timer width (32/16)
+ * @to: a pointer to a timer-of structure
+ *
+ * Write the 32bits max value and read/return the result. If the timer
+ * is a 32bits width, the result will be UINT_MAX, otherwise it will
+ * be truncated by the 16bits register to USHRT_MAX.
+ *
+ * Returns UINT_MAX if the timer is 32bits width, USHRT_MAX if it is a
+ * 16bits width.
+ */
+static u32 __init stm32_timer_width(struct timer_of *to)
+{
+	writel_relaxed(UINT_MAX, timer_of_base(to) + TIM_ARR);
+
+	return readl_relaxed(timer_of_base(to) + TIM_ARR);
+}
+
 static void __init stm32_clockevent_init(struct timer_of *to)
 {
-	unsigned long max_delta;
+	u32 width = 0;
 	int prescaler;
 
 	to->clkevt.name = to->np->full_name;
@@ -93,10 +111,8 @@ static void __init stm32_clockevent_init(struct timer_of *to)
 	to->clkevt.tick_resume = stm32_clock_event_shutdown;
 	to->clkevt.set_next_event = stm32_clock_event_set_next_event;
 
-	/* Detect whether the timer is 16 or 32 bits */
-	writel_relaxed(~0U, timer_of_base(to) + TIM_ARR);
-	max_delta = readl_relaxed(timer_of_base(to) + TIM_ARR);
-	if (max_delta == ~0U) {
+	width = stm32_timer_width(to);
+	if (width == UINT_MAX) {
 		prescaler = 1;
 		to->clkevt.rating = 250;
 	} else {
@@ -115,10 +131,10 @@ static void __init stm32_clockevent_init(struct timer_of *to)
 	to->of_clk.period = DIV_ROUND_UP(to->of_clk.rate, HZ);
 
 	clockevents_config_and_register(&to->clkevt,
-					timer_of_rate(to), 0x1, max_delta);
+					timer_of_rate(to), 0x1, width);
 
 	pr_info("%pOF: STM32 clockevent driver initialized (%d bits)\n",
-		to->np, max_delta == UINT_MAX ? 32 : 16);
+		to->np, width == UINT_MAX ? 32 : 16);
 }
 
 static int __init stm32_timer_init(struct device_node *node)
-- 
2.7.4
