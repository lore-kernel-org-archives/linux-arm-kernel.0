From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Fri,  1 Dec 2017 07:05:42 +0100
Subject: [PATCH v2 19/27] drm/sun4i: Add support for DE2 VI planes
In-Reply-To: <20171201060550.10392-1-jernej.skrabec@siol.net>
References: <20171201060550.10392-1-jernej.skrabec@siol.net>
Message-ID: <20171201060550.10392-20-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds basic support for VI planes. They are meant for video
overlay and because of that they support YUV formats too. However, using
YUV format is not straightforward, so only RGB formats are supported for
now.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/Makefile         |   3 +-
 drivers/gpu/drm/sun4i/sun8i_mixer.c    |  19 ++-
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 276 +++++++++++++++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun8i_vi_layer.h |  51 ++++++
 4 files changed, 346 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_vi_layer.c
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_vi_layer.h

diff --git a/drivers/gpu/drm/sun4i/Makefile b/drivers/gpu/drm/sun4i/Makefile
index 0a839674cd1d..b0a2eb2c4806 100644
--- a/drivers/gpu/drm/sun4i/Makefile
+++ b/drivers/gpu/drm/sun4i/Makefile
@@ -9,7 +9,8 @@ sun4i-drm-hdmi-y		+= sun4i_hdmi_enc.o
 sun4i-drm-hdmi-y		+= sun4i_hdmi_i2c.o
 sun4i-drm-hdmi-y		+= sun4i_hdmi_tmds_clk.o
 
-sun8i-mixer-y			+= sun8i_mixer.o sun8i_ui_layer.o
+sun8i-mixer-y			+= sun8i_mixer.o sun8i_ui_layer.o \
+				   sun8i_vi_layer.o
 
 sun4i-tcon-y			+= sun4i_crtc.o
 sun4i-tcon-y			+= sun4i_dotclock.o
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index 1de98ad9f6c1..888620b1d3f1 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -27,6 +27,7 @@
 #include "sun4i_drv.h"
 #include "sun8i_mixer.h"
 #include "sun8i_ui_layer.h"
