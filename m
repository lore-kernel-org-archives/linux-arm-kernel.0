From: icenowy@aosc.io (Icenowy Zheng)
Date: Thu, 30 Mar 2017 03:46:07 +0800
Subject: [PATCH v3 05/11] drm/sun4i: abstract a mixer type
In-Reply-To: <20170329194613.55548-1-icenowy@aosc.io>
References: <20170329194613.55548-1-icenowy@aosc.io>
Message-ID: <20170329194613.55548-6-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we are going to add support for the Allwinner DE2 mixer in sun4i-drm
driver, we will finally have two types of display mixers -- the DE1
backend and the DE2 mixer. They both do some display blending and feed
graphics data to TCON, so I choose to call them both "mixer" here.

Abstract the mixer type to void * and a ops struct, which contains
functions that should be called outside the mixer-specified code (in
TCON, CRTC or TV Encoder code).

A dedicated Kconfig option is also added to control whether
sun4i-backend-specified code (sun4i_backend.c and sun4i_layer.c) should
be built. As we removed the codes in CRTC code that directly call the
layer code, we can now extract the layer part and combine it with the
backend part into a new module, sun4i-backend.ko.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
Refactored patch in v3.

 drivers/gpu/drm/sun4i/Kconfig         | 10 ++++++++++
 drivers/gpu/drm/sun4i/Makefile        |  6 ++++--
 drivers/gpu/drm/sun4i/sun4i_backend.c | 26 +++++++++++++++++++-------
 drivers/gpu/drm/sun4i/sun4i_backend.h |  5 -----
 drivers/gpu/drm/sun4i/sun4i_crtc.c    | 14 +++++++-------
 drivers/gpu/drm/sun4i/sun4i_crtc.h    |  7 ++++---
 drivers/gpu/drm/sun4i/sun4i_drv.h     |  3 ++-
 drivers/gpu/drm/sun4i/sun4i_layer.c   |  7 +++----
 drivers/gpu/drm/sun4i/sun4i_layer.h   |  6 +++---
 drivers/gpu/drm/sun4i/sun4i_tcon.c    |  2 +-
 drivers/gpu/drm/sun4i/sun4i_tv.c      |  8 +++-----
 drivers/gpu/drm/sun4i/sunxi_mixer.h   | 22 ++++++++++++++++++++++
 12 files changed, 78 insertions(+), 38 deletions(-)
 create mode 100644 drivers/gpu/drm/sun4i/sunxi_mixer.h

diff --git a/drivers/gpu/drm/sun4i/Kconfig b/drivers/gpu/drm/sun4i/Kconfig
index a4b357db8856..5a8227f37cc4 100644
--- a/drivers/gpu/drm/sun4i/Kconfig
+++ b/drivers/gpu/drm/sun4i/Kconfig
@@ -12,3 +12,13 @@ config DRM_SUN4I
 	  Choose this option if you have an Allwinner SoC with a
 	  Display Engine. If M is selected the module will be called
 	  sun4i-drm.
+
+config DRM_SUN4I_BACKEND
+	tristate "Support for Allwinner A10 Display Engine Backend"
+	depends on DRM_SUN4I
+	default DRM_SUN4I
+	help
+	  Choose this option if you have an Allwinner SoC with the
+	  original Allwinner Display Engine, which has a backend to
+	  do some alpha blending and feed graphics to TCON. If M is
+	  selected the module will be called sun4i-backend.
diff --git a/drivers/gpu/drm/sun4i/Makefile b/drivers/gpu/drm/sun4i/Makefile
index 59b757350a1f..1db1068b9be1 100644
--- a/drivers/gpu/drm/sun4i/Makefile
+++ b/drivers/gpu/drm/sun4i/Makefile
@@ -5,9 +5,11 @@ sun4i-tcon-y += sun4i_tcon.o
 sun4i-tcon-y += sun4i_rgb.o
 sun4i-tcon-y += sun4i_dotclock.o
 sun4i-tcon-y += sun4i_crtc.o
