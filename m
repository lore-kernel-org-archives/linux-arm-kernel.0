From: xinliang.liu@linaro.org (Xinliang Liu)
Date: Sat, 28 Nov 2015 18:39:05 +0800
Subject: [PATCH v2 10/10] drm/hisilicon: Add support for external bridge
In-Reply-To: <1448707145-69348-1-git-send-email-xinliang.liu@linaro.org>
References: <1448707145-69348-1-git-send-email-xinliang.liu@linaro.org>
Message-ID: <1448707145-69348-11-git-send-email-xinliang.liu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for external HDMI bridge.

Signed-off-by: Xinliang Liu <xinliang.liu@linaro.org>
Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Signed-off-by: Andy Green <andy.green@linaro.org>
---
 drivers/gpu/drm/hisilicon/hisi_drm_dsi.c | 51 ++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/gpu/drm/hisilicon/hisi_drm_dsi.c b/drivers/gpu/drm/hisilicon/hisi_drm_dsi.c
index 066e08d..9e056db 100644
--- a/drivers/gpu/drm/hisilicon/hisi_drm_dsi.c
+++ b/drivers/gpu/drm/hisilicon/hisi_drm_dsi.c
@@ -78,6 +78,7 @@ struct dsi_hw_ctx {
 
 struct hisi_dsi {
 	struct drm_encoder encoder;
+	struct drm_bridge *bridge;
 	struct mipi_dsi_host host;
 	struct drm_display_mode cur_mode;
 	struct dsi_hw_ctx *ctx;
@@ -671,6 +672,25 @@ static int dsi_host_init(struct device *dev, struct hisi_dsi *dsi)
 	return 0;
 }
 
+static int dsi_bridge_init(struct drm_device *dev, struct hisi_dsi *dsi)
+{
+	struct drm_encoder *encoder = &dsi->encoder;
+	struct drm_bridge *bridge = dsi->bridge;
+	int ret;
+
+	/* associate the bridge to dsi encoder */
+	encoder->bridge = bridge;
+	bridge->encoder = encoder;
+
+	ret = drm_bridge_attach(dev, bridge);
+	if (ret) {
+		DRM_ERROR("failed to attach exteranl bridge\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 static int dsi_bind(struct device *dev, struct device *master, void *data)
 {
 	struct dsi_data *ddata = dev_get_drvdata(dev);
@@ -686,6 +706,10 @@ static int dsi_bind(struct device *dev, struct device *master, void *data)
 	if (ret)
 		return ret;
 
+	ret = dsi_bridge_init(drm_dev, dsi);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -702,8 +726,35 @@ static const struct component_ops dsi_ops = {
 static int dsi_parse_dt(struct platform_device *pdev, struct hisi_dsi *dsi)
 {
 	struct dsi_hw_ctx *ctx = dsi->ctx;
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *endpoint, *bridge_node;
+	struct drm_bridge *bridge;
 	struct resource *res;
 
+	/*
+	 * Get the endpoint node. In our case, dsi has one output port
+	 * to which the external HDMI bridge is connected.
+	 */
+	endpoint = of_graph_get_next_endpoint(np, NULL);
+	if (!endpoint) {
+		DRM_ERROR("no valid endpoint node\n");
+		return -ENODEV;
+	}
+	of_node_put(endpoint);
+
+	bridge_node = of_graph_get_remote_port_parent(endpoint);
+	if (!bridge_node) {
+		DRM_ERROR("no valid bridge node\n");
+		return -ENODEV;
+	}
+	of_node_put(bridge_node);
+
+	bridge = of_drm_find_bridge(bridge_node);
+	if (!bridge) {
+		DRM_INFO("wait for external HDMI bridge driver.\n");
+		return -EPROBE_DEFER;
+	}
+	dsi->bridge = bridge;
 
 	ctx->dsi_cfg_clk = devm_clk_get(&pdev->dev, "pclk_dsi");
 	if (IS_ERR(ctx->dsi_cfg_clk)) {
-- 
1.9.1
