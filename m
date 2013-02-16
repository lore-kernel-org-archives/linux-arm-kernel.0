From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 16 Feb 2013 17:43:59 +0100
Subject: [PATCH v2 07/12] clocksource: samsung-time: Use clk_get_sys for
 getting clocks
In-Reply-To: <1361033044-27629-1-git-send-email-tomasz.figa@gmail.com>
References: <1361033044-27629-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1361033044-27629-8-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes the need to reference platform_device structs defined
in platform code, by using clk_get_sys instead of clk_get for getting
necessary clocks.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 drivers/clocksource/samsung-time.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/clocksource/samsung-time.c b/drivers/clocksource/samsung-time.c
index f1e54f9..5ecc864 100644
--- a/drivers/clocksource/samsung-time.c
+++ b/drivers/clocksource/samsung-time.c
@@ -24,8 +24,6 @@
 #include <asm/mach/map.h>
 #include <asm/sched_clock.h>
 
-#include <plat/devs.h>
-
 static void __iomem *timer_base;
 
 #define S3C_TIMERREG(x) (timer_base + (x))
@@ -336,9 +334,6 @@ static void samsung_timer_resume(void)
 void __init samsung_set_timer_source(enum samsung_timer_mode event,
 				 enum samsung_timer_mode source)
 {
-	s3c_device_timer[event].dev.bus = &platform_bus_type;
-	s3c_device_timer[source].dev.bus = &platform_bus_type;
-
 	timer_source.event_id = event;
 	timer_source.source_id = source;
 }
@@ -486,28 +481,24 @@ static void __init samsung_timer_resources(void)
 	clk_enable(timerclk);
 
 	sprintf(devname, "s3c24xx-pwm.%lu", event_id);
-	s3c_device_timer[event_id].id = event_id;
-	s3c_device_timer[event_id].dev.init_name = devname;
 
-	tin_event = clk_get(&s3c_device_timer[event_id].dev, "pwm-tin");
+	tin_event = clk_get_sys(devname, "pwm-tin");
 	if (IS_ERR(tin_event))
 		panic("failed to get pwm-tin clock for event timer");
 
-	tdiv_event = clk_get(&s3c_device_timer[event_id].dev, "pwm-tdiv");
+	tdiv_event = clk_get_sys(devname, "pwm-tdiv");
 	if (IS_ERR(tdiv_event))
 		panic("failed to get pwm-tdiv clock for event timer");
 
 	clk_enable(tin_event);
 
 	sprintf(devname, "s3c24xx-pwm.%lu", source_id);
-	s3c_device_timer[source_id].id = source_id;
-	s3c_device_timer[source_id].dev.init_name = devname;
 
-	tin_source = clk_get(&s3c_device_timer[source_id].dev, "pwm-tin");
+	tin_source = clk_get_sys(devname, "pwm-tin");
 	if (IS_ERR(tin_source))
 		panic("failed to get pwm-tin clock for source timer");
 
-	tdiv_source = clk_get(&s3c_device_timer[source_id].dev, "pwm-tdiv");
+	tdiv_source = clk_get_sys(devname, "pwm-tdiv");
 	if (IS_ERR(tdiv_source))
 		panic("failed to get pwm-tdiv clock for source timer");
 
-- 
1.8.1.2
