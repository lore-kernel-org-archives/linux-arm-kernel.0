From: john@metanate.com (John Keeping)
Date: Mon, 22 Feb 2016 12:22:59 +0000
Subject: [PATCH] drm/rockchip: vop: fix crtc size in plane check
Message-ID: <1456143779-16208-1-git-send-email-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the geometry of a crtc is changing in an atomic update then we much
validate the plane size against the new state of the crtc and not the
current size, otherwise if the crtc size is increasing the plane will be
cropped at the previous size and will not fill the screen.

Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index fd37054..82d55bd 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -549,6 +549,7 @@ static int vop_plane_atomic_check(struct drm_plane *plane,
 			   struct drm_plane_state *state)
 {
 	struct drm_crtc *crtc = state->crtc;
+	struct drm_crtc_state *crtc_state;
 	struct drm_framebuffer *fb = state->fb;
 	struct vop_win *vop_win = to_vop_win(plane);
 	struct vop_plane_state *vop_plane_state = to_vop_plane_state(state);
@@ -563,12 +564,13 @@ static int vop_plane_atomic_check(struct drm_plane *plane,
 	int max_scale = win->phy->scl ? FRAC_16_16(8, 1) :
 					DRM_PLANE_HELPER_NO_SCALING;
 
-	crtc = crtc ? crtc : plane->state->crtc;
-	/*
-	 * Both crtc or plane->state->crtc can be null.
-	 */
 	if (!crtc || !fb)
 		goto out_disable;
+
+	crtc_state = drm_atomic_get_existing_crtc_state(state->state, crtc);
+	if (WARN_ON(!crtc_state))
+		return -EINVAL;
+
 	src->x1 = state->src_x;
 	src->y1 = state->src_y;
 	src->x2 = state->src_x + state->src_w;
@@ -580,8 +582,8 @@ static int vop_plane_atomic_check(struct drm_plane *plane,
 
 	clip.x1 = 0;
 	clip.y1 = 0;
-	clip.x2 = crtc->mode.hdisplay;
-	clip.y2 = crtc->mode.vdisplay;
+	clip.x2 = crtc_state->adjusted_mode.hdisplay;
+	clip.y2 = crtc_state->adjusted_mode.vdisplay;
 
 	ret = drm_plane_helper_check_update(plane, crtc, state->fb,
 					    src, dest, &clip,
-- 
2.7.0.226.gfe986fe
