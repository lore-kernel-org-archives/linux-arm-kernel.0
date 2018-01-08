From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon,  8 Jan 2018 14:28:55 +0100
Subject: [PATCH 16/20] clocksource/drivers/stm32: Add the oneshot mode
In-Reply-To: <1515418139-23276-1-git-send-email-daniel.lezcano@linaro.org>
References: <1bbaef2e-4080-3f54-7db3-a8989acfd691@free.fr>
 <1515418139-23276-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1515418139-23276-16-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Benjamin Gaignard <benjamin.gaignard@st.com>

The stm32 timer block is able to have a counter and a comparator.

Instead of using the auto-reload register for periodic event, we switch
to the oneshot mode by using the comparator register.

The timer is able to generate an interrupt when the counter overflows but
we don't want that as this counter will be use as a clocksource in the next
patches. So it is disabled by the UDIS bit of the control register.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Tested-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Acked-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/clocksource/timer-stm32.c | 56 ++++++++++++++++++++++++++++++---------
 1 file changed, 44 insertions(+), 12 deletions(-)

diff --git a/drivers/clocksource/timer-stm32.c b/drivers/clocksource/timer-stm32.c
index ac55896..baca42c 100644
--- a/drivers/clocksource/timer-stm32.c
+++ b/drivers/clocksource/timer-stm32.c
@@ -24,14 +24,18 @@
 #define TIM_DIER	0x0c
 #define TIM_SR		0x10
 #define TIM_EGR		0x14
+#define TIM_CNT		0x24
 #define TIM_PSC		0x28
 #define TIM_ARR		0x2c
+#define TIM_CCR1	0x34
 
 #define TIM_CR1_CEN	BIT(0)
+#define TIM_CR1_UDIS	BIT(1)
 #define TIM_CR1_OPM	BIT(3)
 #define TIM_CR1_ARPE	BIT(7)
 
 #define TIM_DIER_UIE	BIT(0)
+#define TIM_DIER_CC1IE	BIT(1)
 
 #define TIM_SR_UIF	BIT(0)
 
@@ -40,33 +44,57 @@
 #define TIM_PSC_MAX	USHRT_MAX
 #define TIM_PSC_CLKRATE	10000
 
+static void stm32_clock_event_disable(struct timer_of *to)
+{
+	writel_relaxed(0, timer_of_base(to) + TIM_DIER);
+}
+
+static void stm32_clock_event_enable(struct timer_of *to)
+{
+	writel_relaxed(TIM_CR1_UDIS | TIM_CR1_CEN, timer_of_base(to) + TIM_CR1);
+}
+
 static int stm32_clock_event_shutdown(struct clock_event_device *clkevt)
 {
 	struct timer_of *to = to_timer_of(clkevt);
 
-	writel_relaxed(0, timer_of_base(to) + TIM_CR1);
+	stm32_clock_event_disable(to);
 
 	return 0;
 }
 
-static int stm32_clock_event_set_periodic(struct clock_event_device *clkevt)
+static int stm32_clock_event_set_next_event(unsigned long evt,
+					    struct clock_event_device *clkevt)
 {
 	struct timer_of *to = to_timer_of(clkevt);
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
+static int stm32_clock_event_set_periodic(struct clock_event_device *clkevt)
+{
+	struct timer_of *to = to_timer_of(clkevt);
+
+	stm32_clock_event_enable(to);
+
+	return stm32_clock_event_set_next_event(timer_of_period(to), clkevt);
+}
+
+static int stm32_clock_event_set_oneshot(struct clock_event_device *clkevt)
 {
 	struct timer_of *to = to_timer_of(clkevt);
 
-	writel_relaxed(evt, timer_of_base(to) + TIM_ARR);
-	writel_relaxed(TIM_CR1_ARPE | TIM_CR1_OPM | TIM_CR1_CEN,
-		       timer_of_base(to) + TIM_CR1);
+	stm32_clock_event_enable(to);
 
 	return 0;
 }
@@ -78,6 +106,11 @@ static irqreturn_t stm32_clock_event_handler(int irq, void *dev_id)
 
 	writel_relaxed(0, timer_of_base(to) + TIM_SR);
 
+	if (clockevent_state_periodic(clkevt))
+		stm32_clock_event_set_periodic(clkevt);
+	else
+		stm32_clock_event_shutdown(clkevt);
+
 	clkevt->event_handler(clkevt);
 
 	return IRQ_HANDLED;
@@ -108,9 +141,10 @@ static void __init stm32_clockevent_init(struct timer_of *to)
 
 	to->clkevt.name = to->np->full_name;
 	to->clkevt.features = CLOCK_EVT_FEAT_PERIODIC;
+	to->clkevt.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
 	to->clkevt.set_state_shutdown = stm32_clock_event_shutdown;
 	to->clkevt.set_state_periodic = stm32_clock_event_set_periodic;
-	to->clkevt.set_state_oneshot = stm32_clock_event_shutdown;
+	to->clkevt.set_state_oneshot = stm32_clock_event_set_oneshot;
 	to->clkevt.tick_resume = stm32_clock_event_shutdown;
 	to->clkevt.set_next_event = stm32_clock_event_set_next_event;
 
@@ -129,12 +163,10 @@ static void __init stm32_clockevent_init(struct timer_of *to)
 		prescaler = prescaler < TIM_PSC_MAX ? prescaler : TIM_PSC_MAX;
 		to->clkevt.rating = 100;
 	}
-	writel_relaxed(0, timer_of_base(to) + TIM_ARR);
 
 	writel_relaxed(prescaler - 1, timer_of_base(to) + TIM_PSC);
 	writel_relaxed(TIM_EGR_UG, timer_of_base(to) + TIM_EGR);
 	writel_relaxed(0, timer_of_base(to) + TIM_SR);
-	writel_relaxed(TIM_DIER_UIE, timer_of_base(to) + TIM_DIER);
 
 	/* Adjust rate and period given the prescaler value */
 	to->of_clk.rate = DIV_ROUND_CLOSEST(to->of_clk.rate, prescaler);
-- 
2.7.4
