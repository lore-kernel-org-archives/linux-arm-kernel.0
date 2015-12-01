From: mark.yao@rock-chips.com (Mark Yao)
Date: Tue,  1 Dec 2015 11:30:21 +0800
Subject: [RFC PATCH 6/9] drm/rockchip: direct config connecter gate and
 out_mode
In-Reply-To: <1448940391-23333-1-git-send-email-mark.yao@rock-chips.com>
References: <1448940391-23333-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1448940621-23447-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both connecter gate and out_mode are not conflict with mode set
configure. Direct setting connecter gate and out_mode, that allow
connector do rockchip_drm_crtc_mode_config after mode set.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |   41 ++++++++++++---------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 6317dea..c65b454 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -90,9 +90,6 @@ struct vop {
 	struct drm_device *drm_dev;
 	bool is_enabled;
 
-	int connector_type;
-	int connector_out_mode;
-
 	/* mutex vsync_ work */
 	struct mutex vsync_mutex;
 	bool vsync_work_pending;
@@ -1029,8 +1026,24 @@ int rockchip_drm_crtc_mode_config(struct drm_crtc *crtc,
 {
 	struct vop *vop = to_vop(crtc);
 
-	vop->connector_type = connector_type;
-	vop->connector_out_mode = out_mode;
+	if (WARN_ON(!vop->is_enabled))
+		return -EINVAL;
+
+	switch (connector_type) {
+	case DRM_MODE_CONNECTOR_LVDS:
+		VOP_CTRL_SET(vop, rgb_en, 1);
+		break;
+	case DRM_MODE_CONNECTOR_eDP:
+		VOP_CTRL_SET(vop, edp_en, 1);
+		break;
+	case DRM_MODE_CONNECTOR_HDMIA:
+		VOP_CTRL_SET(vop, hdmi_en, 1);
+		break;
+	default:
+		DRM_ERROR("unsupport connector_type[%d]\n", connector_type);
+		return -EINVAL;
+	};
+	VOP_CTRL_SET(vop, out_mode, out_mode);
 
 	return 0;
 }
@@ -1132,24 +1145,6 @@ static void vop_crtc_mode_set_nofb(struct drm_crtc *crtc)
 
 		vop_dsp_hold_valid_irq_disable(vop);
 	}
-
-	switch (vop->connector_type) {
-	case DRM_MODE_CONNECTOR_LVDS:
-		VOP_CTRL_SET(vop, rgb_en, 1);
-		break;
-	case DRM_MODE_CONNECTOR_eDP:
-		VOP_CTRL_SET(vop, edp_en, 1);
-		break;
-	case DRM_MODE_CONNECTOR_HDMIA:
-		VOP_CTRL_SET(vop, hdmi_en, 1);
-		break;
-	default:
-		DRM_ERROR("unsupport connector_type[%d]\n",
-			  vop->connector_type);
-		goto out;
-	};
-	VOP_CTRL_SET(vop, out_mode, vop->connector_out_mode);
-
 	val = 0x8;
 	val |= (adjusted_mode->flags & DRM_MODE_FLAG_NHSYNC) ? 0 : 1;
 	val |= (adjusted_mode->flags & DRM_MODE_FLAG_NVSYNC) ? 0 : (1 << 1);
-- 
1.7.9.5
