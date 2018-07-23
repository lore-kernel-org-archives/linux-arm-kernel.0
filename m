From: ayan.halder@arm.com (Ayan Kumar Halder)
Date: Mon, 23 Jul 2018 09:57:00 +0100
Subject: [PATCH] drm/sun4i: Use (struct drm_format_info) fields to determine
 if a format is yuv and multi planar or not.
Message-ID: <1532336220-3791-1-git-send-email-ayan.halder@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We do not need sun4i_backend_format_is_packed_yuv422() /
sun4i_backend_format_is_planar_yuv() to determine if the format is yuv multi planar
or not. (struct drm_format_info *)->is_yuv tells if the format is yuv or not.
And (struct drm_format_info *)->num_planes denotes the number of planes.

This issue was identified during a review on a previous patch:-
https://lists.freedesktop.org/archives/dri-devel/2018-July/183840.html

Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c | 37 ++++++-----------------------------
 1 file changed, 6 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index f6d8d0d..bf49c55 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -63,32 +63,6 @@ static const u32 sunxi_bt601_yuv2rgb_coef[12] = {
 	0x000004a7, 0x00000812, 0x00000000, 0x00002eb1,
 };
 
-static inline bool sun4i_backend_format_is_planar_yuv(uint32_t format)
-{
-	switch (format) {
-	case DRM_FORMAT_YUV411:
-	case DRM_FORMAT_YUV422:
-	case DRM_FORMAT_YUV444:
-		return true;
-	default:
-		return false;
-	}
-}
-
-static inline bool sun4i_backend_format_is_packed_yuv422(uint32_t format)
-{
-	switch (format) {
-	case DRM_FORMAT_YUYV:
-	case DRM_FORMAT_YVYU:
-	case DRM_FORMAT_UYVY:
-	case DRM_FORMAT_VYUY:
-		return true;
-
-	default:
-		return false;
-	}
-}
-
 static void sun4i_backend_apply_color_correction(struct sunxi_engine *engine)
 {
 	int i;
@@ -218,7 +192,8 @@ static int sun4i_backend_update_yuv_format(struct sun4i_backend *backend,
 {
 	struct drm_plane_state *state = plane->state;
 	struct drm_framebuffer *fb = state->fb;
-	uint32_t format = fb->format->format;
+	const struct drm_format_info *format = fb->format;
+	const uint32_t fmt = format->format;
 	u32 val = SUN4I_BACKEND_IYUVCTL_EN;
 	int i;
 
@@ -236,16 +211,16 @@ static int sun4i_backend_update_yuv_format(struct sun4i_backend *backend,
 			   SUN4I_BACKEND_ATTCTL_REG0_LAY_YUVEN);
 
 	/* TODO: Add support for the multi-planar YUV formats */
-	if (sun4i_backend_format_is_packed_yuv422(format))
+	if (format->num_planes == 1)
 		val |= SUN4I_BACKEND_IYUVCTL_FBFMT_PACKED_YUV422;
 	else
-		DRM_DEBUG_DRIVER("Unsupported YUV format (0x%x)\n", format);
+		DRM_DEBUG_DRIVER("Unsupported YUV format (0x%x)\n", fmt);
 
 	/*
 	 * Allwinner seems to list the pixel sequence from right to left, while
 	 * DRM lists it from left to right.
 	 */
-	switch (format) {
+	switch (fmt) {
 	case DRM_FORMAT_YUYV:
 		val |= SUN4I_BACKEND_IYUVCTL_FBPS_VYUY;
 		break;
@@ -260,7 +235,7 @@ static int sun4i_backend_update_yuv_format(struct sun4i_backend *backend,
 		break;
 	default:
 		DRM_DEBUG_DRIVER("Unsupported YUV pixel sequence (0x%x)\n",
-				 format);
+				 fmt);
 	}
 
 	regmap_write(backend->engine.regs, SUN4I_BACKEND_IYUVCTL_REG, val);
-- 
2.7.4
