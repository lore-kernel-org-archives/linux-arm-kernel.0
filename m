From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 30 Jul 2018 17:42:16 +0100
Subject: [PATCH v2 3/7] drm/i2c: tda998x: move tda998x_set_config() into
 tda998x_create()
In-Reply-To: <20180730164137.GD17271@n2100.armlinux.org.uk>
References: <20180730164137.GD17271@n2100.armlinux.org.uk>
Message-ID: <E1fkBFQ-00048e-Cq@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the non-DT configuration of the TDA998x into tda998x_create()
so that we do all setup in one place.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 73 +++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 1c2f5dac1886..843078e9fbf3 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -1621,6 +1621,25 @@ static int tda998x_get_audio_ports(struct tda998x_priv *priv,
 	return 0;
 }
 
+static void tda998x_set_config(struct tda998x_priv *priv,
+			       const struct tda998x_encoder_params *p)
+{
+	priv->vip_cntrl_0 = VIP_CNTRL_0_SWAP_A(p->swap_a) |
+			    (p->mirr_a ? VIP_CNTRL_0_MIRR_A : 0) |
+			    VIP_CNTRL_0_SWAP_B(p->swap_b) |
+			    (p->mirr_b ? VIP_CNTRL_0_MIRR_B : 0);
+	priv->vip_cntrl_1 = VIP_CNTRL_1_SWAP_C(p->swap_c) |
+			    (p->mirr_c ? VIP_CNTRL_1_MIRR_C : 0) |
+			    VIP_CNTRL_1_SWAP_D(p->swap_d) |
+			    (p->mirr_d ? VIP_CNTRL_1_MIRR_D : 0);
+	priv->vip_cntrl_2 = VIP_CNTRL_2_SWAP_E(p->swap_e) |
+			    (p->mirr_e ? VIP_CNTRL_2_MIRR_E : 0) |
+			    VIP_CNTRL_2_SWAP_F(p->swap_f) |
+			    (p->mirr_f ? VIP_CNTRL_2_MIRR_F : 0);
+
+	priv->audio_params = p->audio_params;
+}
+
 static int tda998x_create(struct i2c_client *client, struct tda998x_priv *priv)
 {
 	struct device_node *np = client->dev.of_node;
@@ -1772,23 +1791,24 @@ static int tda998x_create(struct i2c_client *client, struct tda998x_priv *priv)
 	/* enable EDID read irq: */
 	reg_set(priv, REG_INT_FLAGS_2, INT_FLAGS_2_EDID_BLK_RD);
 
-	if (!np)
-		return 0;		/* non-DT */
+	if (np) {
+		/* get the device tree parameters */
+		ret = of_property_read_u32(np, "video-ports", &video);
+		if (ret == 0) {
+			priv->vip_cntrl_0 = video >> 16;
+			priv->vip_cntrl_1 = video >> 8;
+			priv->vip_cntrl_2 = video;
+		}
 
-	/* get the device tree parameters */
-	ret = of_property_read_u32(np, "video-ports", &video);
-	if (ret == 0) {
-		priv->vip_cntrl_0 = video >> 16;
-		priv->vip_cntrl_1 = video >> 8;
-		priv->vip_cntrl_2 = video;
-	}
+		ret = tda998x_get_audio_ports(priv, np);
+		if (ret)
+			goto fail;
 
-	ret = tda998x_get_audio_ports(priv, np);
-	if (ret)
-		goto fail;
-
-	if (priv->audio_port[0].format != AFMT_UNUSED)
-		tda998x_audio_codec_init(priv, &client->dev);
+		if (priv->audio_port[0].format != AFMT_UNUSED)
+			tda998x_audio_codec_init(priv, &client->dev);
+	} else if (client->dev.platform_data) {
+		tda998x_set_config(priv, client->dev.platform_data);
+	}
 
 	return 0;
 
@@ -1834,28 +1854,8 @@ static const struct drm_encoder_funcs tda998x_encoder_funcs = {
 	.destroy = tda998x_encoder_destroy,
 };
 
-static void tda998x_set_config(struct tda998x_priv *priv,
-			       const struct tda998x_encoder_params *p)
-{
-	priv->vip_cntrl_0 = VIP_CNTRL_0_SWAP_A(p->swap_a) |
-			    (p->mirr_a ? VIP_CNTRL_0_MIRR_A : 0) |
-			    VIP_CNTRL_0_SWAP_B(p->swap_b) |
-			    (p->mirr_b ? VIP_CNTRL_0_MIRR_B : 0);
-	priv->vip_cntrl_1 = VIP_CNTRL_1_SWAP_C(p->swap_c) |
-			    (p->mirr_c ? VIP_CNTRL_1_MIRR_C : 0) |
-			    VIP_CNTRL_1_SWAP_D(p->swap_d) |
-			    (p->mirr_d ? VIP_CNTRL_1_MIRR_D : 0);
-	priv->vip_cntrl_2 = VIP_CNTRL_2_SWAP_E(p->swap_e) |
-			    (p->mirr_e ? VIP_CNTRL_2_MIRR_E : 0) |
-			    VIP_CNTRL_2_SWAP_F(p->swap_f) |
-			    (p->mirr_f ? VIP_CNTRL_2_MIRR_F : 0);
-
-	priv->audio_params = p->audio_params;
-}
-
 static int tda998x_bind(struct device *dev, struct device *master, void *data)
 {
-	struct tda998x_encoder_params *params = dev->platform_data;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct drm_device *drm = data;
 	struct tda998x_priv *priv;
@@ -1883,9 +1883,6 @@ static int tda998x_bind(struct device *dev, struct device *master, void *data)
 	if (ret)
 		return ret;
 
-	if (!dev->of_node && params)
-		tda998x_set_config(priv, params);
-
 	drm_encoder_helper_add(&priv->encoder, &tda998x_encoder_helper_funcs);
 	ret = drm_encoder_init(drm, &priv->encoder, &tda998x_encoder_funcs,
 			       DRM_MODE_ENCODER_TMDS, NULL);
-- 
2.7.4
