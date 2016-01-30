From: xinliang.liu@linaro.org (Xinliang Liu)
Date: Sat, 30 Jan 2016 16:54:34 +0800
Subject: [PATCH v3 09/10] drm/hisilicon: Add support for external bridge
In-Reply-To: <1454144075-74361-1-git-send-email-xinliang.liu@linaro.org>
References: <1454144075-74361-1-git-send-email-xinliang.liu@linaro.org>
Message-ID: <1454144075-74361-10-git-send-email-xinliang.liu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for external HDMI bridge.

Signed-off-by: Xinliang Liu <xinliang.liu@linaro.org>

v3:
- Fix a typo: s/exteranl/external.
v2:
- Remove abtraction layer.

---
 drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c | 52 ++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c b/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
index 2837af01e935..1342d84d7c68 100644
--- a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
+++ b/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
@@ -79,6 +79,7 @@ struct dsi_hw_ctx {
 
 struct dw_dsi {
 	struct drm_encoder encoder;
+	struct drm_bridge *bridge;
 	struct mipi_dsi_host host;
 	struct drm_display_mode cur_mode;
 	struct dsi_hw_ctx *ctx;
@@ -688,6 +689,25 @@ static int dsi_host_init(struct device *dev, struct dw_dsi *dsi)
 	return 0;
 }
 
+static int dsi_bridge_init(struct drm_device *dev, struct dw_dsi *dsi)
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
+		DRM_ERROR("failed to attach external bridge\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 static int dsi_bind(struct device *dev, struct device *master, void *data)
 {
 	struct dsi_data *ddata = dev_get_drvdata(dev);
@@ -703,6 +723,10 @@ static int dsi_bind(struct device *dev, struct device *master, void *data)
 	if (ret)
 		return ret;
 
+	ret = dsi_bridge_init(drm_dev, dsi);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -719,8 +743,36 @@ static const struct component_ops dsi_ops = {
 static int dsi_parse_dt(struct platform_device *pdev, struct dw_dsi *dsi)
 {
 	struct dsi_hw_ctx *ctx = dsi->ctx;
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *endpoint, *bridge_node;
+	struct drm_bridge *bridge;
 	struct resource *res;
 
+	/*
+	 * Get the endpoint node. In our case, dsi has one output port1
+	 * to which the external HDMI bridge is connected.
+	 */
+	endpoint = of_graph_get_endpoint_by_regs(np, 1, -1);
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
+
 	ctx->dsi_cfg_clk = devm_clk_get(&pdev->dev, "pclk_dsi");
 	if (IS_ERR(ctx->dsi_cfg_clk)) {
 		DRM_ERROR("failed to get dsi plck clock\n");
-- 
1.9.1
