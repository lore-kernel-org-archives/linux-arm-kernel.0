From: ykk@rock-chips.com (Yakir Yang)
Date: Tue,  1 Sep 2015 14:11:30 +0800
Subject: [PATCH v4 13/16] drm: bridge: analogix/dp: add max link rate and lane
 count limit for RK3288
In-Reply-To: <1441086371-24838-1-git-send-email-ykk@rock-chips.com>
References: <1441086371-24838-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1441087890-25722-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are some IP limit on rk3288 that only support 4 physical lanes
of 2.7/1.6 Gbps/lane, so seprate them out by device_type flag.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
Changes in v4:
- Take Thierry suggest, seprate the link-rate and lane-count limit
  out with the device_type flag.

Changes in v3: None
Changes in v2: None

 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 35 ++++++++++++++--------
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.h |  4 +--
 2 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index f0db92e..f7227ec 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -897,8 +897,8 @@ static void analogix_dp_commit(struct analogix_dp_device *dp)
 		return;
 	}
 
-	ret = analogix_dp_set_link_train(dp, dp->video_info.lane_count,
-					 dp->video_info.link_rate);
+	ret = analogix_dp_set_link_train(dp, dp->video_info.max_lane_count,
+					 dp->video_info.max_link_rate);
 	if (ret) {
 		dev_err(dp->dev, "unable to do link train\n");
 		return;
@@ -1201,18 +1201,27 @@ static int analogix_dp_create_bridge(struct drm_device *drm_dev,
 static int analogix_dp_dt_parse_pdata(struct analogix_dp_device *dp)
 {
 	struct device_node *dp_node = dp->dev->of_node;
-	struct video_info *video_config = &dp->video_info;
-
-	if (of_property_read_u32(dp_node, "samsung,link-rate",
-				 &video_info->link_rate)) {
-		dev_err(dev, "failed to get link-rate\n");
-		return -EINVAL;
-	}
+	struct video_info *video_info = &dp->video_info;
 
-	if (of_property_read_u32(dp_node, "samsung,lane-count",
-				 &video_info->lane_count)) {
-		dev_err(dev, "failed to get lane-count\n");
-		return -EINVAL;
+	switch (dp->plat_data && dp->plat_data->dev_type) {
+	case RK3288_DP:
+		/*
+		 * Like Rk3288 DisplayPort TRM indicate that "Main link
+		 * containing 4 physical lanes of 2.7/1.62 Gbps/lane".
+		 */
+		video_info->max_link_rate = 0x0A;
+		video_info->max_lane_count = 0x04;
+		break;
+	case EXYNOS_DP:
+		/*
+		 * NOTE: those property parseing code is used for
+		 * providing backward compatibility for samsung platform.
+		 */
+		of_property_read_u32(dp_node, "samsung,link-rate",
+				     &video_info->max_link_rate);
+		of_property_read_u32(dp_node, "samsung,lane-count",
+				     &video_info->max_lane_count);
+		break;
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
index 6e3d5bc..d8945e2 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
@@ -129,8 +129,8 @@ struct video_info {
 	enum color_coefficient ycbcr_coeff;
 	enum color_depth color_depth;
 
-	enum link_rate_type link_rate;
-	enum link_lane_count_type lane_count;
+	enum link_rate_type max_link_rate;
+	enum link_lane_count_type max_lane_count;
 };
 
 struct link_train {
-- 
2.1.2
