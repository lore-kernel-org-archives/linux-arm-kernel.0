From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Fri, 15 Dec 2017 09:52:45 +0100
Subject: [PATCH 2/4] clocksource: stm32: use prescaler to adjust the resolution
In-Reply-To: <20171215085247.14946-1-benjamin.gaignard@st.com>
References: <20171215085247.14946-1-benjamin.gaignard@st.com>
Message-ID: <20171215085247.14946-3-benjamin.gaignard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than use fixed prescaler values compute it to get a clock
as close as possible of 10KHz and a resolution of 0.1ms.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/clocksource/timer-stm32.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/clocksource/timer-stm32.c b/drivers/clocksource/timer-stm32.c
index 23a321cca45b..de721d318065 100644
--- a/drivers/clocksource/timer-stm32.c
+++ b/drivers/clocksource/timer-stm32.c
@@ -37,6 +37,11 @@
 
 #define TIM_EGR_UG	BIT(0)
 
+#define MAX_TIM_PSC	0xFFFF
+
+/* Target a 10KHz clock to get a resolution of 0.1 ms */
+#define TARGETED_CLK_RATE 10000
+
 static int stm32_clock_event_shutdown(struct clock_event_device *evt)
 {
 	struct timer_of *to = to_timer_of(evt);
@@ -83,7 +88,7 @@ static irqreturn_t stm32_clock_event_handler(int irq, void *dev_id)
 static void __init stm32_clockevent_init(struct timer_of *to)
 {
 	unsigned long max_delta;
-	int prescaler;
+	unsigned long prescaler;
 
 	to->clkevt.name = "stm32_clockevent";
 	to->clkevt.features = CLOCK_EVT_FEAT_PERIODIC;
@@ -96,13 +101,17 @@ static void __init stm32_clockevent_init(struct timer_of *to)
 	/* Detect whether the timer is 16 or 32 bits */
 	writel_relaxed(~0U, timer_of_base(to) + TIM_ARR);
 	max_delta = readl_relaxed(timer_of_base(to) + TIM_ARR);
-	if (max_delta == ~0U) {
-		prescaler = 1;
+	to->clkevt.rating = 50;
+	if (max_delta == ~0U)
 		to->clkevt.rating = 250;
-	} else {
-		prescaler = 1024;
-		to->clkevt.rating = 50;
-	}
+
+	/*
+	 * Get the highest possible prescaler value to be as close
+	 * as possible of TARGETED_CLK_RATE
+	 */
+	prescaler = DIV_ROUND_CLOSEST(timer_of_rate(to), TARGETED_CLK_RATE);
+	if (prescaler > MAX_TIM_PSC)
+		prescaler = MAX_TIM_PSC;
 
 	writel_relaxed(0, timer_of_base(to) + TIM_ARR);
 	writel_relaxed(prescaler - 1, timer_of_base(to) + TIM_PSC);
-- 
2.15.0
