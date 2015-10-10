From: ykk@rock-chips.com (Yakir Yang)
Date: Sat, 10 Oct 2015 23:46:01 +0800
Subject: [PATCH v6 05/17] drm: bridge: analogix/dp: dynamic parse sync_pol &
 interlace & dynamic_range
In-Reply-To: <1444491357-26095-1-git-send-email-ykk@rock-chips.com>
References: <1444491357-26095-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1444491961-26799-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both hsync/vsync polarity and interlace mode can be parsed from
drm display mode, and dynamic_range and ycbcr_coeff can be judge
by the video code.

But presumably Exynos still relies on the DT properties, so take
good use of mode_fixup() in to achieve the compatibility hacks.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
Changes in v6: None
Changes in v5:
- Switch video timing type to "u32", so driver could use "of_property_read_u32"
  to get the backword timing values. Krzysztof suggest me that driver could use
  the "of_property_read_bool" to get backword timing values, but that interfacs
  would modify the original drm_display_mode timing directly (whether those
  properties exists or not).

Changes in v4:
- Provide backword compatibility with samsung. (Krzysztof)

Changes in v3:
- Dynamic parse video timing info from struct drm_display_mode and
  struct drm_display_info. (Thierry)

Changes in v2: None

 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 148 +++++++++++++--------
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.h |   8 +-
 drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c  |  14 +-
 3 files changed, 106 insertions(+), 64 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 96afb67..9d802ef 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -890,8 +890,8 @@ static void analogix_dp_commit(struct analogix_dp_device *dp)
 		return;
 	}
 
-	ret = analogix_dp_set_link_train(dp, dp->video_info->lane_count,
-					 dp->video_info->link_rate);
+	ret = analogix_dp_set_link_train(dp, dp->video_info.lane_count,
+					 dp->video_info.link_rate);
 	if (ret) {
 		dev_err(dp->dev, "unable to do link train\n");
 		return;
@@ -1030,6 +1030,85 @@ static void analogix_dp_bridge_disable(struct drm_bridge *bridge)
 	dp->dpms_mode = DRM_MODE_DPMS_OFF;
 }
 
