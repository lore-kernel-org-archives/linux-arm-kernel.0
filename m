From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 02 Jan 2014 21:28:44 +0000
Subject: [PATCH RFC 35/46] imx-drm: parallel-display,imx-tve,imx-ldb:
 initialise drm components directly
In-Reply-To: <20140102212528.GD7383@n2100.arm.linux.org.uk>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
Message-ID: <E1Vypoq-0007Fr-MA@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that our bind function is only ever called during the main DRM
driver ->load callback, we don't need to have the imx_drm_connector or
imx_drm_encoder abstractions anymore.  So let's get rid of it, and move
the DRM connector and encoder setup into the connector support files.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/imx-ldb.c          |   68 +++++++++-------------------
 drivers/staging/imx-drm/imx-tve.c          |   58 ++++++-----------------
 drivers/staging/imx-drm/parallel-display.c |   61 +++++++------------------
 3 files changed, 54 insertions(+), 133 deletions(-)

diff --git a/drivers/staging/imx-drm/imx-ldb.c b/drivers/staging/imx-drm/imx-ldb.c
index 5b71f49faa0a..601f9c5c5340 100644
--- a/drivers/staging/imx-drm/imx-ldb.c
+++ b/drivers/staging/imx-drm/imx-ldb.c
@@ -59,9 +59,8 @@ struct imx_ldb;
 struct imx_ldb_channel {
 	struct imx_ldb *ldb;
 	struct drm_connector connector;
-	struct imx_drm_connector *imx_drm_connector;
 	struct drm_encoder encoder;
-	struct imx_drm_encoder *imx_drm_encoder;
+	struct device_node *child;
 	int chno;
 	void *edid;
 	int edid_len;
@@ -92,11 +91,6 @@ static enum drm_connector_status imx_ldb_connector_detect(
 	return connector_status_connected;
 }
 
-static void imx_ldb_connector_destroy(struct drm_connector *connector)
-{
-	/* do not free here */
-}
-
 static int imx_ldb_connector_get_modes(struct drm_connector *connector)
 {
 	struct imx_ldb_channel *imx_ldb_ch = con_to_imx_ldb_ch(connector);
@@ -309,16 +303,11 @@ static void imx_ldb_encoder_disable(struct drm_encoder *encoder)
 	}
 }
 
