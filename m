From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 17 Oct 2017 11:06:18 +0200
Subject: [PATCH 11/23] drm/sun4i: Rename layers to UI planes
In-Reply-To: <cover.fe3d65d1ee05a55224d26e7d113388c428592b26.1508231063.git-series.maxime.ripard@free-electrons.com>
References: <cover.fe3d65d1ee05a55224d26e7d113388c428592b26.1508231063.git-series.maxime.ripard@free-electrons.com>
Message-ID: <a1d1a106d6db266305f86b1e2626105cb8b88d0a.1508231063.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The currently supported planes for DE2 are actually only UI planes, and the
VI planes will differ both in terms of code and features.

It will make sense to support them in a separate file, so let's make sure
we don't create a confusing file name.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/Makefile      |   2 +-
 drivers/gpu/drm/sun4i/sun8i_layer.c | 134 +-----------------------------
 drivers/gpu/drm/sun4i/sun8i_layer.h |  36 +--------
 drivers/gpu/drm/sun4i/sun8i_mixer.c |   4 +-
 drivers/gpu/drm/sun4i/sun8i_ui.c    | 134 +++++++++++++++++++++++++++++-
 drivers/gpu/drm/sun4i/sun8i_ui.h    |  36 ++++++++-
 6 files changed, 173 insertions(+), 173 deletions(-)
 delete mode 100644 drivers/gpu/drm/sun4i/sun8i_layer.c
 delete mode 100644 drivers/gpu/drm/sun4i/sun8i_layer.h
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_ui.c
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_ui.h

diff --git a/drivers/gpu/drm/sun4i/Makefile b/drivers/gpu/drm/sun4i/Makefile
index af18b70ba5ed..cfba2c07519c 100644
--- a/drivers/gpu/drm/sun4i/Makefile
+++ b/drivers/gpu/drm/sun4i/Makefile
@@ -13,7 +13,7 @@ sun4i-tcon-y			+= sun4i_rgb.o
 sun4i-tcon-y			+= sun4i_dotclock.o
 sun4i-tcon-y			+= sun4i_crtc.o
 
-sun8i-mixer-y			+= sun8i_mixer.o sun8i_layer.o
+sun8i-mixer-y			+= sun8i_mixer.o sun8i_ui.o
 
 obj-$(CONFIG_DRM_SUN4I)		+= sun4i-drm.o sun4i-tcon.o
 obj-$(CONFIG_DRM_SUN4I)		+= sun6i_drc.o