+static void analogix_dp_bridge_mode_set(struct drm_bridge *bridge,
+					struct drm_display_mode *orig_mode,
+					struct drm_display_mode *mode)
+{
+	struct analogix_dp_device *dp = bridge->driver_private;
+	struct drm_display_info *display_info = &dp->connector->display_info;
+	struct video_info *video = &dp->video_info;
+	struct device_node *dp_node = dp->dev->of_node;
+	int vic;
+
+	/* Input video interlaces & hsync pol & vsync pol */
+	video->interlaced = !!(mode->flags & DRM_MODE_FLAG_INTERLACE);
+	video->v_sync_polarity = !!(mode->flags & DRM_MODE_FLAG_NVSYNC);
+	video->h_sync_polarity = !!(mode->flags & DRM_MODE_FLAG_NHSYNC);
+
+	/* Input video dynamic_range & colorimetry */
+	vic = drm_match_cea_mode(mode);
+	if ((vic == 6) || (vic == 7) || (vic == 21) || (vic == 22) ||
+	    (vic == 2) || (vic == 3) || (vic == 17) || (vic == 18)) {
+		video->dynamic_range = CEA;
+		video->ycbcr_coeff = COLOR_YCBCR601;
+	} else if (vic) {
+		video->dynamic_range = CEA;
+		video->ycbcr_coeff = COLOR_YCBCR709;
+	} else {
+		video->dynamic_range = VESA;
+		video->ycbcr_coeff = COLOR_YCBCR709;
+	}
+
+	/* Input vide bpc and color_formats */
+	switch (display_info->bpc) {
+	case 12:
+		video->color_depth = COLOR_12;
+		break;
+	case 10:
+		video->color_depth = COLOR_10;
+		break;
+	case 8:
+		video->color_depth = COLOR_8;
+		break;
+	case 6:
+		video->color_depth = COLOR_6;
+		break;
+	default:
+		video->color_depth = COLOR_8;
+		break;
+	}
+	if (display_info->color_formats & DRM_COLOR_FORMAT_YCRCB444)
+		video->color_space = COLOR_YCBCR444;
+	else if (display_info->color_formats & DRM_COLOR_FORMAT_YCRCB422)
+		video->color_space = COLOR_YCBCR422;
+	else if (display_info->color_formats & DRM_COLOR_FORMAT_RGB444)
+		video->color_space = COLOR_RGB;
+	else
+		video->color_space = COLOR_RGB;
+
+	/*
+	 * NOTE: those property parsing code is used for providing backward
+	 * compatibility for samsung platform.
+	 * Due to we used the "of_property_read_u32" interfaces, when this
+	 * property isn't present, the "video_info" can keep the original
+	 * values and wouldn't be modified.
+	 */
+	of_property_read_u32(dp_node, "samsung,color-space",
+			     &video->color_space);
+	of_property_read_u32(dp_node, "samsung,dynamic-range",
+			     &video->dynamic_range);
+	of_property_read_u32(dp_node, "samsung,ycbcr-coeff",
+			     &video->ycbcr_coeff);
+	of_property_read_u32(dp_node, "samsung,color-depth",
+			     &video->color_depth);
+	of_property_read_u32(dp_node, "hsync-active-high",
+			     &video->h_sync_polarity);
+	of_property_read_u32(dp_node, "vsync-active-high",
+			     &video->v_sync_polarity);
+	of_property_read_u32(dp_node, "interlaced",
+			     &video->interlaced);
+}
+
 static void analogix_dp_bridge_nop(struct drm_bridge *bridge)
 {
 	/* do nothing */
@@ -1040,6 +1119,7 @@ static const struct drm_bridge_funcs analogix_dp_bridge_funcs = {
 	.disable = analogix_dp_bridge_disable,
 	.pre_enable = analogix_dp_bridge_nop,
 	.post_disable = analogix_dp_bridge_nop,
+	.mode_set = analogix_dp_bridge_mode_set,
 	.attach = analogix_dp_bridge_attach,
 };
 
@@ -1071,62 +1151,24 @@ static int analogix_dp_create_bridge(struct drm_device *drm_dev,
 	return 0;
 }
 
-static struct video_info *analogix_dp_dt_parse_pdata(struct device *dev)
+static int analogix_dp_dt_parse_pdata(struct analogix_dp_device *dp)
 {
-	struct device_node *dp_node = dev->of_node;
-	struct video_info *dp_video_config;
-
-	dp_video_config = devm_kzalloc(dev, sizeof(*dp_video_config),
-				       GFP_KERNEL);
-	if (!dp_video_config)
-		return ERR_PTR(-ENOMEM);
-
-	dp_video_config->h_sync_polarity =
-		of_property_read_bool(dp_node, "hsync-active-high");
-
-	dp_video_config->v_sync_polarity =
-		of_property_read_bool(dp_node, "vsync-active-high");
-
-	dp_video_config->interlaced =
-		of_property_read_bool(dp_node, "interlaced");
-
-	if (of_property_read_u32(dp_node, "samsung,color-space",
-				 &dp_video_config->color_space)) {
-		dev_err(dev, "failed to get color-space\n");
-		return ERR_PTR(-EINVAL);
-	}
-
-	if (of_property_read_u32(dp_node, "samsung,dynamic-range",
-				 &dp_video_config->dynamic_range)) {
-		dev_err(dev, "failed to get dynamic-range\n");
-		return ERR_PTR(-EINVAL);
-	}
-
-	if (of_property_read_u32(dp_node, "samsung,ycbcr-coeff",
-				 &dp_video_config->ycbcr_coeff)) {
-		dev_err(dev, "failed to get ycbcr-coeff\n");
-		return ERR_PTR(-EINVAL);
-	}
-
-	if (of_property_read_u32(dp_node, "samsung,color-depth",
-				 &dp_video_config->color_depth)) {
-		dev_err(dev, "failed to get color-depth\n");
-		return ERR_PTR(-EINVAL);
-	}
+	struct device_node *dp_node = dp->dev->of_node;
+	struct video_info *video_info = &dp->video_info;
 
 	if (of_property_read_u32(dp_node, "samsung,link-rate",
-				 &dp_video_config->link_rate)) {
-		dev_err(dev, "failed to get link-rate\n");
-		return ERR_PTR(-EINVAL);
+				 &video_info->link_rate)) {
+		dev_err(dp->dev, "failed to get link-rate\n");
+		return -EINVAL;
 	}
 
 	if (of_property_read_u32(dp_node, "samsung,lane-count",
-				 &dp_video_config->lane_count)) {
-		dev_err(dev, "failed to get lane-count\n");
-		return ERR_PTR(-EINVAL);
+				 &video_info->lane_count)) {
+		dev_err(dp->dev, "failed to get lane-count\n");
+		return -EINVAL;
 	}
 
