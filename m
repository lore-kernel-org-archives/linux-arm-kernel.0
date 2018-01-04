From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu,  4 Jan 2018 13:50:26 +0100
Subject: [PATCH 10/12] clocksource/drivers/stm32: Add the clocksource
In-Reply-To: <1515070228-10481-1-git-send-email-daniel.lezcano@linaro.org>
References: <1515070228-10481-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1515070228-10481-11-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Benjamin Gaignard <benjamin.gaignard@st.com>

The scene is set for the clocksource, let's add it for this driver.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-stm32.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/clocksource/timer-stm32.c b/drivers/clocksource/timer-stm32.c
index 1891924..4634f4d 100644
--- a/drivers/clocksource/timer-stm32.c
+++ b/drivers/clocksource/timer-stm32.c
@@ -16,6 +16,7 @@
 #include <linux/of_irq.h>
 #include <linux/clk.h>
 #include <linux/reset.h>
+#include <linux/sched_clock.h>
 #include <linux/slab.h>
 
 #include "timer-of.h"
@@ -80,6 +81,13 @@ static int stm32_timer_of_bits_get(struct timer_of *to)
 	return pd->bits;
 }
 
+static void __iomem *stm32_timer_cnt __read_mostly;
+
+static u64 notrace stm32_read_sched_clock(void)
+{
+	return readl_relaxed(stm32_timer_cnt);
+}
+
 static void stm32_clock_event_disable(struct timer_of *to)
 {
 	writel_relaxed(0, timer_of_base(to) + TIM_DIER);
@@ -204,6 +212,31 @@ static void __init stm32_timer_set_prescaler(struct timer_of *to)
 	to->of_clk.period = DIV_ROUND_UP(to->of_clk.rate, HZ);
 }
 
+static int __init stm32_clocksource_init(struct timer_of *to)
+{
+        u32 bits = stm32_timer_of_bits_get(to);
+	const char *name = to->np->full_name;
+
+	/*
+	 * This driver allows to register several timers and relies on
+	 * the generic time framework to select the right one.
+	 * However, nothing allows to do the same for the
+	 * sched_clock. We are not interested in a sched_clock for the
+	 * 16bits timers but only for the 32bits, so if no 32bits
+	 * timer registered yet, we select this 32bits timer as a
+	 * sched_clock.
+	 */
+	if (bits == 32 && !stm32_timer_cnt) {
+		stm32_timer_cnt = timer_of_base(to) + TIM_CNT;
+		sched_clock_register(stm32_read_sched_clock, bits, timer_of_rate(to));
+		pr_info("%s: STM32 sched_clock registered\n", name);
+	}
+
+	return clocksource_mmio_init(timer_of_base(to) + TIM_CNT, name,
+				     timer_of_rate(to), bits == 32 ? 250 : 100,
+				     bits, clocksource_mmio_readl_up);
+}
+
 static void __init stm32_clockevent_init(struct timer_of *to)
 {
 	u32 bits = stm32_timer_of_bits_get(to);
@@ -256,6 +289,10 @@ static int __init stm32_timer_init(struct device_node *node)
 
 	stm32_timer_set_prescaler(to);
 
+	ret = stm32_clocksource_init(to);
+	if (ret)
+		goto deinit;
+
 	stm32_clockevent_init(to);
 	return 0;
 
-- 
2.7.4
