From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu,  4 Jan 2018 13:50:23 +0100
Subject: [PATCH 07/12] clocksource/drivers/stm32: Compute a prescaler value
 with a targeted rate
In-Reply-To: <1515070228-10481-1-git-send-email-daniel.lezcano@linaro.org>
References: <1515070228-10481-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1515070228-10481-8-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Benjamin Gaignard <benjamin.gaignard@st.com>

The prescaler value is arbitrarily set to 1024 without any regard to the
timer frequency. For 32bits timers, there is no need to set a prescaler
value as they wrap in an acceptable interval and give the opportunity to
have precise timers on this platform. However, for 16bits timers a prescaler
value is needed if we don't want to wrap too often per second which is
unefficient and adds more and more error margin. With a targeted clock
of 10MHz, the 16bits are precise enough whatever the timer frequency is
as we will compute the prescaler.

[Daniel Lezcano]: Massaged the changelog and added comment.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-stm32.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-stm32.c b/drivers/clocksource/timer-stm32.c
index 862134e..ac55896 100644
--- a/drivers/clocksource/timer-stm32.c
+++ b/drivers/clocksource/timer-stm32.c
@@ -37,6 +37,9 @@
 
 #define TIM_EGR_UG	BIT(0)
 
+#define TIM_PSC_MAX	USHRT_MAX
+#define TIM_PSC_CLKRATE	10000
+
 static int stm32_clock_event_shutdown(struct clock_event_device *clkevt)
 {
 	struct timer_of *to = to_timer_of(clkevt);
@@ -116,7 +119,14 @@ static void __init stm32_clockevent_init(struct timer_of *to)
 		prescaler = 1;
 		to->clkevt.rating = 250;
 	} else {
-		prescaler = 1024;
+		prescaler = DIV_ROUND_CLOSEST(timer_of_rate(to),
+					      TIM_PSC_CLKRATE);
+		/*
+		 * The prescaler register is an u16, the variable
+		 * can't be greater than TIM_PSC_MAX, let's cap it in
+		 * this case.
+		 */
+		prescaler = prescaler < TIM_PSC_MAX ? prescaler : TIM_PSC_MAX;
 		to->clkevt.rating = 100;
 	}
 	writel_relaxed(0, timer_of_base(to) + TIM_ARR);
-- 
2.7.4