+#include "sun8i_vi_layer.h"
 #include "sunxi_engine.h"
 
 static const struct de2_fmt_info de2_formats[] = {
@@ -138,11 +139,25 @@ static struct drm_plane **sun8i_layers_init(struct drm_device *drm,
 	struct sun8i_mixer *mixer = engine_to_sun8i_mixer(engine);
 	int i;
 
-	planes = devm_kcalloc(drm->dev, mixer->cfg->ui_num + 1,
+	planes = devm_kcalloc(drm->dev,
+			      mixer->cfg->vi_num + mixer->cfg->ui_num + 1,
 			      sizeof(*planes), GFP_KERNEL);
 	if (!planes)
 		return ERR_PTR(-ENOMEM);
 
+	for (i = 0; i < mixer->cfg->vi_num; i++) {
+		struct sun8i_vi_layer *layer;
+
+		layer = sun8i_vi_layer_init_one(drm, mixer, i);
+		if (IS_ERR(layer)) {
+			dev_err(drm->dev,
+				"Couldn't initialize overlay plane\n");
+			return ERR_CAST(layer);
+		};
+
+		planes[i] = &layer->plane;
+	};
+
 	for (i = 0; i < mixer->cfg->ui_num; i++) {
 		struct sun8i_ui_layer *layer;
 
@@ -153,7 +168,7 @@ static struct drm_plane **sun8i_layers_init(struct drm_device *drm,
 			return ERR_CAST(layer);
 		};
 
-		planes[i] = &layer->plane;
+		planes[mixer->cfg->vi_num + i] = &layer->plane;
 	};
 
 	return planes;
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
new file mode 100644
index 000000000000..b78d4f3e2b48
--- /dev/null
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -0,0 +1,276 @@
+/*
+ * Copyright (C) Jernej Skrabec <jernej.skrabec@siol.net>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ */
+
+#include <drm/drm_atomic.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_fb_cma_helper.h>
+#include <drm/drm_gem_cma_helper.h>
+#include <drm/drm_plane_helper.h>
+#include <drm/drmP.h>
+
+#include "sun8i_vi_layer.h"
+#include "sun8i_mixer.h"
+
+static void sun8i_vi_layer_enable(struct sun8i_mixer *mixer, int channel,
+				  int overlay, bool enable)
+{
+	u32 val;
+
+	DRM_DEBUG_DRIVER("%sabling VI channel %d overlay %d\n",
+			 enable ? "En" : "Dis", channel, overlay);
+
+	if (enable)
+		val = SUN8I_MIXER_CHAN_VI_LAYER_ATTR_EN;
+	else
+		val = 0;
+
+	regmap_update_bits(mixer->engine.regs,
+			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR(channel, overlay),
+			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR_EN, val);
+
+	if (enable)
+		val = SUN8I_MIXER_BLEND_PIPE_CTL_EN(channel);
+	else
+		val = 0;
+
+	regmap_update_bits(mixer->engine.regs,
+			   SUN8I_MIXER_BLEND_PIPE_CTL,
+			   SUN8I_MIXER_BLEND_PIPE_CTL_EN(channel), val);
+}
+
+static int sun8i_vi_layer_update_coord(struct sun8i_mixer *mixer, int channel,
+				       int overlay, struct drm_plane *plane)
+{
+	struct drm_plane_state *state = plane->state;
+	u32 width, height, size;
+
+	DRM_DEBUG_DRIVER("Updating VI channel %d overlay %d\n",
+			 channel, overlay);
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
+		     SUN8I_MIXER_CHAN_VI_LAYER_SIZE(channel, overlay),
+		     size);
+	regmap_write(mixer->engine.regs,
+		     SUN8I_MIXER_CHAN_VI_OVL_SIZE(channel),
+		     size);
+
+	/* Set base coordinates */
+	DRM_DEBUG_DRIVER("Layer coordinates X: %d Y: %d\n",
+			 state->dst.x1, state->dst.y1);
+	regmap_write(mixer->engine.regs,
+		     SUN8I_MIXER_BLEND_ATTR_COORD(channel),
+		     SUN8I_MIXER_COORD(state->dst.x1, state->dst.y1));
+	regmap_write(mixer->engine.regs,
+		     SUN8I_MIXER_BLEND_ATTR_INSIZE(channel),
+		     size);
+
+	return 0;
+}
+
+static int sun8i_vi_layer_update_formats(struct sun8i_mixer *mixer, int channel,
+					 int overlay, struct drm_plane *plane)
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
+	val = fmt_info->de2_fmt << SUN8I_MIXER_CHAN_VI_LAYER_ATTR_FBFMT_OFFSET;
+	regmap_update_bits(mixer->engine.regs,
+			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR(channel, overlay),
+			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR_FBFMT_MASK |
+			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR_RGB_MODE,
+			   val | SUN8I_MIXER_CHAN_VI_LAYER_ATTR_RGB_MODE);
+
+	return 0;
+}
+
+static int sun8i_vi_layer_update_buffer(struct sun8i_mixer *mixer, int channel,
+					int overlay, struct drm_plane *plane)
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
+		     SUN8I_MIXER_CHAN_VI_LAYER_PITCH(channel, overlay, 0),
+		     fb->pitches[0]);
+
+	DRM_DEBUG_DRIVER("Setting buffer address to %pad\n", &paddr);
+
+	regmap_write(mixer->engine.regs,
+		     SUN8I_MIXER_CHAN_VI_LAYER_TOP_LADDR(channel, overlay, 0),
+		     lower_32_bits(paddr));
+
+	return 0;
+}
+
+static int sun8i_vi_layer_atomic_check(struct drm_plane *plane,
+				       struct drm_plane_state *state)
+{
+	struct drm_crtc *crtc = state->crtc;
+	struct drm_crtc_state *crtc_state;
+	struct drm_rect clip;
+
+	if (!crtc)
+		return 0;
+
+	crtc_state = drm_atomic_get_existing_crtc_state(state->state, crtc);
+	if (WARN_ON(!crtc_state))
+		return -EINVAL;
+
+	clip.x1 = 0;
+	clip.y1 = 0;
+	clip.x2 = crtc_state->adjusted_mode.hdisplay;
+	clip.y2 = crtc_state->adjusted_mode.vdisplay;
+
+	return drm_plane_helper_check_state(state, &clip,
+					    DRM_PLANE_HELPER_NO_SCALING,
+					    DRM_PLANE_HELPER_NO_SCALING,
+					    true, true);
+}
+
+static void sun8i_vi_layer_atomic_disable(struct drm_plane *plane,
+					  struct drm_plane_state *old_state)
+{
+	struct sun8i_vi_layer *layer = plane_to_sun8i_vi_layer(plane);
+	struct sun8i_mixer *mixer = layer->mixer;
+
+	sun8i_vi_layer_enable(mixer, layer->channel, layer->overlay, false);
+}
+
+static void sun8i_vi_layer_atomic_update(struct drm_plane *plane,
+					 struct drm_plane_state *old_state)
+{
+	struct sun8i_vi_layer *layer = plane_to_sun8i_vi_layer(plane);
+	struct sun8i_mixer *mixer = layer->mixer;
+
+	if (!plane->state->visible) {
+		sun8i_vi_layer_enable(mixer, layer->channel,
+				      layer->overlay, false);
+		return;
+	}
+
+	sun8i_vi_layer_update_coord(mixer, layer->channel,
+				    layer->overlay, plane);
+	sun8i_vi_layer_update_formats(mixer, layer->channel,
+				      layer->overlay, plane);
+	sun8i_vi_layer_update_buffer(mixer, layer->channel,
+				     layer->overlay, plane);
+	sun8i_vi_layer_enable(mixer, layer->channel, layer->overlay, true);
+}
+
+static struct drm_plane_helper_funcs sun8i_vi_layer_helper_funcs = {
+	.atomic_check	= sun8i_vi_layer_atomic_check,
+	.atomic_disable	= sun8i_vi_layer_atomic_disable,
+	.atomic_update	= sun8i_vi_layer_atomic_update,
+};
+
+static const struct drm_plane_funcs sun8i_vi_layer_funcs = {
+	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
+	.atomic_duplicate_state	= drm_atomic_helper_plane_duplicate_state,
+	.destroy		= drm_plane_cleanup,
+	.disable_plane		= drm_atomic_helper_disable_plane,
+	.reset			= drm_atomic_helper_plane_reset,
+	.update_plane		= drm_atomic_helper_update_plane,
+};
+
+/*
+ * While all RGB formats are supported, VI planes don't support
+ * alpha blending, so there is no point having formats with alpha
+ * channel if their opaque analog exist.
+ */
+static const u32 sun8i_vi_layer_formats[] = {
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
+};
+
+struct sun8i_vi_layer *sun8i_vi_layer_init_one(struct drm_device *drm,
+					       struct sun8i_mixer *mixer,
+					       int index)
+{
+	struct sun8i_vi_layer *layer;
+	int ret;
+
+	layer = devm_kzalloc(drm->dev, sizeof(*layer), GFP_KERNEL);
+	if (!layer)
+		return ERR_PTR(-ENOMEM);
+
+	/* possible crtcs are set later */
+	ret = drm_universal_plane_init(drm, &layer->plane, 0,
+				       &sun8i_vi_layer_funcs,
+				       sun8i_vi_layer_formats,
+				       ARRAY_SIZE(sun8i_vi_layer_formats),
+				       NULL, DRM_PLANE_TYPE_OVERLAY, NULL);
+	if (ret) {
+		dev_err(drm->dev, "Couldn't initialize layer\n");
+		return ERR_PTR(ret);
+	}
+
+	/* fixed zpos for now */
+	ret = drm_plane_create_zpos_immutable_property(&layer->plane, index);
+	if (ret) {
+		dev_err(drm->dev, "Couldn't add zpos property\n");
+		return ERR_PTR(ret);
+	}
+
+	drm_plane_helper_add(&layer->plane, &sun8i_vi_layer_helper_funcs);
+	layer->mixer = mixer;
+	layer->channel = index;
+	layer->overlay = 0;
+
+	return layer;
+}
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.h b/drivers/gpu/drm/sun4i/sun8i_vi_layer.h
new file mode 100644
index 000000000000..6996627a0a76
--- /dev/null
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.h
@@ -0,0 +1,51 @@
+/*
+ * Copyright (C) Jernej Skrabec <jernej.skrabec@siol.net>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ */
+
+#ifndef _SUN8I_VI_LAYER_H_
+#define _SUN8I_VI_LAYER_H_
+
+#include <drm/drm_plane.h>
+
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
+struct sun8i_mixer;
+
+struct sun8i_vi_layer {
+	struct drm_plane	plane;
+	struct sun8i_mixer	*mixer;
+	int			channel;
+	int			overlay;
+};
+
+static inline struct sun8i_vi_layer *
+plane_to_sun8i_vi_layer(struct drm_plane *plane)
+{
+	return container_of(plane, struct sun8i_vi_layer, plane);
+}
+
+struct sun8i_vi_layer *sun8i_vi_layer_init_one(struct drm_device *drm,
+					       struct sun8i_mixer *mixer,
+					       int index);
+#endif /* _SUN8I_VI_LAYER_H_ */
-- 
2.15.1
