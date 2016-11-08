From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 08 Nov 2016 12:25:05 +0000
Subject: [PATCH RFC 02/12] drm/i2c: tda998x: avoid racy access to mode clock
In-Reply-To: <20161108122420.GP1041@n2100.armlinux.org.uk>
References: <20161108122420.GP1041@n2100.armlinux.org.uk>
Message-ID: <E1c45Sb-0005jR-9T@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid a racy access to the mode clock by storing the current mode clock
during a mode set under the audio mutex.  This allows us to access it
from the audio path in a safe way.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 1cc0433ce9d5..ab58a13d815e 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -47,6 +47,7 @@ struct tda998x_priv {
 	u8 vip_cntrl_0;
 	u8 vip_cntrl_1;
 	u8 vip_cntrl_2;
+	unsigned long tmds_clock;
 	struct tda998x_audio_params audio_params;
 
 	struct platform_device *audio_pdev;
@@ -713,8 +714,7 @@ static void tda998x_audio_mute(struct tda998x_priv *priv, bool on)
 
 static int
 tda998x_configure_audio(struct tda998x_priv *priv,
-			struct tda998x_audio_params *params,
-			unsigned mode_clock)
+			struct tda998x_audio_params *params)
 {
 	u8 buf[6], clksel_aip, clksel_fs, cts_n, adiv;
 	u32 n;
@@ -771,7 +771,7 @@ tda998x_configure_audio(struct tda998x_priv *priv,
 	 * assume 100MHz requires larger divider.
 	 */
 	adiv = AUDIO_DIV_SERCLK_8;
-	if (mode_clock > 100000)
+	if (priv->tmds_clock > 100000)
 		adiv++;			/* AUDIO_DIV_SERCLK_16 */
 
 	/* S/PDIF asks for a larger divider */
@@ -1064,6 +1064,10 @@ tda998x_encoder_mode_set(struct drm_encoder *encoder,
 	/* must be last register set: */
 	reg_write(priv, REG_TBG_CNTRL_0, 0);
 
+	mutex_lock(&priv->audio_mutex);
+
+	priv->tmds_clock = adjusted_mode->clock;
+
 	/* Only setup the info frames if the sink is HDMI */
 	if (priv->is_hdmi_sink) {
 		/* We need to turn HDMI HDCP stuff on to get audio through */
@@ -1074,13 +1078,11 @@ tda998x_encoder_mode_set(struct drm_encoder *encoder,
 
 		tda998x_write_avi(priv, adjusted_mode);
 
-		mutex_lock(&priv->audio_mutex);
 		if (priv->audio_params.format != AFMT_UNUSED)
-			tda998x_configure_audio(priv,
-						&priv->audio_params,
-						adjusted_mode->clock);
-		mutex_unlock(&priv->audio_mutex);
+			tda998x_configure_audio(priv, &priv->audio_params);
 	}
+
+	mutex_unlock(&priv->audio_mutex);
 }
 
 static enum drm_connector_status
@@ -1226,9 +1228,6 @@ static int tda998x_audio_hw_params(struct device *dev, void *data,
 		.cea = params->cea,
 	};
 
-	if (!priv->encoder.crtc)
-		return -ENODEV;
-
 	memcpy(audio.status, params->iec.status,
 	       min(sizeof(audio.status), sizeof(params->iec.status)));
 
@@ -1264,9 +1263,7 @@ static int tda998x_audio_hw_params(struct device *dev, void *data,
 	}
 
 	mutex_lock(&priv->audio_mutex);
-	ret = tda998x_configure_audio(priv,
-				      &audio,
-				      priv->encoder.crtc->hwmode.clock);
+	ret = tda998x_configure_audio(priv, &audio);
 
 	if (ret == 0)
 		priv->audio_params = audio;
-- 
2.7.4
