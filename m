From: matthias.bgg@kernel.org (matthias.bgg at kernel.org)
Date: Tue, 24 Apr 2018 11:47:04 +0200
Subject: [v2 resend 07/10] drm/mediatek: Add mfd support for mt8173
In-Reply-To: <cover.1524563001.git.mbrugger@suse.com>
References: <cover.1524563001.git.mbrugger@suse.com>
Message-ID: <ae6e77bc3f5c29ce53e248162a42f4eb4e42a417.1524563001.git.mbrugger@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Matthias Brugger <mbrugger@suse.com>

Use the MFD device for SoC mt8173. Probing via devicetree
is no longer needed for any SoC, so delete it.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 88ee35907744..3cc433ebfa8f 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -399,20 +399,12 @@ static int mtk_drm_probe(struct platform_device *pdev)
 	INIT_WORK(&private->commit.work, mtk_atomic_work);
 	private->data = of_device_get_match_data(dev);
 
-	/* Check if called from mfd */
-	if (!dev->of_node) {
-		mmsys_node = pdev->dev.parent->of_node;
-		private->data = (struct mtk_mmsys_driver_data *)
-				platform_get_device_id(pdev)->driver_data;
-		private->config_regs =
-			syscon_node_to_regmap(mmsys_node);
-		parent_node = mmsys_node->parent;
-	} else {
-		private->config_regs = syscon_node_to_regmap(dev->of_node);
-		if (IS_ERR(private->config_regs))
-			return PTR_ERR(private->config_regs);
-		parent_node = dev->of_node->parent;
-	}
+	mmsys_node = pdev->dev.parent->of_node;
+	private->data = (struct mtk_mmsys_driver_data *)
+			platform_get_device_id(pdev)->driver_data;
+	private->config_regs =
+		syscon_node_to_regmap(mmsys_node);
+	parent_node = mmsys_node->parent;
 
 	/* Iterate over sibling DISP function blocks */
 	for_each_child_of_node(parent_node, node) {
@@ -555,14 +547,9 @@ static int mtk_drm_sys_resume(struct device *dev)
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
@@ -572,7 +559,6 @@ static struct platform_driver mtk_drm_platform_driver = {
 	.remove	= mtk_drm_remove,
 	.driver	= {
 		.name	= "mediatek-drm",
-		.of_match_table = mtk_drm_of_ids,
 		.pm     = &mtk_drm_pm_ops,
 	},
 	.id_table = mtk_drm_ids,
-- 
2.16.3
