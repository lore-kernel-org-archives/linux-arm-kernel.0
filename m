From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 12 Apr 2013 21:17:23 +0200
Subject: [PATCH v5 07/14] clocksource: samsung-pwm: Use platform data to setup
 the clocksource
In-Reply-To: <1365794250-14436-1-git-send-email-t.figa@samsung.com>
References: <1365794250-14436-1-git-send-email-t.figa@samsung.com>
Message-ID: <1365794250-14436-8-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch modifies the clocksource registration code to use data taken
from platform data instead of statically hardcoded defines.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-samsung/devs.c                      |  7 +++
 arch/arm/plat-samsung/include/plat/samsung-time.h | 29 +++++-----
 drivers/clocksource/samsung_pwm.c                 | 70 ++++++++++++++++-------
 include/clocksource/samsung_pwm.h                 |  1 +
 4 files changed, 73 insertions(+), 34 deletions(-)

diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index bfae4dd..fbfabd2 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -32,6 +32,8 @@
 #include <linux/platform_data/s3c-hsudc.h>
 #include <linux/platform_data/s3c-hsotg.h>
 
+#include <clocksource/samsung_pwm.h>
+
 #include <media/s5p_hdmi.h>
 
 #include <asm/irq.h>
@@ -1184,6 +1186,11 @@ struct platform_device samsung_device_pwm = {
 	.resource	= samsung_pwm_resource,
 };
 
+void samsung_timer_init(void)
+{
+	samsung_pwm_clocksource_init(&samsung_device_pwm);
+}
+
 /* RTC */
 
 #ifdef CONFIG_PLAT_S3C24XX
diff --git a/arch/arm/plat-samsung/include/plat/samsung-time.h b/arch/arm/plat-samsung/include/plat/samsung-time.h
index ecc423c..633c151 100644
--- a/arch/arm/plat-samsung/include/plat/samsung-time.h
+++ b/arch/arm/plat-samsung/include/plat/samsung-time.h
@@ -13,6 +13,10 @@
 #ifndef __ASM_PLAT_SAMSUNG_TIME_H
 #define __ASM_PLAT_SAMSUNG_TIME_H __FILE__
 
+#include <clocksource/samsung_pwm.h>
+
+#include <plat/devs.h>
+
 /* SAMSUNG HR-Timer Clock mode */
 enum samsung_timer_mode {
 	SAMSUNG_PWM0,
@@ -22,20 +26,17 @@ enum samsung_timer_mode {
 	SAMSUNG_PWM4,
 };
 
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
-extern void __init samsung_set_timer_source(enum samsung_timer_mode event,
-					enum samsung_timer_mode source);
+static inline void samsung_set_timer_source(enum samsung_timer_mode event,
+						enum samsung_timer_mode source)
+{
+	struct samsung_pwm_variant *variant;
+
+	variant = samsung_device_pwm.dev.platform_data;
+	BUG_ON(!variant);
+
+	variant->output_mask = (1 << 5) - 1;
+	variant->output_mask &= ~((1 << event) | (1 << source));
+}
 
 extern void __init samsung_timer_init(void);
 
diff --git a/drivers/clocksource/samsung_pwm.c b/drivers/clocksource/samsung_pwm.c
index 7bbd55c..841d03c 100644
--- a/drivers/clocksource/samsung_pwm.c
+++ b/drivers/clocksource/samsung_pwm.c
@@ -280,8 +280,13 @@ EXPORT_SYMBOL(samsung_pwm_get);
 struct samsung_timer_source {
 	unsigned int event_id;
 	unsigned int source_id;
+	unsigned int tcnt_max;
+	unsigned int tscaler_div;
+	unsigned int tdiv;
 };
 
+static struct samsung_pwm *pwm;
+
 static struct clk *tin_event;
 static struct clk *tin_source;
 static struct clk *tdiv_event;
@@ -473,20 +478,10 @@ static void samsung_timer_resume(void)
 	samsung_time_start(timer_source.event_id, true);
 
 	/* source timer restart */
-	samsung_time_setup(timer_source.source_id, TCNT_MAX);
+	samsung_time_setup(timer_source.source_id, timer_source.tcnt_max);
 	samsung_time_start(timer_source.source_id, true);
 }
 
