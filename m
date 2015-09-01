From: ykk@rock-chips.com (Yakir Yang)
Date: Tue,  1 Sep 2015 13:52:41 +0800
Subject: [PATCH v4 04/16] drm: bridge: analogix/dp: remove duplicate
 configuration of link rate and link count
In-Reply-To: <1441086371-24838-1-git-send-email-ykk@rock-chips.com>
References: <1441086371-24838-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1441086761-25052-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

link_rate and lane_count already configured in analogix_dp_set_link_train(),
so we don't need to config those repeatly after training finished, just
remove them out.

Beside Display Port 1.2 already support 5.4Gbps link rate, the maximum sets
would change from {1.62Gbps, 2.7Gbps} to {1.62Gbps, 2.7Gbps, 5.4Gbps}.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
Changes in v4:
- Take Jingoo Han suggest, update commit message more readable.
- Adjust the order from 05 to 04

Changes in v3:
- Take Thierry Reding suggest, link_rate and lane_count shouldn't config to
  the DT property value directly, but we can take those as hardware limite.
  For example, RK3288 only support 4 physical lanes of 2.7/1.62 Gbps/lane,
  so DT property would like "link-rate = 0x0a" "lane-count = 4".

Changes in v2: None

 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 8 ++++----
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.h | 5 +++--
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 7d62f22..7196097 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -631,6 +631,8 @@ static void analogix_dp_get_max_rx_bandwidth(struct analogix_dp_device *dp,
 	/*
 	 * For DP rev.1.1, Maximum link rate of Main Link lanes
 	 * 0x06 = 1.62 Gbps, 0x0a = 2.7 Gbps
+	 * For DP rev.1.2, Maximum link rate of Main Link lanes
+	 * 0x06 = 1.62 Gbps, 0x0a = 2.7 Gbps, 0x14 = 5.4Gbps
 	 */
 	analogix_dp_read_byte_from_dpcd(dp, DP_MAX_LINK_RATE, &data);
 	*bandwidth = data;
@@ -664,7 +666,8 @@ static void analogix_dp_init_training(struct analogix_dp_device *dp,
 	analogix_dp_get_max_rx_lane_count(dp, &dp->link_train.lane_count);
 
 	if ((dp->link_train.link_rate != LINK_RATE_1_62GBPS) &&
-	    (dp->link_train.link_rate != LINK_RATE_2_70GBPS)) {
+	    (dp->link_train.link_rate != LINK_RATE_2_70GBPS) &&
+	    (dp->link_train.link_rate != LINK_RATE_5_40GBPS)) {
 		dev_err(dp->dev, "Rx Max Link Rate is abnormal :%x !\n",
 			dp->link_train.link_rate);
 		dp->link_train.link_rate = LINK_RATE_1_62GBPS;
@@ -905,9 +908,6 @@ static void analogix_dp_commit(struct analogix_dp_device *dp)
 	analogix_dp_enable_rx_to_enhanced_mode(dp, 1);
 	analogix_dp_enable_enhanced_mode(dp, 1);
 
-	analogix_dp_set_lane_count(dp, dp->video_info->lane_count);
-	analogix_dp_set_link_bandwidth(dp, dp->video_info->link_rate);
-
 	analogix_dp_init_video(dp);
 	ret = analogix_dp_config_video(dp);
 	if (ret)
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
index d7e47e0..ffabbd0 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
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
-- 
2.1.2
