From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 04 Apr 2013 18:37:05 +0200
Subject: [PATCH v4 08/14] clocksource: samsung-time: Use Samsung PWM/timer
 master driver
In-Reply-To: <1365093431-30621-1-git-send-email-t.figa@samsung.com>
References: <1365093431-30621-1-git-send-email-t.figa@samsung.com>
Message-ID: <1365093431-30621-9-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch modifies the samsung-time clocksource driver to use the
interface provided by Samsung PWM/timer master driver to get platform
data.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-samsung/devs.c                      |  7 ++++
 arch/arm/plat-samsung/include/plat/samsung-time.h | 17 +++++++--
 drivers/clocksource/samsung-time.c                | 44 ++++++++++++++---------
 include/linux/platform_data/samsung-pwm.h         |  1 +
 4 files changed, 51 insertions(+), 18 deletions(-)

diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index bfae4dd..747763d 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -57,6 +57,7 @@
 #include <plat/keypad.h>
 #include <linux/platform_data/mmc-s3cmci.h>
 #include <linux/platform_data/mtd-nand-s3c2410.h>
+#include <plat/samsung-time.h>
 #include <plat/sdhci.h>
 #include <linux/platform_data/touchscreen-s3c2410.h>
 #include <linux/platform_data/usb-s3c2410_udc.h>
@@ -1184,6 +1185,12 @@ struct platform_device samsung_device_pwm = {
 	.resource	= samsung_pwm_resource,
 };
 
+void samsung_timer_init(void)
+{
+	samsung_pwm_register(&samsung_device_pwm);
+	samsung_time_init();
+}
+
 /* RTC */
 
 #ifdef CONFIG_PLAT_S3C24XX
diff --git a/arch/arm/plat-samsung/include/plat/samsung-time.h b/arch/arm/plat-samsung/include/plat/samsung-time.h
index 5d098ef..c0f35cc 100644
--- a/arch/arm/plat-samsung/include/plat/samsung-time.h
+++ b/arch/arm/plat-samsung/include/plat/samsung-time.h
@@ -13,6 +13,10 @@
 #ifndef __ASM_PLAT_SAMSUNG_TIME_H
 #define __ASM_PLAT_SAMSUNG_TIME_H __FILE__
 
+#include <linux/platform_data/samsung-pwm.h>
+
+#include <plat/devs.h>
+
 /* SAMSUNG HR-Timer Clock mode */
 enum samsung_timer_mode {
 	SAMSUNG_PWM0,
@@ -39,8 +43,17 @@ struct samsung_timer_source {
 #define TSIZE			32
 #endif
 
-extern void __init samsung_set_timer_source(enum samsung_timer_mode event,
-					enum samsung_timer_mode source);
+static inline void samsung_set_timer_source(enum samsung_timer_mode event,
+					enum samsung_timer_mode source)
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
 
diff --git a/drivers/clocksource/samsung-time.c b/drivers/clocksource/samsung-time.c
index bccc291..11d7a54 100644
--- a/drivers/clocksource/samsung-time.c
+++ b/drivers/clocksource/samsung-time.c
@@ -14,19 +14,14 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/clockchips.h>
+#include <linux/mfd/samsung-pwm.h>
 #include <linux/platform_device.h>
 
-#include <asm/smp_twd.h>
-#include <asm/mach/time.h>
-#include <asm/mach/arch.h>
-#include <asm/mach/map.h>
 #include <asm/sched_clock.h>
 
-#include <mach/map.h>
 #include <plat/devs.h>
 #include <plat/samsung-time.h>
-
-#define S3C_TIMERREG(x) (S3C_VA_TIMER + (x))
+#define S3C_TIMERREG(x) (pwm->base + (x))
 #define S3C_TIMERREG2(tmr,reg) S3C_TIMERREG((reg)+0x0c+((tmr)*0x0c))
 
 #define S3C2410_TCON	      S3C_TIMERREG(0x08)
@@ -61,6 +56,7 @@
 #define S3C2410_TCON_T0MANUALUPD  (1<<1)
 #define S3C2410_TCON_T0START	  (1<<0)
 
+static struct samsung_pwm *pwm;
 static struct clk *tin_event;
 static struct clk *tin_source;
 static struct clk *tdiv_event;
@@ -256,16 +252,9 @@ static void samsung_timer_resume(void)
 	samsung_time_start(timer_source.source_id, true);
 }
 
-void __init samsung_set_timer_source(enum samsung_timer_mode event,
-				 enum samsung_timer_mode source)
-{
 	s3c_device_timer[event].dev.bus = &platform_bus_type;
 	s3c_device_timer[source].dev.bus = &platform_bus_type;
 
-	timer_source.event_id = event;
-	timer_source.source_id = source;
-}
-
 static struct clock_event_device time_event_device = {
 	.name		= "samsung_event_timer",
 	.features	= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
@@ -311,7 +300,7 @@ static void __init samsung_clockevent_init(void)
 	time_event_device.cpumask = cpumask_of(0);
 	clockevents_config_and_register(&time_event_device, clock_rate, 1, -1);
 
-	irq_number = timer_source.event_id + IRQ_TIMER0;
+	irq_number = pwm->irq[timer_source.event_id];
 	setup_irq(irq_number, &samsung_clock_event_irq);
 }
 
@@ -420,8 +409,31 @@ static void __init samsung_timer_resources(void)
 	clk_enable(tin_source);
 }
 
-void __init samsung_timer_init(void)
+void __init samsung_time_init(void)
 {
+	u8 mask;
+	int channel;
+
+	pwm = samsung_pwm_get(NULL);
+	if (IS_ERR(pwm))
+		panic("failed to get PWM device");
+
+	mask = ~pwm->variant.output_mask & ((1 << SAMSUNG_PWM_NUM) - 1);
+	channel = fls(mask) - 1;
+	if (channel < 0)
+		panic("failed to find PWM channel for clocksource");
+	timer_source.source_id = channel;
+
+	samsung_pwm_request(pwm, channel);
+
+	mask &= ~(1 << channel);
+	channel = fls(mask) - 1;
+	if (channel < 0)
+		panic("failed to find PWM channel for clock event");
+	timer_source.event_id = channel;
+
+	samsung_pwm_request(pwm, channel);
+
 	samsung_timer_resources();
 	samsung_clockevent_init();
 	samsung_clocksource_init();
diff --git a/include/linux/platform_data/samsung-pwm.h b/include/linux/platform_data/samsung-pwm.h
index 8c48dbb..ca6c488 100644
--- a/include/linux/platform_data/samsung-pwm.h
+++ b/include/linux/platform_data/samsung-pwm.h
@@ -24,5 +24,6 @@ struct samsung_pwm_variant {
 };
 
 extern int samsung_pwm_register(struct platform_device *pdev);
+extern void samsung_time_init(void);
 
 #endif
-- 
1.8.1.5
