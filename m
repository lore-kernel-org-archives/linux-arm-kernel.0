From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 04 Apr 2013 18:37:06 +0200
Subject: [PATCH v4 09/14] clocksource: samsung-time: Use variant data to get
 SoC-specific bits
In-Reply-To: <1365093431-30621-1-git-send-email-t.figa@samsung.com>
References: <1365093431-30621-1-git-send-email-t.figa@samsung.com>
Message-ID: <1365093431-30621-10-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch modifies the driver to calculate SoC-specific parameters from
variant data received from PWM/timer master driver.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-samsung/include/plat/samsung-time.h | 17 --------
 drivers/clocksource/samsung-time.c                | 51 ++++++++++++++++++-----
 2 files changed, 41 insertions(+), 27 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/samsung-time.h b/arch/arm/plat-samsung/include/plat/samsung-time.h
index c0f35cc..785c6b7 100644
--- a/arch/arm/plat-samsung/include/plat/samsung-time.h
+++ b/arch/arm/plat-samsung/include/plat/samsung-time.h
@@ -26,23 +26,6 @@ enum samsung_timer_mode {
 	SAMSUNG_PWM4,
 };
 
-struct samsung_timer_source {
-	unsigned int event_id;
-	unsigned int source_id;
-};
-
-#if defined(CONFIG_ARCH_S3C24XX) || defined(CONFIG_ARCH_S5PC100)
-#define TCNT_MAX		0xffff
-#define TSCALER_DIV		25
-#define TDIV			50
-#define TSIZE			16
-#else
-#define TCNT_MAX		0xffffffff
-#define TSCALER_DIV		2
-#define TDIV			2
-#define TSIZE			32
-#endif
-
 static inline void samsung_set_timer_source(enum samsung_timer_mode event,
 					enum samsung_timer_mode source)
 {
diff --git a/drivers/clocksource/samsung-time.c b/drivers/clocksource/samsung-time.c
index 11d7a54..4fa6f6f 100644
--- a/drivers/clocksource/samsung-time.c
+++ b/drivers/clocksource/samsung-time.c
@@ -20,7 +20,6 @@
 #include <asm/sched_clock.h>
 
 #include <plat/devs.h>
-#include <plat/samsung-time.h>
 #define S3C_TIMERREG(x) (pwm->base + (x))
 #define S3C_TIMERREG2(tmr,reg) S3C_TIMERREG((reg)+0x0c+((tmr)*0x0c))
 
@@ -56,6 +55,22 @@
 #define S3C2410_TCON_T0MANUALUPD  (1<<1)
 #define S3C2410_TCON_T0START	  (1<<0)
 
+enum samsung_timer_mode {
+	SAMSUNG_PWM0,
+	SAMSUNG_PWM1,
+	SAMSUNG_PWM2,
+	SAMSUNG_PWM3,
+	SAMSUNG_PWM4,
+};
+
+struct samsung_timer_source {
+	unsigned int event_id;
+	unsigned int source_id;
+	u32 tcnt_max;
+	u16 tscaler_div;
+	u16 tdiv;
+};
+
 static struct samsung_pwm *pwm;
 static struct clk *tin_event;
 static struct clk *tin_source;
@@ -248,7 +263,7 @@ static void samsung_timer_resume(void)
 	samsung_time_start(timer_source.event_id, true);
 
 	/* source timer restart */
-	samsung_time_setup(timer_source.source_id, TCNT_MAX);
+	samsung_time_setup(timer_source.source_id, timer_source.tcnt_max);
 	samsung_time_start(timer_source.source_id, true);
 }
 
@@ -290,15 +305,17 @@ static void __init samsung_clockevent_init(void)
 
 	tscaler = clk_get_parent(tdiv_event);
 
-	clk_set_rate(tscaler, pclk / TSCALER_DIV);
-	clk_set_rate(tdiv_event, pclk / TDIV);
+	clk_set_rate(tscaler, pclk / timer_source.tscaler_div);
+	clk_set_rate(tdiv_event,
+			pclk / (timer_source.tscaler_div * timer_source.tdiv));
 	clk_set_parent(tin_event, tdiv_event);
 
 	clock_rate = clk_get_rate(tin_event);
 	clock_count_per_tick = clock_rate / HZ;
 
 	time_event_device.cpumask = cpumask_of(0);
-	clockevents_config_and_register(&time_event_device, clock_rate, 1, -1);
+	clockevents_config_and_register(&time_event_device, clock_rate,
+						1, timer_source.tcnt_max);
 
 	irq_number = pwm->irq[timer_source.event_id];
 	setup_irq(irq_number, &samsung_clock_event_irq);
@@ -349,21 +366,26 @@ static void __init samsung_clocksource_init(void)
 {
 	unsigned long pclk;
 	unsigned long clock_rate;
+	int ret;
 
 	pclk = clk_get_rate(timerclk);
 
-	clk_set_rate(tdiv_source, pclk / TDIV);
+	clk_set_rate(tdiv_source,
+			pclk / (timer_source.tscaler_div * timer_source.tdiv));
 	clk_set_parent(tin_source, tdiv_source);
 
 	clock_rate = clk_get_rate(tin_source);
 
-	samsung_time_setup(timer_source.source_id, TCNT_MAX);
+	samsung_time_setup(timer_source.source_id, timer_source.tcnt_max);
 	samsung_time_start(timer_source.source_id, true);
 
-	setup_sched_clock(samsung_read_sched_clock, TSIZE, clock_rate);
+	setup_sched_clock(samsung_read_sched_clock,
+						pwm->variant.bits, clock_rate);
 
-	if (clocksource_mmio_init(samsung_timer_reg(), "samsung_clocksource_timer",
-			clock_rate, 250, TSIZE, clocksource_mmio_readl_down))
+	ret = clocksource_mmio_init(samsung_timer_reg(),
+			"samsung_clocksource_timer", clock_rate, 250,
+			pwm->variant.bits, clocksource_mmio_readl_down);
+	if (ret)
 		panic("samsung_clocksource_timer: can't register clocksource\n");
 }
 
@@ -407,6 +429,15 @@ static void __init samsung_timer_resources(void)
 		panic("failed to get pwm-tdiv clock for source timer");
 
 	clk_enable(tin_source);
+
+	timer_source.tcnt_max = (1UL << pwm->variant.bits) - 1;
+	if (pwm->variant.bits == 16) {
+		timer_source.tscaler_div = 25;
+		timer_source.tdiv = 2;
+	} else {
+		timer_source.tscaler_div = 2;
+		timer_source.tdiv = 1;
+	}
 }
 
 void __init samsung_time_init(void)
-- 
1.8.1.5
