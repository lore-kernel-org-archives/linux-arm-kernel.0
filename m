From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Mon, 27 Nov 2017 21:57:41 +0100
Subject: [PATCH 08/17] drm/sun4i: Add support for DE2 VI planes
In-Reply-To: <20171127205750.19277-1-jernej.skrabec@siol.net>
References: <20171127205750.19277-1-jernej.skrabec@siol.net>
Message-ID: <20171127205750.19277-9-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds basic support for VI planes. They are meant for video
overlay and because of that they support YUV formats too. However, using
YUV planes is not straightforward, so only RGB support for now.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_layer.c |  40 +++++++---
 drivers/gpu/drm/sun4i/sun8i_mixer.c | 144 +++++++++++++++++++++++++++++++++---
 drivers/gpu/drm/sun4i/sun8i_mixer.h |  38 ++++++++--
 3 files changed, 196 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_layer.c b/drivers/gpu/drm/sun4i/sun8i_layer.c
index 49ccdd0149bd..e1b6ad82145e 100644
--- a/drivers/gpu/drm/sun4i/sun8i_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_layer.c
@@ -47,13 +47,22 @@ static int sun8i_mixer_layer_atomic_check(struct drm_plane *plane,
 					    true, true);
 }
 
+static void sun8i_mixer_layer_enable(struct sun8i_layer *layer, bool enable)
+{
+	struct sun8i_mixer *mixer = layer->mixer;
+
+	if (layer->id < mixer->cfg->vi_num)
+		sun8i_mixer_vi_layer_enable(mixer, layer->id, enable);
+	else
+		sun8i_mixer_ui_layer_enable(mixer, layer->id, enable);
+}
+
 static void sun8i_mixer_layer_atomic_disable(struct drm_plane *plane,
 					       struct drm_plane_state *old_state)
 {
 	struct sun8i_layer *layer = plane_to_sun8i_layer(plane);
-	struct sun8i_mixer *mixer = layer->mixer;
 
-	sun8i_mixer_layer_enable(mixer, layer->id, false);
+	sun8i_mixer_layer_enable(layer, false);
 }
 
 static void sun8i_mixer_layer_atomic_update(struct drm_plane *plane,
@@ -63,14 +72,21 @@ static void sun8i_mixer_layer_atomic_update(struct drm_plane *plane,
 	struct sun8i_mixer *mixer = layer->mixer;
 
 	if (!plane->state->visible) {
-		sun8i_mixer_layer_enable(mixer, layer->id, false);
+		sun8i_mixer_layer_enable(layer, false);
 		return;
 	}
 
-	sun8i_mixer_update_layer_coord(mixer, layer->id, plane);
-	sun8i_mixer_update_layer_formats(mixer, layer->id, plane);
-	sun8i_mixer_update_layer_buffer(mixer, layer->id, plane);
-	sun8i_mixer_layer_enable(mixer, layer->id, true);
+	if (layer->id < mixer->cfg->vi_num) {
+		sun8i_mixer_update_vi_layer_coord(mixer, layer->id, plane);
+		sun8i_mixer_update_vi_layer_formats(mixer, layer->id, plane);
+		sun8i_mixer_update_vi_layer_buffer(mixer, layer->id, plane);
+	} else {
+		sun8i_mixer_update_ui_layer_coord(mixer, layer->id, plane);
+		sun8i_mixer_update_ui_layer_formats(mixer, layer->id, plane);
+		sun8i_mixer_update_ui_layer_buffer(mixer, layer->id, plane);
+	}
+
+	sun8i_mixer_layer_enable(layer, true);
 }
 
 static struct drm_plane_helper_funcs sun8i_mixer_layer_helper_funcs = {
@@ -123,7 +139,8 @@ static struct sun8i_layer *sun8i_layer_init_one(struct drm_device *drm,
 	if (!layer)
 		return ERR_PTR(-ENOMEM);
 
-	type = index == 0 ? DRM_PLANE_TYPE_PRIMARY : DRM_PLANE_TYPE_OVERLAY;
+	type = index == mixer->cfg->vi_num ?
+		DRM_PLANE_TYPE_PRIMARY : DRM_PLANE_TYPE_OVERLAY;
 
 	/* possible crtcs are set later */
 	ret = drm_universal_plane_init(drm, &layer->plane, 0,
@@ -162,17 +179,18 @@ struct drm_plane **sun8i_layers_init(struct drm_device *drm,
 	if (!planes)
 		return ERR_PTR(-ENOMEM);
 
-	for (i = 0; i < mixer->cfg->ui_num; i++) {
+	for (i = 0; i < mixer->cfg->vi_num + mixer->cfg->ui_num; i++) {
 		struct sun8i_layer *layer;
 
 		layer = sun8i_layer_init_one(drm, mixer, i);
 		if (IS_ERR(layer)) {
 			dev_err(drm->dev, "Couldn't initialize %s plane\n",
-				i ? "overlay" : "primary");
+				i == mixer->cfg->vi_num ?
+					"overlay" : "primary");
 			return ERR_CAST(layer);
 		};
 
-		layer->id = mixer->cfg->vi_num + i;
+		layer->id = i;
 		planes[i] = &layer->plane;
 	};
 
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index fe81c048cc08..dc97351be973 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -136,12 +136,13 @@ static void sun8i_mixer_commit(struct sunxi_engine *engine)
 		     SUN8I_MIXER_GLOBAL_DBUFF_ENABLE);
 }
 
-void sun8i_mixer_layer_enable(struct sun8i_mixer *mixer,
-				int layer, bool enable)
+void sun8i_mixer_ui_layer_enable(struct sun8i_mixer *mixer,
+				 int layer, bool enable)
 {
 	u32 val;
 
-	DRM_DEBUG_DRIVER("%sabling layer %d\n", enable ? "En" : "Dis", layer);
+	DRM_DEBUG_DRIVER("%sabling UI layer %d\n",
+			 enable ? "En" : "Dis", layer);
 
 	if (enable)
 		val = SUN8I_MIXER_CHAN_UI_LAYER_ATTR_EN;
@@ -162,8 +163,35 @@ void sun8i_mixer_layer_enable(struct sun8i_mixer *mixer,
 			   SUN8I_MIXER_BLEND_PIPE_CTL_EN(layer), val);
 }
 
-int sun8i_mixer_update_layer_coord(struct sun8i_mixer *mixer,
-				     int layer, struct drm_plane *plane)
+void sun8i_mixer_vi_layer_enable(struct sun8i_mixer *mixer,
+				 int layer, bool enable)
+{
+	u32 val;
+
+	DRM_DEBUG_DRIVER("%sabling VI layer %d\n",
+			 enable ? "En" : "Dis", layer);
+
+	if (enable)
+		val = SUN8I_MIXER_CHAN_VI_LAYER_ATTR_EN;
+	else
+		val = 0;
+
+	regmap_update_bits(mixer->engine.regs,
+			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR(layer, 0),
+			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR_EN, val);
+
+	if (enable)
+		val = SUN8I_MIXER_BLEND_PIPE_CTL_EN(layer);
+	else
+		val = 0;
+
+	regmap_update_bits(mixer->engine.regs,
+			   SUN8I_MIXER_BLEND_PIPE_CTL,
+			   SUN8I_MIXER_BLEND_PIPE_CTL_EN(layer), val);
+}
+
+int sun8i_mixer_update_ui_layer_coord(struct sun8i_mixer *mixer,
+				      int layer, struct drm_plane *plane)
 {
 	struct drm_plane_state *state = plane->state;
 	u32 width, height, size;
@@ -230,8 +258,46 @@ int sun8i_mixer_update_layer_coord(struct sun8i_mixer *mixer,
 	return 0;
 }
 
-int sun8i_mixer_update_layer_formats(struct sun8i_mixer *mixer,
-				       int layer, struct drm_plane *plane)
+int sun8i_mixer_update_vi_layer_coord(struct sun8i_mixer *mixer,
+				      int layer, struct drm_plane *plane)
+{
+	struct drm_plane_state *state = plane->state;
+	u32 width, height, size;
+
+	DRM_DEBUG_DRIVER("Updating layer %d\n", layer);
+
+	/*
+	 * Same source and destination width and height are guaranteed
+	 * by atomic check function.
+	 */
+	width = drm_rect_width(&state->dst);
+	height = drm_rect_height(&state->dst);
+	size = SUN8I_MIXER_SIZE(width, height);
+
+	/* Set height and width */
+	DRM_DEBUG_DRIVER("Layer size W: %u H: %u\n", width, height);
+	regmap_write(mixer->engine.regs,
+		     SUN8I_MIXER_CHAN_VI_LAYER_SIZE(layer, 0),
+		     size);
+	regmap_write(mixer->engine.regs,
+		     SUN8I_MIXER_CHAN_VI_OVL_SIZE(layer),
+		     size);
+
+	/* Set base coordinates */
+	DRM_DEBUG_DRIVER("Layer coordinates X: %d Y: %d\n",
+			 state->dst.x1, state->dst.y1);
+	regmap_write(mixer->engine.regs,
+		     SUN8I_MIXER_BLEND_ATTR_COORD(layer),
+		     SUN8I_MIXER_COORD(state->dst.x1, state->dst.y1));
+	regmap_write(mixer->engine.regs,
+		     SUN8I_MIXER_BLEND_ATTR_INSIZE(layer),
+		     size);
+
+	return 0;
+}
+
+int sun8i_mixer_update_ui_layer_formats(struct sun8i_mixer *mixer,
+					int layer, struct drm_plane *plane)
 {
 	struct drm_plane_state *state = plane->state;
 	const struct de2_fmt_info *fmt_info;
@@ -251,8 +317,31 @@ int sun8i_mixer_update_layer_formats(struct sun8i_mixer *mixer,
 	return 0;
 }
 
-int sun8i_mixer_update_layer_buffer(struct sun8i_mixer *mixer,
-				      int layer, struct drm_plane *plane)
+int sun8i_mixer_update_vi_layer_formats(struct sun8i_mixer *mixer,
+					int layer, struct drm_plane *plane)
+{
+	struct drm_plane_state *state = plane->state;
+	const struct de2_fmt_info *fmt_info;
+	u32 val;
+
+	fmt_info = sun8i_mixer_format_info(state->fb->format->format);
+	if (!fmt_info) {
+		DRM_DEBUG_DRIVER("Invalid format\n");
+		return -EINVAL;
+	}
+
+	val = fmt_info->de2_fmt << SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_OFFSET;
+	regmap_update_bits(mixer->engine.regs,
+			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR(layer, 0),
+			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR_FBFMT_MASK |
+			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR_RGB_MODE,
+			   val | SUN8I_MIXER_CHAN_VI_LAYER_ATTR_RGB_MODE);
+
+	return 0;
+}
+
+int sun8i_mixer_update_ui_layer_buffer(struct sun8i_mixer *mixer,
+				       int layer, struct drm_plane *plane)
 {
 	struct drm_plane_state *state = plane->state;
 	struct drm_framebuffer *fb = state->fb;
@@ -288,6 +377,43 @@ int sun8i_mixer_update_layer_buffer(struct sun8i_mixer *mixer,
 	return 0;
 }
 
+int sun8i_mixer_update_vi_layer_buffer(struct sun8i_mixer *mixer,
+				       int layer, struct drm_plane *plane)
+{
+	struct drm_plane_state *state = plane->state;
+	struct drm_framebuffer *fb = state->fb;
+	struct drm_gem_cma_object *gem;
+	dma_addr_t paddr;
+	int bpp;
+
+	/* Get the physical address of the buffer in memory */
+	gem = drm_fb_cma_get_gem_obj(fb, 0);
+
+	DRM_DEBUG_DRIVER("Using GEM @ %pad\n", &gem->paddr);
+
+	/* Compute the start of the displayed memory */
+	bpp = fb->format->cpp[0];
+	paddr = gem->paddr + fb->offsets[0];
+
+	/* Fixup framebuffer address for src coordinates */
+	paddr += (state->src.x1 >> 16) * bpp;
+	paddr += (state->src.y1 >> 16) * fb->pitches[0];
+
+	/* Set the line width */
+	DRM_DEBUG_DRIVER("Layer line width: %d bytes\n", fb->pitches[0]);
+	regmap_write(mixer->engine.regs,
+		     SUN8I_MIXER_CHAN_VI_LAYER_PITCH(layer, 0, 0),
+		     fb->pitches[0]);
+
+	DRM_DEBUG_DRIVER("Setting buffer address to %pad\n", &paddr);
+
+	regmap_write(mixer->engine.regs,
+		     SUN8I_MIXER_CHAN_VI_LAYER_TOP_LADDR(layer, 0, 0),
+		     lower_32_bits(paddr));
+
+	return 0;
+}
+
 static const struct sunxi_engine_ops sun8i_engine_ops = {
 	.commit		= sun8i_mixer_commit,
 	.layers_init	= sun8i_layers_init,
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/sun8i_mixer.h
index caebd9cc550f..572ef184a21a 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
@@ -81,6 +81,24 @@
 #define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_OFFSET	8
 #define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MASK	GENMASK(31, 24)
 
+#define SUN8I_MIXER_CHAN_VI_LAYER_ATTR(ch, layer) \
+		(0x2000 + 0x1000 * (ch) + 0x30 * (layer) + 0x0)
+#define SUN8I_MIXER_CHAN_VI_LAYER_SIZE(ch, layer) \
+		(0x2000 + 0x1000 * (ch) + 0x30 * (layer) + 0x4)
+#define SUN8I_MIXER_CHAN_VI_LAYER_COORD(ch, layer) \
+		(0x2000 + 0x1000 * (ch) + 0x30 * (layer) + 0x8)
+#define SUN8I_MIXER_CHAN_VI_LAYER_PITCH(ch, layer, plane) \
+		(0x2000 + 0x1000 * (ch) + 0x30 * (layer) + 0xc + 4 * (plane))
+#define SUN8I_MIXER_CHAN_VI_LAYER_TOP_LADDR(ch, layer, plane) \
+		(0x2000 + 0x1000 * (ch) + 0x30 * (layer) + 0x18 + 4 * (plane))
+#define SUN8I_MIXER_CHAN_VI_OVL_SIZE(ch)	(0x2000 + 0x1000 * (ch) + 0xe8)
+
+#define SUN8I_MIXER_CHAN_VI_LAYER_ATTR_EN		BIT(0)
+/* RGB mode should be set for RGB formats and cleared for YCbCr */
+#define SUN8I_MIXER_CHAN_VI_LAYER_ATTR_RGB_MODE		BIT(15)
+#define SUN8I_MIXER_CHAN_VI_LAYER_ATTR_FBFMT_OFFSET	8
+#define SUN8I_MIXER_CHAN_VI_LAYER_ATTR_FBFMT_MASK	GENMASK(12, 8)
+
 #define SUN8I_MIXER_FBFMT_ARGB8888	0
 #define SUN8I_MIXER_FBFMT_ABGR8888	1
 #define SUN8I_MIXER_FBFMT_RGBA8888	2
@@ -140,12 +158,20 @@ engine_to_sun8i_mixer(struct sunxi_engine *engine)
 	return container_of(engine, struct sun8i_mixer, engine);
 }
 
-void sun8i_mixer_layer_enable(struct sun8i_mixer *mixer,
-				int layer, bool enable);
-int sun8i_mixer_update_layer_coord(struct sun8i_mixer *mixer,
-				     int layer, struct drm_plane *plane);
-int sun8i_mixer_update_layer_formats(struct sun8i_mixer *mixer,
+void sun8i_mixer_ui_layer_enable(struct sun8i_mixer *mixer,
+				 int layer, bool enable);
+int sun8i_mixer_update_ui_layer_coord(struct sun8i_mixer *mixer,
+				      int layer, struct drm_plane *plane);
+int sun8i_mixer_update_ui_layer_formats(struct sun8i_mixer *mixer,
+					int layer, struct drm_plane *plane);
+int sun8i_mixer_update_ui_layer_buffer(struct sun8i_mixer *mixer,
 				       int layer, struct drm_plane *plane);
-int sun8i_mixer_update_layer_buffer(struct sun8i_mixer *mixer,
+void sun8i_mixer_vi_layer_enable(struct sun8i_mixer *mixer,
+				 int layer, bool enable);
+int sun8i_mixer_update_vi_layer_coord(struct sun8i_mixer *mixer,
 				      int layer, struct drm_plane *plane);
+int sun8i_mixer_update_vi_layer_formats(struct sun8i_mixer *mixer,
+					int layer, struct drm_plane *plane);
+int sun8i_mixer_update_vi_layer_buffer(struct sun8i_mixer *mixer,
+				       int layer, struct drm_plane *plane);
 #endif /* _SUN8I_MIXER_H_ */
-- 
2.15.0
