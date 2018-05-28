From: m.purski@samsung.com (Maciej Purski)
Date: Mon, 28 May 2018 11:47:05 +0200
Subject: [PATCH 01/12] drm/exynos: rename "bridge_node" to "mic_bridge_node"
In-Reply-To: <1527500833-16005-1-git-send-email-m.purski@samsung.com>
References: <1527500833-16005-1-git-send-email-m.purski@samsung.com>
 <CGME20180528094722eucas1p28c087e8b9174e0591bf3cb6526885777@eucas1p2.samsung.com>
Message-ID: <1527500833-16005-2-git-send-email-m.purski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When adding support for peripheral out bridges, the "bridge" name
becomes imprecise as it refers to a different device than the
"out_bridge".

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_dsi.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
index eae44fd..9599e6b 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
@@ -279,7 +279,7 @@ struct exynos_dsi {
 	struct list_head transfer_list;
 
 	const struct exynos_dsi_driver_data *driver_data;
-	struct device_node *bridge_node;
+	struct device_node *mic_bridge_node;
 };
 
 #define host_to_dsi(host) container_of(host, struct exynos_dsi, dsi_host)
@@ -1631,7 +1631,7 @@ static int exynos_dsi_parse_dt(struct exynos_dsi *dsi)
 	if (ret < 0)
 		return ret;
 
-	dsi->bridge_node = of_graph_get_remote_node(node, DSI_PORT_IN, 0);
+	dsi->mic_bridge_node = of_graph_get_remote_node(node, DSI_PORT_IN, 0);
 
 	return 0;
 }
@@ -1642,7 +1642,7 @@ static int exynos_dsi_bind(struct device *dev, struct device *master,
 	struct drm_encoder *encoder = dev_get_drvdata(dev);
 	struct exynos_dsi *dsi = encoder_to_dsi(encoder);
 	struct drm_device *drm_dev = data;
-	struct drm_bridge *bridge;
+	struct drm_bridge *mic_bridge;
 	int ret;
 
 	drm_encoder_init(drm_dev, encoder, &exynos_dsi_encoder_funcs,
@@ -1661,10 +1661,10 @@ static int exynos_dsi_bind(struct device *dev, struct device *master,
 		return ret;
 	}
 
-	if (dsi->bridge_node) {
-		bridge = of_drm_find_bridge(dsi->bridge_node);
-		if (bridge)
-			drm_bridge_attach(encoder, bridge, NULL);
+	if (dsi->mic_bridge_node) {
+		mic_bridge = of_drm_find_bridge(dsi->mic_bridge_node);
+		if (mic_bridge)
+			drm_bridge_attach(encoder, mic_bridge, NULL);
 	}
 
 	return mipi_dsi_host_register(&dsi->dsi_host);
@@ -1783,7 +1783,7 @@ static int exynos_dsi_remove(struct platform_device *pdev)
 {
 	struct exynos_dsi *dsi = platform_get_drvdata(pdev);
 
-	of_node_put(dsi->bridge_node);
+	of_node_put(dsi->mic_bridge_node);
 
 	pm_runtime_disable(&pdev->dev);
 
-- 
2.7.4
