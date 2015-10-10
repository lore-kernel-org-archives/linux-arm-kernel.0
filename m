From: ykk@rock-chips.com (Yakir Yang)
Date: Sun, 11 Oct 2015 00:06:01 +0800
Subject: [PATCH v6 17/17] drm: bridge: analogix/dp: add edid modes parse in
 get_modes method
In-Reply-To: <1444491357-26095-1-git-send-email-ykk@rock-chips.com>
References: <1444491357-26095-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1444493161-28226-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Display Port monitor could support kinds of mode which indicate
in monitor edid, not just one single display resolution which
defined in panel or devivetree property display timing.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
Changes in v6: None
Changes in v5: None
Changes in v4:
- Call drm_panel_prepare() in .get_modes function, ensure panel should
  power on before driver try to read edid message.

Changes in v3:
- Add edid modes parse support

Changes in v2: None

 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 24 +++++++----
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.h | 46 +++++++++++-----------
 2 files changed, 40 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index a83b159..bcbc009 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -107,7 +107,7 @@ static unsigned char analogix_dp_calc_edid_check_sum(unsigned char *edid_data)
 
 static int analogix_dp_read_edid(struct analogix_dp_device *dp)
 {
-	unsigned char edid[EDID_BLOCK_LENGTH * 2];
+	unsigned char *edid = dp->edid;
 	unsigned int extend_block = 0;
 	unsigned char sum;
 	unsigned char test_vector;
@@ -901,12 +901,6 @@ static void analogix_dp_commit(struct analogix_dp_device *dp)
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
@@ -947,8 +941,24 @@ EXPORT_SYMBOL_GPL(analogix_dp_detect);
 int analogix_dp_get_modes(struct device *dev)
 {
 	struct analogix_dp_device *dp = dev_get_drvdata(dev);
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
+	drm_mode_connector_update_edid_property(dp->connector, edid);
+	num_modes += drm_add_edid_modes(dp->connector, edid);
+
 	if (dp->plat_data->panel)
 		num_modes += drm_panel_get_modes(dp->plat_data->panel);
 
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
index 3a136b8..089489d 100644
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
1.9.1
