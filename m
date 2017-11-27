From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Mon, 27 Nov 2017 21:57:44 +0100
Subject: [PATCH 11/17] drm/sun4i: Wire in DE2 scaler support
In-Reply-To: <20171127205750.19277-1-jernej.skrabec@siol.net>
References: <20171127205750.19277-1-jernej.skrabec@siol.net>
Message-ID: <20171127205750.19277-12-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Calculate scaling parameters and call appropriate scaler set up
function.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_layer.c |  12 +++-
 drivers/gpu/drm/sun4i/sun8i_mixer.c | 115 +++++++++++++++++++++++++-----------
 drivers/gpu/drm/sun4i/sun8i_mixer.h |   4 --
 3 files changed, 90 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_layer.c b/drivers/gpu/drm/sun4i/sun8i_layer.c
index e1b6ad82145e..6860271e5415 100644
--- a/drivers/gpu/drm/sun4i/sun8i_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_layer.c
@@ -25,8 +25,11 @@
 static int sun8i_mixer_layer_atomic_check(struct drm_plane *plane,
 					  struct drm_plane_state *state)
 {
+	struct sun8i_layer *layer = plane_to_sun8i_layer(plane);
 	struct drm_crtc *crtc = state->crtc;
 	struct drm_crtc_state *crtc_state;
+	int min_scale, max_scale;
+	bool scaler_supported;
 	struct drm_rect clip;
 
 	if (!crtc)
@@ -41,9 +44,14 @@ static int sun8i_mixer_layer_atomic_check(struct drm_plane *plane,
 	clip.x2 = crtc_state->adjusted_mode.hdisplay;
 	clip.y2 = crtc_state->adjusted_mode.vdisplay;
 
+	scaler_supported = !!(layer->mixer->cfg->scaler_mask & BIT(layer->id));
+
+	min_scale = scaler_supported ? 1 : DRM_PLANE_HELPER_NO_SCALING;
+	max_scale = scaler_supported ? (1UL << 20) - 1 :
+				       DRM_PLANE_HELPER_NO_SCALING;
+
 	return drm_plane_helper_check_state(state, &clip,
-					    DRM_PLANE_HELPER_NO_SCALING,
-					    DRM_PLANE_HELPER_NO_SCALING,
+					    min_scale, max_scale,
 					    true, true);
 }
 
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index 291dd8806444..7c9c87a0535b 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -28,6 +28,7 @@
 #include "sun8i_mixer.h"
 #include "sun8i_layer.h"
 #include "sunxi_engine.h"
+#include "sun8i_scaler.h"
 
 struct de2_fmt_info {
 	u32 drm_fmt;
@@ -194,29 +195,34 @@ int sun8i_mixer_update_ui_layer_coord(struct sun8i_mixer *mixer,
 				      int layer, struct drm_plane *plane)
 {
 	struct drm_plane_state *state = plane->state;
-	u32 width, height, size;
+	u32 src_w, src_h, dst_w, dst_h;
+	u32 outsize, insize;
+	u32 hphase, vphase;
 
-	DRM_DEBUG_DRIVER("Updating layer %d\n", layer);
+	DRM_DEBUG_DRIVER("Updating UI layer %d\n", layer);
 
-	/*
-	 * Same source and destination width and height are guaranteed
-	 * by atomic check function.
-	 */
-	width = drm_rect_width(&state->dst);
-	height = drm_rect_height(&state->dst);
-	size = SUN8I_MIXER_SIZE(width, height);
+	src_w = drm_rect_width(&state->src) >> 16;
+	src_h = drm_rect_height(&state->src) >> 16;
+	dst_w = drm_rect_width(&state->dst);
+	dst_h = drm_rect_height(&state->dst);
+
+	hphase = state->src.x1 & 0xffff;
+	vphase = state->src.y1 & 0xffff;
+
+	insize = SUN8I_MIXER_SIZE(src_w, src_h);
+	outsize = SUN8I_MIXER_SIZE(dst_w, dst_h);
 
 	if (plane->type == DRM_PLANE_TYPE_PRIMARY) {
 		bool interlaced = false;
 		u32 val;
 
 		DRM_DEBUG_DRIVER("Primary layer, updating global size W: %u H: %u\n",
-				 width, height);
+				 dst_w, dst_h);
 		regmap_write(mixer->engine.regs,
 			     SUN8I_MIXER_GLOBAL_SIZE,
-			     size);
+			     outsize);
 		regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_OUTSIZE,
-			     size);
+			     outsize);
 
 		if (state->crtc)
 			interlaced = state->crtc->state->adjusted_mode.flags
@@ -237,23 +243,40 @@ int sun8i_mixer_update_ui_layer_coord(struct sun8i_mixer *mixer,
 	}
 
 	/* Set height and width */
-	DRM_DEBUG_DRIVER("Layer size W: %u H: %u\n", width, height);
+	DRM_DEBUG_DRIVER("Layer source offset X: %d Y: %d\n",
+			 state->src.x1 >> 16, state->src.y1 >> 16);
+	DRM_DEBUG_DRIVER("Layer source size W: %d H: %d\n", src_w, src_h);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_MIXER_CHAN_UI_LAYER_SIZE(layer, 0),
-		     size);
+		     SUN8I_MIXER_CHAN_UI_LAYER_SIZE(layer, 0), insize);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_MIXER_CHAN_UI_OVL_SIZE(layer),
-		     size);
+		     SUN8I_MIXER_CHAN_UI_OVL_SIZE(layer), insize);
+
+	if (insize != outsize || hphase || vphase) {
+		u32 hscale, vscale;
+
+		DRM_DEBUG_DRIVER("HW scaling is enabled\n");
+
+		hscale = state->src_w / state->crtc_w;
+		vscale = state->src_h / state->crtc_h;
+
+		sun8i_scaler_gsu_setup(mixer, layer, src_w, src_h, dst_w, dst_h,
+				       hscale, vscale, hphase, vphase);
+		sun8i_scaler_gsu_enable(mixer, layer, true);
+	} else {
+		DRM_DEBUG_DRIVER("HW scaling is not needed\n");
+		sun8i_scaler_gsu_enable(mixer, layer, false);
+	}
 
 	/* Set base coordinates */
