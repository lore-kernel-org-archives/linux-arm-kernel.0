From: jtzhou@marvell.com (Jett.Zhou)
Date: Thu, 27 Jun 2013 19:28:52 +0800
Subject: [V3 3/7] video: mmp: optimize some register setting code
Message-ID: <1372332532-6821-1-git-send-email-jtzhou@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guoqing Li <ligq@marvell.com>

There are dumplicate code of the smooth setting based on different
path, optimized the routine and use readl_relaxed instead.

Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
Signed-off-by: Jing Xiang <jxiang@marvell.com>
Signed-off-by: Guoqing Li <ligq@marvell.com>
---
 drivers/video/mmp/hw/mmp_ctrl.c |   22 +++++++---------------
 1 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/video/mmp/hw/mmp_ctrl.c b/drivers/video/mmp/hw/mmp_ctrl.c
index 8801bc9..9ea3f0a 100644
--- a/drivers/video/mmp/hw/mmp_ctrl.c
+++ b/drivers/video/mmp/hw/mmp_ctrl.c
@@ -53,7 +53,7 @@ static irqreturn_t ctrl_handle_irq(int irq, void *dev_id)
 		tmp = readl_relaxed(ctrl->reg_base + SPU_IRQ_ISR);
 		if (tmp & isr)
 			writel_relaxed(~isr, ctrl->reg_base + SPU_IRQ_ISR);
-	} while ((isr = readl(ctrl->reg_base + SPU_IRQ_ISR)) & imask);
+	} while ((isr = readl_relaxed(ctrl->reg_base + SPU_IRQ_ISR)) & imask);
 
 	return IRQ_HANDLED;
 }
@@ -372,20 +372,12 @@ static void path_set_default(struct mmp_path *path)
 	 * bus arbiter for faster read if not tv path;
 	 * 2.enable horizontal smooth filter;
 	 */
-	if (PATH_PN == path->id) {
-		mask = CFG_GRA_HSMOOTH_MASK | CFG_DMA_HSMOOTH_MASK
-			| CFG_ARBFAST_ENA(1);
-		tmp = readl_relaxed(ctrl_regs(path) + dma_ctrl(0, path->id));
-		tmp |= mask;
-		writel_relaxed(tmp, ctrl_regs(path) + dma_ctrl(0, path->id));
-	} else if (PATH_TV == path->id) {
-		mask = CFG_GRA_HSMOOTH_MASK | CFG_DMA_HSMOOTH_MASK
-			| CFG_ARBFAST_ENA(1);
-		tmp = readl_relaxed(ctrl_regs(path) + dma_ctrl(0, path->id));
-		tmp &= ~mask;
-		tmp |= CFG_GRA_HSMOOTH_MASK | CFG_DMA_HSMOOTH_MASK;
-		writel_relaxed(tmp, ctrl_regs(path) + dma_ctrl(0, path->id));
-	}
+	mask = CFG_GRA_HSMOOTH_MASK | CFG_DMA_HSMOOTH_MASK | CFG_ARBFAST_ENA(1);
+	tmp = readl_relaxed(ctrl_regs(path) + dma_ctrl(0, path->id));
+	tmp |= mask;
+	if (PATH_TV == path->id)
+		tmp &= ~CFG_ARBFAST_ENA(1);
+	writel_relaxed(tmp, ctrl_regs(path) + dma_ctrl(0, path->id));
 }
 
 static int path_init(struct mmphw_path_plat *path_plat,
-- 
1.7.0.4
