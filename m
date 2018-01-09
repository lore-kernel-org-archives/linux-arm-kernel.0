From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  9 Jan 2018 11:56:21 +0100
Subject: [PATCH 02/19] drm/atmel-hlcdc: Use the alpha format helper
In-Reply-To: <cover.713e47b83733ed05f0c38f5ba6ef8b6c1e32805c.1515494838.git-series.maxime.ripard@free-electrons.com>
References: <cover.713e47b83733ed05f0c38f5ba6ef8b6c1e32805c.1515494838.git-series.maxime.ripard@free-electrons.com>
Message-ID: <22c5a25fbdd56193ece1de90dc17cfa8747e7136.1515494838.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the core has a drm format helper to tell if a format embeds an
alpha component in it, let's use it.

Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 20 ++----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
index 703c2d13603f..1a9318810a29 100644
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
@@ -395,7 +381,7 @@ atmel_hlcdc_plane_update_general_settings(struct atmel_hlcdc_plane *plane,
 		cfg |= ATMEL_HLCDC_LAYER_OVR | ATMEL_HLCDC_LAYER_ITER2BL |
 		       ATMEL_HLCDC_LAYER_ITER;
 
-		if (atmel_hlcdc_format_embeds_alpha(format))
+		if (drm_format_has_alpha(format))
 			cfg |= ATMEL_HLCDC_LAYER_LAEN;
 		else
 			cfg |= ATMEL_HLCDC_LAYER_GAEN |
@@ -566,7 +552,7 @@ atmel_hlcdc_plane_prepare_disc_area(struct drm_crtc_state *c_state)
 		ovl_state = drm_plane_state_to_atmel_hlcdc_plane_state(ovl_s);
 
 		if (!ovl_s->fb ||
-		    atmel_hlcdc_format_embeds_alpha(ovl_s->fb->format->format) ||
+		    drm_format_has_alpha(ovl_s->fb->format->format) ||
 		    ovl_state->alpha != 255)
 			continue;
 
@@ -769,7 +755,7 @@ static int atmel_hlcdc_plane_atomic_check(struct drm_plane *p,
 
 	if ((state->crtc_h != state->src_h || state->crtc_w != state->src_w) &&
 	    (!desc->layout.memsize ||
-	     atmel_hlcdc_format_embeds_alpha(state->base.fb->format->format)))
+	     drm_format_has_alpha(state->base.fb->format->format)))
 		return -EINVAL;
 
 	if (state->crtc_x < 0 || state->crtc_y < 0)
-- 
git-series 0.9.1
