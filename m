From: mark.yao@rock-chips.com (Mark Yao)
Date: Mon, 14 Dec 2015 16:32:06 +0800
Subject: [PATCH v2 3/8] drm/rockchip: Convert to support atomic API
In-Reply-To: <1450081931-9709-1-git-send-email-mark.yao@rock-chips.com>
References: <1450081931-9709-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1450081931-9709-4-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rockchip vop not support hw vblank counter, needed check the committed
register if it's really take effect.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
Signed-off-by: Tomasz Figa <tfiga@chromium.org>
---
Changes in v2:
- Optimization commit planes sequence.
- Get vblank count on atomic_begin to protect vblank event.
Adviced by Daniel Stone
- Direct return -EINVAL when yuv address is not support, instead of adjust it.
- code formating and cleanup.
Adviced by Thierry Reding & Daniel Vetter
- Hook mode_set into crtc enable instead of hack crtc enable on mode set.

 drivers/gpu/drm/rockchip/rockchip_drm_drv.c |    5 +-
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h |    2 +
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c  |   80 ++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |  647 +++++++++++----------------
 4 files changed, 343 insertions(+), 391 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index cfd9b83..ab3e0f6 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -213,6 +213,8 @@ static int rockchip_drm_load(struct drm_device *drm_dev, unsigned long flags)
 	 */
 	drm_dev->vblank_disable_allowed = true;
 
+	drm_mode_config_reset(drm_dev);
+
 	ret = rockchip_drm_fbdev_init(drm_dev);
 	if (ret)
 		goto err_vblank_cleanup;
@@ -276,7 +278,8 @@ const struct vm_operations_struct rockchip_drm_vm_ops = {
 };
 
 static struct drm_driver rockchip_drm_driver = {
-	.driver_features	= DRIVER_MODESET | DRIVER_GEM | DRIVER_PRIME,
+	.driver_features	= DRIVER_MODESET | DRIVER_GEM |
+				  DRIVER_PRIME | DRIVER_ATOMIC,
 	.load			= rockchip_drm_load,
 	.unload			= rockchip_drm_unload,
 	.lastclose		= rockchip_drm_lastclose,
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
index 069d6d4..513ff98 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
@@ -18,6 +18,7 @@
 #define _ROCKCHIP_DRM_DRV_H
 
 #include <drm/drm_fb_helper.h>
+#include <drm/drm_atomic_helper.h>
 #include <drm/drm_gem.h>
 
 #include <linux/module.h>
@@ -63,5 +64,6 @@ int rockchip_drm_dma_attach_device(struct drm_device *drm_dev,
 				   struct device *dev);
 void rockchip_drm_dma_detach_device(struct drm_device *drm_dev,
 				    struct device *dev);
+void rockchip_crtc_wait_for_update(struct drm_crtc *crtc);
 
 #endif /* _ROCKCHIP_DRM_DRV_H_ */
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
index b8ac591..9aca778 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <drm/drm.h>
 #include <drm/drmP.h>
+#include <drm/drm_atomic.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_crtc_helper.h>
 
@@ -166,9 +167,88 @@ static void rockchip_drm_output_poll_changed(struct drm_device *dev)
 		drm_fb_helper_hotplug_event(fb_helper);
 }
 
+static void rockchip_atomic_wait_for_complete(struct drm_atomic_state *state)
+{
+	struct drm_crtc_state *crtc_state;
+	struct drm_crtc *crtc;
+	int i;
+
+	for_each_crtc_in_state(state, crtc, crtc_state, i) {
+		if (!crtc->state->active)
+			continue;
+
+		WARN_ON(drm_crtc_vblank_get(crtc));
+	}
+
+	for_each_crtc_in_state(state, crtc, crtc_state, i) {
+		if (!crtc->state->active)
+			continue;
+
+		rockchip_crtc_wait_for_update(crtc);
+	}
+
+	for_each_crtc_in_state(state, crtc, crtc_state, i) {
+		if (!crtc->state->active)
+			continue;
+
+		drm_crtc_vblank_put(crtc);
+	}
+}
+
+int rockchip_drm_atomic_commit(struct drm_device *dev,
+			       struct drm_atomic_state *state,
+			       bool async)
+{
+	int ret;
+
+	if (async)
+		return -EBUSY;
+
+	ret = drm_atomic_helper_prepare_planes(dev, state);
+	if (ret)
+		return ret;
+
+	drm_atomic_helper_swap_state(dev, state);
+
+	/*
+	 * TODO: do fence wait here.
+	 */
+
+	/*
+	 * Rockchip crtc support runtime PM, can't update display planes
+	 * when crtc is disabled.
+	 *
+	 * drm_atomic_helper_commit comments detail that:
+	 *     For drivers supporting runtime PM the recommended sequence is
+	 *
+	 *     drm_atomic_helper_commit_modeset_disables(dev, state);
+	 *
+	 *     drm_atomic_helper_commit_modeset_enables(dev, state);
+	 *
+	 *     drm_atomic_helper_commit_planes(dev, state, true);
+	 *
+	 * See the kerneldoc entries for these three functions for more details.
+	 */
+	drm_atomic_helper_commit_modeset_disables(dev, state);
+
+	drm_atomic_helper_commit_modeset_enables(dev, state);
+
+	drm_atomic_helper_commit_planes(dev, state, true);
+
+	rockchip_atomic_wait_for_complete(state);
+
+	drm_atomic_helper_cleanup_planes(dev, state);
+
+	drm_atomic_state_free(state);
+
+	return 0;
+}
+
 static const struct drm_mode_config_funcs rockchip_drm_mode_config_funcs = {
 	.fb_create = rockchip_user_fb_create,
 	.output_poll_changed = rockchip_drm_output_poll_changed,
+	.atomic_check = drm_atomic_helper_check,
+	.atomic_commit = rockchip_drm_atomic_commit,
 };
 
 struct drm_framebuffer *
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index bd5d349..58d7cc4 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -14,6 +14,7 @@
 
 #include <drm/drm.h>
 #include <drm/drmP.h>
