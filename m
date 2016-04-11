From: xinliang.liu@linaro.org (Xinliang Liu)
Date: Mon, 11 Apr 2016 16:55:42 +0800
Subject: [PATCH v8 09/10] drm/hisilicon: Add support for external bridge
In-Reply-To: <1460364943-76135-1-git-send-email-xinliang.liu@linaro.org>
References: <1460364943-76135-1-git-send-email-xinliang.liu@linaro.org>
Message-ID: <1460364943-76135-10-git-send-email-xinliang.liu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for external HDMI bridge.

v8: None.
v7: None.
v6: None.
v5: None.
v4: None.
v3:
- Fix a typo: s/exteranl/external.
v2:
- Remove abtraction layer.

Signed-off-by: Xinliang Liu <xinliang.liu@linaro.org>
Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Reviewed-by: Archit Taneja <architt@codeaurora.org>
---
 drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c | 52 ++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c b/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
index ea7711832959..bfbc2159250d 100644
--- a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
+++ b/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
@@ -80,6 +80,7 @@ struct dsi_hw_ctx {
 
 struct dw_dsi {
 	struct drm_encoder encoder;
+	struct drm_bridge *bridge;
 	struct mipi_dsi_host host;
 	struct drm_display_mode cur_mode;
 	struct dsi_hw_ctx *ctx;
@@ -700,6 +701,25 @@ static int dsi_host_init(struct device *dev, struct dw_dsi *dsi)
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
@@ -715,6 +735,10 @@ static int dsi_bind(struct device *dev, struct device *master, void *data)
 	if (ret)
 		return ret;
 
+	ret = dsi_bridge_init(drm_dev, dsi);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -731,8 +755,36 @@ static const struct component_ops dsi_ops = {
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
 	ctx->pclk = devm_clk_get(&pdev->dev, "pclk");
 	if (IS_ERR(ctx->pclk)) {
 		DRM_ERROR("failed to get pclk clock\n");
-- 
2.8.0
