From: dkos@cadence.com (Damian Kos)
Date: Tue, 3 Jul 2018 11:02:23 +0100
Subject: [PATCH 12/12] drm/rockchip: add support for CDNS MHDP IP controller.
In-Reply-To: <1530612152-27555-1-git-send-email-dkos@cadence.com>
References: <1530612152-27555-1-git-send-email-dkos@cadence.com>
Message-ID: <1530612152-27555-13-git-send-email-dkos@cadence.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Damian Kos <dkos@cadence.com>
---
 drivers/gpu/drm/rockchip/cdn-dp-core.c |  953 +++++++++++++++++++++++++++++++-
 drivers/gpu/drm/rockchip/cdn-dp-core.h |   25 +
 drivers/gpu/drm/rockchip/cdn-dp-reg.c  |    2 +-
 drivers/gpu/drm/rockchip/cdn-dp-reg.h  |    4 +
 4 files changed, 960 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index c6fbdcd..64e3ab0 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -18,6 +18,7 @@
 #include <drm/drm_dp_helper.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_of.h>
+#include <drm/drm_bridge.h>
 
 #include <linux/clk.h>
 #include <linux/component.h>
@@ -27,6 +28,7 @@
 #include <linux/reset.h>
 #include <linux/mfd/syscon.h>
 #include <linux/phy/phy.h>
+#include <linux/iopoll.h>
 
 #include <sound/hdmi-codec.h>
 
@@ -49,7 +51,11 @@
 
 #define CDN_FW_TIMEOUT_MS	(64 * 1000)
 #define CDN_DPCD_TIMEOUT_MS	5000
-#define CDN_DP_FIRMWARE		"rockchip/dptx.bin"
+#define RK_DP_FIRMWARE		"rockchip/dptx.bin"
+#define CDN_DP_FIRMWARE		"cadence/dptx.bin"
+
+#define FW_ALIVE_TIMEOUT_US		1000000
+#define HPD_EVENT_TIMEOUT		40000
 
 struct cdn_dp_data {
 	u8 max_phy;
@@ -62,7 +68,8 @@ struct cdn_dp_data rk3399_cdn_dp = {
 static const struct of_device_id cdn_dp_dt_ids[] = {
 	{ .compatible = "rockchip,rk3399-cdn-dp",
 		.data = (void *)&rk3399_cdn_dp },
-	{}
+	{ .compatible = "cdns,mhdp", .data = NULL },
+	{ /* sentinel */ }
 };
 
 MODULE_DEVICE_TABLE(of, cdn_dp_dt_ids);
@@ -237,17 +244,27 @@ static bool cdn_dp_check_sink_connection(struct cdn_dp_device *dp)
 	struct cdn_dp_device *dp = connector_to_dp(connector);
 	enum drm_connector_status status = connector_status_disconnected;
 
-	mutex_lock(&dp->lock);
-	if (dp->connected)
-		status = connector_status_connected;
-	mutex_unlock(&dp->lock);
+	if (dp->mhdp_ip) {
+		int ret = cdn_dp_get_hpd_status(dp);
+
+		if (ret > 0)
+			status = connector_status_connected;
+	} else {
+		mutex_lock(&dp->lock);
+		if (dp->connected)
+			status = connector_status_connected;
+		mutex_unlock(&dp->lock);
+	}
 
 	return status;
 }
 
 static void cdn_dp_connector_destroy(struct drm_connector *connector)
 {
-	drm_connector_unregister(connector);
+	struct cdn_dp_device *dp = connector_to_dp(connector);
+
+	if (!dp->mhdp_ip)
+		drm_connector_unregister(connector);
 	drm_connector_cleanup(connector);
 }
 
@@ -258,6 +275,7 @@ static void cdn_dp_connector_destroy(struct drm_connector *connector)
 	.reset = drm_atomic_helper_connector_reset,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+	.dpms = drm_helper_connector_dpms,
 };
 
 static int cdn_dp_connector_get_modes(struct drm_connector *connector)
@@ -267,7 +285,12 @@ static int cdn_dp_connector_get_modes(struct drm_connector *connector)
 	int ret = 0;
 
 	mutex_lock(&dp->lock);
-	edid = dp->edid;
+
+	if (dp->mhdp_ip)
+		edid = drm_do_get_edid(connector, cdn_dp_get_edid_block, dp);
+	else
+		edid = dp->edid;
+
 	if (edid) {
 		DRM_DEV_DEBUG_KMS(dp->dev, "got edid: width[%d] x height[%d]\n",
 				  edid->width_cm, edid->height_cm);
@@ -278,6 +301,7 @@ static int cdn_dp_connector_get_modes(struct drm_connector *connector)
 			drm_mode_connector_update_edid_property(connector,
 								edid);
 	}
+
 	mutex_unlock(&dp->lock);
 
 	return ret;
@@ -360,7 +384,7 @@ static int cdn_dp_firmware_init(struct cdn_dp_device *dp)
 
 	ret = cdn_dp_set_firmware_active(dp, true);
 	if (ret) {
-		DRM_DEV_ERROR(dp->dev, "active ucpu failed: %d\n", ret);
+		DRM_DEV_ERROR(dp->dev, "active fw failed: %d\n", ret);
 		return ret;
 	}
 
