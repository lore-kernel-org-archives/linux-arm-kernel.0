From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 9 Jan 2014 11:59:03 +0100
Subject: [PATCH v2 7/28] drm/i2c: tda998x: set the video mode from the
 adjusted value
Message-ID: <20140109115903.00517f15@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch uses always the adjusted video mode instead of a mix of
original and adjusted mode.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/gpu/drm/i2c/tda998x_drv.c    | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index c29c0b1..1abf404 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -777,6 +777,8 @@ tda998x_encoder_mode_set(struct drm_encoder *encoder,
 	uint16_t de_pix_s, de_pix_e;
 	uint8_t reg, div, rep;
 
+	mode = adjusted_mode;
+
 	/*
 	 * Internally TDA998x is using ITU-R BT.656 style sync but
 	 * we get VESA style sync. TDA998x is using a reference pixel
@@ -808,8 +810,8 @@ tda998x_encoder_mode_set(struct drm_encoder *encoder,
 	 * those to adjust the position of the rising VS edge by adding
 	 * HSKEW to ref_pix.
 	 */
-	if (adjusted_mode->flags & DRM_MODE_FLAG_HSKEW)
-		ref_pix += adjusted_mode->hskew;
+	if (mode->flags & DRM_MODE_FLAG_HSKEW)
+		ref_pix += mode->hskew;
 
 	if ((mode->flags & DRM_MODE_FLAG_INTERLACE) == 0) {
 		ref_line     = 1 + mode->vsync_start - mode->vdisplay;
@@ -941,11 +943,10 @@ tda998x_encoder_mode_set(struct drm_encoder *encoder,
 		reg_write(priv, REG_ENC_CNTRL, ENC_CNTRL_CTL_CODE(1));
 		reg_set(priv, REG_TX33, TX33_HDMI);
 
-		tda998x_write_avi(priv, adjusted_mode);
+		tda998x_write_avi(priv, mode);
 
 		if (priv->params.audio_cfg)
-			tda998x_configure_audio(priv, adjusted_mode,
-						&priv->params);
+			tda998x_configure_audio(priv, mode, &priv->params);
 	}
 }
 

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
