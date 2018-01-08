From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon,  8 Jan 2018 14:28:52 +0100
Subject: [PATCH 13/20] clocksource/drivers/stm32: Use the node name as timer
 name
In-Reply-To: <1515418139-23276-1-git-send-email-daniel.lezcano@linaro.org>
References: <1bbaef2e-4080-3f54-7db3-a8989acfd691@free.fr>
 <1515418139-23276-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1515418139-23276-13-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As there are different timers on the stm32, use the node name for the timer
name in order to give the indication of which timer the kernel is using.

The /proc/timer_list gives all the information with the right name, otherwise
we end up digging in the kernel log and /proc/interrupt to do the connection
between the used timer.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Tested-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Acked-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/clocksource/timer-stm32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-stm32.c b/drivers/clocksource/timer-stm32.c
index 3e4ab07..14b7a2b 100644
--- a/drivers/clocksource/timer-stm32.c
+++ b/drivers/clocksource/timer-stm32.c
@@ -85,7 +85,7 @@ static void __init stm32_clockevent_init(struct timer_of *to)
 	unsigned long max_delta;
 	int prescaler;
 
-	to->clkevt.name = "stm32_clockevent";
+	to->clkevt.name = to->np->full_name;
 	to->clkevt.features = CLOCK_EVT_FEAT_PERIODIC;
 	to->clkevt.set_state_shutdown = stm32_clock_event_shutdown;
 	to->clkevt.set_state_periodic = stm32_clock_event_set_periodic;
-- 
2.7.4
