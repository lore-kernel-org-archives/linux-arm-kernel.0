From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 19 Oct 2017 13:26:08 +0200
Subject: [RFC resend 2/4] drm/mediatek: Add new compatible to probe multimedia
 subsystem.
In-Reply-To: <20171019112610.13645-1-mbrugger@suse.com>
References: <20171019112610.13645-1-mbrugger@suse.com>
Message-ID: <20171019112610.13645-3-mbrugger@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mmsys block is an independent block that probes the
clock driver. The multimedia subsystem therefore does not get
probed. We add a new compatible for the multimedia subsystem.

We pass the mmsys registers via syscon and access them using regmap
instead of relaxed read/write.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c |  4 ++--
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c  | 30 +++++++++++++++++-------------
 drivers/gpu/drm/mediatek/mtk_drm_ddp.h  |  4 ++--
 drivers/gpu/drm/mediatek/mtk_drm_drv.c  | 17 ++++++-----------
 drivers/gpu/drm/mediatek/mtk_drm_drv.h  |  2 +-
 5 files changed, 28 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index 658b8dd45b83..4c65873b4867 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -33,7 +33,7 @@
  * @enabled: records whether crtc_enable succeeded
  * @planes: array of 4 drm_plane structures, one for each overlay plane
  * @pending_planes: whether any plane has pending changes to be applied
- * @config_regs: memory mapped mmsys configuration register space
+ * @config_regs: regmap mapped mmsys configuration register space
  * @mutex: handle to one of the ten disp_mutex streams
  * @ddp_comp_nr: number of components in ddp_comp
  * @ddp_comp: array of pointers the mtk_ddp_comp structures used by this crtc
