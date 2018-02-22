From: tony@atomide.com (Tony Lindgren)
Date: Thu, 22 Feb 2018 10:32:18 -0800
Subject: [PATCH] ARM: OMAP: Fix dmtimer init for omap1
Message-ID: <20180222183218.32996-1-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to enable PM runtime on omap1 also as otherwise we
will get errors:

omap_timer omap_timer.1: omap_dm_timer_probe: pm_runtime_get_sync failed!
omap_timer: probe of omap_timer.1 failed with error -13
...

We are checking for OMAP_TIMER_NEEDS_RESET flag elsewhere so this is
safe to do.

Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Keerthy <j-keerthy@ti.com>
Cc: Ladislav Michl <ladis@linux-mips.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/dmtimer.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -888,11 +888,8 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 	timer->irq = irq->start;
 	timer->pdev = pdev;
 
-	/* Skip pm_runtime_enable for OMAP1 */
-	if (!(timer->capability & OMAP_TIMER_NEEDS_RESET)) {
-		pm_runtime_enable(dev);
-		pm_runtime_irq_safe(dev);
-	}
+	pm_runtime_enable(dev);
+	pm_runtime_irq_safe(dev);
 
 	if (!timer->reserved) {
 		ret = pm_runtime_get_sync(dev);
-- 
2.16.2
