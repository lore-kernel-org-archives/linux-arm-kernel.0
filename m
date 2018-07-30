From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 30 Jul 2018 17:42:21 +0100
Subject: [PATCH v2 4/7] drm/i2c: tda998x: convert to bridge driver
In-Reply-To: <20180730164137.GD17271@n2100.armlinux.org.uk>
References: <20180730164137.GD17271@n2100.armlinux.org.uk>
Message-ID: <E1fkBFV-00048s-O2@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert tda998x to a bridge driver with built-in encoder support for
compatibility with existing component drivers.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 154 +++++++++++++++++++-------------------
 1 file changed, 79 insertions(+), 75 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 843078e9fbf3..1ea62052f3e0 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -69,6 +69,7 @@ struct tda998x_priv {
 	bool edid_delay_active;
 
 	struct drm_encoder encoder;
+	struct drm_bridge bridge;
 	struct drm_connector connector;
 
 	struct tda998x_audio_port audio_port[2];
@@ -79,9 +80,10 @@ struct tda998x_priv {
 
 #define conn_to_tda998x_priv(x) \
 	container_of(x, struct tda998x_priv, connector)
-
 #define enc_to_tda998x_priv(x) \
 	container_of(x, struct tda998x_priv, encoder)
+#define bridge_to_tda998x_priv(x) \
+	container_of(x, struct tda998x_priv, bridge)
 
 /* The TDA9988 series of devices use a paged register scheme.. to simplify
  * things we encode the page # in upper bits of the register #.  To read/
@@ -1262,7 +1264,7 @@ tda998x_connector_best_encoder(struct drm_connector *connector)
 {
 	struct tda998x_priv *priv = conn_to_tda998x_priv(connector);
 
-	return &priv->encoder;
+	return priv->bridge.encoder;
 }
 
 static
@@ -1292,15 +1294,32 @@ static int tda998x_connector_init(struct tda998x_priv *priv,
 	if (ret)
 		return ret;
 
-	drm_mode_connector_attach_encoder(&priv->connector, &priv->encoder);
+	drm_mode_connector_attach_encoder(&priv->connector,
+					  priv->bridge.encoder);
 
 	return 0;
 }
 
-/* DRM encoder functions */
+/* DRM bridge functions */
+
+static int tda998x_bridge_attach(struct drm_bridge *bridge)
+{
+	struct tda998x_priv *priv = bridge_to_tda998x_priv(bridge);
+
+	return tda998x_connector_init(priv, bridge->dev);
+}
+
+static void tda998x_bridge_detach(struct drm_bridge *bridge)
+{
+	struct tda998x_priv *priv = bridge_to_tda998x_priv(bridge);
+
+	drm_connector_cleanup(&priv->connector);
+}
 
-static void tda998x_enable(struct tda998x_priv *priv)
+static void tda998x_bridge_enable(struct drm_bridge *bridge)
 {
+	struct tda998x_priv *priv = bridge_to_tda998x_priv(bridge);
+
 	if (!priv->is_on) {
 		/* enable video ports, audio will be enabled later */
 		reg_write(priv, REG_ENA_VP_0, 0xff);
@@ -1315,8 +1334,10 @@ static void tda998x_enable(struct tda998x_priv *priv)
 	}
 }
 
-static void tda998x_disable(struct tda998x_priv *priv)
+static void tda998x_bridge_disable(struct drm_bridge *bridge)
 {
+	struct tda998x_priv *priv = bridge_to_tda998x_priv(bridge);
+
 	if (!priv->is_on) {
 		/* disable video ports */
 		reg_write(priv, REG_ENA_VP_0, 0x00);
@@ -1327,29 +1348,11 @@ static void tda998x_disable(struct tda998x_priv *priv)
 	}
 }
 
-static void tda998x_encoder_dpms(struct drm_encoder *encoder, int mode)
+static void tda998x_bridge_mode_set(struct drm_bridge *bridge,
+				    struct drm_display_mode *mode,
+				    struct drm_display_mode *adjusted_mode)
 {
-	struct tda998x_priv *priv = enc_to_tda998x_priv(encoder);
-	bool on;
-
-	/* we only care about on or off: */
-	on = mode == DRM_MODE_DPMS_ON;
-
-	if (on == priv->is_on)
-		return;
-
-	if (on)
-		tda998x_enable(priv);
-	else
-		tda998x_disable(priv);
-}
-
-static void
-tda998x_encoder_mode_set(struct drm_encoder *encoder,
-			 struct drm_display_mode *mode,
-			 struct drm_display_mode *adjusted_mode)
-{
-	struct tda998x_priv *priv = enc_to_tda998x_priv(encoder);
+	struct tda998x_priv *priv = bridge_to_tda998x_priv(bridge);
 	u16 ref_pix, ref_line, n_pix, n_line;
 	u16 hs_pix_s, hs_pix_e;
 	u16 vs1_pix_s, vs1_pix_e, vs1_line_s, vs1_line_e;
@@ -1556,8 +1559,18 @@ tda998x_encoder_mode_set(struct drm_encoder *encoder,
 	mutex_unlock(&priv->audio_mutex);
 }
 
+static const struct drm_bridge_funcs tda998x_bridge_funcs = {
+	.attach = tda998x_bridge_attach,
+	.detach = tda998x_bridge_detach,
+	.disable = tda998x_bridge_disable,
+	.mode_set = tda998x_bridge_mode_set,
+	.enable = tda998x_bridge_enable,
+};
+
 static void tda998x_destroy(struct tda998x_priv *priv)
 {
+	drm_bridge_remove(&priv->bridge);
+
 	/* disable all IRQs and free the IRQ handler */
 	cec_write(priv, REG_CEC_RXSHPDINTENA, 0);
 	reg_clear(priv, REG_INT_FLAGS_2, INT_FLAGS_2_EDID_BLK_RD);
@@ -1650,6 +1663,7 @@ static int tda998x_create(struct i2c_client *client, struct tda998x_priv *priv)
 	mutex_init(&priv->mutex);	/* protect the page access */
 	mutex_init(&priv->audio_mutex); /* protect access from audio thread */
 	mutex_init(&priv->edid_mutex);
+	INIT_LIST_HEAD(&priv->bridge.list);
 	init_waitqueue_head(&priv->edid_delay_waitq);
 	timer_setup(&priv->edid_delay_timer, tda998x_edid_delay_done, 0);
 	INIT_WORK(&priv->detect_work, tda998x_detect_work);
@@ -1810,43 +1824,23 @@ static int tda998x_create(struct i2c_client *client, struct tda998x_priv *priv)
 		tda998x_set_config(priv, client->dev.platform_data);
 	}
 
+	priv->bridge.funcs = &tda998x_bridge_funcs;
+	priv->bridge.of_node = dev->of_node;
+
+	drm_bridge_add(&priv->bridge);
+
 	return 0;
 
 fail:
-	/* if encoder_init fails, the encoder slave is never registered,
-	 * so cleanup here:
-	 */
-	i2c_unregister_device(priv->cec);
-	if (priv->cec_notify)
-		cec_notifier_put(priv->cec_notify);
-	if (client->irq)
-		free_irq(client->irq, priv);
+	tda998x_destroy(priv);
 err_irq:
 	return ret;
 }
 
-static void tda998x_encoder_prepare(struct drm_encoder *encoder)
-{
-	tda998x_encoder_dpms(encoder, DRM_MODE_DPMS_OFF);
-}
-
-static void tda998x_encoder_commit(struct drm_encoder *encoder)
-{
-	tda998x_encoder_dpms(encoder, DRM_MODE_DPMS_ON);
-}
-
-static const struct drm_encoder_helper_funcs tda998x_encoder_helper_funcs = {
-	.dpms = tda998x_encoder_dpms,
-	.prepare = tda998x_encoder_prepare,
-	.commit = tda998x_encoder_commit,
-	.mode_set = tda998x_encoder_mode_set,
-};
+/* DRM encoder functions */
 
 static void tda998x_encoder_destroy(struct drm_encoder *encoder)
 {
-	struct tda998x_priv *priv = enc_to_tda998x_priv(encoder);
-
-	tda998x_destroy(priv);
 	drm_encoder_cleanup(encoder);
 }
 
@@ -1854,20 +1848,12 @@ static const struct drm_encoder_funcs tda998x_encoder_funcs = {
 	.destroy = tda998x_encoder_destroy,
 };
 
-static int tda998x_bind(struct device *dev, struct device *master, void *data)
+static int tda998x_encoder_init(struct device *dev, struct drm_device *drm)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct drm_device *drm = data;
-	struct tda998x_priv *priv;
+	struct tda998x_priv *priv = dev_get_drvdata(dev);
 	u32 crtcs = 0;
 	int ret;
 
-	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
-	dev_set_drvdata(dev, priv);
-
 	if (dev->of_node)
 		crtcs = drm_of_find_possible_crtcs(drm, dev->of_node);
 
@@ -1879,35 +1865,53 @@ static int tda998x_bind(struct device *dev, struct device *master, void *data)
 
 	priv->encoder.possible_crtcs = crtcs;
 
-	ret = tda998x_create(client, priv);
-	if (ret)
-		return ret;
-
-	drm_encoder_helper_add(&priv->encoder, &tda998x_encoder_helper_funcs);
 	ret = drm_encoder_init(drm, &priv->encoder, &tda998x_encoder_funcs,
 			       DRM_MODE_ENCODER_TMDS, NULL);
 	if (ret)
 		goto err_encoder;
 
-	ret = tda998x_connector_init(priv, drm);
+	ret = drm_bridge_attach(&priv->encoder, &priv->bridge, NULL);
 	if (ret)
-		goto err_connector;
+		goto err_bridge;
 
 	return 0;
 
-err_connector:
+err_bridge:
 	drm_encoder_cleanup(&priv->encoder);
 err_encoder:
-	tda998x_destroy(priv);
 	return ret;
 }
 
+static int tda998x_bind(struct device *dev, struct device *master, void *data)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct drm_device *drm = data;
+	struct tda998x_priv *priv;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, priv);
+
+	ret = tda998x_create(client, priv);
+	if (ret)
+		return ret;
+
+	ret = tda998x_encoder_init(dev, drm);
+	if (ret) {
+		tda998x_destroy(priv);
+		return ret;
+	}
+	return 0;
+}
+
 static void tda998x_unbind(struct device *dev, struct device *master,
 			   void *data)
 {
 	struct tda998x_priv *priv = dev_get_drvdata(dev);
 
-	drm_connector_cleanup(&priv->connector);
 	drm_encoder_cleanup(&priv->encoder);
 	tda998x_destroy(priv);
 }
-- 
2.7.4