-sun4i-tcon-y += sun4i_layer.o
+
+sun4i-backend-y += sun4i_layer.o
+sun4i-backend-y += sun4i_backend.o
 
 obj-$(CONFIG_DRM_SUN4I)		+= sun4i-drm.o sun4i-tcon.o
-obj-$(CONFIG_DRM_SUN4I)		+= sun4i_backend.o
+obj-$(CONFIG_DRM_SUN4I_BACKEND)	+= sun4i-backend.o
 obj-$(CONFIG_DRM_SUN4I)		+= sun6i_drc.o
 obj-$(CONFIG_DRM_SUN4I)		+= sun4i_tv.o
diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index d660741ba475..35ea51b686e6 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -23,6 +23,8 @@
 
 #include "sun4i_backend.h"
 #include "sun4i_drv.h"
+#include "sun4i_layer.h"
+#include "sunxi_mixer.h"
 
 static const u32 sunxi_rgb2yuv_coef[12] = {
 	0x00000107, 0x00000204, 0x00000064, 0x00000108,
@@ -30,9 +32,10 @@ static const u32 sunxi_rgb2yuv_coef[12] = {
 	0x000001c1, 0x00003e88, 0x00003fb8, 0x00000808
 };
 
-void sun4i_backend_apply_color_correction(struct sun4i_backend *backend)
+static void sun4i_backend_apply_color_correction(void *mixer)
 {
 	int i;
+	struct sun4i_backend *backend = mixer;
 
 	DRM_DEBUG_DRIVER("Applying RGB to YUV color correction\n");
 
@@ -44,27 +47,28 @@ void sun4i_backend_apply_color_correction(struct sun4i_backend *backend)
 		regmap_write(backend->regs, SUN4I_BACKEND_OCRCOEF_REG(i),
 			     sunxi_rgb2yuv_coef[i]);
 }
-EXPORT_SYMBOL(sun4i_backend_apply_color_correction);
 
-void sun4i_backend_disable_color_correction(struct sun4i_backend *backend)
+static void sun4i_backend_disable_color_correction(void *mixer)
 {
+	struct sun4i_backend *backend = mixer;
+
 	DRM_DEBUG_DRIVER("Disabling color correction\n");
 
 	/* Disable color correction */
 	regmap_update_bits(backend->regs, SUN4I_BACKEND_OCCTL_REG,
 			   SUN4I_BACKEND_OCCTL_ENABLE, 0);
 }
-EXPORT_SYMBOL(sun4i_backend_disable_color_correction);
 
-void sun4i_backend_commit(struct sun4i_backend *backend)
+static void sun4i_backend_commit(void *mixer)
 {
+	struct sun4i_backend *backend = mixer;
+
 	DRM_DEBUG_DRIVER("Committing changes\n");
 
 	regmap_write(backend->regs, SUN4I_BACKEND_REGBUFFCTL_REG,
 		     SUN4I_BACKEND_REGBUFFCTL_AUTOLOAD_DIS |
 		     SUN4I_BACKEND_REGBUFFCTL_LOADCTL);
 }
-EXPORT_SYMBOL(sun4i_backend_commit);
 
 void sun4i_backend_layer_enable(struct sun4i_backend *backend,
 				int layer, bool enable)
@@ -288,6 +292,13 @@ static int sun4i_backend_free_sat(struct device *dev) {
 	return 0;
 }
 
+static const struct sunxi_mixer_ops sun4i_backend_mixer_ops = {
+	.apply_color_correction = sun4i_backend_apply_color_correction,
+	.disable_color_correction = sun4i_backend_disable_color_correction,
+	.commit = sun4i_backend_commit,
+	.layers_init = sun4i_layers_init,
+};
+
 static struct regmap_config sun4i_backend_regmap_config = {
 	.reg_bits	= 32,
 	.val_bits	= 32,
@@ -310,7 +321,8 @@ static int sun4i_backend_bind(struct device *dev, struct device *master,
 	if (!backend)
 		return -ENOMEM;
 	dev_set_drvdata(dev, backend);
-	drv->backend = backend;
+	drv->mixer = backend;
+	drv->mixer_ops = &sun4i_backend_mixer_ops;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	regs = devm_ioremap_resource(dev, res);
diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.h b/drivers/gpu/drm/sun4i/sun4i_backend.h
index 83e63cc702b4..65ef521de7d2 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.h
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.h
@@ -151,11 +151,6 @@ struct sun4i_backend {
 	struct reset_control	*sat_reset;
 };
 
-void sun4i_backend_apply_color_correction(struct sun4i_backend *backend);
-void sun4i_backend_disable_color_correction(struct sun4i_backend *backend);
-
-void sun4i_backend_commit(struct sun4i_backend *backend);
-
 void sun4i_backend_layer_enable(struct sun4i_backend *backend,
 				int layer, bool enable);
 int sun4i_backend_update_layer_coord(struct sun4i_backend *backend,
diff --git a/drivers/gpu/drm/sun4i/sun4i_crtc.c b/drivers/gpu/drm/sun4i/sun4i_crtc.c
index 33854ee7f636..938dfe7188ff 100644
--- a/drivers/gpu/drm/sun4i/sun4i_crtc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_crtc.c
@@ -25,11 +25,10 @@
 
 #include <video/videomode.h>
 
-#include "sun4i_backend.h"
 #include "sun4i_crtc.h"
 #include "sun4i_drv.h"
-#include "sun4i_layer.h"
 #include "sunxi_layer.h"
+#include "sunxi_mixer.h"
 #include "sun4i_tcon.h"
 
 static void sun4i_crtc_atomic_begin(struct drm_crtc *crtc,
@@ -57,7 +56,7 @@ static void sun4i_crtc_atomic_flush(struct drm_crtc *crtc,
 
 	DRM_DEBUG_DRIVER("Committing plane changes\n");
 
-	sun4i_backend_commit(scrtc->backend);
+	scrtc->mixer_ops->commit(scrtc->mixer);
 
 	if (event) {
 		crtc->state->event = NULL;
@@ -135,8 +134,8 @@ static const struct drm_crtc_funcs sun4i_crtc_funcs = {
 	.disable_vblank		= sun4i_crtc_disable_vblank,
 };
 
-struct sun4i_crtc *sun4i_crtc_init(struct drm_device *drm,
-				   struct sun4i_backend *backend,
+struct sun4i_crtc *sun4i_crtc_init(struct drm_device *drm, void *mixer,
+				   const struct sunxi_mixer_ops *mixer_ops,
 				   struct sun4i_tcon *tcon)
 {
 	struct sun4i_crtc *scrtc;
@@ -146,11 +145,12 @@ struct sun4i_crtc *sun4i_crtc_init(struct drm_device *drm,
 	scrtc = devm_kzalloc(drm->dev, sizeof(*scrtc), GFP_KERNEL);
 	if (!scrtc)
 		return ERR_PTR(-ENOMEM);
-	scrtc->backend = backend;
+	scrtc->mixer = mixer;
+	scrtc->mixer_ops = mixer_ops;
 	scrtc->tcon = tcon;
 
 	/* Create our layers */
-	scrtc->layers = (void **)sun4i_layers_init(drm, scrtc);
+	scrtc->layers = mixer_ops->layers_init(drm, scrtc);
 	if (IS_ERR(scrtc->layers)) {
 		dev_err(drm->dev, "Couldn't create the planes\n");
 		return NULL;
diff --git a/drivers/gpu/drm/sun4i/sun4i_crtc.h b/drivers/gpu/drm/sun4i/sun4i_crtc.h
index a4036ee44cf8..808019046397 100644
--- a/drivers/gpu/drm/sun4i/sun4i_crtc.h
+++ b/drivers/gpu/drm/sun4i/sun4i_crtc.h
@@ -17,7 +17,8 @@ struct sun4i_crtc {
 	struct drm_crtc			crtc;
 	struct drm_pending_vblank_event	*event;
 
-	struct sun4i_backend		*backend;
+	void				*mixer;
+	const struct sunxi_mixer_ops	*mixer_ops;
 	struct sun4i_tcon		*tcon;
 	void				**layers;
 	const struct sunxi_layer_ops	*layer_ops;
@@ -28,8 +29,8 @@ static inline struct sun4i_crtc *drm_crtc_to_sun4i_crtc(struct drm_crtc *crtc)
 	return container_of(crtc, struct sun4i_crtc, crtc);
 }
 
-struct sun4i_crtc *sun4i_crtc_init(struct drm_device *drm,
-				   struct sun4i_backend *backend,
+struct sun4i_crtc *sun4i_crtc_init(struct drm_device *drm, void *mixer,
+				   const struct sunxi_mixer_ops *mixer_ops,
 				   struct sun4i_tcon *tcon);
 
 #endif /* _SUN4I_CRTC_H_ */
diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.h b/drivers/gpu/drm/sun4i/sun4i_drv.h
index 5df50126ff52..97666b3e6381 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.h
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.h
@@ -17,8 +17,9 @@
 #include <linux/regmap.h>
 
 struct sun4i_drv {
-	struct sun4i_backend	*backend;
+	void			*mixer;
 	struct sun4i_tcon	*tcon;
+	const struct sunxi_mixer_ops *mixer_ops;
 
 	struct drm_fbdev_cma	*fbdev;
 };
diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
index bc4a70d6968b..972e1eb0bb2a 100644
--- a/drivers/gpu/drm/sun4i/sun4i_layer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
@@ -141,11 +141,10 @@ static struct sun4i_layer *sun4i_layer_init_one(struct drm_device *drm,
 	return layer;
 }
 
-struct sun4i_layer **sun4i_layers_init(struct drm_device *drm,
-				       struct sun4i_crtc *crtc)
+void **sun4i_layers_init(struct drm_device *drm, struct sun4i_crtc *crtc)
 {
 	struct sun4i_layer **layers;
-	struct sun4i_backend *backend = crtc->backend;
+	struct sun4i_backend *backend = crtc->mixer;
 	int i;
 
 	layers = devm_kcalloc(drm->dev, ARRAY_SIZE(sun4i_backend_planes) + 1,
@@ -198,5 +197,5 @@ struct sun4i_layer **sun4i_layers_init(struct drm_device *drm,
 	/* Assign layer ops to the CRTC */
 	crtc->layer_ops = &layer_ops;
 
-	return layers;
+	return (void **)layers;
 }
diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.h b/drivers/gpu/drm/sun4i/sun4i_layer.h
index 425eea7b9e3b..e6a08216d038 100644
--- a/drivers/gpu/drm/sun4i/sun4i_layer.h
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.h
@@ -13,6 +13,8 @@
 #ifndef _SUN4I_LAYER_H_
 #define _SUN4I_LAYER_H_
 
+struct sun4i_crtc;
+
 struct sun4i_layer {
 	struct drm_plane	plane;
 	struct sun4i_drv	*drv;
@@ -26,7 +28,5 @@ plane_to_sun4i_layer(struct drm_plane *plane)
 	return container_of(plane, struct sun4i_layer, plane);
 }
 
-struct sun4i_layer **sun4i_layers_init(struct drm_device *drm,
-				       struct sun4i_crtc *crtc);
-
+void **sun4i_layers_init(struct drm_device *drm, struct sun4i_crtc *crtc);
 #endif /* _SUN4I_LAYER_H_ */
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 3ced0b1cef6e..2f330e4e2ead 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -528,7 +528,7 @@ static int sun4i_tcon_bind(struct device *dev, struct device *master,
 		goto err_free_dotclock;
 	}
 
-	tcon->crtc = sun4i_crtc_init(drm, drv->backend, tcon);
+	tcon->crtc = sun4i_crtc_init(drm, drv->mixer, drv->mixer_ops, tcon);
 	if (IS_ERR(tcon->crtc)) {
 		dev_err(dev, "Couldn't create our CRTC\n");
 		ret = PTR_ERR(tcon->crtc);
diff --git a/drivers/gpu/drm/sun4i/sun4i_tv.c b/drivers/gpu/drm/sun4i/sun4i_tv.c
index 49c49431a053..5950736610aa 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tv.c
@@ -22,10 +22,10 @@
 #include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 
-#include "sun4i_backend.h"
 #include "sun4i_crtc.h"
 #include "sun4i_drv.h"
 #include "sun4i_tcon.h"
+#include "sunxi_mixer.h"
 
 #define SUN4I_TVE_EN_REG		0x000
 #define SUN4I_TVE_EN_DAC_MAP_MASK		GENMASK(19, 4)
@@ -353,7 +353,6 @@ static void sun4i_tv_disable(struct drm_encoder *encoder)
 	struct sun4i_tv *tv = drm_encoder_to_sun4i_tv(encoder);
 	struct sun4i_crtc *crtc = drm_crtc_to_sun4i_crtc(encoder->crtc);
 	struct sun4i_tcon *tcon = crtc->tcon;
-	struct sun4i_backend *backend = crtc->backend;
 
 	DRM_DEBUG_DRIVER("Disabling the TV Output\n");
 
@@ -362,7 +361,7 @@ static void sun4i_tv_disable(struct drm_encoder *encoder)
 	regmap_update_bits(tv->regs, SUN4I_TVE_EN_REG,
 			   SUN4I_TVE_EN_ENABLE,
 			   0);
-	sun4i_backend_disable_color_correction(backend);
+	crtc->mixer_ops->disable_color_correction(crtc->mixer);
 }
 
 static void sun4i_tv_enable(struct drm_encoder *encoder)
@@ -370,11 +369,10 @@ static void sun4i_tv_enable(struct drm_encoder *encoder)
 	struct sun4i_tv *tv = drm_encoder_to_sun4i_tv(encoder);
 	struct sun4i_crtc *crtc = drm_crtc_to_sun4i_crtc(encoder->crtc);
 	struct sun4i_tcon *tcon = crtc->tcon;
-	struct sun4i_backend *backend = crtc->backend;
 
 	DRM_DEBUG_DRIVER("Enabling the TV Output\n");
 
-	sun4i_backend_apply_color_correction(backend);
+	crtc->mixer_ops->apply_color_correction(crtc->mixer);
 
 	regmap_update_bits(tv->regs, SUN4I_TVE_EN_REG,
 			   SUN4I_TVE_EN_ENABLE,
diff --git a/drivers/gpu/drm/sun4i/sunxi_mixer.h b/drivers/gpu/drm/sun4i/sunxi_mixer.h
new file mode 100644
index 000000000000..11bdd20269ef
--- /dev/null
+++ b/drivers/gpu/drm/sun4i/sunxi_mixer.h
@@ -0,0 +1,22 @@
+/*
+ * Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.xyz>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ */
+
+#ifndef _SUNXI_MIXER_H_
+#define _SUNXI_MIXER_H_
+
+struct sun4i_crtc;
+
+struct sunxi_mixer_ops {
+	void **(*layers_init)(struct drm_device *drm, struct sun4i_crtc *crtc);
+	void (*apply_color_correction)(void *mixer);
+	void (*disable_color_correction)(void *mixer);
+	void (*commit)(void *mixer);
+};
+
+#endif /* _SUNXI_MIXER_H_ */
-- 
2.12.0
