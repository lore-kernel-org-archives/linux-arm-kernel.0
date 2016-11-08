From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 08 Nov 2016 12:25:31 +0000
Subject: [PATCH RFC 07/12] drm/i2c: tda998x: move and rename
 tda998x_encoder_set_config()
In-Reply-To: <20161108122420.GP1041@n2100.armlinux.org.uk>
References: <20161108122420.GP1041@n2100.armlinux.org.uk>
Message-ID: <E1c45T1-0005jv-VK@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The naming of tda998x_encoder_set_config() is a left-over from when
TDA998x was a slave encoder.  Since this is part of the initialisation,
drop the _encoder from the name, and move it near tda998x_bind().

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 40 +++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 349e04a30210..6b966c19a449 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -822,25 +822,6 @@ tda998x_configure_audio(struct tda998x_priv *priv,
 
 /* DRM encoder functions */
 
-static void tda998x_encoder_set_config(struct tda998x_priv *priv,
-				       const struct tda998x_encoder_params *p)
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
 static void tda998x_encoder_dpms(struct drm_encoder *encoder, int mode)
 {
 	struct tda998x_priv *priv = enc_to_tda998x_priv(encoder);
@@ -1636,6 +1617,25 @@ static const struct drm_connector_funcs tda998x_connector_funcs = {
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
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
 static int tda998x_bind(struct device *dev, struct device *master, void *data)
 {
 	struct tda998x_encoder_params *params = dev->platform_data;
@@ -1668,7 +1668,7 @@ static int tda998x_bind(struct device *dev, struct device *master, void *data)
 		return ret;
 
 	if (!dev->of_node && params)
-		tda998x_encoder_set_config(priv, params);
+		tda998x_set_config(priv, params);
 
 	tda998x_encoder_set_polling(priv, &priv->connector);
 
-- 
2.7.4
