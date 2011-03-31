From: khilman@ti.com (Kevin Hilman)
Date: Thu, 31 Mar 2011 14:49:27 -0700
Subject: [PATCH] OMAP2+: PM debug: update suspend wakeup timer for DM timer changes
Message-ID: <mailman.184.1301609393.1530.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/pm-debug.c |    4 ++--
 arch/arm/mach-omap2/timer-gp.c |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index a5a83b3..eccf117 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -171,8 +171,8 @@ void omap2_pm_wakeup_on_timer(u32 seconds, u32 milliseconds)
 
 	tick_rate = clk_get_rate(omap_dm_timer_get_fclk(gptimer_wakeup));
 	cycles = tick_rate * seconds + tick_rate * milliseconds / 1000;
-	omap_dm_timer_stop(gptimer_wakeup);
-	omap_dm_timer_set_load_start(gptimer_wakeup, 0, 0xffffffff - cycles);
+	__omap_dm_timer_load_start(gptimer_wakeup->io_base, OMAP_TIMER_CTRL_ST,
+				   0xffffffff - cycles, 1);
 
 	pr_info("PM: Resume timer in %u.%03u secs"
 		" (%d ticks at %d ticks/sec.)\n",
diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
index c21e99f..52100b2 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -76,7 +76,7 @@ static struct omap_dm_timer *gptimer;
 static struct clock_event_device clockevent_gpt;
 static u8 __initdata gptimer_id = 1;
 static u8 __initdata inited;
-struct omap_dm_timer *gptimer_wakeup;
+struct omap_dm_timer *gptimer_wakeup = &clkev;
 
 static irqreturn_t omap2_gp_timer_interrupt(int irq, void *dev_id)
 {
-- 
1.7.4
