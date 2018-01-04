From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu,  4 Jan 2018 13:50:25 +0100
Subject: [PATCH 09/12] clocksource/drivers/stm32: Encapsulate more the
 clockevent code
In-Reply-To: <1515070228-10481-1-git-send-email-daniel.lezcano@linaro.org>
References: <1515070228-10481-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1515070228-10481-10-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to prepare the clocksource code, let's encapsulate the clockevent
code, split the prescaler and timer width code into separate functions.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-stm32.c | 107 +++++++++++++++++++++++++++++---------
 1 file changed, 82 insertions(+), 25 deletions(-)

diff --git a/drivers/clocksource/timer-stm32.c b/drivers/clocksource/timer-stm32.c
index baca42c..1891924 100644
--- a/drivers/clocksource/timer-stm32.c
+++ b/drivers/clocksource/timer-stm32.c
@@ -44,6 +44,42 @@
 #define TIM_PSC_MAX	USHRT_MAX
 #define TIM_PSC_CLKRATE	10000
 
+struct stm32_timer_private {
+	int bits;
+};
+
+/**
+ * stm32_timer_of_bits_set - set accessor helper
+ * @to: a timer_of structure pointer
+ * @bits: the number of bits (16 or 32)
+ *
+ * Accessor helper to set the number of bits in the timer-of private
+ * structure.
+ *
+ */
+static void stm32_timer_of_bits_set(struct timer_of *to, int bits)
+{
+	struct stm32_timer_private *pd = to->private_data;
+
+	pd->bits = bits;
+}
+
+/**
+ * stm32_timer_of_bits_get - get accessor helper
+ * @to: a timer_of structure pointer
+ *
+ * Accessor helper to get the number of bits in the timer-of private
+ * structure.
+ *
+ * Returns an integer corresponding to the number of bits.
+ */
+static int stm32_timer_of_bits_get(struct timer_of *to)
+{
+	struct stm32_timer_private *pd = to->private_data;
+
+	return pd->bits;
+}
+
 static void stm32_clock_event_disable(struct timer_of *to)
 {
 	writel_relaxed(0, timer_of_base(to) + TIM_DIER);
@@ -124,35 +160,31 @@ static irqreturn_t stm32_clock_event_handler(int irq, void *dev_id)
  * is a 32bits width, the result will be UINT_MAX, otherwise it will
  * be truncated by the 16bits register to USHRT_MAX.
  *
- * Returns UINT_MAX if the timer is 32bits width, USHRT_MAX if it is a
- * 16bits width.
  */
-static u32 __init stm32_timer_width(struct timer_of *to)
+static void __init stm32_timer_set_width(struct timer_of *to)
 {
+	u32 width;
+
 	writel_relaxed(UINT_MAX, timer_of_base(to) + TIM_ARR);
 
-	return readl_relaxed(timer_of_base(to) + TIM_ARR);
+	width = readl_relaxed(timer_of_base(to) + TIM_ARR);
+
+	stm32_timer_of_bits_set(to, width == UINT_MAX ? 32 : 16);
 }
 
-static void __init stm32_clockevent_init(struct timer_of *to)
+/**
+ * stm32_timer_set_prescaler - Compute and set the prescaler register
+ * @to: a pointer to a timer-of structure
+ *
+ * Depending on the timer width, compute the prescaler to always
+ * target a 10MHz timer rate for the 16bits. 32bits timers are
+ * considered precise and long enough to not use the prescaler.
+ */
+static void __init stm32_timer_set_prescaler(struct timer_of *to)
 {
-	u32 width = 0;
-	int prescaler;
+	int prescaler = 1;
 
-	to->clkevt.name = to->np->full_name;
-	to->clkevt.features = CLOCK_EVT_FEAT_PERIODIC;
-	to->clkevt.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
-	to->clkevt.set_state_shutdown = stm32_clock_event_shutdown;
-	to->clkevt.set_state_periodic = stm32_clock_event_set_periodic;
-	to->clkevt.set_state_oneshot = stm32_clock_event_set_oneshot;
-	to->clkevt.tick_resume = stm32_clock_event_shutdown;
-	to->clkevt.set_next_event = stm32_clock_event_set_next_event;
-
-	width = stm32_timer_width(to);
-	if (width == UINT_MAX) {
-		prescaler = 1;
-		to->clkevt.rating = 250;
-	} else {
+	if (stm32_timer_of_bits_get(to) != 32) {
 		prescaler = DIV_ROUND_CLOSEST(timer_of_rate(to),
 					      TIM_PSC_CLKRATE);
 		/*
@@ -161,7 +193,6 @@ static void __init stm32_clockevent_init(struct timer_of *to)
 		 * this case.
 		 */
 		prescaler = prescaler < TIM_PSC_MAX ? prescaler : TIM_PSC_MAX;
-		to->clkevt.rating = 100;
 	}
 
 	writel_relaxed(prescaler - 1, timer_of_base(to) + TIM_PSC);
@@ -171,12 +202,26 @@ static void __init stm32_clockevent_init(struct timer_of *to)
 	/* Adjust rate and period given the prescaler value */
 	to->of_clk.rate = DIV_ROUND_CLOSEST(to->of_clk.rate, prescaler);
 	to->of_clk.period = DIV_ROUND_UP(to->of_clk.rate, HZ);
+}
+
+static void __init stm32_clockevent_init(struct timer_of *to)
+{
+	u32 bits = stm32_timer_of_bits_get(to);
 
-	clockevents_config_and_register(&to->clkevt,
-					timer_of_rate(to), 0x1, width);
+	to->clkevt.name = to->np->full_name;
+	to->clkevt.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
+	to->clkevt.set_state_shutdown = stm32_clock_event_shutdown;
+	to->clkevt.set_state_periodic = stm32_clock_event_set_periodic;
+	to->clkevt.set_state_oneshot = stm32_clock_event_set_oneshot;
+	to->clkevt.tick_resume = stm32_clock_event_shutdown;
+	to->clkevt.set_next_event = stm32_clock_event_set_next_event;
+	to->clkevt.rating = bits == 32 ? 250 : 100;
+
+	clockevents_config_and_register(&to->clkevt, timer_of_rate(to), 0x1,
+					(1 <<  bits) - 1);
 
 	pr_info("%pOF: STM32 clockevent driver initialized (%d bits)\n",
-		to->np, width == UINT_MAX ? 32 : 16);
+		to->np, bits);
 }
 
 static int __init stm32_timer_init(struct device_node *node)
@@ -196,14 +241,26 @@ static int __init stm32_timer_init(struct device_node *node)
 	if (ret)
 		goto err;
 
+	to->private_data = kzalloc(sizeof(struct stm32_timer_private),
+				   GFP_KERNEL);
+	if (!to->private_data)
+		goto deinit;
+
 	rstc = of_reset_control_get(node, NULL);
 	if (!IS_ERR(rstc)) {
 		reset_control_assert(rstc);
 		reset_control_deassert(rstc);
 	}
 
+	stm32_timer_set_width(to);
+
+	stm32_timer_set_prescaler(to);
+
 	stm32_clockevent_init(to);
 	return 0;
+
+deinit:
+	timer_of_cleanup(to);
 err:
 	kfree(to);
 	return ret;
-- 
2.7.4
