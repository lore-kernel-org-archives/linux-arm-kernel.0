From: ayan.halder@arm.com (Ayan Kumar Halder)
Date: Tue, 17 Jul 2018 18:13:44 +0100
Subject: [PATCH 3/5] drm/rockchip: Substitute is_yuv_support() with
 format->is_yuv
In-Reply-To: <1531847626-22248-1-git-send-email-ayan.halder@arm.com>
References: <1531847626-22248-1-git-send-email-ayan.halder@arm.com>
Message-ID: <1531847626-22248-3-git-send-email-ayan.halder@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drm_format_info table has a field 'is_yuv' to denote if the format
is yuv or not. The driver is expected to use this instead of
having a function for the same purpose.

Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index effecbe..1359e5c 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -243,18 +243,6 @@ static enum vop_data_format vop_convert_format(uint32_t format)
 	}
 }
 
-static bool is_yuv_support(uint32_t format)
-{
-	switch (format) {
-	case DRM_FORMAT_NV12:
-	case DRM_FORMAT_NV16:
-	case DRM_FORMAT_NV24:
-		return true;
-	default:
-		return false;
-	}
-}
-
 static uint16_t scl_vop_cal_scale(enum scale_mode mode, uint32_t src,
 				  uint32_t dst, bool is_horizontal,
 				  int vsu_mode, int *vskiplines)
@@ -298,7 +286,8 @@ static void scl_vop_cal_scl_fac(struct vop *vop, const struct vop_win_data *win,
 	uint16_t cbcr_ver_scl_mode = SCALE_NONE;
 	int hsub = drm_format_horz_chroma_subsampling(pixel_format);
 	int vsub = drm_format_vert_chroma_subsampling(pixel_format);
-	bool is_yuv = is_yuv_support(pixel_format);
+	const struct drm_format_info *info;
+	bool is_yuv = false;
 	uint16_t cbcr_src_w = src_w / hsub;
 	uint16_t cbcr_src_h = src_h / vsub;
 	uint16_t vsu_mode;
@@ -306,6 +295,11 @@ static void scl_vop_cal_scl_fac(struct vop *vop, const struct vop_win_data *win,
 	uint32_t val;
 	int vskiplines;
 
+	info = drm_format_info(pixel_format);
+
+	if (info->is_yuv)
+		is_yuv = true;
+
 	if (dst_w > 3840) {
 		DRM_DEV_ERROR(vop->dev, "Maximum dst width (3840) exceeded\n");
 		return;
@@ -680,7 +674,7 @@ static int vop_plane_atomic_check(struct drm_plane *plane,
 	 * Src.x1 can be odd when do clip, but yuv plane start point
 	 * need align with 2 pixel.
 	 */
-	if (is_yuv_support(fb->format->format) && ((state->src.x1 >> 16) % 2)) {
+	if (fb->format->is_yuv && ((state->src.x1 >> 16) % 2)) {
 		DRM_ERROR("Invalid Source: Yuv format not support odd xpos\n");
 		return -EINVAL;
 	}
@@ -767,7 +761,7 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 	VOP_WIN_SET(vop, win, format, format);
 	VOP_WIN_SET(vop, win, yrgb_vir, DIV_ROUND_UP(fb->pitches[0], 4));
 	VOP_WIN_SET(vop, win, yrgb_mst, dma_addr);
-	if (is_yuv_support(fb->format->format)) {
+	if (fb->format->is_yuv) {
 		int hsub = drm_format_horz_chroma_subsampling(fb->format->format);
 		int vsub = drm_format_vert_chroma_subsampling(fb->format->format);
 		int bpp = fb->format->cpp[1];
-- 
2.7.4
