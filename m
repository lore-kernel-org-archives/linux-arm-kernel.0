From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 23 Mar 2016 17:38:37 +0100
Subject: [PATCH v3 14/19] drm: sun4i: Add RGB output
In-Reply-To: <1458751122-23976-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1458751122-23976-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1458751122-23976-15-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One of the A10 display pipeline possible output is an RGB interface to
drive LCD panels directly. This is done through the first channel of the
TCON that will output our video signals directly.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/Makefile     |   1 +
 drivers/gpu/drm/sun4i/sun4i_drv.c  |   7 ++
 drivers/gpu/drm/sun4i/sun4i_rgb.c  | 234 +++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun4i_rgb.h  |  18 +++
 drivers/gpu/drm/sun4i/sun4i_tcon.c |  48 +++++++-
 drivers/gpu/drm/sun4i/sun4i_tcon.h |   2 +
 6 files changed, 309 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_rgb.c
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_rgb.h

diff --git a/drivers/gpu/drm/sun4i/Makefile b/drivers/gpu/drm/sun4i/Makefile
index 6df3ef32732d..830abb9b2b74 100644
--- a/drivers/gpu/drm/sun4i/Makefile
+++ b/drivers/gpu/drm/sun4i/Makefile
@@ -2,6 +2,7 @@ sun4i-drm-y += sun4i_crtc.o
 sun4i-drm-y += sun4i_drv.o
 sun4i-drm-y += sun4i_framebuffer.o
 sun4i-drm-y += sun4i_layer.o
+sun4i-drm-y += sun4i_rgb.o
 
 sun4i-tcon-y += sun4i_tcon.o
 sun4i-tcon-y += sun4i_dotclock.o
diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 5c64d2105dc7..5ba66ca5258b 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -244,6 +244,13 @@ static int sun4i_drv_add_endpoints(struct device *dev,
 	}
 
 	for_each_available_child_of_node(port, ep) {
+		/*
+		 * If the node is a panel, don't register it into the
+		 * component framework
+		 */
+		if (of_property_read_bool(ep, "allwinner,panel"))
+			continue;
+
 		remote = of_graph_get_remote_port_parent(ep);
 		if (!remote) {
 			DRM_DEBUG_DRIVER("Error retrieving the output node\n");
diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4i_rgb.c
new file mode 100644
index 000000000000..dd0dcc6cdc26
--- /dev/null
+++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
@@ -0,0 +1,234 @@
+/*
+ * Copyright (C) 2015 Free Electrons
+ * Copyright (C) 2015 NextThing Co
+ *
+ * Maxime Ripard <maxime.ripard@free-electrons.com>
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
+struct sun4i_rgb {
+	struct drm_connector	connector;
+	struct drm_encoder	encoder;
+
+	struct sun4i_drv	*drv;
+};
+
+static inline struct sun4i_rgb *
+drm_connector_to_sun4i_rgb(struct drm_connector *connector)
+{
+	return container_of(connector, struct sun4i_rgb,
+			    connector);
+}
+
+static inline struct sun4i_rgb *
+drm_encoder_to_sun4i_rgb(struct drm_encoder *encoder)
+{
+	return container_of(encoder, struct sun4i_rgb,
+			    encoder);
+}
+
+static int sun4i_rgb_get_modes(struct drm_connector *connector)
+{
+	struct sun4i_rgb *rgb =
+		drm_connector_to_sun4i_rgb(connector);
+	struct sun4i_drv *drv = rgb->drv;
+	struct sun4i_tcon *tcon = drv->tcon;
+
+	return drm_panel_get_modes(tcon->panel);
+}
+
+static int sun4i_rgb_mode_valid(struct drm_connector *connector,
+				struct drm_display_mode *mode)
+{
+	u32 hsync = mode->hsync_end - mode->hsync_start;
+	u32 vsync = mode->vsync_end - mode->vsync_start;
+
+	DRM_DEBUG_DRIVER("Validating modes...\n");
+
+	if ((hsync < 1) || (hsync > 0x3ff) ||
+	    (mode->htotal < 1) || (mode->htotal > 0xfff))
+		return MODE_H_ILLEGAL;
+
+	DRM_DEBUG_DRIVER("Horizontal parameters OK\n");
+
+	if ((vsync < 1) || (vsync > 0x3ff) ||
+	    (mode->vtotal < 1) || (mode->vtotal > 0xfff))
+		return MODE_V_ILLEGAL;
+
+	DRM_DEBUG_DRIVER("Vertical parameters OK\n");
+
+	return MODE_OK;
+}
+
+static struct drm_encoder *
+sun4i_rgb_best_encoder(struct drm_connector *connector)
+{
+	struct sun4i_rgb *rgb =
+		drm_connector_to_sun4i_rgb(connector);
+
+	return &rgb->encoder;
+}
+
+static struct drm_connector_helper_funcs sun4i_rgb_con_helper_funcs = {
+	.get_modes	= sun4i_rgb_get_modes,
+	.mode_valid	= sun4i_rgb_mode_valid,
+	.best_encoder	= sun4i_rgb_best_encoder,
+};
+
+static enum drm_connector_status
+sun4i_rgb_connector_detect(struct drm_connector *connector, bool force)
+{
+	return connector_status_connected;
+}
+
+static void
+sun4i_rgb_connector_destroy(struct drm_connector *connector)
+{
+	struct sun4i_rgb *rgb = drm_connector_to_sun4i_rgb(connector);
+	struct sun4i_drv *drv = rgb->drv;
+	struct sun4i_tcon *tcon = drv->tcon;
+
+	drm_panel_detach(tcon->panel);
+	drm_connector_cleanup(connector);
+}
+
+static struct drm_connector_funcs sun4i_rgb_con_funcs = {
+	.dpms			= drm_atomic_helper_connector_dpms,
+	.detect			= sun4i_rgb_connector_detect,
+	.fill_modes		= drm_helper_probe_single_connector_modes,
+	.destroy		= sun4i_rgb_connector_destroy,
+	.reset			= drm_atomic_helper_connector_reset,
+	.atomic_duplicate_state	= drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,
+};
+
+static int sun4i_rgb_atomic_check(struct drm_encoder *encoder,
+				  struct drm_crtc_state *crtc_state,
+				  struct drm_connector_state *conn_state)
+{
+	return 0;
+}
+
+static void sun4i_rgb_encoder_enable(struct drm_encoder *encoder)
+{
+	struct sun4i_rgb *rgb = drm_encoder_to_sun4i_rgb(encoder);
+	struct sun4i_drv *drv = rgb->drv;
+	struct sun4i_tcon *tcon = drv->tcon;
+
+	DRM_DEBUG_DRIVER("Enabling RGB output\n");
+
+	drm_panel_enable(tcon->panel);
+	sun4i_tcon_channel_enable(tcon, 0);
+}
+
+static void sun4i_rgb_encoder_disable(struct drm_encoder *encoder)
+{
+	struct sun4i_rgb *rgb = drm_encoder_to_sun4i_rgb(encoder);
+	struct sun4i_drv *drv = rgb->drv;
+	struct sun4i_tcon *tcon = drv->tcon;
+
+	DRM_DEBUG_DRIVER("Disabling RGB output\n");
+
+	sun4i_tcon_channel_disable(tcon, 0);
+	drm_panel_disable(tcon->panel);
+}
+
+static void sun4i_rgb_encoder_mode_set(struct drm_encoder *encoder,
+				       struct drm_display_mode *mode,
+				       struct drm_display_mode *adjusted_mode)
+{
+	struct sun4i_rgb *rgb = drm_encoder_to_sun4i_rgb(encoder);
+	struct sun4i_drv *drv = rgb->drv;
+	struct sun4i_tcon *tcon = drv->tcon;
+
+	sun4i_tcon0_mode_set(tcon, mode);
+
+	clk_set_rate(tcon->dclk, mode->crtc_clock * 1000);
+
+	/* FIXME: This seems to be board specific */
+	clk_set_phase(tcon->dclk, 120);
+}
+
+static struct drm_encoder_helper_funcs sun4i_rgb_enc_helper_funcs = {
+	.atomic_check	= sun4i_rgb_atomic_check,
+	.mode_set	= sun4i_rgb_encoder_mode_set,
+	.disable	= sun4i_rgb_encoder_disable,
+	.enable		= sun4i_rgb_encoder_enable,
+};
+
+static void sun4i_rgb_enc_destroy(struct drm_encoder *encoder)
+{
+	drm_encoder_cleanup(encoder);
+}
+
+static struct drm_encoder_funcs sun4i_rgb_enc_funcs = {
+	.destroy	= sun4i_rgb_enc_destroy,
+};
+
+int sun4i_rgb_init(struct drm_device *drm)
+{
+	struct sun4i_drv *drv = drm->dev_private;
+	struct sun4i_tcon *tcon = drv->tcon;
+	struct sun4i_rgb *rgb;
+	int ret;
+
+	/* If we don't have a panel, there's no point in going on */
+	if (!tcon->panel)
+		return -ENODEV;
+
+	rgb = devm_kzalloc(drm->dev, sizeof(*rgb), GFP_KERNEL);
+	if (!rgb)
+		return -ENOMEM;
+	rgb->drv = drv;
+
+	drm_encoder_helper_add(&rgb->encoder,
+			       &sun4i_rgb_enc_helper_funcs);
+	ret = drm_encoder_init(drm,
+			       &rgb->encoder,
+			       &sun4i_rgb_enc_funcs,
+			       DRM_MODE_ENCODER_NONE,
+			       NULL);
+	if (ret) {
+		dev_err(drm->dev, "Couldn't initialise the rgb encoder\n");
+		goto err_out;
+	}
+
+	/* The RGB encoder can only work with the TCON channel 0 */
+	rgb->encoder.possible_crtcs = BIT(0);
+
+	drm_connector_helper_add(&rgb->connector,
+				 &sun4i_rgb_con_helper_funcs);
+	ret = drm_connector_init(drm, &rgb->connector,
+				 &sun4i_rgb_con_funcs,
+				 DRM_MODE_CONNECTOR_Unknown);
+	if (ret) {
+		dev_err(drm->dev, "Couldn't initialise the rgb connector\n");
+		goto err_cleanup_connector;
+	}
+
+	drm_mode_connector_attach_encoder(&rgb->connector, &rgb->encoder);
+
+	drm_panel_attach(tcon->panel, &rgb->connector);
+
+	return 0;
+
+err_cleanup_connector:
+	drm_encoder_cleanup(&rgb->encoder);
+err_out:
+	return ret;
+}
+EXPORT_SYMBOL(sun4i_rgb_init);
diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.h b/drivers/gpu/drm/sun4i/sun4i_rgb.h
new file mode 100644
index 000000000000..7c4da4c8acdd
--- /dev/null
+++ b/drivers/gpu/drm/sun4i/sun4i_rgb.h
@@ -0,0 +1,18 @@
+/*
+ * Copyright (C) 2015 Free Electrons
+ * Copyright (C) 2015 NextThing Co
+ *
+ * Maxime Ripard <maxime.ripard@free-electrons.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ */
+
+#ifndef _SUN4I_RGB_H_
+#define _SUN4I_RGB_H_
+
+int sun4i_rgb_init(struct drm_device *drm);
+
+#endif /* _SUN4I_RGB_H_ */
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index b6e57ed79df4..8ae0b20055ee 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -15,10 +15,12 @@
 #include <drm/drm_crtc.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_modes.h>
+#include <drm/drm_panel.h>
 
 #include <linux/component.h>
 #include <linux/ioport.h>
 #include <linux/of_address.h>
+#include <linux/of_graph.h>
 #include <linux/of_irq.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
@@ -26,6 +28,7 @@
 #include "sun4i_crtc.h"
 #include "sun4i_dotclock.h"
 #include "sun4i_drv.h"
+#include "sun4i_rgb.h"
 #include "sun4i_tcon.h"
 
 void sun4i_tcon_disable(struct sun4i_tcon *tcon)
@@ -385,12 +388,29 @@ static int sun4i_tcon_init_regmap(struct device *dev,
 	return 0;
 }
 
+static struct device_node *sun4i_tcon_find_panel(struct device_node *node)
+{
+	struct device_node *port, *end_node;
+
+	/* Inputs are listed first, then outputs */
+	port = of_graph_get_port_by_id(node, 1);
+
+	/* Iterate over the endpoints to find a panel */
+	for_each_child_of_node(port, end_node)
+		/* If the endpoint is not a panel, go on */
+		if (of_property_read_bool(end_node, "allwinner,panel"))
+			return of_graph_get_remote_port_parent(end_node);
+
+	return NULL;
+}
+
 static int sun4i_tcon_bind(struct device *dev, struct device *master,
 			   void *data)
 {
 	struct drm_device *drm = data;
 	struct sun4i_drv *drv = drm->dev_private;
 	struct sun4i_tcon *tcon;
+	struct device_node *np;
 	int ret;
 
 	tcon = devm_kzalloc(dev, sizeof(*tcon), GFP_KERNEL);
@@ -437,7 +457,20 @@ static int sun4i_tcon_bind(struct device *dev, struct device *master,
 		goto err_free_clocks;
 	}
 
-	return 0;
+	np = sun4i_tcon_find_panel(dev->of_node);
+	if (!np) {
+		dev_info(dev, "No panel found... RGB output disabled\n");
+		return 0;
+	}
+
+	tcon->panel = of_drm_find_panel(np);
+	if (!tcon->panel) {
+		dev_err(dev, "Couldn't find our panel\n");
+		ret = -ENODEV;
+		goto err_free_clocks;
+	}
+
+	return sun4i_rgb_init(drm);
 
 err_free_clocks:
 	sun4i_tcon_free_clocks(tcon);
@@ -461,6 +494,19 @@ static struct component_ops sun4i_tcon_ops = {
 
 static int sun4i_tcon_probe(struct platform_device *pdev)
 {
+	struct device_node *node = pdev->dev.of_node;
+	struct device_node *panel_node;
+
+	panel_node = sun4i_tcon_find_panel(node);
+	if (panel_node) {
+		/*
+		 * If the panel is not ready yet, defer the probe
+		 * before registering into the component framework.
+		 */
+		if (!of_drm_find_panel(panel_node))
+			return -EPROBE_DEFER;
+	}
+
 	return component_add(&pdev->dev, &sun4i_tcon_ops);
 }
 
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
index 35161218c2c1..0e0b11db401b 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
@@ -161,6 +161,8 @@ struct sun4i_tcon {
 
 	/* Platform adjustments */
 	bool				has_mux;
+
+	struct drm_panel		*panel;
 };
 
 /* Global Control */
-- 
2.7.3
