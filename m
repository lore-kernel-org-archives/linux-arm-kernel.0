From: zyw@rock-chips.com (Chris Zhong)
Date: Sun,  5 Feb 2017 15:55:01 +0800
Subject: [PATCH v17 6/7] drm/rockchip: cdn-dp: retry to check sink count
In-Reply-To: <1486281302-28200-1-git-send-email-zyw@rock-chips.com>
References: <1486281302-28200-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1486281302-28200-7-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sometimes the Dock is disconnected, but cdn_dp_encoder_disable is not
triggered by DRM. For example, unplug the Dock in console mode, and
re-plug it again, the cdn_dp_event_work will try to get the sink count
of Dock, since the DP is still active. But the Dock has been powered
down, it need re-power on, and wait for a while until it is ready to
DPCD communication.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
---

Changes in v17: None

 drivers/gpu/drm/rockchip/cdn-dp-core.c | 91 +++++++++++++++++++---------------
 drivers/gpu/drm/rockchip/cdn-dp-core.h |  1 +
 2 files changed, 52 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index 799e826..a630b0d 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -197,6 +197,39 @@ static struct cdn_dp_port *cdn_dp_connected_port(struct cdn_dp_device *dp)
 	return NULL;
 }
 
+static bool cdn_dp_check_sink_connection(struct cdn_dp_device *dp)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(CDN_DPCD_TIMEOUT_MS);
+	struct cdn_dp_port *port;
+	u8 sink_count = 0;
+
+	if (dp->active_port < 0 || dp->active_port >= dp->ports) {
+		DRM_DEV_ERROR(dp->dev, "active_port is wrong!\n");
+		return false;
+	}
+
+	port = dp->port[dp->active_port];
+
+	/*
+	 * Attempt to read sink count, retry in case the sink may not be ready.
+	 *
+	 * Sinks are *supposed* to come up within 1ms from an off state, but
+	 * some docks need more time to power up.
+	 */
+	while (time_before(jiffies, timeout)) {
+		if (!extcon_get_state(port->extcon, EXTCON_DISP_DP))
+			return false;
+
+		if (!cdn_dp_get_sink_count(dp, &sink_count))
+			return sink_count ? true : false;
+
+		usleep_range(5000, 10000);
+	}
+
+	DRM_DEV_ERROR(dp->dev, "Get sink capability timed out\n");
+	return false;
+}
+
 static enum drm_connector_status
 cdn_dp_connector_detect(struct drm_connector *connector, bool force)
 {
@@ -345,47 +378,24 @@ static int cdn_dp_firmware_init(struct cdn_dp_device *dp)
 	return cdn_dp_event_config(dp);
 }
 
