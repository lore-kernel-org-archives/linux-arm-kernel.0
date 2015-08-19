From: ykk@rock-chips.com (Yakir Yang)
Date: Wed, 19 Aug 2015 09:50:13 -0500
Subject: [PATCH v3 04/14] drm: bridge/analogix_dp: dynamic parse sync_pol &
 interlace & colorimetry
In-Reply-To: <1439995728-18046-1-git-send-email-ykk@rock-chips.com>
References: <1439995728-18046-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1439995813-18261-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both hsync/vsync polarity and interlace mode can be parsed from
drm display mode, and dynamic_range and ycbcr_coeff can be judge
by the video code.

But presumably Exynos still relaies on the DT properties, so take
good use of mode_fixup() in to achieve the compatibility hacks.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
Changes in v3:
- Take Thierry Reding suggest, dynamic parse video timing info from
  struct drm_display_mode and struct drm_display_info.

Changes in v2: None

 drivers/gpu/drm/bridge/analogix_dp_core.c   | 50 ++++++++++++----------
 drivers/gpu/drm/exynos/analogix_dp-exynos.c | 65 ++++++++++++++++++++++++++---
 2 files changed, 89 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix_dp_core.c
index 6c15e20..480cc13 100644
--- a/drivers/gpu/drm/bridge/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix_dp_core.c
@@ -1110,11 +1110,40 @@ static void analogix_dp_bridge_disable(struct drm_bridge *bridge)
 	dp->dpms_mode = DRM_MODE_DPMS_OFF;
 }
 
+static void analogix_dp_bridge_mode_set(struct drm_bridge *bridge,
+					struct drm_display_mode *orig_mode,
+					struct drm_display_mode *mode)
+{
+	struct analogix_dp_device *dp = bridge->driver_private;
+	struct video_info *video_info = dp->video_info;
+	int vic;
+
+	/* interlaces & hsync pol & vsync pol */
+	video_info->interlaced = !!(mode->flags & DRM_MODE_FLAG_INTERLACE);
+	video_info->v_sync_polarity = !!(mode->flags & DRM_MODE_FLAG_NVSYNC);
+	video_info->h_sync_polarity = !!(mode->flags & DRM_MODE_FLAG_NHSYNC);
+
+	/* dynamic_range & colorimetry */
+	vic = drm_match_cea_mode(mode);
+	if ((vic == 6) || (vic == 7) || (vic == 21) || (vic == 22) ||
+	    (vic == 2) || (vic == 3) || (vic == 17) || (vic == 18)) {
+		video_info->dynamic_range = CEA;
+		video_info->ycbcr_coeff = COLOR_YCBCR601;
+	} else if (vic) {
+		video_info->dynamic_range = CEA;
+		video_info->ycbcr_coeff = COLOR_YCBCR709;
+	} else {
+		video_info->dynamic_range = VESA;
+		video_info->ycbcr_coeff = COLOR_YCBCR709;
+	}
+}
+
 static const struct drm_bridge_funcs analogix_dp_bridge_funcs = {
 	.enable = analogix_dp_bridge_enable,
 	.disable = analogix_dp_bridge_disable,
 	.pre_enable = analogix_dp_bridge_nop,
 	.post_disable = analogix_dp_bridge_nop,
+	.mode_set = analogix_dp_bridge_mode_set,
 	.attach = analogix_dp_bridge_attach,
 };
 
@@ -1156,33 +1185,12 @@ static struct video_info *analogix_dp_dt_parse_pdata(struct device *dev)
 	if (!dp_video_config)
 		return ERR_PTR(-ENOMEM);
 
