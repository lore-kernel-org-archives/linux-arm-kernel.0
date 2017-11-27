From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Mon, 27 Nov 2017 21:57:38 +0100
Subject: [PATCH 05/17] drm/sun4i: Reorder some code in DE2
In-Reply-To: <20171127205750.19277-1-jernej.skrabec@siol.net>
References: <20171127205750.19277-1-jernej.skrabec@siol.net>
Message-ID: <20171127205750.19277-6-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While DE2 driver works, parts of the code are not in optimal place. Reorder
it so it will be easier to support multiple planes.

This commit doesn't do any functional change besides removing two not
very useful debug messages.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c | 60 ++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index 6aa3240186c1..c1b7685603fe 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -90,7 +90,6 @@ int sun8i_mixer_update_layer_coord(struct sun8i_mixer *mixer,
 				     int layer, struct drm_plane *plane)
 {
 	struct drm_plane_state *state = plane->state;
-	struct drm_framebuffer *fb = state->fb;
 	u32 width, height, size;
 
 	DRM_DEBUG_DRIVER("Updating layer %d\n", layer);
@@ -104,34 +103,43 @@ int sun8i_mixer_update_layer_coord(struct sun8i_mixer *mixer,
 	size = SUN8I_MIXER_SIZE(width, height);
 
 	if (plane->type == DRM_PLANE_TYPE_PRIMARY) {
+		bool interlaced = false;
+		u32 val;
+
 		DRM_DEBUG_DRIVER("Primary layer, updating global size W: %u H: %u\n",
 				 width, height);
 		regmap_write(mixer->engine.regs,
 			     SUN8I_MIXER_GLOBAL_SIZE,
 			     size);
-		DRM_DEBUG_DRIVER("Updating blender size\n");
-		regmap_write(mixer->engine.regs,
-			     SUN8I_MIXER_BLEND_ATTR_INSIZE(layer),
-			     size);
 		regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_OUTSIZE,
 			     size);
-		DRM_DEBUG_DRIVER("Updating channel size\n");
-		regmap_write(mixer->engine.regs,
-			     SUN8I_MIXER_CHAN_UI_OVL_SIZE(layer),
-			     size);
-	}
 
-	/* Set the line width */
-	DRM_DEBUG_DRIVER("Layer line width: %d bytes\n", fb->pitches[0]);
-	regmap_write(mixer->engine.regs,
-		     SUN8I_MIXER_CHAN_UI_LAYER_PITCH(layer, 0),
-		     fb->pitches[0]);
+		if (state->crtc)
+			interlaced = state->crtc->state->adjusted_mode.flags
+				& DRM_MODE_FLAG_INTERLACE;
+
+		if (interlaced)
+			val = SUN8I_MIXER_BLEND_OUTCTL_INTERLACED;
+		else
+			val = 0;
+
+		regmap_update_bits(mixer->engine.regs,
+				   SUN8I_MIXER_BLEND_OUTCTL,
+				   SUN8I_MIXER_BLEND_OUTCTL_INTERLACED,
+				   val);
+
+		DRM_DEBUG_DRIVER("Switching display mixer interlaced mode %s\n",
+				 interlaced ? "on" : "off");
+	}
 
 	/* Set height and width */
 	DRM_DEBUG_DRIVER("Layer size W: %u H: %u\n", width, height);
 	regmap_write(mixer->engine.regs,
 		     SUN8I_MIXER_CHAN_UI_LAYER_SIZE(layer, 0),
 		     size);
+	regmap_write(mixer->engine.regs,
+		     SUN8I_MIXER_CHAN_UI_OVL_SIZE(layer),
+		     size);
 
 	/* Set base coordinates */
 	DRM_DEBUG_DRIVER("Layer coordinates X: %d Y: %d\n",
@@ -139,6 +147,9 @@ int sun8i_mixer_update_layer_coord(struct sun8i_mixer *mixer,
 	regmap_write(mixer->engine.regs,
 		     SUN8I_MIXER_BLEND_ATTR_COORD(layer),
 		     SUN8I_MIXER_COORD(state->dst.x1, state->dst.y1));
+	regmap_write(mixer->engine.regs,
+		     SUN8I_MIXER_BLEND_ATTR_INSIZE(layer),
+		     size);
 
 	return 0;
 }
@@ -148,22 +159,9 @@ int sun8i_mixer_update_layer_formats(struct sun8i_mixer *mixer,
 {
 	struct drm_plane_state *state = plane->state;
 	struct drm_framebuffer *fb = state->fb;
-	bool interlaced = false;
 	u32 val;
 	int ret;
 
-	if (plane->state->crtc)
-		interlaced = plane->state->crtc->state->adjusted_mode.flags
-			& DRM_MODE_FLAG_INTERLACE;
-
-	regmap_update_bits(mixer->engine.regs, SUN8I_MIXER_BLEND_OUTCTL,
-			   SUN8I_MIXER_BLEND_OUTCTL_INTERLACED,
-			   interlaced ?
-			   SUN8I_MIXER_BLEND_OUTCTL_INTERLACED : 0);
-
-	DRM_DEBUG_DRIVER("Switching display mixer interlaced mode %s\n",
-			 interlaced ? "on" : "off");
-
 	ret = sun8i_mixer_drm_format_to_layer(plane, fb->format->format,
 						&val);
 	if (ret) {
@@ -201,6 +199,12 @@ int sun8i_mixer_update_layer_buffer(struct sun8i_mixer *mixer,
 	paddr += (state->src.x1 >> 16) * bpp;
 	paddr += (state->src.y1 >> 16) * fb->pitches[0];
 
+	/* Set the line width */
+	DRM_DEBUG_DRIVER("Layer line width: %d bytes\n", fb->pitches[0]);
+	regmap_write(mixer->engine.regs,
+		     SUN8I_MIXER_CHAN_UI_LAYER_PITCH(layer, 0),
+		     fb->pitches[0]);
+
 	DRM_DEBUG_DRIVER("Setting buffer address to %pad\n", &paddr);
 
 	regmap_write(mixer->engine.regs,
-- 
2.15.0
