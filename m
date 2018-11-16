From: matthias.bgg@kernel.org (matthias.bgg at kernel.org)
Date: Fri, 16 Nov 2018 13:54:41 +0100
Subject: [PATCH v5 04/12] drm/mediatek: Add support for mmsys through a pdev
In-Reply-To: <20181116125449.23581-1-matthias.bgg@kernel.org>
References: <20181116125449.23581-1-matthias.bgg@kernel.org>
Message-ID: <20181116125449.23581-5-matthias.bgg@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Matthias Brugger <mbrugger@suse.com>

The MMSYS subsystem includes clocks and drm components.
This patch adds an initailization path through a platform device
for the clock part, so that both drivers get probed from the same
device tree compatible.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 23 +++++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_drm_drv.h |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 99dd612a6683..18fc761ba94f 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -199,6 +199,7 @@ static const struct mtk_mmsys_driver_data mt2701_mmsys_driver_data = {
 	.ext_path = mt2701_mtk_ddp_ext,
 	.ext_len = ARRAY_SIZE(mt2701_mtk_ddp_ext),
 	.shadow_register = true,
+	.clk_drv_name = "clk-mt2701-mm",
 };
 
 static const struct mtk_mmsys_driver_data mt2712_mmsys_driver_data = {
@@ -215,6 +216,7 @@ static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
 	.main_len = ARRAY_SIZE(mt8173_mtk_ddp_main),
 	.ext_path = mt8173_mtk_ddp_ext,
 	.ext_len = ARRAY_SIZE(mt8173_mtk_ddp_ext),
+	.clk_drv_name = "clk-mt8173-mm",
 };
 
 static int mtk_drm_kms_init(struct drm_device *drm)
@@ -473,6 +475,24 @@ static int mtk_drm_probe(struct platform_device *pdev)
 	if (IS_ERR(private->config_regs))
 		return PTR_ERR(private->config_regs);
 
+	/*
+	 * For legacy reasons we need to probe the clock driver via
+	 * a platfomr device. This is outdated and should not be used
+	 * in newer SoCs.
+	 */
+	if (private->data->clk_drv_name) {
+		private->clk_dev = platform_device_register_data(dev,
+						private->data->clk_drv_name, -1,
+						NULL, 0);
+
+		if (IS_ERR(private->clk_dev)) {
+			pr_err("failed to register %s platform device\n",
+						private->data->clk_drv_name);
+
+			return PTR_ERR(private->clk_dev);
+		}
+	}
+
 	/* Iterate over sibling DISP function blocks */
 	for_each_child_of_node(dev->of_node->parent, node) {
 		const struct of_device_id *of_id;
@@ -577,6 +597,9 @@ static int mtk_drm_remove(struct platform_device *pdev)
 	for (i = 0; i < DDP_COMPONENT_ID_MAX; i++)
 		of_node_put(private->comp_node[i]);
 
+	if (private->clk_dev)
+		platform_device_unregister(private->clk_dev);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
index ab0adbd7d4ee..515ac4cae922 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
@@ -37,11 +37,13 @@ struct mtk_mmsys_driver_data {
 	unsigned int third_len;
 
 	bool shadow_register;
+	const char *clk_drv_name;
 };
 
 struct mtk_drm_private {
 	struct drm_device *drm;
 	struct device *dma_dev;
+	struct platform_device *clk_dev;
 
 	unsigned int num_pipes;
 
-- 
2.19.1