-static void imx_ldb_encoder_destroy(struct drm_encoder *encoder)
-{
-	/* do not free here */
-}
-
 static struct drm_connector_funcs imx_ldb_connector_funcs = {
 	.dpms = drm_helper_connector_dpms,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.detect = imx_ldb_connector_detect,
-	.destroy = imx_ldb_connector_destroy,
+	.destroy = imx_drm_connector_destroy,
 };
 
 static struct drm_connector_helper_funcs imx_ldb_connector_helper_funcs = {
@@ -328,7 +317,7 @@ static struct drm_connector_helper_funcs imx_ldb_connector_helper_funcs = {
 };
 
 static struct drm_encoder_funcs imx_ldb_encoder_funcs = {
-	.destroy = imx_ldb_encoder_destroy,
+	.destroy = imx_drm_encoder_destroy,
 };
 
 static struct drm_encoder_helper_funcs imx_ldb_encoder_helper_funcs = {
@@ -355,45 +344,36 @@ static int imx_ldb_get_clk(struct imx_ldb *ldb, int chno)
 	return PTR_ERR_OR_ZERO(ldb->clk_pll[chno]);
 }
 
-static int imx_ldb_register(struct imx_ldb_channel *imx_ldb_ch)
+static int imx_ldb_register(struct drm_device *drm,
+	struct imx_ldb_channel *imx_ldb_ch)
 {
-	int ret;
 	struct imx_ldb *ldb = imx_ldb_ch->ldb;
+	int ret;
+
+	ret = imx_drm_encoder_parse_of(drm, &imx_ldb_ch->encoder,
+				       imx_ldb_ch->child);
+	if (ret)
+		return ret;
 
 	ret = imx_ldb_get_clk(ldb, imx_ldb_ch->chno);
 	if (ret)
 		return ret;
+
 	if (ldb->ldb_ctrl & LDB_SPLIT_MODE_EN) {
-		ret |= imx_ldb_get_clk(ldb, 1);
+		ret = imx_ldb_get_clk(ldb, 1);
 		if (ret)
 			return ret;
 	}
 
-	imx_ldb_ch->connector.funcs = &imx_ldb_connector_funcs;
-	imx_ldb_ch->encoder.funcs = &imx_ldb_encoder_funcs;
-
-	imx_ldb_ch->encoder.encoder_type = DRM_MODE_ENCODER_LVDS;
-	imx_ldb_ch->connector.connector_type = DRM_MODE_CONNECTOR_LVDS;
-
 	drm_encoder_helper_add(&imx_ldb_ch->encoder,
 			&imx_ldb_encoder_helper_funcs);
-	ret = imx_drm_add_encoder(&imx_ldb_ch->encoder,
-			&imx_ldb_ch->imx_drm_encoder, THIS_MODULE);
-	if (ret) {
-		dev_err(ldb->dev, "adding encoder failed with %d\n", ret);
-		return ret;
-	}
+	drm_encoder_init(drm, &imx_ldb_ch->encoder, &imx_ldb_encoder_funcs,
+			 DRM_MODE_ENCODER_LVDS);
 
 	drm_connector_helper_add(&imx_ldb_ch->connector,
 			&imx_ldb_connector_helper_funcs);
-
-	ret = imx_drm_add_connector(&imx_ldb_ch->connector,
-			&imx_ldb_ch->imx_drm_connector, THIS_MODULE);
-	if (ret) {
-		imx_drm_remove_encoder(imx_ldb_ch->imx_drm_encoder);
-		dev_err(ldb->dev, "adding connector failed with %d\n", ret);
-		return ret;
-	}
+	drm_connector_init(drm, &imx_ldb_ch->connector,
+			   &imx_ldb_connector_funcs, DRM_MODE_CONNECTOR_LVDS);
 
 	drm_mode_connector_attach_encoder(&imx_ldb_ch->connector,
 			&imx_ldb_ch->encoder);
@@ -454,6 +434,7 @@ MODULE_DEVICE_TABLE(of, imx_ldb_dt_ids);
 
 static int imx_ldb_bind(struct device *dev, struct device *master, void *data)
 {
+	struct drm_device *drm = data;
 	struct device_node *np = dev->of_node;
 	const struct of_device_id *of_id =
 			of_match_device(imx_ldb_dt_ids, dev);
@@ -524,6 +505,7 @@ static int imx_ldb_bind(struct device *dev, struct device *master, void *data)
 		channel = &imx_ldb->channel[i];
 		channel->ldb = imx_ldb;
 		channel->chno = i;
+		channel->child = child;
 
 		edidp = of_get_property(child, "edid", &channel->edid_len);
 		if (edidp) {
@@ -566,11 +548,9 @@ static int imx_ldb_bind(struct device *dev, struct device *master, void *data)
 			return -EINVAL;
 		}
 
-		ret = imx_ldb_register(channel);
+		ret = imx_ldb_register(drm, channel);
 		if (ret)
 			return ret;
-
-		imx_drm_encoder_add_possible_crtcs(channel->imx_drm_encoder, child);
 	}
 
 	dev_set_drvdata(dev, imx_ldb);
@@ -586,13 +566,9 @@ static void imx_ldb_unbind(struct device *dev, struct device *master,
 
 	for (i = 0; i < 2; i++) {
 		struct imx_ldb_channel *channel = &imx_ldb->channel[i];
-		struct drm_connector *connector = &channel->connector;
-		struct drm_encoder *encoder = &channel->encoder;
-
-		drm_mode_connector_detach_encoder(connector, encoder);
 
-		imx_drm_remove_connector(channel->imx_drm_connector);
-		imx_drm_remove_encoder(channel->imx_drm_encoder);
+		channel->connector.funcs->destroy(&channel->connector);
+		channel->encoder.funcs->destroy(&channel->encoder);
 	}
 }
 
diff --git a/drivers/staging/imx-drm/imx-tve.c b/drivers/staging/imx-drm/imx-tve.c
index f8720f1ef86e..5cb6339cac82 100644
--- a/drivers/staging/imx-drm/imx-tve.c
+++ b/drivers/staging/imx-drm/imx-tve.c
@@ -111,9 +111,7 @@ enum {
 
 struct imx_tve {
 	struct drm_connector connector;
-	struct imx_drm_connector *imx_drm_connector;
 	struct drm_encoder encoder;
-	struct imx_drm_encoder *imx_drm_encoder;
 	struct device *dev;
 	spinlock_t lock;	/* register lock */
 	bool enabled;
@@ -226,11 +224,6 @@ static enum drm_connector_status imx_tve_connector_detect(
 	return connector_status_connected;
 }
 
-static void imx_tve_connector_destroy(struct drm_connector *connector)
-{
-	/* do not free here */
-}
-
 static int imx_tve_connector_get_modes(struct drm_connector *connector)
 {
 	struct imx_tve *tve = con_to_tve(connector);
@@ -368,16 +361,11 @@ static void imx_tve_encoder_disable(struct drm_encoder *encoder)
 	tve_disable(tve);
 }
 
-static void imx_tve_encoder_destroy(struct drm_encoder *encoder)
-{
-	/* do not free here */
-}
-
 static struct drm_connector_funcs imx_tve_connector_funcs = {
 	.dpms = drm_helper_connector_dpms,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.detect = imx_tve_connector_detect,
-	.destroy = imx_tve_connector_destroy,
+	.destroy = imx_drm_connector_destroy,
 };
 
 static struct drm_connector_helper_funcs imx_tve_connector_helper_funcs = {
@@ -387,7 +375,7 @@ static struct drm_connector_helper_funcs imx_tve_connector_helper_funcs = {
 };
 
 static struct drm_encoder_funcs imx_tve_encoder_funcs = {
-	.destroy = imx_tve_encoder_destroy,
+	.destroy = imx_drm_encoder_destroy,
 };
 
 static struct drm_encoder_helper_funcs imx_tve_encoder_helper_funcs = {
@@ -507,7 +495,7 @@ static int tve_clk_init(struct imx_tve *tve, void __iomem *base)
 	return 0;
 }
 
-static int imx_tve_register(struct imx_tve *tve)
+static int imx_tve_register(struct drm_device *drm, struct imx_tve *tve)
 {
 	int encoder_type;
 	int ret;
@@ -515,30 +503,19 @@ static int imx_tve_register(struct imx_tve *tve)
 	encoder_type = tve->mode == TVE_MODE_VGA ?
 				DRM_MODE_ENCODER_DAC : DRM_MODE_ENCODER_TVDAC;
 
-	tve->connector.funcs = &imx_tve_connector_funcs;
-	tve->encoder.funcs = &imx_tve_encoder_funcs;
-
-	tve->encoder.encoder_type = encoder_type;
-	tve->connector.connector_type = DRM_MODE_CONNECTOR_VGA;
+	ret = imx_drm_encoder_parse_of(drm, &tve->encoder,
+				       tve->dev->of_node);
+	if (ret)
+		return ret;
 
 	drm_encoder_helper_add(&tve->encoder, &imx_tve_encoder_helper_funcs);
-	ret = imx_drm_add_encoder(&tve->encoder, &tve->imx_drm_encoder,
-			THIS_MODULE);
-	if (ret) {
-		dev_err(tve->dev, "adding encoder failed with %d\n", ret);
-		return ret;
-	}
+	drm_encoder_init(drm, &tve->encoder, &imx_tve_encoder_funcs,
+			 encoder_type);
 
 	drm_connector_helper_add(&tve->connector,
 			&imx_tve_connector_helper_funcs);
-
-	ret = imx_drm_add_connector(&tve->connector,
-			&tve->imx_drm_connector, THIS_MODULE);
-	if (ret) {
-		imx_drm_remove_encoder(tve->imx_drm_encoder);
-		dev_err(tve->dev, "adding connector failed with %d\n", ret);
-		return ret;
-	}
+	drm_connector_init(drm, &tve->connector, &imx_tve_connector_funcs,
+			   DRM_MODE_CONNECTOR_VGA);
 
 	drm_mode_connector_attach_encoder(&tve->connector, &tve->encoder);
 
@@ -587,6 +564,7 @@ const int of_get_tve_mode(struct device_node *np)
 static int imx_tve_bind(struct device *dev, struct device *master, void *data)
 {
 	struct platform_device *pdev = to_platform_device(dev);
+	struct drm_device *drm = data;
 	struct device_node *np = dev->of_node;
 	struct device_node *ddc_node;
 	struct imx_tve *tve;
@@ -701,12 +679,10 @@ static int imx_tve_bind(struct device *dev, struct device *master, void *data)
 	/* disable cable detection for VGA mode */
 	ret = regmap_write(tve->regmap, TVE_CD_CONT_REG, 0);
 
-	ret = imx_tve_register(tve);
+	ret = imx_tve_register(drm, tve);
 	if (ret)
 		return ret;
 
-	ret = imx_drm_encoder_add_possible_crtcs(tve->imx_drm_encoder, np);
-
 	dev_set_drvdata(dev, tve);
 
 	return 0;
@@ -716,13 +692,9 @@ static void imx_tve_unbind(struct device *dev, struct device *master,
 	void *data)
 {
 	struct imx_tve *tve = dev_get_drvdata(dev);
-	struct drm_connector *connector = &tve->connector;
-	struct drm_encoder *encoder = &tve->encoder;
-
-	drm_mode_connector_detach_encoder(connector, encoder);
 
-	imx_drm_remove_connector(tve->imx_drm_connector);
-	imx_drm_remove_encoder(tve->imx_drm_encoder);
+	tve->connector.funcs->destroy(&tve->connector);
+	tve->encoder.funcs->destroy(&tve->encoder);
 
 	if (!IS_ERR(tve->dac_reg))
 		regulator_disable(tve->dac_reg);
diff --git a/drivers/staging/imx-drm/parallel-display.c b/drivers/staging/imx-drm/parallel-display.c
index 110c0021a797..72c17f0e80be 100644
--- a/drivers/staging/imx-drm/parallel-display.c
+++ b/drivers/staging/imx-drm/parallel-display.c
@@ -32,9 +32,7 @@
 
 struct imx_parallel_display {
 	struct drm_connector connector;
-	struct imx_drm_connector *imx_drm_connector;
 	struct drm_encoder encoder;
-	struct imx_drm_encoder *imx_drm_encoder;
 	struct device *dev;
 	void *edid;
 	int edid_len;
@@ -49,11 +47,6 @@ static enum drm_connector_status imx_pd_connector_detect(
 	return connector_status_connected;
 }
 
-static void imx_pd_connector_destroy(struct drm_connector *connector)
-{
-	/* do not free here */
-}
-
 static int imx_pd_connector_get_modes(struct drm_connector *connector)
 {
 	struct imx_parallel_display *imxpd = con_to_imxpd(connector);
@@ -125,16 +118,11 @@ static void imx_pd_encoder_disable(struct drm_encoder *encoder)
 {
 }
 
-static void imx_pd_encoder_destroy(struct drm_encoder *encoder)
-{
-	/* do not free here */
-}
-
 static struct drm_connector_funcs imx_pd_connector_funcs = {
 	.dpms = drm_helper_connector_dpms,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.detect = imx_pd_connector_detect,
-	.destroy = imx_pd_connector_destroy,
+	.destroy = imx_drm_connector_destroy,
 };
 
 static struct drm_connector_helper_funcs imx_pd_connector_helper_funcs = {
@@ -144,7 +132,7 @@ static struct drm_connector_helper_funcs imx_pd_connector_helper_funcs = {
 };
 
 static struct drm_encoder_funcs imx_pd_encoder_funcs = {
-	.destroy = imx_pd_encoder_destroy,
+	.destroy = imx_drm_encoder_destroy,
 };
 
 static struct drm_encoder_helper_funcs imx_pd_encoder_helper_funcs = {
@@ -156,36 +144,26 @@ static struct drm_encoder_helper_funcs imx_pd_encoder_helper_funcs = {
 	.disable = imx_pd_encoder_disable,
 };
 
-static int imx_pd_register(struct imx_parallel_display *imxpd)
+static int imx_pd_register(struct drm_device *drm,
+	struct imx_parallel_display *imxpd)
 {
 	int ret;
 
-	drm_mode_connector_attach_encoder(&imxpd->connector, &imxpd->encoder);
-
-	imxpd->connector.funcs = &imx_pd_connector_funcs;
-	imxpd->encoder.funcs = &imx_pd_encoder_funcs;
-
-	imxpd->encoder.encoder_type = DRM_MODE_ENCODER_NONE;
-	imxpd->connector.connector_type = DRM_MODE_CONNECTOR_VGA;
+	ret = imx_drm_encoder_parse_of(drm, &imxpd->encoder,
+				       imxpd->dev->of_node);
+	if (ret)
+		return ret;
 
 	drm_encoder_helper_add(&imxpd->encoder, &imx_pd_encoder_helper_funcs);
-	ret = imx_drm_add_encoder(&imxpd->encoder, &imxpd->imx_drm_encoder,
-			THIS_MODULE);
-	if (ret) {
-		dev_err(imxpd->dev, "adding encoder failed with %d\n", ret);
-		return ret;
-	}
+	drm_encoder_init(drm, &imxpd->encoder, &imx_pd_encoder_funcs,
+			 DRM_MODE_ENCODER_NONE);
 
 	drm_connector_helper_add(&imxpd->connector,
 			&imx_pd_connector_helper_funcs);
+	drm_connector_init(drm, &imxpd->connector, &imx_pd_connector_funcs,
+			   DRM_MODE_CONNECTOR_VGA);
 
-	ret = imx_drm_add_connector(&imxpd->connector,
-			&imxpd->imx_drm_connector, THIS_MODULE);
-	if (ret) {
-		imx_drm_remove_encoder(imxpd->imx_drm_encoder);
-		dev_err(imxpd->dev, "adding connector failed with %d\n", ret);
-		return ret;
-	}
+	drm_mode_connector_attach_encoder(&imxpd->connector, &imxpd->encoder);
 
 	imxpd->connector.encoder = &imxpd->encoder;
 
@@ -194,6 +172,7 @@ static int imx_pd_register(struct imx_parallel_display *imxpd)
 
 static int imx_pd_bind(struct device *dev, struct device *master, void *data)
 {
+	struct drm_device *drm = data;
 	struct device_node *np = dev->of_node;
 	const u8 *edidp;
 	struct imx_parallel_display *imxpd;
@@ -220,12 +199,10 @@ static int imx_pd_bind(struct device *dev, struct device *master, void *data)
 
 	imxpd->dev = dev;
 
-	ret = imx_pd_register(imxpd);
+	ret = imx_pd_register(drm, imxpd);
 	if (ret)
 		return ret;
 
-	ret = imx_drm_encoder_add_possible_crtcs(imxpd->imx_drm_encoder, np);
-
 	dev_set_drvdata(dev, imxpd);
 
 	return 0;
@@ -235,13 +212,9 @@ static void imx_pd_unbind(struct device *dev, struct device *master,
 	void *data)
 {
 	struct imx_parallel_display *imxpd = dev_get_drvdata(dev);
-	struct drm_connector *connector = &imxpd->connector;
-	struct drm_encoder *encoder = &imxpd->encoder;
-
-	drm_mode_connector_detach_encoder(connector, encoder);
 
-	imx_drm_remove_connector(imxpd->imx_drm_connector);
-	imx_drm_remove_encoder(imxpd->imx_drm_encoder);
+	imxpd->encoder.funcs->destroy(&imxpd->encoder);
+	imxpd->connector.funcs->destroy(&imxpd->connector);
 }
 
 static const struct component_ops imx_pd_ops = {
-- 
1.7.4.4
