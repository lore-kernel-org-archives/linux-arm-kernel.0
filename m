From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 12 Apr 2013 21:17:18 +0200
Subject: [PATCH v5 02/14] clocksource: samsung-pwm: Clean up platform header
In-Reply-To: <1365794250-14436-1-git-send-email-t.figa@samsung.com>
References: <1365794250-14436-1-git-send-email-t.figa@samsung.com>
Message-ID: <1365794250-14436-3-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves private definitions out of the public platform header
and also cleans it up from unused and/or unnecessary ones.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-samsung/include/plat/samsung-time.h | 11 -----------
 drivers/clocksource/samsung_pwm.c                 | 15 ++++++++++-----
 2 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/samsung-time.h b/arch/arm/plat-samsung/include/plat/samsung-time.h
index 4cc99bb..ecc423c 100644
--- a/arch/arm/plat-samsung/include/plat/samsung-time.h
+++ b/arch/arm/plat-samsung/include/plat/samsung-time.h
@@ -22,14 +22,6 @@ enum samsung_timer_mode {
 	SAMSUNG_PWM4,
 };
 
-struct samsung_timer_source {
-	unsigned int event_id;
-	unsigned int source_id;
-};
-
-/* Be able to sleep for atleast 4 seconds (usually more) */
-#define SAMSUNG_TIMER_MIN_RANGE	4
-
 #if defined(CONFIG_ARCH_S3C24XX) || defined(CONFIG_ARCH_S5PC100)
 #define TCNT_MAX		0xffff
 #define TSCALER_DIV		25
@@ -42,9 +34,6 @@ struct samsung_timer_source {
 #define TSIZE			32
 #endif
 
-#define NON_PERIODIC		0
-#define PERIODIC		1
-
 extern void __init samsung_set_timer_source(enum samsung_timer_mode event,
 					enum samsung_timer_mode source);
 
diff --git a/drivers/clocksource/samsung_pwm.c b/drivers/clocksource/samsung_pwm.c
index f899cbc..974675b 100644
--- a/drivers/clocksource/samsung_pwm.c
+++ b/drivers/clocksource/samsung_pwm.c
@@ -27,6 +27,11 @@
 #include <plat/regs-timer.h>
 #include <plat/samsung-time.h>
 
+struct samsung_timer_source {
+	unsigned int event_id;
+	unsigned int source_id;
+};
+
 static struct clk *tin_event;
 static struct clk *tin_source;
 static struct clk *tdiv_event;
@@ -182,7 +187,7 @@ static int samsung_set_next_event(unsigned long cycles,
 				struct clock_event_device *evt)
 {
 	samsung_time_setup(timer_source.event_id, cycles);
-	samsung_time_start(timer_source.event_id, NON_PERIODIC);
+	samsung_time_start(timer_source.event_id, false);
 
 	return 0;
 }
@@ -195,7 +200,7 @@ static void samsung_set_mode(enum clock_event_mode mode,
 	switch (mode) {
 	case CLOCK_EVT_MODE_PERIODIC:
 		samsung_time_setup(timer_source.event_id, clock_count_per_tick);
-		samsung_time_start(timer_source.event_id, PERIODIC);
+		samsung_time_start(timer_source.event_id, true);
 		break;
 
 	case CLOCK_EVT_MODE_ONESHOT:
@@ -215,11 +220,11 @@ static void samsung_timer_resume(void)
 {
 	/* event timer restart */
 	samsung_time_setup(timer_source.event_id, clock_count_per_tick);
-	samsung_time_start(timer_source.event_id, PERIODIC);
+	samsung_time_start(timer_source.event_id, true);
 
 	/* source timer restart */
 	samsung_time_setup(timer_source.source_id, TCNT_MAX);
-	samsung_time_start(timer_source.source_id, PERIODIC);
+	samsung_time_start(timer_source.source_id, true);
 }
 
 void __init samsung_set_timer_source(enum samsung_timer_mode event,
@@ -335,7 +340,7 @@ static void __init samsung_clocksource_init(void)
 	clock_rate = clk_get_rate(tin_source);
 
 	samsung_time_setup(timer_source.source_id, TCNT_MAX);
-	samsung_time_start(timer_source.source_id, PERIODIC);
+	samsung_time_start(timer_source.source_id, true);
 
 	setup_sched_clock(samsung_read_sched_clock, TSIZE, clock_rate);
 
-- 
1.8.1.5
