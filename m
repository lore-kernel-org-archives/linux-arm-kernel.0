From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 24 Jul 2014 15:57:34 +0100
Subject: [PATCH RFA 1/2] drm/i2c: tda998x: allow re-use of tda998x support code
Message-ID: <E1XAKSc-0004YT-4Q@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Re-jig the TDA998x code so that we separate the functionality from the
drm slave encoder implementation.  In several places, this is pretty
clearly the correct thing to do, because we can avoid repetitively
having to convert from the drm_encoder to the TDA998x private
structure, particularly with the driver internal functions.

The main motivation behind this change is to allow the code to be
re-used with a standard drm_encoder and drm_connector implementation
based on the component helpers, rather than the slave_encoder system.
The addition of this will be in the following patch.

We keep the slave_encoder interface as there are existing users of
this; we need to give them time to convert and test.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
RFA = request for acks, but tested-by's would also be great,
particularly from the tilcdc folk.

 drivers/gpu/drm/i2c/tda998x_drv.c | 179 +++++++++++++++++++++++---------------
 1 file changed, 110 insertions(+), 69 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 5a738ad0c241..64e120c5299a 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -730,12 +730,9 @@ tda998x_configure_audio(struct tda998x_priv *priv,
 
 /* DRM encoder functions */
 
-static void
-tda998x_encoder_set_config(struct drm_encoder *encoder, void *params)
+static void tda998x_encoder_set_config(struct tda998x_priv *priv,
+				       const struct tda998x_encoder_params *p)
 {
-	struct tda998x_priv *priv = to_tda998x_priv(encoder);
-	struct tda998x_encoder_params *p = params;
-
 	priv->vip_cntrl_0 = VIP_CNTRL_0_SWAP_A(p->swap_a) |
 			    (p->mirr_a ? VIP_CNTRL_0_MIRR_A : 0) |
 			    VIP_CNTRL_0_SWAP_B(p->swap_b) |
@@ -752,11 +749,8 @@ tda998x_encoder_set_config(struct drm_encoder *encoder, void *params)
 	priv->params = *p;
 }
 
-static void
-tda998x_encoder_dpms(struct drm_encoder *encoder, int mode)
+static void tda998x_encoder_dpms(struct tda998x_priv *priv, int mode)
 {
-	struct tda998x_priv *priv = to_tda998x_priv(encoder);
-
 	/* we only care about on or off: */
 	if (mode != DRM_MODE_DPMS_ON)
 		mode = DRM_MODE_DPMS_OFF;
@@ -806,9 +800,8 @@ tda998x_encoder_mode_fixup(struct drm_encoder *encoder,
 	return true;
 }
 
-static int
-tda998x_encoder_mode_valid(struct drm_encoder *encoder,
-			  struct drm_display_mode *mode)
+static int tda998x_encoder_mode_valid(struct tda998x_priv *priv,
+				      struct drm_display_mode *mode)
 {
 	if (mode->clock > 150000)
 		return MODE_CLOCK_HIGH;
@@ -820,11 +813,10 @@ tda998x_encoder_mode_valid(struct drm_encoder *encoder,
 }
 
 static void
-tda998x_encoder_mode_set(struct drm_encoder *encoder,
-			struct drm_display_mode *mode,
-			struct drm_display_mode *adjusted_mode)
+tda998x_encoder_mode_set(struct tda998x_priv *priv,
+			 struct drm_display_mode *mode,
+			 struct drm_display_mode *adjusted_mode)
 {
-	struct tda998x_priv *priv = to_tda998x_priv(encoder);
 	uint16_t ref_pix, ref_line, n_pix, n_line;
 	uint16_t hs_pix_s, hs_pix_e;
 	uint16_t vs1_pix_s, vs1_pix_e, vs1_line_s, vs1_line_e;
@@ -1012,20 +1004,16 @@ tda998x_encoder_mode_set(struct drm_encoder *encoder,
 }
 
 static enum drm_connector_status
-tda998x_encoder_detect(struct drm_encoder *encoder,
-		      struct drm_connector *connector)
+tda998x_encoder_detect(struct tda998x_priv *priv)
 {
-	struct tda998x_priv *priv = to_tda998x_priv(encoder);
 	uint8_t val = cec_read(priv, REG_CEC_RXSHPDLEV);
 
 	return (val & CEC_RXSHPDLEV_HPD) ? connector_status_connected :
 			connector_status_disconnected;
 }
 
-static int
-read_edid_block(struct drm_encoder *encoder, uint8_t *buf, int blk)
+static int read_edid_block(struct tda998x_priv *priv, uint8_t *buf, int blk)
 {
-	struct tda998x_priv *priv = to_tda998x_priv(encoder);
 	uint8_t offset, segptr;
 	int ret, i;
 
@@ -1079,10 +1067,8 @@ read_edid_block(struct drm_encoder *encoder, uint8_t *buf, int blk)
 	return 0;
 }
 
-static uint8_t *
-do_get_edid(struct drm_encoder *encoder)
+static uint8_t *do_get_edid(struct tda998x_priv *priv)
 {
-	struct tda998x_priv *priv = to_tda998x_priv(encoder);
 	int j, valid_extensions = 0;
 	uint8_t *block, *new;
 	bool print_bad_edid = drm_debug & DRM_UT_KMS;
@@ -1094,7 +1080,7 @@ do_get_edid(struct drm_encoder *encoder)
 		reg_clear(priv, REG_TX4, TX4_PD_RAM);
 
 	/* base block fetch */
-	if (read_edid_block(encoder, block, 0))
+	if (read_edid_block(priv, block, 0))
 		goto fail;
 
 	if (!drm_edid_block_valid(block, 0, print_bad_edid))
@@ -1111,7 +1097,7 @@ do_get_edid(struct drm_encoder *encoder)
 
 	for (j = 1; j <= block[0x7e]; j++) {
 		uint8_t *ext_block = block + (valid_extensions + 1) * EDID_LENGTH;
-		if (read_edid_block(encoder, ext_block, j))
+		if (read_edid_block(priv, ext_block, j))
 			goto fail;
 
 		if (!drm_edid_block_valid(ext_block, j, print_bad_edid))
@@ -1144,11 +1130,10 @@ do_get_edid(struct drm_encoder *encoder)
 }
 
 static int
-tda998x_encoder_get_modes(struct drm_encoder *encoder,
-			 struct drm_connector *connector)
+tda998x_encoder_get_modes(struct tda998x_priv *priv,
+			  struct drm_connector *connector)
 {
-	struct tda998x_priv *priv = to_tda998x_priv(encoder);
-	struct edid *edid = (struct edid *)do_get_edid(encoder);
+	struct edid *edid = (struct edid *)do_get_edid(priv);
 	int n = 0;
 
 	if (edid) {
@@ -1161,18 +1146,14 @@ tda998x_encoder_get_modes(struct drm_encoder *encoder,
 	return n;
 }
 
-static int
-tda998x_encoder_create_resources(struct drm_encoder *encoder,
-				struct drm_connector *connector)
+static void tda998x_encoder_set_polling(struct tda998x_priv *priv,
+					struct drm_connector *connector)
 {
-	struct tda998x_priv *priv = to_tda998x_priv(encoder);
-
 	if (priv->hdmi->irq)
 		connector->polled = DRM_CONNECTOR_POLL_HPD;
 	else
 		connector->polled = DRM_CONNECTOR_POLL_CONNECT |
 			DRM_CONNECTOR_POLL_DISCONNECT;
-	return 0;
 }
 
 static int
@@ -1185,11 +1166,8 @@ tda998x_encoder_set_property(struct drm_encoder *encoder,
 	return 0;
 }
 
-static void
-tda998x_encoder_destroy(struct drm_encoder *encoder)
+static void tda998x_destroy(struct tda998x_priv *priv)
 {
-	struct tda998x_priv *priv = to_tda998x_priv(encoder);
-
 	/* disable all IRQs and free the IRQ handler */
 	cec_write(priv, REG_CEC_RXSHPDINTENA, 0);
 	reg_clear(priv, REG_INT_FLAGS_2, INT_FLAGS_2_EDID_BLK_RD);
@@ -1198,22 +1176,77 @@ tda998x_encoder_destroy(struct drm_encoder *encoder)
 
 	if (priv->cec)
 		i2c_unregister_device(priv->cec);
+}
+
+/* Slave encoder support */
+
+static void
+tda998x_encoder_slave_set_config(struct drm_encoder *encoder, void *params)
+{
+	tda998x_encoder_set_config(to_tda998x_priv(encoder), params);
+}
+
+static void tda998x_encoder_slave_destroy(struct drm_encoder *encoder)
+{
+	struct tda998x_priv *priv = to_tda998x_priv(encoder);
+
+	tda998x_destroy(priv);
 	drm_i2c_encoder_destroy(encoder);
 	kfree(priv);
 }
 
-static struct drm_encoder_slave_funcs tda998x_encoder_funcs = {
-	.set_config = tda998x_encoder_set_config,
-	.destroy = tda998x_encoder_destroy,
-	.dpms = tda998x_encoder_dpms,
+static void tda998x_encoder_slave_dpms(struct drm_encoder *encoder, int mode)
+{
+	tda998x_encoder_dpms(to_tda998x_priv(encoder), mode);
+}
+
+static int tda998x_encoder_slave_mode_valid(struct drm_encoder *encoder,
+					    struct drm_display_mode *mode)
+{
+	return tda998x_encoder_mode_valid(to_tda998x_priv(encoder), mode);
+}
+
+static void
+tda998x_encoder_slave_mode_set(struct drm_encoder *encoder,
+			       struct drm_display_mode *mode,
+			       struct drm_display_mode *adjusted_mode)
+{
+	tda998x_encoder_mode_set(to_tda998x_priv(encoder), mode, adjusted_mode);
+}
+
+static enum drm_connector_status
+tda998x_encoder_slave_detect(struct drm_encoder *encoder,
+			     struct drm_connector *connector)
+{
+	return tda998x_encoder_detect(to_tda998x_priv(encoder));
+}
+
+static int tda998x_encoder_slave_get_modes(struct drm_encoder *encoder,
+					   struct drm_connector *connector)
+{
+	return tda998x_encoder_get_modes(to_tda998x_priv(encoder), connector);
+}
+
+static int
+tda998x_encoder_slave_create_resources(struct drm_encoder *encoder,
+				       struct drm_connector *connector)
+{
+	tda998x_encoder_set_polling(to_tda998x_priv(encoder), connector);
+	return 0;
+}
+
+static struct drm_encoder_slave_funcs tda998x_encoder_slave_funcs = {
+	.set_config = tda998x_encoder_slave_set_config,
+	.destroy = tda998x_encoder_slave_destroy,
+	.dpms = tda998x_encoder_slave_dpms,
 	.save = tda998x_encoder_save,
 	.restore = tda998x_encoder_restore,
 	.mode_fixup = tda998x_encoder_mode_fixup,
-	.mode_valid = tda998x_encoder_mode_valid,
-	.mode_set = tda998x_encoder_mode_set,
-	.detect = tda998x_encoder_detect,
-	.get_modes = tda998x_encoder_get_modes,
-	.create_resources = tda998x_encoder_create_resources,
+	.mode_valid = tda998x_encoder_slave_mode_valid,
+	.mode_set = tda998x_encoder_slave_mode_set,
+	.detect = tda998x_encoder_slave_detect,
+	.get_modes = tda998x_encoder_slave_get_modes,
+	.create_resources = tda998x_encoder_slave_create_resources,
 	.set_property = tda998x_encoder_set_property,
 };
 
@@ -1231,20 +1264,12 @@ tda998x_remove(struct i2c_client *client)
 	return 0;
 }
 
-static int
-tda998x_encoder_init(struct i2c_client *client,
-		    struct drm_device *dev,
-		    struct drm_encoder_slave *encoder_slave)
+static int tda998x_create(struct i2c_client *client, struct tda998x_priv *priv)
 {
-	struct tda998x_priv *priv;
 	struct device_node *np = client->dev.of_node;
 	u32 video;
 	int rev_lo, rev_hi, ret;
 
-	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
 	priv->vip_cntrl_0 = VIP_CNTRL_0_SWAP_A(2) | VIP_CNTRL_0_SWAP_B(3);
 	priv->vip_cntrl_1 = VIP_CNTRL_1_SWAP_C(0) | VIP_CNTRL_1_SWAP_D(1);
 	priv->vip_cntrl_2 = VIP_CNTRL_2_SWAP_E(4) | VIP_CNTRL_2_SWAP_F(5);
@@ -1252,17 +1277,11 @@ tda998x_encoder_init(struct i2c_client *client,
 	priv->current_page = 0xff;
 	priv->hdmi = client;
 	priv->cec = i2c_new_dummy(client->adapter, 0x34);
-	if (!priv->cec) {
-		kfree(priv);
+	if (!priv->cec)
 		return -ENODEV;
-	}
 
-	priv->encoder = &encoder_slave->base;
 	priv->dpms = DRM_MODE_DPMS_OFF;
 
-	encoder_slave->slave_priv = priv;
-	encoder_slave->slave_funcs = &tda998x_encoder_funcs;
-
 	/* wake up the device: */
 	cec_write(priv, REG_CEC_ENAMODS,
 			CEC_ENAMODS_EN_RXSENS | CEC_ENAMODS_EN_HDMI);
@@ -1365,12 +1384,34 @@ tda998x_encoder_init(struct i2c_client *client,
 	 */
 	if (priv->cec)
 		i2c_unregister_device(priv->cec);
-	kfree(priv);
-	encoder_slave->slave_priv = NULL;
-	encoder_slave->slave_funcs = NULL;
 	return -ENXIO;
 }
 
+static int tda998x_encoder_init(struct i2c_client *client,
+				struct drm_device *dev,
+				struct drm_encoder_slave *encoder_slave)
+{
+	struct tda998x_priv *priv;
+	int ret;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->encoder = &encoder_slave->base;
+
+	ret = tda998x_create(client, priv);
+	if (ret) {
+		kfree(priv);
+		return ret;
+	}
+
+	encoder_slave->slave_priv = priv;
+	encoder_slave->slave_funcs = &tda998x_encoder_slave_funcs;
+
+	return 0;
+}
+
 #ifdef CONFIG_OF
 static const struct of_device_id tda998x_dt_ids[] = {
 	{ .compatible = "nxp,tda998x", },
-- 
1.8.3.1
