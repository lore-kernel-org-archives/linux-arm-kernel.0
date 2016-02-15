From: ykk@rock-chips.com (Yakir Yang)
Date: Mon, 15 Feb 2016 19:10:04 +0800
Subject: [PATCH v14 05/17] drm: bridge: analogix/dp: remove duplicate
 configuration of link rate and link count
In-Reply-To: <1455534485-1154-1-git-send-email-ykk@rock-chips.com>
References: <1455534485-1154-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1455534604-1694-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

link_rate and lane_count already configured in analogix_dp_set_link_train(),
so we don't need to config those repeatly after training finished, just
remove them out.

Beside Display Port 1.2 already support 5.4Gbps link rate, the maximum sets
would change from {1.62Gbps, 2.7Gbps} to {1.62Gbps, 2.7Gbps, 5.4Gbps}.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>
---
Changes in v14: None
Changes in v13: None
Changes in v12:
- Remove the enum link_rate_type struct, using the marcos in drm_dp_helper.h (Jingoo)

Changes in v11: None
Changes in v10: None
Changes in v9: None
Changes in v8: None
Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4:
- Update commit message more readable. (Jingoo)
- Adjust the order from 05 to 04

Changes in v3:
- The link_rate and lane_count shouldn't config to the DT property value
  directly, but we can take those as hardware limite. For example, RK3288
  only support 4 physical lanes of 2.7/1.62 Gbps/lane, so DT property would
  like "link-rate = 0x0a" "lane-count = 4". (Thierry)

Changes in v2: None

 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 14 +++++++-------
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.h |  7 +------
 drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c  |  2 +-
 3 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 6901a6f..b948636 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -627,6 +627,8 @@ static void analogix_dp_get_max_rx_bandwidth(struct analogix_dp_device *dp,
 	/*
 	 * For DP rev.1.1, Maximum link rate of Main Link lanes
 	 * 0x06 = 1.62 Gbps, 0x0a = 2.7 Gbps
+	 * For DP rev.1.2, Maximum link rate of Main Link lanes
+	 * 0x06 = 1.62 Gbps, 0x0a = 2.7 Gbps, 0x14 = 5.4Gbps
 	 */
 	analogix_dp_read_byte_from_dpcd(dp, DP_MAX_LINK_RATE, &data);
 	*bandwidth = data;
@@ -647,7 +649,7 @@ static void analogix_dp_get_max_rx_lane_count(struct analogix_dp_device *dp,
 
 static void analogix_dp_init_training(struct analogix_dp_device *dp,
 				      enum link_lane_count_type max_lane,
-				      enum link_rate_type max_rate)
+				      int max_rate)
 {
 	/*
 	 * MACRO_RST must be applied after the PLL_LOCK to avoid
@@ -659,11 +661,12 @@ static void analogix_dp_init_training(struct analogix_dp_device *dp,
 	analogix_dp_get_max_rx_bandwidth(dp, &dp->link_train.link_rate);
 	analogix_dp_get_max_rx_lane_count(dp, &dp->link_train.lane_count);
 
-	if ((dp->link_train.link_rate != LINK_RATE_1_62GBPS) &&
-	    (dp->link_train.link_rate != LINK_RATE_2_70GBPS)) {
+	if ((dp->link_train.link_rate != DP_LINK_BW_1_62) &&
+	    (dp->link_train.link_rate != DP_LINK_BW_2_7) &&
+	    (dp->link_train.link_rate != DP_LINK_BW_5_4)) {
 		dev_err(dp->dev, "Rx Max Link Rate is abnormal :%x !\n",
 			dp->link_train.link_rate);
-		dp->link_train.link_rate = LINK_RATE_1_62GBPS;
+		dp->link_train.link_rate = DP_LINK_BW_1_62;
 	}
 
 	if (dp->link_train.lane_count == 0) {
@@ -901,9 +904,6 @@ static void analogix_dp_commit(struct analogix_dp_device *dp)
 	analogix_dp_enable_rx_to_enhanced_mode(dp, 1);
 	analogix_dp_enable_enhanced_mode(dp, 1);
 
-	analogix_dp_set_lane_count(dp, dp->video_info->lane_count);
-	analogix_dp_set_link_bandwidth(dp, dp->video_info->link_rate);
-
 	analogix_dp_init_video(dp);
 	ret = analogix_dp_config_video(dp);
 	if (ret)
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
index d4c4ae2..afb0a53 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
@@ -20,11 +20,6 @@
 #define MAX_CR_LOOP 5
 #define MAX_EQ_LOOP 5
 
-enum link_rate_type {
-	LINK_RATE_1_62GBPS = 0x06,
-	LINK_RATE_2_70GBPS = 0x0a
-};
-
 enum link_lane_count_type {
 	LANE_COUNT1 = 1,
 	LANE_COUNT2 = 2,
@@ -128,7 +123,7 @@ struct video_info {
 	enum color_coefficient ycbcr_coeff;
 	enum color_depth color_depth;
 
-	enum link_rate_type link_rate;
+	int link_rate;
 	enum link_lane_count_type lane_count;
 };
 
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
index a388c0a..eb0b63c 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
@@ -855,7 +855,7 @@ void analogix_dp_set_link_bandwidth(struct analogix_dp_device *dp, u32 bwtype)
 	u32 reg;
 
 	reg = bwtype;
-	if ((bwtype == LINK_RATE_2_70GBPS) || (bwtype == LINK_RATE_1_62GBPS))
+	if ((bwtype == DP_LINK_BW_2_7) || (bwtype == DP_LINK_BW_1_62))
 		writel(reg, dp->reg_base + ANALOGIX_DP_LINK_BW_SET);
 }
 
-- 
1.9.1