-	return dp_video_config;
+	return 0;
 }
 
 int analogix_dp_bind(struct device *dev, struct drm_device *drm_dev,
@@ -1159,9 +1201,9 @@ int analogix_dp_bind(struct device *dev, struct drm_device *drm_dev,
 	 */
 	dp->plat_data = plat_data;
 
-	dp->video_info = analogix_dp_dt_parse_pdata(&pdev->dev);
-	if (IS_ERR(dp->video_info))
-		return PTR_ERR(dp->video_info);
+	ret = analogix_dp_dt_parse_pdata(dp);
+	if (ret)
+		return ret;
 
 	dp->phy = devm_phy_get(dp->dev, "dp");
 	if (IS_ERR(dp->phy)) {
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
index 9a90a18..730486d 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
@@ -120,9 +120,9 @@ enum dp_irq_type {
 struct video_info {
 	char *name;
 
-	bool h_sync_polarity;
-	bool v_sync_polarity;
-	bool interlaced;
+	u32 h_sync_polarity;
+	u32 v_sync_polarity;
+	u32 interlaced;
 
 	enum color_space color_space;
 	enum dynamic_range dynamic_range;
@@ -154,7 +154,7 @@ struct analogix_dp_device {
 	unsigned int		irq;
 	void __iomem		*reg_base;
 
-	struct video_info	*video_info;
+	struct video_info	video_info;
 	struct link_train	link_train;
 	struct work_struct	hotplug_work;
 	struct phy		*phy;
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
index a388c0a..861097a 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
@@ -1084,15 +1084,15 @@ void analogix_dp_set_video_color_format(struct analogix_dp_device *dp)
 	u32 reg;
 
 	/* Configure the input color depth, color space, dynamic range */
-	reg = (dp->video_info->dynamic_range << IN_D_RANGE_SHIFT) |
-		(dp->video_info->color_depth << IN_BPC_SHIFT) |
-		(dp->video_info->color_space << IN_COLOR_F_SHIFT);
+	reg = (dp->video_info.dynamic_range << IN_D_RANGE_SHIFT) |
+		(dp->video_info.color_depth << IN_BPC_SHIFT) |
+		(dp->video_info.color_space << IN_COLOR_F_SHIFT);
 	writel(reg, dp->reg_base + ANALOGIX_DP_VIDEO_CTL_2);
 
 	/* Set Input Color YCbCr Coefficients to ITU601 or ITU709 */
 	reg = readl(dp->reg_base + ANALOGIX_DP_VIDEO_CTL_3);
 	reg &= ~IN_YC_COEFFI_MASK;
-	if (dp->video_info->ycbcr_coeff)
+	if (dp->video_info.ycbcr_coeff)
 		reg |= IN_YC_COEFFI_ITU709;
 	else
 		reg |= IN_YC_COEFFI_ITU601;
@@ -1229,17 +1229,17 @@ void analogix_dp_config_video_slave_mode(struct analogix_dp_device *dp)
 
 	reg = readl(dp->reg_base + ANALOGIX_DP_VIDEO_CTL_10);
 	reg &= ~INTERACE_SCAN_CFG;
-	reg |= (dp->video_info->interlaced << 2);
+	reg |= (dp->video_info.interlaced << 2);
 	writel(reg, dp->reg_base + ANALOGIX_DP_VIDEO_CTL_10);
 
 	reg = readl(dp->reg_base + ANALOGIX_DP_VIDEO_CTL_10);
 	reg &= ~VSYNC_POLARITY_CFG;
-	reg |= (dp->video_info->v_sync_polarity << 1);
+	reg |= (dp->video_info.v_sync_polarity << 1);
 	writel(reg, dp->reg_base + ANALOGIX_DP_VIDEO_CTL_10);
 
 	reg = readl(dp->reg_base + ANALOGIX_DP_VIDEO_CTL_10);
 	reg &= ~HSYNC_POLARITY_CFG;
-	reg |= (dp->video_info->h_sync_polarity << 0);
+	reg |= (dp->video_info.h_sync_polarity << 0);
 	writel(reg, dp->reg_base + ANALOGIX_DP_VIDEO_CTL_10);
 
 	reg = AUDIO_MODE_SPDIF_MODE | VIDEO_MODE_SLAVE_MODE;
-- 
1.9.1
