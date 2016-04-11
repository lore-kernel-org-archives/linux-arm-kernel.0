From: xinliang.liu@linaro.org (Xinliang Liu)
Date: Mon, 11 Apr 2016 16:55:41 +0800
Subject: [PATCH v8 08/10] drm/hisilicon: Add designware dsi host driver
In-Reply-To: <1460364943-76135-1-git-send-email-xinliang.liu@linaro.org>
References: <1460364943-76135-1-git-send-email-xinliang.liu@linaro.org>
Message-ID: <1460364943-76135-9-git-send-email-xinliang.liu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DesignWare dsi host driver for hi6220 SoC.

v8: None.
v7: None.
v6: None.
v5: None.
v4: None.
v3: None.
v2:
- Remove abtraction layer.

Signed-off-by: Xinliang Liu <xinliang.liu@linaro.org>
Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Reviewed-by: Archit Taneja <architt@codeaurora.org>
---
 drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c | 50 ++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c b/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
index 1a930b77ec53..ea7711832959 100644
--- a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
+++ b/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
@@ -80,6 +80,7 @@ struct dsi_hw_ctx {
 
 struct dw_dsi {
 	struct drm_encoder encoder;
+	struct mipi_dsi_host host;
 	struct drm_display_mode cur_mode;
 	struct dsi_hw_ctx *ctx;
 	struct mipi_phy_params phy;
@@ -654,6 +655,51 @@ static int dw_drm_encoder_init(struct device *dev,
 	return 0;
 }
 
+static int dsi_host_attach(struct mipi_dsi_host *host,
+			   struct mipi_dsi_device *mdsi)
+{
+	struct dw_dsi *dsi = host_to_dsi(host);
+
+	if (mdsi->lanes < 1 || mdsi->lanes > 4) {
+		DRM_ERROR("dsi device params invalid\n");
+		return -EINVAL;
+	}
+
+	dsi->lanes = mdsi->lanes;
+	dsi->format = mdsi->format;
+	dsi->mode_flags = mdsi->mode_flags;
+
+	return 0;
+}
+
+static int dsi_host_detach(struct mipi_dsi_host *host,
+			   struct mipi_dsi_device *mdsi)
+{
+	/* do nothing */
+	return 0;
+}
+
+static const struct mipi_dsi_host_ops dsi_host_ops = {
+	.attach = dsi_host_attach,
+	.detach = dsi_host_detach,
+};
+
+static int dsi_host_init(struct device *dev, struct dw_dsi *dsi)
+{
+	struct mipi_dsi_host *host = &dsi->host;
+	int ret;
+
+	host->dev = dev;
+	host->ops = &dsi_host_ops;
+	ret = mipi_dsi_host_register(host);
+	if (ret) {
+		DRM_ERROR("failed to register dsi host\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 static int dsi_bind(struct device *dev, struct device *master, void *data)
 {
 	struct dsi_data *ddata = dev_get_drvdata(dev);
@@ -665,6 +711,10 @@ static int dsi_bind(struct device *dev, struct device *master, void *data)
 	if (ret)
 		return ret;
 
+	ret = dsi_host_init(dev, dsi);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
-- 
2.8.0
