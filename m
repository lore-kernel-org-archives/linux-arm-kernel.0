From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 04 Apr 2013 18:37:07 +0200
Subject: [PATCH v4 10/14] clocksource: samsung-time: Use master driver to
 configure dividers
In-Reply-To: <1365093431-30621-1-git-send-email-t.figa@samsung.com>
References: <1365093431-30621-1-git-send-email-t.figa@samsung.com>
Message-ID: <1365093431-30621-11-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch modifies the driver to use functions provided by master
driver to configure PWM frequency dividers.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/clocksource/samsung-time.c | 61 +++++---------------------------------
 1 file changed, 8 insertions(+), 53 deletions(-)

diff --git a/drivers/clocksource/samsung-time.c b/drivers/clocksource/samsung-time.c
index 4fa6f6f..e617d37 100644
--- a/drivers/clocksource/samsung-time.c
+++ b/drivers/clocksource/samsung-time.c
@@ -19,7 +19,6 @@
 
 #include <asm/sched_clock.h>
 
-#include <plat/devs.h>
 #define S3C_TIMERREG(x) (pwm->base + (x))
 #define S3C_TIMERREG2(tmr,reg) S3C_TIMERREG((reg)+0x0c+((tmr)*0x0c))
 
@@ -72,10 +71,6 @@ struct samsung_timer_source {
 };
 
 static struct samsung_pwm *pwm;
-static struct clk *tin_event;
-static struct clk *tin_source;
-static struct clk *tdiv_event;
-static struct clk *tdiv_source;
 static struct clk *timerclk;
 static struct samsung_timer_source timer_source;
 static unsigned long clock_count_per_tick;
@@ -267,9 +262,6 @@ static void samsung_timer_resume(void)
 	samsung_time_start(timer_source.source_id, true);
 }
 
-	s3c_device_timer[event].dev.bus = &platform_bus_type;
-	s3c_device_timer[source].dev.bus = &platform_bus_type;
-
 static struct clock_event_device time_event_device = {
 	.name		= "samsung_event_timer",
 	.features	= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
@@ -299,18 +291,14 @@ static void __init samsung_clockevent_init(void)
 	unsigned long pclk;
 	unsigned long clock_rate;
 	unsigned int irq_number;
-	struct clk *tscaler;
 
 	pclk = clk_get_rate(timerclk);
 
-	tscaler = clk_get_parent(tdiv_event);
-
-	clk_set_rate(tscaler, pclk / timer_source.tscaler_div);
-	clk_set_rate(tdiv_event,
-			pclk / (timer_source.tscaler_div * timer_source.tdiv));
-	clk_set_parent(tin_event, tdiv_event);
+	samsung_pwm_set_prescale(pwm, timer_source.event_id,
+						timer_source.tscaler_div);
+	samsung_pwm_set_divisor(pwm, timer_source.event_id, timer_source.tdiv);
 
-	clock_rate = clk_get_rate(tin_event);
+	clock_rate = pclk / (timer_source.tscaler_div * timer_source.tdiv);
 	clock_count_per_tick = clock_rate / HZ;
 
 	time_event_device.cpumask = cpumask_of(0);
@@ -370,11 +358,11 @@ static void __init samsung_clocksource_init(void)
 
 	pclk = clk_get_rate(timerclk);
 
-	clk_set_rate(tdiv_source,
-			pclk / (timer_source.tscaler_div * timer_source.tdiv));
-	clk_set_parent(tin_source, tdiv_source);
+	samsung_pwm_set_prescale(pwm, timer_source.source_id,
+						timer_source.tscaler_div);
+	samsung_pwm_set_divisor(pwm, timer_source.source_id, timer_source.tdiv);
 
-	clock_rate = clk_get_rate(tin_source);
+	clock_rate = pclk / (timer_source.tscaler_div * timer_source.tdiv);
 
 	samsung_time_setup(timer_source.source_id, timer_source.tcnt_max);
 	samsung_time_start(timer_source.source_id, true);
@@ -391,43 +379,10 @@ static void __init samsung_clocksource_init(void)
 
 static void __init samsung_timer_resources(void)
 {
-
-	unsigned long event_id = timer_source.event_id;
-	unsigned long source_id = timer_source.source_id;
-	char devname[15];
-
 	timerclk = clk_get(NULL, "timers");
 	if (IS_ERR(timerclk))
 		panic("failed to get timers clock for timer");
 
-	clk_enable(timerclk);
-
-	sprintf(devname, "s3c24xx-pwm.%lu", event_id);
-	s3c_device_timer[event_id].id = event_id;
-	s3c_device_timer[event_id].dev.init_name = devname;
-
-	tin_event = clk_get(&s3c_device_timer[event_id].dev, "pwm-tin");
-	if (IS_ERR(tin_event))
-		panic("failed to get pwm-tin clock for event timer");
-
-	tdiv_event = clk_get(&s3c_device_timer[event_id].dev, "pwm-tdiv");
-	if (IS_ERR(tdiv_event))
-		panic("failed to get pwm-tdiv clock for event timer");
-
-	clk_enable(tin_event);
-
-	sprintf(devname, "s3c24xx-pwm.%lu", source_id);
-	s3c_device_timer[source_id].id = source_id;
-	s3c_device_timer[source_id].dev.init_name = devname;
-
-	tin_source = clk_get(&s3c_device_timer[source_id].dev, "pwm-tin");
-	if (IS_ERR(tin_source))
-		panic("failed to get pwm-tin clock for source timer");
-
-	tdiv_source = clk_get(&s3c_device_timer[source_id].dev, "pwm-tdiv");
-	if (IS_ERR(tdiv_source))
-		panic("failed to get pwm-tdiv clock for source timer");
-
 	clk_enable(tin_source);
 
 	timer_source.tcnt_max = (1UL << pwm->variant.bits) - 1;
-- 
1.8.1.5
