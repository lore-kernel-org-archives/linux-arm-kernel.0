From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Sun, 23 Oct 2016 20:10:34 +0100
Subject: [PATCH RFC 02/10] drm/i2c: tda998x: avoid configuring audio for DVI
 mode
In-Reply-To: <20161023191002.GJ1041@n2100.armlinux.org.uk>
References: <20161023191002.GJ1041@n2100.armlinux.org.uk>
Message-ID: <E1byOAE-0005yY-2W@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We must not configure the audio path when the sink is a DVI device, as
DVI has no capability to receive HDMI audio.  HDMI audio is a HDMI only
feature, requiring HDMI infoframes.

There's a question concerning how to handle a DVI connected device when
the audio device is opened - we save the audio configuration, so that if
a HDMI device is hotplugged, audio will then work.  This seems a
reasonable expectation.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index d72bc30a3bce..495ee3fed661 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -44,6 +44,7 @@ struct tda998x_priv {
 	u8 current_page;
 	int dpms;
 	bool is_hdmi_sink;
+	bool is_hdmi_config;
 	u8 vip_cntrl_0;
 	u8 vip_cntrl_1;
 	u8 vip_cntrl_2;
@@ -971,6 +972,8 @@ tda998x_encoder_mode_set(struct drm_encoder *encoder,
 			div = 3;
 	}
 
+	mutex_lock(&priv->audio_mutex);
+
 	/* mute the audio FIFO: */
 	reg_set(priv, REG_AIP_CNTRL_0, AIP_CNTRL_0_RST_FIFO);
 
@@ -1074,13 +1077,14 @@ tda998x_encoder_mode_set(struct drm_encoder *encoder,
 
 		tda998x_write_avi(priv, adjusted_mode);
 
-		mutex_lock(&priv->audio_mutex);
 		if (priv->audio_params.format != AFMT_UNUSED)
 			tda998x_configure_audio(priv,
 						&priv->audio_params,
 						adjusted_mode->clock);
-		mutex_unlock(&priv->audio_mutex);
 	}
+
+	priv->is_hdmi_config = priv->is_hdmi_sink;
+	mutex_unlock(&priv->audio_mutex);
 }
 
 static enum drm_connector_status
@@ -1264,9 +1268,12 @@ static int tda998x_audio_hw_params(struct device *dev, void *data,
 	}
 
 	mutex_lock(&priv->audio_mutex);
-	ret = tda998x_configure_audio(priv,
-				      &audio,
-				      priv->encoder.crtc->hwmode.clock);
+	/* We must not program the TDA998x for audio if the sink is DVI. */
+	if (priv->is_hdmi_config)
+		ret = tda998x_configure_audio(priv, &audio,
+					      priv->encoder.crtc->hwmode.clock);
+	else
+		ret = 0;
 
 	if (ret == 0)
 		priv->audio_params = audio;
-- 
2.1.0
