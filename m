From: plaes@plaes.org (Priit Laes)
Date: Sat, 11 Feb 2017 19:44:03 +0200
Subject: [PATCH 6/8] drm/sun4i: Add initial LVDS stub
In-Reply-To: <20170211174405.28395-1-plaes@plaes.org>
References: <20170211174405.28395-1-plaes@plaes.org>
Message-ID: <20170211174405.28395-7-plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Priit Laes <plaes@plaes.org>
---
 drivers/gpu/drm/sun4i/Makefile     |   1 +
 drivers/gpu/drm/sun4i/sun4i_lvds.c | 247 +++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun4i_lvds.h |  15 +++
 3 files changed, 263 insertions(+)
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_lvds.c
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_lvds.h

diff --git a/drivers/gpu/drm/sun4i/Makefile b/drivers/gpu/drm/sun4i/Makefile
index d625a82..5dfbe16 100644
--- a/drivers/gpu/drm/sun4i/Makefile
+++ b/drivers/gpu/drm/sun4i/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_DRM_SUN4I)		+= sun4i-drm.o sun4i-tcon.o
 obj-$(CONFIG_DRM_SUN4I)		+= sun4i_backend.o
 obj-$(CONFIG_DRM_SUN4I)		+= sun6i_drc.o
 obj-$(CONFIG_DRM_SUN4I)		+= sun4i_tv.o