diff --git a/drivers/gpu/drm/sun4i/sun8i_layer.c b/drivers/gpu/drm/sun4i/sun8i_layer.c
deleted file mode 100644
index 23810ff72684..000000000000
--- a/drivers/gpu/drm/sun4i/sun8i_layer.c
+++ /dev/null
@@ -1,134 +0,0 @@
-/*
- * Copyright (C) Icenowy Zheng <icenowy@aosc.io>
- *
- * Based on sun4i_layer.h, which is:
- *   Copyright (C) 2015 Free Electrons
- *   Copyright (C) 2015 NextThing Co
- *
- *   Maxime Ripard <maxime.ripard@free-electrons.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- */
-
-#include <drm/drm_atomic_helper.h>
-#include <drm/drm_plane_helper.h>
-#include <drm/drmP.h>
-
-#include "sun8i_layer.h"
-#include "sun8i_mixer.h"
-
-struct sun8i_plane_desc {
-	       enum drm_plane_type     type;
-	       const uint32_t          *formats;
-	       uint32_t                nformats;
-};
-
-static void sun8i_mixer_layer_atomic_disable(struct drm_plane *plane,
-					       struct drm_plane_state *old_state)
-{
-	struct sun8i_layer *layer = plane_to_sun8i_layer(plane);
-	struct sun8i_mixer *mixer = layer->mixer;
-
-	sun8i_mixer_layer_enable(mixer, layer->id, false);
-}
-
-static void sun8i_mixer_layer_atomic_update(struct drm_plane *plane,
-					      struct drm_plane_state *old_state)
-{
-	struct sun8i_layer *layer = plane_to_sun8i_layer(plane);
-	struct sun8i_mixer *mixer = layer->mixer;
-
-	sun8i_mixer_update_layer_coord(mixer, layer->id, plane);
-	sun8i_mixer_update_layer_formats(mixer, layer->id, plane);
-	sun8i_mixer_update_layer_buffer(mixer, layer->id, plane);
-	sun8i_mixer_layer_enable(mixer, layer->id, true);
-}
-
-static struct drm_plane_helper_funcs sun8i_mixer_layer_helper_funcs = {
-	.atomic_disable	= sun8i_mixer_layer_atomic_disable,
-	.atomic_update	= sun8i_mixer_layer_atomic_update,
-};
-
-static const struct drm_plane_funcs sun8i_mixer_layer_funcs = {
-	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
-	.atomic_duplicate_state	= drm_atomic_helper_plane_duplicate_state,
-	.destroy		= drm_plane_cleanup,
-	.disable_plane		= drm_atomic_helper_disable_plane,
-	.reset			= drm_atomic_helper_plane_reset,
-	.update_plane		= drm_atomic_helper_update_plane,
-};
-
-static const uint32_t sun8i_mixer_layer_formats[] = {
-	DRM_FORMAT_RGB888,
-	DRM_FORMAT_ARGB8888,
-	DRM_FORMAT_XRGB8888,
-};
-
-static const struct sun8i_plane_desc sun8i_mixer_planes[] = {
-	{
-		.type = DRM_PLANE_TYPE_PRIMARY,
-		.formats = sun8i_mixer_layer_formats,
-		.nformats = ARRAY_SIZE(sun8i_mixer_layer_formats),
-	},
-};
-
-static struct sun8i_layer *sun8i_layer_init_one(struct drm_device *drm,
-						struct sun8i_mixer *mixer,
-						const struct sun8i_plane_desc *plane)
-{
-	struct sun8i_layer *layer;
-	int ret;
-
-	layer = devm_kzalloc(drm->dev, sizeof(*layer), GFP_KERNEL);
-	if (!layer)
-		return ERR_PTR(-ENOMEM);
-
-	/* possible crtcs are set later */
-	ret = drm_universal_plane_init(drm, &layer->plane, 0,
-				       &sun8i_mixer_layer_funcs,
-				       plane->formats, plane->nformats,
-				       NULL, plane->type, NULL);
-	if (ret) {
-		dev_err(drm->dev, "Couldn't initialize layer\n");
-		return ERR_PTR(ret);
-	}
-
-	drm_plane_helper_add(&layer->plane,
-			     &sun8i_mixer_layer_helper_funcs);
-	layer->mixer = mixer;
-
-	return layer;
-}
-
-struct drm_plane **sun8i_layers_init(struct drm_device *drm,
-				     struct sunxi_engine *engine)
-{
-	struct drm_plane **planes;
-	struct sun8i_mixer *mixer = engine_to_sun8i_mixer(engine);
-	int i;
-
-	planes = devm_kcalloc(drm->dev, ARRAY_SIZE(sun8i_mixer_planes) + 1,
-			      sizeof(*planes), GFP_KERNEL);
-	if (!planes)
-		return ERR_PTR(-ENOMEM);
-
-	for (i = 0; i < ARRAY_SIZE(sun8i_mixer_planes); i++) {
-		const struct sun8i_plane_desc *plane = &sun8i_mixer_planes[i];
-		struct sun8i_layer *layer;
-
-		layer = sun8i_layer_init_one(drm, mixer, plane);
-		if (IS_ERR(layer)) {
-			dev_err(drm->dev, "Couldn't initialize %s plane\n",
-				i ? "overlay" : "primary");
-			return ERR_CAST(layer);
-		};
-
-		layer->id = i;
-		planes[i] = &layer->plane;
-	};
-
-	return planes;
-}
diff --git a/drivers/gpu/drm/sun4i/sun8i_layer.h b/drivers/gpu/drm/sun4i/sun8i_layer.h
deleted file mode 100644
index e5eccd27cff0..000000000000
--- a/drivers/gpu/drm/sun4i/sun8i_layer.h
+++ /dev/null
@@ -1,36 +0,0 @@
-/*
- * Copyright (C) Icenowy Zheng <icenowy@aosc.io>
- *
- * Based on sun4i_layer.h, which is:
- *   Copyright (C) 2015 Free Electrons
- *   Copyright (C) 2015 NextThing Co
- *
- *   Maxime Ripard <maxime.ripard@free-electrons.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- */
-
-#ifndef _SUN8I_LAYER_H_
-#define _SUN8I_LAYER_H_
-
-struct sunxi_engine;
-
-struct sun8i_layer {
-	struct drm_plane	plane;
-	struct sun4i_drv	*drv;
-	struct sun8i_mixer	*mixer;
-	int			id;
-};
-
-static inline struct sun8i_layer *
-plane_to_sun8i_layer(struct drm_plane *plane)
-{
-	return container_of(plane, struct sun8i_layer, plane);
-}
-
-struct drm_plane **sun8i_layers_init(struct drm_device *drm,
-				     struct sunxi_engine *engine);
-#endif /* _SUN8I_LAYER_H_ */
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index cb193c5f1686..1955b2a36ac5 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -26,7 +26,7 @@
 
 #include "sun4i_drv.h"
 #include "sun8i_mixer.h"