-void __init samsung_set_timer_source(enum samsung_timer_mode event,
-				 enum samsung_timer_mode source)
-{
-	s3c_device_timer[event].dev.bus = &platform_bus_type;
-	s3c_device_timer[source].dev.bus = &platform_bus_type;
-
-	timer_source.event_id = event;
-	timer_source.source_id = source;
-}
-
 static struct clock_event_device time_event_device = {
 	.name		= "samsung_event_timer",
 	.features	= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
@@ -522,8 +517,9 @@ static void __init samsung_clockevent_init(void)
 
 	tscaler = clk_get_parent(tdiv_event);
 
-	clk_set_rate(tscaler, pclk / TSCALER_DIV);
-	clk_set_rate(tdiv_event, pclk / TDIV);
+	clk_set_rate(tscaler, pclk / timer_source.tscaler_div);
+	clk_set_rate(tdiv_event,
+			pclk / (timer_source.tdiv * timer_source.tscaler_div));
 	clk_set_parent(tin_event, tdiv_event);
 
 	clock_rate = clk_get_rate(tin_event);
@@ -532,7 +528,7 @@ static void __init samsung_clockevent_init(void)
 	time_event_device.cpumask = cpumask_of(0);
 	clockevents_config_and_register(&time_event_device, clock_rate, 1, -1);
 
-	irq_number = timer_source.event_id + IRQ_TIMER0;
+	irq_number = pwm->irq[timer_source.event_id];
 	setup_irq(irq_number, &samsung_clock_event_irq);
 }
 
@@ -579,23 +575,29 @@ static u32 notrace samsung_read_sched_clock(void)
 
 static void __init samsung_clocksource_init(void)
 {
+	void __iomem *reg = samsung_timer_reg();
 	unsigned long pclk;
 	unsigned long clock_rate;
+	int ret;
 
 	pclk = clk_get_rate(timerclk);
 
-	clk_set_rate(tdiv_source, pclk / TDIV);
+	clk_set_rate(tdiv_source,
+			pclk / (timer_source.tdiv * timer_source.tscaler_div));
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
+	ret = clocksource_mmio_init(reg, "samsung_clocksource_timer",
+					clock_rate, 250, pwm->variant.bits,
+					clocksource_mmio_readl_down);
+	if (ret)
 		panic("samsung_clocksource_timer: can't register clocksource\n");
 }
 
@@ -639,10 +641,38 @@ static void __init samsung_timer_resources(void)
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
 
-void __init samsung_timer_init(void)
+void __init samsung_pwm_clocksource_init(struct platform_device *pdev)
 {
+	u8 mask;
+	int channel;
+
+	pwm = samsung_pwm_get(pdev, NULL);
+	if (IS_ERR(pwm))
+		panic("failed to get PWM device");
+
+	mask = ~pwm->variant.output_mask & ((1 << SAMSUNG_PWM_NUM) - 1);
+	channel = fls(mask) - 1;
+	if (channel < 0)
+		panic("failed to find PWM channel for clocksource");
+	timer_source.source_id = channel;
+
+	mask &= ~(1 << channel);
+	channel = fls(mask) - 1;
+	if (channel < 0)
+		panic("failed to find PWM channel for clock event");
+	timer_source.event_id = channel;
+
 	samsung_timer_resources();
 	samsung_clockevent_init();
 	samsung_clocksource_init();
diff --git a/include/clocksource/samsung_pwm.h b/include/clocksource/samsung_pwm.h
index d16415f..a0449d5 100644
--- a/include/clocksource/samsung_pwm.h
+++ b/include/clocksource/samsung_pwm.h
@@ -38,6 +38,7 @@ struct samsung_pwm {
 	int irq[SAMSUNG_PWM_NUM];
 };
 
+extern void samsung_pwm_clocksource_init(struct platform_device *);
 extern struct samsung_pwm *samsung_pwm_get(struct platform_device *,
 							struct device_node *);
 
-- 
1.8.1.5
