From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Fri,  8 Dec 2017 12:32:46 +0100
Subject: [PATCH v9 2/6] clocksource: stm32: increase min delta value
In-Reply-To: <20171208113250.359-1-benjamin.gaignard@st.com>
References: <20171208113250.359-1-benjamin.gaignard@st.com>
Message-ID: <20171208113250.359-3-benjamin.gaignard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Benjamin Gaignard <benjamin.gaignard@linaro.org>

The CPU is a CortexM4 @ 200MHZ and the clocks driving
the timers are at 90MHZ with a min delta at 1 you could
have an interrupt each 0.01 ms which is really to much.
By increase it to 0x60 it give more time (around 1 ms)
to CPU to handle the interrupt.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
---
 drivers/clocksource/timer-stm32.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-stm32.c b/drivers/clocksource/timer-stm32.c
index fc61fd18a182..a45f1f1cd040 100644
--- a/drivers/clocksource/timer-stm32.c
+++ b/drivers/clocksource/timer-stm32.c
@@ -36,6 +36,12 @@
 
 #define TIM_EGR_UG	BIT(0)
 
+/*
+ * The clock driving the hardware is at 90MHZ with a MIN_DELTA
+ * at 0x60 it gives around 1 ms to the CPU to handle the interrupt
+ */
+#define MIN_DELTA	0x60
+
 static int stm32_clock_event_shutdown(struct clock_event_device *evt)
 {
 	struct timer_of *to = to_timer_of(evt);
@@ -129,7 +135,8 @@ static int __init stm32_clockevent_init(struct device_node *node)
 	writel_relaxed(0, timer_of_base(to) + TIM_SR);
 
 	clockevents_config_and_register(&to->clkevt,
-					timer_of_period(to), 0x1, max_delta);
+					timer_of_period(to),
+					MIN_DELTA, max_delta);
 
 	pr_info("%pOF: STM32 clockevent driver initialized (%d bits)\n",
 			node, bits);
-- 
2.15.0
