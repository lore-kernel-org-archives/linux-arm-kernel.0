From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 04 Apr 2013 18:36:59 +0200
Subject: [PATCH v4 02/14] clocksource: samsung-time: Drop useless defines from
 public header
In-Reply-To: <1365093431-30621-1-git-send-email-t.figa@samsung.com>
References: <1365093431-30621-1-git-send-email-t.figa@samsung.com>
Message-ID: <1365093431-30621-3-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch cleans up public header from useless definitions.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-samsung/include/plat/samsung-time.h |  6 ------
 drivers/clocksource/samsung-time.c                | 10 +++++-----
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/samsung-time.h b/arch/arm/plat-samsung/include/plat/samsung-time.h
index 4cc99bb..5d098ef 100644
--- a/arch/arm/plat-samsung/include/plat/samsung-time.h
+++ b/arch/arm/plat-samsung/include/plat/samsung-time.h
@@ -27,9 +27,6 @@ struct samsung_timer_source {
 	unsigned int source_id;
 };
 
-/* Be able to sleep for atleast 4 seconds (usually more) */
-#define SAMSUNG_TIMER_MIN_RANGE	4
-
 #if defined(CONFIG_ARCH_S3C24XX) || defined(CONFIG_ARCH_S5PC100)
 #define TCNT_MAX		0xffff
 #define TSCALER_DIV		25
@@ -42,9 +39,6 @@ struct samsung_timer_source {
 #define TSIZE			32
 #endif
 
-#define NON_PERIODIC		0
-#define PERIODIC		1
-
 extern void __init samsung_set_timer_source(enum samsung_timer_mode event,
 					enum samsung_timer_mode source);
 
diff --git a/drivers/clocksource/samsung-time.c b/drivers/clocksource/samsung-time.c
index f899cbc..d4d7e3e 100644
--- a/drivers/clocksource/samsung-time.c
+++ b/drivers/clocksource/samsung-time.c
@@ -182,7 +182,7 @@ static int samsung_set_next_event(unsigned long cycles,
 				struct clock_event_device *evt)
 {
 	samsung_time_setup(timer_source.event_id, cycles);
-	samsung_time_start(timer_source.event_id, NON_PERIODIC);
+	samsung_time_start(timer_source.event_id, false);
 
 	return 0;
 }
@@ -195,7 +195,7 @@ static void samsung_set_mode(enum clock_event_mode mode,
 	switch (mode) {
 	case CLOCK_EVT_MODE_PERIODIC:
 		samsung_time_setup(timer_source.event_id, clock_count_per_tick);
-		samsung_time_start(timer_source.event_id, PERIODIC);
+		samsung_time_start(timer_source.event_id, true);
 		break;
 
 	case CLOCK_EVT_MODE_ONESHOT:
@@ -215,11 +215,11 @@ static void samsung_timer_resume(void)
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
@@ -335,7 +335,7 @@ static void __init samsung_clocksource_init(void)
 	clock_rate = clk_get_rate(tin_source);
 
 	samsung_time_setup(timer_source.source_id, TCNT_MAX);
-	samsung_time_start(timer_source.source_id, PERIODIC);
+	samsung_time_start(timer_source.source_id, true);
 
 	setup_sched_clock(samsung_read_sched_clock, TSIZE, clock_rate);
 
-- 
1.8.1.5
