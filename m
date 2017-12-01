From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Fri,  1 Dec 2017 07:05:49 +0100
Subject: [PATCH v2 26/27] drm/sun4i: Wire in DE2 YUV support
In-Reply-To: <20171201060550.10392-1-jernej.skrabec@siol.net>
References: <20171201060550.10392-1-jernej.skrabec@siol.net>
Message-ID: <20171201060550.10392-27-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have all required bits, add support for YUV formats.

DRM subsystem doesn't know YUV411 semi-planar format, so leave that out
for now.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 127 ++++++++++++++++++++++++++-------
 1 file changed, 102 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
index 02aaa7d3fceb..0b4800fd7ba1 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -55,6 +55,7 @@ static int sun8i_vi_layer_update_coord(struct sun8i_mixer *mixer, int channel,
 	u32 src_w, src_h, dst_w, dst_h;
 	u32 outsize, insize;
 	u32 hphase, vphase;
+	bool subsampled;
 
 	DRM_DEBUG_DRIVER("Updating VI channel %d overlay %d\n",
 			 channel, overlay);
@@ -67,12 +68,32 @@ static int sun8i_vi_layer_update_coord(struct sun8i_mixer *mixer, int channel,
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
 		     SUN8I_MIXER_CHAN_VI_LAYER_SIZE(channel, overlay),
@@ -81,7 +102,13 @@ static int sun8i_vi_layer_update_coord(struct sun8i_mixer *mixer, int channel,
 		     SUN8I_MIXER_CHAN_VI_OVL_SIZE(channel),
 		     insize);
 
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
@@ -120,7 +147,7 @@ static int sun8i_vi_layer_update_formats(struct sun8i_mixer *mixer, int channel,
 	u32 val;
 
 	fmt_info = sun8i_mixer_format_info(state->fb->format->format);
-	if (!fmt_info || !fmt_info->rgb) {
+	if (!fmt_info) {
 		DRM_DEBUG_DRIVER("Invalid format\n");
 		return -EINVAL;
 	}
@@ -128,9 +155,23 @@ static int sun8i_vi_layer_update_formats(struct sun8i_mixer *mixer, int channel,
 	val = fmt_info->de2_fmt << SUN8I_MIXER_CHAN_VI_LAYER_ATTR_FBFMT_OFFSET;
 	regmap_update_bits(mixer->engine.regs,
 			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR(channel, overlay),
-			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR_FBFMT_MASK |
-			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR_RGB_MODE,
-			   val | SUN8I_MIXER_CHAN_VI_LAYER_ATTR_RGB_MODE);
+			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR_FBFMT_MASK, val);
+
+	if (fmt_info->csc != SUN8I_CSC_MODE_OFF) {
+		sun8i_csc_set_ccsc_coefficients(mixer, channel, fmt_info->csc);
+		sun8i_csc_enable_ccsc(mixer, channel, true);
+	} else {
+		sun8i_csc_enable_ccsc(mixer, channel, false);
+	}
+
+	if (fmt_info->rgb)
+		val = SUN8I_MIXER_CHAN_VI_LAYER_ATTR_RGB_MODE;
+	else
+		val = 0;
+
+	regmap_update_bits(mixer->engine.regs,
+			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR(channel, overlay),
+			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR_RGB_MODE, val);
 
 	return 0;
 }
@@ -140,34 +181,53 @@ static int sun8i_vi_layer_update_buffer(struct sun8i_mixer *mixer, int channel,
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
-		     SUN8I_MIXER_CHAN_VI_LAYER_PITCH(channel, overlay, 0),
-		     fb->pitches[0]);
+		dx = src_x;
+		dy = src_y;
 
-	DRM_DEBUG_DRIVER("Setting buffer address to %pad\n", &paddr);
+		if (i > 0) {
+			dx /= format->hsub;
+			dy /= format->vsub;
+		}
 
-	regmap_write(mixer->engine.regs,
-		     SUN8I_MIXER_CHAN_VI_LAYER_TOP_LADDR(channel, overlay, 0),
-		     lower_32_bits(paddr));
+		/* Fixup framebuffer address for src coordinates */
+		paddr += dx * format->cpp[i];
+		paddr += dy * fb->pitches[i];
+
+		/* Set the line width */
+		DRM_DEBUG_DRIVER("Layer %d. line width: %d bytes\n",
+				 i + 1, fb->pitches[i]);
+		regmap_write(mixer->engine.regs,
+			     SUN8I_MIXER_CHAN_VI_LAYER_PITCH(channel,
+							     overlay, i),
+	       fb->pitches[i]);
+
+		DRM_DEBUG_DRIVER("Setting %d. buffer address to %pad\n",
+				 i + 1, &paddr);
+
+		regmap_write(mixer->engine.regs,
+			     SUN8I_MIXER_CHAN_VI_LAYER_TOP_LADDR(channel,
+								 overlay, i),
+	       lower_32_bits(paddr));
+	}
 
 	return 0;
 }
@@ -270,6 +330,23 @@ static const u32 sun8i_vi_layer_formats[] = {
 	DRM_FORMAT_RGBX8888,
 	DRM_FORMAT_XBGR8888,
 	DRM_FORMAT_XRGB8888,
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
 };
 
 struct sun8i_vi_layer *sun8i_vi_layer_init_one(struct drm_device *drm,
-- 
2.15.1
