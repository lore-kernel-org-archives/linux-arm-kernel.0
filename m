From: mark.yao@rock-chips.com (Mark Yao)
Date: Tue, 21 Jul 2015 16:20:04 +0800
Subject: [PATCH v3 3/6] drm/rockchip: vop: Add yuv plane support
In-Reply-To: <1437466807-13689-1-git-send-email-mark.yao@rock-chips.com>
References: <1437466807-13689-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1437466807-13689-4-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

vop support yuv with NV12, NV16 and NV24, only 2 plane yuv.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
Changes in v3:
Adviced by Tomasz Figa
- separate dest calculate to another patch
- fix src x1,x2 when do align, and remove unnecessary src.y1 align.

Changes in v2:
- Uv buffer not support odd offset, align it.
- Fix error display when move yuv image.  

 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |   56 ++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index c7e0283..47ce943 100644
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
+	unsigned int uv_vir_stride = 0;
 	dma_addr_t yrgb_mst;
+	dma_addr_t uv_mst = 0;
 	enum vop_data_format format;
 	uint32_t val;
 	bool is_alpha;
+	bool is_yuv;
 	bool visible;
 	int ret;
 	struct drm_rect dest = {
@@ -620,6 +637,8 @@ static int vop_update_plane_event(struct drm_plane *plane,
 		return 0;
 
 	is_alpha = is_alpha_support(fb->pixel_format);
+	is_yuv = is_yuv_support(fb->pixel_format);
+
 	format = vop_convert_format(fb->pixel_format);
 	if (format < 0)
 		return format;
@@ -632,18 +651,47 @@ static int vop_update_plane_event(struct drm_plane *plane,
 
 	rk_obj = to_rockchip_obj(obj);
 
+	if (is_yuv) {
+		/*
+		 * Src.x1 can be odd when do clip, but yuv plane start point
+		 * need align with 2 pixel.
+		 */
+		val = (src.x1 >> 16) % 2;
+		src.x1 += val << 16;
+		src.x2 += val << 16;
+	}
+
 	actual_w = (src.x2 - src.x1) >> 16;
 	actual_h = (src.y2 - src.y1) >> 16;
 
 	dsp_stx = dest.x1 + crtc->mode.htotal - crtc->mode.hsync_start;
 	dsp_sty = dest.y1 + crtc->mode.vtotal - crtc->mode.vsync_start;
 
-	offset = (src.x1 >> 16) * (fb->bits_per_pixel >> 3);
+	offset = (src.x1 >> 16) * drm_format_plane_cpp(fb->pixel_format, 0);
 	offset += (src.y1 >> 16) * fb->pitches[0];
-	yrgb_mst = rk_obj->dma_addr + offset;
 
+	yrgb_mst = rk_obj->dma_addr + offset + fb->offsets[0];
 	y_vir_stride = fb->pitches[0] >> 2;
 
+	if (is_yuv) {
+		int hsub = drm_format_horz_chroma_subsampling(fb->pixel_format);
+		int vsub = drm_format_vert_chroma_subsampling(fb->pixel_format);
+		int bpp = drm_format_plane_cpp(fb->pixel_format, 1);
+
+		uv_obj = rockchip_fb_get_gem_obj(fb, 1);
+		if (!uv_obj) {
+			DRM_ERROR("fail to get uv object from framebuffer\n");
+			return -EINVAL;
+		}
+		rk_uv_obj = to_rockchip_obj(uv_obj);
+		uv_vir_stride = fb->pitches[1] >> 2;
+
+		offset = (src.x1 >> 16) * bpp / hsub;
+		offset += (src.y1 >> 16) * fb->pitches[1] / vsub;
+
+		uv_mst = rk_uv_obj->dma_addr + offset + fb->offsets[1];
+	}
+
 	/*
 	 * If this plane update changes the plane's framebuffer, (or more
 	 * precisely, if this update has a different framebuffer than the last
@@ -679,6 +727,10 @@ static int vop_update_plane_event(struct drm_plane *plane,
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
