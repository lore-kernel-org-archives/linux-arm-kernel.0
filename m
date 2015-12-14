From: mark.yao@rock-chips.com (Mark Yao)
Date: Mon, 14 Dec 2015 16:36:55 +0800
Subject: [PATCH v2 6/8] drm/rockchip: direct config connecter gate and out_mode
In-Reply-To: <1450081931-9709-1-git-send-email-mark.yao@rock-chips.com>
References: <1450081931-9709-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1450082215-10377-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both connecter gate and out_mode are not conflict with mode set
configure. Direct setting connecter gate and out_mode, that allow
connector do rockchip_drm_crtc_mode_config after mode set.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---

Changes in v2: None

 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |   40 ++++++++++++---------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 40cc8ed..43573be 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -89,9 +89,6 @@ struct vop {
 	struct drm_device *drm_dev;
 	bool is_enabled;
 
-	int connector_type;
-	int connector_out_mode;
-
 	/* mutex vsync_ work */
 	struct mutex vsync_mutex;
 	bool vsync_work_pending;
@@ -1026,8 +1023,24 @@ int rockchip_drm_crtc_mode_config(struct drm_crtc *crtc,
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
@@ -1131,23 +1144,6 @@ static void vop_crtc_enable(struct drm_crtc *crtc)
 		vop_dsp_hold_valid_irq_disable(vop);
 	}
 
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