+obj-$(CONFIG_DRM_SUN4I)		+= sun4i_lvds.o
diff --git a/drivers/gpu/drm/sun4i/sun4i_lvds.c b/drivers/gpu/drm/sun4i/sun4i_lvds.c
new file mode 100644
index 0000000..2ba4705
--- /dev/null
+++ b/drivers/gpu/drm/sun4i/sun4i_lvds.c
@@ -0,0 +1,247 @@
+/*
+ * Copyright (C) 2016 Priit Laes
+ *
+ * Priit Laes <plaes@plaes.org>
+ *
+ * Based on sun4i_rgb.c by Maxime Ripard <maxime.ripard@free-electrons.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ */
+
+#include <linux/clk.h>
+
+#include <drm/drmP.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_panel.h>
+
+#include "sun4i_drv.h"
+#include "sun4i_tcon.h"
+
+struct sun4i_lvds {
+	struct drm_connector	connector;
+	struct drm_encoder	encoder;
+
+	struct sun4i_drv	*drv;
+};
+
+static inline struct sun4i_lvds *
+drm_connector_to_sun4i_lvds(struct drm_connector *connector)
+{
+	return container_of(connector, struct sun4i_lvds,
+			    connector);
+}
+
+static inline struct sun4i_lvds *
+drm_encoder_to_sun4i_lvds(struct drm_encoder *encoder)
+{
+	return container_of(encoder, struct sun4i_lvds,
+			    encoder);
+}
+
+static int sun4i_lvds_get_modes(struct drm_connector *connector)
+{
+	struct sun4i_lvds *lvds =
+		drm_connector_to_sun4i_lvds(connector);
+	struct sun4i_drv *drv = lvds->drv;
+	struct sun4i_tcon *tcon = drv->tcon;
+
+	return drm_panel_get_modes(tcon->panel);
+}
+
+static int sun4i_lvds_mode_valid(struct drm_connector *connector,
+				 struct drm_display_mode *mode)
+{
+	DRM_DEBUG_DRIVER("LVDS mode valid!\n");
+	return MODE_OK;
+}
+
+static struct drm_connector_helper_funcs sun4i_lvds_con_helper_funcs = {
+	.get_modes	= sun4i_lvds_get_modes,
+	.mode_valid	= sun4i_lvds_mode_valid,
+};
+
+static enum drm_connector_status
+sun4i_lvds_connector_detect(struct drm_connector *connector, bool force)
+{
+	return connector_status_connected;
+}
+
+static void
+sun4i_lvds_connector_destroy(struct drm_connector *connector)
+{
+	struct sun4i_lvds *lvds = drm_connector_to_sun4i_lvds(connector);
+	struct sun4i_drv *drv = lvds->drv;
+	struct sun4i_tcon *tcon = drv->tcon;
+
+	drm_panel_detach(tcon->panel);
+	drm_connector_cleanup(connector);
+}
+
+static struct drm_connector_funcs sun4i_lvds_con_funcs = {
+	.dpms			= drm_atomic_helper_connector_dpms,
+	.detect			= sun4i_lvds_connector_detect,
+	.fill_modes		= drm_helper_probe_single_connector_modes,
+	.destroy		= sun4i_lvds_connector_destroy,
+	.reset			= drm_atomic_helper_connector_reset,
+	.atomic_duplicate_state	= drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,
+};
+
+static int sun4i_lvds_atomic_check(struct drm_encoder *encoder,
+				  struct drm_crtc_state *crtc_state,
+				  struct drm_connector_state *conn_state)
+{
+	return 0;
+}
+
+static void sun4i_lvds_encoder_enable(struct drm_encoder *encoder)
+{
+	struct sun4i_lvds *lvds = drm_encoder_to_sun4i_lvds(encoder);
+	struct sun4i_drv *drv = lvds->drv;
+	struct sun4i_tcon *tcon = drv->tcon;
+
+	DRM_DEBUG_DRIVER("Enabling LVDS output\n");
+
+	if (!IS_ERR(tcon->panel)) {
+		drm_panel_prepare(tcon->panel);
+		drm_panel_enable(tcon->panel);
+	}
+
+	/* encoder->bridge can be NULL; drm_bridge_enable checks for it */
+	drm_bridge_enable(encoder->bridge);
+
+	sun4i_tcon_channel_enable(tcon, 0);
+}
+
+static void sun4i_lvds_encoder_disable(struct drm_encoder *encoder)
+{
+	struct sun4i_lvds *lvds = drm_encoder_to_sun4i_lvds(encoder);
+	struct sun4i_drv *drv = lvds->drv;
+	struct sun4i_tcon *tcon = drv->tcon;
+
+	DRM_DEBUG_DRIVER("Disabling LVDS output\n");
+
+	sun4i_tcon_channel_disable(tcon, 0);
+
+	/* encoder->bridge can be NULL; drm_bridge_disable checks for it */
+	drm_bridge_disable(encoder->bridge);
+
+	if (!IS_ERR(tcon->panel)) {
+		drm_panel_disable(tcon->panel);
+		drm_panel_unprepare(tcon->panel);
+	}
+}
+
+static void sun4i_lvds_encoder_mode_set(struct drm_encoder *encoder,
+				       struct drm_display_mode *mode,
+				       struct drm_display_mode *adjusted_mode)
+{
+	struct sun4i_lvds *lvds = drm_encoder_to_sun4i_lvds(encoder);
+	struct sun4i_drv *drv = lvds->drv;
+	struct sun4i_tcon *tcon = drv->tcon;
+
+	sun4i_tcon0_mode_set(tcon, mode, DRM_MODE_ENCODER_LVDS);
+
+	clk_set_rate(tcon->dclk, mode->crtc_clock * 1000);
+
+	/* FIXME: This seems to be board specific */
+	clk_set_phase(tcon->dclk, 60);
+}
+
+static struct drm_encoder_helper_funcs sun4i_lvds_enc_helper_funcs = {
+	.atomic_check	= sun4i_lvds_atomic_check,
+	.mode_set	= sun4i_lvds_encoder_mode_set,
+	.disable	= sun4i_lvds_encoder_disable,
+	.enable		= sun4i_lvds_encoder_enable,
+};
+
+static void sun4i_lvds_enc_destroy(struct drm_encoder *encoder)
+{
+	drm_encoder_cleanup(encoder);
+}
+
+static struct drm_encoder_funcs sun4i_lvds_enc_funcs = {
+	.destroy	= sun4i_lvds_enc_destroy,
+};
+
+int sun4i_lvds_init(struct drm_device *drm)
+{
+	struct sun4i_drv *drv = drm->dev_private;
+	struct sun4i_tcon *tcon = drv->tcon;
+	struct drm_encoder *encoder;
+	struct sun4i_lvds *lvds;
+	int ret;
+
+	lvds = devm_kzalloc(drm->dev, sizeof(*lvds), GFP_KERNEL);
+	if (!lvds)
+		return -ENOMEM;
+	lvds->drv = drv;
+	encoder = &lvds->encoder;
+
+	tcon->panel = sun4i_tcon_find_panel(tcon->dev->of_node);
+	encoder->bridge = sun4i_tcon_find_bridge(tcon->dev->of_node);
+	if (IS_ERR(tcon->panel) && IS_ERR(encoder->bridge)) {
+		dev_info(drm->dev, "No panel or bridge found... LVDS output disabled\n");
+		return 0;
+	}
+
+	drm_encoder_helper_add(&lvds->encoder,
+			       &sun4i_lvds_enc_helper_funcs);
+	ret = drm_encoder_init(drm,
+			       &lvds->encoder,
+			       &sun4i_lvds_enc_funcs,
+			       DRM_MODE_ENCODER_NONE,
+			       NULL);
+	if (ret) {
+		dev_err(drm->dev, "Couldn't initialise the LVDS encoder\n");
+		goto err_out;
+	}
+
+	/* Hardcode to TCON channel 0 */
+	lvds->encoder.possible_crtcs = BIT(0);
+
+	if (!IS_ERR(tcon->panel)) {
+		drm_connector_helper_add(&lvds->connector,
+					 &sun4i_lvds_con_helper_funcs);
+		ret = drm_connector_init(drm, &lvds->connector,
+					 &sun4i_lvds_con_funcs,
+					 DRM_MODE_CONNECTOR_LVDS);
+		if (ret) {
+			dev_err(drm->dev, "Couldn't initialise the LVDS connector\n");
+			goto err_cleanup_connector;
+		}
+
+		drm_mode_connector_attach_encoder(&lvds->connector,
+						  &lvds->encoder);
+
+		ret = drm_panel_attach(tcon->panel, &lvds->connector);
+		if (ret) {
+			dev_err(drm->dev, "Couldn't attach our panel\n");
+			goto err_cleanup_connector;
+		}
+	}
+
+	if (!IS_ERR(encoder->bridge)) {
+		encoder->bridge->encoder = &lvds->encoder;
+
+		ret = drm_bridge_attach(drm, encoder->bridge);
+		if (ret) {
+			dev_err(drm->dev, "Couldn't attach our bridge\n");
+			goto err_cleanup_connector;
+		}
+	} else {
+		encoder->bridge = NULL;
+	}
+
+	return 0;
+
+err_cleanup_connector:
+	drm_encoder_cleanup(&lvds->encoder);
+err_out:
+	return ret;
+}
+EXPORT_SYMBOL(sun4i_lvds_init);
diff --git a/drivers/gpu/drm/sun4i/sun4i_lvds.h b/drivers/gpu/drm/sun4i/sun4i_lvds.h
new file mode 100644
index 0000000..1fc9646
--- /dev/null
+++ b/drivers/gpu/drm/sun4i/sun4i_lvds.h
@@ -0,0 +1,15 @@
+/*
+ * Copyright (C) 2016 Priit Laes <plaes@plaes.org>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ */
+
+#ifndef _SUN4I_LVDS_H_
+#define _SUN4I_LVDS_H_
+
+int sun4i_lvds_init(struct drm_device *drm);
+
+#endif /* _SUN4I_LVDS_H_ */
-- 
2.9.3