-#include "sun8i_layer.h"
+#include "sun8i_ui.h"
 #include "sunxi_engine.h"
 
 static void sun8i_mixer_commit(struct sunxi_engine *engine)
@@ -228,7 +228,7 @@ int sun8i_mixer_update_layer_buffer(struct sun8i_mixer *mixer,
 
 static const struct sunxi_engine_ops sun8i_engine_ops = {
 	.commit		= sun8i_mixer_commit,
-	.layers_init	= sun8i_layers_init,
+	.layers_init	= sun8i_ui_init,
 };
 
 static struct regmap_config sun8i_mixer_regmap_config = {
diff --git a/drivers/gpu/drm/sun4i/sun8i_ui.c b/drivers/gpu/drm/sun4i/sun8i_ui.c
new file mode 100644
index 000000000000..077099ef565a
--- /dev/null
+++ b/drivers/gpu/drm/sun4i/sun8i_ui.c
@@ -0,0 +1,134 @@
+/*
+ * Copyright (C) Icenowy Zheng <icenowy@aosc.io>
+ *
+ * Based on sun4i_layer.h, which is:
+ *   Copyright (C) 2015 Free Electrons
+ *   Copyright (C) 2015 NextThing Co
+ *
+ *   Maxime Ripard <maxime.ripard@free-electrons.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ */
+
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_plane_helper.h>
+#include <drm/drmP.h>
+
+#include "sun8i_ui.h"
+#include "sun8i_mixer.h"
+
+struct sun8i_plane_desc {
+	       enum drm_plane_type     type;
+	       const uint32_t          *formats;
+	       uint32_t                nformats;
+};
+
+static void sun8i_mixer_ui_atomic_disable(struct drm_plane *plane,
+					  struct drm_plane_state *old_state)
+{
+	struct sun8i_ui *ui = plane_to_sun8i_ui(plane);
+	struct sun8i_mixer *mixer = ui->mixer;
+
+	sun8i_mixer_layer_enable(mixer, ui->id, false);
+}
+
+static void sun8i_mixer_ui_atomic_update(struct drm_plane *plane,
+					 struct drm_plane_state *old_state)
+{
+	struct sun8i_ui *ui = plane_to_sun8i_ui(plane);
+	struct sun8i_mixer *mixer = ui->mixer;
+
+	sun8i_mixer_update_layer_coord(mixer, ui->id, plane);
+	sun8i_mixer_update_layer_formats(mixer, ui->id, plane);
+	sun8i_mixer_update_layer_buffer(mixer, ui->id, plane);
+	sun8i_mixer_layer_enable(mixer, ui->id, true);
+}
+
+static struct drm_plane_helper_funcs sun8i_mixer_ui_helper_funcs = {
+	.atomic_disable	= sun8i_mixer_ui_atomic_disable,
+	.atomic_update	= sun8i_mixer_ui_atomic_update,
+};
+
+static const struct drm_plane_funcs sun8i_mixer_ui_funcs = {
+	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
+	.atomic_duplicate_state	= drm_atomic_helper_plane_duplicate_state,
+	.destroy		= drm_plane_cleanup,
+	.disable_plane		= drm_atomic_helper_disable_plane,
+	.reset			= drm_atomic_helper_plane_reset,
+	.update_plane		= drm_atomic_helper_update_plane,
+};
+
+static const uint32_t sun8i_mixer_ui_formats[] = {
+	DRM_FORMAT_RGB888,
+	DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_XRGB8888,
+};
+
+static const struct sun8i_plane_desc sun8i_mixer_planes[] = {
+	{
+		.type = DRM_PLANE_TYPE_PRIMARY,
+		.formats = sun8i_mixer_ui_formats,
+		.nformats = ARRAY_SIZE(sun8i_mixer_ui_formats),
+	},
+};
+
+static struct sun8i_ui *sun8i_ui_init_one(struct drm_device *drm,
+					  struct sun8i_mixer *mixer,
+					  const struct sun8i_plane_desc *plane)
+{
+	struct sun8i_ui *ui;
+	int ret;
+
+	ui = devm_kzalloc(drm->dev, sizeof(*ui), GFP_KERNEL);
+	if (!ui)
+		return ERR_PTR(-ENOMEM);
+
+	/* possible crtcs are set later */
+	ret = drm_universal_plane_init(drm, &ui->plane, 0,
+				       &sun8i_mixer_ui_funcs,
+				       plane->formats, plane->nformats,
+				       NULL, plane->type, NULL);
+	if (ret) {
+		dev_err(drm->dev, "Couldn't initialize ui\n");
+		return ERR_PTR(ret);
+	}
+
+	drm_plane_helper_add(&ui->plane,
+			     &sun8i_mixer_ui_helper_funcs);
+	ui->mixer = mixer;
+
+	return ui;
+}
+
+struct drm_plane **sun8i_ui_init(struct drm_device *drm,
+				 struct sunxi_engine *engine)
+{
+	struct drm_plane **planes;
+	struct sun8i_mixer *mixer = engine_to_sun8i_mixer(engine);
+	int i;
+
+	planes = devm_kcalloc(drm->dev, ARRAY_SIZE(sun8i_mixer_planes) + 1,
+			      sizeof(*planes), GFP_KERNEL);
+	if (!planes)
+		return ERR_PTR(-ENOMEM);
+
+	for (i = 0; i < ARRAY_SIZE(sun8i_mixer_planes); i++) {
+		const struct sun8i_plane_desc *plane = &sun8i_mixer_planes[i];
+		struct sun8i_ui *ui;
+
+		ui = sun8i_ui_init_one(drm, mixer, plane);
+		if (IS_ERR(ui)) {
+			dev_err(drm->dev, "Couldn't initialize %s plane\n",
+				i ? "overlay" : "primary");
+			return ERR_CAST(ui);
+		};
+
+		ui->id = i;
+		planes[i] = &ui->plane;
+	};
+
+	return planes;
+}
diff --git a/drivers/gpu/drm/sun4i/sun8i_ui.h b/drivers/gpu/drm/sun4i/sun8i_ui.h
new file mode 100644
index 000000000000..17dfc92ccc9f
--- /dev/null
+++ b/drivers/gpu/drm/sun4i/sun8i_ui.h
@@ -0,0 +1,36 @@
+/*
+ * Copyright (C) Icenowy Zheng <icenowy@aosc.io>
+ *
+ * Based on sun4i_layer.h, which is:
+ *   Copyright (C) 2015 Free Electrons
+ *   Copyright (C) 2015 NextThing Co
+ *
+ *   Maxime Ripard <maxime.ripard@free-electrons.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ */
+
+#ifndef _SUN8I_UI_H_
+#define _SUN8I_UI_H_
+
+struct sunxi_engine;
+
+struct sun8i_ui {
+	struct drm_plane	plane;
+	struct sun4i_drv	*drv;
+	struct sun8i_mixer	*mixer;
+	int			id;
+};
+
+static inline struct sun8i_ui *
+plane_to_sun8i_ui(struct drm_plane *plane)
+{
+	return container_of(plane, struct sun8i_ui, plane);
+}
+
+struct drm_plane **sun8i_ui_init(struct drm_device *drm,
+				 struct sunxi_engine *engine);
+#endif /* _SUN8I_UI_H_ */
-- 
git-series 0.9.1
