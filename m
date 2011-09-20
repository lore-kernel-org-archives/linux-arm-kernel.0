From: tarun.kanti@ti.com (Tarun Kanti DebBarma)
Date: Tue, 20 Sep 2011 17:00:21 +0530
Subject: [PATCH v16 06/12] OMAP: dmtimer: pm_runtime support
In-Reply-To: <1316518227-28116-1-git-send-email-tarun.kanti@ti.com>
References: <1316518227-28116-1-git-send-email-tarun.kanti@ti.com>
Message-ID: <1316518227-28116-7-git-send-email-tarun.kanti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pm_runtime feature to dmtimer whereby *_runtime_get_sync()
is called within omap_dm_timer_enable(), pm_runtime_put()
is called in omap_dm_timer_disable(). In addition to calling
pm_runtime_enable, we are calling pm_runtime_irq_safe so that
they can be called from interrupt context.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Signed-off-by: Partha Basak <p-basak2@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Cousson, Benoit <b-cousson@ti.com>
---
 arch/arm/plat-omap/dmtimer.c              |   33 ++++++++--------------------
 arch/arm/plat-omap/include/plat/dmtimer.h |    1 -
 2 files changed, 10 insertions(+), 24 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index b486fd2..53821a3 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -38,6 +38,7 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/err.h>
+#include <linux/pm_runtime.h>
 
 #include <plat/dmtimer.h>
 
@@ -202,33 +203,13 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_free);
 
 void omap_dm_timer_enable(struct omap_dm_timer *timer)
 {
-	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
-
-	if (timer->enabled)
-		return;
-
-	if (!pdata->needs_manual_reset) {
-		clk_enable(timer->fclk);
-		clk_enable(timer->iclk);
-	}
-
-	timer->enabled = 1;
+	pm_runtime_get_sync(&timer->pdev->dev);
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_enable);
 
 void omap_dm_timer_disable(struct omap_dm_timer *timer)
 {
-	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
-
-	if (!timer->enabled)
-		return;
-
-	if (!pdata->needs_manual_reset) {
-		clk_disable(timer->iclk);
-		clk_disable(timer->fclk);
-	}
-
-	timer->enabled = 0;
+	pm_runtime_put(&timer->pdev->dev);
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_disable);
 
@@ -463,7 +444,7 @@ int omap_dm_timers_active(void)
 	struct omap_dm_timer *timer;
 
 	list_for_each_entry(timer, &omap_timer_list, node) {
-		if (!timer->enabled)
+		if (!timer->reserved)
 			continue;
 
 		if (omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG) &
@@ -533,6 +514,12 @@ static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
 	timer->irq = irq->start;
 	timer->pdev = pdev;
 
+	/* Skip pm_runtime_enable for OMAP1 */
+	if (!pdata->needs_manual_reset) {
+		pm_runtime_enable(&pdev->dev);
+		pm_runtime_irq_safe(&pdev->dev);
+	}
+
 	/* add the timer element to the list */
 	spin_lock_irqsave(&dm_timer_lock, flags);
 	list_add_tail(&timer->node, &omap_timer_list);
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 6cedc73..351b6cd 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -243,7 +243,6 @@ struct omap_dm_timer {
 
 	unsigned long rate;
 	unsigned reserved:1;
-	unsigned enabled:1;
 	unsigned posted:1;
 	struct platform_device *pdev;
 	struct list_head node;
-- 
1.7.0.4
