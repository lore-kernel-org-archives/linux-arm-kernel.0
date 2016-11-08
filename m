From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 08 Nov 2016 12:25:58 +0000
Subject: [PATCH RFC 12/12] drm/i2c: tda998x: switch to boolean is_on
In-Reply-To: <20161108122420.GP1041@n2100.armlinux.org.uk>
References: <20161108122420.GP1041@n2100.armlinux.org.uk>
Message-ID: <E1c45TS-0005kT-2y@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than storing the DPMS mode (which will always be on or off) use a
boolean to store this instead.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 226871e34442..3a5e5c466972 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -42,7 +42,7 @@ struct tda998x_priv {
 	struct mutex mutex;
 	u16 rev;
 	u8 current_page;
-	int dpms;
+	bool is_on;
 	bool supports_infoframes;
 	bool sink_has_audio;
 	u8 vip_cntrl_0;
@@ -1159,16 +1159,15 @@ static int tda998x_connector_init(struct tda998x_priv *priv,
 static void tda998x_encoder_dpms(struct drm_encoder *encoder, int mode)
 {
 	struct tda998x_priv *priv = enc_to_tda998x_priv(encoder);
+	bool on;
 
 	/* we only care about on or off: */
-	if (mode != DRM_MODE_DPMS_ON)
-		mode = DRM_MODE_DPMS_OFF;
+	on = mode == DRM_MODE_DPMS_ON;
 
-	if (mode == priv->dpms)
+	if (on == priv->is_on)
 		return;
 
-	switch (mode) {
-	case DRM_MODE_DPMS_ON:
+	if (on) {
 		/* enable video ports, audio will be enabled later */
 		reg_write(priv, REG_ENA_VP_0, 0xff);
 		reg_write(priv, REG_ENA_VP_1, 0xff);
@@ -1177,16 +1176,16 @@ static void tda998x_encoder_dpms(struct drm_encoder *encoder, int mode)
 		reg_write(priv, REG_VIP_CNTRL_0, priv->vip_cntrl_0);
 		reg_write(priv, REG_VIP_CNTRL_1, priv->vip_cntrl_1);
 		reg_write(priv, REG_VIP_CNTRL_2, priv->vip_cntrl_2);
-		break;
-	case DRM_MODE_DPMS_OFF:
+
+		priv->is_on = true;
+	} else {
 		/* disable video ports */
 		reg_write(priv, REG_ENA_VP_0, 0x00);
 		reg_write(priv, REG_ENA_VP_1, 0x00);
 		reg_write(priv, REG_ENA_VP_2, 0x00);
-		break;
-	}
 
-	priv->dpms = mode;
+		priv->is_on = false;
+	}
 }
 
 static void
@@ -1480,8 +1479,6 @@ static int tda998x_create(struct i2c_client *client, struct tda998x_priv *priv)
 	if (!priv->cec)
 		return -ENODEV;
 
-	priv->dpms = DRM_MODE_DPMS_OFF;
-
 	mutex_init(&priv->mutex);	/* protect the page access */
 	init_waitqueue_head(&priv->edid_delay_waitq);
 	setup_timer(&priv->edid_delay_timer, tda998x_edid_delay_done,
-- 
2.7.4
