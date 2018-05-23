From: peda@axentia.se (Peter Rosin)
Date: Wed, 23 May 2018 11:31:22 +0200
Subject: [PATCH v5 7/7] drm/i2c: tda998x: register as a drm bridge
In-Reply-To: <20180523093122.27859-1-peda@axentia.se>
References: <20180523093122.27859-1-peda@axentia.se>
Message-ID: <20180523093122.27859-8-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes this driver work with all(?) drivers that are not
componentized and instead expect to connect to a panel/bridge. That
said, the only one tested is atmel-hlcdc.

This hooks the relevant work function previously called by the encoder
and the component also to the bridge, since the encoder goes away when
connecting to the bridge interface of the driver and the equivalent of
bind/unbind of the component is handled by bridge attach/detach.

The lifetime requirements of a bridge and a component are slightly
different, which is the reason for struct tda998x_bridge.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 170 ++++++++++++++++++++++++++++++++------
 1 file changed, 143 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index d401b3d0095c..d47e49c2991a 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -36,6 +36,14 @@ struct tda998x_audio_port {
 	u8 config;		/* AP value */
 };
 
+struct tda998x_priv;
+
+struct tda998x_bridge {
+	struct tda998x_priv *priv;
+	struct device *dev;
+	struct drm_bridge bridge;
+};
+
 struct tda998x_priv {
 	struct i2c_client *cec;
 	struct i2c_client *hdmi;
@@ -63,6 +71,8 @@ struct tda998x_priv {
 	wait_queue_head_t edid_delay_waitq;
 	bool edid_delay_active;
 
+	struct tda998x_bridge *bridge;
+	bool local_encoder;
 	struct drm_encoder encoder;
 	struct drm_connector connector;
 
@@ -75,6 +85,9 @@ struct tda998x_priv {
 #define enc_to_tda998x_priv(x) \
 	container_of(x, struct tda998x_priv, encoder)
 
+#define bridge_to_tda998x_bridge(x) \
+	container_of(x, struct tda998x_bridge, bridge)
+
 /* The TDA9988 series of devices use a paged register scheme.. to simplify
  * things we encode the page # in upper bits of the register #.  To read/
  * write a given register, we need to make sure CURPAGE register is set
@@ -842,7 +855,8 @@ static int tda998x_audio_hw_params(struct device *dev, void *data,
 				   struct hdmi_codec_daifmt *daifmt,
 				   struct hdmi_codec_params *params)
 {
-	struct tda998x_priv *priv = dev_get_drvdata(dev);
+	struct tda998x_bridge *bridge = dev_get_drvdata(dev);
+	struct tda998x_priv *priv = bridge->priv;
 	int i, ret;
 	struct tda998x_audio_params audio = {
 		.sample_width = params->sample_width,
@@ -899,7 +913,8 @@ static int tda998x_audio_hw_params(struct device *dev, void *data,
 
 static void tda998x_audio_shutdown(struct device *dev, void *data)
 {
-	struct tda998x_priv *priv = dev_get_drvdata(dev);
+	struct tda998x_bridge *bridge = dev_get_drvdata(dev);
+	struct tda998x_priv *priv = bridge->priv;
 
 	mutex_lock(&priv->audio_mutex);
 
@@ -912,7 +927,8 @@ static void tda998x_audio_shutdown(struct device *dev, void *data)
 
 int tda998x_audio_digital_mute(struct device *dev, void *data, bool enable)
 {
-	struct tda998x_priv *priv = dev_get_drvdata(dev);
+	struct tda998x_bridge *bridge = dev_get_drvdata(dev);
+	struct tda998x_priv *priv = bridge->priv;
 
 	mutex_lock(&priv->audio_mutex);
 
@@ -925,7 +941,8 @@ int tda998x_audio_digital_mute(struct device *dev, void *data, bool enable)
 static int tda998x_audio_get_eld(struct device *dev, void *data,
 				 uint8_t *buf, size_t len)
 {
-	struct tda998x_priv *priv = dev_get_drvdata(dev);
+	struct tda998x_bridge *bridge = dev_get_drvdata(dev);
+	struct tda998x_priv *priv = bridge->priv;
 
 	mutex_lock(&priv->audio_mutex);
 	memcpy(buf, priv->connector.eld,
@@ -1126,7 +1143,10 @@ tda998x_connector_best_encoder(struct drm_connector *connector)
 {
 	struct tda998x_priv *priv = conn_to_tda998x_priv(connector);
 
-	return &priv->encoder;
+	if (priv->local_encoder)
+		return &priv->encoder;
+	else
+		return priv->bridge->bridge.encoder;
 }
 
 static
@@ -1140,6 +1160,7 @@ static int tda998x_connector_init(struct tda998x_priv *priv,
 				  struct drm_device *drm)
 {
 	struct drm_connector *connector = &priv->connector;
+	struct drm_encoder *encoder;
 	int ret;
 
 	connector->interlace_allowed = 1;
@@ -1156,7 +1177,8 @@ static int tda998x_connector_init(struct tda998x_priv *priv,
 	if (ret)
 		return ret;
 
-	drm_mode_connector_attach_encoder(&priv->connector, &priv->encoder);
+	encoder = tda998x_connector_best_encoder(&priv->connector);
+	drm_mode_connector_attach_encoder(&priv->connector, encoder);
 
 	return 0;
 }
@@ -1671,8 +1693,10 @@ static void tda998x_set_config(struct tda998x_priv *priv,
 	priv->audio_params = p->audio_params;
 }
 
-static int tda998x_init(struct device *dev, struct drm_device *drm)
+static int tda998x_init(struct device *dev, struct drm_device *drm,
+			bool local_encoder)
 {
+	struct tda998x_bridge *bridge = dev_get_drvdata(dev);
 	struct tda998x_encoder_params *params = dev->platform_data;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct tda998x_priv *priv;
@@ -1683,18 +1707,22 @@ static int tda998x_init(struct device *dev, struct drm_device *drm)
 	if (!priv)
 		return -ENOMEM;
 
-	dev_set_drvdata(dev, priv);
+	bridge->priv = priv;
+	priv->bridge = bridge;
+	priv->local_encoder = local_encoder;
 
-	if (dev->of_node)
-		crtcs = drm_of_find_possible_crtcs(drm, dev->of_node);
+	if (local_encoder) {
+		if (dev->of_node)
+			crtcs = drm_of_find_possible_crtcs(drm, dev->of_node);
 
-	/* If no CRTCs were found, fall back to our old behaviour */
-	if (crtcs == 0) {
-		dev_warn(dev, "Falling back to first CRTC\n");
-		crtcs = 1 << 0;
-	}
+		/* If no CRTCs were found, fall back to our old behaviour */
+		if (crtcs == 0) {
+			dev_warn(dev, "Falling back to first CRTC\n");
+			crtcs = 1 << 0;
+		}
 
-	priv->encoder.possible_crtcs = crtcs;
+		priv->encoder.possible_crtcs = crtcs;
+	}
 
 	ret = tda998x_create(client, priv);
 	if (ret)
@@ -1703,11 +1731,15 @@ static int tda998x_init(struct device *dev, struct drm_device *drm)
 	if (!dev->of_node && params)
 		tda998x_set_config(priv, params);
 
-	drm_encoder_helper_add(&priv->encoder, &tda998x_encoder_helper_funcs);
-	ret = drm_encoder_init(drm, &priv->encoder, &tda998x_encoder_funcs,
-			       DRM_MODE_ENCODER_TMDS, NULL);
-	if (ret)
-		goto err_encoder;
+	if (local_encoder) {
+		drm_encoder_helper_add(&priv->encoder,
+				       &tda998x_encoder_helper_funcs);
+		ret = drm_encoder_init(drm, &priv->encoder,
+				       &tda998x_encoder_funcs,
+				       DRM_MODE_ENCODER_TMDS, NULL);
+		if (ret)
+			goto err_encoder;
+	}
 
 	ret = tda998x_connector_init(priv, drm);
 	if (ret)
@@ -1716,7 +1748,8 @@ static int tda998x_init(struct device *dev, struct drm_device *drm)
 	return 0;
 
 err_connector:
-	drm_encoder_cleanup(&priv->encoder);
+	if (local_encoder)
+		drm_encoder_cleanup(&priv->encoder);
 err_encoder:
 	tda998x_destroy(priv);
 	return ret;
@@ -1724,10 +1757,12 @@ static int tda998x_init(struct device *dev, struct drm_device *drm)
 
 static void tda998x_fini(struct device *dev)
 {
-	struct tda998x_priv *priv = dev_get_drvdata(dev);
+	struct tda998x_bridge *bridge = dev_get_drvdata(dev);
+	struct tda998x_priv *priv = bridge->priv;
 
 	drm_connector_cleanup(&priv->connector);
-	drm_encoder_cleanup(&priv->encoder);
+	if (priv->local_encoder)
+		drm_encoder_cleanup(&priv->encoder);
 	tda998x_destroy(priv);
 }
 
@@ -1735,7 +1770,7 @@ static int tda998x_bind(struct device *dev, struct device *master, void *data)
 {
 	struct drm_device *drm = data;
 
-	return tda998x_init(dev, drm);
+	return tda998x_init(dev, drm, true);
 }
 
 static void tda998x_unbind(struct device *dev, struct device *master,
@@ -1749,19 +1784,100 @@ static const struct component_ops tda998x_ops = {
 	.unbind = tda998x_unbind,
 };
 
+/* DRM bridge functions */
+
+static int tda998x_bridge_attach(struct drm_bridge *dbridge)
+{
+	struct tda998x_bridge *bridge = bridge_to_tda998x_bridge(dbridge);
+	struct device *dev = bridge->dev;
+	struct drm_device *drm = bridge->bridge.dev;
+
+	return tda998x_init(dev, drm, false);
+}
+
+static void tda998x_bridge_detach(struct drm_bridge *dbridge)
+{
+	struct tda998x_bridge *bridge = bridge_to_tda998x_bridge(dbridge);
+	struct device *dev = bridge->dev;
+
+	tda998x_fini(dev);
+}
+
+static void tda998x_bridge_enable(struct drm_bridge *dbridge)
+{
+	struct tda998x_bridge *bridge = bridge_to_tda998x_bridge(dbridge);
+	struct tda998x_priv *priv = bridge->priv;
+
+	tda998x_enable(priv);
+}
+
+static void tda998x_bridge_disable(struct drm_bridge *dbridge)
+{
+	struct tda998x_bridge *bridge = bridge_to_tda998x_bridge(dbridge);
+	struct tda998x_priv *priv = bridge->priv;
+
+	tda998x_disable(priv);
+}
+
+static void tda998x_bridge_mode_set(struct drm_bridge *dbridge,
+				    struct drm_display_mode *mode,
+				    struct drm_display_mode *adjusted_mode)
+{
+	struct tda998x_bridge *bridge = bridge_to_tda998x_bridge(dbridge);
+	struct tda998x_priv *priv = bridge->priv;
+
+	tda998x_mode_set(priv, mode, adjusted_mode);
+}
+
+static const struct drm_bridge_funcs tda998x_bridge_funcs = {
+	.attach = tda998x_bridge_attach,
+	.detach = tda998x_bridge_detach,
+	.enable = tda998x_bridge_enable,
+	.disable = tda998x_bridge_disable,
+	.mode_set = tda998x_bridge_mode_set,
+};
+
 static int
 tda998x_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
+	struct device *dev = &client->dev;
+	struct tda998x_bridge *bridge;
+	int ret;
+
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
 		dev_warn(&client->dev, "adapter does not support I2C\n");
 		return -EIO;
 	}
-	return component_add(&client->dev, &tda998x_ops);
+
+	bridge = devm_kzalloc(dev, sizeof(*bridge), GFP_KERNEL);
+	if (!bridge)
+		return -ENOMEM;
+
+	bridge->dev = dev;
+	dev_set_drvdata(dev, bridge);
+
+	bridge->bridge.funcs = &tda998x_bridge_funcs;
+#ifdef CONFIG_OF
+	bridge->bridge.of_node = dev->of_node;
+#endif
+	drm_bridge_add(&bridge->bridge);
+
+	ret = component_add(dev, &tda998x_ops);
+
+	if (ret)
+		drm_bridge_remove(&bridge->bridge);
+
+	return ret;
 }
 
 static int tda998x_remove(struct i2c_client *client)
 {
-	component_del(&client->dev, &tda998x_ops);
+	struct device *dev = &client->dev;
+	struct tda998x_bridge *bridge = dev_get_drvdata(dev);
+
+	drm_bridge_remove(&bridge->bridge);
+	component_del(dev, &tda998x_ops);
+
 	return 0;
 }
 
-- 
2.11.0
