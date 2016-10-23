From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Sun, 23 Oct 2016 20:10:59 +0100
Subject: [PATCH RFC 07/10] drm/i2c: tda998x: separate connector initialisation
In-Reply-To: <20161023191002.GJ1041@n2100.armlinux.org.uk>
References: <20161023191002.GJ1041@n2100.armlinux.org.uk>
Message-ID: <E1byOAd-0005z9-Nb@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Separate out the connector initialisation from the rest of the drivers
initialisation.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 58 +++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index bb5389fbd059..4379c6aa1c48 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -979,6 +979,37 @@ const struct drm_connector_helper_funcs tda998x_connector_helper_funcs = {
 	.best_encoder = tda998x_connector_best_encoder,
 };
 
+static int tda998x_connector_init(struct tda998x_priv *priv,
+				  struct drm_device *drm)
+{
+	struct drm_connector *connector = &priv->connector;
+	int ret;
+
+	connector->interlace_allowed = 1;
+
+	if (priv->hdmi->irq)
+		connector->polled = DRM_CONNECTOR_POLL_HPD;
+	else
+		connector->polled = DRM_CONNECTOR_POLL_CONNECT |
+			DRM_CONNECTOR_POLL_DISCONNECT;
+
+	drm_connector_helper_add(connector, &tda998x_connector_helper_funcs);
+	ret = drm_connector_init(drm, connector, &tda998x_connector_funcs,
+				 DRM_MODE_CONNECTOR_HDMIA);
+	if (ret)
+		return ret;
+
+	ret = drm_connector_register(&priv->connector);
+	if (ret) {
+		drm_connector_cleanup(&priv->connector);
+		return ret;
+	}
+
+	drm_mode_connector_attach_encoder(&priv->connector, &priv->encoder);
+
+	return 0;
+}
+
 /* DRM encoder functions */
 
 static void tda998x_encoder_dpms(struct drm_encoder *encoder, int mode)
@@ -1212,16 +1243,6 @@ tda998x_encoder_mode_set(struct drm_encoder *encoder,
 	mutex_unlock(&priv->audio_mutex);
 }
 
-static void tda998x_encoder_set_polling(struct tda998x_priv *priv,
-					struct drm_connector *connector)
-{
-	if (priv->hdmi->irq)
-		connector->polled = DRM_CONNECTOR_POLL_HPD;
-	else
-		connector->polled = DRM_CONNECTOR_POLL_CONNECT |
-			DRM_CONNECTOR_POLL_DISCONNECT;
-}
-
 static void tda998x_destroy(struct tda998x_priv *priv)
 {
 	/* disable all IRQs and free the IRQ handler */
@@ -1634,7 +1655,6 @@ static int tda998x_bind(struct device *dev, struct device *master, void *data)
 		crtcs = 1 << 0;
 	}
 
-	priv->connector.interlace_allowed = 1;
 	priv->encoder.possible_crtcs = crtcs;
 
 	ret = tda998x_create(client, priv);
@@ -1644,32 +1664,18 @@ static int tda998x_bind(struct device *dev, struct device *master, void *data)
 	if (!dev->of_node && params)
 		tda998x_set_config(priv, params);
 
-	tda998x_encoder_set_polling(priv, &priv->connector);
-
 	drm_encoder_helper_add(&priv->encoder, &tda998x_encoder_helper_funcs);
 	ret = drm_encoder_init(drm, &priv->encoder, &tda998x_encoder_funcs,
 			       DRM_MODE_ENCODER_TMDS, NULL);
 	if (ret)
 		goto err_encoder;
 
-	drm_connector_helper_add(&priv->connector,
-				 &tda998x_connector_helper_funcs);
-	ret = drm_connector_init(drm, &priv->connector,
-				 &tda998x_connector_funcs,
-				 DRM_MODE_CONNECTOR_HDMIA);
+	ret = tda998x_connector_init(priv, drm);
 	if (ret)
 		goto err_connector;
 
-	ret = drm_connector_register(&priv->connector);
-	if (ret)
-		goto err_sysfs;
-
-	drm_mode_connector_attach_encoder(&priv->connector, &priv->encoder);
-
 	return 0;
 
-err_sysfs:
-	drm_connector_cleanup(&priv->connector);
 err_connector:
 	drm_encoder_cleanup(&priv->encoder);
 err_encoder:
-- 
2.1.0
