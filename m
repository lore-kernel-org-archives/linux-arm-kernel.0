From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 08 Nov 2016 12:25:21 +0000
Subject: [PATCH RFC 05/12] drm/i2c: tda998x: only enable audio if supported by
 sink
In-Reply-To: <20161108122420.GP1041@n2100.armlinux.org.uk>
References: <20161108122420.GP1041@n2100.armlinux.org.uk>
Message-ID: <E1c45Sr-0005jj-58@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Check for audio support by the attached sink by consulting the EDID
prior to enabling audio over the TMDS link.  We must consult the EDID
after calling drm_helper_probe_single_connector_modes(), as this can
use an override EDID, or load a replacement EDID.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 75833a4650e8..fa13ac0e8691 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -44,6 +44,7 @@ struct tda998x_priv {
 	u8 current_page;
 	int dpms;
 	bool supports_infoframes;
+	bool sink_has_audio;
 	u8 vip_cntrl_0;
 	u8 vip_cntrl_1;
 	u8 vip_cntrl_2;
@@ -1090,13 +1091,33 @@ tda998x_encoder_mode_set(struct drm_encoder *encoder,
 
 		tda998x_write_avi(priv, adjusted_mode);
 
-		if (priv->audio_params.format != AFMT_UNUSED)
+		if (priv->audio_params.format != AFMT_UNUSED &&
+		    priv->sink_has_audio)
 			tda998x_configure_audio(priv, &priv->audio_params);
 	}
 
 	mutex_unlock(&priv->audio_mutex);
 }
 
+static int tda998x_connector_fill_modes(struct drm_connector *connector,
+					uint32_t maxX, uint32_t maxY)
+{
+	struct tda998x_priv *priv = conn_to_tda998x_priv(connector);
+	int ret;
+
+	ret = drm_helper_probe_single_connector_modes(connector, maxX, maxY);
+
+	if (connector->edid_blob_ptr) {
+		struct edid *edid = (void *)connector->edid_blob_ptr->data;
+
+		priv->sink_has_audio = drm_detect_monitor_audio(edid);
+	} else {
+		priv->sink_has_audio = false;
+	}
+
+	return ret;
+}
+
 static enum drm_connector_status
 tda998x_connector_detect(struct drm_connector *connector, bool force)
 {
@@ -1274,7 +1295,7 @@ static int tda998x_audio_hw_params(struct device *dev, void *data,
 	}
 
 	mutex_lock(&priv->audio_mutex);
-	if (priv->supports_infoframes)
+	if (priv->supports_infoframes && priv->sink_has_audio)
 		ret = tda998x_configure_audio(priv, &audio);
 	else
 		ret = 0;
@@ -1608,7 +1629,7 @@ static int tda998x_connector_dpms(struct drm_connector *connector, int mode)
 static const struct drm_connector_funcs tda998x_connector_funcs = {
 	.dpms = tda998x_connector_dpms,
 	.reset = drm_atomic_helper_connector_reset,
-	.fill_modes = drm_helper_probe_single_connector_modes,
+	.fill_modes = tda998x_connector_fill_modes,
 	.detect = tda998x_connector_detect,
 	.destroy = tda998x_connector_destroy,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
-- 
2.7.4