@@ -48,7 +48,7 @@ struct mtk_drm_crtc {
 	struct drm_plane		planes[OVL_LAYER_NR];
 	bool				pending_planes;
 
-	void __iomem			*config_regs;
+	struct regmap			*config_regs;
 	struct mtk_disp_mutex		*mutex;
 	unsigned int			ddp_comp_nr;
 	struct mtk_ddp_comp		**ddp_comp;
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
index 8130f3dab661..1227d6db07da 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
@@ -185,16 +185,16 @@ static unsigned int mtk_ddp_sel_in(enum mtk_ddp_comp_id cur,
 	return value;
 }
 
-static void mtk_ddp_sout_sel(void __iomem *config_regs,
+static void mtk_ddp_sout_sel(struct regmap *config_regs,
 			     enum mtk_ddp_comp_id cur,
 			     enum mtk_ddp_comp_id next)
 {
 	if (cur == DDP_COMPONENT_BLS && next == DDP_COMPONENT_DSI0)
-		writel_relaxed(BLS_TO_DSI_RDMA1_TO_DPI1,
-			       config_regs + DISP_REG_CONFIG_OUT_SEL);
+		regmap_write(config_regs, DISP_REG_CONFIG_OUT_SEL,
+				BLS_TO_DSI_RDMA1_TO_DPI1);
 }
 
-void mtk_ddp_add_comp_to_path(void __iomem *config_regs,
+void mtk_ddp_add_comp_to_path(struct regmap *config_regs,
 			      enum mtk_ddp_comp_id cur,
 			      enum mtk_ddp_comp_id next)
 {
@@ -202,20 +202,22 @@ void mtk_ddp_add_comp_to_path(void __iomem *config_regs,
 
 	value = mtk_ddp_mout_en(cur, next, &addr);
 	if (value) {
-		reg = readl_relaxed(config_regs + addr) | value;
-		writel_relaxed(reg, config_regs + addr);
+		regmap_read(config_regs, addr, &reg);
+		reg |= value;
+		regmap_write(config_regs, addr, reg);
 	}
 
 	mtk_ddp_sout_sel(config_regs, cur, next);
 
 	value = mtk_ddp_sel_in(cur, next, &addr);
 	if (value) {
-		reg = readl_relaxed(config_regs + addr) | value;
-		writel_relaxed(reg, config_regs + addr);
+		regmap_read(config_regs, addr, &reg);
+		reg |= value;
+		regmap_write(config_regs, addr, reg);
 	}
 }
 
-void mtk_ddp_remove_comp_from_path(void __iomem *config_regs,
+void mtk_ddp_remove_comp_from_path(struct regmap *config_regs,
 				   enum mtk_ddp_comp_id cur,
 				   enum mtk_ddp_comp_id next)
 {
@@ -223,14 +225,16 @@ void mtk_ddp_remove_comp_from_path(void __iomem *config_regs,
 
 	value = mtk_ddp_mout_en(cur, next, &addr);
 	if (value) {
-		reg = readl_relaxed(config_regs + addr) & ~value;
-		writel_relaxed(reg, config_regs + addr);
+		regmap_read(config_regs, addr, &reg);
+		reg &= ~value;
+		regmap_write(config_regs, addr, reg);
 	}
 
 	value = mtk_ddp_sel_in(cur, next, &addr);
 	if (value) {
-		reg = readl_relaxed(config_regs + addr) & ~value;
-		writel_relaxed(reg, config_regs + addr);
+		regmap_read(config_regs, addr, &reg);
+		reg &= ~value;
+		regmap_write(config_regs, addr, reg);
 	}
 }
 
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp.h
index f9a799168077..32e12f33b76a 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.h
@@ -20,10 +20,10 @@ struct regmap;
 struct device;
 struct mtk_disp_mutex;
 
-void mtk_ddp_add_comp_to_path(void __iomem *config_regs,
+void mtk_ddp_add_comp_to_path(struct regmap *config_regs,
 			      enum mtk_ddp_comp_id cur,
 			      enum mtk_ddp_comp_id next);
-void mtk_ddp_remove_comp_from_path(void __iomem *config_regs,
+void mtk_ddp_remove_comp_from_path(struct regmap *config_regs,
 				   enum mtk_ddp_comp_id cur,
 				   enum mtk_ddp_comp_id next);
 
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index a2ca90fc403c..f013d0039821 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -21,6 +21,7 @@
 #include <drm/drm_of.h>
 #include <linux/component.h>
 #include <linux/iommu.h>
+#include <linux/mfd/syscon.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/pm_runtime.h>
@@ -385,7 +386,6 @@ static int mtk_drm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct mtk_drm_private *private;
-	struct resource *mem;
 	struct device_node *node;
 	struct component_match *match = NULL;
 	int ret;
@@ -399,14 +399,9 @@ static int mtk_drm_probe(struct platform_device *pdev)
 	INIT_WORK(&private->commit.work, mtk_atomic_work);
 	private->data = of_device_get_match_data(dev);
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	private->config_regs = devm_ioremap_resource(dev, mem);
-	if (IS_ERR(private->config_regs)) {
-		ret = PTR_ERR(private->config_regs);
-		dev_err(dev, "Failed to ioremap mmsys-config resource: %d\n",
-			ret);
-		return ret;
-	}
+	private->config_regs = syscon_regmap_lookup_by_compatible("mediatek,mmsys");
+	if (IS_ERR(private->config_regs))
+		return PTR_ERR(private->config_regs);
 
 	/* Iterate over sibling DISP function blocks */
 	for_each_child_of_node(dev->of_node->parent, node) {
@@ -550,9 +545,9 @@ static SIMPLE_DEV_PM_OPS(mtk_drm_pm_ops, mtk_drm_sys_suspend,
 			 mtk_drm_sys_resume);
 
 static const struct of_device_id mtk_drm_of_ids[] = {
-	{ .compatible = "mediatek,mt2701-mmsys",
+	{ .compatible = "mediatek,mt2701-dispsys",
 	  .data = &mt2701_mmsys_driver_data},
-	{ .compatible = "mediatek,mt8173-mmsys",
+	{ .compatible = "mediatek,mt8173-dispsys",
 	  .data = &mt8173_mmsys_driver_data},
 	{ }
 };
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
index c3378c452c0a..c6fa0ad458e8 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
@@ -44,7 +44,7 @@ struct mtk_drm_private {
 
 	struct device_node *mutex_node;
 	struct device *mutex_dev;
-	void __iomem *config_regs;
+	struct regmap *config_regs;
 	struct device_node *comp_node[DDP_COMPONENT_ID_MAX];
 	struct mtk_ddp_comp *ddp_comp[DDP_COMPONENT_ID_MAX];
 	const struct mtk_mmsys_driver_data *data;
-- 
2.14.2
