From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Wed, 22 Feb 2017 23:23:06 +0800
Subject: [PATCH 4/8] drm/sun4i: add support for sun8i DE2 mixers and display
 engines
Message-ID: <20170222152310.3719-5-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner have a new "Display Engine 2.0" in there new SoCs, which comes
in a new "Display Engine" (mixers instead of old backends and
frontends).

Add support for the mixer on Allwinner V3s SoC; it's the simplest one.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 drivers/gpu/drm/sun4i/Kconfig       |   8 +
 drivers/gpu/drm/sun4i/Makefile      |   1 +
 drivers/gpu/drm/sun4i/sun4i_crtc.c  |   6 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c   |  38 +++-
 drivers/gpu/drm/sun4i/sun4i_drv.h   |   1 +
 drivers/gpu/drm/sun4i/sun4i_layer.c |  92 ++++++--
 drivers/gpu/drm/sun4i/sun4i_layer.h |   1 +
 drivers/gpu/drm/sun4i/sun8i_mixer.c | 417 ++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun8i_mixer.h | 133 ++++++++++++
 9 files changed, 674 insertions(+), 23 deletions(-)
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_mixer.c
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_mixer.h

diff --git a/drivers/gpu/drm/sun4i/Kconfig b/drivers/gpu/drm/sun4i/Kconfig
index a4b357db8856..8df401fff145 100644
--- a/drivers/gpu/drm/sun4i/Kconfig
+++ b/drivers/gpu/drm/sun4i/Kconfig
@@ -12,3 +12,11 @@ config DRM_SUN4I
 	  Choose this option if you have an Allwinner SoC with a
 	  Display Engine. If M is selected the module will be called
 	  sun4i-drm.
+
+config DRM_SUN4I_DE2
+	bool "Support Display Engine 2.0"
+	depends on DRM_SUN4I
+	default MACH_SUN8I
+	help
+	  Choose this option if you have an Allwinner SoC with a
+	  "Display Engine 2.0".
diff --git a/drivers/gpu/drm/sun4i/Makefile b/drivers/gpu/drm/sun4i/Makefile
index d625a82a6e5f..890e6e50dfee 100644
--- a/drivers/gpu/drm/sun4i/Makefile
+++ b/drivers/gpu/drm/sun4i/Makefile
@@ -9,5 +9,6 @@ sun4i-tcon-y += sun4i_dotclock.o
 
 obj-$(CONFIG_DRM_SUN4I)		+= sun4i-drm.o sun4i-tcon.o
 obj-$(CONFIG_DRM_SUN4I)		+= sun4i_backend.o
+obj-$(CONFIG_DRM_SUN4I)		+= sun8i_mixer.o
 obj-$(CONFIG_DRM_SUN4I)		+= sun6i_drc.o
 obj-$(CONFIG_DRM_SUN4I)		+= sun4i_tv.o
diff --git a/drivers/gpu/drm/sun4i/sun4i_crtc.c b/drivers/gpu/drm/sun4i/sun4i_crtc.c
index 4a192210574f..4d2228454726 100644
--- a/drivers/gpu/drm/sun4i/sun4i_crtc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_crtc.c
@@ -25,6 +25,7 @@
 #include <video/videomode.h>
 
 #include "sun4i_backend.h"
+#include "sun8i_mixer.h"
 #include "sun4i_crtc.h"
 #include "sun4i_drv.h"
 #include "sun4i_tcon.h"
