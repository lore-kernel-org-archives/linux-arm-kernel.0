From: peda@axentia.se (Peter Rosin)
Date: Thu, 19 Apr 2018 18:27:50 +0200
Subject: [PATCH v3 6/7] drm/i2c: tda998x: split encoder and component
 functions from the work
In-Reply-To: <20180419162751.25223-1-peda@axentia.se>
References: <20180419162751.25223-1-peda@axentia.se>
Message-ID: <20180419162751.25223-7-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables reuse of the machinery for the case where a drm_bridge
needs to do the same work via different interfaces.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 46 ++++++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 8f6e013f2b87..9c78f7bde49c 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -1163,9 +1163,8 @@ static int tda998x_connector_init(struct tda998x_priv *priv,
 
 /* DRM encoder functions */
 
-static void tda998x_encoder_dpms(struct drm_encoder *encoder, int mode)
+static void tda998x_dpms(struct tda998x_priv *priv, int mode)
 {
-	struct tda998x_priv *priv = enc_to_tda998x_priv(encoder);
 	bool on;
 
 	/* we only care about on or off: */
@@ -1195,12 +1194,18 @@ static void tda998x_encoder_dpms(struct drm_encoder *encoder, int mode)
 	}
 }
 
-static void
-tda998x_encoder_mode_set(struct drm_encoder *encoder,
-			 struct drm_display_mode *mode,
-			 struct drm_display_mode *adjusted_mode)
+static void tda998x_encoder_dpms(struct drm_encoder *encoder, int mode)
 {
 	struct tda998x_priv *priv = enc_to_tda998x_priv(encoder);
+
+	tda998x_dpms(priv, mode);
+}
+
+static void
+tda998x_mode_set(struct tda998x_priv *priv,
+		 struct drm_display_mode *mode,
+		 struct drm_display_mode *adjusted_mode)
+{
 	u16 ref_pix, ref_line, n_pix, n_line;
 	u16 hs_pix_s, hs_pix_e;
 	u16 vs1_pix_s, vs1_pix_e, vs1_line_s, vs1_line_e;
@@ -1407,6 +1412,16 @@ tda998x_encoder_mode_set(struct drm_encoder *encoder,
 	mutex_unlock(&priv->audio_mutex);
 }
 
+static void
+tda998x_encoder_mode_set(struct drm_encoder *encoder,
+			 struct drm_display_mode *mode,
+			 struct drm_display_mode *adjusted_mode)
+{
+	struct tda998x_priv *priv = enc_to_tda998x_priv(encoder);
+
+	tda998x_mode_set(priv, mode, adjusted_mode);
+}
+
 static void tda998x_destroy(struct tda998x_priv *priv)
 {
 	/* disable all IRQs and free the IRQ handler */
@@ -1653,11 +1668,10 @@ static void tda998x_set_config(struct tda998x_priv *priv,
 	priv->audio_params = p->audio_params;
 }
 
-static int tda998x_bind(struct device *dev, struct device *master, void *data)
+static int tda998x_init(struct device *dev, struct drm_device *drm)
 {
 	struct tda998x_encoder_params *params = dev->platform_data;
 	struct i2c_client *client = to_i2c_client(dev);
-	struct drm_device *drm = data;
 	struct tda998x_priv *priv;
 	u32 crtcs = 0;
 	int ret;
@@ -1705,8 +1719,7 @@ static int tda998x_bind(struct device *dev, struct device *master, void *data)
 	return ret;
 }
 
-static void tda998x_unbind(struct device *dev, struct device *master,
-			   void *data)
+static void tda998x_fini(struct device *dev)
 {
 	struct tda998x_priv *priv = dev_get_drvdata(dev);
 
@@ -1715,6 +1728,19 @@ static void tda998x_unbind(struct device *dev, struct device *master,
 	tda998x_destroy(priv);
 }
 
+static int tda998x_bind(struct device *dev, struct device *master, void *data)
+{
+	struct drm_device *drm = data;
+
+	return tda998x_init(dev, drm);
+}
+
+static void tda998x_unbind(struct device *dev, struct device *master,
+			   void *data)
+{
+	tda998x_fini(dev);
+}
+
 static const struct component_ops tda998x_ops = {
 	.bind = tda998x_bind,
 	.unbind = tda998x_unbind,
-- 
2.11.0
