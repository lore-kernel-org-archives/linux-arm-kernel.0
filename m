From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 08 Nov 2016 12:25:15 +0000
Subject: [PATCH RFC 04/12] drm/i2c: tda998x: only configure infoframes and
 audio if supported
In-Reply-To: <20161108122420.GP1041@n2100.armlinux.org.uk>
References: <20161108122420.GP1041@n2100.armlinux.org.uk>
Message-ID: <E1c45Sl-0005jd-P8@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CEA 861B specification indicates the situations when we are able to
send each infoframe based on the version of the EDID's CEA extension.
Update the tda998x driver to follow the CEA specification wrt sending
of infoframes.

Since we only support the generation of AVI version 2, this limits us
to CEA extension version 3, so we treat CEA extension version 2 as
CEA 861 (no infoframes, no audio.)

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index bafe3c7ad84b..75833a4650e8 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -43,7 +43,7 @@ struct tda998x_priv {
 	u16 rev;
 	u8 current_page;
 	int dpms;
-	bool is_hdmi_sink;
+	bool supports_infoframes;
 	u8 vip_cntrl_0;
 	u8 vip_cntrl_1;
 	u8 vip_cntrl_2;
@@ -1068,8 +1068,20 @@ tda998x_encoder_mode_set(struct drm_encoder *encoder,
 
 	priv->tmds_clock = adjusted_mode->clock;
 
-	/* Only setup the info frames if the sink is HDMI */
-	if (priv->is_hdmi_sink) {
+	/* CEA-861B section 6 says that:
+	 * CEA version 1 (CEA-861) has no support for infoframes.
+	 * CEA version 2 (CEA-861A) supports version 1 AVI infoframes,
+	 * and optional basic audio.
+	 * CEA version 3 (CEA-861B) supports version 1 and 2 AVI infoframes,
+	 * and optional digital audio, with audio infoframes.
+	 *
+	 * Since we only support generation of version 2 AVI infoframes,
+	 * ignore CEA version 2 and below (iow, behave as if we're a
+	 * CEA-861 source.)
+	 */
+	priv->supports_infoframes = priv->connector.display_info.cea_rev >= 3;
+
+	if (priv->supports_infoframes) {
 		/* We need to turn HDMI HDCP stuff on to get audio through */
 		reg &= ~TBG_CNTRL_1_DWIN_DIS;
 		reg_write(priv, REG_TBG_CNTRL_1, reg);
@@ -1180,7 +1192,6 @@ static int tda998x_connector_get_modes(struct drm_connector *connector)
 
 	drm_mode_connector_update_edid_property(connector, edid);
 	n = drm_add_edid_modes(connector, edid);
-	priv->is_hdmi_sink = drm_detect_hdmi_monitor(edid);
 	drm_edid_to_eld(connector, edid);
 
 	kfree(edid);
@@ -1263,7 +1274,10 @@ static int tda998x_audio_hw_params(struct device *dev, void *data,
 	}
 
 	mutex_lock(&priv->audio_mutex);
-	ret = tda998x_configure_audio(priv, &audio);
+	if (priv->supports_infoframes)
+		ret = tda998x_configure_audio(priv, &audio);
+	else
+		ret = 0;
 
 	if (ret == 0)
 		priv->audio_params = audio;
-- 
2.7.4
