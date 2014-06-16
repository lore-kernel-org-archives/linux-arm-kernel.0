From: Li.Xiubo@freescale.com (Xiubo Li)
Date: Mon, 16 Jun 2014 13:08:38 +0800
Subject: [PATCHv2] clocksource: arch_arm_timer: Fix timecounter initialization
Message-ID: <1402895318-26217-1-git-send-email-Li.Xiubo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The third parameter(u64 start_tstamp) of timecounter_init() should
be the start time by ns, not a cycle counter.

Here just set it to zero.

Cc: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 drivers/clocksource/arm_arch_timer.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 5163ec1..b29a810 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -426,19 +426,16 @@ struct timecounter *arch_timer_get_timecounter(void)
 
 static void __init arch_counter_register(unsigned type)
 {
-	u64 start_count;
-
 	/* Register the CP15 based counter if we have one */
 	if (type & ARCH_CP15_TIMER)
 		arch_timer_read_counter = arch_counter_get_cntvct;
 	else
 		arch_timer_read_counter = arch_counter_get_cntvct_mem;
 
-	start_count = arch_timer_read_counter();
 	clocksource_register_hz(&clocksource_counter, arch_timer_rate);
 	cyclecounter.mult = clocksource_counter.mult;
 	cyclecounter.shift = clocksource_counter.shift;
-	timecounter_init(&timecounter, &cyclecounter, start_count);
+	timecounter_init(&timecounter, &cyclecounter, 0);
 
 	/* 56 bits minimum, so we assume worst case rollover */
 	sched_clock_register(arch_timer_read_counter, 56, arch_timer_rate);
-- 
1.8.5
