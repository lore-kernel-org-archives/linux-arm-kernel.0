From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Sun, 23 Oct 2016 20:11:10 +0100
Subject: [PATCH RFC 09/10] drm/i2c: tda998x: remove complexity from
 tda998x_audio_get_eld()
In-Reply-To: <20161023191002.GJ1041@n2100.armlinux.org.uk>
References: <20161023191002.GJ1041@n2100.armlinux.org.uk>
Message-ID: <E1byOAn-0005zM-WF@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tda998x_audio_get_eld() is needlessly complex - the connector associated
with the encoder is always our own priv->connector.  Remove this
complexity, but ensure that there are no races when copying out the ELD.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 6a7095b66a69..547cf99ac32d 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -911,21 +911,13 @@ static int tda998x_audio_get_eld(struct device *dev, void *data,
 				 uint8_t *buf, size_t len)
 {
 	struct tda998x_priv *priv = dev_get_drvdata(dev);
-	struct drm_mode_config *config = &priv->encoder.dev->mode_config;
-	struct drm_connector *connector;
-	int ret = -ENODEV;
-
-	mutex_lock(&config->mutex);
-	list_for_each_entry(connector, &config->connector_list, head) {
-		if (&priv->encoder == connector->encoder) {
-			memcpy(buf, connector->eld,
-			       min(sizeof(connector->eld), len));
-			ret = 0;
-		}
-	}
-	mutex_unlock(&config->mutex);
 
-	return ret;
+	mutex_lock(&priv->audio_mutex);
+	memcpy(buf, priv->connector.eld,
+	       min(sizeof(priv->connector.eld), len));
+	mutex_unlock(&priv->audio_mutex);
+
+	return 0;
 }
 
 static const struct hdmi_codec_ops audio_codec_ops = {
@@ -1082,7 +1074,10 @@ static int tda998x_connector_get_modes(struct drm_connector *connector)
 	drm_mode_connector_update_edid_property(connector, edid);
 	n = drm_add_edid_modes(connector, edid);
 	priv->is_hdmi_sink = drm_detect_hdmi_monitor(edid);
+
+	mutex_lock(&priv->audio_mutex);
 	drm_edid_to_eld(connector, edid);
+	mutex_unlock(&priv->audio_mutex);
 
 	kfree(edid);
 
-- 
2.1.0
