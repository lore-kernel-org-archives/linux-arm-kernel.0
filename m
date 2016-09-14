From: tfiga@chromium.org (Tomasz Figa)
Date: Wed, 14 Sep 2016 21:55:01 +0900
Subject: [PATCH 8/8] drm/rockchip: Kill vop_plane_state
In-Reply-To: <1473857701-9250-1-git-send-email-tfiga@chromium.org>
References: <1473857701-9250-1-git-send-email-tfiga@chromium.org>
Message-ID: <1473857701-9250-9-git-send-email-tfiga@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After changes introduced by last patches, there is no useful data stored
in vop_plane_state struct.  Let's remove it and make the driver use
generic plane state alone.

Signed-off-by: Tomasz Figa <tfiga@chromium.org>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 94 +++++------------------------
 1 file changed, 15 insertions(+), 79 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index cacdffb..57650c9 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -88,19 +88,11 @@
 
 #define to_vop(x) container_of(x, struct vop, crtc)
 #define to_vop_win(x) container_of(x, struct vop_win, base)
-#define to_vop_plane_state(x) container_of(x, struct vop_plane_state, base)
 
 enum vop_pending {
 	VOP_PENDING_FB_UNREF,
 };
 
-struct vop_plane_state {
-	struct drm_plane_state base;
-	int format;
-	dma_addr_t yrgb_mst;
-	bool enable;
-};
-
 struct vop_win {
 	struct drm_plane base;
 	const struct vop_win_data *data;
@@ -651,7 +643,6 @@ static int vop_plane_atomic_check(struct drm_plane *plane,
 	struct drm_crtc_state *crtc_state;
 	struct drm_framebuffer *fb = state->fb;
 	struct vop_win *vop_win = to_vop_win(plane);
-	struct vop_plane_state *vop_plane_state = to_vop_plane_state(state);
 	const struct vop_win_data *win = vop_win->data;
 	int ret;
 	struct drm_rect clip;
@@ -661,7 +652,7 @@ static int vop_plane_atomic_check(struct drm_plane *plane,
 					DRM_PLANE_HELPER_NO_SCALING;
 
 	if (!crtc || !fb)
-		goto out_disable;
+		return 0;
 
 	crtc_state = drm_atomic_get_existing_crtc_state(state->state, crtc);
 	if (WARN_ON(!crtc_state))
@@ -679,11 +670,11 @@ static int vop_plane_atomic_check(struct drm_plane *plane,
 		return ret;
 
 	if (!state->visible)
-		goto out_disable;
+		return 0;
 
-	vop_plane_state->format = vop_convert_format(fb->pixel_format);
-	if (vop_plane_state->format < 0)
-		return vop_plane_state->format;
+	ret = vop_convert_format(fb->pixel_format);
+	if (ret < 0)
+		return ret;
 
 	/*
 	 * Src.x1 can be odd when do clip, but yuv plane start point
@@ -692,19 +683,12 @@ static int vop_plane_atomic_check(struct drm_plane *plane,
 	if (is_yuv_support(fb->pixel_format) && ((state->src.x1 >> 16) % 2))
 		return -EINVAL;
 
-	vop_plane_state->enable = true;
-
-	return 0;
-
-out_disable:
-	vop_plane_state->enable = false;
 	return 0;
 }
 
 static void vop_plane_atomic_disable(struct drm_plane *plane,
 				     struct drm_plane_state *old_state)
 {
-	struct vop_plane_state *vop_plane_state = to_vop_plane_state(old_state);
 	struct vop_win *vop_win = to_vop_win(plane);
 	const struct vop_win_data *win = vop_win->data;
 	struct vop *vop = to_vop(old_state->crtc);
@@ -717,8 +701,6 @@ static void vop_plane_atomic_disable(struct drm_plane *plane,
 	VOP_WIN_SET(vop, win, enable, 0);
 
 	spin_unlock(&vop->reg_lock);
-
-	vop_plane_state->enable = false;
 }
 
 static void vop_plane_atomic_update(struct drm_plane *plane,
@@ -727,7 +709,6 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 	struct drm_plane_state *state = plane->state;
 	struct drm_crtc *crtc = state->crtc;
 	struct vop_win *vop_win = to_vop_win(plane);
-	struct vop_plane_state *vop_plane_state = to_vop_plane_state(state);
 	const struct vop_win_data *win = vop_win->data;
 	struct vop *vop = to_vop(state->crtc);
 	struct drm_framebuffer *fb = state->fb;
@@ -742,6 +723,7 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 	dma_addr_t dma_addr;
 	uint32_t val;
 	bool rb_swap;
+	int format;
 
 	/*
 	 * can't update plane when vop is disabled.
@@ -752,7 +734,7 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 	if (WARN_ON(!vop->is_enabled))
 		return;
 
-	if (!vop_plane_state->enable) {
+	if (!state->visible) {
 		vop_plane_atomic_disable(plane, old_state);
 		return;
 	}
@@ -773,13 +755,15 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 
 	offset = (src->x1 >> 16) * drm_format_plane_cpp(fb->pixel_format, 0);
 	offset += (src->y1 >> 16) * fb->pitches[0];
-	vop_plane_state->yrgb_mst = rk_obj->dma_addr + offset + fb->offsets[0];
+	dma_addr = rk_obj->dma_addr + offset + fb->offsets[0];
+
+	format = vop_convert_format(fb->pixel_format);
 
 	spin_lock(&vop->reg_lock);
 
-	VOP_WIN_SET(vop, win, format, vop_plane_state->format);
+	VOP_WIN_SET(vop, win, format, format);
 	VOP_WIN_SET(vop, win, yrgb_vir, fb->pitches[0] >> 2);
-	VOP_WIN_SET(vop, win, yrgb_mst, vop_plane_state->yrgb_mst);
+	VOP_WIN_SET(vop, win, yrgb_mst, dma_addr);
 	if (is_yuv_support(fb->pixel_format)) {
 		int hsub = drm_format_horz_chroma_subsampling(fb->pixel_format);
 		int vsub = drm_format_vert_chroma_subsampling(fb->pixel_format);
@@ -831,61 +815,13 @@ static const struct drm_plane_helper_funcs plane_helper_funcs = {
 	.atomic_disable = vop_plane_atomic_disable,
 };
 
-static void vop_atomic_plane_reset(struct drm_plane *plane)
-{
-	struct vop_plane_state *vop_plane_state =
-					to_vop_plane_state(plane->state);
-
-	if (plane->state && plane->state->fb)
-		drm_framebuffer_unreference(plane->state->fb);
-
-	kfree(vop_plane_state);
-	vop_plane_state = kzalloc(sizeof(*vop_plane_state), GFP_KERNEL);
-	if (!vop_plane_state)
-		return;
-
-	plane->state = &vop_plane_state->base;
-	plane->state->plane = plane;
-}
-
-static struct drm_plane_state *
-vop_atomic_plane_duplicate_state(struct drm_plane *plane)
-{
-	struct vop_plane_state *old_vop_plane_state;
-	struct vop_plane_state *vop_plane_state;
-
-	if (WARN_ON(!plane->state))
-		return NULL;
-
-	old_vop_plane_state = to_vop_plane_state(plane->state);
-	vop_plane_state = kmemdup(old_vop_plane_state,
-				  sizeof(*vop_plane_state), GFP_KERNEL);
-	if (!vop_plane_state)
-		return NULL;
-
-	__drm_atomic_helper_plane_duplicate_state(plane,
-						  &vop_plane_state->base);
-
-	return &vop_plane_state->base;
-}
-
-static void vop_atomic_plane_destroy_state(struct drm_plane *plane,
-					   struct drm_plane_state *state)
-{
-	struct vop_plane_state *vop_state = to_vop_plane_state(state);
-
-	__drm_atomic_helper_plane_destroy_state(state);
-
-	kfree(vop_state);
-}
-
 static const struct drm_plane_funcs vop_plane_funcs = {
 	.update_plane	= drm_atomic_helper_update_plane,
 	.disable_plane	= drm_atomic_helper_disable_plane,
 	.destroy = vop_plane_destroy,
-	.reset = vop_atomic_plane_reset,
-	.atomic_duplicate_state = vop_atomic_plane_duplicate_state,
-	.atomic_destroy_state = vop_atomic_plane_destroy_state,
+	.reset = drm_atomic_helper_plane_reset,
+	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
 };
 
 static int vop_crtc_enable_vblank(struct drm_crtc *crtc)
-- 
2.8.0.rc3.226.g39d4020
