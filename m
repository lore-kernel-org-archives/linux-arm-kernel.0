From: tarun.kanti@ti.com (Tarun Kanti DebBarma)
Date: Tue, 20 Sep 2011 17:00:23 +0530
Subject: [PATCH v16 08/12] OMAP: dmtimer: do remaining initialization in probe
In-Reply-To: <1316518227-28116-1-git-send-email-tarun.kanti@ti.com>
References: <1316518227-28116-1-git-send-email-tarun.kanti@ti.com>
Message-ID: <1316518227-28116-9-git-send-email-tarun.kanti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use sys_timer_reserved to identify which all timers have already been
used for clocksource and clockevent. Mark all those timers as reserved
so that no one else uses them.
Call __omap_dm_timer_init_regs for the remaining timers so that their
base and offsets are configured correctly based upon timer ip version.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/plat-omap/dmtimer.c              |   21 +++++++++++++++++----
 arch/arm/plat-omap/include/plat/dmtimer.h |    1 +
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 53821a3..9c9feb9 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -514,10 +514,23 @@ static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
 	timer->irq = irq->start;
 	timer->pdev = pdev;
 
-	/* Skip pm_runtime_enable for OMAP1 */
-	if (!pdata->needs_manual_reset) {
-		pm_runtime_enable(&pdev->dev);
-		pm_runtime_irq_safe(&pdev->dev);
+/*
+ * sys_timer_reserved is not defined for OMAP1.
+ * Use the macro to avoid compilation error on OMAP1.
+ */
+#if defined(CONFIG_ARCH_OMAP2PLUS)
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_irq_safe(&pdev->dev);
+	/* Mark clocksource and clockevent timers as reserved */
+	if ((sys_timer_reserved >> (pdev->id - 1)) & 0x1)
+		timer->reserved = 1;
+#endif
+
+	if (!timer->reserved) {
+		pm_runtime_get_sync(&pdev->dev);
+		__omap_dm_timer_init_regs(timer);
+		timer->tidr = __raw_readl(timer->io_base);
+		pm_runtime_put(&pdev->dev);
 	}
 
 	/* add the timer element to the list */
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index e29adfa..6413fe2 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -246,6 +246,7 @@ struct omap_dm_timer {
 	void __iomem	*pend;		/* write pending */
 	void __iomem	*func_base;	/* function register base */
 
+	u32 tidr;	/* TIDR register value */
 	unsigned long rate;
 	unsigned reserved:1;
 	unsigned posted:1;
-- 
1.7.0.4
