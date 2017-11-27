From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Mon, 27 Nov 2017 21:57:35 +0100
Subject: [PATCH 02/17] drm/sun4i: Start using layer id in DE2 driver
In-Reply-To: <20171127205750.19277-1-jernej.skrabec@siol.net>
References: <20171127205750.19277-1-jernej.skrabec@siol.net>
Message-ID: <20171127205750.19277-3-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Till now, plane selection was hardcoded to first overlay in first UI
channel.

It turns out that overlays don't fit well in current DRM design, because
they can't be blended together or scaled independetly when they are set
to same channel.

Beause of that, always use only first overlay in each channel. This
simplifies things, since layer parameter can be then used as channel
selection.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_layer.c |  2 +-
 drivers/gpu/drm/sun4i/sun8i_mixer.c | 31 +++++++++++--------------------
 2 files changed, 12 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_layer.c b/drivers/gpu/drm/sun4i/sun8i_layer.c
index 23810ff72684..5b2d45a9db8a 100644
--- a/drivers/gpu/drm/sun4i/sun8i_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_layer.c
@@ -126,7 +126,7 @@ struct drm_plane **sun8i_layers_init(struct drm_device *drm,
 			return ERR_CAST(layer);
 		};
 
-		layer->id = i;
+		layer->id = mixer->cfg->vi_num + i;
 		planes[i] = &layer->plane;
 	};
 
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index 015943c0ed5a..37eb5f6f8ee8 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -41,11 +41,8 @@ void sun8i_mixer_layer_enable(struct sun8i_mixer *mixer,
 				int layer, bool enable)
 {
 	u32 val;
-	/* Currently the first UI channel is used */
-	int chan = mixer->cfg->vi_num;
 
-	DRM_DEBUG_DRIVER("%sabling layer %d in channel %d\n",
-			 enable ? "En" : "Dis", layer, chan);
+	DRM_DEBUG_DRIVER("%sabling layer %d\n", enable ? "En" : "Dis", layer);
 
 	if (enable)
 		val = SUN8I_MIXER_CHAN_UI_LAYER_ATTR_EN;
@@ -53,17 +50,17 @@ void sun8i_mixer_layer_enable(struct sun8i_mixer *mixer,
 		val = 0;
 
 	regmap_update_bits(mixer->engine.regs,
-			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(chan, layer),
+			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(layer, 0),
 			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_EN, val);
 
 	if (enable)
-		val = SUN8I_MIXER_BLEND_PIPE_CTL_EN(chan);
+		val = SUN8I_MIXER_BLEND_PIPE_CTL_EN(layer);
 	else
 		val = 0;
 
 	regmap_update_bits(mixer->engine.regs,
 			   SUN8I_MIXER_BLEND_PIPE_CTL,
-			   SUN8I_MIXER_BLEND_PIPE_CTL_EN(chan), val);
+			   SUN8I_MIXER_BLEND_PIPE_CTL_EN(layer), val);
 }
 
 static int sun8i_mixer_drm_format_to_layer(struct drm_plane *plane,
@@ -94,8 +91,6 @@ int sun8i_mixer_update_layer_coord(struct sun8i_mixer *mixer,
 {
 	struct drm_plane_state *state = plane->state;
 	struct drm_framebuffer *fb = state->fb;
-	/* Currently the first UI channel is used */
-	int chan = mixer->cfg->vi_num;
 
 	DRM_DEBUG_DRIVER("Updating layer %d\n", layer);
 
@@ -107,7 +102,7 @@ int sun8i_mixer_update_layer_coord(struct sun8i_mixer *mixer,
 					      state->crtc_h));
 		DRM_DEBUG_DRIVER("Updating blender size\n");
 		regmap_write(mixer->engine.regs,
-			     SUN8I_MIXER_BLEND_ATTR_INSIZE(chan),
+			     SUN8I_MIXER_BLEND_ATTR_INSIZE(layer),
 			     SUN8I_MIXER_SIZE(state->crtc_w,
 					      state->crtc_h));
 		regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_OUTSIZE,
@@ -115,7 +110,7 @@ int sun8i_mixer_update_layer_coord(struct sun8i_mixer *mixer,
 					      state->crtc_h));
 		DRM_DEBUG_DRIVER("Updating channel size\n");
 		regmap_write(mixer->engine.regs,
-			     SUN8I_MIXER_CHAN_UI_OVL_SIZE(chan),
+			     SUN8I_MIXER_CHAN_UI_OVL_SIZE(layer),
 			     SUN8I_MIXER_SIZE(state->crtc_w,
 					      state->crtc_h));
 	}
@@ -123,21 +118,21 @@ int sun8i_mixer_update_layer_coord(struct sun8i_mixer *mixer,
 	/* Set the line width */
 	DRM_DEBUG_DRIVER("Layer line width: %d bytes\n", fb->pitches[0]);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_MIXER_CHAN_UI_LAYER_PITCH(chan, layer),
+		     SUN8I_MIXER_CHAN_UI_LAYER_PITCH(layer, 0),
 		     fb->pitches[0]);
 
 	/* Set height and width */
 	DRM_DEBUG_DRIVER("Layer size W: %u H: %u\n",
 			 state->crtc_w, state->crtc_h);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_MIXER_CHAN_UI_LAYER_SIZE(chan, layer),
+		     SUN8I_MIXER_CHAN_UI_LAYER_SIZE(layer, 0),
 		     SUN8I_MIXER_SIZE(state->crtc_w, state->crtc_h));
 
 	/* Set base coordinates */
 	DRM_DEBUG_DRIVER("Layer coordinates X: %d Y: %d\n",
 			 state->crtc_x, state->crtc_y);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_MIXER_CHAN_UI_LAYER_COORD(chan, layer),
+		     SUN8I_MIXER_BLEND_ATTR_COORD(layer),
 		     SUN8I_MIXER_COORD(state->crtc_x, state->crtc_y));
 
 	return 0;
@@ -150,8 +145,6 @@ int sun8i_mixer_update_layer_formats(struct sun8i_mixer *mixer,
 	struct drm_framebuffer *fb = state->fb;
 	bool interlaced = false;
 	u32 val;
-	/* Currently the first UI channel is used */
-	int chan = mixer->cfg->vi_num;
 	int ret;
 
 	if (plane->state->crtc)
@@ -175,7 +168,7 @@ int sun8i_mixer_update_layer_formats(struct sun8i_mixer *mixer,
 
 	val <<= SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_OFFSET;
 	regmap_update_bits(mixer->engine.regs,
-			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(chan, layer),
+			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(layer, 0),
 			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_MASK, val);
 
 	return 0;
@@ -188,8 +181,6 @@ int sun8i_mixer_update_layer_buffer(struct sun8i_mixer *mixer,
 	struct drm_framebuffer *fb = state->fb;
 	struct drm_gem_cma_object *gem;
 	dma_addr_t paddr;
-	/* Currently the first UI channel is used */
-	int chan = mixer->cfg->vi_num;
 	int bpp;
 
 	/* Get the physical address of the buffer in memory */
@@ -221,7 +212,7 @@ int sun8i_mixer_update_layer_buffer(struct sun8i_mixer *mixer,
 	DRM_DEBUG_DRIVER("Setting buffer address to %pad\n", &paddr);
 
 	regmap_write(mixer->engine.regs,
-		     SUN8I_MIXER_CHAN_UI_LAYER_TOP_LADDR(chan, layer),
+		     SUN8I_MIXER_CHAN_UI_LAYER_TOP_LADDR(layer, 0),
 		     lower_32_bits(paddr));
 
 	return 0;
-- 
2.15.0
