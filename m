From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu,  4 Jan 2018 13:50:28 +0100
Subject: [PATCH 12/12] clocksource/drivers/stm32: Start the timer's counter
 sooner
In-Reply-To: <1515070228-10481-1-git-send-email-daniel.lezcano@linaro.org>
References: <1515070228-10481-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1515070228-10481-13-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we have a lot of timers on this platform, we can have potentially all the
timers enabled in the DT, so we don't want to start the timer for every probe
otherwise they will be running for nothing as only one will be used.

Start the timer only when setting the mode or when the clocksource is
enabled.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-stm32.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-stm32.c b/drivers/clocksource/timer-stm32.c
index dcf8445..4ce2345 100644
--- a/drivers/clocksource/timer-stm32.c
+++ b/drivers/clocksource/timer-stm32.c
@@ -101,7 +101,15 @@ static void stm32_clock_event_disable(struct timer_of *to)
 	writel_relaxed(0, timer_of_base(to) + TIM_DIER);
 }
 
-static void stm32_clock_event_enable(struct timer_of *to)
+/**
+ * stm32_timer_start - Start the counter without event
+ * @to: a timer_of structure pointer
+ *
+ * Start the timer in order to have the counter reset and start
+ * incrementing but disable interrupt event when there is a counter
+ * overflow. By default, the counter direction is used as upcounter.
+ */
+static void stm32_timer_start(struct timer_of *to)
 {
 	writel_relaxed(TIM_CR1_UDIS | TIM_CR1_CEN, timer_of_base(to) + TIM_CR1);
 }
@@ -137,7 +145,7 @@ static int stm32_clock_event_set_periodic(struct clock_event_device *clkevt)
 {
 	struct timer_of *to = to_timer_of(clkevt);
 
-	stm32_clock_event_enable(to);
+	stm32_timer_start(to);
 
 	return stm32_clock_event_set_next_event(timer_of_period(to), clkevt);
 }
@@ -146,7 +154,7 @@ static int stm32_clock_event_set_oneshot(struct clock_event_device *clkevt)
 {
 	struct timer_of *to = to_timer_of(clkevt);
 
-	stm32_clock_event_enable(to);
+	stm32_timer_start(to);
 
 	return 0;
 }
@@ -235,6 +243,13 @@ static int __init stm32_clocksource_init(struct timer_of *to)
 	 * sched_clock.
 	 */
 	if (bits == 32 && !stm32_timer_cnt) {
+
+		/*
+		 * Start immediately the counter as we will be using
+		 * it right after.
+		 */
+		stm32_timer_start(to);
+
 		stm32_timer_cnt = timer_of_base(to) + TIM_CNT;
 		sched_clock_register(stm32_read_sched_clock, bits, timer_of_rate(to));
 		pr_info("%s: STM32 sched_clock registered\n", name);
-- 
2.7.4
