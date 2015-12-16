From: ykk@rock-chips.com (Yakir Yang)
Date: Wed, 16 Dec 2015 11:49:20 +0800
Subject: [PATCH v11 13/19] drm: bridge: analogix/dp: add max link rate and
 lane count limit for RK3288
In-Reply-To: <1450236018-1118-1-git-send-email-ykk@rock-chips.com>
References: <1450236018-1118-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1450237760-3034-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are some IP limit on rk3288 that only support 4 physical lanes
of 2.7/1.6 Gbps/lane, so seprate them out by device_type flag.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>
---
Changes in v11: None
Changes in v10:
- Remove the surplus "plat_data" check. (Heiko)
-       switch (dp->plat_data && dp->plat_data->dev_type) {
+       switch (dp->plat_data->dev_type) {

Changes in v9: None
Changes in v8: None
Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4:
- Seprate the link-rate and lane-count limit out with the device_type
  flag. (Thierry)

Changes in v3: None
Changes in v2: None

 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 33 ++++++++++++++--------
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.h |  4 +--
 2 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index a0d97cb..f624810 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -890,8 +890,8 @@ static void analogix_dp_commit(struct analogix_dp_device *dp)
 		return;
 	}
 
-	ret = analogix_dp_set_link_train(dp, dp->video_info.lane_count,
-					 dp->video_info.link_rate);
+	ret = analogix_dp_set_link_train(dp, dp->video_info.max_lane_count,
+					 dp->video_info.max_link_rate);
 	if (ret) {
 		dev_err(dp->dev, "unable to do link train\n");
 		return;
@@ -1158,16 +1158,25 @@ static int analogix_dp_dt_parse_pdata(struct analogix_dp_device *dp)
 	struct device_node *dp_node = dp->dev->of_node;
 	struct video_info *video_info = &dp->video_info;
 
-	if (of_property_read_u32(dp_node, "samsung,link-rate",
-				 &video_info->link_rate)) {
-		dev_err(dp->dev, "failed to get link-rate\n");
-		return -EINVAL;
-	}
-
-	if (of_property_read_u32(dp_node, "samsung,lane-count",
-				 &video_info->lane_count)) {
-		dev_err(dp->dev, "failed to get lane-count\n");
-		return -EINVAL;
+	switch (dp->plat_data->dev_type) {
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
index 0416d23..45555ec 100644
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
1.9.1
