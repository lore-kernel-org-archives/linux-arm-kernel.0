From: ykk@rock-chips.com (Yakir Yang)
Date: Mon, 15 Feb 2016 19:11:29 +0800
Subject: [PATCH v14 15/17] drm: bridge: analogix/dp: add edid modes parse in
 get_modes method
In-Reply-To: <1455534485-1154-1-git-send-email-ykk@rock-chips.com>
References: <1455534485-1154-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1455534689-2165-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Display Port monitor could support kinds of mode which indicate
in monitor edid, not just one single display resolution which
defined in panel or devivetree property display timing.

Note: Gustavo Padovan try to remove the controller and phy
power on function in bind time at bellow commit:
	drm/exynos: do not start enabling DP at bind() phase

But for now driver need to read edid message in .get_modes()
function, so controller must be inited in bind time, so we
need to add controller init back.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>
---
Changes in v14: None
Changes in v13: None
Changes in v12: None
Changes in v11: None
Changes in v10: None
Changes in v9: None
Changes in v8: None
Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4:
- Call drm_panel_prepare() in .get_modes function, ensure panel should
  power on before driver try to read edid message.

Changes in v3:
- Add edid modes parse support

Changes in v2: None

 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 17 ++++----
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.h | 46 +++++++++++-----------
 2 files changed, 33 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index cfdf695..bc59e8d 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -110,7 +110,7 @@ static unsigned char analogix_dp_calc_edid_check_sum(unsigned char *edid_data)
 
 static int analogix_dp_read_edid(struct analogix_dp_device *dp)
 {
-	unsigned char edid[EDID_BLOCK_LENGTH * 2];
+	unsigned char *edid = dp->edid;
 	unsigned int extend_block = 0;
 	unsigned char sum;
 	unsigned char test_vector;
@@ -904,12 +904,6 @@ static void analogix_dp_commit(struct analogix_dp_device *dp)
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
@@ -939,8 +933,14 @@ static void analogix_dp_commit(struct analogix_dp_device *dp)
 int analogix_dp_get_modes(struct drm_connector *connector)
 {
 	struct analogix_dp_device *dp = to_dp(connector);
+	struct edid *edid = (struct edid *)dp->edid;
 	int num_modes = 0;
 
+	if (analogix_dp_handle_edid(dp) == 0) {
+		drm_mode_connector_update_edid_property(&dp->connector, edid);
+		num_modes += drm_add_edid_modes(&dp->connector, edid);
+	}
+
 	if (dp->plat_data->panel)
 		num_modes += drm_panel_get_modes(dp->plat_data->panel);
 
@@ -978,6 +978,7 @@ static void analogix_dp_connector_destroy(struct drm_connector *connector)
 {
 	drm_connector_unregister(connector);
 	drm_connector_cleanup(connector);
+
 }
 
 static const struct drm_connector_funcs analogix_dp_connector_funcs = {
@@ -1348,6 +1349,8 @@ int analogix_dp_bind(struct device *dev, struct drm_device *drm_dev,
 		}
 	}
 
+	analogix_dp_init_dp(dp);
+
 	ret = devm_request_irq(&pdev->dev, dp->irq, analogix_dp_irq_handler,
 			       irq_flags, "analogix-dp", dp);
 	if (ret) {
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
index 22aff07..48b4a87 100644
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
 enum link_lane_count_type {
 	LANE_COUNT1 = 1,
 	LANE_COUNT2 = 2,
@@ -155,6 +177,7 @@ struct analogix_dp_device {
 	int			dpms_mode;
 	int			hpd_gpio;
 	bool                    force_hpd;
+	unsigned char           edid[EDID_BLOCK_LENGTH * 2];
 
 	struct analogix_dp_plat_data *plat_data;
 };
@@ -254,27 +277,4 @@ int analogix_dp_is_video_stream_on(struct analogix_dp_device *dp);
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
