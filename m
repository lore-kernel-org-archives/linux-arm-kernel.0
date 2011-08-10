From: hemantp@ti.com (Hemant Pedanekar)
Date: Wed, 10 Aug 2011 18:49:35 +0530
Subject: [PATCH v2] omap: timer: Set dmtimer used as clocksource in autoreload
	mode
Message-ID: <1312982375-11848-1-git-send-email-hemantp@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If CONFIG_OMAP_32K_TIMER is not selected and dmtimer is used as clocksource, the
timer stops counting once overflow occurs as it was not set in autoreload mode.
This results into timekeeping failure: for example, 'sleep 1' at the shell after
the timer counter overflow would hang.

This patch sets up autoreload when starting the clocksource timer which fixes
the above issue.

Signed-off-by: Hemant Pedanekar <hemantp@ti.com>
---
 arch/arm/mach-omap2/timer.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index e964072..cf1de7d 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -293,7 +293,8 @@ static void __init omap2_gp_clocksource_init(int gptimer_id,
 	pr_info("OMAP clocksource: GPTIMER%d at %lu Hz\n",
 		gptimer_id, clksrc.rate);
 
-	__omap_dm_timer_load_start(clksrc.io_base, OMAP_TIMER_CTRL_ST, 0, 1);
+	__omap_dm_timer_load_start(clksrc.io_base,
+			OMAP_TIMER_CTRL_ST | OMAP_TIMER_CTRL_AR, 0, 1);
 	init_sched_clock(&cd, dmtimer_update_sched_clock, 32, clksrc.rate);
 
 	if (clocksource_register_hz(&clocksource_gpt, clksrc.rate))
-- 
1.7.3.5
