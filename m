From: xinliang.liu@linaro.org (Xinliang Liu)
Date: Sat, 28 Nov 2015 18:39:04 +0800
Subject: [PATCH v2 09/10] drm/hisilicon: Add dsi host driver
In-Reply-To: <1448707145-69348-1-git-send-email-xinliang.liu@linaro.org>
References: <1448707145-69348-1-git-send-email-xinliang.liu@linaro.org>
Message-ID: <1448707145-69348-10-git-send-email-xinliang.liu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add dsi host driver for hi6220 SoC.

Signed-off-by: Xinliang Liu <xinliang.liu@linaro.org>
Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Signed-off-by: Andy Green <andy.green@linaro.org>
---
 drivers/gpu/drm/hisilicon/hisi_drm_dsi.c | 50 ++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/gpu/drm/hisilicon/hisi_drm_dsi.c b/drivers/gpu/drm/hisilicon/hisi_drm_dsi.c
index 7a6cf66..066e08d 100644
--- a/drivers/gpu/drm/hisilicon/hisi_drm_dsi.c
+++ b/drivers/gpu/drm/hisilicon/hisi_drm_dsi.c
@@ -78,6 +78,7 @@ struct dsi_hw_ctx {
 
 struct hisi_dsi {
 	struct drm_encoder encoder;
+	struct mipi_dsi_host host;
 	struct drm_display_mode cur_mode;
 	struct dsi_hw_ctx *ctx;
 	struct mipi_phy_register phy;
@@ -625,6 +626,51 @@ static int hisi_drm_encoder_init(struct drm_device *dev,
 	return 0;
 }
 
+static int dsi_host_attach(struct mipi_dsi_host *host,
+			   struct mipi_dsi_device *mdsi)
+{
+	struct hisi_dsi *dsi = host_to_dsi(host);
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
+static struct mipi_dsi_host_ops dsi_host_ops = {
+	.attach = dsi_host_attach,
+	.detach = dsi_host_detach,
+};
+
+static int dsi_host_init(struct device *dev, struct hisi_dsi *dsi)
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
@@ -636,6 +682,10 @@ static int dsi_bind(struct device *dev, struct device *master, void *data)
 	if (ret)
 		return ret;
 
+	ret = dsi_host_init(dev, dsi);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
-- 
1.9.1
