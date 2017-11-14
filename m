From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 14 Nov 2017 22:41:09 +0100
Subject: [PATCH 3/8] drm/mediatek: mt2701: switch to mfd probing.
In-Reply-To: <20171114214114.15793-1-mbrugger@suse.com>
References: <20171114214114.15793-1-mbrugger@suse.com>
Message-ID: <20171114214114.15793-4-mbrugger@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the mtk-mmsys MFD device in place, we switch the probing for
mt2701 from device-tree to mfd.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index dd249cf5121e..5a263aa3ab6e 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -21,6 +21,7 @@
 #include <drm/drm_of.h>
 #include <linux/component.h>
 #include <linux/iommu.h>
+#include <linux/mfd/mmsys.h>
 #include <linux/mfd/syscon.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
@@ -392,9 +393,10 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
 
 static int mtk_drm_probe(struct platform_device *pdev)
 {
+	struct mmsys_dev *mmsys_private;
 	struct device *dev = &pdev->dev;
 	struct mtk_drm_private *private;
-	struct device_node *node;
+	struct device_node *node, *parent_node;
 	struct component_match *match = NULL;
 	int ret;
 	int i;
@@ -407,12 +409,23 @@ static int mtk_drm_probe(struct platform_device *pdev)
 	INIT_WORK(&private->commit.work, mtk_atomic_work);
 	private->data = of_device_get_match_data(dev);
 
-	private->config_regs = syscon_node_to_regmap(dev->of_node);
-	if (IS_ERR(private->config_regs))
-		return PTR_ERR(private->config_regs);
+	/* Check if called from mfd */
+	if (!dev->of_node) {
+		mmsys_private = dev_get_drvdata(pdev->dev.parent);
+		private->data = (struct mtk_mmsys_driver_data *)
+				platform_get_device_id(pdev)->driver_data;
+		private->config_regs =
+			syscon_node_to_regmap(mmsys_private->of_node);
+		parent_node = mmsys_private->of_node->parent;
+	} else {
+		private->config_regs = syscon_node_to_regmap(dev->of_node);
+		if (IS_ERR(private->config_regs))
+			return PTR_ERR(private->config_regs);
+		parent_node = dev->of_node->parent;
+	}
 
 	/* Iterate over sibling DISP function blocks */
-	for_each_child_of_node(dev->of_node->parent, node) {
+	for_each_child_of_node(parent_node, node) {
 		const struct of_device_id *of_id;
 		enum mtk_ddp_comp_type comp_type;
 		int comp_id;
@@ -553,13 +566,17 @@ static SIMPLE_DEV_PM_OPS(mtk_drm_pm_ops, mtk_drm_sys_suspend,
 			 mtk_drm_sys_resume);
 
 static const struct of_device_id mtk_drm_of_ids[] = {
-	{ .compatible = "mediatek,mt2701-mmsys",
-	  .data = &mt2701_mmsys_driver_data},
 	{ .compatible = "mediatek,mt8173-mmsys",
 	  .data = &mt8173_mmsys_driver_data},
 	{ }
 };
 
+static const struct platform_device_id mtk_drm_ids[] = {
+	{ "drm-mt2701-mm", (kernel_ulong_t)&mt2701_mmsys_driver_data },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(platform, mtk_drm_ids);
+
 static struct platform_driver mtk_drm_platform_driver = {
 	.probe	= mtk_drm_probe,
 	.remove	= mtk_drm_remove,
@@ -568,6 +585,7 @@ static struct platform_driver mtk_drm_platform_driver = {
 		.of_match_table = mtk_drm_of_ids,
 		.pm     = &mtk_drm_pm_ops,
 	},
+	.id_table = mtk_drm_ids,
 };
 
 static struct platform_driver * const mtk_drm_drivers[] = {
-- 
2.14.2
