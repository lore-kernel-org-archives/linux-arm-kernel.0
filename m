From: tarun.kanti@ti.com (Tarun Kanti DebBarma)
Date: Fri, 23 Sep 2011 14:48:56 +0530
Subject: [correction] [PATCH 09/12] OMAP: dmtimer: low-power mode support
Message-ID: <mailman.148.1316770064.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These are some missing content as well as correction to this patch.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 arch/arm/plat-omap/dmtimer.c |   21 ++++++++++++++++++---
 1 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index de7896f..81a2305 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -79,9 +79,9 @@ static void omap_dm_timer_write_reg(struct
omap_dm_timer *timer, u32 reg,

 static void omap_timer_restore_context(struct omap_dm_timer *timer)
 {
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_OCP_CFG_OFFSET,
-				timer->context.tiocp_cfg);
-	if (timer->revision > 1)
+	__raw_writel(timer->context.tiocp_cfg,
+			timer->io_base + OMAP_TIMER_OCP_CFG_OFFSET);
+	if (timer->revision == 1)
 		__raw_writel(timer->context.tistat, timer->sys_stat);

 	__raw_writel(timer->context.tisr, timer->irq_stat);
@@ -356,6 +356,21 @@ int omap_dm_timer_stop(struct omap_dm_timer *timer)

 	__omap_dm_timer_stop(timer, timer->posted, rate);

+	if (timer->loses_context) {
+		if (timer->get_context_loss_count)
+			timer->ctx_loss_count =
+			timer->get_context_loss_count(&timer->pdev->dev);
+	}
+
+	/*
+	 * Since the register values are computed and written within
+	 * __omap_dm_timer_stop, we need to use read to retrieve the
+	 * context.
+	 */
+	timer->context.tclr =
+			omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
+	timer->context.tisr = __raw_readl(timer->irq_stat);
+	omap_dm_timer_disable(timer);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_stop);
-- 
1.7.0.4
