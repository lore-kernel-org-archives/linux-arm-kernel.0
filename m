From: enric.balletbo@collabora.com (Enric Balletbo i Serra)
Date: Mon,  6 Aug 2018 17:53:39 +0200
Subject: [PATCH] drm/rockchip: update cursors asynchronously through atomic.
Message-ID: <20180806155339.9473-1-enric.balletbo@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support to async updates of cursors by using the new atomic
interface for that.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
Hi,

This first version is slightly different from the RFC, note that I did
not maintain the Sean reviewed tag for that reason. With this version I
don't touch the atomic_update function and all is implemented in the
async_check/update functions. See the changelog for a list of changes.

The patch was tested on a Samsung Chromebook Plus in two ways.

 1. Running all igt kms_cursor_legacy and kms_atomic at plane_cursor_legacy
    tests and see that there is no regression after the patch.

 2. Running weston using the atomic API.

Best regards,
  Enric

Changes in v1:
- Rebased on top of drm-misc
- In async_check call drm_atomic_helper_check_plane_state to check that
  the desired plane is valid and update various bits of derived state
  (clipped coordinates etc.)
- In async_check allow to configure new scaling in the fast path.
- In async_update force to flush all registered PSR encoders.
- In async_update call atomic_update directly.
- In async_update call vop_cfg_done needed to set the vop registers and take effect.

 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 53 +++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index e9f91278137d..dab70056ee73 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -811,10 +811,63 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 	spin_unlock(&vop->reg_lock);
 }
 
+static int vop_plane_atomic_async_check(struct drm_plane *plane,
+					struct drm_plane_state *state)
+{
+	struct vop_win *vop_win = to_vop_win(plane);
+	const struct vop_win_data *win = vop_win->data;
+	int min_scale = win->phy->scl ? FRAC_16_16(1, 8) :
+					DRM_PLANE_HELPER_NO_SCALING;
+	int max_scale = win->phy->scl ? FRAC_16_16(8, 1) :
+					DRM_PLANE_HELPER_NO_SCALING;
+	int ret;
+
+	if (plane != state->crtc->cursor)
+		return -EINVAL;
+
+	if (!plane->state)
+		return -EINVAL;
+
+	if (!plane->state->fb ||
+	    plane->state->fb != state->fb)
+		return -EINVAL;
+
+	ret = drm_atomic_helper_check_plane_state(plane->state,
+						  plane->crtc->state,
+						  min_scale, max_scale,
+						  true, true);
+	return ret;
+}
+
+static void vop_plane_atomic_async_update(struct drm_plane *plane,
+					  struct drm_plane_state *new_state)
+{
+	struct vop *vop = to_vop(plane->state->crtc);
+
+	plane->state->crtc_x = new_state->crtc_x;
+	plane->state->crtc_y = new_state->crtc_y;
+	plane->state->crtc_h = new_state->crtc_h;
+	plane->state->crtc_w = new_state->crtc_w;
+	plane->state->src_x = new_state->src_x;
+	plane->state->src_y = new_state->src_y;
+	plane->state->src_h = new_state->src_h;
+	plane->state->src_w = new_state->src_w;
+
+	if (vop->is_enabled) {
+		rockchip_drm_psr_flush_all(plane->dev);
+		vop_plane_atomic_update(plane, plane->state);
+		spin_lock(&vop->reg_lock);
+		vop_cfg_done(vop);
+		spin_unlock(&vop->reg_lock);
+	}
+}
+
 static const struct drm_plane_helper_funcs plane_helper_funcs = {
 	.atomic_check = vop_plane_atomic_check,
 	.atomic_update = vop_plane_atomic_update,
 	.atomic_disable = vop_plane_atomic_disable,
+	.atomic_async_check = vop_plane_atomic_async_check,
+	.atomic_async_update = vop_plane_atomic_async_update,
 };
 
 static const struct drm_plane_funcs vop_plane_funcs = {
-- 
2.18.0
