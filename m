From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 22 Jan 2018 11:35:31 +0100
Subject: [PATCH v2 02/19] drm/atmel-hlcdc: Use the alpha format field in
 drm_format_info
In-Reply-To: <cover.9e7b6a702e4d90a13d08fbe3b0a319cbf4db687f.1516617243.git-series.maxime.ripard@free-electrons.com>
References: <cover.9e7b6a702e4d90a13d08fbe3b0a319cbf4db687f.1516617243.git-series.maxime.ripard@free-electrons.com>
Message-ID: <23518426a46320dd884465cebec0961f839f2972.1516617243.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the drm_format_info has a alpha field to tell if a format embeds
an alpha component in it, let's use it.

Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Reviewed-by: Daniel Vetter <daniel.vetter@intel.com>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 24 +++---------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
index 703c2d13603f..e18800ed7cd1 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
@@ -194,20 +194,6 @@ static int atmel_hlcdc_format_to_plane_mode(u32 format, u32 *mode)
 	return 0;
 }
 
-static bool atmel_hlcdc_format_embeds_alpha(u32 format)
-{
-	int i;
-
-	for (i = 0; i < sizeof(format); i++) {
-		char tmp = (format >> (8 * i)) & 0xff;
-
-		if (tmp == 'A')
-			return true;
-	}
-
-	return false;
-}
-
 static u32 heo_downscaling_xcoef[] = {
 	0x11343311,
 	0x000000f7,
@@ -377,13 +363,13 @@ atmel_hlcdc_plane_update_general_settings(struct atmel_hlcdc_plane *plane,
 {
 	unsigned int cfg = ATMEL_HLCDC_LAYER_DMA_BLEN_INCR16 | state->ahb_id;
 	const struct atmel_hlcdc_layer_desc *desc = plane->layer.desc;
-	u32 format = state->base.fb->format->format;
+	const struct drm_format_info *format = state->base.fb->format;
 
 	/*
 	 * Rotation optimization is not working on RGB888 (rotation is still
 	 * working but without any optimization).
 	 */
-	if (format == DRM_FORMAT_RGB888)
+	if (format->format == DRM_FORMAT_RGB888)
 		cfg |= ATMEL_HLCDC_LAYER_DMA_ROTDIS;
 
 	atmel_hlcdc_layer_write_cfg(&plane->layer, ATMEL_HLCDC_LAYER_DMA_CFG,
@@ -395,7 +381,7 @@ atmel_hlcdc_plane_update_general_settings(struct atmel_hlcdc_plane *plane,
 		cfg |= ATMEL_HLCDC_LAYER_OVR | ATMEL_HLCDC_LAYER_ITER2BL |
 		       ATMEL_HLCDC_LAYER_ITER;
 
-		if (atmel_hlcdc_format_embeds_alpha(format))
+		if (format->has_alpha)
 			cfg |= ATMEL_HLCDC_LAYER_LAEN;
 		else
 			cfg |= ATMEL_HLCDC_LAYER_GAEN |
@@ -566,7 +552,7 @@ atmel_hlcdc_plane_prepare_disc_area(struct drm_crtc_state *c_state)
 		ovl_state = drm_plane_state_to_atmel_hlcdc_plane_state(ovl_s);
 
 		if (!ovl_s->fb ||
-		    atmel_hlcdc_format_embeds_alpha(ovl_s->fb->format->format) ||
+		    ovl_s->fb->format->has_alpha ||
 		    ovl_state->alpha != 255)
 			continue;
 
@@ -769,7 +755,7 @@ static int atmel_hlcdc_plane_atomic_check(struct drm_plane *p,
 
 	if ((state->crtc_h != state->src_h || state->crtc_w != state->src_w) &&
 	    (!desc->layout.memsize ||
-	     atmel_hlcdc_format_embeds_alpha(state->base.fb->format->format)))
+	     state->base.fb->format->has_alpha))
 		return -EINVAL;
 
 	if (state->crtc_x < 0 || state->crtc_y < 0)
-- 
git-series 0.9.1
