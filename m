From: plaes@plaes.org (Priit Laes)
Date: Fri, 16 Nov 2018 19:18:29 +0200
Subject: [PATCH] drm/sun4i: hdmi: Improve compatibility with non-hotplug
 capable connectors
Message-ID: <20181116171830.23465-1-plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Priit Laes <priit.laes@paf.com>

Even though HDMI connector features hotplug detect pin (HPD), there are
devices that which do not support it. For these devices fall back to
additional check on I2C bus. Of course, there might be also devices
that do not wire DDC pins too, so we don't really know whether cable
has been connected.

Signed-off-by: Priit Laes <plaes@plaes.org>
Signed-off-by: Priit Laes <priit.laes@paf.com>
---
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
index 061d2e0d9011..bded09af1340 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
@@ -238,14 +238,18 @@ sun4i_hdmi_connector_detect(struct drm_connector *connector, bool force)
 	struct sun4i_hdmi *hdmi = drm_connector_to_sun4i_hdmi(connector);
 	unsigned long reg;
 
-	if (readl_poll_timeout(hdmi->base + SUN4I_HDMI_HPD_REG, reg,
+	if (!readl_poll_timeout(hdmi->base + SUN4I_HDMI_HPD_REG, reg,
 			       reg & SUN4I_HDMI_HPD_HIGH,
 			       0, 500000)) {
-		cec_phys_addr_invalidate(hdmi->cec_adap);
-		return connector_status_disconnected;
+		return connector_status_connected;
 	}
 
-	return connector_status_connected;
+	if (!IS_ERR(hdmi->i2c) && drm_probe_ddc(hdmi->i2c))
+		return connector_status_connected;
+
+	cec_phys_addr_invalidate(hdmi->cec_adap);
+
+	return connector_status_unknown;
 }
 
 static const struct drm_connector_funcs sun4i_hdmi_connector_funcs = {
-- 
2.19.1
