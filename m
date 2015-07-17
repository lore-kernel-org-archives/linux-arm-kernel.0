From: jianwei.wang@freescale.com (Jianwei Wang)
Date: Fri, 17 Jul 2015 18:38:59 +0800
Subject: [PATCH v10 1/5] drm/layerscape: Add Freescale DCU DRM driver
Message-ID: <1437129543-8037-1-git-send-email-jianwei.wang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jianwei Wang <jianwei.wang.chn@gmail.com>

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
(2) Blending of each pixel using up to 4 source layers
dependent
on size of panel.
(3) Each graphic layer can be placed with one pixel resolution
in either axis.
(4) Each graphic layer support RGB565 and RGB888 direct colors
without alpha channel and BGRA8888 BGRA4444 ARGB1555 direct
colors
with an alpha channel and YUV422 format.
(5) Each graphic layer support alpha blending with 8-bit
resolution.

This is a simplified version, only one primary plane, one
framebuffer, one crtc, one connector and one encoder for TFT
LCD panel.

Signed-off-by: Alison Wang <b18965@freescale.com>
Signed-off-by: Xiubo Li <lixiubo@cmss.chinamobile.com>
Signed-off-by: Jianwei Wang <jianwei.wang.chn@gmail.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Reviewed-by: Alison Wang <alison.wang@freescale.com>
---


Changed in V10
-adjust commit log, remove meaningless statement
-cleanup code for it's format and style.
-remove platform related code out, including of tcon(vf610) and scfg(ls1021a)
-remove useless sentences: encoder->crtc = crtc; and connector->encoder = encoder; and so on
-add vendor prefix for panel pandle
-make a DCU_CTRLDESCLN(x, y)  to avoid high repetition
-introduce per-SoC capability structure to avoid check on the OF node's compatible string
-Implement some functions: crtc enable and disable, enable and disable VBLANK, plane
 atomic_disable and atomic_enable -atomic_check and so on
-move DCU config sentence to the right place
-move get resources functions to  ->probe()
-move fsl,dcu.txt to video/ folder
-add big-endian describe
All advaced by Thierry Reding

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


 .../devicetree/bindings/video/fsl,dcu.txt          |  22 ++
 MAINTAINERS                                        |   8 +
 drivers/gpu/drm/Kconfig                            |   2 +
 drivers/gpu/drm/Makefile                           |   1 +
 drivers/gpu/drm/fsl-dcu/Kconfig                    |  18 +
 drivers/gpu/drm/fsl-dcu/Makefile                   |   7 +
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c         | 208 +++++++++++
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.h         |  19 +
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c          | 402 +++++++++++++++++++++
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h          | 197 ++++++++++
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_fbdev.c        |  23 ++
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.c          |  43 +++
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_output.h       |  33 ++
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c        | 261 +++++++++++++
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.h        |  17 +
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c          | 182 ++++++++++
 16 files changed, 1443 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/fsl,dcu.txt
 create mode 100644 drivers/gpu/drm/fsl-dcu/Kconfig
 create mode 100644 drivers/gpu/drm/fsl-dcu/Makefile
 create mode 100644 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
 create mode 100644 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.h
 create mode 100644 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
 create mode 100644 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h
 create mode 100644 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_fbdev.c
 create mode 100644 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.c
 create mode 100644 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_output.h
 create mode 100644 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c
 create mode 100644 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.h
 create mode 100644 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c