@@ -706,8 +730,6 @@ static int cdn_dp_parse_dt(struct cdn_dp_device *dp)
 {
 	struct device *dev = dp->dev;
 	struct device_node *np = dev->of_node;
-	struct platform_device *pdev = to_platform_device(dev);
-	struct resource *res;
 
 	dp->grf = syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
 	if (IS_ERR(dp->grf)) {
@@ -715,13 +737,6 @@ static int cdn_dp_parse_dt(struct cdn_dp_device *dp)
 		return PTR_ERR(dp->grf);
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	dp->regs = devm_ioremap_resource(dev, res);
-	if (IS_ERR(dp->regs)) {
-		DRM_DEV_ERROR(dev, "ioremap reg failed\n");
-		return PTR_ERR(dp->regs);
-	}
-
 	dp->core_clk = devm_clk_get(dev, "core-clk");
 	if (IS_ERR(dp->core_clk)) {
 		DRM_DEV_ERROR(dev, "cannot get core_clk_dp\n");
@@ -897,7 +912,7 @@ static int cdn_dp_request_firmware(struct cdn_dp_device *dp)
 	mutex_unlock(&dp->lock);
 
 	while (time_before(jiffies, timeout)) {
-		ret = request_firmware(&dp->fw, CDN_DP_FIRMWARE, dp->dev);
+		ret = request_firmware(&dp->fw, RK_DP_FIRMWARE, dp->dev);
 		if (ret == -ENOENT) {
 			msleep(sleep);
 			sleep *= 2;
@@ -974,8 +989,8 @@ static void cdn_dp_pd_event_work(struct work_struct *work)
 		}
 
 		/* If training result is changed, update the video config */
-		if (mode->clock &&
-		    (rate != dp->link.rate || lanes != dp->link.num_lanes)) {
+		if ((rate != dp->link.rate || lanes != dp->link.num_lanes) &&
+				mode->clock) {
 			ret = cdn_dp_config_video(dp);
 			if (ret) {
 				dp->connected = false;
@@ -1145,10 +1160,870 @@ int cdn_dp_resume(struct device *dev)
 	return 0;
 }
 
+static inline struct cdn_dp_device *bridge_to_dp(struct drm_bridge *bridge)
+{
+	return container_of(bridge, struct cdn_dp_device, bridge);
+}
+
+static unsigned int max_link_rate(struct cdn_mhdp_host host,
+				  struct cdn_mhdp_sink sink)
+{
+	return min(host.link_rate, sink.link_rate);
+}
+
+static void cdn_mhdp_link_training_init(struct cdn_dp_device *dp)
+{
+	u32 reg32;
+
+	drm_dp_dpcd_writeb(&dp->aux, DP_TRAINING_PATTERN_SET,
+			   DP_TRAINING_PATTERN_DISABLE);
+
+	/* Reset PHY configuration */
+	reg32 = CDN_PHY_COMMON_CONFIG | CDN_PHY_TRAINING_TYPE(1);
+	if (!(dp->host.lanes_cnt & SCRAMBLER_EN))
+		reg32 |= CDN_PHY_SCRAMBLER_BYPASS;
+
+	cdn_dp_register_write(dp, CDN_DPTX_PHY_CONFIG, reg32);
+
+	cdn_dp_register_write(dp, CDN_DP_ENHNCD,
+			      dp->sink.enhanced & dp->host.enhanced);
+
+	cdn_dp_register_write(dp, CDN_DP_LANE_EN,
+			      CDN_DP_LANE_EN_LANES(dp->link.num_lanes));
+
+	drm_dp_link_configure(&dp->aux, &dp->link);
+
+	cdn_dp_register_write(dp, CDN_DPTX_PHY_CONFIG, CDN_PHY_COMMON_CONFIG |
+			      CDN_PHY_TRAINING_EN | CDN_PHY_TRAINING_TYPE(1) |
+			      CDN_PHY_SCRAMBLER_BYPASS);
+
+	drm_dp_dpcd_writeb(&dp->aux, DP_TRAINING_PATTERN_SET,
+			   DP_TRAINING_PATTERN_1 | DP_LINK_SCRAMBLING_DISABLE);
+}
+
+static void cdn_mhdp_get_adjust_train(struct cdn_dp_device *dp,
+				      u8 link_status[DP_LINK_STATUS_SIZE],
+				      u8 lanes_data[DP_MAX_NUM_LANES])
+{
+	unsigned int i;
+	u8 adjust, max_pre_emphasis, max_volt_swing;
+
+	max_pre_emphasis = CDN_PRE_EMPHASIS(dp->host.pre_emphasis)
+		<< DP_TRAIN_PRE_EMPHASIS_SHIFT;
+	max_volt_swing = CDN_VOLT_SWING(dp->host.volt_swing);
+
+	for (i = 0; i < dp->link.num_lanes; i++) {
+		adjust = drm_dp_get_adjust_request_voltage(link_status, i);
+		lanes_data[i] = min_t(u8, adjust, max_volt_swing);
+		if (lanes_data[i] != adjust)
+			lanes_data[i] |= DP_TRAIN_MAX_SWING_REACHED;
+
+		adjust = drm_dp_get_adjust_request_pre_emphasis(link_status, i);
+		lanes_data[i] |= min_t(u8, adjust, max_pre_emphasis);
+		if ((lanes_data[i] >> DP_TRAIN_PRE_EMPHASIS_SHIFT) != adjust)
+			lanes_data[i] |= DP_TRAIN_MAX_PRE_EMPHASIS_REACHED;
+	}
+}
+
+static void cdn_mhdp_adjust_requested_eq(struct cdn_dp_device *dp,
+					 u8 link_status[DP_LINK_STATUS_SIZE])
+{
+	unsigned int i;
+	u8 pre, volt, max_pre = CDN_VOLT_SWING(dp->host.volt_swing),
+	   max_volt = CDN_PRE_EMPHASIS(dp->host.pre_emphasis);
+
+	for (i = 0; i < dp->link.num_lanes; i++) {
+		volt = drm_dp_get_adjust_request_voltage(link_status, i);
+		pre = drm_dp_get_adjust_request_pre_emphasis(link_status, i);
+		if (volt + pre > 3)
+			drm_dp_set_adjust_request_voltage(link_status, i,
+							  3 - pre);
+		if (dp->host.volt_swing & CDN_FORCE_VOLT_SWING)
+			drm_dp_set_adjust_request_voltage(link_status, i,
+							  max_volt);
+		if (dp->host.pre_emphasis & CDN_FORCE_PRE_EMPHASIS)
+			drm_dp_set_adjust_request_pre_emphasis(link_status, i,
+							       max_pre);
+	}
+}
+
+static bool cdn_mhdp_link_training_channel_eq(struct cdn_dp_device *dp,
+					      u8 eq_tps,
+					      unsigned int training_interval)
+{
+	u8 lanes_data[DP_MAX_NUM_LANES], fail_counter_short = 0;
+	u8 *dpcd;
+	u32 reg32;
+
+	dpcd = kzalloc(sizeof(u8) * DP_LINK_STATUS_SIZE, GFP_KERNEL);
+
+	dev_dbg(dp->dev, "Link training - Starting EQ phase\n");
+
+	/* Enable link training TPS[eq_tps] in PHY */
+	reg32 = CDN_PHY_COMMON_CONFIG | CDN_PHY_TRAINING_EN |
+		CDN_PHY_TRAINING_TYPE(eq_tps);
+	if (eq_tps != 4)
+		reg32 |= CDN_PHY_SCRAMBLER_BYPASS;
+	cdn_dp_register_write(dp, CDN_DPTX_PHY_CONFIG, reg32);
+
+	drm_dp_dpcd_writeb(&dp->aux, DP_TRAINING_PATTERN_SET,
+			   (eq_tps != 4) ? eq_tps | DP_LINK_SCRAMBLING_DISABLE :
+			   CDN_DP_TRAINING_PATTERN_4);
+
+	drm_dp_dpcd_read_link_status(&dp->aux, dpcd);
+
+	do {
+		cdn_mhdp_get_adjust_train(dp, dpcd, lanes_data);
+
+		cdn_dp_adjust_lt(dp, dp->link.num_lanes,
+				 training_interval, lanes_data, dpcd);
+
+		if (!drm_dp_clock_recovery_ok(dpcd, dp->link.num_lanes))
+			goto err;
+
+		if (drm_dp_channel_eq_ok(dpcd, dp->link.num_lanes)) {
+			dev_dbg(dp->dev,
+				"Link training: EQ phase succeeded\n");
+			kfree(dpcd);
+			return true;
+		}
+
+		fail_counter_short++;
+
+		cdn_mhdp_adjust_requested_eq(dp, dpcd);
+	} while (fail_counter_short < 5);
+
+err:
+	dev_dbg(dp->dev,
+		"Link training - EQ phase failed for %d lanes and %d rate\n",
+		dp->link.num_lanes, dp->link.rate);
+
+	kfree(dpcd);
+	return false;
+}
+
+static void cdn_mhdp_adjust_requested_cr(struct cdn_dp_device *dp,
+					 u8 link_status[DP_LINK_STATUS_SIZE],
+					 u8 *req_volt, u8 *req_pre)
+{
+	unsigned int i, max_volt = CDN_VOLT_SWING(dp->host.volt_swing),
+		     max_pre = CDN_PRE_EMPHASIS(dp->host.pre_emphasis);
+
+	for (i = 0; i < dp->link.num_lanes; i++) {
+		if (dp->host.volt_swing & CDN_FORCE_VOLT_SWING)
+			drm_dp_set_adjust_request_voltage(link_status, i,
+							  max_volt);
+		else
+			drm_dp_set_adjust_request_voltage(link_status, i,
+							  req_volt[i]);
+
+		if (dp->host.pre_emphasis & CDN_FORCE_PRE_EMPHASIS)
+			drm_dp_set_adjust_request_pre_emphasis(link_status, i,
+							       max_pre);
+		else
+			drm_dp_set_adjust_request_pre_emphasis(link_status, i,
+							       req_pre[i]);
+	}
+}
+
+static void cdn_mhdp_validate_cr(struct cdn_dp_device *dp, bool *cr_done,
+				 bool *same_before_adjust,
+				 bool *max_swing_reached,
+				 u8 before_cr[DP_LINK_STATUS_SIZE],
+				 u8 after_cr[DP_LINK_STATUS_SIZE],
+				 u8 *req_volt, u8 *req_pre)
+{
+	unsigned int i;
+	u8 tmp, max_volt = CDN_VOLT_SWING(dp->host.volt_swing),
+	   max_pre = CDN_PRE_EMPHASIS(dp->host.pre_emphasis), lane_status;
+	bool same_pre, same_volt;
+
+	*same_before_adjust = false;
+	*max_swing_reached = false;
+	*cr_done = true;
+
+	for (i = 0; i < dp->link.num_lanes; i++) {
+		tmp = drm_dp_get_adjust_request_voltage(after_cr, i);
+		req_volt[i] = min_t(u8, tmp, max_volt);
+
+		tmp = drm_dp_get_adjust_request_pre_emphasis(after_cr, i) >>
+			DP_TRAIN_PRE_EMPHASIS_SHIFT;
+		req_pre[i] = min_t(u8, tmp, max_pre);
+
+		same_pre = (before_cr[i] & DP_TRAIN_PRE_EMPHASIS_MASK) ==
+			(req_pre[i] << DP_TRAIN_PRE_EMPHASIS_SHIFT);
+		same_volt = (before_cr[i] & DP_TRAIN_VOLTAGE_SWING_MASK) ==
+			req_volt[i];
+		if (same_pre && same_volt)
+			*same_before_adjust = true;
+
+		lane_status = drm_dp_get_lane_status(after_cr, i);
+		if (!(lane_status & DP_LANE_CR_DONE)) {
+			*cr_done = false;
+			/* 3.1.5.2 in DP Standard v1.4. Table 3-1 */
+			if (req_volt[i] + req_pre[i] >= 3) {
+				*max_swing_reached = true;
+				return;
+			}
+		}
+	}
+}
+
+static bool cdn_mhdp_link_training_clock_recovery(struct cdn_dp_device *dp)
+{
+	u8 lanes_data[DP_MAX_NUM_LANES], fail_counter_short = 0,
+	   fail_counter_cr_long = 0;
+	u8 *dpcd;
+	bool cr_done;
+
+	dpcd = kzalloc(sizeof(u8) * DP_LINK_STATUS_SIZE, GFP_KERNEL);
+
+	dev_dbg(dp->dev, "Link training starting CR phase\n");
+
+	cdn_mhdp_link_training_init(dp);
+
+	drm_dp_dpcd_read_link_status(&dp->aux, dpcd);
+
+	do {
+		u8 requested_adjust_volt_swing[DP_MAX_NUM_LANES] = {},
+		   requested_adjust_pre_emphasis[DP_MAX_NUM_LANES] = {};
+		bool same_before_adjust, max_swing_reached;
+
+		cdn_mhdp_get_adjust_train(dp, dpcd, lanes_data);
+
+		cdn_dp_adjust_lt(dp, dp->link.num_lanes, 100,
+				 lanes_data, dpcd);
+
+		cdn_mhdp_validate_cr(dp, &cr_done, &same_before_adjust,
+				     &max_swing_reached, lanes_data, dpcd,
+				     requested_adjust_volt_swing,
+				     requested_adjust_pre_emphasis);
+
+		if (max_swing_reached)
+			goto err;
+
+		if (cr_done) {
+			dev_dbg(dp->dev,
+				"Link training: CR phase succeeded\n");
+			kfree(dpcd);
+			return true;
+		}
+
+		/* Not all CR_DONE bits set */
+		fail_counter_cr_long++;
+
+		if (same_before_adjust) {
+			fail_counter_short++;
+			continue;
+		}
+
+		fail_counter_short = 0;
+		/*
+		 * Voltage swing/pre-emphasis adjust requested during CR phase
+		 */
+		cdn_mhdp_adjust_requested_cr(dp, dpcd,
+					     requested_adjust_volt_swing,
+					     requested_adjust_pre_emphasis);
+	} while (fail_counter_short < 5 && fail_counter_cr_long < 10);
+
+err:
+	dev_dbg(dp->dev,
+		"Link training: CR phase failed for %d lanes and %d rate\n",
+		dp->link.num_lanes, dp->link.rate);
+
+	kfree(dpcd);
+
+	return false;
+}
+
+static void lower_link_rate(struct drm_dp_link *link)
+{
+	switch (drm_dp_link_rate_to_bw_code(link->rate)) {
+	case DP_LINK_BW_2_7:
+		link->rate = drm_dp_bw_code_to_link_rate(DP_LINK_BW_1_62);
+		break;
+	case DP_LINK_BW_5_4:
+		link->rate = drm_dp_bw_code_to_link_rate(DP_LINK_BW_2_7);
+		break;
+	case DP_LINK_BW_8_1:
+		link->rate = drm_dp_bw_code_to_link_rate(DP_LINK_BW_5_4);
+		break;
+	}
+}
+
+static u8 eq_training_pattern_supported(struct cdn_mhdp_host *host,
+					struct cdn_mhdp_sink *sink)
+{
+	return fls(host->pattern_supp & sink->pattern_supp);
+}
+
+static int cdn_mhdp_link_training(struct cdn_dp_device *dp,
+				  unsigned int video_mode,
+				  unsigned int training_interval)
+{
+	u32 reg32;
+	u8 eq_tps = eq_training_pattern_supported(&dp->host, &dp->sink);
+
+	while (1) {
+		if (!cdn_mhdp_link_training_clock_recovery(dp)) {
+			if (drm_dp_link_rate_to_bw_code(dp->link.rate) !=
+					DP_LINK_BW_1_62) {
+				dev_dbg(dp->dev,
+					"Reducing link rate during CR phase\n");
+				lower_link_rate(&dp->link);
+				drm_dp_link_configure(&dp->aux, &dp->link);
+
+				continue;
+			} else if (dp->link.num_lanes > 1) {
+				dev_dbg(dp->dev,
+					"Reducing lanes number during CR phase\n");
+				dp->link.num_lanes >>= 1;
+				dp->link.rate = max_link_rate(dp->host,
+							      dp->sink);
+				drm_dp_link_configure(&dp->aux, &dp->link);
+
+				continue;
+			}
+
+			dev_dbg(dp->dev,
+				"Link training failed during CR phase\n");
+			goto err;
+		}
+
+		if (cdn_mhdp_link_training_channel_eq(dp, eq_tps,
+						      training_interval))
+			break;
+
+		if (dp->link.num_lanes > 1) {
+			dev_dbg(dp->dev,
+				"Reducing lanes number during EQ phase\n");
+			dp->link.num_lanes >>= 1;
+			drm_dp_link_configure(&dp->aux, &dp->link);
+
+			continue;
+		} else if (drm_dp_link_rate_to_bw_code(dp->link.rate) !=
+			   DP_LINK_BW_1_62) {
+			dev_dbg(dp->dev,
+				"Reducing link rate during EQ phase\n");
+			lower_link_rate(&dp->link);
+			drm_dp_link_configure(&dp->aux, &dp->link);
+
+			continue;
+		}
+
+		dev_dbg(dp->dev, "Link training failed during EQ phase\n");
+		goto err;
+	}
+
+	dev_dbg(dp->dev, "Link training successful\n");
+
+	drm_dp_dpcd_writeb(&dp->aux, DP_TRAINING_PATTERN_SET,
+			   (dp->host.lanes_cnt & SCRAMBLER_EN) ? 0 :
+			   DP_LINK_SCRAMBLING_DISABLE);
+
+	/* SW reset DPTX framer */
+	cdn_dp_register_write(dp, CDN_DP_SW_RESET, 1);
+	cdn_dp_register_write(dp, CDN_DP_SW_RESET, 0);
+
+	/* Enable framer */
+	/* FIXME: update when MST supported, BIT(2) */
+	cdn_dp_register_write(dp, CDN_DP_FRAMER_GLOBAL_CONFIG,
+			      CDN_DP_FRAMER_EN |
+			      CDN_DP_NUM_LANES(dp->link.num_lanes) |
+			      CDN_DP_DISABLE_PHY_RST |
+			      CDN_DP_WR_FAILING_EDGE_VSYNC |
+			      (video_mode ? CDN_DP_NO_VIDEO_MODE : 0));
+
+	/* Reset PHY config */
+	reg32 = CDN_PHY_COMMON_CONFIG | CDN_PHY_TRAINING_TYPE(1);
+	if (!(dp->host.lanes_cnt & SCRAMBLER_EN))
+		reg32 |= CDN_PHY_SCRAMBLER_BYPASS;
+	cdn_dp_register_write(dp, CDN_DPTX_PHY_CONFIG, reg32);
+
+	return 0;
+err:
+	/* Reset PHY config */
+	reg32 = CDN_PHY_COMMON_CONFIG | CDN_PHY_TRAINING_TYPE(1);
+	if (!(dp->host.lanes_cnt & SCRAMBLER_EN))
+		reg32 |= CDN_PHY_SCRAMBLER_BYPASS;
+	cdn_dp_register_write(dp, CDN_DPTX_PHY_CONFIG, reg32);
+
+	drm_dp_dpcd_writeb(&dp->aux, DP_TRAINING_PATTERN_SET,
+			   DP_TRAINING_PATTERN_DISABLE);
+
+	return -EIO;
+}
+
+static void cdn_mhdp_enable(struct drm_bridge *bridge)
+{
+	struct cdn_dp_device *dp = bridge_to_dp(bridge);
+	struct drm_display_mode *mode;
+	struct drm_display_info *disp_info = &dp->connector.display_info;
+	enum vic_pxl_encoding_format pxlfmt;
+	int pxlclock;
+	unsigned int rate, tu_size = 30, vs, vs_f, bpp, required_bandwidth,
+		     available_bandwidth, dp_framer_sp = 0, msa_horizontal_1,
+		     msa_vertical_1, bnd_hsync2vsync, hsync2vsync_pol_ctrl,
+		     misc0 = 0, misc1 = 0, line_thresh = 0, pxl_repr,
+		     front_porch, back_porch, msa_h0, msa_v0, hsync, vsync,
+		     dp_vertical_1, line_thresh1, line_thresh2;
+	u32 reg_rd_resp;
+
+	unsigned int size = DP_RECEIVER_CAP_SIZE, dp_framer_global_config,
+		     video_mode, training_interval_us;
+	u8 reg0[size], reg8, amp[2];
+
+	mode = &bridge->encoder->crtc->state->adjusted_mode;
+	pxlclock = mode->crtc_clock;
+
+	/*
+	 * Upon power-on reset/device disconnection: [2:0] bits should be 0b001
+	 * and [7:5] bits 0b000.
+	 */
+	drm_dp_dpcd_writeb(&dp->aux, DP_SET_POWER, 1);
+
+	drm_dp_link_probe(&dp->aux, &dp->link);
+
+	dev_dbg(dp->dev, "Set sink device power state via DPCD\n");
+	drm_dp_link_power_up(&dp->aux, &dp->link);
+	/* FIXME (CDNS): do we have to wait for 100ms before going on? */
+	mdelay(100);
+
+	dp->sink.link_rate = dp->link.rate;
+	dp->sink.lanes_cnt = dp->link.num_lanes;
+	dp->sink.enhanced = !!(dp->link.capabilities &
+			DP_LINK_CAP_ENHANCED_FRAMING);
+
+	drm_dp_dpcd_read(&dp->aux, DP_DPCD_REV, reg0, size);
+
+	dp->sink.pattern_supp = PTS1 | PTS2;
+	if (drm_dp_tps3_supported(reg0))
+		dp->sink.pattern_supp |= PTS3;
+	if (drm_dp_tps4_supported(reg0))
+		dp->sink.pattern_supp |= PTS4;
+
+	dp->sink.fast_link = !!(reg0[DP_MAX_DOWNSPREAD] &
+			DP_NO_AUX_HANDSHAKE_LINK_TRAINING);
+
+	dp->link.rate = max_link_rate(dp->host, dp->sink);
+	dp->link.num_lanes = min_t(u8, dp->sink.lanes_cnt,
+			dp->host.lanes_cnt & GENMASK(2, 0));
+
+	reg8 = reg0[DP_TRAINING_AUX_RD_INTERVAL] &
+		DP_TRAINING_AUX_RD_INTERVAL_MASK;
+	switch (reg8) {
+	case 0:
+		training_interval_us = 400;
+		break;
+	case 1:
+	case 2:
+	case 3:
+	case 4:
+		training_interval_us = 4000 << (reg8 - 1);
+		break;
+	default:
+		dev_err(dp->dev,
+			"wrong training interval returned by DPCD: %d\n",
+			reg8);
+		return;
+	}
+
+	cdn_dp_register_read(dp, CDN_DP_FRAMER_GLOBAL_CONFIG, &reg_rd_resp);
+
+	dp_framer_global_config = reg_rd_resp;
+
+	video_mode = !(dp_framer_global_config & CDN_DP_NO_VIDEO_MODE);
+
+	if (dp_framer_global_config & CDN_DP_FRAMER_EN)
+		cdn_dp_register_write(dp, CDN_DP_FRAMER_GLOBAL_CONFIG,
+				      dp_framer_global_config &
+				      ~CDN_DP_FRAMER_EN);
+
+	/* Spread AMP if required, enable 8b/10b coding */
+	amp[0] = (dp->host.lanes_cnt & SSC) ? DP_SPREAD_AMP_0_5 : 0;
+	amp[1] = DP_SET_ANSI_8B10B;
+	drm_dp_dpcd_write(&dp->aux, DP_DOWNSPREAD_CTRL, amp, 2);
+
+	if (dp->host.fast_link & dp->sink.fast_link) {
+		/* FIXME: implement fastlink */
+		DRM_DEV_DEBUG_KMS(dp->dev, "fastlink\n");
+	} else {
+		int lt_result = cdn_mhdp_link_training(dp, video_mode,
+						       training_interval_us);
+		if (lt_result) {
+			dev_err(dp->dev, "Link training failed. Exiting.\n");
+			return;
+		}
+	}
+
+	rate = dp->link.rate / 1000;
+
+	/* FIXME: what about Y_ONLY? how is it handled in the kernel? */
+	if (disp_info->color_formats & DRM_COLOR_FORMAT_YCRCB444)
+		pxlfmt = YCBCR_4_4_4;
+	else if (disp_info->color_formats & DRM_COLOR_FORMAT_YCRCB422)
+		pxlfmt = YCBCR_4_2_2;
+	else if (disp_info->color_formats & DRM_COLOR_FORMAT_YCRCB420)
+		pxlfmt = YCBCR_4_2_0;
+	else
+		pxlfmt = PXL_RGB;
+
+	/* if YCBCR supported and stream not SD, use ITU709 */
+	/* FIXME: handle ITU version with YCBCR420 when supported */
+	if ((pxlfmt == YCBCR_4_4_4 ||
+			pxlfmt == YCBCR_4_2_2) && mode->crtc_vdisplay >= 720)
+		misc0 = DP_YCBCR_COEFFICIENTS_ITU709;
+
+	switch (pxlfmt) {
+	case PXL_RGB:
+		bpp = disp_info->bpc * 3;
+		pxl_repr = CDN_DP_FRAMER_RGB << CDN_DP_FRAMER_PXL_FORMAT;
+		misc0 |= DP_COLOR_FORMAT_RGB;
+		break;
+	case YCBCR_4_4_4:
+		bpp = disp_info->bpc * 3;
+		pxl_repr = CDN_DP_FRAMER_YCBCR444 << CDN_DP_FRAMER_PXL_FORMAT;
+		misc0 |= DP_COLOR_FORMAT_YCbCr444 | DP_TEST_DYNAMIC_RANGE_CEA;
+		break;
+	case YCBCR_4_2_2:
+		bpp = disp_info->bpc * 2;
+		pxl_repr = CDN_DP_FRAMER_YCBCR422 << CDN_DP_FRAMER_PXL_FORMAT;
+		misc0 |= DP_COLOR_FORMAT_YCbCr422 | DP_TEST_DYNAMIC_RANGE_CEA;
+		break;
+	case YCBCR_4_2_0:
+		bpp = disp_info->bpc * 3 / 2;
+		pxl_repr = CDN_DP_FRAMER_YCBCR420 << CDN_DP_FRAMER_PXL_FORMAT;
+		break;
+	default:
+		bpp = disp_info->bpc;
+		pxl_repr = CDN_DP_FRAMER_Y_ONLY << CDN_DP_FRAMER_PXL_FORMAT;
+	}
+
+	switch (disp_info->bpc) {
+	case 6:
+		misc0 |= DP_TEST_BIT_DEPTH_6;
+		pxl_repr |= CDN_DP_FRAMER_6_BPC;
+		break;
+	case 8:
+		misc0 |= DP_TEST_BIT_DEPTH_8;
+		pxl_repr |= CDN_DP_FRAMER_8_BPC;
+		break;
+	case 10:
+		misc0 |= DP_TEST_BIT_DEPTH_10;
+		pxl_repr |= CDN_DP_FRAMER_10_BPC;
+		break;
+	case 12:
+		misc0 |= DP_TEST_BIT_DEPTH_12;
+		pxl_repr |= CDN_DP_FRAMER_12_BPC;
+		break;
+	case 16:
+		misc0 |= DP_TEST_BIT_DEPTH_16;
+		pxl_repr |= CDN_DP_FRAMER_16_BPC;
+		break;
+	}
+
+	/* find optimal tu_size */
+	required_bandwidth = pxlclock * bpp / 8;
+	available_bandwidth = dp->link.num_lanes * rate;
+	do {
+		tu_size += 2;
+
+		vs_f = tu_size * required_bandwidth / available_bandwidth;
+		vs = vs_f / 1000;
+		vs_f = vs_f % 1000;
+		/* FIXME downspreading? It's unused is what I've been told. */
+	} while ((vs == 1 || ((vs_f > 850 || vs_f < 100) && vs_f != 0) ||
+			tu_size - vs < 2) && tu_size < 64);
+
+	if (vs > 64)
+		return;
+
+	bnd_hsync2vsync = CDN_IP_BYPASS_V_INTERFACE;
+	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
+		bnd_hsync2vsync |= CDN_IP_DET_INTERLACE_FORMAT;
+
+	cdn_dp_register_write(dp, BND_HSYNC2VSYNC, bnd_hsync2vsync);
+
+	if (mode->flags & DRM_MODE_FLAG_INTERLACE &&
+			mode->flags & DRM_MODE_FLAG_PHSYNC)
+		hsync2vsync_pol_ctrl = CDN_H2V_HSYNC_POL_ACTIVE_LOW |
+			CDN_H2V_VSYNC_POL_ACTIVE_LOW;
+	else
+		hsync2vsync_pol_ctrl = 0;
+
+	cdn_dp_register_write(dp, CDN_HSYNC2VSYNC_POL_CTRL,
+			      hsync2vsync_pol_ctrl);
+
+	cdn_dp_register_write(dp, CDN_DP_FRAMER_TU, CDN_DP_FRAMER_TU_VS(vs) |
+			      CDN_DP_FRAMER_TU_SIZE(tu_size) |
+			      CDN_DP_FRAMER_TU_CNT_RST_EN);
+
+	cdn_dp_register_write(dp, CDN_DP_FRAMER_PXL_REPR, pxl_repr);
+
+	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
+		dp_framer_sp |= CDN_DP_FRAMER_INTERLACE;
+	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
+		dp_framer_sp |= CDN_DP_FRAMER_HSYNC_POL_LOW;
+	if (mode->flags & DRM_MODE_FLAG_NVSYNC)
+		dp_framer_sp |= CDN_DP_FRAMER_VSYNC_POL_LOW;
+	cdn_dp_register_write(dp, CDN_DP_FRAMER_SP, dp_framer_sp);
+
+	front_porch = mode->crtc_hsync_start - mode->crtc_hdisplay;
+	back_porch = mode->crtc_htotal - mode->crtc_hsync_end;
+	cdn_dp_register_write(dp, CDN_DP_FRONT_BACK_PORCH,
+			      CDN_DP_FRONT_PORCH(front_porch) |
+			      CDN_DP_BACK_PORCH(back_porch));
+
+	cdn_dp_register_write(dp, CDN_DP_BYTE_COUNT,
+			      mode->crtc_hdisplay * bpp / 8);
+
+	msa_h0 = mode->crtc_htotal - mode->crtc_hsync_start;
+	cdn_dp_register_write(dp, CDN_DP_MSA_HORIZONTAL_0,
+			      CDN_DP_MSAH0_H_TOTAL(mode->crtc_htotal) |
+			      CDN_DP_MSAH0_HSYNC_START(msa_h0));
+
+	hsync = mode->crtc_hsync_end - mode->crtc_hsync_start;
+	msa_horizontal_1 = CDN_DP_MSAH1_HSYNC_WIDTH(hsync) |
+		CDN_DP_MSAH1_HDISP_WIDTH(mode->crtc_hdisplay);
+	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
+		msa_horizontal_1 |= CDN_DP_MSAH1_HSYNC_POL_LOW;
+	cdn_dp_register_write(dp, CDN_DP_MSA_HORIZONTAL_1, msa_horizontal_1);
+
+	msa_v0 = mode->crtc_vtotal - mode->crtc_vsync_start;
+	cdn_dp_register_write(dp, CDN_DP_MSA_VERTICAL_0,
+			      CDN_DP_MSAV0_V_TOTAL(mode->crtc_vtotal) |
+			      CDN_DP_MSAV0_VSYNC_START(msa_v0));
+
+	vsync = mode->crtc_vsync_end - mode->crtc_vsync_start;
+	msa_vertical_1 = CDN_DP_MSAV1_VSYNC_WIDTH(vsync) |
+		CDN_DP_MSAV1_VDISP_WIDTH(mode->crtc_vdisplay);
+	if (mode->flags & DRM_MODE_FLAG_NVSYNC)
+		msa_vertical_1 |= CDN_DP_MSAV1_VSYNC_POL_LOW;
+	cdn_dp_register_write(dp, CDN_DP_MSA_VERTICAL_1, msa_vertical_1);
+
+	if ((mode->flags & DRM_MODE_FLAG_INTERLACE) &&
+			mode->crtc_vtotal % 2 == 0)
+		misc1 = DP_TEST_INTERLACED;
+	if (pxlfmt == Y_ONLY)
+		misc1 |= DP_TEST_COLOR_FORMAT_RAW_Y_ONLY;
+	/* FIXME: use VSC SDP for Y420 */
+	/* FIXME: (CDN) no code for Y420 in bare metal test */
+	if (pxlfmt == YCBCR_4_2_0)
+		misc1 = DP_TEST_VSC_SDP;
+
+	cdn_dp_register_write(dp, CDN_DP_MSA_MISC, misc0 | (misc1 << 8));
+
+	/* FIXME: to be changed if MST mode */
+	cdn_dp_register_write(dp, CDN_DP_STREAM_CONFIG, 1);
+
+	cdn_dp_register_write(dp, CDN_DP_HORIZONTAL,
+			      CDN_DP_H_HSYNC_WIDTH(hsync) |
+			      CDN_DP_H_H_TOTAL(mode->crtc_hdisplay));
+
+	cdn_dp_register_write(dp, CDN_DP_VERTICAL_0,
+			      CDN_DP_V0_VHEIGHT(mode->crtc_vdisplay) |
+			      CDN_DP_V0_VSTART(msa_v0));
+
+	dp_vertical_1 = CDN_DP_V1_VTOTAL(mode->crtc_vtotal);
+	if ((mode->flags & DRM_MODE_FLAG_INTERLACE) &&
+			mode->crtc_vtotal % 2 == 0)
+		dp_vertical_1 |= CDN_DP_V1_VTOTAL_EVEN;
+
+	cdn_dp_register_write(dp, CDN_DP_VERTICAL_1, dp_vertical_1);
+
+	cdn_dp_register_write_field(dp, CDN_DP_VB_ID, 2, 1,
+				    (mode->flags & DRM_MODE_FLAG_INTERLACE) ?
+				    CDN_DP_VB_ID_INTERLACED : 0);
+
+	line_thresh1 = ((vs + 1) << 5) * 8 / bpp;
+	line_thresh2 = (pxlclock << 5) / 1000 / rate * (vs + 1) - (1 << 5);
+	line_thresh = line_thresh1 - line_thresh2 / dp->link.num_lanes;
+	line_thresh = (line_thresh >> 5) + 2;
+	cdn_dp_register_write(dp, CDN_DP_LINE_THRESH,
+			      line_thresh & GENMASK(5, 0));
+
+	cdn_dp_register_write(dp, CDN_DP_RATE_GOVERNOR_STATUS,
+			      CDN_DP_RG_TU_VS_DIFF((tu_size - vs > 3) ?
+			      0 : tu_size - vs));
+
+	cdn_dp_set_video_status(dp, 1);
+
+	/* __simu_enable_mhdp(dp->regs); */
+}
+
+static void cdn_mhdp_disable(struct drm_bridge *bridge)
+{
+	struct cdn_dp_device *dp = bridge_to_dp(bridge);
+
+	/* __simu_disable_mhdp(dp->regs); */
+
+	cdn_dp_set_video_status(dp, 0);
+
+	drm_dp_link_power_down(&dp->aux, &dp->link);
+}
+
+static int cdn_mhdp_attach(struct drm_bridge *bridge)
+{
+	struct cdn_dp_device *dp = bridge_to_dp(bridge);
+	struct drm_connector *conn = &dp->connector;
+	int ret;
+
+	conn->polled = DRM_CONNECTOR_POLL_CONNECT |
+		DRM_CONNECTOR_POLL_DISCONNECT;
+
+	ret = drm_connector_init(bridge->dev, conn,
+				 &cdn_dp_atomic_connector_funcs,
+				 DRM_MODE_CONNECTOR_DisplayPort);
+	if (ret) {
+		dev_err(dp->dev, "failed to init connector\n");
+		return ret;
+	}
+
+	drm_connector_helper_add(conn, &cdn_dp_connector_helper_funcs);
+
+	ret = drm_mode_connector_attach_encoder(conn, bridge->encoder);
+	if (ret) {
+		dev_err(dp->dev, "failed to attach connector to encoder\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct drm_bridge_funcs cdn_mhdp_bridge_funcs = {
+	.enable = cdn_mhdp_enable,
+	.disable = cdn_mhdp_disable,
+	.attach = cdn_mhdp_attach,
+};
+
+static ssize_t cdn_mhdp_transfer(struct drm_dp_aux *aux,
+				 struct drm_dp_aux_msg *msg)
+{
+	struct cdn_dp_device *dp = dev_get_drvdata(aux->dev);
+	int ret;
+
+	if (msg->request != DP_AUX_NATIVE_WRITE &&
+			msg->request != DP_AUX_NATIVE_READ)
+		return -ENOTSUPP;
+
+	if (msg->request == DP_AUX_NATIVE_WRITE) {
+		int i;
+
+		for (i = 0; i < msg->size; ++i) {
+			ret = cdn_dp_dpcd_write(dp,
+						msg->address + i,
+						*((u8 *)msg->buffer + i));
+			if (!ret)
+				continue;
+
+			DRM_DEV_ERROR(dp->dev, "Failed to write DPCD\n");
+
+			return i;
+		}
+	} else {
+		ret = cdn_dp_dpcd_read(dp, msg->address, msg->buffer,
+				       msg->size);
+		if (ret) {
+			DRM_DEV_ERROR(dp->dev, "Failed to read DPCD\n");
+			return 0;
+		}
+	}
+
+	return msg->size;
+}
+
+int cdn_mhdp_probe(struct cdn_dp_device *dp)
+{
+	unsigned long clk_rate;
+	const struct firmware *fw;
+	int ret;
+	u32 reg;
+
+	dp->core_clk = devm_clk_get(dp->dev, "clk");
+	if (IS_ERR(dp->core_clk)) {
+		DRM_DEV_ERROR(dp->dev, "cannot get core_clk_dp\n");
+		return PTR_ERR(dp->core_clk);
+	}
+
+	drm_dp_aux_init(&dp->aux);
+	dp->aux.dev = dp->dev;
+	dp->aux.transfer = cdn_mhdp_transfer;
+
+	clk_rate = clk_get_rate(dp->core_clk);
+	cdn_dp_set_fw_clk(dp, clk_rate);
+
+	ret = request_firmware(&fw, CDN_DP_FIRMWARE, dp->dev);
+	if (ret) {
+		dev_err(dp->dev, "failed to load firmware (%s), ret: %d\n",
+			CDN_DP_FIRMWARE, ret);
+		return ret;
+	}
+
+	memcpy_toio(dp->regs + ADDR_IMEM, fw->data, fw->size);
+
+	release_firmware(fw);
+
+	/* __simu_configure_mhdp(dp->regs); */
+
+	/* un-reset ucpu */
+	writel(0, dp->regs + APB_CTRL);
+
+	/* check the keep alive register to make sure fw working */
+	ret = readx_poll_timeout(readl, dp->regs + KEEP_ALIVE,
+				 reg, reg, 2000, FW_ALIVE_TIMEOUT_US);
+	if (ret < 0) {
+		DRM_DEV_ERROR(dp->dev, "failed to loaded the FW reg = %x\n",
+			      reg);
+		return -EINVAL;
+	}
+
+	/*
+	 * FIXME (CDNS): how are the characteristics/features of the host
+	 * defined? Will they be always hardcoded?
+	 */
+	/* FIXME: link rate 2.7; num_lanes = 2, */
+	/* FIXME: read capabilities from PHY */
+	/* FIXME: get number of lanes */
+	dp->host.link_rate = drm_dp_bw_code_to_link_rate(DP_LINK_BW_5_4);
+	dp->host.lanes_cnt = LANE_4 | SCRAMBLER_EN;
+	dp->host.volt_swing = VOLTAGE_LEVEL_3;
+	dp->host.pre_emphasis = PRE_EMPHASIS_LEVEL_2;
+	dp->host.pattern_supp = PTS1 | PTS2 | PTS3 | PTS4;
+	dp->host.fast_link = 0;
+	dp->host.lane_mapping = LANE_MAPPING_FLIPPED;
+	dp->host.enhanced = true;
+
+	dp->bridge.of_node = dp->dev->of_node;
+	dp->bridge.funcs = &cdn_mhdp_bridge_funcs;
+
+	ret = cdn_dp_set_firmware_active(dp, true);
+	if (ret) {
+		DRM_DEV_ERROR(dp->dev, "active ucpu failed: %d\n", ret);
+		return ret;
+	}
+
+	/* __simu_phy_reset(dp->regs); */
+
+	ret = readl_poll_timeout(dp->regs + SW_EVENTS0, reg,
+				 reg & DPTX_HPD_EVENT, 500,
+				 HPD_EVENT_TIMEOUT);
+	if (ret) {
+		dev_err(dp->dev, "no HPD received %d\n", reg);
+		return -ENODEV;
+	}
+
+	drm_bridge_add(&dp->bridge);
+
+	/* __simu_configure2_mhdp(dp->regs); */
+
+	return 0;
+}
+
 static int cdn_dp_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	const struct of_device_id *match;
+	struct resource *res;
 	struct cdn_dp_data *dp_data;
 	struct cdn_dp_port *port;
 	struct cdn_dp_device *dp;
@@ -1161,7 +2036,24 @@ static int cdn_dp_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	dp->dev = dev;
 
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	dp->regs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(dp->regs)) {
+		DRM_DEV_ERROR(dev, "ioremap reg failed\n");
+		return PTR_ERR(dp->regs);
+	}
+
 	match = of_match_node(cdn_dp_dt_ids, pdev->dev.of_node);
+	if (!match)
+		return -EINVAL;
+
+	dp->mhdp_ip = !strcmp("cdns,mhdp", match->compatible);
+
+	if (dp->mhdp_ip) {
+		cdn_mhdp_probe(dp);
+		goto skip_phy_init;
+	}
+
 	dp_data = (struct cdn_dp_data *)match->data;
 
 	for (i = 0; i < dp_data->max_phy; i++) {
@@ -1194,6 +2086,8 @@ static int cdn_dp_probe(struct platform_device *pdev)
 	mutex_init(&dp->lock);
 	dev_set_drvdata(dev, dp);
 
+skip_phy_init:
+
 	cdn_dp_audio_codec_init(dp, dev);
 
 	return component_add(dev, &cdn_dp_component_ops);
@@ -1202,10 +2096,23 @@ static int cdn_dp_probe(struct platform_device *pdev)
 static int cdn_dp_remove(struct platform_device *pdev)
 {
 	struct cdn_dp_device *dp = platform_get_drvdata(pdev);
+	int ret;
 
 	platform_device_unregister(dp->audio_pdev);
-	cdn_dp_suspend(dp->dev);
-	component_del(&pdev->dev, &cdn_dp_component_ops);
+
+	if (dp->mhdp_ip) {
+		drm_bridge_remove(&dp->bridge);
+
+		ret = cdn_dp_set_firmware_active(dp, false);
+		if (ret) {
+			DRM_DEV_ERROR(dp->dev, "disabling fw failed: %d\n",
+				      ret);
+			return ret;
+		}
+	} else {
+		cdn_dp_suspend(dp->dev);
+		component_del(&pdev->dev, &cdn_dp_component_ops);
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.h b/drivers/gpu/drm/rockchip/cdn-dp-core.h
index f57e296..9c43f6d 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.h
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.h
@@ -69,6 +69,25 @@ struct cdn_dp_port {
 	u8 id;
 };
 
+struct cdn_mhdp_host {
+	unsigned int	link_rate;
+	u8	lanes_cnt;
+	u8	volt_swing;
+	u8	pre_emphasis;
+	u8	pattern_supp;
+	u8	fast_link;
+	u8	lane_mapping;
+	u8	enhanced;
+};
+
+struct cdn_mhdp_sink {
+	unsigned int	link_rate;
+	u8	lanes_cnt;
+	u8	pattern_supp;
+	u8	fast_link;
+	u8	enhanced;
+};
+
 struct cdn_dp_device {
 	struct device *dev;
 	struct drm_device *drm_dev;
@@ -108,5 +127,11 @@ struct cdn_dp_device {
 
 	u8 dpcd[DP_RECEIVER_CAP_SIZE];
 	bool sink_has_audio;
+	bool mhdp_ip;
+
+	struct cdn_mhdp_host host;
+	struct cdn_mhdp_sink sink;
+	struct drm_bridge bridge;
+	struct drm_dp_aux aux;
 };
 #endif  /* _CDN_DP_CORE_H */
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-reg.c b/drivers/gpu/drm/rockchip/cdn-dp-reg.c
index b061cfc..52a284b 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-reg.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-reg.c
@@ -1060,7 +1060,7 @@ int cdn_dp_register_write(struct cdn_dp_device *dp, u32 addr, u32 value)
 }
 
 int cdn_dp_register_write_field(struct cdn_dp_device *dp, u32 addr,
-		u8 index, u8 nbits, u32 value)
+				u8 index, u8 nbits, u32 value)
 {
 	u8 msg[10];
 	int ret;
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-reg.h b/drivers/gpu/drm/rockchip/cdn-dp-reg.h
index b5472ad..135f36e 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-reg.h
+++ b/drivers/gpu/drm/rockchip/cdn-dp-reg.h
@@ -388,6 +388,10 @@
 #define LANE_MAPPING_NORMAL			0x1b
 #define LANE_MAPPING_FLIPPED			0xe4
 #define ENHANCED				1
+#define LANE_1					BIT(0)
+#define LANE_2					BIT(1)
+#define LANE_4					BIT(2)
+#define SSC					BIT(3)
 #define SCRAMBLER_EN				BIT(4)
 
 #define	FULL_LT_STARTED				BIT(0)
-- 
1.7.1
