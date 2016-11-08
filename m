From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 08 Nov 2016 12:25:42 +0000
Subject: [PATCH RFC 09/12] drm/i2c: tda998x: separate connector initialisation
In-Reply-To: <20161108122420.GP1041@n2100.armlinux.org.uk>
References: <20161108122420.GP1041@n2100.armlinux.org.uk>
Message-ID: <E1c45TC-0005k7-Fg@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Separate out the connector initialisation from the rest of the drivers
initialisation.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 46 ++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 3f3e1f0137f8..af3dc5528663 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -996,6 +996,31 @@ const struct drm_connector_helper_funcs tda998x_connector_helper_funcs = {
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
+	drm_mode_connector_attach_encoder(&priv->connector, &priv->encoder);
+
+	return 0;
+}
+
 /* DRM encoder functions */
 
 static void tda998x_encoder_dpms(struct drm_encoder *encoder, int mode)
@@ -1241,16 +1266,6 @@ tda998x_encoder_mode_set(struct drm_encoder *encoder,
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
@@ -1662,7 +1677,6 @@ static int tda998x_bind(struct device *dev, struct device *master, void *data)
 		crtcs = 1 << 0;
 	}
 
-	priv->connector.interlace_allowed = 1;
 	priv->encoder.possible_crtcs = crtcs;
 
 	ret = tda998x_create(client, priv);
@@ -1672,24 +1686,16 @@ static int tda998x_bind(struct device *dev, struct device *master, void *data)
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
 
-	drm_mode_connector_attach_encoder(&priv->connector, &priv->encoder);
-
 	return 0;
 
 err_connector:
-- 
2.7.4