diff --git a/Documentation/devicetree/bindings/video/fsl,dcu.txt b/Documentation/devicetree/bindings/video/fsl,dcu.txt
new file mode 100644
index 0000000..ebf1be9
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/fsl,dcu.txt
@@ -0,0 +1,22 @@
+Device Tree bindings for Freescale DCU DRM Driver
+
+Required properties:
+- compatible:		Should be one of
+	* "fsl,ls1021a-dcu".
+	* "fsl,vf610-dcu".
+
+- reg:			Address and length of the register set for dcu.
+- clocks:		From common clock binding: handle to dcu clock.
+- clock-names:		From common clock binding: Shall be "dcu".
+- big-endian		Boolean property, LS1021A DCU registers are big-endian.
+- fsl,panel:		The phandle to panel node.
+
+Examples:
+dcu: dcu at 2ce0000 {
+	compatible = "fsl,ls1021a-dcu";
+	reg = <0x0 0x2ce0000 0x0 0x10000>;
+	clocks = <&platform_clk 0>;
+	clock-names = "dcu";
+	big-endian;
+	fsl,panel = <&panel>;
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index 6761318..d4dfe14 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3397,6 +3397,14 @@ F:	drivers/gpu/drm/exynos/
 F:	include/drm/exynos*
 F:	include/uapi/drm/exynos*
 
+DRM DRIVERS FOR FREESCALE DCU
+M:	Jianwei Wang <jianwei.wang.chn@gmail.com>
+M:	Alison Wang <alison.wang@freescale.com>
+L:	dri-devel at lists.freedesktop.org
+S:	Supported
+F:	drivers/gpu/drm/fsl-dcu/
+F:	Documentation/devicetree/bindings/video/fsl,dcu.txt
+
 DRM DRIVERS FOR FREESCALE IMX
 M:	Philipp Zabel <p.zabel@pengutronix.de>
 L:	dri-devel at lists.freedesktop.org
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
index 0000000..c78cf3f
--- /dev/null
+++ b/drivers/gpu/drm/fsl-dcu/Kconfig
@@ -0,0 +1,18 @@
+config DRM_FSL_DCU
+	tristate "DRM Support for Freescale DCU"
+	depends on DRM && OF && ARM
+	select BACKLIGHT_CLASS_DEVICE
+	select BACKLIGHT_LCD_SUPPORT
+	select DRM_KMS_HELPER
+	select DRM_KMS_CMA_HELPER
+	select DRM_KMS_FB_HELPER
+	select DRM_PANEL
+	select FB_SYS_FILLRECT
+	select FB_SYS_COPYAREA
+	select FB_SYS_IMAGEBLIT
+	select FB_SYS_FOPS
+	select REGMAP_MMIO
+	select VIDEOMODE_HELPERS
+	help
+	  Choose this option if you have an Freescale DCU chipset.
+	  If M is selected the module will be called fsl-dcu-drm.
diff --git a/drivers/gpu/drm/fsl-dcu/Makefile b/drivers/gpu/drm/fsl-dcu/Makefile
new file mode 100644
index 0000000..b1f9c58
--- /dev/null
+++ b/drivers/gpu/drm/fsl-dcu/Makefile
@@ -0,0 +1,7 @@
+fsl-dcu-drm-y := fsl_dcu_drm_drv.o \
+		 fsl_dcu_drm_kms.o \
+		 fsl_dcu_drm_rgb.o \
+		 fsl_dcu_drm_plane.o \
+		 fsl_dcu_drm_crtc.o \
+		 fsl_dcu_drm_fbdev.o
+obj-$(CONFIG_DRM_FSL_DCU)	+= fsl-dcu-drm.o
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
new file mode 100644
index 0000000..c7123d8
--- /dev/null
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
@@ -0,0 +1,208 @@
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
+#include <linux/regmap.h>
+
+#include <drm/drmP.h>
+#include <drm/drm_atomic.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_crtc_helper.h>
+
+#include "fsl_dcu_drm_crtc.h"
+#include "fsl_dcu_drm_drv.h"
+#include "fsl_dcu_drm_plane.h"
+
+static void fsl_dcu_drm_crtc_atomic_begin(struct drm_crtc *crtc)
+{
+}
+
+static int fsl_dcu_drm_crtc_atomic_check(struct drm_crtc *crtc,
+					 struct drm_crtc_state *state)
+{
+	return 0;
+}
+
+static void fsl_dcu_drm_crtc_atomic_flush(struct drm_crtc *crtc)
+{
+}
+
+static void fsl_dcu_drm_disable_crtc(struct drm_crtc *crtc)
+{
+	struct drm_device *dev = crtc->dev;
+	struct fsl_dcu_drm_device *fsl_dev = dev->dev_private;
+	int ret;
+
+	ret = regmap_update_bits(fsl_dev->regmap, DCU_DCU_MODE,
+				 DCU_MODE_DCU_MODE_MASK,
+				 DCU_MODE_DCU_MODE(DCU_MODE_OFF));
+	if (ret)
+		dev_err(fsl_dev->dev, "Disable CRTC failed\n");
+	ret = regmap_write(fsl_dev->regmap, DCU_UPDATE_MODE,
+			   DCU_UPDATE_MODE_READREG);
+	if (ret)
+		dev_err(fsl_dev->dev, "Enable CRTC failed\n");
+}
+
+static void fsl_dcu_drm_crtc_enable(struct drm_crtc *crtc)
+{
+	struct drm_device *dev = crtc->dev;
+	struct fsl_dcu_drm_device *fsl_dev = dev->dev_private;
+	int ret;
+
+	ret = regmap_update_bits(fsl_dev->regmap, DCU_DCU_MODE,
+				 DCU_MODE_DCU_MODE_MASK,
+				 DCU_MODE_DCU_MODE(DCU_MODE_NORMAL));
+	if (ret)
+		dev_err(fsl_dev->dev, "Enable CRTC failed\n");
+	ret = regmap_write(fsl_dev->regmap, DCU_UPDATE_MODE,
+			   DCU_UPDATE_MODE_READREG);
+	if (ret)
+		dev_err(fsl_dev->dev, "Enable CRTC failed\n");
+}
+
+static bool fsl_dcu_drm_crtc_mode_fixup(struct drm_crtc *crtc,
+					const struct drm_display_mode *mode,
+					struct drm_display_mode *adjusted_mode)
+{
+	return true;
+}
+
+static void fsl_dcu_drm_crtc_mode_set_nofb(struct drm_crtc *crtc)
+{
+	struct drm_device *dev = crtc->dev;
+	struct fsl_dcu_drm_device *fsl_dev = dev->dev_private;
+	struct drm_display_mode *mode = &crtc->state->mode;
+	uint32_t hbp, hfp, hsw, vbp, vfp, vsw, div, index;
+	unsigned long dcuclk;
+	int ret;
+
+	index = drm_crtc_index(crtc);
+	dcuclk = clk_get_rate(fsl_dev->clk);
+	div = dcuclk / mode->clock / 1000;
+
+	/* Configure timings: */
+	hbp = mode->htotal - mode->hsync_end;
+	hfp = mode->hsync_start - mode->hdisplay;
+	hsw = mode->hsync_end - mode->hsync_start;
+	vbp = mode->vtotal - mode->vsync_end;
+	vfp = mode->vsync_start - mode->vdisplay;
+	vsw = mode->vsync_end - mode->vsync_start;
+
+	ret = regmap_write(fsl_dev->regmap, DCU_HSYN_PARA,
+			   DCU_HSYN_PARA_BP(hbp) |
+			   DCU_HSYN_PARA_PW(hsw) |
+			   DCU_HSYN_PARA_FP(hfp));
+	if (ret)
+		goto set_failed;
+	ret = regmap_write(fsl_dev->regmap, DCU_VSYN_PARA,
+			   DCU_VSYN_PARA_BP(vbp) |
+			   DCU_VSYN_PARA_PW(vsw) |
+			   DCU_VSYN_PARA_FP(vfp));
+	if (ret)
+		goto set_failed;
+	ret = regmap_write(fsl_dev->regmap, DCU_DISP_SIZE,
+			   DCU_DISP_SIZE_DELTA_Y(mode->vdisplay) |
+			   DCU_DISP_SIZE_DELTA_X(mode->hdisplay));
+	if (ret)
+		goto set_failed;
+	ret = regmap_write(fsl_dev->regmap, DCU_DIV_RATIO, div);
+	if (ret)
+		goto set_failed;
+	ret = regmap_write(fsl_dev->regmap, DCU_SYN_POL,
+			   DCU_SYN_POL_INV_VS_LOW | DCU_SYN_POL_INV_HS_LOW);
+	if (ret)
+		goto set_failed;
+	ret = regmap_write(fsl_dev->regmap, DCU_BGND, DCU_BGND_R(0) |
+			   DCU_BGND_G(0) | DCU_BGND_B(0));
+	if (ret)
+		goto set_failed;
+	ret = regmap_write(fsl_dev->regmap, DCU_DCU_MODE,
+			   DCU_MODE_BLEND_ITER(1) | DCU_MODE_RASTER_EN);
+	if (ret)
+		goto set_failed;
+	ret = regmap_write(fsl_dev->regmap, DCU_THRESHOLD,
+			   DCU_THRESHOLD_LS_BF_VS(BF_VS_VAL) |
+			   DCU_THRESHOLD_OUT_BUF_HIGH(BUF_MAX_VAL) |
+			   DCU_THRESHOLD_OUT_BUF_LOW(BUF_MIN_VAL));
+	if (ret)
+		goto set_failed;
+	ret = regmap_write(fsl_dev->regmap, DCU_UPDATE_MODE,
+			   DCU_UPDATE_MODE_READREG);
+	if (ret)
+		goto set_failed;
+	return;
+set_failed:
+	dev_err(dev->dev, "set DCU register failed\n");
+}
+
+static const struct drm_crtc_helper_funcs fsl_dcu_drm_crtc_helper_funcs = {
+	.atomic_begin = fsl_dcu_drm_crtc_atomic_begin,
+	.atomic_check = fsl_dcu_drm_crtc_atomic_check,
+	.atomic_flush = fsl_dcu_drm_crtc_atomic_flush,
+	.disable = fsl_dcu_drm_disable_crtc,
+	.enable = fsl_dcu_drm_crtc_enable,
+	.mode_fixup = fsl_dcu_drm_crtc_mode_fixup,
+	.mode_set_nofb = fsl_dcu_drm_crtc_mode_set_nofb,
+};
+
+static const struct drm_crtc_funcs fsl_dcu_drm_crtc_funcs = {
+	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
+	.destroy = drm_crtc_cleanup,
+	.page_flip = drm_atomic_helper_page_flip,
+	.reset = drm_atomic_helper_crtc_reset,
+	.set_config = drm_atomic_helper_set_config,
+};
+
+int fsl_dcu_drm_crtc_create(struct fsl_dcu_drm_device *fsl_dev)
+{
+	struct drm_plane *primary;
+	struct drm_crtc *crtc = &fsl_dev->crtc;
+	unsigned int i, j, reg_num;
+	int ret;
+
+	primary = fsl_dcu_drm_primary_create_plane(fsl_dev->drm);
+	ret = drm_crtc_init_with_planes(fsl_dev->drm, crtc, primary, NULL,
+					&fsl_dcu_drm_crtc_funcs);
+	if (ret < 0)
+		return ret;
+
+	drm_crtc_helper_add(crtc, &fsl_dcu_drm_crtc_helper_funcs);
+
+	if (!strcmp(fsl_dev->soc->name, "ls1021a"))
+		reg_num = LS1021A_LAYER_REG_NUM;
+	else
+		reg_num = VF610_LAYER_REG_NUM;
+	for (i = 0; i <= fsl_dev->soc->total_layer; i++) {
+		for (j = 0; j < reg_num; j++) {
+			ret = regmap_write(fsl_dev->regmap,
+					   DCU_CTRLDESCLN(i, j), 0);
+			if (ret)
+				goto init_failed;
+		}
+	}
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
index 0000000..43d4da2
--- /dev/null
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.h
@@ -0,0 +1,19 @@
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
+struct fsl_dcu_drm_device;
+
+int fsl_dcu_drm_crtc_create(struct fsl_dcu_drm_device *fsl_dev);
+
+#endif /* __FSL_DCU_DRM_CRTC_H__ */
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
new file mode 100644
index 0000000..aa48d77
--- /dev/null
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
@@ -0,0 +1,402 @@
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
+#include <linux/clk-provider.h>
+#include <linux/io.h>
+#include <linux/mfd/syscon.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+
+#include <drm/drmP.h>
+#include <drm/drm_gem_cma_helper.h>
+
+#include "fsl_dcu_drm_crtc.h"
+#include "fsl_dcu_drm_drv.h"
+
+static const struct regmap_config fsl_dcu_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+};
+
+static int fsl_dcu_drm_irq_init(struct drm_device *dev)
+{
+	struct fsl_dcu_drm_device *fsl_dev = dev->dev_private;
+	unsigned int value;
+	int ret;
+
+	ret = drm_irq_install(dev, fsl_dev->irq);
+	if (ret < 0)
+		dev_err(dev->dev, "failed to install IRQ handler\n");
+
+	ret = regmap_write(fsl_dev->regmap, DCU_INT_STATUS, 0);
+	if (ret)
+		dev_err(dev->dev, "set DCU_INT_STATUS failed\n");
+	ret = regmap_read(fsl_dev->regmap, DCU_INT_MASK, &value);
+	if (ret)
+		dev_err(dev->dev, "read DCU_INT_MASK failed\n");
+	value &= DCU_INT_MASK_VBLANK;
+	ret = regmap_write(fsl_dev->regmap, DCU_INT_MASK, value);
+	if (ret)
+		dev_err(dev->dev, "set DCU_INT_MASK failed\n");
+	ret = regmap_write(fsl_dev->regmap, DCU_UPDATE_MODE,
+			   DCU_UPDATE_MODE_READREG);
+	if (ret)
+		dev_err(dev->dev, "set DCU_UPDATE_MODE failed\n");
+
+	return ret;
+}
+
+static int fsl_dcu_load(struct drm_device *drm, unsigned long flags)
+{
+	struct device *dev = drm->dev;
+	struct fsl_dcu_drm_device *fsl_dev = drm->dev_private;
+	int ret;
+
+	ret = fsl_dcu_drm_modeset_init(fsl_dev);
+	if (ret < 0) {
+		dev_err(dev, "failed to initialize mode setting\n");
+		return ret;
+	}
+
+	ret = drm_vblank_init(drm, drm->mode_config.num_crtc);
+	if (ret < 0) {
+		dev_err(dev, "failed to initialize vblank\n");
+		goto done;
+	}
+	drm->vblank_disable_allowed = true;
+
+	ret = fsl_dcu_drm_irq_init(drm);
+	if (ret < 0)
+		goto done;
+	drm->irq_enabled = true;
+
+	fsl_dcu_fbdev_init(drm);
+
+	return 0;
+done:
+	if (ret) {
+		drm_mode_config_cleanup(drm);
+		drm_vblank_cleanup(drm);
+		drm_irq_uninstall(drm);
+		drm->dev_private = NULL;
+	}
+
+	return ret;
+}
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
+	ret = regmap_read(fsl_dev->regmap, DCU_INT_STATUS, &int_status);
+	if (ret)
+		dev_err(dev->dev, "set DCU_INT_STATUS failed\n");
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
+	struct fsl_dcu_drm_device *fsl_dev = dev->dev_private;
+	unsigned int value;
+	int ret;
+
+	ret = regmap_read(fsl_dev->regmap, DCU_INT_MASK, &value);
+	if (ret)
+		dev_err(dev->dev, "read DCU_INT_MASK failed\n");
+	value &= ~DCU_INT_MASK_VBLANK;
+	ret = regmap_write(fsl_dev->regmap, DCU_INT_MASK, value);
+	if (ret)
+		dev_err(dev->dev, "set DCU_INT_MASK failed\n");
+	return 0;
+}
+
+static void fsl_dcu_drm_disable_vblank(struct drm_device *dev, int crtc)
+{
+	struct fsl_dcu_drm_device *fsl_dev = dev->dev_private;
+	unsigned int value;
+	int ret;
+
+	ret = regmap_read(fsl_dev->regmap, DCU_INT_MASK, &value);
+	if (ret)
+		dev_err(dev->dev, "read DCU_INT_MASK failed\n");
+	value |= DCU_INT_MASK_VBLANK;
+	ret = regmap_write(fsl_dev->regmap, DCU_INT_MASK, value);
+	if (ret)
+		dev_err(dev->dev, "set DCU_INT_MASK failed\n");
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
+static int fsl_dcu_drm_pm_suspend(struct device *dev)
+{
+	struct fsl_dcu_drm_device *fsl_dev = dev_get_drvdata(dev);
+
+	if (!fsl_dev)
+		return 0;
+
+	drm_kms_helper_poll_disable(fsl_dev->drm);
+	regcache_cache_only(fsl_dev->regmap, true);
+	regcache_mark_dirty(fsl_dev->regmap);
+	clk_disable(fsl_dev->clk);
+	clk_unprepare(fsl_dev->clk);
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
+	ret = clk_enable(fsl_dev->clk);
+	if (ret < 0) {
+		dev_err(dev, "failed to enable dcu clk\n");
+		clk_unprepare(fsl_dev->clk);
+		return ret;
+	}
+	ret = clk_prepare(fsl_dev->clk);
+	if (ret < 0) {
+		dev_err(dev, "failed to prepare dcu clk\n");
+		return ret;
+	}
+
+	drm_kms_helper_poll_enable(fsl_dev->drm);
+	regcache_cache_only(fsl_dev->regmap, false);
+	regcache_sync(fsl_dev->regmap);
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops fsl_dcu_drm_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(fsl_dcu_drm_pm_suspend, fsl_dcu_drm_pm_resume)
+};
+
+static const struct fsl_dcu_soc_data fsl_dcu_ls1021a_data = {
+	.name = "ls1021a",
+	.total_layer = 16,
+	.max_layer = 4,
+};
+
+static const struct fsl_dcu_soc_data fsl_dcu_vf610_data = {
+	.name = "vf610",
+	.total_layer = 64,
+	.max_layer = 6,
+};
+
+static const struct of_device_id fsl_dcu_of_match[] = {
+	{
+		.compatible = "fsl,ls1021a-dcu",
+		.data = &fsl_dcu_ls1021a_data,
+	}, {
+		.compatible = "fsl,vf610-dcu",
+		.data = &fsl_dcu_vf610_data,
+	}, {
+	},
+};
+MODULE_DEVICE_TABLE(of, fsl_dcu_of_match);
+
+static int fsl_dcu_drm_probe(struct platform_device *pdev)
+{
+	struct fsl_dcu_drm_device *fsl_dev;
+	struct drm_device *drm;
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	void __iomem *base;
+	struct drm_driver *driver = &fsl_dcu_drm_driver;
+	const struct of_device_id *id;
+	int ret;
+
+	fsl_dev = devm_kzalloc(dev, sizeof(*fsl_dev), GFP_KERNEL);
+	if (!fsl_dev)
+		return -ENOMEM;
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
+	fsl_dev->irq = platform_get_irq(pdev, 0);
+	if (ret < 0) {
+		dev_err(dev, "failed to get irq\n");
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
+	id = of_match_node(fsl_dcu_of_match, pdev->dev.of_node);
+	if (!id)
+		return -ENODEV;
+	fsl_dev->soc = id->data;
+
+	drm = drm_dev_alloc(driver, dev);
+	if (!drm)
+		return -ENOMEM;
+
+	fsl_dev->dev = dev;
+	fsl_dev->drm = drm;
+	fsl_dev->np = dev->of_node;
+	drm->dev_private = fsl_dev;
+	dev_set_drvdata(dev, fsl_dev);
+	drm_dev_set_unique(drm, dev_name(dev));
+
+	ret = drm_dev_register(drm, 0);
+	if (ret < 0)
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
+	return ret;
+}
+
+static int fsl_dcu_drm_remove(struct platform_device *pdev)
+{
+	struct fsl_dcu_drm_device *fsl_dev = platform_get_drvdata(pdev);
+
+	drm_put_dev(fsl_dev->drm);
+
+	return 0;
+}
+
+static struct platform_driver fsl_dcu_drm_platform_driver = {
+	.probe		= fsl_dcu_drm_probe,
+	.remove		= fsl_dcu_drm_remove,
+	.driver		= {
+		.name	= "fsl-dcu",
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
index 0000000..579b9e4
--- /dev/null
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h
@@ -0,0 +1,197 @@
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
+#include "fsl_dcu_drm_crtc.h"
+#include "fsl_dcu_drm_output.h"
+#include "fsl_dcu_drm_plane.h"
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
+#define DCU_CTRLDESCLN(layer, reg)	(0x200 + (reg - 1) * 4 + (layer) * 0x40)
+
+#define DCU_LAYER_HEIGHT(x)		((x) << 16)
+#define DCU_LAYER_WIDTH(x)		(x)
+
+#define DCU_LAYER_POSY(x)		((x) << 16)
+#define DCU_LAYER_POSX(x)		(x)
+
+#define DCU_LAYER_EN			BIT(31)
+#define DCU_LAYER_TILE_EN		BIT(30)
+#define DCU_LAYER_DATA_SEL_CLUT		BIT(29)
+#define DCU_LAYER_SAFETY_EN		BIT(28)
+#define DCU_LAYER_TRANS(x)		((x) << 20)
+#define DCU_LAYER_BPP(x)		((x) << 16)
+#define DCU_LAYER_RLE_EN		BIT(15)
+#define DCU_LAYER_LUOFFS(x)		((x) << 4)
+#define DCU_LAYER_BB_ON			BIT(2)
+#define DCU_LAYER_AB(x)			(x)
+
+#define DCU_LAYER_CKMAX_R(x)		((x) << 16)
+#define DCU_LAYER_CKMAX_G(x)		((x) << 8)
+#define DCU_LAYER_CKMAX_B(x)		(x)
+
+#define DCU_LAYER_CKMIN_R(x)		((x) << 16)
+#define DCU_LAYER_CKMIN_G(x)		((x) << 8)
+#define DCU_LAYER_CKMIN_B(x)		(x)
+
+#define DCU_LAYER_TILE_VER(x)		((x) << 16)
+#define DCU_LAYER_TILE_HOR(x)		(x)
+
+#define DCU_LAYER_FG_FCOLOR(x)		(x)
+
+#define DCU_LAYER_BG_BCOLOR(x)		(x)
+
+#define DCU_LAYER_POST_SKIP(x)		((x) << 16)
+#define DCU_LAYER_PRE_SKIP(x)		(x)
+
+#define FSL_DCU_RGB565			4
+#define FSL_DCU_RGB888			5
+#define FSL_DCU_ARGB8888		6
+#define FSL_DCU_ARGB1555		11
+#define FSL_DCU_ARGB4444		12
+#define FSL_DCU_YUV422			14
+
+#define VF610_LAYER_REG_NUM		9
+#define LS1021A_LAYER_REG_NUM		10
+
+struct clk;
+struct device;
+struct drm_device;
+
+struct fsl_dcu_soc_data {
+	const char *name;
+	/*total layer number*/
+	unsigned int total_layer;
+	/*max layer number DCU supported*/
+	unsigned int max_layer;
+};
+
+struct fsl_dcu_drm_device {
+	struct device *dev;
+	struct device_node *np;
+	struct regmap *regmap;
+	int irq;
+	struct clk *clk;
+	/*protects hardware register*/
+	spinlock_t irq_lock;
+	struct drm_device *drm;
+	struct drm_fbdev_cma *fbdev;
+	struct drm_crtc crtc;
+	struct drm_encoder encoder;
+	struct fsl_dcu_drm_connector connector;
+	const struct fsl_dcu_soc_data *soc;
+};
+
+void fsl_dcu_fbdev_init(struct drm_device *dev);
+int fsl_dcu_drm_modeset_init(struct fsl_dcu_drm_device *fsl_dev);
+
+#endif /* __FSL_DCU_DRM_DRV_H__ */
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_fbdev.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_fbdev.c
new file mode 100644
index 0000000..8b8b819
--- /dev/null
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_fbdev.c
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
index 0000000..0ef5959
--- /dev/null
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.c
@@ -0,0 +1,43 @@
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
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_fb_cma_helper.h>
+
+#include "fsl_dcu_drm_crtc.h"
+#include "fsl_dcu_drm_drv.h"
+
+static const struct drm_mode_config_funcs fsl_dcu_drm_mode_config_funcs = {
+	.atomic_check = drm_atomic_helper_check,
+	.atomic_commit = drm_atomic_helper_commit,
+	.fb_create = drm_fb_cma_create,
+};
+
+int fsl_dcu_drm_modeset_init(struct fsl_dcu_drm_device *fsl_dev)
+{
+	drm_mode_config_init(fsl_dev->drm);
+
+	fsl_dev->drm->mode_config.min_width = 0;
+	fsl_dev->drm->mode_config.min_height = 0;
+	fsl_dev->drm->mode_config.max_width = 2031;
+	fsl_dev->drm->mode_config.max_height = 2047;
+	fsl_dev->drm->mode_config.funcs = &fsl_dcu_drm_mode_config_funcs;
+
+	drm_kms_helper_poll_init(fsl_dev->drm);
+	fsl_dcu_drm_crtc_create(fsl_dev);
+	fsl_dcu_drm_encoder_create(fsl_dev, &fsl_dev->crtc);
+	fsl_dcu_drm_connector_create(fsl_dev, &fsl_dev->encoder);
+	drm_mode_config_reset(fsl_dev->drm);
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_output.h b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_output.h
new file mode 100644
index 0000000..7093109
--- /dev/null
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_output.h
@@ -0,0 +1,33 @@
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
+struct fsl_dcu_drm_connector {
+	struct drm_connector base;
+	struct drm_encoder *encoder;
+	struct drm_panel *panel;
+};
+
+static inline struct fsl_dcu_drm_connector *
+to_fsl_dcu_connector(struct drm_connector *con)
+{
+	return con ? container_of(con, struct fsl_dcu_drm_connector, base)
+		     : NULL;
+}
+
+int fsl_dcu_drm_connector_create(struct fsl_dcu_drm_device *fsl_dev,
+				 struct drm_encoder *encoder);
+int fsl_dcu_drm_encoder_create(struct fsl_dcu_drm_device *fsl_dev,
+			       struct drm_crtc *crtc);
+
+#endif /* __FSL_DCU_DRM_CONNECTOR_H__ */
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c
new file mode 100644
index 0000000..237c283
--- /dev/null
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c
@@ -0,0 +1,261 @@
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
+
+#include <drm/drmP.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_fb_cma_helper.h>
+#include <drm/drm_gem_cma_helper.h>
+#include <drm/drm_plane_helper.h>
+
+#include "fsl_dcu_drm_drv.h"
+#include "fsl_dcu_drm_plane.h"
+
+static int fsl_dcu_drm_plane_index(struct drm_plane *plane)
+{
+	struct fsl_dcu_drm_device *fsl_dev = plane->dev->dev_private;
+	unsigned int total_layer = fsl_dev->soc->total_layer;
+	unsigned int index;
+
+	index = drm_plane_index(plane);
+	if (index < total_layer)
+		return total_layer - index - 1;
+
+	dev_err(fsl_dev->dev, "No more layer left\n");
+	return -EINVAL;
+}
+
+static int fsl_dcu_drm_plane_atomic_check(struct drm_plane *plane,
+					  struct drm_plane_state *state)
+{
+	struct drm_framebuffer *fb = state->fb;
+
+	switch (fb->pixel_format) {
+	case DRM_FORMAT_RGB565:
+	case DRM_FORMAT_RGB888:
+	case DRM_FORMAT_ARGB8888:
+	case DRM_FORMAT_BGRA4444:
+	case DRM_FORMAT_ARGB1555:
+	case DRM_FORMAT_YUV422:
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static void fsl_dcu_drm_plane_atomic_disable(struct drm_plane *plane,
+					     struct drm_plane_state *old_state)
+{
+	struct fsl_dcu_drm_device *fsl_dev = plane->dev->dev_private;
+	unsigned int index, value, ret;
+
+	index = fsl_dcu_drm_plane_index(plane);
+	if (index < 0)
+		return;
+
+	ret = regmap_read(fsl_dev->regmap, DCU_CTRLDESCLN(index, 4), &value);
+	if (ret)
+		dev_err(fsl_dev->dev, "read DCU_INT_MASK failed\n");
+	value &= ~DCU_LAYER_EN;
+	ret = regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN(index, 4), value);
+	if (ret)
+		dev_err(fsl_dev->dev, "set DCU register failed\n");
+}
+
+static void fsl_dcu_drm_plane_atomic_update(struct drm_plane *plane,
+					    struct drm_plane_state *old_state)
+
+{
+	struct fsl_dcu_drm_device *fsl_dev = plane->dev->dev_private;
+	struct drm_plane_state *state = plane->state;
+	struct drm_framebuffer *fb = plane->state->fb;
+	struct drm_gem_cma_object *gem;
+	unsigned int alpha, bpp;
+	int index, ret;
+
+	if (!fb)
+		return;
+
+	index = fsl_dcu_drm_plane_index(plane);
+	if (index < 0)
+		return;
+
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
+	ret = regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN(index, 1),
+			   DCU_LAYER_HEIGHT(state->crtc_h) |
+			   DCU_LAYER_WIDTH(state->crtc_w));
+	if (ret)
+		goto set_failed;
+	ret = regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN(index, 2),
+			   DCU_LAYER_POSY(state->crtc_y) |
+			   DCU_LAYER_POSX(state->crtc_x));
+	if (ret)
+		goto set_failed;
+	ret = regmap_write(fsl_dev->regmap,
+			   DCU_CTRLDESCLN(index, 3), gem->paddr);
+	if (ret)
+		goto set_failed;
+	ret = regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN(index, 4),
+			   DCU_LAYER_EN |
+			   DCU_LAYER_TRANS(alpha) |
+			   DCU_LAYER_BPP(bpp) |
+			   DCU_LAYER_AB(0));
+	if (ret)
+		goto set_failed;
+	ret = regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN(index, 5),
+			   DCU_LAYER_CKMAX_R(0xFF) |
+			   DCU_LAYER_CKMAX_G(0xFF) |
+			   DCU_LAYER_CKMAX_B(0xFF));
+	if (ret)
+		goto set_failed;
+	ret = regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN(index, 6),
+			   DCU_LAYER_CKMIN_R(0) |
+			   DCU_LAYER_CKMIN_G(0) |
+			   DCU_LAYER_CKMIN_B(0));
+	if (ret)
+		goto set_failed;
+	ret = regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN(index, 7), 0);
+	if (ret)
+		goto set_failed;
+	ret = regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN(index, 8),
+			   DCU_LAYER_FG_FCOLOR(0));
+	if (ret)
+		goto set_failed;
+	ret = regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN(index, 9),
+			   DCU_LAYER_BG_BCOLOR(0));
+	if (ret)
+		goto set_failed;
+	if (!strcmp(fsl_dev->soc->name, "ls1021a")) {
+		ret = regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN(index, 10),
+				   DCU_LAYER_POST_SKIP(0) |
+				   DCU_LAYER_PRE_SKIP(0));
+		if (ret)
+			goto set_failed;
+	}
+	ret = regmap_update_bits(fsl_dev->regmap, DCU_DCU_MODE,
+				 DCU_MODE_DCU_MODE_MASK,
+				 DCU_MODE_DCU_MODE(DCU_MODE_NORMAL));
+	if (ret)
+		goto set_failed;
+	ret = regmap_write(fsl_dev->regmap,
+			   DCU_UPDATE_MODE, DCU_UPDATE_MODE_READREG);
+	if (ret)
+		goto set_failed;
+	return;
+
+set_failed:
+	dev_err(fsl_dev->dev, "set DCU register failed\n");
+}
+
+static void
+fsl_dcu_drm_plane_cleanup_fb(struct drm_plane *plane,
+			     struct drm_framebuffer *fb,
+			     const struct drm_plane_state *new_state)
+{
+}
+
+static int
+fsl_dcu_drm_plane_prepare_fb(struct drm_plane *plane,
+			     struct drm_framebuffer *fb,
+			     const struct drm_plane_state *new_state)
+{
+	return 0;
+}
+
+static const struct drm_plane_helper_funcs fsl_dcu_drm_plane_helper_funcs = {
+	.atomic_check = fsl_dcu_drm_plane_atomic_check,
+	.atomic_disable = fsl_dcu_drm_plane_atomic_disable,
+	.atomic_update = fsl_dcu_drm_plane_atomic_update,
+	.cleanup_fb = fsl_dcu_drm_plane_cleanup_fb,
+	.prepare_fb = fsl_dcu_drm_plane_prepare_fb,
+};
+
+static void fsl_dcu_drm_plane_destroy(struct drm_plane *plane)
+{
+	drm_plane_cleanup(plane);
+}
+
+static const struct drm_plane_funcs fsl_dcu_drm_plane_funcs = {
+	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
+	.destroy = fsl_dcu_drm_plane_destroy,
+	.disable_plane = drm_atomic_helper_disable_plane,
+	.reset = drm_atomic_helper_plane_reset,
+	.update_plane = drm_atomic_helper_update_plane,
+};
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
index 0000000..d657f08
--- /dev/null
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.h
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
+#ifndef __FSL_DCU_DRM_PLANE_H__
+#define __FSL_DCU_DRM_PLANE_H__
+
+struct drm_plane *fsl_dcu_drm_primary_create_plane(struct drm_device *dev);
+
+#endif /* __FSL_DCU_DRM_PLANE_H__ */
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c
new file mode 100644
index 0000000..fe8ab5d
--- /dev/null
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c
@@ -0,0 +1,182 @@
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
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_panel.h>
+
+#include "fsl_dcu_drm_drv.h"
+
+static int
+fsl_dcu_drm_encoder_atomic_check(struct drm_encoder *encoder,
+				 struct drm_crtc_state *crtc_state,
+				 struct drm_connector_state *conn_state)
+{
+	return 0;
+}
+
+static void fsl_dcu_drm_encoder_disable(struct drm_encoder *encoder)
+{
+}
+
+static void fsl_dcu_drm_encoder_enable(struct drm_encoder *encoder)
+{
+}
+
+static const struct drm_encoder_helper_funcs encoder_helper_funcs = {
+	.atomic_check = fsl_dcu_drm_encoder_atomic_check,
+	.disable = fsl_dcu_drm_encoder_disable,
+	.enable = fsl_dcu_drm_encoder_enable,
+};
+
+static void fsl_dcu_drm_encoder_destroy(struct drm_encoder *encoder)
+{
+	drm_encoder_cleanup(encoder);
+}
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
+	ret = drm_encoder_init(fsl_dev->drm, encoder, &encoder_funcs,
+			       DRM_MODE_ENCODER_LVDS);
+	if (ret < 0)
+		return ret;
+
+	drm_encoder_helper_add(encoder, &encoder_helper_funcs);
+
+	return 0;
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
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+	.destroy = fsl_dcu_drm_connector_destroy,
+	.detect = fsl_dcu_drm_connector_detect,
+	.dpms = drm_atomic_helper_connector_dpms,
+	.fill_modes = drm_helper_probe_single_connector_modes,
+	.reset = drm_atomic_helper_connector_reset,
+};
+
+static struct drm_encoder *
+fsl_dcu_drm_connector_best_encoder(struct drm_connector *connector)
+{
+	struct fsl_dcu_drm_connector *fsl_con = to_fsl_dcu_connector(connector);
+
+	return fsl_con->encoder;
+}
+
+static int fsl_dcu_drm_connector_get_modes(struct drm_connector *connector)
+{
+	struct fsl_dcu_drm_connector *fsl_connector;
+	int (*get_modes)(struct drm_panel *panel);
+	int num_modes = 0;
+
+	fsl_connector = to_fsl_dcu_connector(connector);
+	if (fsl_connector->panel && fsl_connector->panel->funcs &&
+	    fsl_connector->panel->funcs->get_modes) {
+		get_modes = fsl_connector->panel->funcs->get_modes;
+		num_modes = get_modes(fsl_connector->panel);
+	}
+
+	return num_modes;
+}
+
+static int fsl_dcu_drm_connector_mode_valid(struct drm_connector *connector,
+					    struct drm_display_mode *mode)
+{
+	if (mode->hdisplay & 0xf)
+		return MODE_ERROR;
+
+	return MODE_OK;
+}
+
+static const struct drm_connector_helper_funcs connector_helper_funcs = {
+	.best_encoder = fsl_dcu_drm_connector_best_encoder,
+	.get_modes = fsl_dcu_drm_connector_get_modes,
+	.mode_valid = fsl_dcu_drm_connector_mode_valid,
+};
+
+int fsl_dcu_drm_connector_create(struct fsl_dcu_drm_device *fsl_dev,
+				 struct drm_encoder *encoder)
+{
+	struct drm_connector *connector = &fsl_dev->connector.base;
+	struct drm_mode_config mode_config = fsl_dev->drm->mode_config;
+	struct device_node *panel_node;
+	int ret;
+
+	fsl_dev->connector.encoder = encoder;
+
+	ret = drm_connector_init(fsl_dev->drm, connector,
+				 &fsl_dcu_drm_connector_funcs,
+				 DRM_MODE_CONNECTOR_LVDS);
+	if (ret < 0)
+		return ret;
+
+	drm_connector_helper_add(connector, &connector_helper_funcs);
+	ret = drm_connector_register(connector);
+	if (ret < 0)
+		goto err_cleanup;
+
+	ret = drm_mode_connector_attach_encoder(connector, encoder);
+	if (ret < 0)
+		goto err_sysfs;
+
+	drm_object_property_set_value(&connector->base,
+				      mode_config.dpms_property,
+				      DRM_MODE_DPMS_OFF);
+
+	panel_node = of_parse_phandle(fsl_dev->np, "fsl,panel", 0);
+	if (panel_node) {
+		fsl_dev->connector.panel = of_drm_find_panel(panel_node);
+		if (!fsl_dev->connector.panel) {
+			ret = -EPROBE_DEFER;
+			goto err_sysfs;
+		}
+	of_node_put(panel_node);
+	}
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
-- 
2.1.0.27.g96db324
