From: seanpaul@chromium.org (Sean Paul)
Date: Thu,  9 Mar 2017 23:32:48 -0500
Subject: [PATCH 33/41] drm/rockchip: Disable VOP windows when PSR is active
In-Reply-To: <20170310043305.17216-1-seanpaul@chromium.org>
References: <20170310043305.17216-1-seanpaul@chromium.org>
Message-ID: <20170310043305.17216-34-seanpaul@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: zain wang <wzz@rock-chips.com>

We do not have to drive the display when it is in PSR mode, so we can
save some power by disabling active VOP windows, until a next PSR flush
turns them back on.

Cc: Kristian H. Kristensen <hoegsberg@chromium.org>
Signed-off-by: zain wang <wzz@rock-chips.com>
Signed-off-by: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
---
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c | 34 +++++++++++++++++--------
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h     |  1 +
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c     | 31 ++++++++++++++++++++++
 3 files changed, 55 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index 0614d32c5435..de23cc6fd05d 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -91,19 +91,31 @@ static int analogix_dp_psr_set(struct drm_encoder *encoder, bool enabled)
 	if (!crtc)
 		return -EINVAL;
 
-	vact_end = crtc->mode.vtotal - crtc->mode.vsync_start + crtc->mode.vdisplay;
+	if (enabled) {
+		vact_end = crtc->mode.vtotal - crtc->mode.vsync_start +
+			crtc->mode.vdisplay;
+		ret = rockchip_drm_wait_line_flag(dp->encoder.crtc, vact_end,
+						PSR_WAIT_LINE_FLAG_TIMEOUT_MS);
+		if (ret) {
+			dev_err(dp->dev, "line flag interrupt did not arrive\n");
+			return -ETIMEDOUT;
+		}
 
-	ret = rockchip_drm_wait_line_flag(dp->encoder.crtc, vact_end,
-					  PSR_WAIT_LINE_FLAG_TIMEOUT_MS);
-	if (ret) {
-		dev_err(dp->dev, "line flag interrupt did not arrive\n");
-		return -ETIMEDOUT;
+		ret = analogix_dp_enable_psr(dp->dev);
+		if (ret) {
+			dev_err(dp->dev, "failed to enable psr %d\n", ret);
+			return ret;
+		}
+		rockchip_drm_set_win_enabled(crtc, false);
+	} else {
+		rockchip_drm_set_win_enabled(crtc, true);
+		ret = analogix_dp_disable_psr(dp->dev);
+		if (ret) {
+			dev_err(dp->dev, "failed to disable psr %d\n", ret);
+			return ret;
+		}
 	}
-
-	if (enabled)
-		return analogix_dp_enable_psr(dp->dev);
-	else
-		return analogix_dp_disable_psr(dp->dev);
+	return 0;
 }
 
 static int rockchip_dp_pre_init(struct rockchip_dp_device *dp)
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
index a966d1d37378..be4ad9b670cf 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
@@ -65,5 +65,6 @@ void rockchip_drm_dma_detach_device(struct drm_device *drm_dev,
 				    struct device *dev);
 int rockchip_drm_wait_line_flag(struct drm_crtc *crtc, unsigned int line_num,
 				unsigned int mstimeout);
+void rockchip_drm_set_win_enabled(struct drm_crtc *ctrc, bool enabled);
 
 #endif /* _ROCKCHIP_DRM_DRV_H_ */
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 879efc3a6c67..e90a32ee5a36 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -89,6 +89,9 @@
 #define VOP_WIN_GET_YRGBADDR(vop, win) \
 		vop_readl(vop, win->base + win->phy->yrgb_mst.offset)
 
+#define VOP_WIN_TO_INDEX(vop_win) \
+	((vop_win) - (vop_win)->vop->win)
+
 #define to_vop(x) container_of(x, struct vop, crtc)
 #define to_vop_win(x) container_of(x, struct vop_win, base)
 
@@ -108,6 +111,8 @@ struct vop {
 	struct drm_device *drm_dev;
 	bool is_enabled;
 
+	unsigned int win_enabled;
+
 	struct completion dsp_hold_completion;
 
 	/* protected by dev->event_lock */
@@ -562,6 +567,27 @@ static int vop_enable(struct drm_crtc *crtc)
 	return ret;
 }
 
+void rockchip_drm_set_win_enabled(struct drm_crtc *crtc, bool enabled)
+{
+	struct vop *vop = to_vop(crtc);
+	int i;
+
+	spin_lock(&vop->reg_lock);
+
+	for (i = 0; i < vop->data->win_size; i++) {
+		struct vop_win *vop_win = &vop->win[i];
+		const struct vop_win_data *win = vop_win->data;
+
+		VOP_WIN_SET(vop, win, enable,
+			    enabled && (vop->win_enabled & BIT(i)));
+	}
+
+	vop_cfg_done(vop);
+
+	spin_unlock(&vop->reg_lock);
+}
+EXPORT_SYMBOL(rockchip_drm_set_win_enabled);
+
 static void vop_crtc_disable(struct drm_crtc *crtc)
 {
 	struct vop *vop = to_vop(crtc);
@@ -581,6 +607,7 @@ static void vop_crtc_disable(struct drm_crtc *crtc)
 
 		spin_lock(&vop->reg_lock);
 		VOP_WIN_SET(vop, win, enable, 0);
+		vop->win_enabled &= ~BIT(i);
 		spin_unlock(&vop->reg_lock);
 	}
 
@@ -700,6 +727,7 @@ static void vop_plane_atomic_disable(struct drm_plane *plane,
 	spin_lock(&vop->reg_lock);
 
 	VOP_WIN_SET(vop, win, enable, 0);
+	vop->win_enabled &= ~BIT(VOP_WIN_TO_INDEX(vop_win));
 
 	spin_unlock(&vop->reg_lock);
 }
@@ -807,6 +835,8 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 	}
 
 	VOP_WIN_SET(vop, win, enable, 1);
+	vop->win_enabled |= BIT(VOP_WIN_TO_INDEX(vop_win));
+
 	spin_unlock(&vop->reg_lock);
 }
 
@@ -1443,6 +1473,7 @@ static int vop_initial(struct vop *vop)
 		const struct vop_win_data *win = &vop_data->win[i];
 
 		VOP_WIN_SET(vop, win, enable, 0);
+		vop->win_enabled &= ~BIT(i);
 	}
 
 	vop_cfg_done(vop);
-- 
2.12.0.246.ga2ecc84866-goog
