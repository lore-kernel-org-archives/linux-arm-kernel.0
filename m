From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 27 May 2011 14:57:41 -0700
Subject: [PATCH] ARM: S5P: Fix bug on init of PWMTimers for HRTimer
Message-ID: <1306533461-32208-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sangbeom Kim <sbkim73@samsung.com>

This patch fixes following.

<6>[    0.000000] sched_clock: 32 bits at 33MHz, ...
<6>[  128.651309] Calibrating delay loop...

There is a big jump. The reason is that PWM Timer which
is for HRTimer was used before its initialization.

So this patch changes its order and following is kernel
boot log message after this.

<6>[    0.000000] sched_clock: 32 bits at 33MHz, ...
<6>[    0.000088] Calibrating delay loop...

Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/plat-s5p/s5p-time.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-s5p/s5p-time.c b/arch/arm/plat-s5p/s5p-time.c
index 899a8cc..612934c 100644
--- a/arch/arm/plat-s5p/s5p-time.c
+++ b/arch/arm/plat-s5p/s5p-time.c
@@ -370,11 +370,11 @@ static void __init s5p_clocksource_init(void)
 
 	clock_rate = clk_get_rate(tin_source);
 
-	init_sched_clock(&cd, s5p_update_sched_clock, 32, clock_rate);
-
 	s5p_time_setup(timer_source.source_id, TCNT_MAX);
 	s5p_time_start(timer_source.source_id, PERIODIC);
 
+	init_sched_clock(&cd, s5p_update_sched_clock, 32, clock_rate);
+
 	if (clocksource_register_hz(&time_clocksource, clock_rate))
 		panic("%s: can't register clocksource\n", time_clocksource.name);
 }
-- 
1.7.4.4
