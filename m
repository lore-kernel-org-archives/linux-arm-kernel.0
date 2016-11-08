From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 08 Nov 2016 12:25:52 +0000
Subject: [PATCH RFC 11/12] drm/i2c: tda998x: remove complexity from
 tda998x_audio_get_eld()
In-Reply-To: <20161108122420.GP1041@n2100.armlinux.org.uk>
References: <20161108122420.GP1041@n2100.armlinux.org.uk>
Message-ID: <E1c45TM-0005kN-UB@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tda998x_audio_get_eld() is needlessly complex - the connector associated
with the encoder is always our own priv->connector.  Remove this
complexity, but ensure that there are no races when copying out the ELD.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index b1ad5ed5d645..226871e34442 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -910,21 +910,13 @@ static int tda998x_audio_get_eld(struct device *dev, void *data,
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
@@ -975,6 +967,7 @@ static int tda998x_connector_fill_modes(struct drm_connector *connector,
 	struct tda998x_priv *priv = conn_to_tda998x_priv(connector);
 	int ret;
 
+	mutex_lock(&priv->audio_mutex);
 	ret = drm_helper_probe_single_connector_modes(connector, maxX, maxY);
 
 	if (connector->edid_blob_ptr) {
@@ -984,6 +977,7 @@ static int tda998x_connector_fill_modes(struct drm_connector *connector,
 	} else {
 		priv->sink_has_audio = false;
 	}
+	mutex_unlock(&priv->audio_mutex);
 
 	return ret;
 }
-- 
2.7.4
