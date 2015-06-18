From: mark.yao@rock-chips.com (Mark Yao)
Date: Thu, 18 Jun 2015 15:49:27 +0800
Subject: [PATCH 3/6] drm/rockchip: vop: fix yuv plane support
In-Reply-To: <1434613770-6608-1-git-send-email-mark.yao@rock-chips.com>
References: <1434613770-6608-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1434613770-6608-4-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

vop support yuv with NV12, NV16 and NV24, only 2 plane yuv.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |   42 ++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 3c9f4f3..7d84549 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -373,6 +373,18 @@ static enum vop_data_format vop_convert_format(uint32_t format)
 	}
 }
 
+static bool is_yuv_support(uint32_t format)
+{
+	switch (format) {
+	case DRM_FORMAT_NV12:
+	case DRM_FORMAT_NV16:
+	case DRM_FORMAT_NV24:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static bool is_alpha_support(uint32_t format)
 {
 	switch (format) {
@@ -577,16 +589,21 @@ static int vop_update_plane_event(struct drm_plane *plane,
 	struct vop *vop = to_vop(crtc);
 	struct drm_gem_object *obj;
 	struct rockchip_gem_object *rk_obj;
+	struct drm_gem_object *uv_obj;
+	struct rockchip_gem_object *rk_uv_obj;
 	unsigned long offset;
 	unsigned int actual_w;
 	unsigned int actual_h;
 	unsigned int dsp_stx;
 	unsigned int dsp_sty;
 	unsigned int y_vir_stride;
+	unsigned int uv_vir_stride;
 	dma_addr_t yrgb_mst;
+	dma_addr_t uv_mst;
 	enum vop_data_format format;
 	uint32_t val;
 	bool is_alpha;
+	bool is_yuv;
 	bool visible;
 	int ret;
 	struct drm_rect dest = {
@@ -608,6 +625,12 @@ static int vop_update_plane_event(struct drm_plane *plane,
 	};
 	bool can_position = plane->type != DRM_PLANE_TYPE_PRIMARY;
 
+	if (drm_format_num_planes(fb->pixel_format) > 2) {
+		DRM_ERROR("unsupport more than 2 plane format[%08x]\n",
+			  fb->pixel_format);
+		return -EINVAL;
+	}
+
 	ret = drm_plane_helper_check_update(plane, crtc, fb,
 					    &src, &dest, &clip,
 					    DRM_PLANE_HELPER_NO_SCALING,
@@ -624,6 +647,8 @@ static int vop_update_plane_event(struct drm_plane *plane,
 	if (format < 0)
 		return format;
 
+	is_yuv = is_yuv_support(fb->pixel_format);
+
 	obj = rockchip_fb_get_gem_obj(fb, 0);
 	if (!obj) {
 		DRM_ERROR("fail to get rockchip gem object from framebuffer\n");
@@ -642,10 +667,21 @@ static int vop_update_plane_event(struct drm_plane *plane,
 
 	offset = (src.x1 >> 16) * (fb->bits_per_pixel >> 3);
 	offset += (src.y1 >> 16) * fb->pitches[0];
-	yrgb_mst = rk_obj->dma_addr + offset;
 
+	yrgb_mst = rk_obj->dma_addr + offset + fb->offsets[0];
 	y_vir_stride = fb->pitches[0] >> 2;
 
+	if (is_yuv) {
+		uv_obj = rockchip_fb_get_gem_obj(fb, 1);
+		if (!uv_obj) {
+			DRM_ERROR("fail to get uv object from framebuffer\n");
+			return -EINVAL;
+		}
+		rk_uv_obj = to_rockchip_obj(uv_obj);
+		uv_vir_stride = (fb->pitches[1] >> 2);
+		uv_mst = rk_uv_obj->dma_addr + fb->offsets[1];
+	}
+
 	/*
 	 * If this plane update changes the plane's framebuffer, (or more
 	 * precisely, if this update has a different framebuffer than the last
@@ -681,6 +717,10 @@ static int vop_update_plane_event(struct drm_plane *plane,
 	VOP_WIN_SET(vop, win, format, format);
 	VOP_WIN_SET(vop, win, yrgb_vir, y_vir_stride);
 	VOP_WIN_SET(vop, win, yrgb_mst, yrgb_mst);
+	if (is_yuv) {
+		VOP_WIN_SET(vop, win, uv_vir, uv_vir_stride);
+		VOP_WIN_SET(vop, win, uv_mst, uv_mst);
+	}
 	val = (actual_h - 1) << 16;
 	val |= (actual_w - 1) & 0xffff;
 	VOP_WIN_SET(vop, win, act_info, val);
-- 
1.7.9.5
