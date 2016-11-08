From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 Nov 2016 13:34:12 +0000
Subject: [PATCH RFC 00/12] tda998x updates
In-Reply-To: <20161108133215.GQ1041@n2100.armlinux.org.uk>
References: <20161108122420.GP1041@n2100.armlinux.org.uk>
 <2264579a-3273-d9c4-761a-f50f547eb39b@arm.com>
 <20161108133215.GQ1041@n2100.armlinux.org.uk>
Message-ID: <20161108133411.GA31754@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 08, 2016 at 01:32:15PM +0000, Russell King - ARM Linux wrote:
> Unfortunately, my drm-tda998x-devel branch is slightly out of date with
> these patches it's the original set of 10 patches.  I've not pushed
> these ones out to that branch yet, as I've three additional patches on
> top of these which aren't "ready" for pushing out.

Here's the delta between the branch and what I just posted:

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 1b262a89b7e1..3a5e5c466972 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -43,12 +43,12 @@ struct tda998x_priv {
 	u16 rev;
 	u8 current_page;
 	bool is_on;
-	bool is_hdmi_sink;
-	bool is_hdmi_config;
+	bool supports_infoframes;
+	bool sink_has_audio;
 	u8 vip_cntrl_0;
 	u8 vip_cntrl_1;
 	u8 vip_cntrl_2;
-	unsigned long tdms_clock;
+	unsigned long tmds_clock;
 	struct tda998x_audio_params audio_params;
 
 	struct platform_device *audio_pdev;
@@ -774,7 +774,7 @@ tda998x_configure_audio(struct tda998x_priv *priv,
 	 * assume 100MHz requires larger divider.
 	 */
 	adiv = AUDIO_DIV_SERCLK_8;
-	if (priv->tdms_clock > 100000)
+	if (priv->tmds_clock > 100000)
 		adiv++;			/* AUDIO_DIV_SERCLK_16 */
 
 	/* S/PDIF asks for a larger divider */
@@ -869,8 +869,7 @@ static int tda998x_audio_hw_params(struct device *dev, void *data,
 	}
 
 	mutex_lock(&priv->audio_mutex);
-	/* We must not program the TDA998x for audio if the sink is DVI. */
-	if (priv->is_hdmi_config)
+	if (priv->supports_infoframes && priv->sink_has_audio)
 		ret = tda998x_configure_audio(priv, &audio);
 	else
 		ret = 0;
@@ -962,6 +961,27 @@ static int tda998x_connector_dpms(struct drm_connector *connector, int mode)
 		return drm_helper_connector_dpms(connector, mode);
 }
 
+static int tda998x_connector_fill_modes(struct drm_connector *connector,
+					uint32_t maxX, uint32_t maxY)
+{
+	struct tda998x_priv *priv = conn_to_tda998x_priv(connector);
+	int ret;
+
+	mutex_lock(&priv->audio_mutex);
+	ret = drm_helper_probe_single_connector_modes(connector, maxX, maxY);
+
+	if (connector->edid_blob_ptr) {
+		struct edid *edid = (void *)connector->edid_blob_ptr->data;
+
+		priv->sink_has_audio = drm_detect_monitor_audio(edid);
+	} else {
+		priv->sink_has_audio = false;
+	}
+	mutex_unlock(&priv->audio_mutex);
+
+	return ret;
+}
+
 static enum drm_connector_status
 tda998x_connector_detect(struct drm_connector *connector, bool force)
 {
@@ -980,7 +1000,7 @@ static void tda998x_connector_destroy(struct drm_connector *connector)
 static const struct drm_connector_funcs tda998x_connector_funcs = {
 	.dpms = tda998x_connector_dpms,
 	.reset = drm_atomic_helper_connector_reset,
-	.fill_modes = drm_helper_probe_single_connector_modes,
+	.fill_modes = tda998x_connector_fill_modes,
 	.detect = tda998x_connector_detect,
 	.destroy = tda998x_connector_destroy,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
@@ -1072,11 +1092,7 @@ static int tda998x_connector_get_modes(struct drm_connector *connector)
 
 	drm_mode_connector_update_edid_property(connector, edid);
 	n = drm_add_edid_modes(connector, edid);
-	priv->is_hdmi_sink = drm_detect_hdmi_monitor(edid);
-
-	mutex_lock(&priv->audio_mutex);
 	drm_edid_to_eld(connector, edid);
-	mutex_unlock(&priv->audio_mutex);
 
 	kfree(edid);
 
@@ -1350,8 +1366,22 @@ tda998x_encoder_mode_set(struct drm_encoder *encoder,
 	/* must be last register set: */
 	reg_write(priv, REG_TBG_CNTRL_0, 0);
 
-	/* Only setup the info frames if the sink is HDMI */
-	if (priv->is_hdmi_sink) {
+	priv->tmds_clock = adjusted_mode->clock;
+
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
@@ -1360,13 +1390,11 @@ tda998x_encoder_mode_set(struct drm_encoder *encoder,
 
 		tda998x_write_avi(priv, adjusted_mode);
 
-		priv->tdms_clock = adjusted_mode->clock;
-
-		if (priv->audio_params.format != AFMT_UNUSED)
+		if (priv->audio_params.format != AFMT_UNUSED &&
+		    priv->sink_has_audio)
 			tda998x_configure_audio(priv, &priv->audio_params);
 	}
 
-	priv->is_hdmi_config = priv->is_hdmi_sink;
 	mutex_unlock(&priv->audio_mutex);
 }
 


-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
