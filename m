From: moinejf@free.fr (Jean-Francois Moine)
Date: Wed, 23 Oct 2013 09:41:49 +0200
Subject: ]PATCH 9/10] drm/i2c: tda998x: fix some video errors
Message-ID: <20131023094149.127451db@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes some video errors:
- shift and set the repeat PLL value in range 0..3
- set the quantization range to RGB/YUV instead of full
- set 0 the register ENABLE_SPACE to fill the active space
- set the 'toggle enable' bit when needed
- move the TBG_CNTRL_0 setting as the last register set
- don't set SYNC_ONCE

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 28 ++++++++++++++--------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index e19a554..b0eecee 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -224,7 +224,7 @@ struct tda998x_priv {
 # define PLL_SERIAL_1_SRL_IZ(x)   (((x) & 3) << 1)
 # define PLL_SERIAL_1_SRL_MAN_IZ  (1 << 6)
 #define REG_PLL_SERIAL_2          REG(0x02, 0x01)     /* read/write */
-# define PLL_SERIAL_2_SRL_NOSC(x) (((x) & 3) << 0)
+# define PLL_SERIAL_2_SRL_NOSC(x) ((x) << 0)
 # define PLL_SERIAL_2_SRL_PR(x)   (((x) & 0xf) << 4)
 #define REG_PLL_SERIAL_3          REG(0x02, 0x02)     /* read/write */
 # define PLL_SERIAL_3_SRL_CCIR    (1 << 0)
@@ -975,6 +975,11 @@ tda998x_encoder_mode_set(struct drm_encoder *encoder,
 	}
 
 	div = 148500 / mode->clock;
+	if (div != 0) {
+		div--;
+		if (div > 3)
+			div = 3;
+	}
 
 	/* mute the audio FIFO: */
 	reg_set(priv, REG_AIP_CNTRL_0, AIP_CNTRL_0_RST_FIFO);
@@ -995,7 +1000,9 @@ tda998x_encoder_mode_set(struct drm_encoder *encoder,
 	reg_clear(priv, REG_PLL_SERIAL_1, PLL_SERIAL_1_SRL_MAN_IZ);
 	reg_clear(priv, REG_PLL_SERIAL_3, PLL_SERIAL_3_SRL_DE);
 	reg_write(priv, REG_SERIALIZER, 0);
-	reg_write(priv, REG_HVF_CNTRL_1, HVF_CNTRL_1_VQR(0));
+
+	/* video quantization range = 0: full, 1: RGB/YUV, 2: YUV */
+	reg_write(priv, REG_HVF_CNTRL_1, HVF_CNTRL_1_VQR(1));
 
 	/* TODO enable pixel repeat for pixel rates less than 25Msamp/s */
 	rep = 0;
@@ -1013,7 +1020,7 @@ tda998x_encoder_mode_set(struct drm_encoder *encoder,
 	/* set BIAS tmds value: */
 	reg_write(priv, REG_ANA_GENERAL, 0x09);
 
-	reg_write(priv, REG_TBG_CNTRL_0, TBG_CNTRL_0_SYNC_MTHD);
+	reg_write(priv, REG_TBG_CNTRL_0, 0);
 
 	/*
 	 * Sync on rising HSYNC/VSYNC
@@ -1065,22 +1072,19 @@ tda998x_encoder_mode_set(struct drm_encoder *encoder,
 
 		if (priv->rev == TDA19988) {
 			/* let incoming pixels fill the active space (if any) */
-			reg_write(priv, REG_ENABLE_SPACE, 0x01);
+			reg_write(priv, REG_ENABLE_SPACE, 0x00);
 		}
 	}
 
-	/* must be last register set: */
-	reg_clear(priv, REG_TBG_CNTRL_0, TBG_CNTRL_0_SYNC_ONCE);
-
 	/*
 	 * Always generate sync polarity relative to input sync and
 	 * revert input stage toggled sync at output stage
 	 */
-	reg = TBG_CNTRL_1_DWIN_DIS | TBG_CNTRL_1_TGL_EN;
+	reg = TBG_CNTRL_1_DWIN_DIS;
 	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
-		reg |= TBG_CNTRL_1_H_TGL;
+		reg |= TBG_CNTRL_1_H_TGL | TBG_CNTRL_1_TGL_EN;
 	if (mode->flags & DRM_MODE_FLAG_NVSYNC)
-		reg |= TBG_CNTRL_1_V_TGL;
+		reg |= TBG_CNTRL_1_V_TGL | TBG_CNTRL_1_TGL_EN;
 	reg_write(priv, REG_TBG_CNTRL_1, reg);
 
 	/* Only setup the info frames if the sink is HDMI */
@@ -1096,6 +1100,10 @@ tda998x_encoder_mode_set(struct drm_encoder *encoder,
 		if (priv->audio)
 			tda998x_configure_audio(priv, mode, &priv->params);
 	}
+
+	/* must be last register set: */
+	reg_write(priv, REG_TBG_CNTRL_0, 0);
+/*			TBG_CNTRL_0_SYNC_ONCE does not work after dpms off/on */
 }
 
 static enum drm_connector_status

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
