From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 31 Jul 2018 10:26:44 +0100
Subject: [PATCH 2/4] drm/i2c: tda998x: get rid of private fill_modes function
In-Reply-To: <20180731092343.GH17271@n2100.armlinux.org.uk>
References: <20180731092343.GH17271@n2100.armlinux.org.uk>
Message-ID: <E1fkQvU-0003nG-OK@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can achieve the same effect via the get_modes() method, rather than
wrapping the fill_modes helper.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 58831b6a4722..98ec91a55a6a 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -1097,29 +1097,6 @@ static int tda998x_audio_codec_init(struct tda998x_priv *priv,
 
 /* DRM connector functions */
 
-static int tda998x_connector_fill_modes(struct drm_connector *connector,
-					uint32_t maxX, uint32_t maxY)
-{
-	struct tda998x_priv *priv = conn_to_tda998x_priv(connector);
-	int ret;
-
-	mutex_lock(&priv->audio_mutex);
-	ret = drm_helper_probe_single_connector_modes(connector, maxX, maxY);
-
-	if (connector->edid_blob_ptr) {
-		struct edid *edid = (void *)connector->edid_blob_ptr->data;
-
-		cec_notifier_set_phys_addr_from_edid(priv->cec_notify, edid);
-
-		priv->sink_has_audio = drm_detect_monitor_audio(edid);
-	} else {
-		priv->sink_has_audio = false;
-	}
-	mutex_unlock(&priv->audio_mutex);
-
-	return ret;
-}
-
 static enum drm_connector_status
 tda998x_connector_detect(struct drm_connector *connector, bool force)
 {
@@ -1138,7 +1115,7 @@ static void tda998x_connector_destroy(struct drm_connector *connector)
 static const struct drm_connector_funcs tda998x_connector_funcs = {
 	.dpms = drm_helper_connector_dpms,
 	.reset = drm_atomic_helper_connector_reset,
-	.fill_modes = tda998x_connector_fill_modes,
+	.fill_modes = drm_helper_probe_single_connector_modes,
 	.detect = tda998x_connector_detect,
 	.destroy = tda998x_connector_destroy,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
@@ -1237,7 +1214,12 @@ static int tda998x_connector_get_modes(struct drm_connector *connector)
 	}
 
 	drm_connector_update_edid_property(connector, edid);
+	cec_notifier_set_phys_addr_from_edid(priv->cec_notify, edid);
+
+	mutex_lock(&priv->audio_mutex);
 	n = drm_add_edid_modes(connector, edid);
+	priv->sink_has_audio = drm_detect_monitor_audio(edid);
+	mutex_unlock(&priv->audio_mutex);
 
 	kfree(edid);
 
-- 
2.7.4