+#include <drm/drm_atomic.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_plane_helper.h>
@@ -63,12 +64,15 @@
 
 #define to_vop(x) container_of(x, struct vop, crtc)
 #define to_vop_win(x) container_of(x, struct vop_win, base)
+#define to_vop_plane_state(x) container_of(x, struct vop_plane_state, base)
 
-struct vop_win_state {
-	struct list_head head;
-	struct drm_framebuffer *fb;
+struct vop_plane_state {
+	struct drm_plane_state base;
+	int format;
+	struct drm_rect src;
+	struct drm_rect dest;
 	dma_addr_t yrgb_mst;
-	struct drm_pending_vblank_event *event;
+	bool enable;
 };
 
 struct vop_win {
@@ -76,8 +80,7 @@ struct vop_win {
 	const struct vop_win_data *data;
 	struct vop *vop;
 
-	struct list_head pending;
-	struct vop_win_state *active;
+	struct vop_plane_state state;
 };
 
 struct vop {
@@ -93,6 +96,8 @@ struct vop {
 	struct mutex vsync_mutex;
 	bool vsync_work_pending;
 	struct completion dsp_hold_completion;
+	struct completion wait_update_complete;
+	struct drm_pending_vblank_event *event;
 
 	const struct vop_data *data;
 
@@ -632,7 +637,7 @@ static void vop_dsp_hold_valid_irq_disable(struct vop *vop)
 	spin_unlock_irqrestore(&vop->irq_lock, flags);
 }
 
-static void vop_crtc_enable(struct drm_crtc *crtc)
+static void vop_enable(struct drm_crtc *crtc)
 {
 	struct vop *vop = to_vop(crtc);
 	int ret;
@@ -746,224 +751,188 @@ static void vop_crtc_disable(struct drm_crtc *crtc)
 	pm_runtime_put(vop->dev);
 }
 
-/*
- * Caller must hold vsync_mutex.
- */
-static struct drm_framebuffer *vop_win_last_pending_fb(struct vop_win *vop_win)
-{
-	struct vop_win_state *last;
-	struct vop_win_state *active = vop_win->active;
-
-	if (list_empty(&vop_win->pending))
-		return active ? active->fb : NULL;
-
-	last = list_last_entry(&vop_win->pending, struct vop_win_state, head);
-	return last ? last->fb : NULL;
-}
-
-/*
- * Caller must hold vsync_mutex.
- */
-static int vop_win_queue_fb(struct vop_win *vop_win,
-			    struct drm_framebuffer *fb, dma_addr_t yrgb_mst,
-			    struct drm_pending_vblank_event *event)
+static void vop_plane_destroy(struct drm_plane *plane)
 {
-	struct vop_win_state *state;
-
-	state = kzalloc(sizeof(*state), GFP_KERNEL);
-	if (!state)
-		return -ENOMEM;
-
-	state->fb = fb;
-	state->yrgb_mst = yrgb_mst;
-	state->event = event;
-
-	list_add_tail(&state->head, &vop_win->pending);
-
-	return 0;
+	drm_plane_cleanup(plane);
 }
 
-static int vop_update_plane_event(struct drm_plane *plane,
-				  struct drm_crtc *crtc,
-				  struct drm_framebuffer *fb, int crtc_x,
-				  int crtc_y, unsigned int crtc_w,
-				  unsigned int crtc_h, uint32_t src_x,
-				  uint32_t src_y, uint32_t src_w,
-				  uint32_t src_h,
-				  struct drm_pending_vblank_event *event)
+static int vop_plane_atomic_check(struct drm_plane *plane,
+			   struct drm_plane_state *state)
 {
+	struct drm_crtc *crtc = state->crtc;
+	struct drm_framebuffer *fb = state->fb;
 	struct vop_win *vop_win = to_vop_win(plane);
+	struct vop_plane_state *vop_plane_state = to_vop_plane_state(state);
 	const struct vop_win_data *win = vop_win->data;
-	struct vop *vop = to_vop(crtc);
-	struct drm_gem_object *obj;
-	struct rockchip_gem_object *rk_obj;
-	struct drm_gem_object *uv_obj;
-	struct rockchip_gem_object *rk_uv_obj;
-	unsigned long offset;
-	unsigned int actual_w;
-	unsigned int actual_h;
-	unsigned int dsp_stx;
-	unsigned int dsp_sty;
-	unsigned int y_vir_stride;
-	unsigned int uv_vir_stride = 0;
-	dma_addr_t yrgb_mst;
-	dma_addr_t uv_mst = 0;
-	enum vop_data_format format;
-	uint32_t val;
-	bool is_alpha;
-	bool rb_swap;
-	bool is_yuv;
 	bool visible;
 	int ret;
-	struct drm_rect dest = {
-		.x1 = crtc_x,
-		.y1 = crtc_y,
-		.x2 = crtc_x + crtc_w,
-		.y2 = crtc_y + crtc_h,
-	};
-	struct drm_rect src = {
-		/* 16.16 fixed point */
-		.x1 = src_x,
-		.y1 = src_y,
-		.x2 = src_x + src_w,
-		.y2 = src_y + src_h,
-	};
-	const struct drm_rect clip = {
-		.x2 = crtc->mode.hdisplay,
-		.y2 = crtc->mode.vdisplay,
-	};
-	bool can_position = plane->type != DRM_PLANE_TYPE_PRIMARY;
+	struct drm_rect *dest = &vop_plane_state->dest;
+	struct drm_rect *src = &vop_plane_state->src;
+	struct drm_rect clip;
 	int min_scale = win->phy->scl ? FRAC_16_16(1, 8) :
 					DRM_PLANE_HELPER_NO_SCALING;
 	int max_scale = win->phy->scl ? FRAC_16_16(8, 1) :
 					DRM_PLANE_HELPER_NO_SCALING;
 
-	ret = drm_plane_helper_check_update(plane, crtc, fb,
-					    &src, &dest, &clip,
+	crtc = crtc ? crtc : plane->state->crtc;
+	/*
+	 * Both crtc or plane->state->crtc can be null.
+	 */
+	if (!crtc || !fb)
+		goto out_disable;
+	src->x1 = state->src_x;
+	src->y1 = state->src_y;
+	src->x2 = state->src_x + state->src_w;
+	src->y2 = state->src_y + state->src_h;
+	dest->x1 = state->crtc_x;
+	dest->y1 = state->crtc_y;
+	dest->x2 = state->crtc_x + state->crtc_w;
+	dest->y2 = state->crtc_y + state->crtc_h;
+
+	clip.x1 = 0;
+	clip.y1 = 0;
+	clip.x2 = crtc->mode.hdisplay;
+	clip.y2 = crtc->mode.vdisplay;
+
+	ret = drm_plane_helper_check_update(plane, crtc, state->fb,
+					    src, dest, &clip,
 					    min_scale,
 					    max_scale,
-					    can_position, false, &visible);
+					    true, true, &visible);
 	if (ret)
 		return ret;
 
 	if (!visible)
-		return 0;
+		goto out_disable;
 
-	is_alpha = is_alpha_support(fb->pixel_format);
-	rb_swap = has_rb_swapped(fb->pixel_format);
-	is_yuv = is_yuv_support(fb->pixel_format);
-
-	format = vop_convert_format(fb->pixel_format);
-	if (format < 0)
-		return format;
+	vop_plane_state->format = vop_convert_format(fb->pixel_format);
+	if (vop_plane_state->format < 0)
+		return vop_plane_state->format;
 
-	obj = rockchip_fb_get_gem_obj(fb, 0);
-	if (!obj) {
-		DRM_ERROR("fail to get rockchip gem object from framebuffer\n");
+	/*
+	 * Src.x1 can be odd when do clip, but yuv plane start point
+	 * need align with 2 pixel.
+	 */
+	if (is_yuv_support(fb->pixel_format) && ((src->x1 >> 16) % 2))
 		return -EINVAL;
-	}
 
-	rk_obj = to_rockchip_obj(obj);
+	vop_plane_state->enable = true;
 
-	if (is_yuv) {
-		/*
-		 * Src.x1 can be odd when do clip, but yuv plane start point
-		 * need align with 2 pixel.
-		 */
-		val = (src.x1 >> 16) % 2;
-		src.x1 += val << 16;
-		src.x2 += val << 16;
-	}
+	return 0;
 
-	actual_w = (src.x2 - src.x1) >> 16;
-	actual_h = (src.y2 - src.y1) >> 16;
+out_disable:
+	vop_plane_state->enable = false;
+	return 0;
+}
 
-	dsp_stx = dest.x1 + crtc->mode.htotal - crtc->mode.hsync_start;
-	dsp_sty = dest.y1 + crtc->mode.vtotal - crtc->mode.vsync_start;
+static void vop_plane_atomic_disable(struct drm_plane *plane,
+				     struct drm_plane_state *old_state)
+{
+	struct vop_plane_state *vop_plane_state = to_vop_plane_state(old_state);
+	struct vop_win *vop_win = to_vop_win(plane);
+	const struct vop_win_data *win = vop_win->data;
+	struct vop *vop = to_vop(old_state->crtc);
 
-	offset = (src.x1 >> 16) * drm_format_plane_cpp(fb->pixel_format, 0);
-	offset += (src.y1 >> 16) * fb->pitches[0];
+	if (!old_state->crtc)
+		return;
 
-	yrgb_mst = rk_obj->dma_addr + offset + fb->offsets[0];
-	y_vir_stride = fb->pitches[0] >> 2;
+	spin_lock(&vop->reg_lock);
 
-	if (is_yuv) {
-		int hsub = drm_format_horz_chroma_subsampling(fb->pixel_format);
-		int vsub = drm_format_vert_chroma_subsampling(fb->pixel_format);
-		int bpp = drm_format_plane_cpp(fb->pixel_format, 1);
+	VOP_WIN_SET(vop, win, enable, 0);
 
-		uv_obj = rockchip_fb_get_gem_obj(fb, 1);
-		if (!uv_obj) {
-			DRM_ERROR("fail to get uv object from framebuffer\n");
-			return -EINVAL;
-		}
-		rk_uv_obj = to_rockchip_obj(uv_obj);
-		uv_vir_stride = fb->pitches[1] >> 2;
+	spin_unlock(&vop->reg_lock);
 
-		offset = (src.x1 >> 16) * bpp / hsub;
-		offset += (src.y1 >> 16) * fb->pitches[1] / vsub;
+	vop_plane_state->enable = false;
+}
 
-		uv_mst = rk_uv_obj->dma_addr + offset + fb->offsets[1];
-	}
+static void vop_plane_atomic_update(struct drm_plane *plane,
+		struct drm_plane_state *old_state)
+{
+	struct drm_plane_state *state = plane->state;
+	struct drm_crtc *crtc = state->crtc;
+	struct vop_win *vop_win = to_vop_win(plane);
+	struct vop_plane_state *vop_plane_state = to_vop_plane_state(state);
+	const struct vop_win_data *win = vop_win->data;
+	struct vop *vop = to_vop(state->crtc);
+	struct drm_framebuffer *fb = state->fb;
+	unsigned int actual_w, actual_h;
+	unsigned int dsp_stx, dsp_sty;
+	uint32_t act_info, dsp_info, dsp_st;
+	struct drm_rect *src = &vop_plane_state->src;
+	struct drm_rect *dest = &vop_plane_state->dest;
+	struct drm_gem_object *obj, *uv_obj;
+	struct rockchip_gem_object *rk_obj, *rk_uv_obj;
+	unsigned long offset;
+	dma_addr_t dma_addr;
+	uint32_t val;
+	bool rb_swap;
 
 	/*
-	 * If this plane update changes the plane's framebuffer, (or more
-	 * precisely, if this update has a different framebuffer than the last
-	 * update), enqueue it so we can track when it completes.
-	 *
-	 * Only when we discover that this update has completed, can we
-	 * unreference any previous framebuffers.
+	 * can't update plane when vop is disabled.
 	 */
-	mutex_lock(&vop->vsync_mutex);
-	if (fb != vop_win_last_pending_fb(vop_win)) {
-		ret = drm_crtc_vblank_get(crtc);
-		if (ret) {
-			DRM_ERROR("failed to get vblank, %d\n", ret);
-			mutex_unlock(&vop->vsync_mutex);
-			return ret;
-		}
-
-		drm_framebuffer_reference(fb);
+	if (!crtc)
+		return;
 
-		ret = vop_win_queue_fb(vop_win, fb, yrgb_mst, event);
-		if (ret) {
-			drm_crtc_vblank_put(crtc);
-			mutex_unlock(&vop->vsync_mutex);
-			return ret;
-		}
+	if (WARN_ON(!vop->is_enabled))
+		return;
 
-		vop->vsync_work_pending = true;
+	if (!vop_plane_state->enable) {
+		vop_plane_atomic_disable(plane, old_state);
+		return;
 	}
-	mutex_unlock(&vop->vsync_mutex);
+
+	obj = rockchip_fb_get_gem_obj(fb, 0);
+	rk_obj = to_rockchip_obj(obj);
+
+	actual_w = drm_rect_width(src) >> 16;
+	actual_h = drm_rect_height(src) >> 16;
+	act_info = (actual_h - 1) << 16 | ((actual_w - 1) & 0xffff);
+
+	dsp_info = (drm_rect_height(dest) - 1) << 16;
+	dsp_info |= (drm_rect_width(dest) - 1) & 0xffff;
+
+	dsp_stx = dest->x1 + crtc->mode.htotal - crtc->mode.hsync_start;
+	dsp_sty = dest->y1 + crtc->mode.vtotal - crtc->mode.vsync_start;
+	dsp_st = dsp_sty << 16 | (dsp_stx & 0xffff);
+
+	offset = (src->x1 >> 16) * drm_format_plane_cpp(fb->pixel_format, 0);
+	offset += (src->y1 >> 16) * fb->pitches[0];
+	vop_plane_state->yrgb_mst = rk_obj->dma_addr + offset + fb->offsets[0];
 
 	spin_lock(&vop->reg_lock);
 
-	VOP_WIN_SET(vop, win, format, format);
-	VOP_WIN_SET(vop, win, yrgb_vir, y_vir_stride);
-	VOP_WIN_SET(vop, win, yrgb_mst, yrgb_mst);
-	if (is_yuv) {
-		VOP_WIN_SET(vop, win, uv_vir, uv_vir_stride);
-		VOP_WIN_SET(vop, win, uv_mst, uv_mst);
+	VOP_WIN_SET(vop, win, format, vop_plane_state->format);
+	VOP_WIN_SET(vop, win, yrgb_vir, fb->pitches[0] >> 2);
+	VOP_WIN_SET(vop, win, yrgb_mst, vop_plane_state->yrgb_mst);
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
+
+		dma_addr = rk_uv_obj->dma_addr + offset + fb->offsets[1];
+		VOP_WIN_SET(vop, win, uv_vir, fb->pitches[1] >> 2);
+		VOP_WIN_SET(vop, win, uv_mst, dma_addr);
 	}
 
 	if (win->phy->scl)
 		scl_vop_cal_scl_fac(vop, win, actual_w, actual_h,
-				    dest.x2 - dest.x1, dest.y2 - dest.y1,
+				    drm_rect_width(dest), drm_rect_height(dest),
 				    fb->pixel_format);
 
-	val = (actual_h - 1) << 16;
-	val |= (actual_w - 1) & 0xffff;
-	VOP_WIN_SET(vop, win, act_info, val);
+	VOP_WIN_SET(vop, win, act_info, act_info);
+	VOP_WIN_SET(vop, win, dsp_info, dsp_info);
+	VOP_WIN_SET(vop, win, dsp_st, dsp_st);
 
-	val = (dest.y2 - dest.y1 - 1) << 16;
-	val |= (dest.x2 - dest.x1 - 1) & 0xffff;
-	VOP_WIN_SET(vop, win, dsp_info, val);
-	val = dsp_sty << 16;
-	val |= dsp_stx & 0xffff;
-	VOP_WIN_SET(vop, win, dsp_st, val);
+	rb_swap = has_rb_swapped(fb->pixel_format);
 	VOP_WIN_SET(vop, win, rb_swap, rb_swap);
 
-	if (is_alpha) {
+	if (is_alpha_support(fb->pixel_format)) {
 		VOP_WIN_SET(vop, win, dst_alpha_ctl,
 			    DST_FACTOR_M0(ALPHA_SRC_INVERSE));
 		val = SRC_ALPHA_EN(1) | SRC_COLOR_M0(ALPHA_SRC_PRE_MUL) |
@@ -977,86 +946,78 @@ static int vop_update_plane_event(struct drm_plane *plane,
 	}
 
 	VOP_WIN_SET(vop, win, enable, 1);
-
-	vop_cfg_done(vop);
 	spin_unlock(&vop->reg_lock);
-
-	return 0;
 }
 
-static int vop_update_plane(struct drm_plane *plane, struct drm_crtc *crtc,
-			    struct drm_framebuffer *fb, int crtc_x, int crtc_y,
-			    unsigned int crtc_w, unsigned int crtc_h,
-			    uint32_t src_x, uint32_t src_y, uint32_t src_w,
-			    uint32_t src_h)
-{
-	return vop_update_plane_event(plane, crtc, fb, crtc_x, crtc_y, crtc_w,
-				      crtc_h, src_x, src_y, src_w, src_h,
-				      NULL);
-}
+static const struct drm_plane_helper_funcs plane_helper_funcs = {
+	.atomic_check = vop_plane_atomic_check,
+	.atomic_update = vop_plane_atomic_update,
+	.atomic_disable = vop_plane_atomic_disable,
+};
 
-static int vop_update_primary_plane(struct drm_crtc *crtc,
-				    struct drm_pending_vblank_event *event)
+void rockchip_crtc_wait_for_update(struct drm_crtc *crtc)
 {
-	unsigned int crtc_w, crtc_h;
-
-	crtc_w = crtc->primary->fb->width - crtc->x;
-	crtc_h = crtc->primary->fb->height - crtc->y;
+	struct vop *vop = to_vop(crtc);
 
-	return vop_update_plane_event(crtc->primary, crtc, crtc->primary->fb,
-				      0, 0, crtc_w, crtc_h, crtc->x << 16,
-				      crtc->y << 16, crtc_w << 16,
-				      crtc_h << 16, event);
+	reinit_completion(&vop->wait_update_complete);
+	WARN_ON(!wait_for_completion_timeout(&vop->wait_update_complete, 100));
 }
 
-static int vop_disable_plane(struct drm_plane *plane)
+void vop_atomic_plane_reset(struct drm_plane *plane)
 {
-	struct vop_win *vop_win = to_vop_win(plane);
-	const struct vop_win_data *win = vop_win->data;
-	struct vop *vop;
-	int ret;
+	struct vop_plane_state *vop_plane_state =
+					to_vop_plane_state(plane->state);
 
-	if (!plane->crtc)
-		return 0;
+	if (plane->state && plane->state->fb)
+		drm_framebuffer_unreference(plane->state->fb);
 
-	vop = to_vop(plane->crtc);
+	kfree(vop_plane_state);
+	vop_plane_state = kzalloc(sizeof(*vop_plane_state), GFP_KERNEL);
+	if (!vop_plane_state)
+		return;
 
-	ret = drm_crtc_vblank_get(plane->crtc);
-	if (ret) {
-		DRM_ERROR("failed to get vblank, %d\n", ret);
-		return ret;
-	}
+	plane->state = &vop_plane_state->base;
+	plane->state->plane = plane;
+}
 
-	mutex_lock(&vop->vsync_mutex);
+struct drm_plane_state *
+vop_atomic_plane_duplicate_state(struct drm_plane *plane)
+{
+	struct vop_plane_state *old_vop_plane_state;
+	struct vop_plane_state *vop_plane_state;
 
-	ret = vop_win_queue_fb(vop_win, NULL, 0, NULL);
-	if (ret) {
-		drm_crtc_vblank_put(plane->crtc);
-		mutex_unlock(&vop->vsync_mutex);
-		return ret;
-	}
+	if (WARN_ON(!plane->state))
+		return NULL;
 
-	vop->vsync_work_pending = true;
-	mutex_unlock(&vop->vsync_mutex);
+	old_vop_plane_state = to_vop_plane_state(plane->state);
+	vop_plane_state = kmemdup(old_vop_plane_state,
+				  sizeof(*vop_plane_state), GFP_KERNEL);
+	if (!vop_plane_state)
+		return NULL;
 
-	spin_lock(&vop->reg_lock);
-	VOP_WIN_SET(vop, win, enable, 0);
-	vop_cfg_done(vop);
-	spin_unlock(&vop->reg_lock);
+	__drm_atomic_helper_plane_duplicate_state(plane,
+						  &vop_plane_state->base);
 
-	return 0;
+	return &vop_plane_state->base;
 }
 
-static void vop_plane_destroy(struct drm_plane *plane)
+static void vop_atomic_plane_destroy_state(struct drm_plane *plane,
+					   struct drm_plane_state *state)
 {
-	vop_disable_plane(plane);
-	drm_plane_cleanup(plane);
+	struct vop_plane_state *vop_state = to_vop_plane_state(state);
+
+	__drm_atomic_helper_plane_destroy_state(plane, state);
+
+	kfree(vop_state);
 }
 
 static const struct drm_plane_funcs vop_plane_funcs = {
-	.update_plane = vop_update_plane,
-	.disable_plane = vop_disable_plane,
+	.update_plane	= drm_atomic_helper_update_plane,
+	.disable_plane	= drm_atomic_helper_disable_plane,
 	.destroy = vop_plane_destroy,
+	.reset = vop_atomic_plane_reset,
+	.atomic_duplicate_state = vop_atomic_plane_duplicate_state,
+	.atomic_destroy_state = vop_atomic_plane_destroy_state,
 };
 
 int rockchip_drm_crtc_mode_config(struct drm_crtc *crtc,
@@ -1077,7 +1038,7 @@ static int vop_crtc_enable_vblank(struct drm_crtc *crtc)
 	struct vop *vop = to_vop(crtc);
 	unsigned long flags;
 
-	if (!vop->is_enabled)
+	if (WARN_ON(!vop->is_enabled))
 		return -EPERM;
 
 	spin_lock_irqsave(&vop->irq_lock, flags);
@@ -1094,7 +1055,7 @@ static void vop_crtc_disable_vblank(struct drm_crtc *crtc)
 	struct vop *vop = to_vop(crtc);
 	unsigned long flags;
 
-	if (!vop->is_enabled)
+	if (WARN_ON(!vop->is_enabled))
 		return;
 
 	spin_lock_irqsave(&vop->irq_lock, flags);
@@ -1117,29 +1078,10 @@ static bool vop_crtc_mode_fixup(struct drm_crtc *crtc,
 	return true;
 }
 
-static int vop_crtc_mode_set_base(struct drm_crtc *crtc, int x, int y,
-				  struct drm_framebuffer *old_fb)
-{
-	int ret;
-
-	crtc->x = x;
-	crtc->y = y;
-
-	ret = vop_update_primary_plane(crtc, NULL);
-	if (ret < 0) {
-		DRM_ERROR("fail to update plane\n");
-		return ret;
-	}
-
-	return 0;
-}
-
-static int vop_crtc_mode_set(struct drm_crtc *crtc,
-			     struct drm_display_mode *mode,
-			     struct drm_display_mode *adjusted_mode,
-			     int x, int y, struct drm_framebuffer *fb)
+static void vop_crtc_enable(struct drm_crtc *crtc)
 {
 	struct vop *vop = to_vop(crtc);
+	struct drm_display_mode *adjusted_mode = &crtc->state->adjusted_mode;
 	u16 hsync_len = adjusted_mode->hsync_end - adjusted_mode->hsync_start;
 	u16 hdisplay = adjusted_mode->hdisplay;
 	u16 htotal = adjusted_mode->htotal;
@@ -1150,9 +1092,9 @@ static int vop_crtc_mode_set(struct drm_crtc *crtc,
 	u16 vsync_len = adjusted_mode->vsync_end - adjusted_mode->vsync_start;
 	u16 vact_st = adjusted_mode->vtotal - adjusted_mode->vsync_start;
 	u16 vact_end = vact_st + vdisplay;
-	int ret, ret_clk;
 	uint32_t val;
 
+	vop_enable(crtc);
 	/*
 	 * disable dclk to stop frame scan, so that we can safe config mode and
 	 * enable iommu.
@@ -1172,7 +1114,6 @@ static int vop_crtc_mode_set(struct drm_crtc *crtc,
 	default:
 		DRM_ERROR("unsupport connector_type[%d]\n",
 			  vop->connector_type);
-		ret = -EINVAL;
 		goto out;
 	};
 	VOP_CTRL_SET(vop, out_mode, vop->connector_out_mode);
@@ -1194,9 +1135,6 @@ static int vop_crtc_mode_set(struct drm_crtc *crtc,
 	VOP_CTRL_SET(vop, vact_st_end, val);
 	VOP_CTRL_SET(vop, vpost_st_end, val);
 
-	ret = vop_crtc_mode_set_base(crtc, x, y, fb);
-	if (ret)
-		goto out;
 
 	/*
 	 * reset dclk, take all mode config affect, so the clk would run in
@@ -1208,172 +1146,98 @@ static int vop_crtc_mode_set(struct drm_crtc *crtc,
 
 	clk_set_rate(vop->dclk, adjusted_mode->clock * 1000);
 out:
-	ret_clk = clk_enable(vop->dclk);
-	if (ret_clk < 0) {
+	if (clk_enable(vop->dclk) < 0)
 		dev_err(vop->dev, "failed to enable dclk - %d\n", ret_clk);
-		return ret_clk;
-	}
 
-	return ret;
 }
 
-static const struct drm_crtc_helper_funcs vop_crtc_helper_funcs = {
-	.enable = vop_crtc_enable,
-	.disable = vop_crtc_disable,
-	.mode_fixup = vop_crtc_mode_fixup,
-	.mode_set = vop_crtc_mode_set,
-	.mode_set_base = vop_crtc_mode_set_base,
-};
-
-static int vop_crtc_page_flip(struct drm_crtc *crtc,
-			      struct drm_framebuffer *fb,
-			      struct drm_pending_vblank_event *event,
-			      uint32_t page_flip_flags)
+static void vop_crtc_atomic_flush(struct drm_crtc *crtc,
+				  struct drm_crtc_state *old_crtc_state)
 {
 	struct vop *vop = to_vop(crtc);
-	struct drm_framebuffer *old_fb = crtc->primary->fb;
-	int ret;
 
-	/* when the page flip is requested, crtc should be on */
-	if (!vop->is_enabled) {
-		DRM_DEBUG("page flip request rejected because crtc is off.\n");
-		return 0;
-	}
+	if (WARN_ON(!vop->is_enabled))
+		return;
 
-	crtc->primary->fb = fb;
+	spin_lock(&vop->reg_lock);
 
-	ret = vop_update_primary_plane(crtc, event);
-	if (ret)
-		crtc->primary->fb = old_fb;
+	vop_cfg_done(vop);
 
-	return ret;
+	spin_unlock(&vop->reg_lock);
 }
 
-static void vop_win_state_complete(struct vop_win *vop_win,
-				   struct vop_win_state *state)
+static void vop_crtc_atomic_begin(struct drm_crtc *crtc,
+				  struct drm_crtc_state *old_crtc_state)
 {
-	struct vop *vop = vop_win->vop;
-	struct drm_crtc *crtc = &vop->crtc;
-	struct drm_device *drm = crtc->dev;
-	unsigned long flags;
+	struct vop *vop = to_vop(crtc);
 
-	if (state->event) {
-		spin_lock_irqsave(&drm->event_lock, flags);
-		drm_crtc_send_vblank_event(crtc, state->event);
-		spin_unlock_irqrestore(&drm->event_lock, flags);
-	}
+	if (crtc->state->event) {
+		WARN_ON(drm_crtc_vblank_get(crtc) != 0);
 
-	list_del(&state->head);
-	drm_crtc_vblank_put(crtc);
+		vop->event = crtc->state->event;
+		crtc->state->event = NULL;
+	}
 }
 
+static const struct drm_crtc_helper_funcs vop_crtc_helper_funcs = {
+	.enable = vop_crtc_enable,
+	.disable = vop_crtc_disable,
+	.mode_fixup = vop_crtc_mode_fixup,
+	.atomic_flush = vop_crtc_atomic_flush,
+	.atomic_begin = vop_crtc_atomic_begin,
+};
+
 static void vop_crtc_destroy(struct drm_crtc *crtc)
 {
 	drm_crtc_cleanup(crtc);
 }
 
 static const struct drm_crtc_funcs vop_crtc_funcs = {
-	.set_config = drm_crtc_helper_set_config,
-	.page_flip = vop_crtc_page_flip,
+	.set_config = drm_atomic_helper_set_config,
+	.page_flip = drm_atomic_helper_page_flip,
 	.destroy = vop_crtc_destroy,
+	.reset = drm_atomic_helper_crtc_reset,
+	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
 };
 
-static bool vop_win_state_is_active(struct vop_win *vop_win,
-				    struct vop_win_state *state)
+static bool vop_win_pending_is_complete(struct vop_win *vop_win)
 {
-	bool active = false;
-
-	if (state->fb) {
-		dma_addr_t yrgb_mst;
-
-		/* check yrgb_mst to tell if pending_fb is now front */
-		yrgb_mst = VOP_WIN_GET_YRGBADDR(vop_win->vop, vop_win->data);
-
-		active = (yrgb_mst == state->yrgb_mst);
-	} else {
-		bool enabled;
+	struct drm_plane *plane = &vop_win->base;
+	struct vop_plane_state *state = to_vop_plane_state(plane->state);
+	dma_addr_t yrgb_mst;
 
-		/* if enable bit is clear, plane is now disabled */
-		enabled = VOP_WIN_GET(vop_win->vop, vop_win->data, enable);
+	if (!state->enable)
+		return VOP_WIN_GET(vop_win->vop, vop_win->data, enable) == 0;
 
-		active = (enabled == 0);
-	}
+	yrgb_mst = VOP_WIN_GET_YRGBADDR(vop_win->vop, vop_win->data);
 
-	return active;
+	return yrgb_mst == state->yrgb_mst;
 }
 
-static void vop_win_state_destroy(struct vop_win_state *state)
+static void vop_handle_vblank(struct vop *vop)
 {
-	struct drm_framebuffer *fb = state->fb;
-
-	if (fb)
-		drm_framebuffer_unreference(fb);
-
-	kfree(state);
-}
-
-static void vop_win_update_state(struct vop_win *vop_win)
-{
-	struct vop_win_state *state, *n, *new_active = NULL;
-
-	/* Check if any pending states are now active */
-	list_for_each_entry(state, &vop_win->pending, head)
-		if (vop_win_state_is_active(vop_win, state)) {
-			new_active = state;
-			break;
-		}
-
-	if (!new_active)
-		return;
+	struct drm_device *drm = vop->drm_dev;
+	struct drm_crtc *crtc = &vop->crtc;
+	unsigned long flags;
+	int i;
 
-	/*
-	 * Destroy any 'skipped' pending states - states that were queued
-	 * before the newly active state.
-	 */
-	list_for_each_entry_safe(state, n, &vop_win->pending, head) {
-		if (state == new_active)
-			break;
-		vop_win_state_complete(vop_win, state);
-		vop_win_state_destroy(state);
+	for (i = 0; i < vop->data->win_size; i++) {
+		if (!vop_win_pending_is_complete(&vop->win[i]))
+			return;
 	}
 
-	vop_win_state_complete(vop_win, new_active);
-
-	if (vop_win->active)
-		vop_win_state_destroy(vop_win->active);
-	vop_win->active = new_active;
-}
-
-static bool vop_win_has_pending_state(struct vop_win *vop_win)
-{
-	return !list_empty(&vop_win->pending);
-}
-
-static irqreturn_t vop_isr_thread(int irq, void *data)
-{
-	struct vop *vop = data;
-	const struct vop_data *vop_data = vop->data;
-	unsigned int i;
-
-	mutex_lock(&vop->vsync_mutex);
-
-	if (!vop->vsync_work_pending)
-		goto done;
+	if (vop->event) {
+		spin_lock_irqsave(&drm->event_lock, flags);
 
-	vop->vsync_work_pending = false;
+		drm_crtc_send_vblank_event(crtc, vop->event);
+		drm_crtc_vblank_put(crtc);
+		vop->event = NULL;
 
-	for (i = 0; i < vop_data->win_size; i++) {
-		struct vop_win *vop_win = &vop->win[i];
-
-		vop_win_update_state(vop_win);
-		if (vop_win_has_pending_state(vop_win))
-			vop->vsync_work_pending = true;
+		spin_unlock_irqrestore(&drm->event_lock, flags);
 	}
-
-done:
-	mutex_unlock(&vop->vsync_mutex);
-
-	return IRQ_HANDLED;
+	if (!completion_done(&vop->wait_update_complete))
+		complete(&vop->wait_update_complete);
 }
 
 static irqreturn_t vop_isr(int irq, void *data)
@@ -1409,8 +1273,9 @@ static irqreturn_t vop_isr(int irq, void *data)
 
 	if (active_irqs & FS_INTR) {
 		drm_crtc_handle_vblank(crtc);
+		vop_handle_vblank(vop);
 		active_irqs &= ~FS_INTR;
-		ret = (vop->vsync_work_pending) ? IRQ_WAKE_THREAD : IRQ_HANDLED;
+		ret = IRQ_HANDLED;
 	}
 
 	/* Unhandled irqs are spurious. */
@@ -1455,6 +1320,7 @@ static int vop_create_crtc(struct vop *vop)
 		}
 
 		plane = &vop_win->base;
+		drm_plane_helper_add(plane, &plane_helper_funcs);
 		if (plane->type == DRM_PLANE_TYPE_PRIMARY)
 			primary = plane;
 		else if (plane->type == DRM_PLANE_TYPE_CURSOR)
@@ -1490,6 +1356,7 @@ static int vop_create_crtc(struct vop *vop)
 			DRM_ERROR("failed to initialize overlay plane\n");
 			goto err_cleanup_crtc;
 		}
+		drm_plane_helper_add(&vop_win->base, &plane_helper_funcs);
 	}
 
 	port = of_get_child_by_name(dev->of_node, "port");
@@ -1500,6 +1367,7 @@ static int vop_create_crtc(struct vop *vop)
 	}
 
 	init_completion(&vop->dsp_hold_completion);
+	init_completion(&vop->wait_update_complete);
 	crtc->port = port;
 	rockchip_register_crtc_funcs(crtc, &private_crtc_funcs);
 
@@ -1633,7 +1501,6 @@ static void vop_win_init(struct vop *vop)
 
 		vop_win->data = win_data;
 		vop_win->vop = vop;
-		INIT_LIST_HEAD(&vop_win->pending);
 	}
 }
 
@@ -1694,8 +1561,8 @@ static int vop_bind(struct device *dev, struct device *master, void *data)
 
 	mutex_init(&vop->vsync_mutex);
 
-	ret = devm_request_threaded_irq(dev, vop->irq, vop_isr, vop_isr_thread,
-					IRQF_SHARED, dev_name(dev), vop);
+	ret = devm_request_irq(dev, vop->irq, vop_isr,
+			       IRQF_SHARED, dev_name(dev), vop);
 	if (ret)
 		return ret;
 
-- 
1.7.9.5
