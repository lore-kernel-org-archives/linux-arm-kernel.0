From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 14 Jan 2016 16:25:01 +0100
Subject: [PATCH v2 18/26] drm: sun4i: Add RGB output
In-Reply-To: <1452785109-6172-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1452785109-6172-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1452785109-6172-19-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One of the A10 display pipeline possible output is an RGB interface to
drive LCD panels directly. This is done through the first channel of the
TCON that will output our video signals directly.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/Makefile     |   2 +
 drivers/gpu/drm/sun4i/sun4i_rgb.c  | 229 +++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun4i_rgb.h  |  18 +++
 drivers/gpu/drm/sun4i/sun4i_tcon.c |  26 ++++-
 drivers/gpu/drm/sun4i/sun4i_tcon.h |   2 +
 5 files changed, 276 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_rgb.c
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_rgb.h

diff --git a/drivers/gpu/drm/sun4i/Makefile b/drivers/gpu/drm/sun4i/Makefile
index 7b0e83bae867..a7c9e7fd5a26 100644
--- a/drivers/gpu/drm/sun4i/Makefile
+++ b/drivers/gpu/drm/sun4i/Makefile
@@ -3,6 +3,8 @@ sun4i-drm-y += sun4i_drv.o
 sun4i-drm-y += sun4i_framebuffer.o
 sun4i-drm-y += sun4i_layer.o
 
+sun4i-drm-y += sun4i_rgb.o
+
 obj-$(CONFIG_DRM_SUN4I)		+= sun4i-drm.o
 
 obj-$(CONFIG_DRM_SUN4I)		+= sun4i_backend.o
diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4i_rgb.c
new file mode 100644
index 000000000000..c2b366e39749
--- /dev/null
+++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
@@ -0,0 +1,229 @@
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
+static bool sun4i_rgb_encoder_mode_fixup(struct drm_encoder *encoder,
+					 const struct drm_display_mode *mode,
+					 struct drm_display_mode *adjusted)
+{
+	return true;
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
+}
+
+static struct drm_encoder_helper_funcs sun4i_rgb_enc_helper_funcs = {
+	.mode_fixup	= sun4i_rgb_encoder_mode_fixup,
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
+			       DRM_MODE_ENCODER_NONE);
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
index e253818b711b..6a6dc47a3b42 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -15,6 +15,7 @@
 #include <drm/drm_crtc.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_modes.h>
+#include <drm/drm_panel.h>
 
 #include <linux/clk-provider.h>
 #include <linux/component.h>
@@ -25,6 +26,7 @@
 
 #include "sun4i_crtc.h"
 #include "sun4i_drv.h"
+#include "sun4i_rgb.h"
 #include "sun4i_tcon.h"
 
 void sun4i_tcon_disable(struct sun4i_tcon *tcon)
@@ -418,6 +420,7 @@ static int sun4i_tcon_bind(struct device *dev, struct device *master,
 	struct drm_device *drm = data;
 	struct sun4i_drv *drv = drm->dev_private;
 	struct sun4i_tcon *tcon;
+	struct device_node *np;
 	int ret;
 
 	tcon = devm_kzalloc(dev, sizeof(*tcon), GFP_KERNEL);
@@ -444,7 +447,20 @@ static int sun4i_tcon_bind(struct device *dev, struct device *master,
 		goto err_free_clocks;
 	}
 
-	return 0;
+	np = of_parse_phandle(dev->of_node, "allwinner,panel", 0);
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
@@ -466,6 +482,14 @@ static struct component_ops sun4i_tcon_ops = {
 
 static int sun4i_tcon_probe(struct platform_device *pdev)
 {
+	struct device_node *np;
+
+	np = of_parse_phandle(pdev->dev.of_node, "allwinner,panel", 0);
+	if (np) {
+		if (!of_drm_find_panel(np))
+			return -EPROBE_DEFER;
+	}
+
 	return component_add(&pdev->dev, &sun4i_tcon_ops);
 }
 
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
index 6fa093bce974..9496912b6484 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
@@ -152,6 +152,8 @@ struct sun4i_tcon {
 
 	/* Pixel clock */
 	struct clk			*dclk;
+
+	struct drm_panel		*panel;
 };
 
 /* Global Control */
-- 
2.6.4
