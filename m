From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Fri,  8 Dec 2017 12:32:47 +0100
Subject: [PATCH v9 3/6] clocksource: stm32: only use 32 bits timers
In-Reply-To: <20171208113250.359-1-benjamin.gaignard@st.com>
References: <20171208113250.359-1-benjamin.gaignard@st.com>
Message-ID: <20171208113250.359-4-benjamin.gaignard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Benjamin Gaignard <benjamin.gaignard@linaro.org>

The clock driving counters is at 90MHz so the maximum period
for 16 bis counters is around 728us (2^16 / 90.000.000).
For 32 bits counters this period is close 47 secondes which is
more acceptable.

When using 16 bits counters the kernel may not be able to boot
because it has a too high overhead compare to the clockevent period.
Downgrading the rating of 16bits counter won't change anything
to this problem so this patch remove 16 bits counters support
and makes sure that they won't be probed anymore.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
---
 drivers/clocksource/timer-stm32.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/clocksource/timer-stm32.c b/drivers/clocksource/timer-stm32.c
index a45f1f1cd040..707808d91bf0 100644
--- a/drivers/clocksource/timer-stm32.c
+++ b/drivers/clocksource/timer-stm32.c
@@ -84,12 +84,16 @@ static irqreturn_t stm32_clock_event_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static bool stm32_timer_is_32bits(struct timer_of *to)
+{
+	return readl_relaxed(timer_of_base(to) + TIM_ARR) == ~0UL;
+}
+
 static int __init stm32_clockevent_init(struct device_node *node)
 {
 	struct reset_control *rstc;
-	unsigned long max_delta;
-	int ret, bits, prescaler = 1;
 	struct timer_of *to;
+	int ret;
 
 	to = kzalloc(sizeof(*to), GFP_KERNEL);
 	if (!to)
@@ -118,31 +122,27 @@ static int __init stm32_clockevent_init(struct device_node *node)
 	}
 
 	/* Detect whether the timer is 16 or 32 bits */
-	writel_relaxed(~0U, timer_of_base(to) + TIM_ARR);
-	max_delta = readl_relaxed(timer_of_base(to) + TIM_ARR);
-	if (max_delta == ~0U) {
-		prescaler = 1;
-		bits = 32;
-	} else {
-		prescaler = 1024;
-		bits = 16;
+	if (!stm32_timer_is_32bits(to)) {
+		pr_warn("Timer %pOF is a 16 bits timer\n", node);
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
 					timer_of_period(to),
-					MIN_DELTA, max_delta);
-
-	pr_info("%pOF: STM32 clockevent driver initialized (%d bits)\n",
-			node, bits);
+					MIN_DELTA, ~0U);
 
 	return 0;
 
+deinit:
+	timer_of_cleanup(to);
 err:
 	kfree(to);
 	return ret;
-- 
2.15.0
