From: jianwei.wang@freescale.com (Jianwei Wang)
Date: Mon, 13 Jul 2015 18:51:29 +0800
Subject: [PATCH v9 1/4] drm/layerscape: Add Freescale DCU DRM driver
Message-ID: <1436784692-40560-1-git-send-email-jianwei.wang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add support for Two Dimensional Animation and Compositing
Engine (2D-ACE) on the Freescale SoCs.

2D-ACE is a Freescale display controller. 2D-ACE describes
the functionality of the module extremely well its name is a value
that cannot be used as a token in programming languages.
Instead the valid token "DCU" is used to tag the register names and
function names.

The Display Controller Unit (DCU) module is a system master that
fetches graphics stored in internal or external memory and displays
them on a TFT LCD panel. A wide range of panel sizes is supported
and the timing of the interface signals is highly configurable.
Graphics are read directly from memory and then blended in real-time,
which allows for dynamic content creation with minimal CPU
intervention.

The features:
(1) Full RGB888 output to TFT LCD panel.
(2) For the current LCD panel, WQVGA "480x272" is supported.
(3) Blending of each pixel using up to 4 source layers
dependent on size of panel.
(4) Each graphic layer can be placed with one pixel resolution
in either axis.
(5) Each graphic layer support RGB565 and RGB888 direct colors
without alpha
channel and BGRA8888 BGRA4444 ARGB1555 direct colors with an
alpha channel and YUV422 format.
(6) Each graphic layer support alpha blending with 8-bit
resolution.

This is a simplified version, only one primary plane, one
framebuffer, one crtc, one connector and one encoder for TFT
LCD panel.

Signed-off-by: Alison Wang <b18965@freescale.com>
Signed-off-by: Xiubo Li <lixiubo@cmss.chinamobile.com>
Signed-off-by: Jianwei Wang <b52261@freescale.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Reviewed-by: Alison Wang <alison.wang@freescale.com>
---


Changed in V9

-put node after calling of_drm_find_panel
-split clk_prepare_enable() to clk_prepare() and clk_enable(),
 just call clk_prepare once, and check return value
-check regmap_write/regmap_read return return value
-remove useless ".owner    = THIS_MODULE,"
All advanced by Mark Yao

Changed in V8

- Remove useless code
#define DRIVER_NAME     "fsl-dcu-drm"
MODULE_ALIAS("platform:fsl-dcu-drm");
Adviced by Paul Bolle

Changed in V7

- Remove redundant functions and replace deprecated hooker
Adviced by Daniel Vetter
- Replace drm_platform_init with drm_dev_alloc/register
Adviced by Daniel Vetter

Changed in V6

- Add NEC nl4827hc19_05b panel to panel-simple.c
Adviced by Mark Yao
- Add DRIVER_ATOMIC for driver_features
Adviced by Mark Yao
- check fsl_dev if it's NULL at PM suspend/resume
Adviced by Mark Yao

Changed in V5

- Update commit message
- Add layer registers initialization
- Remove unused functions
- Rename driver folder
Adviced by Stefan Agner
- Move pixel clock control functions to fsl_dcu_drm_drv.c
- remove redundant enable the clock implicitly using regmap
- Add maintainer message

Changed in V4:

-This version doesn't have functionality changed
Just a minor adjustment.

Changed in V3:

- Test driver on Vybrid board and add compatible string
- Remove unused functions
- set default crtc for encoder
- replace legacy functions with atomic help functions
Adviced by Daniel Vetter
- Set the unique name of the DRM device
- Implement irq handle function for vblank interrupt

Changed in v2: 
- Add atomic support
Adviced by Daniel Vetter
- Modify bindings file
- Rename node for compatibility
- Move platform related code out for compatibility
Adviced by Stefan Agner


 MAINTAINERS                                     |   9 +
 drivers/gpu/drm/Kconfig                         |   2 +
 drivers/gpu/drm/Makefile                        |   1 +
 drivers/gpu/drm/fsl-dcu/Kconfig                 |  18 +
 drivers/gpu/drm/fsl-dcu/Makefile                |   7 +
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_connector.c | 187 ++++++++++
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_connector.h |  31 ++
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c      | 212 +++++++++++
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.h      |  22 ++
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c       | 453 ++++++++++++++++++++++++
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h       | 222 ++++++++++++
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_fbdev.c     |  26 ++
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.c       |  42 +++
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.h       |  17 +
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c     | 227 ++++++++++++
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.h     |  23 ++
 16 files changed, 1499 insertions(+)
 create mode 100644 drivers/gpu/drm/fsl-dcu/Kconfig
 create mode 100644 drivers/gpu/drm/fsl-dcu/Makefile
 create mode 100644 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_connector.c
 create mode 100644 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_connector.h
 create mode 100644 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
 create mode 100644 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.h
 create mode 100644 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
 create mode 100644 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h
 create mode 100644 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_fbdev.c
 create mode 100644 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.c
 create mode 100644 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.h
 create mode 100644 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c
 create mode 100644 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 6761318..fffb8c9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3404,6 +3404,15 @@ S:	Maintained
 F:	drivers/gpu/drm/imx/
 F:	Documentation/devicetree/bindings/drm/imx/
 
+DRM DRIVERS FOR FREESCALE DCU
+M:	Jianwei Wang <jianwei.wang@freescale.com>
+M:	Alison Wang <alison.wang@freescale.com>
+L:	dri-devel at lists.freedesktop.org
+S:	Supported
+F:	drivers/gpu/drm/fsl-dcu/
+F:      Documentation/devicetree/bindings/drm/fsl-dcu/
+F:      Documentation/devicetree/bindings/panel/nec,nl4827hc19_05b.txt
+
 DRM DRIVERS FOR NVIDIA TEGRA
 M:	Thierry Reding <thierry.reding@gmail.com>
 M:	Terje Bergstr?m <tbergstrom@nvidia.com>
diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index c46ca31..9cfd14e 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -231,6 +231,8 @@ source "drivers/gpu/drm/virtio/Kconfig"
 
 source "drivers/gpu/drm/msm/Kconfig"
 
+source "drivers/gpu/drm/fsl-dcu/Kconfig"
+
 source "drivers/gpu/drm/tegra/Kconfig"
 
 source "drivers/gpu/drm/panel/Kconfig"
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 5713d05..11cb81e 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -70,3 +70,4 @@ obj-$(CONFIG_DRM_IMX) += imx/
 obj-y			+= i2c/
 obj-y			+= panel/
 obj-y			+= bridge/
