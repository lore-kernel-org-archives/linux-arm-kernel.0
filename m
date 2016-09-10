From: mark.yao@rock-chips.com (Mark Yao)
Date: Sat, 10 Sep 2016 10:29:02 +0800
Subject: [PATCH 1/3] drm/rockchip: vop: move dma_addr to plane atomic check
Message-ID: <1473474544-16248-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Calc dma_addr earlier, then the dma_addr can be used on
crtc atomic check.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 52 ++++++++++++++++-------------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 3321115..834456f 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -91,6 +91,7 @@ struct vop_plane_state {
 	struct drm_plane_state base;
 	int format;
 	dma_addr_t yrgb_mst;
+	dma_addr_t uv_mst;
 	bool enable;
 };
 
@@ -589,12 +590,16 @@ static int vop_plane_atomic_check(struct drm_plane *plane,
 	struct vop_win *vop_win = to_vop_win(plane);
 	struct vop_plane_state *vop_plane_state = to_vop_plane_state(state);
 	const struct vop_win_data *win = vop_win->data;
+	struct drm_gem_object *obj, *uv_obj;
+	struct rockchip_gem_object *rk_obj, *rk_uv_obj;
 	int ret;
+	struct drm_rect *src = &state->src;
 	struct drm_rect clip;
 	int min_scale = win->phy->scl ? FRAC_16_16(1, 8) :
 					DRM_PLANE_HELPER_NO_SCALING;
 	int max_scale = win->phy->scl ? FRAC_16_16(8, 1) :
 					DRM_PLANE_HELPER_NO_SCALING;
+	unsigned long offset;
 
 	if (!crtc || !fb)
 		goto out_disable;
@@ -628,6 +633,29 @@ static int vop_plane_atomic_check(struct drm_plane *plane,
 	if (is_yuv_support(fb->pixel_format) && ((state->src.x1 >> 16) % 2))
 		return -EINVAL;
 
+	obj = rockchip_fb_get_gem_obj(fb, 0);
+	rk_obj = to_rockchip_obj(obj);
+
+	offset = (src->x1 >> 16) * drm_format_plane_cpp(fb->pixel_format, 0);
+	offset += (src->y1 >> 16) * fb->pitches[0];
+	offset += fb->offsets[0];
+	vop_plane_state->yrgb_mst = rk_obj->dma_addr + offset;
+
+	if (is_yuv_support(fb->pixel_format)) {
+		int hsub = drm_format_horz_chroma_subsampling(fb->pixel_format);
+		int vsub = drm_format_vert_chroma_subsampling(fb->pixel_format);
+		int bpp = drm_format_plane_cpp(fb->pixel_format, 1);
+
+		uv_obj = rockchip_fb_get_gem_obj(fb, 1);
+		rk_uv_obj = to_rockchip_obj(uv_obj);
+
+		offset = (src->x1 >> 16) * bpp / hsub;
+		offset += (src->y1 >> 16) * fb->pitches[1] / vsub;
+		offset += fb->offsets[1];
+
+		vop_plane_state->uv_mst = rk_uv_obj->dma_addr + offset;
+	}
+
 	vop_plane_state->enable = true;
 
 	return 0;
@@ -677,10 +705,6 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 	uint32_t act_info, dsp_info, dsp_st;
 	struct drm_rect *src = &state->src;
 	struct drm_rect *dest = &state->dst;
-	struct drm_gem_object *obj, *uv_obj;
-	struct rockchip_gem_object *rk_obj, *rk_uv_obj;
-	unsigned long offset;
-	dma_addr_t dma_addr;
 	uint32_t val;
 	bool rb_swap;
 
@@ -698,9 +722,6 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 		return;
 	}
 
-	obj = rockchip_fb_get_gem_obj(fb, 0);
-	rk_obj = to_rockchip_obj(obj);
-
 	actual_w = drm_rect_width(src) >> 16;
 	actual_h = drm_rect_height(src) >> 16;
 	act_info = (actual_h - 1) << 16 | ((actual_w - 1) & 0xffff);
@@ -712,10 +733,6 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 	dsp_sty = dest->y1 + crtc->mode.vtotal - crtc->mode.vsync_start;
 	dsp_st = dsp_sty << 16 | (dsp_stx & 0xffff);
 
-	offset = (src->x1 >> 16) * drm_format_plane_cpp(fb->pixel_format, 0);
-	offset += (src->y1 >> 16) * fb->pitches[0];
-	vop_plane_state->yrgb_mst = rk_obj->dma_addr + offset + fb->offsets[0];
-
 	spin_lock_irq(&plane->dev->event_lock);
 	vop_win->enable = true;
 	vop_win->yrgb_mst = vop_plane_state->yrgb_mst;
@@ -727,19 +744,8 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 	VOP_WIN_SET(vop, win, yrgb_vir, fb->pitches[0] >> 2);
 	VOP_WIN_SET(vop, win, yrgb_mst, vop_plane_state->yrgb_mst);
 	if (is_yuv_support(fb->pixel_format)) {
-		int hsub = drm_format_horz_chroma_subsampling(fb->pixel_format);
-		int vsub = drm_format_vert_chroma_subsampling(fb->pixel_format);
-		int bpp = drm_format_plane_cpp(fb->pixel_format, 1);
-
-		uv_obj = rockchip_fb_get_gem_obj(fb, 1);
-		rk_uv_obj = to_rockchip_obj(uv_obj);
-
-		offset = (src->x1 >> 16) * bpp / hsub;
-		offset += (src->y1 >> 16) * fb->pitches[1] / vsub;
-
-		dma_addr = rk_uv_obj->dma_addr + offset + fb->offsets[1];
 		VOP_WIN_SET(vop, win, uv_vir, fb->pitches[1] >> 2);
-		VOP_WIN_SET(vop, win, uv_mst, dma_addr);
+		VOP_WIN_SET(vop, win, uv_mst, vop_plane_state->uv_mst);
 	}
 
 	if (win->phy->scl)
-- 
1.9.1
