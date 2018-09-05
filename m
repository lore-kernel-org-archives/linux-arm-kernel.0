From: bibby.hsieh@mediatek.com (Bibby Hsieh)
Date: Wed, 5 Sep 2018 16:31:38 +0800
Subject: [PATCH v2 05/13] drm/mediatek: dpi use new API for finding bridge
In-Reply-To: <20180905083146.14727-1-bibby.hsieh@mediatek.com>
References: <20180905083146.14727-1-bibby.hsieh@mediatek.com>
Message-ID: <20180905083146.14727-6-bibby.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: chunhui dai <chunhui.dai@mediatek.com>

Using new API for finding bridge.

Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index 3758cfeb586b..ed2c153c70a2 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -14,6 +14,7 @@
 #include <drm/drmP.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_of.h>
 #include <linux/kernel.h>
 #include <linux/component.h>
 #include <linux/platform_device.h>
@@ -708,7 +709,6 @@ static int mtk_dpi_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct mtk_dpi *dpi;
 	struct resource *mem;
-	struct device_node *bridge_node;
 	int comp_id;
 	const struct of_device_id *match;
 	int ret;
@@ -758,16 +758,13 @@ static int mtk_dpi_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	bridge_node = of_graph_get_remote_node(dev->of_node, 0, 0);
-	if (!bridge_node)
-		return -ENODEV;
-
-	dev_info(dev, "Found bridge node: %pOF\n", bridge_node);
-
-	dpi->bridge = of_drm_find_bridge(bridge_node);
-	of_node_put(bridge_node);
-	if (!dpi->bridge)
+	ret = drm_of_find_panel_or_bridge(dev->of_node, 0, 0,
+					  NULL, &dpi->bridge);
+	if (ret) {
+		dev_err(dev, "Failed to find panel or bridge: %d\n", ret);
 		return -EPROBE_DEFER;
+	}
+	dev_info(dev, "Found bridge node: %pOF\n", dpi->bridge);
 
 	comp_id = mtk_ddp_comp_get_id(dev->of_node, MTK_DPI);
 	if (comp_id < 0) {
-- 
2.12.5.2.gbdf23ab
