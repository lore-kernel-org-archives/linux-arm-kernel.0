From: ayan.halder@arm.com (Ayan Kumar Halder)
Date: Tue, 17 Jul 2018 18:13:46 +0100
Subject: [PATCH 5/5] drm/sun4i: Substitute sun4i_backend_format_is_yuv() with
 format->is_yuv
In-Reply-To: <1531847626-22248-1-git-send-email-ayan.halder@arm.com>
References: <1531847626-22248-1-git-send-email-ayan.halder@arm.com>
Message-ID: <1531847626-22248-5-git-send-email-ayan.halder@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drm_format_info table has a field 'is_yuv' to denote if the format
is yuv or not. The driver is expected to use this instead of
having a function for the same purpose.

Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index de0a76d..d7950b5 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -86,12 +86,6 @@ static inline bool sun4i_backend_format_is_packed_yuv422(uint32_t format)
 	}
 }
 
-static inline bool sun4i_backend_format_is_yuv(uint32_t format)
-{
-	return sun4i_backend_format_is_planar_yuv(format) ||
-		sun4i_backend_format_is_packed_yuv422(format);
-}
-
 static void sun4i_backend_apply_color_correction(struct sunxi_engine *engine)
 {
 	int i;
@@ -304,7 +298,7 @@ int sun4i_backend_update_layer_formats(struct sun4i_backend *backend,
 			   SUN4I_BACKEND_ATTCTL_REG0_LAY_GLBALPHA_EN,
 			   val);
 
-	if (sun4i_backend_format_is_yuv(fb->format->format))
+	if (fb->format->is_yuv)
 		return sun4i_backend_update_yuv_format(backend, layer, plane);
 
 	ret = sun4i_backend_drm_format_to_layer(fb->format->format, &val);
@@ -384,7 +378,7 @@ int sun4i_backend_update_layer_buffer(struct sun4i_backend *backend,
 	 */
 	paddr -= PHYS_OFFSET;
 
-	if (sun4i_backend_format_is_yuv(fb->format->format))
+	if (fb->format->is_yuv)
 		return sun4i_backend_update_yuv_buffer(backend, fb, paddr);
 
 	/* Write the 32 lower bits of the address (in bits) */
@@ -502,7 +496,7 @@ static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
 		if (fb->format->has_alpha || (plane_state->alpha != DRM_BLEND_ALPHA_OPAQUE))
 			num_alpha_planes++;
 
-		if (sun4i_backend_format_is_yuv(fb->format->format)) {
+		if (fb->format->is_yuv) {
 			DRM_DEBUG_DRIVER("Plane FB format is YUV\n");
 			num_yuv_planes++;
 		}
-- 
2.7.4