@@ -55,7 +56,10 @@ static void sun4i_crtc_atomic_flush(struct drm_crtc *crtc,
 
 	DRM_DEBUG_DRIVER("Committing plane changes\n");
 
-	sun4i_backend_commit(drv->backend);
+	if (drv->backend)
+		sun4i_backend_commit(drv->backend);
+	else if (drv->mixer)
+		sun8i_mixer_commit(drv->mixer);
 
 	if (event) {
 		crtc->state->event = NULL;
diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 4ce665349f6b..58af38f5e833 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -20,12 +20,17 @@
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_of.h>
 
+#include <linux/of_device.h>
+
 #include "sun4i_crtc.h"
 #include "sun4i_drv.h"
 #include "sun4i_framebuffer.h"
 #include "sun4i_layer.h"
 #include "sun4i_tcon.h"
 
+#define DE_VER_DE	0
+#define DE_VER_DE2	1
+
 static int sun4i_drv_enable_vblank(struct drm_device *drm, unsigned int pipe)
 {
 	struct sun4i_drv *drv = drm->dev_private;
@@ -117,7 +122,9 @@ static int sun4i_drv_bind(struct device *dev)
 {
 	struct drm_device *drm;
 	struct sun4i_drv *drv;
-	int ret;
+	int ret, de_ver;
+
+	de_ver = (int)of_device_get_match_data(dev);
 
 	drm = drm_dev_alloc(&sun4i_drv_driver, dev);
 	if (IS_ERR(drm))
@@ -140,7 +147,10 @@ static int sun4i_drv_bind(struct device *dev)
 	}
 
 	/* Create our layers */
-	drv->layers = sun4i_layers_init(drm);
+	if (de_ver == DE_VER_DE2)
+		drv->layers = sun8i_layers_init(drm);
+	else
+		drv->layers = sun4i_layers_init(drm);
 	if (IS_ERR(drv->layers)) {
 		dev_err(drm->dev, "Couldn't create the planes\n");
 		ret = PTR_ERR(drv->layers);
@@ -323,10 +333,26 @@ static int sun4i_drv_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id sun4i_drv_of_table[] = {
-	{ .compatible = "allwinner,sun5i-a13-display-engine" },
-	{ .compatible = "allwinner,sun6i-a31-display-engine" },
-	{ .compatible = "allwinner,sun6i-a31s-display-engine" },
-	{ .compatible = "allwinner,sun8i-a33-display-engine" },
+	{
+		.compatible = "allwinner,sun5i-a13-display-engine",
+		.data = (void *)DE_VER_DE,
+	},
+	{
+		.compatible = "allwinner,sun6i-a31-display-engine",
+		.data = (void *)DE_VER_DE,
+	},
+	{
+		.compatible = "allwinner,sun6i-a31s-display-engine",
+		.data = (void *)DE_VER_DE,
+	},
+	{
+		.compatible = "allwinner,sun8i-a33-display-engine",
+		.data = (void *)DE_VER_DE,
+	},
+	{
+		.compatible = "allwinner,sun8i-v3s-display-engine",
+		.data = (void *)DE_VER_DE2,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sun4i_drv_of_table);
diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.h b/drivers/gpu/drm/sun4i/sun4i_drv.h
index 597353eab728..cf1da95b85bd 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.h
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.h
@@ -18,6 +18,7 @@
 
 struct sun4i_drv {
 	struct sun4i_backend	*backend;
+	struct sun8i_mixer	*mixer;
 	struct sun4i_crtc	*crtc;
 	struct sun4i_tcon	*tcon;
 
diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
index 5d53c977bca5..6dcdac38ab69 100644
--- a/drivers/gpu/drm/sun4i/sun4i_layer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
@@ -16,52 +16,66 @@
 #include <drm/drmP.h>
 
 #include "sun4i_backend.h"
+#include "sun8i_mixer.h"
 #include "sun4i_drv.h"
 #include "sun4i_layer.h"
 
 struct sun4i_plane_desc {
 	       enum drm_plane_type     type;
+	       /* Pipe is not used in sun8i-mixer */
 	       u8                      pipe;
 	       const uint32_t          *formats;
 	       uint32_t                nformats;
 };
 
-static int sun4i_backend_layer_atomic_check(struct drm_plane *plane,
+static int sun4i_layer_atomic_check(struct drm_plane *plane,
 					    struct drm_plane_state *state)
 {
 	return 0;
 }
 
-static void sun4i_backend_layer_atomic_disable(struct drm_plane *plane,
+static void sun4i_layer_atomic_disable(struct drm_plane *plane,
 					       struct drm_plane_state *old_state)
 {
 	struct sun4i_layer *layer = plane_to_sun4i_layer(plane);
 	struct sun4i_drv *drv = layer->drv;
 	struct sun4i_backend *backend = drv->backend;
+	struct sun8i_mixer *mixer = drv->mixer;
 
-	sun4i_backend_layer_enable(backend, layer->id, false);
+	if (backend)
+		sun4i_backend_layer_enable(backend, layer->id, false);
+	else if (mixer)
+		sun8i_mixer_layer_enable(mixer, layer->id, false);
 }
 
-static void sun4i_backend_layer_atomic_update(struct drm_plane *plane,
+static void sun4i_layer_atomic_update(struct drm_plane *plane,
 					      struct drm_plane_state *old_state)
 {
 	struct sun4i_layer *layer = plane_to_sun4i_layer(plane);
 	struct sun4i_drv *drv = layer->drv;
 	struct sun4i_backend *backend = drv->backend;
-
-	sun4i_backend_update_layer_coord(backend, layer->id, plane);
-	sun4i_backend_update_layer_formats(backend, layer->id, plane);
-	sun4i_backend_update_layer_buffer(backend, layer->id, plane);
-	sun4i_backend_layer_enable(backend, layer->id, true);
+	struct sun8i_mixer *mixer = drv->mixer;
+
+	if (backend) {
+		sun4i_backend_update_layer_coord(backend, layer->id, plane);
+		sun4i_backend_update_layer_formats(backend, layer->id, plane);
+		sun4i_backend_update_layer_buffer(backend, layer->id, plane);
+		sun4i_backend_layer_enable(backend, layer->id, true);
+	} else if (mixer) {
+		sun8i_mixer_update_layer_coord(mixer, layer->id, plane);
+		sun8i_mixer_update_layer_formats(mixer, layer->id, plane);
+		sun8i_mixer_update_layer_buffer(mixer, layer->id, plane);
+		sun8i_mixer_layer_enable(mixer, layer->id, true);
+	}
 }
 
-static struct drm_plane_helper_funcs sun4i_backend_layer_helper_funcs = {
-	.atomic_check	= sun4i_backend_layer_atomic_check,
-	.atomic_disable	= sun4i_backend_layer_atomic_disable,
-	.atomic_update	= sun4i_backend_layer_atomic_update,
+static struct drm_plane_helper_funcs sun4i_layer_helper_funcs = {
+	.atomic_check	= sun4i_layer_atomic_check,
+	.atomic_disable	= sun4i_layer_atomic_disable,
+	.atomic_update	= sun4i_layer_atomic_update,
 };
 
-static const struct drm_plane_funcs sun4i_backend_layer_funcs = {
+static const struct drm_plane_funcs sun4i_layer_funcs = {
 	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
 	.atomic_duplicate_state	= drm_atomic_helper_plane_duplicate_state,
 	.destroy		= drm_plane_cleanup,
@@ -88,6 +102,12 @@ static const uint32_t sun4i_backend_layer_formats_overlay[] = {
 	DRM_FORMAT_XRGB8888,
 };
 
+static const uint32_t sun8i_mixer_layer_formats[] = {
+	DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_RGB888,
+	DRM_FORMAT_XRGB8888,
+};
+
 static const struct sun4i_plane_desc sun4i_backend_planes[] = {
 	{
 		.type = DRM_PLANE_TYPE_PRIMARY,
@@ -103,6 +123,19 @@ static const struct sun4i_plane_desc sun4i_backend_planes[] = {
 	},
 };
 
+static const struct sun4i_plane_desc sun8i_mixer_planes[] = {
+	{
+		.type = DRM_PLANE_TYPE_PRIMARY,
+		.formats = sun8i_mixer_layer_formats,
+		.nformats = ARRAY_SIZE(sun8i_mixer_layer_formats),
+	},
+	{
+		.type = DRM_PLANE_TYPE_OVERLAY,
+		.formats = sun8i_mixer_layer_formats,
+		.nformats = ARRAY_SIZE(sun8i_mixer_layer_formats),
+	},
+};
+
 static struct sun4i_layer *sun4i_layer_init_one(struct drm_device *drm,
 						const struct sun4i_plane_desc *plane)
 {
@@ -115,7 +148,7 @@ static struct sun4i_layer *sun4i_layer_init_one(struct drm_device *drm,
 		return ERR_PTR(-ENOMEM);
 
 	ret = drm_universal_plane_init(drm, &layer->plane, BIT(0),
-				       &sun4i_backend_layer_funcs,
+				       &sun4i_layer_funcs,
 				       plane->formats, plane->nformats,
 				       plane->type, NULL);
 	if (ret) {
@@ -124,7 +157,7 @@ static struct sun4i_layer *sun4i_layer_init_one(struct drm_device *drm,
 	}
 
 	drm_plane_helper_add(&layer->plane,
-			     &sun4i_backend_layer_helper_funcs);
+			     &sun4i_layer_helper_funcs);
 	layer->drv = drv;
 
 	if (plane->type == DRM_PLANE_TYPE_PRIMARY)
@@ -187,3 +220,30 @@ struct sun4i_layer **sun4i_layers_init(struct drm_device *drm)
 
 	return layers;
 }
+
+struct sun4i_layer **sun8i_layers_init(struct drm_device *drm)
+{
+	struct sun4i_layer **layers;
+	int i;
+
+	layers = devm_kcalloc(drm->dev, ARRAY_SIZE(sun8i_mixer_planes),
+			      sizeof(**layers), GFP_KERNEL);
+	if (!layers)
+		return ERR_PTR(-ENOMEM);
+
+	for (i = 0; i < ARRAY_SIZE(sun8i_mixer_planes); i++) {
+		const struct sun4i_plane_desc *plane = &sun8i_mixer_planes[i];
+		struct sun4i_layer *layer = layers[i];
+
+		layer = sun4i_layer_init_one(drm, plane);
+		if (IS_ERR(layer)) {
+			dev_err(drm->dev, "Couldn't initialize %s plane\n",
+				i ? "overlay" : "primary");
+			return ERR_CAST(layer);
+		};
+
+		layer->id = i;
+	};
+
+	return layers;
+}
diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.h b/drivers/gpu/drm/sun4i/sun4i_layer.h
index a2f65d7a3f4e..f7b9e5daea50 100644
--- a/drivers/gpu/drm/sun4i/sun4i_layer.h
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.h
@@ -26,5 +26,6 @@ plane_to_sun4i_layer(struct drm_plane *plane)
 }
 
 struct sun4i_layer **sun4i_layers_init(struct drm_device *drm);
+struct sun4i_layer **sun8i_layers_init(struct drm_device *drm);
 
 #endif /* _SUN4I_LAYER_H_ */
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
new file mode 100644
index 000000000000..9427b57240d3
--- /dev/null
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -0,0 +1,417 @@
+/*
+ * Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.xyz>
+ *
+ * Based on sun4i_backend.c, which is:
+ *   Copyright (C) 2015 Free Electrons
+ *   Copyright (C) 2015 NextThing Co
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ */
+
+#include <drm/drmP.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_fb_cma_helper.h>
+#include <drm/drm_gem_cma_helper.h>
+#include <drm/drm_plane_helper.h>
+
+#include <linux/component.h>
+#include <linux/reset.h>
+#include <linux/of_device.h>
+
+#include "sun8i_mixer.h"
+#include "sun4i_drv.h"
+
+#define SUN8I_DRAM_OFFSET 0x40000000
+
+#if defined CONFIG_DRM_SUN4I_DE2
+void sun8i_mixer_commit(struct sun8i_mixer *mixer)
+{
+	DRM_DEBUG_DRIVER("Committing changes\n");
+
+	regmap_write(mixer->regs, SUN8I_MIXER_GLOBAL_DBUFF,
+		     SUN8I_MIXER_GLOBAL_DBUFF_ENABLE);
+}
+EXPORT_SYMBOL(sun8i_mixer_commit);
+
+void sun8i_mixer_layer_enable(struct sun8i_mixer *mixer,
+				int layer, bool enable)
+{
+	u32 val;
+	/* Currently the first UI channel is used */
+	int chan = mixer->cfg->vi_num;
+
+	DRM_DEBUG_DRIVER("Enabling layer %d in channel %d\n", layer, chan);
+
+	if (enable)
+		val = SUN8I_MIXER_CHAN_UI_LAYER_ATTR_EN;
+	else
+		val = 0;
+
+	regmap_update_bits(mixer->regs,
+			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(chan, layer),
+			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_EN, val);
+
+	/* Set the alpha configuration */
+	regmap_update_bits(mixer->regs,
+			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(chan, layer),
+			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_MASK,
+			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_DEF);
+	regmap_update_bits(mixer->regs,
+			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(chan, layer),
+			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MASK,
+			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_DEF);
+}
+EXPORT_SYMBOL(sun8i_mixer_layer_enable);
+
+static int sun8i_mixer_drm_format_to_layer(struct drm_plane *plane,
+					     u32 format, u32 *mode)
+{
+	if ((plane->type == DRM_PLANE_TYPE_PRIMARY) &&
+	    (format == DRM_FORMAT_ARGB8888))
+		format = DRM_FORMAT_XRGB8888;
+
+	switch (format) {
+	case DRM_FORMAT_ARGB8888:
+		*mode = SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_ARGB8888;
+		break;
+
+	case DRM_FORMAT_XRGB8888:
+		*mode = SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_XRGB8888;
+		break;
+
+	case DRM_FORMAT_RGB888:
+		*mode = SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_RGB888;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int sun8i_mixer_update_layer_coord(struct sun8i_mixer *mixer,
+				     int layer, struct drm_plane *plane)
+{
+	struct drm_plane_state *state = plane->state;
+	struct drm_framebuffer *fb = state->fb;
+	/* Currently the first UI channel is used */
+	int chan = mixer->cfg->vi_num;
+	int i;
+
+	DRM_DEBUG_DRIVER("Updating layer %d\n", layer);
+
+	if (plane->type == DRM_PLANE_TYPE_PRIMARY) {
+		DRM_DEBUG_DRIVER("Primary layer, updating global size W: %u H: %u\n",
+				 state->crtc_w, state->crtc_h);
+		regmap_write(mixer->regs, SUN8I_MIXER_GLOBAL_SIZE,
+			     SUN8I_MIXER_SIZE(state->crtc_w,
+					      state->crtc_h));
+		DRM_DEBUG_DRIVER("Updating blender size\n");
+		for (i = 0; i < SUN8I_MIXER_MAX_CHAN_COUNT; i++)
+			regmap_write(mixer->regs,
+				     SUN8I_MIXER_BLEND_ATTR_INSIZE(i),
+				     SUN8I_MIXER_SIZE(state->crtc_w,
+						      state->crtc_h));
+		regmap_write(mixer->regs, SUN8I_MIXER_BLEND_OUTSIZE,
+			     SUN8I_MIXER_SIZE(state->crtc_w,
+					      state->crtc_h));
+		DRM_DEBUG_DRIVER("Updating channel size\n");
+		regmap_write(mixer->regs, SUN8I_MIXER_CHAN_UI_OVL_SIZE(chan),
+			     SUN8I_MIXER_SIZE(state->crtc_w,
+					      state->crtc_h));
+	}
+
+	/* Set the line width */
+	DRM_DEBUG_DRIVER("Layer line width: %d bytes\n", fb->pitches[0]);
+	regmap_write(mixer->regs, SUN8I_MIXER_CHAN_UI_LAYER_PITCH(chan, layer),
+		     fb->pitches[0]);
+
+	/* Set height and width */
+	DRM_DEBUG_DRIVER("Layer size W: %u H: %u\n",
+			 state->crtc_w, state->crtc_h);
+	regmap_write(mixer->regs, SUN8I_MIXER_CHAN_UI_LAYER_SIZE(chan, layer),
+		     SUN8I_MIXER_SIZE(state->crtc_w, state->crtc_h));
+
+	/* Set base coordinates */
+	DRM_DEBUG_DRIVER("Layer coordinates X: %d Y: %d\n",
+			 state->crtc_x, state->crtc_y);
+	regmap_write(mixer->regs, SUN8I_MIXER_CHAN_UI_LAYER_COORD(chan, layer),
+		     SUN8I_MIXER_COORD(state->crtc_x, state->crtc_y));
+
+	return 0;
+}
+EXPORT_SYMBOL(sun8i_mixer_update_layer_coord);
+
+int sun8i_mixer_update_layer_formats(struct sun8i_mixer *mixer,
+				       int layer, struct drm_plane *plane)
+{
+	struct drm_plane_state *state = plane->state;
+	struct drm_framebuffer *fb = state->fb;
+	bool interlaced = false;
+	u32 val;
+	/* Currently the first UI channel is used */
+	int chan = mixer->cfg->vi_num;
+	int ret;
+
+	if (plane->state->crtc)
+		interlaced = plane->state->crtc->state->adjusted_mode.flags
+			& DRM_MODE_FLAG_INTERLACE;
+
+	regmap_update_bits(mixer->regs, SUN8I_MIXER_BLEND_OUTCTL,
+			   SUN8I_MIXER_BLEND_OUTCTL_INTERLACED,
+			   interlaced ?
+			   SUN8I_MIXER_BLEND_OUTCTL_INTERLACED : 0);
+
+	DRM_DEBUG_DRIVER("Switching display mixer interlaced mode %s\n",
+			 interlaced ? "on" : "off");
+
+	ret = sun8i_mixer_drm_format_to_layer(plane, fb->format->format,
+						&val);
+	if (ret) {
+		DRM_DEBUG_DRIVER("Invalid format\n");
+		return ret;
+	}
+
+	regmap_update_bits(mixer->regs,
+			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(chan, layer),
+			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_MASK, val);
+
+	return 0;
+}
+EXPORT_SYMBOL(sun8i_mixer_update_layer_formats);
+
+int sun8i_mixer_update_layer_buffer(struct sun8i_mixer *mixer,
+				      int layer, struct drm_plane *plane)
+{
+	struct drm_plane_state *state = plane->state;
+	struct drm_framebuffer *fb = state->fb;
+	struct drm_gem_cma_object *gem;
+	dma_addr_t paddr;
+	uint32_t paddr_u32;
+	/* Currently the first UI channel is used */
+	int chan = mixer->cfg->vi_num;
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
+	paddr += (state->src_x >> 16) * bpp;
+	paddr += (state->src_y >> 16) * fb->pitches[0];
+	paddr -= SUN8I_DRAM_OFFSET;
+
+	DRM_DEBUG_DRIVER("Setting buffer address to %pad\n", &paddr);
+
+	paddr_u32 = (uint32_t) paddr;
+
+	regmap_write(mixer->regs,
+		     SUN8I_MIXER_CHAN_UI_LAYER_TOP_LADDR(chan, layer),
+		     paddr_u32);
+
+	return 0;
+}
+EXPORT_SYMBOL(sun8i_mixer_update_layer_buffer);
+
+static struct regmap_config sun8i_mixer_regmap_config = {
+	.reg_bits	= 32,
+	.val_bits	= 32,
+	.reg_stride	= 4,
+	.max_register	= 0xbffc, /* guessed */
+};
+
+static int sun8i_mixer_bind(struct device *dev, struct device *master,
+			      void *data)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct drm_device *drm = data;
+	struct sun4i_drv *drv = drm->dev_private;
+	struct sun8i_mixer *mixer;
+	struct resource *res;
+	void __iomem *regs;
+	int i, ret;
+
+	mixer = devm_kzalloc(dev, sizeof(*mixer), GFP_KERNEL);
+	if (!mixer)
+		return -ENOMEM;
+	dev_set_drvdata(dev, mixer);
+	drv->mixer = mixer;
+
+	mixer->cfg = of_device_get_match_data(dev);
+	if (!mixer->cfg)
+		return -EINVAL;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	regs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
+
+	mixer->regs = devm_regmap_init_mmio(dev, regs,
+					      &sun8i_mixer_regmap_config);
+	if (IS_ERR(mixer->regs)) {
+		dev_err(dev, "Couldn't create the mixer regmap\n");
+		return PTR_ERR(mixer->regs);
+	}
+
+	mixer->reset = devm_reset_control_get(dev, NULL);
+	if (IS_ERR(mixer->reset)) {
+		dev_err(dev, "Couldn't get our reset line\n");
+		return PTR_ERR(mixer->reset);
+	}
+
+	ret = reset_control_deassert(mixer->reset);
+	if (ret) {
+		dev_err(dev, "Couldn't deassert our reset line\n");
+		return ret;
+	}
+
+	mixer->bus_clk = devm_clk_get(dev, "bus");
+	if (IS_ERR(mixer->bus_clk)) {
+		dev_err(dev, "Couldn't get the mixer bus clock\n");
+		ret = PTR_ERR(mixer->bus_clk);
+		goto err_assert_reset;
+	}
+	clk_prepare_enable(mixer->bus_clk);
+
+	mixer->mod_clk = devm_clk_get(dev, "mod");
+	if (IS_ERR(mixer->mod_clk)) {
+		dev_err(dev, "Couldn't get the mixer module clock\n");
+		ret = PTR_ERR(mixer->mod_clk);
+		goto err_disable_bus_clk;
+	}
+	clk_prepare_enable(mixer->mod_clk);
+
+	/* Reset the registers */
+	for (i = 0x0; i < 0x20000; i += 4)
+		regmap_write(mixer->regs, i, 0);
+
+	/* Enable the mixer */
+	regmap_write(mixer->regs, SUN8I_MIXER_GLOBAL_CTL,
+		     SUN8I_MIXER_GLOBAL_CTL_RT_EN);
+
+	/* Initialize blender */
+	regmap_write(mixer->regs, SUN8I_MIXER_BLEND_FCOLOR_CTL,
+		     SUN8I_MIXER_BLEND_FCOLOR_CTL_DEF);
+	regmap_write(mixer->regs, SUN8I_MIXER_BLEND_PREMULTIPLY,
+		     SUN8I_MIXER_BLEND_PREMULTIPLY_DEF);
+	regmap_write(mixer->regs, SUN8I_MIXER_BLEND_BKCOLOR,
+		     SUN8I_MIXER_BLEND_BKCOLOR_DEF);
+	regmap_write(mixer->regs, SUN8I_MIXER_BLEND_MODE(0),
+		     SUN8I_MIXER_BLEND_MODE_DEF);
+	regmap_write(mixer->regs, SUN8I_MIXER_BLEND_MODE(1),
+		     SUN8I_MIXER_BLEND_MODE_DEF);
+	regmap_write(mixer->regs, SUN8I_MIXER_BLEND_CK_CTL,
+		     SUN8I_MIXER_BLEND_CK_CTL_DEF);
+
+	for (i = 0; i < SUN8I_MIXER_MAX_CHAN_COUNT; i++)
+		regmap_write(mixer->regs,
+			     SUN8I_MIXER_BLEND_ATTR_FCOLOR(i),
+			     SUN8I_MIXER_BLEND_ATTR_FCOLOR_DEF);
+
+	/* Select the first UI channel */
+	DRM_DEBUG_DRIVER("Selecting channel %d (first UI channel)\n",
+			 mixer->cfg->vi_num);
+	regmap_write(mixer->regs, SUN8I_MIXER_BLEND_ROUTE,
+		     mixer->cfg->vi_num);
+
+	return 0;
+
+	clk_disable_unprepare(mixer->mod_clk);
+err_disable_bus_clk:
+	clk_disable_unprepare(mixer->bus_clk);
+err_assert_reset:
+	reset_control_assert(mixer->reset);
+	return ret;
+}
+
+static void sun8i_mixer_unbind(struct device *dev, struct device *master,
+				 void *data)
+{
+	struct sun8i_mixer *mixer = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(mixer->mod_clk);
+	clk_disable_unprepare(mixer->bus_clk);
+	reset_control_assert(mixer->reset);
+}
+
+static const struct component_ops sun8i_mixer_ops = {
+	.bind	= sun8i_mixer_bind,
+	.unbind	= sun8i_mixer_unbind,
+};
+
+static int sun8i_mixer_probe(struct platform_device *pdev)
+{
+	return component_add(&pdev->dev, &sun8i_mixer_ops);
+}
+
+static int sun8i_mixer_remove(struct platform_device *pdev)
+{
+	component_del(&pdev->dev, &sun8i_mixer_ops);
+
+	return 0;
+}
+
+static const struct sun8i_mixer_cfg sun8i_v3s_mixer_cfg = {
+	.vi_num = 2,
+	.ui_num = 1,
+};
+
+static const struct of_device_id sun8i_mixer_of_table[] = {
+	{
+		.compatible = "allwinner,sun8i-v3s-de2-mixer",
+		.data = &sun8i_v3s_mixer_cfg
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sun8i_mixer_of_table);
+
+static struct platform_driver sun8i_mixer_platform_driver = {
+	.probe		= sun8i_mixer_probe,
+	.remove		= sun8i_mixer_remove,
+	.driver		= {
+		.name		= "sun8i-mixer",
+		.of_match_table	= sun8i_mixer_of_table,
+	},
+};
+module_platform_driver(sun8i_mixer_platform_driver);
+
+MODULE_AUTHOR("Icenowy Zheng <icenowy@aosc.xyz>");
+MODULE_DESCRIPTION("Allwinner DE2 Mixer driver");
+MODULE_LICENSE("GPL");
+#else /* DRM_SUN4I_DE2 */
+void sun8i_mixer_commit(struct sun8i_mixer *mixer)
+{
+}
+
+void sun8i_mixer_layer_enable(struct sun8i_mixer *mixer,
+				int layer, bool enable)
+{
+}
+
+int sun8i_mixer_update_layer_coord(struct sun8i_mixer *mixer,
+				     int layer, struct drm_plane *plane)
+{
+	return -ENOENT;
+}
+
+int sun8i_mixer_update_layer_formats(struct sun8i_mixer *mixer,
+				       int layer, struct drm_plane *plane)
+{
+	return -ENOENT;
+}
+
+int sun8i_mixer_update_layer_buffer(struct sun8i_mixer *mixer,
+				      int layer, struct drm_plane *plane)
+{
+	return -ENOENT;
+}
+#endif /* CONFIG_DRM_SUN4I_DE2 */
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/sun8i_mixer.h
new file mode 100644
index 000000000000..0bc134b3bc98
--- /dev/null
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
@@ -0,0 +1,133 @@
+/*
+ * Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.xyz>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ */
+
+#ifndef _SUN8I_MIXER_H_
+#define _SUN8I_MIXER_H_
+
+#include <linux/clk.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+
+#include "sun4i_layer.h"
+
+#define SUN8I_MIXER_MAX_CHAN_COUNT		4
+
+#define SUN8I_MIXER_SIZE(w, h)			(((h) - 1) << 16 | ((w) - 1))
+#define SUN8I_MIXER_COORD(x, y)			((y) << 16 | (x))
+
+#define SUN8I_MIXER_GLOBAL_CTL			0x0
+#define SUN8I_MIXER_GLOBAL_STATUS		0x4
+#define SUN8I_MIXER_GLOBAL_DBUFF		0x8
+#define SUN8I_MIXER_GLOBAL_SIZE			0xc
+
+#define SUN8I_MIXER_GLOBAL_CTL_RT_EN		0x1
+
+#define SUN8I_MIXER_GLOBAL_DBUFF_ENABLE		0x1
+
+#define SUN8I_MIXER_BLEND_FCOLOR_CTL		0x1000
+#define SUN8I_MIXER_BLEND_ATTR_FCOLOR(x)	(0x1004 + 0x10 * (x) + 0x0)
+#define SUN8I_MIXER_BLEND_ATTR_INSIZE(x)	(0x1004 + 0x10 * (x) + 0x4)
+#define SUN8I_MIXER_BLEND_ATTR_OFFSET(x)	(0x1004 + 0x10 * (x) + 0x8)
+#define SUN8I_MIXER_BLEND_ROUTE			0x1080
+#define SUN8I_MIXER_BLEND_PREMULTIPLY		0x1084
+#define SUN8I_MIXER_BLEND_BKCOLOR		0x1088
+#define SUN8I_MIXER_BLEND_OUTSIZE		0x108c
+#define SUN8I_MIXER_BLEND_MODE(x)		(0x1090 + 0x04 * (x))
+#define SUN8I_MIXER_BLEND_CK_CTL		0x10b0
+#define SUN8I_MIXER_BLEND_CK_CFG		0x10b4
+#define SUN8I_MIXER_BLEND_CK_MAX(x)		(0x10c0 + 0x04 * (x))
+#define SUN8I_MIXER_BLEND_CK_MIN(x)		(0x10e0 + 0x04 * (x))
+#define SUN8I_MIXER_BLEND_OUTCTL		0x10fc
+
+/* The following numbers are some still unknown magic numbers */
+#define SUN8I_MIXER_BLEND_ATTR_FCOLOR_DEF	0xff000000
+#define SUN8I_MIXER_BLEND_FCOLOR_CTL_DEF	0x00000101
+#define SUN8I_MIXER_BLEND_PREMULTIPLY_DEF	0x0
+#define SUN8I_MIXER_BLEND_BKCOLOR_DEF		0xff000000
+#define SUN8I_MIXER_BLEND_MODE_DEF		0x03010301
+#define SUN8I_MIXER_BLEND_CK_CTL_DEF		0x0
+
+#define SUN8I_MIXER_BLEND_OUTCTL_INTERLACED	BIT(1)
+
+/*
+ * VI channels are not used now, but the support of them may be introduced in
+ * the future.
+ */
+
+#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR(ch, layer) \
+			(0x2000 + 0x1000 * (ch) + 0x20 * (layer) + 0x0)
+#define SUN8I_MIXER_CHAN_UI_LAYER_SIZE(ch, layer) \
+			(0x2000 + 0x1000 * (ch) + 0x20 * (layer) + 0x4)
+#define SUN8I_MIXER_CHAN_UI_LAYER_COORD(ch, layer) \
+			(0x2000 + 0x1000 * (ch) + 0x20 * (layer) + 0x8)
+#define SUN8I_MIXER_CHAN_UI_LAYER_PITCH(ch, layer) \
+			(0x2000 + 0x1000 * (ch) + 0x20 * (layer) + 0xc)
+#define SUN8I_MIXER_CHAN_UI_LAYER_TOP_LADDR(ch, layer) \
+			(0x2000 + 0x1000 * (ch) + 0x20 * (layer) + 0x10)
+#define SUN8I_MIXER_CHAN_UI_LAYER_BOT_LADDR(ch, layer) \
+			(0x2000 + 0x1000 * (ch) + 0x20 * (layer) + 0x14)
+#define SUN8I_MIXER_CHAN_UI_LAYER_FCOLOR(ch, layer) \
+			(0x2000 + 0x1000 * (ch) + 0x20 * (layer) + 0x18)
+#define SUN8I_MIXER_CHAN_UI_TOP_HADDR(ch)	(0x2000 + 0x1000 * (ch) + 0x80)
+#define SUN8I_MIXER_CHAN_UI_BOT_HADDR(ch)	(0x2000 + 0x1000 * (ch) + 0x84)
+#define SUN8I_MIXER_CHAN_UI_OVL_SIZE(ch)	(0x2000 + 0x1000 * (ch) + 0x88)
+
+#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_EN		BIT(0)
+#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_MASK	GENMASK(2, 1)
+#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_MASK	GENMASK(11, 8)
+#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MASK	GENMASK(31, 24)
+#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_DEF	(1 << 1)
+#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_ARGB8888	(0 << 8)
+#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_XRGB8888	(4 << 8)
+#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_RGB888	(8 << 8)
+#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_DEF	(0xff << 24)
+
+/*
+ * These sun-engines are still unknown now, the EN registers are here only to
+ * be used to disable these sub-engines.
+ */
+#define SUN8I_MIXER_VSU_EN			0x20000
+#define SUN8I_MIXER_GSU1_EN			0x30000
+#define SUN8I_MIXER_GSU2_EN			0x40000
+#define SUN8I_MIXER_GSU3_EN			0x50000
+#define SUN8I_MIXER_FCE_EN			0xa0000
+#define SUN8I_MIXER_BWS_EN			0xa2000
+#define SUN8I_MIXER_LTI_EN			0xa4000
+#define SUN8I_MIXER_PEAK_EN			0xa6000
+#define SUN8I_MIXER_ASE_EN			0xa8000
+#define SUN8I_MIXER_FCC_EN			0xaa000
+#define SUN8I_MIXER_DCSC_EN			0xb0000
+
+struct sun8i_mixer_cfg {
+	int		vi_num;
+	int		ui_num;
+};
+
+struct sun8i_mixer {
+	struct regmap			*regs;
+
+	const struct sun8i_mixer_cfg	*cfg;
+
+	struct reset_control		*reset;
+
+	struct clk			*bus_clk;
+	struct clk			*mod_clk;
+};
+
+void sun8i_mixer_commit(struct sun8i_mixer *mixer);
+
+void sun8i_mixer_layer_enable(struct sun8i_mixer *mixer,
+				int layer, bool enable);
+int sun8i_mixer_update_layer_coord(struct sun8i_mixer *mixer,
+				     int layer, struct drm_plane *plane);
+int sun8i_mixer_update_layer_formats(struct sun8i_mixer *mixer,
+				       int layer, struct drm_plane *plane);
+int sun8i_mixer_update_layer_buffer(struct sun8i_mixer *mixer,
+				      int layer, struct drm_plane *plane);
+#endif /* _SUN8I_MIXER_H_ */
-- 
2.11.1
