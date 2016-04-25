From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 25 Apr 2016 15:22:47 +0200
Subject: [PATCH v4 06/11] drm: sun4i: Add RGB output
In-Reply-To: <1461590572-4027-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1461590572-4027-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1461590572-4027-7-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One of the A10 display pipeline possible output is an RGB interface to
drive LCD panels directly. This is done through the first channel of the
TCON that will output our video signals directly.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/Makefile     |   1 +
 drivers/gpu/drm/sun4i/sun4i_drv.c  |  24 ++++
 drivers/gpu/drm/sun4i/sun4i_rgb.c  | 250 +++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun4i_rgb.h  |  18 +++
 drivers/gpu/drm/sun4i/sun4i_tcon.c |  61 ++++++++-
 drivers/gpu/drm/sun4i/sun4i_tcon.h |   2 +
 6 files changed, 355 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_rgb.c
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_rgb.h

diff --git a/drivers/gpu/drm/sun4i/Makefile b/drivers/gpu/drm/sun4i/Makefile
index 6df3ef32732d..74f804b88ff5 100644
--- a/drivers/gpu/drm/sun4i/Makefile
+++ b/drivers/gpu/drm/sun4i/Makefile
@@ -4,6 +4,7 @@ sun4i-drm-y += sun4i_framebuffer.o
 sun4i-drm-y += sun4i_layer.o
 
 sun4i-tcon-y += sun4i_tcon.o
+sun4i-tcon-y += sun4i_rgb.o
 sun4i-tcon-y += sun4i_dotclock.o
 
 obj-$(CONFIG_DRM_SUN4I)		+= sun4i-drm.o sun4i-tcon.o
diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index a081969673ac..891d434ea57f 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -222,6 +222,11 @@ static bool sun4i_drv_node_is_frontend(struct device_node *node)
 				       "allwinner,sun5i-a13-display-frontend");
 }
 
+static bool sun4i_drv_node_is_tcon(struct device_node *node)
+{
+	return of_device_is_compatible(node, "allwinner,sun5i-a13-tcon");
+}
+
 static int compare_of(struct device *dev, void *data)
 {
 	DRM_DEBUG_DRIVER("Comparing of node %s with %s\n",
@@ -270,6 +275,25 @@ static int sun4i_drv_add_endpoints(struct device *dev,
 			continue;
 		}
 
+		/*
+		 * If the node is our TCON, the first port is used for our
+		 * panel, and will not be part of the
+		 * component framework.
+		 */
+		if (sun4i_drv_node_is_tcon(node)) {
+			struct of_endpoint endpoint;
+
+			if (of_graph_parse_endpoint(ep, &endpoint)) {
+				DRM_DEBUG_DRIVER("Couldn't parse endpoint\n");
+				continue;
+			}
+
+			if (!endpoint.id) {
+				DRM_DEBUG_DRIVER("Endpoint is our panel... skipping\n");
+				continue;
+			}
+		}
+
 		/* Walk down our tree */
 		count += sun4i_drv_add_endpoints(dev, match, remote);
 
diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4i_rgb.c
new file mode 100644
index 000000000000..ab6494818050
--- /dev/null
+++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
@@ -0,0 +1,250 @@
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
+	if (hsync < 1)
+		return MODE_HSYNC_NARROW;
+
+	if (hsync > 0x3ff)
+		return MODE_HSYNC_WIDE;
+
+	if ((mode->hdisplay < 1) || (mode->htotal < 1))
+		return MODE_H_ILLEGAL;
+
+	if ((mode->hdisplay > 0x7ff) || (mode->htotal > 0xfff))
+		return MODE_BAD_HVALUE;
+
+	DRM_DEBUG_DRIVER("Horizontal parameters OK\n");
+
+	if (vsync < 1)
+		return MODE_VSYNC_NARROW;
+
+	if (vsync > 0x3ff)
+		return MODE_VSYNC_WIDE;
+
+	if ((mode->vdisplay < 1) || (mode->vtotal < 1))
+		return MODE_V_ILLEGAL;
+
+	if ((mode->vdisplay > 0x7ff) || (mode->vtotal > 0xfff))
+		return MODE_BAD_VVALUE;
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
index 5fbd3ce9d651..9f19b0e08560 100644
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
@@ -395,6 +398,40 @@ static int sun4i_tcon_init_regmap(struct device *dev,
 	return 0;
 }
 
+static struct drm_panel *sun4i_tcon_find_panel(struct device_node *node)
+{
+	struct device_node *port, *remote, *child;
+	struct device_node *end_node = NULL;
+
+	/* Inputs are listed first, then outputs */
+	port = of_graph_get_port_by_id(node, 1);
+
+	/*
+	 * Our first output is the RGB interface where the panel will
+	 * be connected.
+	 */
+	for_each_child_of_node(port, child) {
+		u32 reg;
+
+		of_property_read_u32(child, "reg", &reg);
+		if (reg == 0)
+			end_node = child;
+	}
+
+	if (!end_node) {
+		DRM_DEBUG_DRIVER("Missing panel endpoint\n");
+		return ERR_PTR(-ENODEV);
+	}
+
+	remote = of_graph_get_remote_port_parent(end_node);
+	if (!remote) {
+		DRM_DEBUG_DRIVER("Enable to parse remote node\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	return of_drm_find_panel(remote);
+}
+
 static int sun4i_tcon_bind(struct device *dev, struct device *master,
 			   void *data)
 {
@@ -447,7 +484,13 @@ static int sun4i_tcon_bind(struct device *dev, struct device *master,
 		goto err_free_clocks;
 	}
 
-	return 0;
+	tcon->panel = sun4i_tcon_find_panel(dev->of_node);
+	if (IS_ERR(tcon->panel)) {
+		dev_info(dev, "No panel found... RGB output disabled\n");
+		return 0;
+	}
+
+	return sun4i_rgb_init(drm);
 
 err_free_clocks:
 	sun4i_tcon_free_clocks(tcon);
@@ -471,6 +514,22 @@ static struct component_ops sun4i_tcon_ops = {
 
 static int sun4i_tcon_probe(struct platform_device *pdev)
 {
+	struct device_node *node = pdev->dev.of_node;
+	struct drm_panel *panel;
+
+	/*
+	 * The panel is not ready.
+	 * Defer the probe.
+	 */
+	panel = sun4i_tcon_find_panel(node);
+	if (IS_ERR(panel)) {
+		/*
+		 * If we don't have a panel endpoint, just go on
+		 */
+		if (PTR_ERR(panel) != -ENODEV)
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
2.8.1