+obj-$(CONFIG_DRM_FSL_DCU) += fsl-dcu/
diff --git a/drivers/gpu/drm/fsl-dcu/Kconfig b/drivers/gpu/drm/fsl-dcu/Kconfig
new file mode 100644
index 0000000..bfd484b
--- /dev/null
+++ b/drivers/gpu/drm/fsl-dcu/Kconfig
@@ -0,0 +1,18 @@
+config DRM_FSL_DCU
+	tristate "DRM Support for Freescale DCU"
+	depends on DRM && OF && ARM
+	select DRM_KMS_HELPER
+	select DRM_KMS_CMA_HELPER
+	select VIDEOMODE_HELPERS
+	select BACKLIGHT_CLASS_DEVICE
+	select BACKLIGHT_LCD_SUPPORT
+	select REGMAP_MMIO
+	select DRM_KMS_FB_HELPER
+	select FB_SYS_FILLRECT
+	select FB_SYS_COPYAREA
+	select FB_SYS_IMAGEBLIT
+	select FB_SYS_FOPS
+	select DRM_PANEL
+	help
+	  Choose this option if you have an Freescale DCU chipset.
+	  If M is selected the module will be called fsl-dcu-drm.
diff --git a/drivers/gpu/drm/fsl-dcu/Makefile b/drivers/gpu/drm/fsl-dcu/Makefile
new file mode 100644
index 0000000..336b4a6
--- /dev/null
+++ b/drivers/gpu/drm/fsl-dcu/Makefile
@@ -0,0 +1,7 @@
+fsl-dcu-drm-y := fsl_dcu_drm_drv.o \
+	       fsl_dcu_drm_kms.o \
+	       fsl_dcu_drm_connector.o \
+	       fsl_dcu_drm_plane.o \
+	       fsl_dcu_drm_crtc.o \
+	       fsl_dcu_drm_fbdev.o
+obj-$(CONFIG_DRM_FSL_DCU)	+= fsl-dcu-drm.o
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_connector.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_connector.c
new file mode 100644
index 0000000..41dd1d0
--- /dev/null
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_connector.c
@@ -0,0 +1,187 @@
+/*
+ * Copyright 2015 Freescale Semiconductor, Inc.
+ *
+ * Freescale DCU drm device driver
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/backlight.h>
+
+#include <drm/drmP.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_panel.h>
+
+#include "fsl_dcu_drm_drv.h"
+#include "fsl_dcu_drm_connector.h"
+
+static void fsl_dcu_drm_encoder_disable(struct drm_encoder *encoder)
+{
+}
+
+static int
+fsl_dcu_drm_encoder_atomic_check(struct drm_encoder *encoder,
+				 struct drm_crtc_state *crtc_state,
+				 struct drm_connector_state *conn_state)
+{
+	return 0;
+}
+
+static void fsl_dcu_drm_encoder_destroy(struct drm_encoder *encoder)
+{
+	drm_encoder_cleanup(encoder);
+}
+
+static void fsl_dcu_drm_encoder_enable(struct drm_encoder *encoder)
+{
+}
+
+static const struct drm_encoder_helper_funcs encoder_helper_funcs = {
+	.enable = fsl_dcu_drm_encoder_enable,
+	.disable = fsl_dcu_drm_encoder_disable,
+	.atomic_check = fsl_dcu_drm_encoder_atomic_check,
+};
+
+static const struct drm_encoder_funcs encoder_funcs = {
+	.destroy = fsl_dcu_drm_encoder_destroy,
+};
+
+int fsl_dcu_drm_encoder_create(struct fsl_dcu_drm_device *fsl_dev,
+			       struct drm_crtc *crtc)
+{
+	struct drm_encoder *encoder = &fsl_dev->encoder;
+	int ret;
+
+	encoder->possible_crtcs = 1;
+	ret = drm_encoder_init(fsl_dev->ddev, encoder, &encoder_funcs,
+			       DRM_MODE_ENCODER_LVDS);
+	if (ret < 0)
+		return ret;
+
+	drm_encoder_helper_add(encoder, &encoder_helper_funcs);
+	encoder->crtc = crtc;
+
+	return 0;
+}
+
+#define to_fsl_dcu_connector(connector) \
+	container_of(connector, struct fsl_dcu_drm_connector, connector)
+
+static int fsl_dcu_drm_connector_get_modes(struct drm_connector *connector)
+{
+	struct fsl_dcu_drm_connector *fsl_connector;
+	int num_modes = 0;
+
+	fsl_connector = to_fsl_dcu_connector(connector);
+	if (fsl_connector->panel && fsl_connector->panel->funcs &&
+	    fsl_connector->panel->funcs->get_modes)
+		num_modes = fsl_connector->panel->funcs->get_modes
+				(fsl_connector->panel);
+
+	return num_modes;
+}
+
+static int fsl_dcu_drm_connector_mode_valid(struct drm_connector *connector,
+					    struct drm_display_mode *mode)
+{
+	return MODE_OK;
+}
+
+static struct drm_encoder *
+fsl_dcu_drm_connector_best_encoder(struct drm_connector *connector)
+{
+	struct fsl_dcu_drm_connector *fsl_con = to_fsl_dcu_connector(connector);
+
+	return fsl_con->encoder;
+}
+
+static void fsl_dcu_drm_connector_destroy(struct drm_connector *connector)
+{
+	drm_connector_unregister(connector);
+	drm_connector_cleanup(connector);
+}
+
+static enum drm_connector_status
+fsl_dcu_drm_connector_detect(struct drm_connector *connector, bool force)
+{
+	return connector_status_connected;
+}
+
+static const struct drm_connector_funcs fsl_dcu_drm_connector_funcs = {
+	.dpms = drm_atomic_helper_connector_dpms,
+	.reset = drm_atomic_helper_connector_reset,
+	.detect = fsl_dcu_drm_connector_detect,
+	.fill_modes = drm_helper_probe_single_connector_modes,
+	.destroy = fsl_dcu_drm_connector_destroy,
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+};
+
+static const struct drm_connector_helper_funcs connector_helper_funcs = {
+	.get_modes = fsl_dcu_drm_connector_get_modes,
+	.mode_valid = fsl_dcu_drm_connector_mode_valid,
+	.best_encoder = fsl_dcu_drm_connector_best_encoder,
+};
+
+int fsl_dcu_drm_connector_create(struct fsl_dcu_drm_device *fsl_dev,
+				 struct drm_encoder *encoder)
+{
+	struct drm_connector *connector = &fsl_dev->connector.connector;
+	struct device_node *panel_node;
+	int ret;
+
+	fsl_dev->connector.encoder = encoder;
+
+	connector->display_info.width_mm = 0;
+	connector->display_info.height_mm = 0;
+
+	ret = drm_connector_init(fsl_dev->ddev, connector,
+				 &fsl_dcu_drm_connector_funcs,
+				 DRM_MODE_CONNECTOR_LVDS);
+	if (ret < 0)
+		return ret;
+
+	connector->dpms = DRM_MODE_DPMS_OFF;
+	drm_connector_helper_add(connector, &connector_helper_funcs);
+	ret = drm_connector_register(connector);
+	if (ret < 0)
+		goto err_cleanup;
+
+	ret = drm_mode_connector_attach_encoder(connector, encoder);
+	if (ret < 0)
+		goto err_sysfs;
+
+	connector->encoder = encoder;
+
+	drm_object_property_set_value
+		(&connector->base, fsl_dev->ddev->mode_config.dpms_property,
+		DRM_MODE_DPMS_OFF);
+
+	panel_node = of_parse_phandle(fsl_dev->np, "panel", 0);
+	if (panel_node) {
+		fsl_dev->connector.panel = of_drm_find_panel(panel_node);
+		if (!fsl_dev->connector.panel) {
+			of_node_put(panel_node);
+			ret = -EPROBE_DEFER;
+			goto err_sysfs;
+		}
+	}
+	of_node_put(panel_node);
+
+	ret = drm_panel_attach(fsl_dev->connector.panel, connector);
+	if (ret) {
+		dev_err(fsl_dev->dev, "failed to attach panel\n");
+		goto err_sysfs;
+	}
+
+	return 0;
+
+err_sysfs:
+	drm_connector_unregister(connector);
+err_cleanup:
+	drm_connector_cleanup(connector);
+	return ret;
+}
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_connector.h b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_connector.h
new file mode 100644
index 0000000..1c3dbb2
--- /dev/null
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_connector.h
@@ -0,0 +1,31 @@
+/*
+ * Copyright 2015 Freescale Semiconductor, Inc.
+ *
+ * Freescale DCU drm device driver
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __FSL_DCU_DRM_CONNECTOR_H__
+#define __FSL_DCU_DRM_CONNECTOR_H__
+
+#include <drm/drmP.h>
+#include <drm/drm_crtc.h>
+#include "fsl_dcu_drm_crtc.h"
+
+struct fsl_dcu_drm_device;
+struct fsl_dcu_drm_connector {
+	struct drm_connector connector;
+	struct drm_encoder *encoder;
+	struct drm_panel *panel;
+};
+
+int fsl_dcu_drm_encoder_create(struct fsl_dcu_drm_device *fsl_dev,
+			       struct drm_crtc *crtc);
+int fsl_dcu_drm_connector_create(struct fsl_dcu_drm_device *fsl_dev,
+				 struct drm_encoder *encoder);
+
+#endif /* __FSL_DCU_DRM_CONNECTOR_H__ */
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
new file mode 100644
index 0000000..df69629
--- /dev/null
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
@@ -0,0 +1,212 @@
+/*
+ * Copyright 2015 Freescale Semiconductor, Inc.
+ *
+ * Freescale DCU drm device driver
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/regmap.h>
+#include <linux/clk.h>
+
+#include <drm/drmP.h>
+#include <drm/drm_atomic.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_crtc.h>
+
+#include "fsl_dcu_drm_crtc.h"
+#include "fsl_dcu_drm_drv.h"
+#include "fsl_dcu_drm_plane.h"
+
+#define to_fsl_dcu_crtc(c)	container_of(c, struct fsl_dcu_drm_crtc, crtc)
+
+static void fsl_dcu_drm_crtc_mode_set_nofb(struct drm_crtc *crtc)
+{
+	struct drm_device *dev = crtc->dev;
+	struct fsl_dcu_drm_device *fsl_dev = dev->dev_private;
+	struct drm_display_mode *mode = &crtc->state->mode;
+	uint32_t hbp, hfp, hsw, vbp, vfp, vsw, div, index;
+	int err;
+
+	DBG(": set mode: %d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
+	    mode->base.id, mode->name,
+	    mode->vrefresh, mode->clock,
+	    mode->hdisplay, mode->hsync_start,
+	    mode->hsync_end, mode->htotal,
+	    mode->vdisplay, mode->vsync_start,
+	    mode->vsync_end, mode->vtotal,
+	    mode->type, mode->flags);
+
+	index = drm_crtc_index(crtc);
+	div = (uint32_t)clk_get_rate(fsl_dev->clk) / mode->clock / 1000;
+
+	/* Configure timings: */
+	hbp = mode->htotal - mode->hsync_end;
+	hfp = mode->hsync_start - mode->hdisplay;
+	hsw = mode->hsync_end - mode->hsync_start;
+	vbp = mode->vtotal - mode->vsync_end;
+	vfp = mode->vsync_start - mode->vdisplay;
+	vsw = mode->vsync_end - mode->vsync_start;
+
+	err = regmap_write(fsl_dev->regmap, DCU_HSYN_PARA,
+			   DCU_HSYN_PARA_BP(hbp) |
+			   DCU_HSYN_PARA_PW(hsw) |
+			   DCU_HSYN_PARA_FP(hfp));
+	if (err)
+		goto set_failed;
+	err = regmap_write(fsl_dev->regmap, DCU_VSYN_PARA,
+			   DCU_VSYN_PARA_BP(vbp) |
+			   DCU_VSYN_PARA_PW(vsw) |
+			   DCU_VSYN_PARA_FP(vfp));
+	if (err)
+		goto set_failed;
+	err = regmap_write(fsl_dev->regmap, DCU_DISP_SIZE,
+			   DCU_DISP_SIZE_DELTA_Y(mode->vdisplay) |
+			   DCU_DISP_SIZE_DELTA_X(mode->hdisplay));
+	if (err)
+		goto set_failed;
+	err = regmap_write(fsl_dev->regmap, DCU_DIV_RATIO, div);
+	if (err)
+		goto set_failed;
+	err = regmap_write(fsl_dev->regmap, DCU_UPDATE_MODE,
+			   DCU_UPDATE_MODE_READREG);
+	if (err)
+		goto set_failed;
+	return;
+set_failed:
+	dev_err(dev->dev, "set DCU register failed\n");
+}
+
+static bool fsl_dcu_drm_crtc_mode_fixup(struct drm_crtc *crtc,
+					const struct drm_display_mode *mode,
+					struct drm_display_mode *adjusted_mode)
+{
+	return true;
+}
+
+static void fsl_dcu_drm_crtc_enable(struct drm_crtc *crtc)
+{
+}
+
+static int fsl_dcu_drm_crtc_atomic_check(struct drm_crtc *crtc,
+					 struct drm_crtc_state *state)
+{
+	return 0;
+}
+
+static void fsl_dcu_drm_crtc_atomic_begin(struct drm_crtc *crtc)
+{
+}
+
+static void fsl_dcu_drm_crtc_atomic_flush(struct drm_crtc *crtc)
+{
+}
+
+static void fsl_dcu_drm_disable_crtc(struct drm_crtc *crtc)
+{
+}
+
+static const struct drm_crtc_funcs fsl_dcu_drm_crtc_funcs = {
+	.page_flip = drm_atomic_helper_page_flip,
+	.set_config = drm_atomic_helper_set_config,
+	.destroy = drm_crtc_cleanup,
+	.reset = drm_atomic_helper_crtc_reset,
+	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
+};
+
+static const struct drm_crtc_helper_funcs fsl_dcu_drm_crtc_helper_funcs = {
+	.enable = fsl_dcu_drm_crtc_enable,
+	.disable = fsl_dcu_drm_disable_crtc,
+	.mode_fixup = fsl_dcu_drm_crtc_mode_fixup,
+	.mode_set_nofb = fsl_dcu_drm_crtc_mode_set_nofb,
+	.atomic_check = fsl_dcu_drm_crtc_atomic_check,
+	.atomic_begin = fsl_dcu_drm_crtc_atomic_begin,
+	.atomic_flush = fsl_dcu_drm_crtc_atomic_flush,
+};
+
+int fsl_dcu_drm_crtc_create(struct fsl_dcu_drm_device *fsl_dev)
+{
+	struct drm_plane *primary;
+	struct drm_crtc *crtc = &fsl_dev->crtc;
+	int i, ret;
+
+	primary = fsl_dcu_drm_primary_create_plane(fsl_dev->ddev);
+	ret = drm_crtc_init_with_planes(fsl_dev->ddev, crtc, primary, NULL,
+					&fsl_dcu_drm_crtc_funcs);
+	if (ret < 0)
+		return ret;
+
+	drm_crtc_helper_add(crtc, &fsl_dcu_drm_crtc_helper_funcs);
+
+	for (i = 0; i < DCU_TOTAL_LAYER_NUM; i++) {
+		ret = regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN_1(i), 0);
+		if (ret)
+			goto init_failed;
+		ret = regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN_2(i), 0);
+		if (ret)
+			goto init_failed;
+		ret = regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN_3(i), 0);
+		if (ret)
+			goto init_failed;
+		ret = regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN_4(i), 0);
+		if (ret)
+			goto init_failed;
+		ret = regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN_5(i), 0);
+		if (ret)
+			goto init_failed;
+		ret = regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN_6(i), 0);
+		if (ret)
+			goto init_failed;
+		ret = regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN_7(i), 0);
+		if (ret)
+			goto init_failed;
+		ret = regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN_8(i), 0);
+		if (ret)
+			goto init_failed;
+		ret = regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN_9(i), 0);
+		if (ret)
+			goto init_failed;
+		if (of_device_is_compatible(fsl_dev->np, "fsl,ls1021a-dcu")) {
+			ret = regmap_write(fsl_dev->regmap,
+					   DCU_CTRLDESCLN_10(i), 0);
+			if (ret)
+				goto init_failed;
+		}
+	}
+	ret = regmap_write(fsl_dev->regmap, DCU_SYN_POL,
+			   DCU_SYN_POL_INV_VS_LOW | DCU_SYN_POL_INV_HS_LOW);
+	if (ret)
+		goto init_failed;
+	ret = regmap_write(fsl_dev->regmap, DCU_BGND, DCU_BGND_R(0) |
+			   DCU_BGND_G(0) | DCU_BGND_B(0));
+	if (ret)
+		goto init_failed;
+	ret = regmap_write(fsl_dev->regmap, DCU_DCU_MODE,
+			   DCU_MODE_BLEND_ITER(1) | DCU_MODE_RASTER_EN);
+	if (ret)
+		goto init_failed;
+	ret = regmap_write(fsl_dev->regmap, DCU_THRESHOLD,
+			   DCU_THRESHOLD_LS_BF_VS(BF_VS_VAL) |
+			   DCU_THRESHOLD_OUT_BUF_HIGH(BUF_MAX_VAL) |
+			   DCU_THRESHOLD_OUT_BUF_LOW(BUF_MIN_VAL));
+	if (ret)
+		goto init_failed;
+	ret = regmap_update_bits(fsl_dev->regmap, DCU_DCU_MODE,
+				 DCU_MODE_DCU_MODE_MASK,
+				 DCU_MODE_DCU_MODE(DCU_MODE_OFF));
+	if (ret)
+		goto init_failed;
+	ret = regmap_write(fsl_dev->regmap, DCU_UPDATE_MODE,
+			   DCU_UPDATE_MODE_READREG);
+	if (ret)
+		goto init_failed;
+
+	return 0;
+init_failed:
+	dev_err(fsl_dev->dev, "init DCU register failed\n");
+	return ret;
+}
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.h b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.h
new file mode 100644
index 0000000..193785f
--- /dev/null
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.h
@@ -0,0 +1,22 @@
+/*
+ * Copyright 2015 Freescale Semiconductor, Inc.
+ *
+ * Freescale DCU drm device driver
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __FSL_DCU_DRM_CRTC_H__
+#define __FSL_DCU_DRM_CRTC_H__
+
+#include <drm/drmP.h>
+#include <drm/drm_crtc.h>
+
+struct fsl_dcu_drm_device;
+
+int fsl_dcu_drm_crtc_create(struct fsl_dcu_drm_device *fsl_dev);
+
+#endif /* __FSL_DCU_DRM_CRTC_H__ */
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
new file mode 100644
index 0000000..6c5bb97
--- /dev/null
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
@@ -0,0 +1,453 @@
+/*
+ * Copyright 2015 Freescale Semiconductor, Inc.
+ *
+ * Freescale DCU drm device driver
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
+
+#include <drm/drmP.h>
+
+#include "fsl_dcu_drm_drv.h"
+#include "fsl_dcu_drm_crtc.h"
+#include "fsl_dcu_drm_kms.h"
+
+static int fsl_dcu_unload(struct drm_device *dev)
+{
+	drm_mode_config_cleanup(dev);
+	drm_vblank_cleanup(dev);
+	drm_irq_uninstall(dev);
+
+	dev->dev_private = NULL;
+
+	return 0;
+}
+
+static struct regmap_config fsl_dcu_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+};
+
+static int fsl_dcu_bypass_tcon(struct fsl_dcu_drm_device *fsl_dev,
+			       struct device_node *np)
+{
+	struct device_node *tcon_np;
+	struct platform_device *pdev;
+	struct clk *tcon_clk;
+	struct resource *res;
+	void __iomem *base;
+	int ret;
+
+	tcon_np = of_parse_phandle(np, "tcon-controller", 0);
+	if (!tcon_np)
+		return -EINVAL;
+
+	pdev = of_find_device_by_node(tcon_np);
+	if (!pdev)
+		return -EINVAL;
+
+	tcon_clk = devm_clk_get(&pdev->dev, "tcon");
+	if (IS_ERR(tcon_clk))
+		return PTR_ERR(tcon_clk);
+	ret = clk_prepare(tcon_clk);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to prepare tcon clk\n");
+		return ret;
+	}
+	ret = clk_enable(tcon_clk);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to enable tcon clk\n");
+		clk_unprepare(tcon_clk);
+		return ret;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	fsl_dev->tcon_regmap = devm_regmap_init_mmio(&pdev->dev,
+			base, &fsl_dcu_regmap_config);
+	if (IS_ERR(fsl_dev->tcon_regmap)) {
+		dev_err(&pdev->dev, "regmap init failed\n");
+		return PTR_ERR(fsl_dev->tcon_regmap);
+	}
+
+	ret = regmap_write(fsl_dev->tcon_regmap,
+			   TCON_CTRL1, TCON_BYPASS_ENABLE);
+	if (ret) {
+		dev_err(&pdev->dev, "set TCON_CTRL1 failed\n");
+		return ret;
+	}
+	return 0;
+}
+
+static void dcu_pixclk_enable(void)
+{
+	struct regmap *scfg_regmap;
+
+	scfg_regmap = syscon_regmap_lookup_by_compatible("fsl,ls1021a-scfg");
+	if (IS_ERR(scfg_regmap)) {
+		pr_err("No syscfg phandle specified\n");
+		return;
+	}
+
+	regmap_write(scfg_regmap, SCFG_PIXCLKCR, PXCK_ENABLE);
+}
+
+static int fsl_dcu_drm_irq_init(struct drm_device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev->dev);
+	struct fsl_dcu_drm_device *fsl_dev = dev->dev_private;
+	unsigned int int_mask;
+	int ret;
+
+	ret = drm_irq_install(dev, platform_get_irq(pdev, 0));
+	if (ret < 0)
+		dev_err(&pdev->dev, "failed to install IRQ handler\n");
+
+	dev->irq_enabled = true;
+	dev->vblank_disable_allowed = true;
+
+	ret = regmap_write(fsl_dev->regmap, DCU_INT_STATUS, 0);
+	if (ret)
+		dev_err(&pdev->dev, "set DCU_INT_STATUS failed\n");
+	ret = regmap_read(fsl_dev->regmap, DCU_INT_MASK, &int_mask);
+	if (ret)
+		dev_err(&pdev->dev, "read DCU_INT_MASK failed\n");
+	ret = regmap_write(fsl_dev->regmap, DCU_INT_MASK, int_mask &
+			   ~DCU_INT_MASK_VBLANK);
+	if (ret)
+		dev_err(&pdev->dev, "set DCU_INT_MASK failed\n");
+	ret = regmap_write(fsl_dev->regmap, DCU_UPDATE_MODE,
+			   DCU_UPDATE_MODE_READREG);
+	if (ret)
+		dev_err(&pdev->dev, "set DCU_UPDATE_MODE failed\n");
+
+	return 0;
+}
+
+static int fsl_dcu_load(struct drm_device *ddev, unsigned long flags)
+{
+	struct device *dev = ddev->dev;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct fsl_dcu_drm_device *fsl_dev;
+	struct resource *res;
+	void __iomem *base;
+	int ret;
+
+	fsl_dev = devm_kzalloc(dev, sizeof(*fsl_dev), GFP_KERNEL);
+	if (!fsl_dev)
+		return -ENOMEM;
+
+	fsl_dev->dev = dev;
+	fsl_dev->ddev = ddev;
+	fsl_dev->np = dev->of_node;
+	ddev->dev_private = fsl_dev;
+	dev_set_drvdata(dev, fsl_dev);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(dev, "could not get memory IO resource\n");
+		return -ENODEV;
+	}
+
+	base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(base)) {
+		ret = PTR_ERR(base);
+		return ret;
+	}
+
+	fsl_dev->clk = devm_clk_get(dev, "dcu");
+	if (IS_ERR(fsl_dev->clk)) {
+		ret = PTR_ERR(fsl_dev->clk);
+		dev_err(dev, "failed to get dcu clock\n");
+		return ret;
+	}
+	ret = clk_prepare(fsl_dev->clk);
+	if (ret < 0) {
+		dev_err(dev, "failed to prepare dcu clk\n");
+		return ret;
+	}
+	ret = clk_enable(fsl_dev->clk);
+	if (ret < 0) {
+		dev_err(dev, "failed to enable dcu clk\n");
+		clk_unprepare(fsl_dev->clk);
+		return ret;
+	}
+
+	fsl_dev->regmap = devm_regmap_init_mmio(dev, base,
+			&fsl_dcu_regmap_config);
+	if (IS_ERR(fsl_dev->regmap)) {
+		dev_err(dev, "regmap init failed\n");
+		return PTR_ERR(fsl_dev->regmap);
+	}
+
+	/* Put TCON in bypass mode, so the input signals from DCU are passed
+	 * through TCON unchanged */
+	fsl_dcu_bypass_tcon(fsl_dev, fsl_dev->np);
+
+	if (of_device_is_compatible(fsl_dev->np, "fsl,ls1021a-dcu"))
+		dcu_pixclk_enable();
+	ret = fsl_dcu_drm_modeset_init(fsl_dev);
+	if (ret < 0) {
+		dev_err(dev, "failed to initialize mode setting\n");
+		return ret;
+	}
+
+	ret = drm_vblank_init(ddev, ddev->mode_config.num_crtc);
+	if (ret < 0) {
+		dev_err(dev, "failed to initialize vblank\n");
+		goto done;
+	}
+
+	ret = fsl_dcu_drm_irq_init(ddev);
+	if (ret < 0)
+		goto done;
+
+	fsl_dcu_fbdev_init(ddev);
+
+	return 0;
+done:
+	if (ret)
+		fsl_dcu_unload(ddev);
+
+	return ret;
+}
+
+static void fsl_dcu_drm_preclose(struct drm_device *dev, struct drm_file *file)
+{
+}
+
+static irqreturn_t fsl_dcu_drm_irq(int irq, void *arg)
+{
+	struct drm_device *dev = arg;
+	struct fsl_dcu_drm_device *fsl_dev = dev->dev_private;
+	unsigned int int_status;
+	int ret;
+
+	regmap_read(fsl_dev->regmap, DCU_INT_STATUS, &int_status);
+	if (int_status & DCU_INT_STATUS_VBLANK)
+		drm_handle_vblank(dev, 0);
+
+	ret = regmap_write(fsl_dev->regmap, DCU_INT_STATUS, 0xffffffff);
+	if (ret)
+		dev_err(dev->dev, "set DCU_INT_STATUS failed\n");
+	ret = regmap_write(fsl_dev->regmap, DCU_UPDATE_MODE,
+			   DCU_UPDATE_MODE_READREG);
+	if (ret)
+		dev_err(dev->dev, "set DCU_UPDATE_MODE failed\n");
+
+	return IRQ_HANDLED;
+}
+
+static int fsl_dcu_drm_enable_vblank(struct drm_device *dev, int crtc)
+{
+	return 0;
+}
+
+static void fsl_dcu_drm_disable_vblank(struct drm_device *dev, int crtc)
+{
+}
+
+static const struct file_operations fsl_dcu_drm_fops = {
+	.owner		= THIS_MODULE,
+	.open		= drm_open,
+	.release	= drm_release,
+	.unlocked_ioctl	= drm_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= drm_compat_ioctl,
+#endif
+	.poll		= drm_poll,
+	.read		= drm_read,
+	.llseek		= no_llseek,
+	.mmap		= drm_gem_cma_mmap,
+};
+
+static struct drm_driver fsl_dcu_drm_driver = {
+	.driver_features	= DRIVER_HAVE_IRQ | DRIVER_GEM | DRIVER_MODESET
+				| DRIVER_PRIME | DRIVER_ATOMIC,
+	.load			= fsl_dcu_load,
+	.unload			= fsl_dcu_unload,
+	.preclose		= fsl_dcu_drm_preclose,
+	.irq_handler		= fsl_dcu_drm_irq,
+	.get_vblank_counter	= drm_vblank_count,
+	.enable_vblank		= fsl_dcu_drm_enable_vblank,
+	.disable_vblank		= fsl_dcu_drm_disable_vblank,
+	.gem_free_object	= drm_gem_cma_free_object,
+	.gem_vm_ops		= &drm_gem_cma_vm_ops,
+	.prime_handle_to_fd	= drm_gem_prime_handle_to_fd,
+	.prime_fd_to_handle	= drm_gem_prime_fd_to_handle,
+	.gem_prime_import	= drm_gem_prime_import,
+	.gem_prime_export	= drm_gem_prime_export,
+	.gem_prime_get_sg_table	= drm_gem_cma_prime_get_sg_table,
+	.gem_prime_import_sg_table = drm_gem_cma_prime_import_sg_table,
+	.gem_prime_vmap		= drm_gem_cma_prime_vmap,
+	.gem_prime_vunmap	= drm_gem_cma_prime_vunmap,
+	.gem_prime_mmap		= drm_gem_cma_prime_mmap,
+	.dumb_create		= drm_gem_cma_dumb_create,
+	.dumb_map_offset	= drm_gem_cma_dumb_map_offset,
+	.dumb_destroy		= drm_gem_dumb_destroy,
+	.fops			= &fsl_dcu_drm_fops,
+	.name			= "fsl-dcu-drm",
+	.desc			= "Freescale DCU DRM",
+	.date			= "20150213",
+	.major			= 1,
+	.minor			= 0,
+};
+
+#ifdef CONFIG_PM_SLEEP
+static void dcu_pixclk_disable(void)
+{
+	struct regmap *scfg_regmap;
+
+	scfg_regmap = syscon_regmap_lookup_by_compatible("fsl,ls1021a-scfg");
+	if (IS_ERR(scfg_regmap)) {
+		pr_err("No syscfg phandle specified\n");
+		return;
+	}
+
+	regmap_write(scfg_regmap, SCFG_PIXCLKCR, PXCK_DISABLE);
+}
+
+static int fsl_dcu_drm_pm_suspend(struct device *dev)
+{
+	struct fsl_dcu_drm_device *fsl_dev = dev_get_drvdata(dev);
+
+	if (!fsl_dev)
+		return 0;
+
+	if (of_device_is_compatible(fsl_dev->np, "fsl,ls1021a-dcu"))
+		dcu_pixclk_disable();
+
+	drm_kms_helper_poll_disable(fsl_dev->ddev);
+	regcache_cache_only(fsl_dev->regmap, true);
+	regcache_mark_dirty(fsl_dev->regmap);
+	clk_disable(fsl_dev->clk);
+
+	if (fsl_dev->tcon_regmap) {
+		regcache_cache_only(fsl_dev->tcon_regmap, true);
+		regcache_mark_dirty(fsl_dev->tcon_regmap);
+		clk_disable(fsl_dev->tcon_clk);
+	}
+
+	return 0;
+}
+
+static int fsl_dcu_drm_pm_resume(struct device *dev)
+{
+	struct fsl_dcu_drm_device *fsl_dev = dev_get_drvdata(dev);
+	int ret;
+
+	if (!fsl_dev)
+		return 0;
+
+	/* Enable clocks and restore all registers */
+	if (fsl_dev->tcon_regmap) {
+		ret = clk_enable(fsl_dev->tcon_clk);
+		if (ret < 0) {
+			dev_err(dev, "failed to enable tcon clk\n");
+			clk_unprepare(fsl_dev->tcon_clk);
+			return ret;
+		}
+		regcache_cache_only(fsl_dev->tcon_regmap, false);
+		regcache_sync(fsl_dev->tcon_regmap);
+	}
+
+	ret = clk_enable(fsl_dev->clk);
+	if (ret < 0) {
+		dev_err(dev, "failed to enable dcu clk\n");
+		clk_unprepare(fsl_dev->clk);
+		return ret;
+	}
+
+	drm_kms_helper_poll_enable(fsl_dev->ddev);
+	regcache_cache_only(fsl_dev->regmap, false);
+	regcache_sync(fsl_dev->regmap);
+
+	if (of_device_is_compatible(fsl_dev->np, "fsl,ls1021a-dcu"))
+		dcu_pixclk_enable();
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops fsl_dcu_drm_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(fsl_dcu_drm_pm_suspend, fsl_dcu_drm_pm_resume)
+};
+
+static int fsl_dcu_drm_probe(struct platform_device *pdev)
+{
+	struct drm_driver *driver = &fsl_dcu_drm_driver;
+	struct drm_device *drm;
+	int err;
+
+	drm = drm_dev_alloc(driver, &pdev->dev);
+	if (!drm)
+		return -ENOMEM;
+
+	drm_dev_set_unique(drm, dev_name(&pdev->dev));
+
+	err = drm_dev_register(drm, 0);
+	if (err < 0)
+		goto unref;
+
+	DRM_INFO("Initialized %s %d.%d.%d %s on minor %d\n", driver->name,
+		 driver->major, driver->minor, driver->patchlevel,
+		 driver->date, drm->primary->index);
+
+	return 0;
+
+unref:
+	drm_dev_unref(drm);
+	return err;
+}
+
+static int fsl_dcu_drm_remove(struct platform_device *pdev)
+{
+	struct fsl_dcu_drm_device *fsl_dev = platform_get_drvdata(pdev);
+
+	drm_put_dev(fsl_dev->ddev);
+
+	return 0;
+}
+
+static const struct of_device_id fsl_dcu_of_match[] = {
+		{ .compatible = "fsl,ls1021a-dcu", },
+		{ .compatible = "fsl,vf610-dcu", },
+		{ },
+};
+MODULE_DEVICE_TABLE(of, fsl_dcu_of_match);
+
+static struct platform_driver fsl_dcu_drm_platform_driver = {
+	.probe		= fsl_dcu_drm_probe,
+	.remove		= fsl_dcu_drm_remove,
+	.driver		= {
+		.name	= "fsl,dcu",
+		.pm	= &fsl_dcu_drm_pm_ops,
+		.of_match_table = fsl_dcu_of_match,
+	},
+};
+
+module_platform_driver(fsl_dcu_drm_platform_driver);
+
+MODULE_DESCRIPTION("Freescale DCU DRM Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h
new file mode 100644
index 0000000..336744e
--- /dev/null
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h
@@ -0,0 +1,222 @@
+/*
+ * Copyright 2015 Freescale Semiconductor, Inc.
+ *
+ * Freescale DCU drm device driver
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __FSL_DCU_DRM_DRV_H__
+#define __FSL_DCU_DRM_DRV_H__
+
+#include <linux/kernel.h>
+#include <linux/spinlock.h>
+#include <stddef.h>
+#include <drm/drm.h>
+#include <drm/drmP.h>
+#include <drm/drm_fb_helper.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_gem_cma_helper.h>
+#include <drm/drm_fb_cma_helper.h>
+
+#include "fsl_dcu_drm_crtc.h"
+#include "fsl_dcu_drm_plane.h"
+#include "fsl_dcu_drm_connector.h"
+
+#define DCU_DCU_MODE			0x0010
+#define DCU_MODE_BLEND_ITER(x)		((x) << 20)
+#define DCU_MODE_RASTER_EN		BIT(14)
+#define DCU_MODE_DCU_MODE(x)		(x)
+#define DCU_MODE_DCU_MODE_MASK		0x03
+#define DCU_MODE_OFF			0
+#define DCU_MODE_NORMAL			1
+#define DCU_MODE_TEST			2
+#define DCU_MODE_COLORBAR		3
+
+#define DCU_BGND			0x0014
+#define DCU_BGND_R(x)			((x) << 16)
+#define DCU_BGND_G(x)			((x) << 8)
+#define DCU_BGND_B(x)			(x)
+
+#define DCU_DISP_SIZE			0x0018
+#define DCU_DISP_SIZE_DELTA_Y(x)	((x) << 16)
+/*Regisiter value 1/16 of horizontal resolution*/
+#define DCU_DISP_SIZE_DELTA_X(x)	((x) >> 4)
+
+#define DCU_HSYN_PARA			0x001c
+#define DCU_HSYN_PARA_BP(x)		((x) << 22)
+#define DCU_HSYN_PARA_PW(x)		((x) << 11)
+#define DCU_HSYN_PARA_FP(x)		(x)
+
+#define DCU_VSYN_PARA			0x0020
+#define DCU_VSYN_PARA_BP(x)		((x) << 22)
+#define DCU_VSYN_PARA_PW(x)		((x) << 11)
+#define DCU_VSYN_PARA_FP(x)		(x)
+
+#define DCU_SYN_POL			0x0024
+#define DCU_SYN_POL_INV_PXCK_FALL	(0 << 6)
+#define DCU_SYN_POL_NEG_REMAIN		(0 << 5)
+#define DCU_SYN_POL_INV_VS_LOW		BIT(1)
+#define DCU_SYN_POL_INV_HS_LOW		BIT(0)
+
+#define DCU_THRESHOLD			0x0028
+#define DCU_THRESHOLD_LS_BF_VS(x)	((x) << 16)
+#define DCU_THRESHOLD_OUT_BUF_HIGH(x)	((x) << 8)
+#define DCU_THRESHOLD_OUT_BUF_LOW(x)	(x)
+#define BF_VS_VAL			0x03
+#define BUF_MAX_VAL			0x78
+#define BUF_MIN_VAL			0x0a
+
+#define DCU_INT_STATUS			0x002C
+#define DCU_INT_STATUS_VSYNC		BIT(0)
+#define DCU_INT_STATUS_UNDRUN		BIT(1)
+#define DCU_INT_STATUS_LSBFVS		BIT(2)
+#define DCU_INT_STATUS_VBLANK		BIT(3)
+#define DCU_INT_STATUS_CRCREADY		BIT(4)
+#define DCU_INT_STATUS_CRCOVERFLOW	BIT(5)
+#define DCU_INT_STATUS_P1FIFOLO		BIT(6)
+#define DCU_INT_STATUS_P1FIFOHI		BIT(7)
+#define DCU_INT_STATUS_P2FIFOLO		BIT(8)
+#define DCU_INT_STATUS_P2FIFOHI		BIT(9)
+#define DCU_INT_STATUS_PROGEND		BIT(10)
+#define DCU_INT_STATUS_IPMERROR		BIT(11)
+#define DCU_INT_STATUS_LYRTRANS		BIT(12)
+#define DCU_INT_STATUS_DMATRANS		BIT(14)
+#define DCU_INT_STATUS_P3FIFOLO		BIT(16)
+#define DCU_INT_STATUS_P3FIFOHI		BIT(17)
+#define DCU_INT_STATUS_P4FIFOLO		BIT(18)
+#define DCU_INT_STATUS_P4FIFOHI		BIT(19)
+#define DCU_INT_STATUS_P1EMPTY		BIT(26)
+#define DCU_INT_STATUS_P2EMPTY		BIT(27)
+#define DCU_INT_STATUS_P3EMPTY		BIT(28)
+#define DCU_INT_STATUS_P4EMPTY		BIT(29)
+
+#define DCU_INT_MASK			0x0030
+#define DCU_INT_MASK_VSYNC		BIT(0)
+#define DCU_INT_MASK_UNDRUN		BIT(1)
+#define DCU_INT_MASK_LSBFVS		BIT(2)
+#define DCU_INT_MASK_VBLANK		BIT(3)
+#define DCU_INT_MASK_CRCREADY		BIT(4)
+#define DCU_INT_MASK_CRCOVERFLOW	BIT(5)
+#define DCU_INT_MASK_P1FIFOLO		BIT(6)
+#define DCU_INT_MASK_P1FIFOHI		BIT(7)
+#define DCU_INT_MASK_P2FIFOLO		BIT(8)
+#define DCU_INT_MASK_P2FIFOHI		BIT(9)
+#define DCU_INT_MASK_PROGEND		BIT(10)
+#define DCU_INT_MASK_IPMERROR		BIT(11)
+#define DCU_INT_MASK_LYRTRANS		BIT(12)
+#define DCU_INT_MASK_DMATRANS		BIT(14)
+#define DCU_INT_MASK_P3FIFOLO		BIT(16)
+#define DCU_INT_MASK_P3FIFOHI		BIT(17)
+#define DCU_INT_MASK_P4FIFOLO		BIT(18)
+#define DCU_INT_MASK_P4FIFOHI		BIT(19)
+#define DCU_INT_MASK_P1EMPTY		BIT(26)
+#define DCU_INT_MASK_P2EMPTY		BIT(27)
+#define DCU_INT_MASK_P3EMPTY		BIT(28)
+#define DCU_INT_MASK_P4EMPTY		BIT(29)
+
+#define DCU_DIV_RATIO			0x0054
+
+#define DCU_UPDATE_MODE			0x00cc
+#define DCU_UPDATE_MODE_MODE		BIT(31)
+#define DCU_UPDATE_MODE_READREG		BIT(30)
+
+#define DCU_DCFB_MAX			0x300
+
+#define DCU_CTRLDESCLN_1(x)		(0x200 + (x) * 0x40)
+#define DCU_CTRLDESCLN_1_HEIGHT(x)	((x) << 16)
+#define DCU_CTRLDESCLN_1_WIDTH(x)	(x)
+
+#define DCU_CTRLDESCLN_2(x)		(0x204 + (x) * 0x40)
+#define DCU_CTRLDESCLN_2_POSY(x)	((x) << 16)
+#define DCU_CTRLDESCLN_2_POSX(x)	(x)
+
+#define DCU_CTRLDESCLN_3(x)		(0x208 + (x) * 0x40)
+
+#define DCU_CTRLDESCLN_4(x)		(0x20c + (x) * 0x40)
+#define DCU_CTRLDESCLN_4_EN		BIT(31)
+#define DCU_CTRLDESCLN_4_TILE_EN	BIT(30)
+#define DCU_CTRLDESCLN_4_DATA_SEL_CLUT	BIT(29)
+#define DCU_CTRLDESCLN_4_SAFETY_EN	BIT(28)
+#define DCU_CTRLDESCLN_4_TRANS(x)	((x) << 20)
+#define DCU_CTRLDESCLN_4_BPP(x)		((x) << 16)
+#define DCU_CTRLDESCLN_4_RLE_EN		BIT(15)
+#define DCU_CTRLDESCLN_4_LUOFFS(x)	((x) << 4)
+#define DCU_CTRLDESCLN_4_BB_ON		BIT(2)
+#define DCU_CTRLDESCLN_4_AB(x)		(x)
+
+#define DCU_CTRLDESCLN_5(x)		(0x210 + (x) * 0x40)
+#define DCU_CTRLDESCLN_5_CKMAX_R(x)	((x) << 16)
+#define DCU_CTRLDESCLN_5_CKMAX_G(x)	((x) << 8)
+#define DCU_CTRLDESCLN_5_CKMAX_B(x)	(x)
+
+#define DCU_CTRLDESCLN_6(x)		(0x214 + (x) * 0x40)
+#define DCU_CTRLDESCLN_6_CKMIN_R(x)	((x) << 16)
+#define DCU_CTRLDESCLN_6_CKMIN_G(x)	((x) << 8)
+#define DCU_CTRLDESCLN_6_CKMIN_B(x)	(x)
+
+#define DCU_CTRLDESCLN_7(x)		(0x218 + (x) * 0x40)
+#define DCU_CTRLDESCLN_7_TILE_VER(x)	((x) << 16)
+#define DCU_CTRLDESCLN_7_TILE_HOR(x)	(x)
+
+#define DCU_CTRLDESCLN_8(x)		(0x21c + (x) * 0x40)
+#define DCU_CTRLDESCLN_8_FG_FCOLOR(x)	(x)
+
+#define DCU_CTRLDESCLN_9(x)		(0x220 + (x) * 0x40)
+#define DCU_CTRLDESCLN_9_BG_BCOLOR(x)	(x)
+
+#define DCU_CTRLDESCLN_10(x)		(0x224 + (x) * 0x40)
+#define DCU_CTRLDESCLN_10_POST_SKIP(x)	((x) << 16)
+#define DCU_CTRLDESCLN_10_PRE_SKIP(x)	(x)
+
+#ifdef CONFIG_SOC_VF610
+#define DCU_TOTAL_LAYER_NUM             64
+#define DCU_LAYER_NUM_MAX               6
+#else
+#define DCU_TOTAL_LAYER_NUM             16
+#define DCU_LAYER_NUM_MAX               4
+#endif
+
+#define FSL_DCU_RGB565			4
+#define FSL_DCU_RGB888			5
+#define FSL_DCU_ARGB8888		6
+#define FSL_DCU_ARGB1555		11
+#define FSL_DCU_ARGB4444		12
+#define FSL_DCU_YUV422			14
+
+#define TCON_CTRL1			0x0000
+#define TCON_BYPASS_ENABLE		BIT(29)
+
+#define SCFG_PIXCLKCR			0x28
+#define PXCK_ENABLE			BIT(31)
+#define PXCK_DISABLE			0
+
+#define DBG(fmt, ...) DRM_DEBUG(fmt"\n", ##__VA_ARGS__)
+
+struct clk;
+struct device;
+struct drm_device;
+
+struct fsl_dcu_drm_device {
+	struct device *dev;
+	struct device_node *np;
+	struct regmap *regmap;
+	struct regmap *tcon_regmap;
+	unsigned int irq;
+	struct clk *clk;
+	struct clk *tcon_clk;
+	/*protects hardware register*/
+	spinlock_t irq_lock;
+	struct drm_device *ddev;
+	struct drm_fbdev_cma *fbdev;
+	struct drm_crtc crtc;
+	struct drm_encoder encoder;
+	struct fsl_dcu_drm_connector connector;
+};
+
+void fsl_dcu_fbdev_init(struct drm_device *dev);
+
+#endif /* __FSL_DCU_DRM_DRV_H__ */
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_fbdev.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_fbdev.c
new file mode 100644
index 0000000..f8ef0e1
--- /dev/null
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_fbdev.c
@@ -0,0 +1,26 @@
+/*
+ * Copyright 2015 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ */
+
+#include <drm/drmP.h>
+#include <drm/drm_fb_cma_helper.h>
+
+#include "fsl_dcu_drm_drv.h"
+
+/* initialize fbdev helper */
+void fsl_dcu_fbdev_init(struct drm_device *dev)
+{
+	struct fsl_dcu_drm_device *fsl_dev = dev_get_drvdata(dev->dev);
+
+	fsl_dev->fbdev = drm_fbdev_cma_init(dev, 24, 1, 1);
+}
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.c
new file mode 100644
index 0000000..0de21c69
--- /dev/null
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.c
@@ -0,0 +1,42 @@
+/*
+ * Copyright 2015 Freescale Semiconductor, Inc.
+ *
+ * Freescale DCU drm device driver
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <drm/drmP.h>
+#include <drm/drm_atomic_helper.h>
+
+#include "fsl_dcu_drm_crtc.h"
+#include "fsl_dcu_drm_connector.h"
+#include "fsl_dcu_drm_drv.h"
+
+static const struct drm_mode_config_funcs fsl_dcu_drm_mode_config_funcs = {
+	.fb_create = drm_fb_cma_create,
+	.atomic_check = drm_atomic_helper_check,
+	.atomic_commit = drm_atomic_helper_commit,
+};
+
+int fsl_dcu_drm_modeset_init(struct fsl_dcu_drm_device *fsl_dev)
+{
+	drm_mode_config_init(fsl_dev->ddev);
+
+	fsl_dev->ddev->mode_config.min_width = 0;
+	fsl_dev->ddev->mode_config.min_height = 0;
+	fsl_dev->ddev->mode_config.max_width = 2031;
+	fsl_dev->ddev->mode_config.max_height = 2047;
+	fsl_dev->ddev->mode_config.funcs = &fsl_dcu_drm_mode_config_funcs;
+
+	drm_kms_helper_poll_init(fsl_dev->ddev);
+	fsl_dcu_drm_crtc_create(fsl_dev);
+	fsl_dcu_drm_encoder_create(fsl_dev, &fsl_dev->crtc);
+	fsl_dcu_drm_connector_create(fsl_dev, &fsl_dev->encoder);
+	drm_mode_config_reset(fsl_dev->ddev);
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.h b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.h
new file mode 100644
index 0000000..b9bd299
--- /dev/null
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.h
@@ -0,0 +1,17 @@
+/*
+ * Copyright 2015 Freescale Semiconductor, Inc.
+ *
+ * Freescale DCU drm device driver
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __FSL_DCU_DRM_KMS_H__
+#define __FSL_DCU_DRM_KMS_H__
+
+int fsl_dcu_drm_modeset_init(struct fsl_dcu_drm_device *fsl_dev);
+
+#endif /* __FSL_DCU_DRM_KMS_H__ */
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c
new file mode 100644
index 0000000..fccb517
--- /dev/null
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c
@@ -0,0 +1,227 @@
+/*
+ * Copyright 2015 Freescale Semiconductor, Inc.
+ *
+ * Freescale DCU drm device driver
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <drm/drmP.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_fb_cma_helper.h>
+#include <drm/drm_gem_cma_helper.h>
+#include <linux/regmap.h>
+#include <drm/drm_plane_helper.h>
+#include <drm/drm_atomic_helper.h>
+
+#include "fsl_dcu_drm_drv.h"
+#include "fsl_dcu_drm_kms.h"
+#include "fsl_dcu_drm_plane.h"
+
+#define to_fsl_dcu_plane(plane) \
+	container_of(plane, struct fsl_dcu_drm_plane, plane)
+
+static int
+fsl_dcu_drm_plane_prepare_fb(struct drm_plane *plane,
+			     struct drm_framebuffer *fb,
+			     const struct drm_plane_state *new_state)
+{
+	return 0;
+}
+
+static void
+fsl_dcu_drm_plane_cleanup_fb(struct drm_plane *plane,
+			     struct drm_framebuffer *fb,
+			     const struct drm_plane_state *new_state)
+{
+}
+
+static int fsl_dcu_drm_plane_atomic_check(struct drm_plane *plane,
+					  struct drm_plane_state *state)
+{
+	return 0;
+}
+
+static void fsl_dcu_drm_plane_atomic_disable(struct drm_plane *plane,
+					     struct drm_plane_state *old_state)
+{
+}
+
+void fsl_dcu_drm_plane_atomic_update(struct drm_plane *plane,
+				     struct drm_plane_state *old_state)
+{
+	struct fsl_dcu_drm_device *fsl_dev = plane->dev->dev_private;
+	struct drm_plane_state *state = plane->state;
+	struct drm_framebuffer *fb = plane->state->fb;
+	struct drm_gem_cma_object *gem;
+	struct fsl_dcu_drm_plane *fsl_plane = to_fsl_dcu_plane(plane);
+	u32 index, alpha, bpp;
+	int err;
+
+	if (!fb)
+		return;
+
+	index = fsl_plane->index;
+	gem = drm_fb_cma_get_gem_obj(fb, 0);
+
+	switch (fb->pixel_format) {
+	case DRM_FORMAT_RGB565:
+		bpp = FSL_DCU_RGB565;
+		alpha = 0xff;
+		break;
+	case DRM_FORMAT_RGB888:
+		bpp = FSL_DCU_RGB888;
+		alpha = 0xff;
+		break;
+	case DRM_FORMAT_ARGB8888:
+		bpp = FSL_DCU_ARGB8888;
+		alpha = 0xff;
+		break;
+	case DRM_FORMAT_BGRA4444:
+		bpp = FSL_DCU_ARGB4444;
+		alpha = 0xff;
+		break;
+	case DRM_FORMAT_ARGB1555:
+		bpp = FSL_DCU_ARGB1555;
+		alpha = 0xff;
+		break;
+	case DRM_FORMAT_YUV422:
+		bpp = FSL_DCU_YUV422;
+		alpha = 0xff;
+		break;
+	default:
+		return;
+	}
+
+	err = regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN_1(index),
+			   DCU_CTRLDESCLN_1_HEIGHT(state->crtc_h) |
+			   DCU_CTRLDESCLN_1_WIDTH(state->crtc_w));
+	if (err)
+		goto set_failed;
+	err = regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN_2(index),
+			   DCU_CTRLDESCLN_2_POSY(state->crtc_y) |
+			   DCU_CTRLDESCLN_2_POSX(state->crtc_x));
+	if (err)
+		goto set_failed;
+	err = regmap_write(fsl_dev->regmap,
+			   DCU_CTRLDESCLN_3(index), gem->paddr);
+	if (err)
+		goto set_failed;
+	err = regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN_4(index),
+			   DCU_CTRLDESCLN_4_EN |
+			   DCU_CTRLDESCLN_4_TRANS(alpha) |
+			   DCU_CTRLDESCLN_4_BPP(bpp) |
+			   DCU_CTRLDESCLN_4_AB(0));
+	if (err)
+		goto set_failed;
+	err = regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN_5(index),
+			   DCU_CTRLDESCLN_5_CKMAX_R(0xFF) |
+			   DCU_CTRLDESCLN_5_CKMAX_G(0xFF) |
+			   DCU_CTRLDESCLN_5_CKMAX_B(0xFF));
+	if (err)
+		goto set_failed;
+	err = regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN_6(index),
+			   DCU_CTRLDESCLN_6_CKMIN_R(0) |
+			   DCU_CTRLDESCLN_6_CKMIN_G(0) |
+			   DCU_CTRLDESCLN_6_CKMIN_B(0));
+	if (err)
+		goto set_failed;
+	err = regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN_7(index), 0);
+	if (err)
+		goto set_failed;
+	err = regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN_8(index),
+			   DCU_CTRLDESCLN_8_FG_FCOLOR(0));
+	if (err)
+		goto set_failed;
+	err = regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN_9(index),
+			   DCU_CTRLDESCLN_9_BG_BCOLOR(0));
+	if (err)
+		goto set_failed;
+	if (of_device_is_compatible(fsl_dev->np, "fsl,ls1021a-dcu")) {
+		err = regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN_10(index),
+				   DCU_CTRLDESCLN_10_POST_SKIP(0) |
+				   DCU_CTRLDESCLN_10_PRE_SKIP(0));
+		if (err)
+			goto set_failed;
+	}
+	err = regmap_update_bits(fsl_dev->regmap, DCU_DCU_MODE,
+				 DCU_MODE_DCU_MODE_MASK,
+				 DCU_MODE_DCU_MODE(DCU_MODE_NORMAL));
+	if (err)
+		goto set_failed;
+	err = regmap_write(fsl_dev->regmap,
+			   DCU_UPDATE_MODE, DCU_UPDATE_MODE_READREG);
+	if (err)
+		goto set_failed;
+	return;
+
+set_failed:
+	dev_err(fsl_dev->dev, "set DCU register failed\n");
+}
+
+int fsl_dcu_drm_plane_disable(struct drm_plane *plane)
+{
+	return 0;
+}
+
+void fsl_dcu_drm_plane_destroy(struct drm_plane *plane)
+{
+	fsl_dcu_drm_plane_disable(plane);
+	drm_plane_cleanup(plane);
+}
+
+static const uint32_t fsl_dcu_drm_plane_formats[] = {
+	DRM_FORMAT_RGB565,
+	DRM_FORMAT_RGB888,
+	DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_ARGB4444,
+	DRM_FORMAT_ARGB1555,
+	DRM_FORMAT_YUV422,
+};
+
+static const struct drm_plane_funcs fsl_dcu_drm_plane_funcs = {
+	.update_plane = drm_atomic_helper_update_plane,
+	.disable_plane = drm_atomic_helper_disable_plane,
+	.destroy = fsl_dcu_drm_plane_destroy,
+	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
+	.reset = drm_atomic_helper_plane_reset,
+};
+
+static const struct drm_plane_helper_funcs fsl_dcu_drm_plane_helper_funcs = {
+	.prepare_fb = fsl_dcu_drm_plane_prepare_fb,
+	.cleanup_fb = fsl_dcu_drm_plane_cleanup_fb,
+	.atomic_check = fsl_dcu_drm_plane_atomic_check,
+	.atomic_update = fsl_dcu_drm_plane_atomic_update,
+	.atomic_disable = fsl_dcu_drm_plane_atomic_disable,
+};
+
+struct drm_plane *fsl_dcu_drm_primary_create_plane(struct drm_device *dev)
+{
+	struct drm_plane *primary;
+	int ret;
+
+	primary = kzalloc(sizeof(*primary), GFP_KERNEL);
+	if (!primary) {
+		DRM_DEBUG_KMS("Failed to allocate primary plane\n");
+		return NULL;
+	}
+
+	/* possible_crtc's will be filled in later by crtc_init */
+	ret = drm_universal_plane_init(dev, primary, 0,
+				       &fsl_dcu_drm_plane_funcs,
+				       fsl_dcu_drm_plane_formats,
+				       ARRAY_SIZE(fsl_dcu_drm_plane_formats),
+				       DRM_PLANE_TYPE_PRIMARY);
+	if (ret) {
+		kfree(primary);
+		primary = NULL;
+	}
+	drm_plane_helper_add(primary, &fsl_dcu_drm_plane_helper_funcs);
+
+	return primary;
+}
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.h b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.h
new file mode 100644
index 0000000..ccbfa61
--- /dev/null
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.h
@@ -0,0 +1,23 @@
+/*
+ * Copyright 2015 Freescale Semiconductor, Inc.
+ *
+ * Freescale DCU drm device driver
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __FSL_DCU_DRM_PLANE_H__
+#define __FSL_DCU_DRM_PLANE_H__
+
+struct fsl_dcu_drm_device;
+struct fsl_dcu_drm_plane {
+	struct drm_plane plane;
+	unsigned int index;
+};
+
+struct drm_plane *fsl_dcu_drm_primary_create_plane(struct drm_device *dev);
+
+#endif /* __FSL_DCU_DRM_PLANE_H__ */
-- 
2.1.0.27.g96db324
