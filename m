From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 9 Jan 2014 11:59:41 +0100
Subject: [PATCH v2 9/28] drm/i2c: tda998x: don't read write-only registers
Message-ID: <20140109115941.30e67a37@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch takes care of the write-only registers of the tda998x.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 44 +++++++++++-----------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 99c3796..c3f0d70 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -487,9 +487,9 @@ static void
 tda998x_reset(struct tda998x_priv *priv)
 {
 	/* reset audio and i2c master: */
-	reg_set(priv, REG_SOFTRESET, SOFTRESET_AUDIO | SOFTRESET_I2C_MASTER);
+	reg_write(priv, REG_SOFTRESET, SOFTRESET_AUDIO | SOFTRESET_I2C_MASTER);
 	msleep(50);
-	reg_clear(priv, REG_SOFTRESET, SOFTRESET_AUDIO | SOFTRESET_I2C_MASTER);
+	reg_write(priv, REG_SOFTRESET, 0);
 	msleep(50);
 
 	/* reset transmitter: */
@@ -846,7 +846,7 @@ tda998x_encoder_mode_set(struct drm_encoder *encoder,
 	reg_set(priv, REG_AIP_CNTRL_0, AIP_CNTRL_0_RST_FIFO);
 
 	/* set HDMI HDCP mode off: */
-	reg_set(priv, REG_TBG_CNTRL_1, TBG_CNTRL_1_DWIN_DIS);
+	reg_write(priv, REG_TBG_CNTRL_1, TBG_CNTRL_1_DWIN_DIS);
 	reg_clear(priv, REG_TX33, TX33_HDMI);
 	reg_write(priv, REG_ENC_CNTRL, ENC_CNTRL_CTL_CODE(0));
 
@@ -873,38 +873,28 @@ tda998x_encoder_mode_set(struct drm_encoder *encoder,
 			PLL_SERIAL_2_SRL_PR(rep));
 
 	/* set color matrix bypass flag: */
-	reg_set(priv, REG_MAT_CONTRL, MAT_CONTRL_MAT_BP);
+	reg_write(priv, REG_MAT_CONTRL, MAT_CONTRL_MAT_BP |
+				MAT_CONTRL_MAT_SC(1));
 
 	/* set BIAS tmds value: */
 	reg_write(priv, REG_ANA_GENERAL, 0x09);
 
-	reg_clear(priv, REG_TBG_CNTRL_0, TBG_CNTRL_0_SYNC_MTHD);
+	reg_write(priv, REG_TBG_CNTRL_0, 0);
 
 	/*
 	 * Sync on rising HSYNC/VSYNC
 	 */
-	reg_write(priv, REG_VIP_CNTRL_3, 0);
-	reg_set(priv, REG_VIP_CNTRL_3, VIP_CNTRL_3_SYNC_HS);
+	reg = VIP_CNTRL_3_SYNC_HS;
 
 	/*
 	 * TDA19988 requires high-active sync at input stage,
 	 * so invert low-active sync provided by master encoder here
 	 */
 	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
-		reg_set(priv, REG_VIP_CNTRL_3, VIP_CNTRL_3_H_TGL);
+		reg |= VIP_CNTRL_3_H_TGL;
 	if (mode->flags & DRM_MODE_FLAG_NVSYNC)
-		reg_set(priv, REG_VIP_CNTRL_3, VIP_CNTRL_3_V_TGL);
-
-	/*
-	 * Always generate sync polarity relative to input sync and
-	 * revert input stage toggled sync at output stage
-	 */
-	reg = TBG_CNTRL_1_TGL_EN;
-	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
-		reg |= TBG_CNTRL_1_H_TGL;
-	if (mode->flags & DRM_MODE_FLAG_NVSYNC)
-		reg |= TBG_CNTRL_1_V_TGL;
-	reg_write(priv, REG_TBG_CNTRL_1, reg);
+		reg |= VIP_CNTRL_3_V_TGL;
+	reg_write(priv, REG_VIP_CNTRL_3, reg);
 
 	reg_write(priv, REG_VIDFORMAT, 0x00);
 	reg_write16(priv, REG_REFPIX_MSB, ref_pix);
@@ -936,10 +926,22 @@ tda998x_encoder_mode_set(struct drm_encoder *encoder,
 	/* must be last register set: */
 	reg_clear(priv, REG_TBG_CNTRL_0, TBG_CNTRL_0_SYNC_ONCE);
 
+	/*
+	 * Always generate sync polarity relative to input sync and
+	 * revert input stage toggled sync at output stage
+	 */
+	reg = TBG_CNTRL_1_DWIN_DIS | TBG_CNTRL_1_TGL_EN;
+	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
+		reg |= TBG_CNTRL_1_H_TGL;
+	if (mode->flags & DRM_MODE_FLAG_NVSYNC)
+		reg |= TBG_CNTRL_1_V_TGL;
+	reg_write(priv, REG_TBG_CNTRL_1, reg);
+
 	/* Only setup the info frames if the sink is HDMI */
 	if (priv->is_hdmi_sink) {
 		/* We need to turn HDMI HDCP stuff on to get audio through */
-		reg_clear(priv, REG_TBG_CNTRL_1, TBG_CNTRL_1_DWIN_DIS);
+		reg &= ~TBG_CNTRL_1_DWIN_DIS;
+		reg_write(priv, REG_TBG_CNTRL_1, reg);
 		reg_write(priv, REG_ENC_CNTRL, ENC_CNTRL_CTL_CODE(1));
 		reg_set(priv, REG_TX33, TX33_HDMI);
 

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