-static int cdn_dp_get_sink_capability(struct cdn_dp_device *dp,
-				      struct cdn_dp_port *port,
-				      u8 *sink_count)
+static int cdn_dp_get_sink_capability(struct cdn_dp_device *dp)
 {
 	int ret;
-	unsigned long timeout = jiffies + msecs_to_jiffies(CDN_DPCD_TIMEOUT_MS);
 
-	/*
-	 * Attempt to read sink count & sink capability, retry in case the sink
-	 * may not be ready.
-	 *
-	 * Sinks are *supposed* to come up within 1ms from an off state, but
-	 * some docks need more time to power up.
-	 */
-	while (time_before(jiffies, timeout)) {
-		if (!extcon_get_state(port->extcon, EXTCON_DISP_DP))
-			return -ENODEV;
-
-		if (cdn_dp_get_sink_count(dp, sink_count)) {
-			usleep_range(5000, 10000);
-			continue;
-		}
-
-		if (!*sink_count)
-			return -ENODEV;
-
-		ret = cdn_dp_dpcd_read(dp, DP_DPCD_REV, dp->dpcd,
-				       DP_RECEIVER_CAP_SIZE);
-		if (ret) {
-			DRM_DEV_ERROR(dp->dev, "Failed to get caps %d\n", ret);
-			return ret;
-		}
+	if (!cdn_dp_check_sink_connection(dp))
+		return -ENODEV;
 
-		kfree(dp->edid);
-		dp->edid = drm_do_get_edid(&dp->connector,
-					   cdn_dp_get_edid_block, dp);
-		return 0;
+	ret = cdn_dp_dpcd_read(dp, DP_DPCD_REV, dp->dpcd,
+			       DP_RECEIVER_CAP_SIZE);
+	if (ret) {
+		DRM_DEV_ERROR(dp->dev, "Failed to get caps %d\n", ret);
+		return ret;
 	}
 
-	DRM_DEV_ERROR(dp->dev, "Get sink capability timed out\n");
-	return -ETIMEDOUT;
+	kfree(dp->edid);
+	dp->edid = drm_do_get_edid(&dp->connector,
+				   cdn_dp_get_edid_block, dp);
+	return 0;
 }
 
 static int cdn_dp_enable_phy(struct cdn_dp_device *dp, struct cdn_dp_port *port)
@@ -437,6 +447,7 @@ static int cdn_dp_enable_phy(struct cdn_dp_device *dp, struct cdn_dp_port *port)
 		goto err_power_on;
 	}
 
+	dp->active_port = port->id;
 	return 0;
 
 err_power_on:
@@ -466,6 +477,7 @@ static int cdn_dp_disable_phy(struct cdn_dp_device *dp,
 
 	port->phy_enabled = false;
 	port->lanes = 0;
+	dp->active_port = -1;
 	return 0;
 }
 
@@ -504,7 +516,6 @@ static int cdn_dp_enable(struct cdn_dp_device *dp)
 {
 	int ret, i, lanes;
 	struct cdn_dp_port *port;
-	u8 sink_count;
 
 	port = cdn_dp_connected_port(dp);
 	if (!port) {
@@ -535,8 +546,8 @@ static int cdn_dp_enable(struct cdn_dp_device *dp)
 			if (ret)
 				continue;
 
-			ret = cdn_dp_get_sink_capability(dp, port, &sink_count);
-			if (ret || (!ret && !sink_count)) {
+			ret = cdn_dp_get_sink_capability(dp);
+			if (ret) {
 				cdn_dp_disable_phy(dp, port);
 			} else {
 				dp->active = true;
@@ -939,7 +950,6 @@ static void cdn_dp_pd_event_work(struct work_struct *work)
 	enum drm_connector_status old_status;
 
 	int ret;
-	u8 sink_count;
 
 	mutex_lock(&dp->lock);
 
@@ -967,7 +977,7 @@ static void cdn_dp_pd_event_work(struct work_struct *work)
 		}
 
 	/* Enabled and connected to a dongle without a sink, notify userspace */
-	} else if (cdn_dp_get_sink_count(dp, &sink_count) || !sink_count) {
+	} else if (!cdn_dp_check_sink_connection(dp)) {
 		DRM_DEV_INFO(dp->dev, "Connected without sink. Assert hpd\n");
 		dp->connected = false;
 
@@ -1040,6 +1050,7 @@ static int cdn_dp_bind(struct device *dev, struct device *master, void *data)
 	dp->drm_dev = drm_dev;
 	dp->connected = false;
 	dp->active = false;
+	dp->active_port = -1;
 
 	INIT_WORK(&dp->event_work, cdn_dp_pd_event_work);
 
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.h b/drivers/gpu/drm/rockchip/cdn-dp-core.h
index 7d48661..f57e296 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.h
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.h
@@ -104,6 +104,7 @@ struct cdn_dp_device {
 	struct cdn_dp_port *port[MAX_PHY];
 	u8 ports;
 	u8 lanes;
+	int active_port;
 
 	u8 dpcd[DP_RECEIVER_CAP_SIZE];
 	bool sink_has_audio;
-- 
2.6.3
