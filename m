From: ykk@rock-chips.com (Yakir Yang)
Date: Wed, 19 Aug 2015 09:50:24 -0500
Subject: [PATCH v3 05/14] drm: bridge/analogix_dp: fix link_rate & lane_count
 bug
In-Reply-To: <1439995728-18046-1-git-send-email-ykk@rock-chips.com>
References: <1439995728-18046-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1439995824-18312-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

link_rate and lane_count already configed in analogix_dp_set_link_train(),
so we don't need to config those repeatly after training finished, just
remove them out.

Beside Display Port 1.2 already support 5.4Gbps link rate, the maximum sets
would change from {1.62Gbps, 2.7Gbps} to {1.62Gbps, 2.7Gbps, 5.4Gbps}.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
Changes in v3:
- Take Thierry Reding suggest, link_rate and lane_count shouldn't config to
  the DT property value directly, but we can take those as hardware limite.
  For example, RK3288 only support 4 physical lanes of 2.7/1.62 Gbps/lane,
  so DT property would like "link-rate = 0x0a" "lane-count = 4".

Changes in v2: None

 drivers/gpu/drm/bridge/analogix_dp_core.c | 16 ++++++++--------
 drivers/gpu/drm/bridge/analogix_dp_core.h |  9 +++++----
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix_dp_core.c
index 480cc13..1778e0a 100644
--- a/drivers/gpu/drm/bridge/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix_dp_core.c
@@ -635,6 +635,8 @@ static void analogix_dp_get_max_rx_bandwidth(struct analogix_dp_device *dp,
 	/*
 	 * For DP rev.1.1, Maximum link rate of Main Link lanes
 	 * 0x06 = 1.62 Gbps, 0x0a = 2.7 Gbps
+	 * For DP rev.1.2, Maximum link rate of Main Link lanes
+	 * 0x06 = 1.62 Gbps, 0x0a = 2.7 Gbps, 0x14 = 5.4Gbps
 	 */
 	analogix_dp_read_byte_from_dpcd(dp, DP_MAX_LINK_RATE, &data);
 	*bandwidth = data;
@@ -668,7 +670,8 @@ static void analogix_dp_init_training(struct analogix_dp_device *dp,
 	analogix_dp_get_max_rx_lane_count(dp, &dp->link_train.lane_count);
 
 	if ((dp->link_train.link_rate != LINK_RATE_1_62GBPS) &&
-	    (dp->link_train.link_rate != LINK_RATE_2_70GBPS)) {
+	    (dp->link_train.link_rate != LINK_RATE_2_70GBPS) &&
+	    (dp->link_train.link_rate != LINK_RATE_5_40GBPS)) {
 		dev_err(dp->dev, "Rx Max Link Rate is abnormal :%x !\n",
 			dp->link_train.link_rate);
 		dp->link_train.link_rate = LINK_RATE_1_62GBPS;
@@ -901,8 +904,8 @@ static void analogix_dp_commit(struct analogix_dp_device *dp)
 		return;
 	}
 
-	ret = analogix_dp_set_link_train(dp, dp->video_info->lane_count,
-					 dp->video_info->link_rate);
+	ret = analogix_dp_set_link_train(dp, dp->video_info->max_lane_count,
+					 dp->video_info->max_link_rate);
 	if (ret) {
 		dev_err(dp->dev, "unable to do link train\n");
 		return;
@@ -912,9 +915,6 @@ static void analogix_dp_commit(struct analogix_dp_device *dp)
 	analogix_dp_enable_rx_to_enhanced_mode(dp, 1);
 	analogix_dp_enable_enhanced_mode(dp, 1);
 
-	analogix_dp_set_lane_count(dp, dp->video_info->lane_count);
-	analogix_dp_set_link_bandwidth(dp, dp->video_info->link_rate);
-
 	analogix_dp_init_video(dp);
 	ret = analogix_dp_config_video(dp);
 	if (ret)
@@ -1198,13 +1198,13 @@ static struct video_info *analogix_dp_dt_parse_pdata(struct device *dev)
 	}
 
 	if (of_property_read_u32(dp_node, "analogix,link-rate",
-				 &dp_video_config->link_rate)) {
+				 &dp_video_config->max_link_rate)) {
 		dev_err(dev, "failed to get link-rate\n");
 		return ERR_PTR(-EINVAL);
 	}
 
 	if (of_property_read_u32(dp_node, "analogix,lane-count",
-				 &dp_video_config->lane_count)) {
+				 &dp_video_config->max_lane_count)) {
 		dev_err(dev, "failed to get lane-count\n");
 		return ERR_PTR(-EINVAL);
 	}
diff --git a/drivers/gpu/drm/bridge/analogix_dp_core.h b/drivers/gpu/drm/bridge/analogix_dp_core.h
index 2cefde9..941b34f 100644
--- a/drivers/gpu/drm/bridge/analogix_dp_core.h
+++ b/drivers/gpu/drm/bridge/analogix_dp_core.h
@@ -21,8 +21,9 @@
 #define MAX_EQ_LOOP 5
 
 enum link_rate_type {
-	LINK_RATE_1_62GBPS = 0x06,
-	LINK_RATE_2_70GBPS = 0x0a
+	LINK_RATE_1_62GBPS = DP_LINK_BW_1_62,
+	LINK_RATE_2_70GBPS = DP_LINK_BW_2_7,
+	LINK_RATE_5_40GBPS = DP_LINK_BW_5_4,
 };
 
 enum link_lane_count_type {
@@ -128,8 +129,8 @@ struct video_info {
 	enum color_coefficient ycbcr_coeff;
 	enum color_depth color_depth;
 
-	enum link_rate_type link_rate;
-	enum link_lane_count_type lane_count;
+	enum link_rate_type       max_link_rate;
+	enum link_lane_count_type max_lane_count;
 };
 
 struct link_train {
-- 
1.9.1