-	dp_video_config->h_sync_polarity =
-		of_property_read_bool(dp_node, "hsync-active-high");
-
-	dp_video_config->v_sync_polarity =
-		of_property_read_bool(dp_node, "vsync-active-high");
-
-	dp_video_config->interlaced =
-		of_property_read_bool(dp_node, "interlaced");
-
 	if (of_property_read_u32(dp_node, "analogix,color-space",
 				 &dp_video_config->color_space)) {
 		dev_err(dev, "failed to get color-space\n");
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (of_property_read_u32(dp_node, "analogix,dynamic-range",
-				 &dp_video_config->dynamic_range)) {
-		dev_err(dev, "failed to get dynamic-range\n");
-		return ERR_PTR(-EINVAL);
-	}
-
-	if (of_property_read_u32(dp_node, "analogix,ycbcr-coeff",
-				 &dp_video_config->ycbcr_coeff)) {
-		dev_err(dev, "failed to get ycbcr-coeff\n");
-		return ERR_PTR(-EINVAL);
-	}
-
 	if (of_property_read_u32(dp_node, "analogix,color-depth",
 				 &dp_video_config->color_depth)) {
 		dev_err(dev, "failed to get color-depth\n");
diff --git a/drivers/gpu/drm/exynos/analogix_dp-exynos.c b/drivers/gpu/drm/exynos/analogix_dp-exynos.c
index d5631c2..17da2c8 100644
--- a/drivers/gpu/drm/exynos/analogix_dp-exynos.c
+++ b/drivers/gpu/drm/exynos/analogix_dp-exynos.c
@@ -26,11 +26,17 @@
 #include <drm/exynos_drm.h>
 #include "exynos_drm_drv.h"
 
-#define plat_data_to_dp(pd) \
-		container_of(pd, struct exynos_dp_device, plat_data)
+#define to_dp(nm)	container_of(nm, struct exynos_dp_device, nm)
+
+struct video_info {
+	bool h_sync_polarity;
+	bool v_sync_polarity;
+	bool interlaced;
+};
 
 struct exynos_dp_device {
 	struct exynos_drm_display  display;
+	struct video_info          video_info;
 	struct drm_bridge          *ptn_bridge;
 	struct drm_device          *drm_dev;
 	struct device              *dev;
@@ -42,7 +48,7 @@ struct exynos_dp_device {
 int exynos_dp_crtc_clock_enable(struct analogix_dp_plat_data *plat_data,
 				bool enable)
 {
-	struct exynos_dp_device *dp = plat_data_to_dp(plat_data);
+	struct exynos_dp_device *dp = to_dp(plat_data);
 	struct drm_encoder *encoder = dp->display.encoder;
 	struct exynos_drm_crtc *crtc;
 
@@ -69,7 +75,7 @@ static int exynos_dp_poweroff(struct analogix_dp_plat_data *plat_data)
 static int exynos_dp_get_modes(struct analogix_dp_plat_data *plat_data,
 			       struct drm_connector *connector)
 {
-	struct exynos_dp_device *dp = plat_data_to_dp(plat_data);
+	struct exynos_dp_device *dp = to_dp(plat_data);
 	struct drm_display_mode *mode;
 
 	if (dp->plat_data.panel)
@@ -97,7 +103,7 @@ static int exynos_dp_get_modes(struct analogix_dp_plat_data *plat_data,
 static int exynos_dp_bridge_attach(struct analogix_dp_plat_data *plat_data,
 				   struct drm_bridge *bridge)
 {
-	struct exynos_dp_device *dp = plat_data_to_dp(plat_data);
+	struct exynos_dp_device *dp = to_dp(plat_data);
 	struct drm_encoder *encoder = dp->display.encoder;
 	int ret;
 
@@ -116,6 +122,34 @@ static int exynos_dp_bridge_attach(struct analogix_dp_plat_data *plat_data,
 	return 0;
 }
 
+static void exynos_dp_mode_fixup(struct exynos_drm_display *display,
+				 struct drm_connector *connector,
+				 const struct drm_display_mode *mode,
+				 struct drm_display_mode *adjusted_mode)
+{
+	struct exynos_dp_device *dp = to_dp(display);
+	int flags = adjusted_mode->flags;
+
+	flags &= ~(DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_NHSYNC |
+		   DRM_MODE_FLAG_PVSYNC | DRM_MODE_FLAG_NVSYNC |
+		   DRM_MODE_FLAG_INTERLACE);
+
+	if (dp->video_info.h_sync_polarity)
+		flags |= DRM_MODE_FLAG_PHSYNC;
+	else
+		flags |= DRM_MODE_FLAG_NHSYNC;
+
+	if (dp->video_info.v_sync_polarity)
+		flags |= DRM_MODE_FLAG_PVSYNC;
+	else
+		flags |= DRM_MODE_FLAG_NVSYNC;
+
+	if (dp->video_info.interlaced)
+		flags |= DRM_MODE_FLAG_INTERLACE;
+
+	adjusted_mode->flags = flags;
+}
+
 static void exynos_dp_dpms(struct exynos_drm_display *display, int mode)
 {
 	/* do nothing */
@@ -137,6 +171,7 @@ static struct exynos_drm_display_ops exynos_dp_display_ops = {
 	.create_connector = exynos_dp_create_connector,
 	.dpms = exynos_dp_dpms,
 	.commit = exynos_dp_commit,
+	.mode_fixup = exynos_dp_mode_fixup,
 };
 
 static int exynos_dp_dt_parse_panel(struct exynos_dp_device *dp)
@@ -153,6 +188,22 @@ static int exynos_dp_dt_parse_panel(struct exynos_dp_device *dp)
 	return 0;
 }
 
+static int exynos_dp_dt_parse_video_info(struct exynos_dp_device *dp)
+{
+	struct device_node *dp_node = dp->dev->of_node;
+
+	dp->video_info.h_sync_polarity =
+		of_property_read_bool(dp_node, "hsync-active-high");
+
+	dp->video_info.v_sync_polarity =
+		of_property_read_bool(dp_node, "vsync-active-high");
+
+	dp->video_info.interlaced =
+		of_property_read_bool(dp_node, "interlaced");
+
+	return 0;
+}
+
 static int exynos_dp_bind(struct device *dev, struct device *master, void *data)
 {
 	struct exynos_dp_device *dp = dev_get_drvdata(dev);
@@ -180,6 +231,10 @@ static int exynos_dp_bind(struct device *dev, struct device *master, void *data)
 			return ret;
 	}
 
+	ret = exynos_dp_dt_parse_video_info(dp);
+	if (ret)
+		return ret;
+
 	ret = exynos_drm_create_enc_conn(dp->drm_dev, &dp->display);
 	if (ret) {
 		DRM_ERROR("exynos dp create enc_conn failed\n");
-- 
1.9.1
