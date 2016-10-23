From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Sun, 23 Oct 2016 20:10:39 +0100
Subject: [PATCH RFC 03/10] drm/i2c: tda998x: avoid racy access to mode clock
In-Reply-To: <20161023191002.GJ1041@n2100.armlinux.org.uk>
References: <20161023191002.GJ1041@n2100.armlinux.org.uk>
Message-ID: <E1byOAJ-0005yk-5w@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid a racy access to the mode clock by storing the current mode clock
during a mode set under the audio mutex.  This allows us to access it
from the audio path in a safe way.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 495ee3fed661..858237f7f4d6 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -48,6 +48,7 @@ struct tda998x_priv {
 	u8 vip_cntrl_0;
 	u8 vip_cntrl_1;
 	u8 vip_cntrl_2;
+	unsigned long tdms_clock;
 	struct tda998x_audio_params audio_params;
 
 	struct platform_device *audio_pdev;
@@ -714,8 +715,7 @@ static void tda998x_audio_mute(struct tda998x_priv *priv, bool on)
 
 static int
 tda998x_configure_audio(struct tda998x_priv *priv,
-			struct tda998x_audio_params *params,
-			unsigned mode_clock)
+			struct tda998x_audio_params *params)
 {
 	u8 buf[6], clksel_aip, clksel_fs, cts_n, adiv;
 	u32 n;
@@ -772,7 +772,7 @@ tda998x_configure_audio(struct tda998x_priv *priv,
 	 * assume 100MHz requires larger divider.
 	 */
 	adiv = AUDIO_DIV_SERCLK_8;
-	if (mode_clock > 100000)
+	if (priv->tdms_clock > 100000)
 		adiv++;			/* AUDIO_DIV_SERCLK_16 */
 
 	/* S/PDIF asks for a larger divider */
@@ -1077,10 +1077,10 @@ tda998x_encoder_mode_set(struct drm_encoder *encoder,
 
 		tda998x_write_avi(priv, adjusted_mode);
 
+		priv->tdms_clock = adjusted_mode->clock;
+
 		if (priv->audio_params.format != AFMT_UNUSED)
-			tda998x_configure_audio(priv,
-						&priv->audio_params,
-						adjusted_mode->clock);
+			tda998x_configure_audio(priv, &priv->audio_params);
 	}
 
 	priv->is_hdmi_config = priv->is_hdmi_sink;
@@ -1230,9 +1230,6 @@ static int tda998x_audio_hw_params(struct device *dev, void *data,
 		.cea = params->cea,
 	};
 
-	if (!priv->encoder.crtc)
-		return -ENODEV;
-
 	memcpy(audio.status, params->iec.status,
 	       min(sizeof(audio.status), sizeof(params->iec.status)));
 
@@ -1270,8 +1267,7 @@ static int tda998x_audio_hw_params(struct device *dev, void *data,
 	mutex_lock(&priv->audio_mutex);
 	/* We must not program the TDA998x for audio if the sink is DVI. */
 	if (priv->is_hdmi_config)
-		ret = tda998x_configure_audio(priv, &audio,
-					      priv->encoder.crtc->hwmode.clock);
+		ret = tda998x_configure_audio(priv, &audio);
 	else
 		ret = 0;
 
-- 
2.1.0
