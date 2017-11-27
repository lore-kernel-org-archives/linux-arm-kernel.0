From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Mon, 27 Nov 2017 21:57:49 +0100
Subject: [PATCH 16/17] drm/sun4i: Wire in DE2 YUV support
In-Reply-To: <20171127205750.19277-1-jernej.skrabec@siol.net>
References: <20171127205750.19277-1-jernej.skrabec@siol.net>
Message-ID: <20171127205750.19277-17-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have all required bits, add support for YUV formats.

DRM subsystem doesn't know YUV411 semi-planar format, so leave that out
for now.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_layer.c |  56 +++++++++++++++++-
 drivers/gpu/drm/sun4i/sun8i_mixer.c | 110 +++++++++++++++++++++++++++---------
 2 files changed, 137 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_layer.c b/drivers/gpu/drm/sun4i/sun8i_layer.c
index 6860271e5415..9e431eaa3430 100644
--- a/drivers/gpu/drm/sun4i/sun8i_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_layer.c
@@ -112,7 +112,7 @@ static const struct drm_plane_funcs sun8i_mixer_layer_funcs = {
 	.update_plane		= drm_atomic_helper_update_plane,
 };
 
-static const uint32_t sun8i_mixer_layer_formats[] = {
+static const u32 sun8i_mixer_ui_layer_formats[] = {
 	DRM_FORMAT_ABGR1555,
 	DRM_FORMAT_ABGR4444,
 	DRM_FORMAT_ABGR8888,
@@ -135,26 +135,76 @@ static const uint32_t sun8i_mixer_layer_formats[] = {
 	DRM_FORMAT_XRGB8888,
 };
 
+/*
+ * While all RGB formats are supported, VI planes don't support
+ * alpha blending, so there is no point having formats with alpha
+ * channel if their opaque analog exist.
+ */
+static const u32 sun8i_mixer_vi_layer_formats[] = {
+	DRM_FORMAT_ABGR1555,
+	DRM_FORMAT_ABGR4444,
+	DRM_FORMAT_ARGB1555,
+	DRM_FORMAT_ARGB4444,
+	DRM_FORMAT_BGR565,
+	DRM_FORMAT_BGR888,
+	DRM_FORMAT_BGRA5551,
+	DRM_FORMAT_BGRA4444,
+	DRM_FORMAT_BGRX8888,
+	DRM_FORMAT_RGB565,
+	DRM_FORMAT_RGB888,
+	DRM_FORMAT_RGBA4444,
+	DRM_FORMAT_RGBA5551,
+	DRM_FORMAT_RGBX8888,
+	DRM_FORMAT_XBGR8888,
+	DRM_FORMAT_XRGB8888,
+
+	DRM_FORMAT_NV16,
+	DRM_FORMAT_NV12,
+	DRM_FORMAT_NV21,
+	DRM_FORMAT_NV61,
+	DRM_FORMAT_UYVY,
+	DRM_FORMAT_VYUY,
+	DRM_FORMAT_YUYV,
+	DRM_FORMAT_YVYU,
+	DRM_FORMAT_YUV411,
+	DRM_FORMAT_YUV420,
+	DRM_FORMAT_YUV422,
+	DRM_FORMAT_YUV444,
+	DRM_FORMAT_YVU411,
+	DRM_FORMAT_YVU420,
+	DRM_FORMAT_YVU422,
+	DRM_FORMAT_YVU444,
+};
+
 static struct sun8i_layer *sun8i_layer_init_one(struct drm_device *drm,
 						struct sun8i_mixer *mixer,
 						int index)
 {
 	struct sun8i_layer *layer;
 	enum drm_plane_type type;
+	unsigned int format_cnt;
+	const u32 *formats;
 	int ret;
 
 	layer = devm_kzalloc(drm->dev, sizeof(*layer), GFP_KERNEL);
 	if (!layer)
 		return ERR_PTR(-ENOMEM);
 
+	if (index < mixer->cfg->vi_num) {
+		formats = sun8i_mixer_vi_layer_formats;
+		format_cnt = ARRAY_SIZE(sun8i_mixer_vi_layer_formats);
+	} else {
+		formats = sun8i_mixer_ui_layer_formats;
+		format_cnt = ARRAY_SIZE(sun8i_mixer_ui_layer_formats);
+	}
+
 	type = index == mixer->cfg->vi_num ?
 		DRM_PLANE_TYPE_PRIMARY : DRM_PLANE_TYPE_OVERLAY;
 
 	/* possible crtcs are set later */
 	ret = drm_universal_plane_init(drm, &layer->plane, 0,
 				       &sun8i_mixer_layer_funcs,
-				       sun8i_mixer_layer_formats,
-				       ARRAY_SIZE(sun8i_mixer_layer_formats),
+				       formats, format_cnt,
 				       NULL, type, NULL);
 	if (ret) {
 		dev_err(drm->dev, "Couldn't initialize layer\n");
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index 6fb7dfd789f9..4d2b42804008 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -428,6 +428,7 @@ int sun8i_mixer_update_vi_layer_coord(struct sun8i_mixer *mixer,
 	u32 src_w, src_h, dst_w, dst_h;
 	u32 outsize, insize;
 	u32 hphase, vphase;
+	bool subsampled;
 
 	DRM_DEBUG_DRIVER("Updating VI layer %d\n", layer);
 
@@ -439,19 +440,45 @@ int sun8i_mixer_update_vi_layer_coord(struct sun8i_mixer *mixer,
 	hphase = state->src.x1 & 0xffff;
 	vphase = state->src.y1 & 0xffff;
 
+	/* make coordinates dividable by subsampling factor */
+	if (format->hsub > 1) {
+		int mask, remainder;
+
+		mask = format->hsub - 1;
+		remainder = (state->src.x1 >> 16) & mask;
+		src_w = (src_w + remainder) & ~mask;
+		hphase += remainder << 16;
+	}
+
+	if (format->vsub > 1) {
+		int mask, remainder;
+
+		mask = format->vsub - 1;
+		remainder = (state->src.y1 >> 16) & mask;
+		src_h = (src_h + remainder) & ~mask;
+		vphase += remainder << 16;
+	}
+
 	insize = SUN8I_MIXER_SIZE(src_w, src_h);
 	outsize = SUN8I_MIXER_SIZE(dst_w, dst_h);
 
 	/* Set height and width */
 	DRM_DEBUG_DRIVER("Layer source offset X: %d Y: %d\n",
-			 state->src.x1 >> 16, state->src.y1 >> 16);
+			 (state->src.x1 >> 16) & ~(format->hsub - 1),
+			 (state->src.y1 >> 16) & ~(format->vsub - 1));
 	DRM_DEBUG_DRIVER("Layer source size W: %d H: %d\n", src_w, src_h);
 	regmap_write(mixer->engine.regs,
 		     SUN8I_MIXER_CHAN_VI_LAYER_SIZE(layer, 0), insize);
 	regmap_write(mixer->engine.regs,
 		     SUN8I_MIXER_CHAN_VI_OVL_SIZE(layer), insize);
 
-	if (insize != outsize || hphase || vphase) {
+	/*
+	 * Scaler must be enabled for subsampled formats, so it scales
+	 * chroma to same size as luma.
+	 */
+	subsampled = format->hsub > 1 || format->vsub > 1;
+
+	if (insize != outsize || subsampled || hphase || vphase) {
 		u32 hscale, vscale;
 
 		DRM_DEBUG_DRIVER("HW scaling is enabled\n");
@@ -510,17 +537,31 @@ int sun8i_mixer_update_vi_layer_formats(struct sun8i_mixer *mixer,
 	u32 val;
 
 	fmt_info = sun8i_mixer_format_info(state->fb->format->format);
-	if (!fmt_info || !fmt_info->rgb) {
+	if (!fmt_info) {
 		DRM_DEBUG_DRIVER("Invalid format\n");
 		return -EINVAL;
 	}
 
-	val = fmt_info->de2_fmt << SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_OFFSET;
+	val = fmt_info->de2_fmt << SUN8I_MIXER_CHAN_VI_LAYER_ATTR_FBFMT_OFFSET;
 	regmap_update_bits(mixer->engine.regs,
 			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR(layer, 0),
-			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR_FBFMT_MASK |
-			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR_RGB_MODE,
-			   val | SUN8I_MIXER_CHAN_VI_LAYER_ATTR_RGB_MODE);
+			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR_FBFMT_MASK, val);
+
+	if (fmt_info->csc != SUN8I_CSC_MODE_OFF) {
+		sun8i_csc_set_ccsc_coefficients(mixer, layer, fmt_info->csc);
+		sun8i_csc_enable_ccsc(mixer, layer, true);
+	} else {
+		sun8i_csc_enable_ccsc(mixer, layer, false);
+	}
+
+	if (fmt_info->rgb)
+		val = SUN8I_MIXER_CHAN_VI_LAYER_ATTR_RGB_MODE;
+	else
+		val = 0;
+
+	regmap_update_bits(mixer->engine.regs,
+			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR(layer, 0),
+			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR_RGB_MODE, val);
 
 	return 0;
 }
@@ -567,34 +608,51 @@ int sun8i_mixer_update_vi_layer_buffer(struct sun8i_mixer *mixer,
 {
 	struct drm_plane_state *state = plane->state;
 	struct drm_framebuffer *fb = state->fb;
+	const struct drm_format_info *format = fb->format;
 	struct drm_gem_cma_object *gem;
+	u32 dx, dy, src_x, src_y;
 	dma_addr_t paddr;
-	int bpp;
+	int i;
 
-	/* Get the physical address of the buffer in memory */
-	gem = drm_fb_cma_get_gem_obj(fb, 0);
+	/* Adjust x and y to be dividable by subsampling factor */
+	src_x = (state->src.x1 >> 16) & ~(format->hsub - 1);
+	src_y = (state->src.y1 >> 16) & ~(format->vsub - 1);
 
-	DRM_DEBUG_DRIVER("Using GEM @ %pad\n", &gem->paddr);
+	for (i = 0; i < format->num_planes; i++) {
+		/* Get the physical address of the buffer in memory */
+		gem = drm_fb_cma_get_gem_obj(fb, i);
 
-	/* Compute the start of the displayed memory */
-	bpp = fb->format->cpp[0];
-	paddr = gem->paddr + fb->offsets[0];
+		DRM_DEBUG_DRIVER("Using GEM @ %pad\n", &gem->paddr);
 
-	/* Fixup framebuffer address for src coordinates */
-	paddr += (state->src.x1 >> 16) * bpp;
-	paddr += (state->src.y1 >> 16) * fb->pitches[0];
+		/* Compute the start of the displayed memory */
+		paddr = gem->paddr + fb->offsets[i];
 
-	/* Set the line width */
-	DRM_DEBUG_DRIVER("Layer line width: %d bytes\n", fb->pitches[0]);
-	regmap_write(mixer->engine.regs,
-		     SUN8I_MIXER_CHAN_VI_LAYER_PITCH(layer, 0, 0),
-		     fb->pitches[0]);
+		dx = src_x;
+		dy = src_y;
 
-	DRM_DEBUG_DRIVER("Setting buffer address to %pad\n", &paddr);
+		if (i > 0) {
+			dx /= format->hsub;
+			dy /= format->vsub;
+		}
 
-	regmap_write(mixer->engine.regs,
-		     SUN8I_MIXER_CHAN_VI_LAYER_TOP_LADDR(layer, 0, 0),
-		     lower_32_bits(paddr));
+		/* Fixup framebuffer address for src coordinates */
+		paddr += dx * format->cpp[i];
+		paddr += dy * fb->pitches[i];
+
+		/* Set the line width */
+		DRM_DEBUG_DRIVER("Layer %d. line width: %d bytes\n",
+				 i + 1, fb->pitches[i]);
+		regmap_write(mixer->engine.regs,
+			     SUN8I_MIXER_CHAN_VI_LAYER_PITCH(layer, 0, i),
+			     fb->pitches[i]);
+
+		DRM_DEBUG_DRIVER("Setting %d. buffer address to %pad\n",
+				 i + 1, &paddr);
+
+		regmap_write(mixer->engine.regs,
+			     SUN8I_MIXER_CHAN_VI_LAYER_TOP_LADDR(layer, 0, i),
+			     lower_32_bits(paddr));
+	}
 
 	return 0;
 }
-- 
2.15.0
