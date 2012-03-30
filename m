From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 30 Mar 2012 18:57:26 +0530
Subject: [PATCH 1/3] ARM: OMAP: timer: allow gp timer clock-event to be used
 on both cpus
In-Reply-To: <1333114048-26136-1-git-send-email-santosh.shilimkar@ti.com>
References: <1333114048-26136-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1333114048-26136-2-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For coupled cpuidle to work when both cpus are active, it needs a global timer
that can handle events for both cpus.  This timer is used as the broadcast
clock-event when the per-cpu timer hardware stop in low power states.
Set the cpumask of clockevent_gpt to all cpus, set the rating correctly, and
set the irq to allow the clockevent core to determine the affinity of the
timer.

Signed-off-by: Colin Cross <ccross@android.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/timer.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index fc73567..e33f9c4 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -135,6 +135,7 @@ static struct clock_event_device clockevent_gpt = {
 	.name		= "gp timer",
 	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
 	.shift		= 32,
+	.rating		= 300,
 	.set_next_event	= omap2_gp_timer_set_next_event,
 	.set_mode	= omap2_gp_timer_set_mode,
 };
@@ -225,7 +226,8 @@ static void __init omap2_gp_clockevent_init(int gptimer_id,
 		clockevent_delta2ns(3, &clockevent_gpt);
 		/* Timer internal resynch latency. */
 
-	clockevent_gpt.cpumask = cpumask_of(0);
+	clockevent_gpt.cpumask = cpu_all_mask;
+	clockevent_gpt.irq = omap_dm_timer_get_irq(&clkev);
 	clockevents_register_device(&clockevent_gpt);
 
 	pr_info("OMAP clockevent source: GPTIMER%d at %lu Hz\n",
-- 
1.7.5.4
