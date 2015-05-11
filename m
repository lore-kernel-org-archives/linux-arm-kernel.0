From: tfiga@chromium.org (Tomasz Figa)
Date: Mon, 11 May 2015 19:55:39 +0900
Subject: [PATCH v2] drm/rockchip: Add BGR formats to VOP
Message-ID: <1431341739-12523-1-git-send-email-tfiga@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

VOP can support BGR formats in all windows thanks to red/blue swap option
provided in WINx_CTRL0 registers. This patch enables support for
ABGR8888, XBGR8888, BGR888 and BGR565 formats by using this feature.

Signed-off-by: Tomasz Figa <tfiga@chromium.org>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 33 +++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

Changes since v1:
(https://patchwork.kernel.org/patch/6369531/)
 - Fixed register addresses for win2/3 and hwc (reported by Mark Yao).

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 4557f33..6254e98 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -169,6 +169,7 @@ struct vop_win_phy {
 
 	struct vop_reg enable;
 	struct vop_reg format;
+	struct vop_reg rb_swap;
 	struct vop_reg act_info;
 	struct vop_reg dsp_info;
 	struct vop_reg dsp_st;
@@ -198,8 +199,12 @@ struct vop_data {
 static const uint32_t formats_01[] = {
 	DRM_FORMAT_XRGB8888,
 	DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_XBGR8888,
+	DRM_FORMAT_ABGR8888,
 	DRM_FORMAT_RGB888,
+	DRM_FORMAT_BGR888,
 	DRM_FORMAT_RGB565,
+	DRM_FORMAT_BGR565,
 	DRM_FORMAT_NV12,
 	DRM_FORMAT_NV16,
 	DRM_FORMAT_NV24,
@@ -208,8 +213,12 @@ static const uint32_t formats_01[] = {
 static const uint32_t formats_234[] = {
 	DRM_FORMAT_XRGB8888,
 	DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_XBGR8888,
+	DRM_FORMAT_ABGR8888,
 	DRM_FORMAT_RGB888,
+	DRM_FORMAT_BGR888,
 	DRM_FORMAT_RGB565,
+	DRM_FORMAT_BGR565,
 };
 
 static const struct vop_win_phy win01_data = {
@@ -217,6 +226,7 @@ static const struct vop_win_phy win01_data = {
 	.nformats = ARRAY_SIZE(formats_01),
 	.enable = VOP_REG(WIN0_CTRL0, 0x1, 0),
 	.format = VOP_REG(WIN0_CTRL0, 0x7, 1),
+	.rb_swap = VOP_REG(WIN0_CTRL0, 0x1, 12),
 	.act_info = VOP_REG(WIN0_ACT_INFO, 0x1fff1fff, 0),
 	.dsp_info = VOP_REG(WIN0_DSP_INFO, 0x0fff0fff, 0),
 	.dsp_st = VOP_REG(WIN0_DSP_ST, 0x1fff1fff, 0),
@@ -233,6 +243,7 @@ static const struct vop_win_phy win23_data = {
 	.nformats = ARRAY_SIZE(formats_234),
 	.enable = VOP_REG(WIN2_CTRL0, 0x1, 0),
 	.format = VOP_REG(WIN2_CTRL0, 0x7, 1),
+	.rb_swap = VOP_REG(WIN2_CTRL0, 0x1, 12),
 	.dsp_info = VOP_REG(WIN2_DSP_INFO0, 0x0fff0fff, 0),
 	.dsp_st = VOP_REG(WIN2_DSP_ST0, 0x1fff1fff, 0),
 	.yrgb_mst = VOP_REG(WIN2_MST0, 0xffffffff, 0),
@@ -246,6 +257,7 @@ static const struct vop_win_phy cursor_data = {
 	.nformats = ARRAY_SIZE(formats_234),
 	.enable = VOP_REG(HWC_CTRL0, 0x1, 0),
 	.format = VOP_REG(HWC_CTRL0, 0x7, 1),
+	.rb_swap = VOP_REG(HWC_CTRL0, 0x1, 12),
 	.dsp_st = VOP_REG(HWC_DSP_ST, 0x1fff1fff, 0),
 	.yrgb_mst = VOP_REG(HWC_MST, 0xffffffff, 0),
 };
@@ -351,15 +363,32 @@ static inline void vop_mask_write_relaxed(struct vop *vop, uint32_t offset,
 	}
 }
 
+static bool has_rb_swapped(uint32_t format)
+{
+	switch (format) {
+	case DRM_FORMAT_XBGR8888:
+	case DRM_FORMAT_ABGR8888:
+	case DRM_FORMAT_BGR888:
+	case DRM_FORMAT_BGR565:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static enum vop_data_format vop_convert_format(uint32_t format)
 {
 	switch (format) {
 	case DRM_FORMAT_XRGB8888:
 	case DRM_FORMAT_ARGB8888:
+	case DRM_FORMAT_XBGR8888:
+	case DRM_FORMAT_ABGR8888:
 		return VOP_FMT_ARGB8888;
 	case DRM_FORMAT_RGB888:
+	case DRM_FORMAT_BGR888:
 		return VOP_FMT_RGB888;
 	case DRM_FORMAT_RGB565:
+	case DRM_FORMAT_BGR565:
 		return VOP_FMT_RGB565;
 	case DRM_FORMAT_NV12:
 		return VOP_FMT_YUV420SP;
@@ -377,6 +406,7 @@ static bool is_alpha_support(uint32_t format)
 {
 	switch (format) {
 	case DRM_FORMAT_ARGB8888:
+	case DRM_FORMAT_ABGR8888:
 		return true;
 	default:
 		return false;
@@ -587,6 +617,7 @@ static int vop_update_plane_event(struct drm_plane *plane,
 	enum vop_data_format format;
 	uint32_t val;
 	bool is_alpha;
+	bool rb_swap;
 	bool visible;
 	int ret;
 	struct drm_rect dest = {
@@ -620,6 +651,7 @@ static int vop_update_plane_event(struct drm_plane *plane,
 		return 0;
 
 	is_alpha = is_alpha_support(fb->pixel_format);
+	rb_swap = has_rb_swapped(fb->pixel_format);
 	format = vop_convert_format(fb->pixel_format);
 	if (format < 0)
 		return format;
@@ -688,6 +720,7 @@ static int vop_update_plane_event(struct drm_plane *plane,
 	val = (dsp_sty - 1) << 16;
 	val |= (dsp_stx - 1) & 0xffff;
 	VOP_WIN_SET(vop, win, dsp_st, val);
+	VOP_WIN_SET(vop, win, rb_swap, rb_swap);
 
 	if (is_alpha) {
 		VOP_WIN_SET(vop, win, dst_alpha_ctl,
-- 
2.2.0.rc0.207.ga3a616c
