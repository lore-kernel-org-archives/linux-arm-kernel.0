From: matthias.bgg@kernel.org (matthias.bgg at kernel.org)
Date: Tue, 17 Jul 2018 23:59:50 +0200
Subject: [PATCH v4--to=ulrich.hecht+renesas@gmail.com 4/5] drm/mediatek: Add
 support for mmsys through a pdev
In-Reply-To: <20180717215951.378-1-matthias.bgg@kernel.org>
References: <20180717215951.378-1-matthias.bgg@kernel.org>
Message-ID: <20180717215951.378-5-matthias.bgg@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Matthias Brugger <mbrugger@suse.com>

The MMSYS subsystem includes clocks and drm components.
This patch adds an initailization path through a platform device
for the clock part, so that both drivers get probed from the same
device tree compatible.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 18 ++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_drm_drv.h |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index dd249cf5121e..c946aea722e5 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -173,6 +173,7 @@ static const struct mtk_mmsys_driver_data mt2701_mmsys_driver_data = {
 	.ext_path = mt2701_mtk_ddp_ext,
 	.ext_len = ARRAY_SIZE(mt2701_mtk_ddp_ext),
 	.shadow_register = true,
+	.clk_drv_name = "clk-mt2701-mm",
 };
 
 static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
@@ -180,6 +181,7 @@ static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
 	.main_len = ARRAY_SIZE(mt8173_mtk_ddp_main),
 	.ext_path = mt8173_mtk_ddp_ext,
 	.ext_len = ARRAY_SIZE(mt8173_mtk_ddp_ext),
+	.clk_drv_name = "clk-mt8173-mm",
 };
 
 static int mtk_drm_kms_init(struct drm_device *drm)
@@ -411,6 +413,19 @@ static int mtk_drm_probe(struct platform_device *pdev)
 	if (IS_ERR(private->config_regs))
 		return PTR_ERR(private->config_regs);
 
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
@@ -515,6 +530,9 @@ static int mtk_drm_remove(struct platform_device *pdev)
 	for (i = 0; i < DDP_COMPONENT_ID_MAX; i++)
 		of_node_put(private->comp_node[i]);
 
+	if (private->clk_dev)
+		platform_device_unregister(private->clk_dev);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
index 86cec19193c4..200eee5de419 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
@@ -34,11 +34,13 @@ struct mtk_mmsys_driver_data {
 	const enum mtk_ddp_comp_id *ext_path;
 	unsigned int ext_len;
 	bool shadow_register;
+	const char *clk_drv_name;
 };
 
 struct mtk_drm_private {
 	struct drm_device *drm;
 	struct device *dma_dev;
+	struct platform_device *clk_dev;
 
 	unsigned int num_pipes;
 
-- 
2.17.1
