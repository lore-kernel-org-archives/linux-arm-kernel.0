From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sat, 08 Aug 2015 17:04:16 +0100
Subject: [PATCH 11/12] drm: bridge/dw_hdmi: add connector mode forcing
In-Reply-To: <20150808160251.GM7557@n2100.arm.linux.org.uk>
References: <20150808160251.GM7557@n2100.arm.linux.org.uk>
Message-ID: <E1ZO6bY-0002vr-9R@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When connected to HDMI sources, some DVI monitors de-assert their HPD
signal and TDMS loads for one seconds every four seconds when there is
no signal present on the connection.

Unfortunately, this behaviour is indistinguishable from a proper HDMI
setup with an AV receiver in the path to the display: the HDMI spec
requires us to detect HPD deassertions as short as 100ms, which indicate
that the EDID has changed.

Since it is possible to connect a DVI monitor to an AV receiver and then
to a HDMI source, merely working around this by detecting the lack of
HDMI vendor block in the EDID is insufficient - the AV receiver is at
liberty to modify the EDID as it sees fit, and it will place its own
parameters into the EDID including the HDMI vendor block.

DRM has support for forcing the state of a connector, which we should
implement to allow us to work around these broken DVI monitors - we can
tell DRM to force the connection state to indicate that there is always
a device connected to work around this problem.  Although this requires
manual configuration, it is better than nothing at all.

When a forced connection state has been set, there is no point handling
our RXSENSE interrupts, so disable them in this circumstance.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpu/drm/bridge/dw_hdmi.c | 51 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 47 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
index 0ee188930d26..2d1c7e4ec086 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi.c
+++ b/drivers/gpu/drm/bridge/dw_hdmi.c
@@ -126,7 +126,9 @@ struct dw_hdmi {
 	bool sink_has_audio;
 
 	struct mutex mutex;		/* for state below and previous_mode */
+	enum drm_connector_force force;	/* mutex-protected force state */
 	bool disabled;			/* DRM has disabled our bridge */
+	bool bridge_is_on;		/* indicates the bridge is on */
 
 	spinlock_t audio_lock;
 	struct mutex audio_mutex;
@@ -1378,12 +1380,36 @@ static void initialize_hdmi_ih_mutes(struct dw_hdmi *hdmi)
 
 static void dw_hdmi_poweron(struct dw_hdmi *hdmi)
 {
+	hdmi->bridge_is_on = true;
 	dw_hdmi_setup(hdmi, &hdmi->previous_mode);
 }
 
 static void dw_hdmi_poweroff(struct dw_hdmi *hdmi)
 {
 	dw_hdmi_phy_disable(hdmi);
+	hdmi->bridge_is_on = false;
+}
+
+static void dw_hdmi_update_power(struct dw_hdmi *hdmi)
+{
+	int force = hdmi->force;
+
+	if (hdmi->disabled) {
+		force = DRM_FORCE_OFF;
+	} else if (force == DRM_FORCE_UNSPECIFIED) {
+		if (hdmi_readb(hdmi, HDMI_PHY_STAT0) & HDMI_PHY_HPD)
+			force = DRM_FORCE_ON;
+		else
+			force = DRM_FORCE_OFF;
+	}
+
+	if (force == DRM_FORCE_OFF) {
+		if (hdmi->bridge_is_on)
+			dw_hdmi_poweroff(hdmi);
+	} else {
+		if (!hdmi->bridge_is_on)
+			dw_hdmi_poweron(hdmi);
+	}
 }
 
 static void dw_hdmi_bridge_mode_set(struct drm_bridge *bridge,
@@ -1413,7 +1439,7 @@ static void dw_hdmi_bridge_disable(struct drm_bridge *bridge)
 
 	mutex_lock(&hdmi->mutex);
 	hdmi->disabled = true;
-	dw_hdmi_poweroff(hdmi);
+	dw_hdmi_update_power(hdmi);
 	mutex_unlock(&hdmi->mutex);
 }
 
@@ -1422,8 +1448,8 @@ static void dw_hdmi_bridge_enable(struct drm_bridge *bridge)
 	struct dw_hdmi *hdmi = bridge->driver_private;
 
 	mutex_lock(&hdmi->mutex);
-	dw_hdmi_poweron(hdmi);
 	hdmi->disabled = false;
+	dw_hdmi_update_power(hdmi);
 	mutex_unlock(&hdmi->mutex);
 }
 
@@ -1438,6 +1464,11 @@ dw_hdmi_connector_detect(struct drm_connector *connector, bool force)
 	struct dw_hdmi *hdmi = container_of(connector, struct dw_hdmi,
 					     connector);
 
+	mutex_lock(&hdmi->mutex);
+	hdmi->force = DRM_FORCE_UNSPECIFIED;
+	dw_hdmi_update_power(hdmi);
+	mutex_unlock(&hdmi->mutex);
+
 	return hdmi_readb(hdmi, HDMI_PHY_STAT0) & HDMI_PHY_HPD ?
 		connector_status_connected : connector_status_disconnected;
 }
@@ -1502,11 +1533,23 @@ static void dw_hdmi_connector_destroy(struct drm_connector *connector)
 	drm_connector_cleanup(connector);
 }
 
+static void dw_hdmi_connector_force(struct drm_connector *connector)
+{
+	struct dw_hdmi *hdmi = container_of(connector, struct dw_hdmi,
+					     connector);
+
+	mutex_lock(&hdmi->mutex);
+	hdmi->force = connector->force;
+	dw_hdmi_update_power(hdmi);
+	mutex_unlock(&hdmi->mutex);
+}
+
 static struct drm_connector_funcs dw_hdmi_connector_funcs = {
 	.dpms = drm_helper_connector_dpms,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.detect = dw_hdmi_connector_detect,
 	.destroy = dw_hdmi_connector_destroy,
+	.force = dw_hdmi_connector_force,
 };
 
 static struct drm_connector_helper_funcs dw_hdmi_connector_helper_funcs = {
@@ -1552,12 +1595,12 @@ static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
 		if (phy_int_pol & HDMI_PHY_HPD) {
 			dev_dbg(hdmi->dev, "EVENT=plugin\n");
 
-			if (!hdmi->disabled)
+			if (!hdmi->disabled && !hdmi->force)
 				dw_hdmi_poweron(hdmi);
 		} else {
 			dev_dbg(hdmi->dev, "EVENT=plugout\n");
 
-			if (!hdmi->disabled)
+			if (!hdmi->disabled && !hdmi->force)
 				dw_hdmi_poweroff(hdmi);
 		}
 		mutex_unlock(&hdmi->mutex);
-- 
2.1.0
