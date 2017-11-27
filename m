From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Mon, 27 Nov 2017 21:57:37 +0100
Subject: [PATCH 04/17] drm/sun4i: Use values calculated by atomic check
In-Reply-To: <20171127205750.19277-1-jernej.skrabec@siol.net>
References: <20171127205750.19277-1-jernej.skrabec@siol.net>
Message-ID: <20171127205750.19277-5-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have properly clipped coordinates in plane state structure,
use them.

This also fixes bug where source x and y were adjusted for negative
value, but width and height weren't. It wasn't discovered because
primary plane usually doesn't have negative coordinates.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_layer.c |  5 ++++
 drivers/gpu/drm/sun4i/sun8i_mixer.c | 52 ++++++++++++++++---------------------
 2 files changed, 27 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_layer.c b/drivers/gpu/drm/sun4i/sun8i_layer.c
index 54739e12311d..511d2f8afef6 100644
--- a/drivers/gpu/drm/sun4i/sun8i_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_layer.c
@@ -68,6 +68,11 @@ static void sun8i_mixer_layer_atomic_update(struct drm_plane *plane,
 	struct sun8i_layer *layer = plane_to_sun8i_layer(plane);
 	struct sun8i_mixer *mixer = layer->mixer;
 
+	if (!plane->state->visible) {
+		sun8i_mixer_layer_enable(mixer, layer->id, false);
+		return;
+	}
+
 	sun8i_mixer_update_layer_coord(mixer, layer->id, plane);
 	sun8i_mixer_update_layer_formats(mixer, layer->id, plane);
 	sun8i_mixer_update_layer_buffer(mixer, layer->id, plane);
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index 37eb5f6f8ee8..6aa3240186c1 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -91,28 +91,34 @@ int sun8i_mixer_update_layer_coord(struct sun8i_mixer *mixer,
 {
 	struct drm_plane_state *state = plane->state;
 	struct drm_framebuffer *fb = state->fb;
+	u32 width, height, size;
 
 	DRM_DEBUG_DRIVER("Updating layer %d\n", layer);
 
+	/*
+	 * Same source and destination width and height are guaranteed
+	 * by atomic check function.
+	 */
+	width = drm_rect_width(&state->dst);
+	height = drm_rect_height(&state->dst);
+	size = SUN8I_MIXER_SIZE(width, height);
+
 	if (plane->type == DRM_PLANE_TYPE_PRIMARY) {
 		DRM_DEBUG_DRIVER("Primary layer, updating global size W: %u H: %u\n",
-				 state->crtc_w, state->crtc_h);
-		regmap_write(mixer->engine.regs, SUN8I_MIXER_GLOBAL_SIZE,
-			     SUN8I_MIXER_SIZE(state->crtc_w,
-					      state->crtc_h));
+				 width, height);
+		regmap_write(mixer->engine.regs,
+			     SUN8I_MIXER_GLOBAL_SIZE,
+			     size);
 		DRM_DEBUG_DRIVER("Updating blender size\n");
 		regmap_write(mixer->engine.regs,
 			     SUN8I_MIXER_BLEND_ATTR_INSIZE(layer),
-			     SUN8I_MIXER_SIZE(state->crtc_w,
-					      state->crtc_h));
+			     size);
 		regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_OUTSIZE,
-			     SUN8I_MIXER_SIZE(state->crtc_w,
-					      state->crtc_h));
+			     size);
 		DRM_DEBUG_DRIVER("Updating channel size\n");
 		regmap_write(mixer->engine.regs,
 			     SUN8I_MIXER_CHAN_UI_OVL_SIZE(layer),
-			     SUN8I_MIXER_SIZE(state->crtc_w,
-					      state->crtc_h));
+			     size);
 	}
 
 	/* Set the line width */
@@ -122,18 +128,17 @@ int sun8i_mixer_update_layer_coord(struct sun8i_mixer *mixer,
 		     fb->pitches[0]);
 
 	/* Set height and width */
-	DRM_DEBUG_DRIVER("Layer size W: %u H: %u\n",
-			 state->crtc_w, state->crtc_h);
+	DRM_DEBUG_DRIVER("Layer size W: %u H: %u\n", width, height);
 	regmap_write(mixer->engine.regs,
 		     SUN8I_MIXER_CHAN_UI_LAYER_SIZE(layer, 0),
-		     SUN8I_MIXER_SIZE(state->crtc_w, state->crtc_h));
+		     size);
 
 	/* Set base coordinates */
 	DRM_DEBUG_DRIVER("Layer coordinates X: %d Y: %d\n",
-			 state->crtc_x, state->crtc_y);
+			 state->dst.x1, state->dst.y1);
 	regmap_write(mixer->engine.regs,
 		     SUN8I_MIXER_BLEND_ATTR_COORD(layer),
-		     SUN8I_MIXER_COORD(state->crtc_x, state->crtc_y));
+		     SUN8I_MIXER_COORD(state->dst.x1, state->dst.y1));
 
 	return 0;
 }
@@ -193,21 +198,8 @@ int sun8i_mixer_update_layer_buffer(struct sun8i_mixer *mixer,
 	paddr = gem->paddr + fb->offsets[0];
 
 	/* Fixup framebuffer address for src coordinates */
-	paddr += (state->src_x >> 16) * bpp;
-	paddr += (state->src_y >> 16) * fb->pitches[0];
-
-	/*
-	 * The hardware cannot correctly deal with negative crtc
-	 * coordinates, the display is cropped to the requested size,
-	 * but the display content is not moved.
-	 * Manually move the display content by fixup the framebuffer
-	 * address when crtc_x or crtc_y is negative, like what we
-	 * have did for src_x and src_y.
-	 */
-	if (state->crtc_x < 0)
-		paddr += -state->crtc_x * bpp;
-	if (state->crtc_y < 0)
-		paddr += -state->crtc_y * fb->pitches[0];
+	paddr += (state->src.x1 >> 16) * bpp;
+	paddr += (state->src.y1 >> 16) * fb->pitches[0];
 
 	DRM_DEBUG_DRIVER("Setting buffer address to %pad\n", &paddr);
 
-- 
2.15.0
