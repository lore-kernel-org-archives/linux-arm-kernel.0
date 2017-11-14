From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 14 Nov 2017 22:41:12 +0100
Subject: [PATCH 6/8] drm/mediatek: Add mfd support for mt8173
In-Reply-To: <20171114214114.15793-1-mbrugger@suse.com>
References: <20171114214114.15793-1-mbrugger@suse.com>
Message-ID: <20171114214114.15793-7-mbrugger@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the MFD device for SoC mt8173. Probing via devicetree
is no longer needed for any SoC, so delete it.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 5a263aa3ab6e..1eb02acf229a 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -409,20 +409,12 @@ static int mtk_drm_probe(struct platform_device *pdev)
 	INIT_WORK(&private->commit.work, mtk_atomic_work);
 	private->data = of_device_get_match_data(dev);
 
-	/* Check if called from mfd */
-	if (!dev->of_node) {
-		mmsys_private = dev_get_drvdata(pdev->dev.parent);
-		private->data = (struct mtk_mmsys_driver_data *)
-				platform_get_device_id(pdev)->driver_data;
-		private->config_regs =
-			syscon_node_to_regmap(mmsys_private->of_node);
-		parent_node = mmsys_private->of_node->parent;
-	} else {
-		private->config_regs = syscon_node_to_regmap(dev->of_node);
-		if (IS_ERR(private->config_regs))
-			return PTR_ERR(private->config_regs);
-		parent_node = dev->of_node->parent;
-	}
+	mmsys_private = dev_get_drvdata(pdev->dev.parent);
+	private->data = (struct mtk_mmsys_driver_data *)
+			platform_get_device_id(pdev)->driver_data;
+	private->config_regs =
+		syscon_node_to_regmap(mmsys_private->of_node);
+	parent_node = mmsys_private->of_node->parent;
 
 	/* Iterate over sibling DISP function blocks */
 	for_each_child_of_node(parent_node, node) {
@@ -565,14 +557,9 @@ static int mtk_drm_sys_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(mtk_drm_pm_ops, mtk_drm_sys_suspend,
 			 mtk_drm_sys_resume);
 
-static const struct of_device_id mtk_drm_of_ids[] = {
-	{ .compatible = "mediatek,mt8173-mmsys",
-	  .data = &mt8173_mmsys_driver_data},
-	{ }
-};
-
 static const struct platform_device_id mtk_drm_ids[] = {
 	{ "drm-mt2701-mm", (kernel_ulong_t)&mt2701_mmsys_driver_data },
+	{ "drm-mt8173-mm", (kernel_ulong_t)&mt8173_mmsys_driver_data },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(platform, mtk_drm_ids);
@@ -582,7 +569,6 @@ static struct platform_driver mtk_drm_platform_driver = {
 	.remove	= mtk_drm_remove,
 	.driver	= {
 		.name	= "mediatek-drm",
-		.of_match_table = mtk_drm_of_ids,
 		.pm     = &mtk_drm_pm_ops,
 	},
 	.id_table = mtk_drm_ids,
-- 
2.14.2
