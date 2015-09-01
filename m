From: ykk@rock-chips.com (Yakir Yang)
Date: Tue,  1 Sep 2015 14:01:48 +0800
Subject: [PATCH v4 09/16] drm: rockchip: add bpc and color mode setting
In-Reply-To: <1441086371-24838-1-git-send-email-ykk@rock-chips.com>
References: <1441086371-24838-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1441087308-25455-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Yao <yzq@rock-chips.com>

Add bpc and color mode setting in rockchip_drm_vop driver, so
connector could try to use the edid drm_display_info to config
vop output mode.

Signed-off-by: Mark Yao <yzq@rock-chips.com>
Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c | 46 +++++++++++++++++++------
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c     |  2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h     |  2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c     | 33 ++++++++++++++++--
 4 files changed, 68 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index cebff9e..efea045 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -11,11 +11,6 @@
  * Free Software Foundation; either version 2 of the License, or (at your
  * option) any later version.
  */
-#include <drm/drmP.h>
-#include <drm/drm_crtc_helper.h>
-#include <drm/drm_panel.h>
-#include <drm/drm_of.h>
-#include <drm/drm_dp_helper.h>
 
 #include <linux/component.h>
 #include <linux/mfd/syscon.h>
@@ -27,6 +22,13 @@
 #include <video/of_videomode.h>
 #include <video/videomode.h>
 
+#include <drm/drmP.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_panel.h>
+#include <drm/drm_of.h>
+#include <drm/drm_dp_helper.h>
+
 #include <drm/bridge/analogix_dp.h>
 
 #include "rockchip_drm_drv.h"
@@ -125,20 +127,44 @@ static void rockchip_dp_drm_encoder_mode_set(struct drm_encoder *encoder,
 	/* do nothing */
 }
 
+static drm_connector *rockchip_dp_get_connector(struct rockchip_dp_device *dp)
+{
+	struct drm_connector *connector;
+	struct drm_device *drm_dev = dp->drm_dev;
+
+	drm_for_each_connector(connector, drm_dev) {
+		if (connector->encoder != &dp->encoder)
+			return connector;
+	}
+
+	return NULL;
+}
+
 static void rockchip_dp_drm_encoder_prepare(struct drm_encoder *encoder)
 {
 	struct rockchip_dp_device *dp = encoder_to_dp(encoder);
+	struct drm_connector *connector;
+	int ret = 0;
 	u32 val;
-	int ret;
 
-	ret = rockchip_drm_crtc_mode_config(encoder->crtc,
-					    DRM_MODE_CONNECTOR_eDP,
-					    ROCKCHIP_OUT_MODE_AAAA);
-	if (ret < 0) {
+	connector = rockchip_dp_get_connector(dp);
+	if (!connector) {
+		DRM_ERROR("Failed to get connector by encoder[%p]\n", encoder);
+		return;
+	}
+
+	if (connector->display_info.color_formats | DRM_COLOR_FORMAT_RGB444)
+		ret = rockchip_drm_crtc_mode_config(
+			encoder->crtc, DRM_MODE_CONNECTOR_eDP,
+			connector->display_info.bpc, DRM_COLOR_FORMAT_RGB444);
+	if (!ret) {
 		dev_err(dp->dev, "Could not set crtc mode config: %d.\n", ret);
 		return;
 	}
 
+	connector->display_info.bpc = ret;
+	connector->display_info.color_formats = DRM_COLOR_FORMAT_RGB444;
+
 	ret = rockchip_drm_encoder_get_mux_id(dp->dev->of_node, encoder);
 	if (ret < 0)
 		return;
diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 80d6fc8..428a3c1 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -215,7 +215,7 @@ static void dw_hdmi_rockchip_encoder_commit(struct drm_encoder *encoder)
 static void dw_hdmi_rockchip_encoder_prepare(struct drm_encoder *encoder)
 {
 	rockchip_drm_crtc_mode_config(encoder->crtc, DRM_MODE_CONNECTOR_HDMIA,
-				      ROCKCHIP_OUT_MODE_AAAA);
+				      10, DRM_COLOR_FORMAT_RGB444);
 }
 
 static struct drm_encoder_helper_funcs dw_hdmi_rockchip_encoder_helper_funcs = {
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
index dc4e5f0..ef1d7fb 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
@@ -59,7 +59,7 @@ void rockchip_unregister_crtc_funcs(struct drm_device *dev, int pipe);
 int rockchip_drm_encoder_get_mux_id(struct device_node *node,
 				    struct drm_encoder *encoder);
 int rockchip_drm_crtc_mode_config(struct drm_crtc *crtc, int connector_type,
-				  int out_mode);
+				  int bpc, int color);
 int rockchip_drm_dma_attach_device(struct drm_device *drm_dev,
 				   struct device *dev);
 void rockchip_drm_dma_detach_device(struct drm_device *drm_dev,
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 34b78e7..5d7f9b6 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -811,14 +811,41 @@ static const struct drm_plane_funcs vop_plane_funcs = {
 
 int rockchip_drm_crtc_mode_config(struct drm_crtc *crtc,
 				  int connector_type,
-				  int out_mode)
+				  int bpc, int color)
 {
 	struct vop *vop = to_vop(crtc);
-
 	vop->connector_type = connector_type;
 	vop->connector_out_mode = out_mode;
 
-	return 0;
+	/*
+	 * RK3288 vop only support RGB Color output.
+	 */
+	if (color != DRM_COLOR_FORMAT_RGB444) {
+		DRM_ERROR("Only support output RGB444, not support%d\n",
+			  color);
+		return -EINVAL;
+	}
+
+	/*
+	 * Fixme: I don't know how to describe the ROCKCHIP_OUT_MODE_P565's
+	 * bpc, 5 or 6?
+	 *
+	 */
+	if (bpc >= 10) {
+		bpc = 10;
+		vop->connector_out_mode = ROCKCHIP_OUT_MODE_AAAA;
+	} else if (bpc >= 8) {
+		bpc = 8;
+		vop->connector_out_mode = ROCKCHIP_OUT_MODE_P888;
+	} else if (bpc >= 6) {
+		bpc = 6;
+		vop->connector_out_mode = ROCKCHIP_OUT_MODE_P888;
+	} else {
+		DRM_ERROR("unsupport bpc %d\n", bpc);
+		return -EINVAL;
+	}
+
+	return bpc;
 }
 EXPORT_SYMBOL_GPL(rockchip_drm_crtc_mode_config);
 
-- 
2.1.2
