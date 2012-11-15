From: jon-hunter@ti.com (Jon Hunter)
Date: Thu, 15 Nov 2012 13:44:04 -0600
Subject: [PATCH] ARM: OMAP2+: Fix compiler warning for 32k timer
Message-ID: <1353008644-24745-1-git-send-email-jon-hunter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit "ARM: OMAP2+: Add device-tree support for 32kHz counter"
added structure omap_counter_match to the OMAP2 timer code. When
CONFIG_OMAP_32K_TIMER is not defined this structure generates the
following as it is not used.

  CC      arch/arm/mach-omap2/timer.o
  arch/arm/mach-omap2/timer.c:163:28: warning: 'omap_counter_match'
  defined but not used [-Wunused-variable]

Move the definition of omap_counter_match to avoid this warning when
CONFIG_OMAP_32K_TIMER is not set.

Thanks to Kevin Hilman for tracking down and reporting this problem.

Reported-by: Kevin Hilam <khilman@deeprootsystems.com>
Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---

This is based upon Tony Lindgren's OMAP master branch.

 arch/arm/mach-omap2/timer.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 099e406..2b9d485 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -160,11 +160,6 @@ static struct of_device_id omap_timer_match[] __initdata = {
 	{ }
 };
 
-static struct of_device_id omap_counter_match[] __initdata = {
-	{ .compatible = "ti,omap-counter32k", },
-	{ }
-};
-
 /**
  * omap_get_timer_dt - get a timer using device-tree
  * @match	- device-tree match structure for matching a device type
@@ -408,6 +403,11 @@ static u32 notrace dmtimer_read_sched_clock(void)
 }
 
 #ifdef CONFIG_OMAP_32K_TIMER
+static struct of_device_id omap_counter_match[] __initdata = {
+	{ .compatible = "ti,omap-counter32k", },
+	{ }
+};
+
 /* Setup free-running counter for clocksource */
 static int __init omap2_sync32k_clocksource_init(void)
 {
-- 
1.7.9.5
