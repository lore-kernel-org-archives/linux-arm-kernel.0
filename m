From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 02 Jan 2014 21:28:49 +0000
Subject: [PATCH RFC 36/46] imx-drm: imx-hdmi: initialise drm components
 directly
In-Reply-To: <20140102212528.GD7383@n2100.arm.linux.org.uk>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
Message-ID: <E1Vypov-0007Fv-Pp@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/imx-hdmi.c |   56 +++++++++--------------------------
 1 files changed, 15 insertions(+), 41 deletions(-)

diff --git a/drivers/staging/imx-drm/imx-hdmi.c b/drivers/staging/imx-drm/imx-hdmi.c
index d81940a8904f..512b39710530 100644
--- a/drivers/staging/imx-drm/imx-hdmi.c
+++ b/drivers/staging/imx-drm/imx-hdmi.c
@@ -117,9 +117,7 @@ struct hdmi_data_info {
 
 struct imx_hdmi {
 	struct drm_connector connector;
-	struct imx_drm_connector *imx_drm_connector;
 	struct drm_encoder encoder;
-	struct imx_drm_encoder *imx_drm_encoder;
 
 	enum imx_hdmi_devtype dev_type;
 	struct device *dev;
@@ -1382,10 +1380,6 @@ static enum drm_connector_status imx_hdmi_connector_detect(struct drm_connector
 	return connector_status_connected;
 }
 
-static void imx_hdmi_connector_destroy(struct drm_connector *connector)
-{
-}
-
 static int imx_hdmi_connector_get_modes(struct drm_connector *connector)
 {
 	struct imx_hdmi *hdmi = container_of(connector, struct imx_hdmi,
@@ -1471,13 +1465,8 @@ static void imx_hdmi_encoder_commit(struct drm_encoder *encoder)
 	imx_hdmi_poweron(hdmi);
 }
 
-static void imx_hdmi_encoder_destroy(struct drm_encoder *encoder)
-{
-	return;
-}
-
 static struct drm_encoder_funcs imx_hdmi_encoder_funcs = {
-	.destroy = imx_hdmi_encoder_destroy,
+	.destroy = imx_drm_encoder_destroy,
 };
 
 static struct drm_encoder_helper_funcs imx_hdmi_encoder_helper_funcs = {
@@ -1493,7 +1482,7 @@ static struct drm_connector_funcs imx_hdmi_connector_funcs = {
 	.dpms = drm_helper_connector_dpms,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.detect = imx_hdmi_connector_detect,
-	.destroy = imx_hdmi_connector_destroy,
+	.destroy = imx_drm_connector_destroy,
 };
 
 static struct drm_connector_helper_funcs imx_hdmi_connector_helper_funcs = {
@@ -1533,34 +1522,23 @@ static irqreturn_t imx_hdmi_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int imx_hdmi_register(struct imx_hdmi *hdmi)
+static int imx_hdmi_register(struct drm_device *drm, struct imx_hdmi *hdmi)
 {
 	int ret;
 
-	hdmi->connector.funcs = &imx_hdmi_connector_funcs;
-	hdmi->encoder.funcs = &imx_hdmi_encoder_funcs;
-
-	hdmi->encoder.encoder_type = DRM_MODE_ENCODER_TMDS;
-	hdmi->connector.connector_type = DRM_MODE_CONNECTOR_HDMIA;
+	ret = imx_drm_encoder_parse_of(drm, &hdmi->encoder,
+				       hdmi->dev->of_node);
+	if (ret)
+		return ret;
 
 	drm_encoder_helper_add(&hdmi->encoder, &imx_hdmi_encoder_helper_funcs);
-	ret = imx_drm_add_encoder(&hdmi->encoder, &hdmi->imx_drm_encoder,
-			THIS_MODULE);
-	if (ret) {
-		dev_err(hdmi->dev, "adding encoder failed: %d\n", ret);
-		return ret;
-	}
+	drm_encoder_init(drm, &hdmi->encoder, &imx_hdmi_encoder_funcs,
+			 DRM_MODE_ENCODER_TMDS);
 
 	drm_connector_helper_add(&hdmi->connector,
 			&imx_hdmi_connector_helper_funcs);
-
-	ret = imx_drm_add_connector(&hdmi->connector,
-			&hdmi->imx_drm_connector, THIS_MODULE);
-	if (ret) {
-		imx_drm_remove_encoder(hdmi->imx_drm_encoder);
-		dev_err(hdmi->dev, "adding connector failed: %d\n", ret);
-		return ret;
-	}
+	drm_connector_init(drm, &hdmi->connector, &imx_hdmi_connector_funcs,
+			   DRM_MODE_CONNECTOR_HDMIA);
 
 	hdmi->connector.encoder = &hdmi->encoder;
 
@@ -1592,6 +1570,7 @@ static int imx_hdmi_bind(struct device *dev, struct device *master, void *data)
 	struct platform_device *pdev = to_platform_device(dev);
 	const struct of_device_id *of_id =
 				of_match_device(imx_hdmi_dt_ids, dev);
+	struct drm_device *drm = data;
 	struct device_node *np = dev->of_node;
 	struct device_node *ddc_node;
 	struct imx_hdmi *hdmi;
@@ -1699,12 +1678,10 @@ static int imx_hdmi_bind(struct device *dev, struct device *master, void *data)
 	if (ret)
 		goto err_iahb;
 
-	ret = imx_hdmi_register(hdmi);
+	ret = imx_hdmi_register(drm, hdmi);
 	if (ret)
 		goto err_iahb;
 
-	imx_drm_encoder_add_possible_crtcs(hdmi->imx_drm_encoder, np);
-
 	dev_set_drvdata(dev, hdmi);
 
 	return 0;
@@ -1721,12 +1698,9 @@ static void imx_hdmi_unbind(struct device *dev, struct device *master,
 	void *data)
 {
 	struct imx_hdmi *hdmi = dev_get_drvdata(dev);
-	struct drm_connector *connector = &hdmi->connector;
-	struct drm_encoder *encoder = &hdmi->encoder;
 
-	drm_mode_connector_detach_encoder(connector, encoder);
-	imx_drm_remove_connector(hdmi->imx_drm_connector);
-	imx_drm_remove_encoder(hdmi->imx_drm_encoder);
+	hdmi->connector.funcs->destroy(&hdmi->connector);
+	hdmi->encoder.funcs->destroy(&hdmi->encoder);
 
 	clk_disable_unprepare(hdmi->iahb_clk);
 	clk_disable_unprepare(hdmi->isfr_clk);
-- 
1.7.4.4