-	DRM_DEBUG_DRIVER("Layer coordinates X: %d Y: %d\n",
+	DRM_DEBUG_DRIVER("Layer destination coordinates X: %d Y: %d\n",
 			 state->dst.x1, state->dst.y1);
+	DRM_DEBUG_DRIVER("Layer destination size W: %d H: %d\n", dst_w, dst_h);
 	regmap_write(mixer->engine.regs,
 		     SUN8I_MIXER_BLEND_ATTR_COORD(layer),
 		     SUN8I_MIXER_COORD(state->dst.x1, state->dst.y1));
 	regmap_write(mixer->engine.regs,
 		     SUN8I_MIXER_BLEND_ATTR_INSIZE(layer),
-		     size);
+		     outsize);
 
 	return 0;
 }
@@ -262,36 +285,58 @@ int sun8i_mixer_update_vi_layer_coord(struct sun8i_mixer *mixer,
 				      int layer, struct drm_plane *plane)
 {
 	struct drm_plane_state *state = plane->state;
-	u32 width, height, size;
+	u32 src_w, src_h, dst_w, dst_h;
+	u32 outsize, insize;
+	u32 hphase, vphase;
 
-	DRM_DEBUG_DRIVER("Updating layer %d\n", layer);
+	DRM_DEBUG_DRIVER("Updating VI layer %d\n", layer);
 
-	/*
-	 * Same source and destination width and height are guaranteed
-	 * by atomic check function.
-	 */
-	width = drm_rect_width(&state->dst);
-	height = drm_rect_height(&state->dst);
-	size = SUN8I_MIXER_SIZE(width, height);
+	src_w = drm_rect_width(&state->src) >> 16;
+	src_h = drm_rect_height(&state->src) >> 16;
+	dst_w = drm_rect_width(&state->dst);
+	dst_h = drm_rect_height(&state->dst);
+
+	hphase = state->src.x1 & 0xffff;
+	vphase = state->src.y1 & 0xffff;
+
+	insize = SUN8I_MIXER_SIZE(src_w, src_h);
+	outsize = SUN8I_MIXER_SIZE(dst_w, dst_h);
 
 	/* Set height and width */
-	DRM_DEBUG_DRIVER("Layer size W: %u H: %u\n", width, height);
+	DRM_DEBUG_DRIVER("Layer source offset X: %d Y: %d\n",
+			 state->src.x1 >> 16, state->src.y1 >> 16);
+	DRM_DEBUG_DRIVER("Layer source size W: %d H: %d\n", src_w, src_h);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_MIXER_CHAN_VI_LAYER_SIZE(layer, 0),
-		     size);
+		     SUN8I_MIXER_CHAN_VI_LAYER_SIZE(layer, 0), insize);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_MIXER_CHAN_VI_OVL_SIZE(layer),
-		     size);
+		     SUN8I_MIXER_CHAN_VI_OVL_SIZE(layer), insize);
+
+	if (insize != outsize || hphase || vphase) {
+		u32 hscale, vscale;
+
+		DRM_DEBUG_DRIVER("HW scaling is enabled\n");
+
+		hscale = state->src_w / state->crtc_w;
+		vscale = state->src_h / state->crtc_h;
+
+		sun8i_scaler_vsu_setup(mixer, layer, src_w, src_h, dst_w, dst_h,
+				       hscale, vscale, hphase, vphase);
+		sun8i_scaler_vsu_enable(mixer, layer, true);
+	} else {
+		DRM_DEBUG_DRIVER("HW scaling is not needed\n");
+		sun8i_scaler_vsu_enable(mixer, layer, false);
+	}
 
 	/* Set base coordinates */
-	DRM_DEBUG_DRIVER("Layer coordinates X: %d Y: %d\n",
+	DRM_DEBUG_DRIVER("Layer destination coordinates X: %d Y: %d\n",
 			 state->dst.x1, state->dst.y1);
+	DRM_DEBUG_DRIVER("Layer destination size W: %d H: %d\n", dst_w, dst_h);
 	regmap_write(mixer->engine.regs,
 		     SUN8I_MIXER_BLEND_ATTR_COORD(layer),
 		     SUN8I_MIXER_COORD(state->dst.x1, state->dst.y1));
 	regmap_write(mixer->engine.regs,
 		     SUN8I_MIXER_BLEND_ATTR_INSIZE(layer),
-		     size);
+		     outsize);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/sun8i_mixer.h
index ad5aef5846ae..355a45e6cfb4 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
@@ -124,10 +124,6 @@
  * These sub-engines are still unknown now, the EN registers are here only to
  * be used to disable these sub-engines.
  */
-#define SUN8I_MIXER_VSU_EN			0x20000
-#define SUN8I_MIXER_GSU1_EN			0x30000
-#define SUN8I_MIXER_GSU2_EN			0x40000
-#define SUN8I_MIXER_GSU3_EN			0x50000
 #define SUN8I_MIXER_FCE_EN			0xa0000
 #define SUN8I_MIXER_BWS_EN			0xa2000
 #define SUN8I_MIXER_LTI_EN			0xa4000
-- 
2.15.0
