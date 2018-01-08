From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon,  8 Jan 2018 14:28:58 +0100
Subject: [PATCH 19/20] clocksource/drivers/stm32: Add the timer delay
In-Reply-To: <1515418139-23276-1-git-send-email-daniel.lezcano@linaro.org>
References: <1bbaef2e-4080-3f54-7db3-a8989acfd691@free.fr>
 <1515418139-23276-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1515418139-23276-19-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the timer delay, that saves us ~90ms of boot time.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Tested-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Acked-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/clocksource/timer-stm32.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/clocksource/timer-stm32.c b/drivers/clocksource/timer-stm32.c
index 4634f4d..dcf8445 100644
--- a/drivers/clocksource/timer-stm32.c
+++ b/drivers/clocksource/timer-stm32.c
@@ -9,6 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/clocksource.h>
 #include <linux/clockchips.h>
+#include <linux/delay.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/of.h>
@@ -88,6 +89,13 @@ static u64 notrace stm32_read_sched_clock(void)
 	return readl_relaxed(stm32_timer_cnt);
 }
 
+static struct delay_timer stm32_timer_delay;
+
+static unsigned long stm32_read_delay(void)
+{
+	return readl_relaxed(stm32_timer_cnt);
+}
+
 static void stm32_clock_event_disable(struct timer_of *to)
 {
 	writel_relaxed(0, timer_of_base(to) + TIM_DIER);
@@ -230,6 +238,11 @@ static int __init stm32_clocksource_init(struct timer_of *to)
 		stm32_timer_cnt = timer_of_base(to) + TIM_CNT;
 		sched_clock_register(stm32_read_sched_clock, bits, timer_of_rate(to));
 		pr_info("%s: STM32 sched_clock registered\n", name);
+
+		stm32_timer_delay.read_current_timer = stm32_read_delay;
+		stm32_timer_delay.freq = timer_of_rate(to);
+		register_current_timer_delay(&stm32_timer_delay);
+		pr_info("%s: STM32 delay timer registered\n", name);
 	}
 
 	return clocksource_mmio_init(timer_of_base(to) + TIM_CNT, name,
-- 
2.7.4
