From: ykk@rock-chips.com (Yakir Yang)
Date: Tue,  1 Sep 2015 14:20:18 +0800
Subject: [PATCH v4 16/16] drm: bridge: analogix/dp: add edid modes parse in
 get_modes method
In-Reply-To: <1441086371-24838-1-git-send-email-ykk@rock-chips.com>
References: <1441086371-24838-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1441088418-25922-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Display Port monitor could support kinds of mode which indicate
in monitor edid, not just one single display resolution which
defined in panel or devivetree property display timing.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
Changes in v4:
- Call drm_panel_prepare() in .get_modes function, ensure panel should
  power on before driver try to read edid message.

Changes in v3:
- Add edid modes parse support

Changes in v2: None

 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 31 ++++++++-------
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.h | 46 +++++++++++-----------
 2 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 499ec57..c71e5f6 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -111,7 +111,7 @@ static unsigned char analogix_dp_calc_edid_check_sum(unsigned char *edid_data)
 
 static int analogix_dp_read_edid(struct analogix_dp_device *dp)
 {
-	unsigned char edid[EDID_BLOCK_LENGTH * 2];
+	unsigned char *edid = dp->edid;
 	unsigned int extend_block = 0;
 	unsigned char sum;
 	unsigned char test_vector;
@@ -908,12 +908,6 @@ static void analogix_dp_commit(struct analogix_dp_device *dp)
 			DRM_ERROR("failed to disable the panel\n");
 	}
 
-	ret = analogix_dp_handle_edid(dp);
-	if (ret) {
-		dev_err(dp->dev, "unable to handle edid\n");
-		return;
-	}
-
 	ret = analogix_dp_set_link_train(dp, dp->video_info.max_lane_count,
 					 dp->video_info.max_link_rate);
 	if (ret) {
@@ -972,8 +966,24 @@ static int analogix_dp_get_modes(struct drm_connector *connector)
 {
 	struct analogix_dp_device *dp = connector_to_dp(connector);
 	struct analogix_dp_plat_data *plat_data = dp->plat_data;
+	struct edid *edid = (struct edid *)dp->edid;
 	int num_modes = 0;
 
+	if (dp->plat_data && dp->plat_data->panel) {
+		if (drm_panel_prepare(dp->plat_data->panel)) {
+			DRM_ERROR("failed to setup the panel\n");
+			return -EINVAL;
+		}
+	}
+
+	if (analogix_dp_handle_edid(dp)) {
+		dev_err(dp->dev, "unable to handle edid\n");
+		return -EINVAL;
+	}
+
+	drm_mode_connector_update_edid_property(connector, edid);
+	num_modes += drm_add_edid_modes(connector, edid);
+
 	if (plat_data && plat_data->panel)
 		num_modes += drm_panel_get_modes(plat_data->panel);
 
@@ -1055,13 +1065,6 @@ static void analogix_dp_bridge_enable(struct drm_bridge *bridge)
 	if (dp->dpms_mode == DRM_MODE_DPMS_ON)
 		return;
 
-	if (dp->plat_data && dp->plat_data->panel) {
-		if (drm_panel_prepare(dp->plat_data->panel)) {
-			DRM_ERROR("failed to setup the panel\n");
-			return;
-		}
-	}
-
 	if (dp->plat_data && dp->plat_data->power_on)
 		dp->plat_data->power_on(dp->plat_data);
 
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
index 6960ab3..5348b1b 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
@@ -20,6 +20,28 @@
 #define MAX_CR_LOOP 5
 #define MAX_EQ_LOOP 5
 
+/* I2C EDID Chip ID, Slave Address */
+#define I2C_EDID_DEVICE_ADDR			0x50
+#define I2C_E_EDID_DEVICE_ADDR			0x30
+
+#define EDID_BLOCK_LENGTH			0x80
+#define EDID_HEADER_PATTERN			0x00
+#define EDID_EXTENSION_FLAG			0x7e
+#define EDID_CHECKSUM				0x7f
+
+/* DP_MAX_LANE_COUNT */
+#define DPCD_ENHANCED_FRAME_CAP(x)		(((x) >> 7) & 0x1)
+#define DPCD_MAX_LANE_COUNT(x)			((x) & 0x1f)
+
+/* DP_LANE_COUNT_SET */
+#define DPCD_LANE_COUNT_SET(x)			((x) & 0x1f)
+
+/* DP_TRAINING_LANE0_SET */
+#define DPCD_PRE_EMPHASIS_SET(x)		(((x) & 0x3) << 3)
+#define DPCD_PRE_EMPHASIS_GET(x)		(((x) >> 3) & 0x3)
+#define DPCD_VOLTAGE_SWING_SET(x)		(((x) & 0x3) << 0)
+#define DPCD_VOLTAGE_SWING_GET(x)		(((x) >> 0) & 0x3)
+
 enum link_rate_type {
 	LINK_RATE_1_62GBPS = DP_LINK_BW_1_62,
 	LINK_RATE_2_70GBPS = DP_LINK_BW_2_7,
@@ -161,6 +183,7 @@ struct analogix_dp_device {
 	int			dpms_mode;
 	int			hpd_gpio;
 	bool                    need_force_hpd;
+	unsigned char           edid[EDID_BLOCK_LENGTH * 2];
 
 	struct analogix_dp_plat_data *plat_data;
 };
@@ -260,27 +283,4 @@ int analogix_dp_is_video_stream_on(struct analogix_dp_device *dp);
 void analogix_dp_config_video_slave_mode(struct analogix_dp_device *dp);
 void analogix_dp_enable_scrambling(struct analogix_dp_device *dp);
 void analogix_dp_disable_scrambling(struct analogix_dp_device *dp);
-
-/* I2C EDID Chip ID, Slave Address */
-#define I2C_EDID_DEVICE_ADDR			0x50
-#define I2C_E_EDID_DEVICE_ADDR			0x30
-
-#define EDID_BLOCK_LENGTH			0x80
-#define EDID_HEADER_PATTERN			0x00
-#define EDID_EXTENSION_FLAG			0x7e
-#define EDID_CHECKSUM				0x7f
-
-/* DP_MAX_LANE_COUNT */
-#define DPCD_ENHANCED_FRAME_CAP(x)		(((x) >> 7) & 0x1)
-#define DPCD_MAX_LANE_COUNT(x)			((x) & 0x1f)
-
-/* DP_LANE_COUNT_SET */
-#define DPCD_LANE_COUNT_SET(x)			((x) & 0x1f)
-
-/* DP_TRAINING_LANE0_SET */
-#define DPCD_PRE_EMPHASIS_SET(x)		(((x) & 0x3) << 3)
-#define DPCD_PRE_EMPHASIS_GET(x)		(((x) >> 3) & 0x3)
-#define DPCD_VOLTAGE_SWING_SET(x)		(((x) & 0x3) << 0)
-#define DPCD_VOLTAGE_SWING_GET(x)		(((x) >> 0) & 0x3)
-
 #endif /* _ANALOGIX_DP_CORE_H */
-- 
2.1.2
