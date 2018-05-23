From: peda@axentia.se (Peter Rosin)
Date: Wed, 23 May 2018 11:31:21 +0200
Subject: [PATCH v5 6/7] drm/i2c: tda998x: split encoder and component
 functions from the work
In-Reply-To: <20180523093122.27859-1-peda@axentia.se>
References: <20180523093122.27859-1-peda@axentia.se>
Message-ID: <20180523093122.27859-7-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables reuse of the machinery for the case where a drm_bridge
needs to do the same work via different interfaces.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 3dda07a2fd2f..d401b3d0095c 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -1202,11 +1202,10 @@ static void tda998x_encoder_dpms(struct drm_encoder *encoder, int mode)
 }
 
 static void
-tda998x_encoder_mode_set(struct drm_encoder *encoder,
-			 struct drm_display_mode *mode,
-			 struct drm_display_mode *adjusted_mode)
+tda998x_mode_set(struct tda998x_priv *priv,
+		 struct drm_display_mode *mode,
+		 struct drm_display_mode *adjusted_mode)
 {
-	struct tda998x_priv *priv = enc_to_tda998x_priv(encoder);
 	u16 ref_pix, ref_line, n_pix, n_line;
 	u16 hs_pix_s, hs_pix_e;
 	u16 vs1_pix_s, vs1_pix_e, vs1_line_s, vs1_line_e;
@@ -1413,6 +1412,16 @@ tda998x_encoder_mode_set(struct drm_encoder *encoder,
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
@@ -1662,11 +1671,10 @@ static void tda998x_set_config(struct tda998x_priv *priv,
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
@@ -1714,8 +1722,7 @@ static int tda998x_bind(struct device *dev, struct device *master, void *data)
 	return ret;
 }
 
-static void tda998x_unbind(struct device *dev, struct device *master,
-			   void *data)
+static void tda998x_fini(struct device *dev)
 {
 	struct tda998x_priv *priv = dev_get_drvdata(dev);
 
@@ -1724,6 +1731,19 @@ static void tda998x_unbind(struct device *dev, struct device *master,
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
