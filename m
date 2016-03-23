From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 23 Mar 2016 17:38:35 +0100
Subject: [PATCH v3 12/19] drm: Add Allwinner A10 Display Engine support
In-Reply-To: <1458751122-23976-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1458751122-23976-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1458751122-23976-13-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner A10 and subsequent SoCs share the same display pipeline, with
variations in the number of controllers (1 or 2), or the presence or not of
some output (HDMI, TV, VGA) or not.

Add a driver with a limited set of features for now, and we will hopefully
support all of them eventually

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/Kconfig                   |   2 +
 drivers/gpu/drm/Makefile                  |   3 +-
 drivers/gpu/drm/sun4i/Kconfig             |  14 +
 drivers/gpu/drm/sun4i/Makefile            |  10 +
 drivers/gpu/drm/sun4i/sun4i_backend.c     | 364 ++++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun4i_backend.h     | 165 ++++++++++
 drivers/gpu/drm/sun4i/sun4i_crtc.c        | 120 ++++++++
 drivers/gpu/drm/sun4i/sun4i_crtc.h        |  30 ++
 drivers/gpu/drm/sun4i/sun4i_dotclock.c    | 160 ++++++++++
 drivers/gpu/drm/sun4i/sun4i_dotclock.h    |  21 ++
 drivers/gpu/drm/sun4i/sun4i_drv.c         | 319 +++++++++++++++++++
 drivers/gpu/drm/sun4i/sun4i_drv.h         |  30 ++
 drivers/gpu/drm/sun4i/sun4i_framebuffer.c |  54 ++++
 drivers/gpu/drm/sun4i/sun4i_framebuffer.h |  19 ++
 drivers/gpu/drm/sun4i/sun4i_layer.c       | 161 ++++++++++
 drivers/gpu/drm/sun4i/sun4i_layer.h       |  30 ++
 drivers/gpu/drm/sun4i/sun4i_tcon.c        | 492 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun4i_tcon.h        | 184 +++++++++++
 18 files changed, 2177 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/sun4i/Kconfig
 create mode 100644 drivers/gpu/drm/sun4i/Makefile
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_backend.c
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_backend.h
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_crtc.c
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_crtc.h
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_dotclock.c
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_dotclock.h
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_drv.c
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_drv.h
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_framebuffer.c
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_framebuffer.h
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_layer.c
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_layer.h
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_tcon.c
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_tcon.h

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index f2a74d0b68ae..420779064e49 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -252,6 +252,8 @@ source "drivers/gpu/drm/rcar-du/Kconfig"
 
 source "drivers/gpu/drm/shmobile/Kconfig"
 
+source "drivers/gpu/drm/sun4i/Kconfig"
+
 source "drivers/gpu/drm/omapdrm/Kconfig"
 
 source "drivers/gpu/drm/tilcdc/Kconfig"
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 6eb94fc561dc..e163fd3cd604 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -1,4 +1,4 @@
-#
+
 # Makefile for the drm device driver.  This driver provides support for the
 # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
 
@@ -65,6 +65,7 @@ obj-$(CONFIG_DRM_ATMEL_HLCDC)	+= atmel-hlcdc/
 obj-$(CONFIG_DRM_RCAR_DU) += rcar-du/
 obj-$(CONFIG_DRM_SHMOBILE) +=shmobile/
 obj-y			+= omapdrm/
+obj-$(CONFIG_DRM_SUN4I) += sun4i/
 obj-y			+= tilcdc/
 obj-$(CONFIG_DRM_QXL) += qxl/
 obj-$(CONFIG_DRM_BOCHS) += bochs/
diff --git a/drivers/gpu/drm/sun4i/Kconfig b/drivers/gpu/drm/sun4i/Kconfig
new file mode 100644
index 000000000000..99510e64e91a
--- /dev/null
+++ b/drivers/gpu/drm/sun4i/Kconfig
@@ -0,0 +1,14 @@
+config DRM_SUN4I
+	tristate "DRM Support for Allwinner A10 Display Engine"
+	depends on DRM && ARM
+	depends on ARCH_SUNXI || COMPILE_TEST
+	select DRM_GEM_CMA_HELPER
+	select DRM_KMS_HELPER
+	select DRM_KMS_CMA_HELPER
+	select DRM_PANEL
+	select REGMAP_MMIO
+	select VIDEOMODE_HELPERS
+	help
+	  Choose this option if you have an Allwinner SoC with a
+	  Display Engine. If M is selected the module will be called
+	  sun4i-drm.
diff --git a/drivers/gpu/drm/sun4i/Makefile b/drivers/gpu/drm/sun4i/Makefile
new file mode 100644
index 000000000000..6df3ef32732d
--- /dev/null
+++ b/drivers/gpu/drm/sun4i/Makefile
@@ -0,0 +1,10 @@
+sun4i-drm-y += sun4i_crtc.o
+sun4i-drm-y += sun4i_drv.o
+sun4i-drm-y += sun4i_framebuffer.o
+sun4i-drm-y += sun4i_layer.o
+
+sun4i-tcon-y += sun4i_tcon.o
+sun4i-tcon-y += sun4i_dotclock.o
+
+obj-$(CONFIG_DRM_SUN4I)		+= sun4i-drm.o sun4i-tcon.o
+obj-$(CONFIG_DRM_SUN4I)		+= sun4i_backend.o
diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
new file mode 100644
index 000000000000..f7a15c1a93bf
--- /dev/null
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -0,0 +1,364 @@
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
+
+#include "sun4i_backend.h"
+#include "sun4i_drv.h"
+
+static u32 sunxi_rgb2yuv_coef[12] = {
+	0x00000107, 0x00000204, 0x00000064, 0x00000108,
+	0x00003f69, 0x00003ed6, 0x000001c1, 0x00000808,
+	0x000001c1, 0x00003e88, 0x00003fb8, 0x00000808
+};
+
+void sun4i_backend_apply_color_correction(struct sun4i_backend *backend)
+{
+	int i;
+
+	DRM_DEBUG_DRIVER("Applying RGB to YUV color correction\n");
+
+	/* Set color correction */
+	regmap_write(backend->regs, SUN4I_BACKEND_OCCTL_REG,
+		     SUN4I_BACKEND_OCCTL_ENABLE);
+
+	for (i = 0; i < 12; i++)
+		regmap_write(backend->regs, SUN4I_BACKEND_OCRCOEF_REG(i),
+			     sunxi_rgb2yuv_coef[i]);
+}
+EXPORT_SYMBOL(sun4i_backend_apply_color_correction);
+
+void sun4i_backend_disable_color_correction(struct sun4i_backend *backend)
+{
+	DRM_DEBUG_DRIVER("Disabling color correction\n");
+
+	/* Disable color correction */
+	regmap_update_bits(backend->regs, SUN4I_BACKEND_OCCTL_REG,
+			   SUN4I_BACKEND_OCCTL_ENABLE, 0);
+}
+EXPORT_SYMBOL(sun4i_backend_disable_color_correction);
+
+void sun4i_backend_commit(struct sun4i_backend *backend)
+{
+	DRM_DEBUG_DRIVER("Committing changes\n");
+
+	regmap_write(backend->regs, SUN4I_BACKEND_REGBUFFCTL_REG,
+		     SUN4I_BACKEND_REGBUFFCTL_AUTOLOAD_DIS |
+		     SUN4I_BACKEND_REGBUFFCTL_LOADCTL);
+}
+EXPORT_SYMBOL(sun4i_backend_commit);
+
+void sun4i_backend_layer_enable(struct sun4i_backend *backend,
+				int layer, bool enable)
+{
+	u32 val;
+
+	DRM_DEBUG_DRIVER("Enabling layer %d\n", layer);
+
+	if (enable)
+		val = SUN4I_BACKEND_MODCTL_LAY_EN(layer);
+	else
+		val = 0;
+
+	regmap_update_bits(backend->regs, SUN4I_BACKEND_MODCTL_REG,
+			   SUN4I_BACKEND_MODCTL_LAY_EN(layer), val);
+}
+EXPORT_SYMBOL(sun4i_backend_layer_enable);
+
+static int sun4i_backend_drm_format_to_layer(u32 format, u32 *mode)
+{
+	switch (format) {
+	case DRM_FORMAT_ARGB8888:
+		*mode = SUN4I_BACKEND_LAY_FBFMT_ARGB8888;
+		break;
+
+	case DRM_FORMAT_XRGB8888:
+		*mode = SUN4I_BACKEND_LAY_FBFMT_XRGB8888;
+		break;
+
+	case DRM_FORMAT_RGB888:
+		*mode = SUN4I_BACKEND_LAY_FBFMT_RGB888;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int sun4i_backend_update_layer_coord(struct sun4i_backend *backend,
+				     int layer, struct drm_plane *plane)
+{
+	struct drm_plane_state *state = plane->state;
+	struct drm_framebuffer *fb = state->fb;
+
+	DRM_DEBUG_DRIVER("Updating layer %d\n", layer);
+
+	if (plane->type == DRM_PLANE_TYPE_PRIMARY) {
+		DRM_DEBUG_DRIVER("Primary layer, updating global size W: %u H: %u\n",
+				 state->crtc_w, state->crtc_h);
+		regmap_write(backend->regs, SUN4I_BACKEND_DISSIZE_REG,
+			     SUN4I_BACKEND_DISSIZE(state->crtc_w,
+						   state->crtc_h));
+	}
+
+	/* Set the line width */
+	DRM_DEBUG_DRIVER("Layer line width: %d bits\n", fb->pitches[0] * 8);
+	regmap_write(backend->regs, SUN4I_BACKEND_LAYLINEWIDTH_REG(layer),
+		     fb->pitches[0] * 8);
+
+	/* Set height and width */
+	DRM_DEBUG_DRIVER("Layer size W: %u H: %u\n",
+			 state->crtc_w, state->crtc_h);
+	regmap_write(backend->regs, SUN4I_BACKEND_LAYSIZE_REG(layer),
+		     SUN4I_BACKEND_LAYSIZE(state->crtc_w,
+					   state->crtc_h));
+
+	/* Set base coordinates */
+	DRM_DEBUG_DRIVER("Layer coordinates X: %d Y: %d\n",
+			 state->crtc_x, state->crtc_y);
+	regmap_write(backend->regs, SUN4I_BACKEND_LAYCOOR_REG(layer),
+		     SUN4I_BACKEND_LAYCOOR(state->crtc_x,
+					   state->crtc_y));
+
+	return 0;
+}
+EXPORT_SYMBOL(sun4i_backend_update_layer_coord);
+
+int sun4i_backend_update_layer_formats(struct sun4i_backend *backend,
+				       int layer, struct drm_plane *plane)
+{
+	struct drm_plane_state *state = plane->state;
+	struct drm_framebuffer *fb = state->fb;
+	bool interlaced = false;
+	u32 val;
+	int ret;
+
+	if (plane->state->crtc)
+		interlaced = plane->state->crtc->state->adjusted_mode.flags
+			& DRM_MODE_FLAG_INTERLACE;
+
+	regmap_update_bits(backend->regs, SUN4I_BACKEND_MODCTL_REG,
+			   SUN4I_BACKEND_MODCTL_ITLMOD_EN,
+			   interlaced ? SUN4I_BACKEND_MODCTL_ITLMOD_EN : 0);
+
+	DRM_DEBUG_DRIVER("Switching display backend interlaced mode %s\n",
+			 interlaced ? "on" : "off");
+
+	ret = sun4i_backend_drm_format_to_layer(fb->pixel_format, &val);
+	if (ret) {
+		DRM_DEBUG_DRIVER("Invalid format\n");
+		return val;
+	}
+
+	regmap_update_bits(backend->regs, SUN4I_BACKEND_ATTCTL_REG1(layer),
+			   SUN4I_BACKEND_ATTCTL_REG1_LAY_FBFMT, val);
+
+	return 0;
+}
+EXPORT_SYMBOL(sun4i_backend_update_layer_formats);
+
+int sun4i_backend_update_layer_buffer(struct sun4i_backend *backend,
+				      int layer, struct drm_plane *plane)
+{
+	struct drm_plane_state *state = plane->state;
+	struct drm_framebuffer *fb = state->fb;
+	struct drm_gem_cma_object *gem;
+	u32 lo_paddr, hi_paddr;
+	dma_addr_t paddr;
+	int bpp;
+
+	/* Get the physical address of the buffer in memory */
+	gem = drm_fb_cma_get_gem_obj(fb, 0);
+
+	DRM_DEBUG_DRIVER("Using GEM @ 0x%x\n", gem->paddr);
+
+	/* Compute the start of the displayed memory */
+	bpp = drm_format_plane_cpp(fb->pixel_format, 0);
+	paddr = gem->paddr + fb->offsets[0];
+	paddr += (state->src_x >> 16) * bpp;
+	paddr += (state->src_y >> 16) * fb->pitches[0];
+
+	DRM_DEBUG_DRIVER("Setting buffer address to 0x%x\n", paddr);
+
+	/* Write the 32 lower bits of the address (in bits) */
+	lo_paddr = paddr << 3;
+	DRM_DEBUG_DRIVER("Setting address lower bits to 0x%x\n", lo_paddr);
+	regmap_write(backend->regs, SUN4I_BACKEND_LAYFB_L32ADD_REG(layer),
+		     lo_paddr);
+
+	/* And the upper bits */
+	hi_paddr = paddr >> 29;
+	DRM_DEBUG_DRIVER("Setting address high bits to 0x%x\n", hi_paddr);
+	regmap_update_bits(backend->regs, SUN4I_BACKEND_LAYFB_H4ADD_REG,
+			   SUN4I_BACKEND_LAYFB_H4ADD_MSK(layer),
+			   SUN4I_BACKEND_LAYFB_H4ADD(layer, hi_paddr));
+
+	return 0;
+}
+EXPORT_SYMBOL(sun4i_backend_update_layer_buffer);
+
+static struct regmap_config sun4i_backend_regmap_config = {
+	.reg_bits	= 32,
+	.val_bits	= 32,
+	.reg_stride	= 4,
+	.max_register	= 0x5800,
+};
+
+static int sun4i_backend_bind(struct device *dev, struct device *master,
+			      void *data)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct drm_device *drm = data;
+	struct sun4i_drv *drv = drm->dev_private;
+	struct sun4i_backend *backend;
+	struct resource *res;
+	void __iomem *regs;
+	int i, ret;
+
+	backend = devm_kzalloc(dev, sizeof(*backend), GFP_KERNEL);
+	if (!backend)
+		return -ENOMEM;
+	dev_set_drvdata(dev, backend);
+	drv->backend = backend;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	regs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(regs)) {
+		dev_err(dev, "Couldn't map the backend registers\n");
+		return PTR_ERR(regs);
+	}
+
+	backend->regs = devm_regmap_init_mmio(dev, regs,
+					      &sun4i_backend_regmap_config);
+	if (IS_ERR(backend->regs)) {
+		dev_err(dev, "Couldn't create the backend0 regmap\n");
+		return PTR_ERR(backend->regs);
+	}
+
+	backend->reset = devm_reset_control_get(dev, NULL);
+	if (IS_ERR(backend->reset)) {
+		dev_err(dev, "Couldn't get our reset line\n");
+		return PTR_ERR(backend->reset);
+	}
+
+	ret = reset_control_deassert(backend->reset);
+	if (ret) {
+		dev_err(dev, "Couldn't deassert our reset line\n");
+		return ret;
+	}
+
+	backend->bus_clk = devm_clk_get(dev, "ahb");
+	if (IS_ERR(backend->bus_clk)) {
+		dev_err(dev, "Couldn't get the backend bus clock\n");
+		ret = PTR_ERR(backend->bus_clk);
+		goto err_assert_reset;
+	}
+	clk_prepare_enable(backend->bus_clk);
+
+	backend->mod_clk = devm_clk_get(dev, "mod");
+	if (IS_ERR(backend->mod_clk)) {
+		dev_err(dev, "Couldn't get the backend module clock\n");
+		ret = PTR_ERR(backend->mod_clk);
+		goto err_disable_bus_clk;
+	}
+	clk_prepare_enable(backend->mod_clk);
+
+	backend->ram_clk = devm_clk_get(dev, "ram");
+	if (IS_ERR(backend->ram_clk)) {
+		dev_err(dev, "Couldn't get the backend RAM clock\n");
+		ret = PTR_ERR(backend->ram_clk);
+		goto err_disable_mod_clk;
+	}
+	clk_prepare_enable(backend->ram_clk);
+
+	/* Reset the registers */
+	for (i = 0x800; i < 0x1000; i += 4)
+		regmap_write(backend->regs, i, 0);
+
+	/* Disable registers autoloading */
+	regmap_write(backend->regs, SUN4I_BACKEND_REGBUFFCTL_REG,
+		     SUN4I_BACKEND_REGBUFFCTL_AUTOLOAD_DIS);
+
+	/* Enable the backend */
+	regmap_write(backend->regs, SUN4I_BACKEND_MODCTL_REG,
+		     SUN4I_BACKEND_MODCTL_DEBE_EN |
+		     SUN4I_BACKEND_MODCTL_START_CTL);
+
+	return 0;
+
+err_disable_mod_clk:
+	clk_disable_unprepare(backend->mod_clk);
+err_disable_bus_clk:
+	clk_disable_unprepare(backend->bus_clk);
+err_assert_reset:
+	reset_control_assert(backend->reset);
+	return ret;
+}
+
+static void sun4i_backend_unbind(struct device *dev, struct device *master,
+				 void *data)
+{
+	struct sun4i_backend *backend = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(backend->ram_clk);
+	clk_disable_unprepare(backend->mod_clk);
+	clk_disable_unprepare(backend->bus_clk);
+	reset_control_assert(backend->reset);
+}
+
+static struct component_ops sun4i_backend_ops = {
+	.bind	= sun4i_backend_bind,
+	.unbind	= sun4i_backend_unbind,
+};
+
+static int sun4i_backend_probe(struct platform_device *pdev)
+{
+	return component_add(&pdev->dev, &sun4i_backend_ops);
+}
+
+static int sun4i_backend_remove(struct platform_device *pdev)
+{
+	component_del(&pdev->dev, &sun4i_backend_ops);
+
+	return 0;
+}
+
+static const struct of_device_id sun4i_backend_of_table[] = {
+	{ .compatible = "allwinner,sun5i-a13-display-backend" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sun4i_backend_of_table);
+
+static struct platform_driver sun4i_backend_platform_driver = {
+	.probe		= sun4i_backend_probe,
+	.remove		= sun4i_backend_remove,
+	.driver		= {
+		.name		= "sun4i-backend",
+		.of_match_table	= sun4i_backend_of_table,
+	},
+};
+module_platform_driver(sun4i_backend_platform_driver);
+
+MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com>");
+MODULE_DESCRIPTION("Allwinner A10 Display Backend Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.h b/drivers/gpu/drm/sun4i/sun4i_backend.h
new file mode 100644
index 000000000000..7070bb3434e5
--- /dev/null
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.h
@@ -0,0 +1,165 @@
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
+#ifndef _SUN4I_BACKEND_H_
+#define _SUN4I_BACKEND_H_
+
+#include <linux/clk.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+
+#define SUN4I_BACKEND_MODCTL_REG		0x800
+#define SUN4I_BACKEND_MODCTL_LINE_SEL			BIT(29)
+#define SUN4I_BACKEND_MODCTL_ITLMOD_EN			BIT(28)
+#define SUN4I_BACKEND_MODCTL_OUT_SEL			GENMASK(22, 20)
+#define SUN4I_BACKEND_MODCTL_OUT_LCD				(0 << 20)
+#define SUN4I_BACKEND_MODCTL_OUT_FE0				(6 << 20)
+#define SUN4I_BACKEND_MODCTL_OUT_FE1				(7 << 20)
+#define SUN4I_BACKEND_MODCTL_HWC_EN			BIT(16)
+#define SUN4I_BACKEND_MODCTL_LAY_EN(l)			BIT(8 + l)
+#define SUN4I_BACKEND_MODCTL_OCSC_EN			BIT(5)
+#define SUN4I_BACKEND_MODCTL_DFLK_EN			BIT(4)
+#define SUN4I_BACKEND_MODCTL_DLP_START_CTL		BIT(2)
+#define SUN4I_BACKEND_MODCTL_START_CTL			BIT(1)
+#define SUN4I_BACKEND_MODCTL_DEBE_EN			BIT(0)
+
+#define SUN4I_BACKEND_BACKCOLOR_REG		0x804
+#define SUN4I_BACKEND_BACKCOLOR(r, g, b)		(((r) << 16) | ((g) << 8) | (b))
+
+#define SUN4I_BACKEND_DISSIZE_REG		0x808
+#define SUN4I_BACKEND_DISSIZE(w, h)			(((((h) - 1) & 0xffff) << 16) | \
+							 (((w) - 1) & 0xffff))
+
+#define SUN4I_BACKEND_LAYSIZE_REG(l)		(0x810 + (0x4 * (l)))
+#define SUN4I_BACKEND_LAYSIZE(w, h)			(((((h) - 1) & 0x1fff) << 16) | \
+							 (((w) - 1) & 0x1fff))
+
+#define SUN4I_BACKEND_LAYCOOR_REG(l)		(0x820 + (0x4 * (l)))
+#define SUN4I_BACKEND_LAYCOOR(x, y)			((((u32)(y) & 0xffff) << 16) | \
+							 ((u32)(x) & 0xffff))
+
+#define SUN4I_BACKEND_LAYLINEWIDTH_REG(l)	(0x840 + (0x4 * (l)))
+
+#define SUN4I_BACKEND_LAYFB_L32ADD_REG(l)	(0x850 + (0x4 * (l)))
+
+#define SUN4I_BACKEND_LAYFB_H4ADD_REG		0x860
+#define SUN4I_BACKEND_LAYFB_H4ADD_MSK(l)		GENMASK(3 + ((l) * 8), 0)
+#define SUN4I_BACKEND_LAYFB_H4ADD(l, val)			((val) << ((l) * 8))
+
+#define SUN4I_BACKEND_REGBUFFCTL_REG		0x870
+#define SUN4I_BACKEND_REGBUFFCTL_AUTOLOAD_DIS		BIT(1)
+#define SUN4I_BACKEND_REGBUFFCTL_LOADCTL		BIT(0)
+
+#define SUN4I_BACKEND_CKMAX_REG			0x880
+#define SUN4I_BACKEND_CKMIN_REG			0x884
+#define SUN4I_BACKEND_CKCFG_REG			0x888
+#define SUN4I_BACKEND_ATTCTL_REG0(l)		(0x890 + (0x4 * (l)))
+#define SUN4I_BACKEND_ATTCTL_REG0_LAY_PIPESEL_MASK	BIT(15)
+#define SUN4I_BACKEND_ATTCTL_REG0_LAY_PIPESEL(x)		((x) << 15)
+#define SUN4I_BACKEND_ATTCTL_REG0_LAY_PRISEL_MASK	GENMASK(11, 10)
+#define SUN4I_BACKEND_ATTCTL_REG0_LAY_PRISEL(x)			((x) << 10)
+
+#define SUN4I_BACKEND_ATTCTL_REG1(l)		(0x8a0 + (0x4 * (l)))
+#define SUN4I_BACKEND_ATTCTL_REG1_LAY_HSCAFCT		GENMASK(15, 14)
+#define SUN4I_BACKEND_ATTCTL_REG1_LAY_WSCAFCT		GENMASK(13, 12)
+#define SUN4I_BACKEND_ATTCTL_REG1_LAY_FBFMT		GENMASK(11, 8)
+#define SUN4I_BACKEND_LAY_FBFMT_1BPP				(0 << 8)
+#define SUN4I_BACKEND_LAY_FBFMT_2BPP				(1 << 8)
+#define SUN4I_BACKEND_LAY_FBFMT_4BPP				(2 << 8)
+#define SUN4I_BACKEND_LAY_FBFMT_8BPP				(3 << 8)
+#define SUN4I_BACKEND_LAY_FBFMT_RGB655				(4 << 8)
+#define SUN4I_BACKEND_LAY_FBFMT_RGB565				(5 << 8)
+#define SUN4I_BACKEND_LAY_FBFMT_RGB556				(6 << 8)
+#define SUN4I_BACKEND_LAY_FBFMT_ARGB1555			(7 << 8)
+#define SUN4I_BACKEND_LAY_FBFMT_RGBA5551			(8 << 8)
+#define SUN4I_BACKEND_LAY_FBFMT_XRGB8888			(9 << 8)
+#define SUN4I_BACKEND_LAY_FBFMT_ARGB8888			(10 << 8)
+#define SUN4I_BACKEND_LAY_FBFMT_RGB888				(11 << 8)
+#define SUN4I_BACKEND_LAY_FBFMT_ARGB4444			(12 << 8)
+#define SUN4I_BACKEND_LAY_FBFMT_RGBA4444			(13 << 8)
+
+#define SUN4I_BACKEND_DLCDPCTL_REG		0x8b0
+#define SUN4I_BACKEND_DLCDPFRMBUF_ADDRCTL_REG	0x8b4
+#define SUN4I_BACKEND_DLCDPCOOR_REG0		0x8b8
+#define SUN4I_BACKEND_DLCDPCOOR_REG1		0x8bc
+
+#define SUN4I_BACKEND_INT_EN_REG		0x8c0
+#define SUN4I_BACKEND_INT_FLAG_REG		0x8c4
+#define SUN4I_BACKEND_REG_LOAD_FINISHED			BIT(1)
+
+#define SUN4I_BACKEND_HWCCTL_REG		0x8d8
+#define SUN4I_BACKEND_HWCFBCTL_REG		0x8e0
+#define SUN4I_BACKEND_WBCTL_REG			0x8f0
+#define SUN4I_BACKEND_WBADD_REG			0x8f4
+#define SUN4I_BACKEND_WBLINEWIDTH_REG		0x8f8
+#define SUN4I_BACKEND_SPREN_REG			0x900
+#define SUN4I_BACKEND_SPRFMTCTL_REG		0x908
+#define SUN4I_BACKEND_SPRALPHACTL_REG		0x90c
+#define SUN4I_BACKEND_IYUVCTL_REG		0x920
+#define SUN4I_BACKEND_IYUVADD_REG(c)		(0x930 + (0x4 * (c)))
+#define SUN4I_BACKEND_IYUVLINEWITDTH_REG(c)	(0x940 + (0x4 * (c)))
+#define SUN4I_BACKEND_YGCOEF_REG(c)		(0x950 + (0x4 * (c)))
+#define SUN4I_BACKEND_YGCONS_REG		0x95c
+#define SUN4I_BACKEND_URCOEF_REG(c)		(0x960 + (0x4 * (c)))
+#define SUN4I_BACKEND_URCONS_REG		0x96c
+#define SUN4I_BACKEND_VBCOEF_REG(c)		(0x970 + (0x4 * (c)))
+#define SUN4I_BACKEND_VBCONS_REG		0x97c
+#define SUN4I_BACKEND_KSCTL_REG			0x980
+#define SUN4I_BACKEND_KSBKCOLOR_REG		0x984
+#define SUN4I_BACKEND_KSFSTLINEWIDTH_REG	0x988
+#define SUN4I_BACKEND_KSVSCAFCT_REG		0x98c
+#define SUN4I_BACKEND_KSHSCACOEF_REG(x)		(0x9a0 + (0x4 * (x)))
+#define SUN4I_BACKEND_OCCTL_REG			0x9c0
+#define SUN4I_BACKEND_OCCTL_ENABLE			BIT(0)
+
+#define SUN4I_BACKEND_OCRCOEF_REG(x)		(0x9d0 + (0x4 * (x)))
+#define SUN4I_BACKEND_OCRCONS_REG		0x9dc
+#define SUN4I_BACKEND_OCGCOEF_REG(x)		(0x9e0 + (0x4 * (x)))
+#define SUN4I_BACKEND_OCGCONS_REG		0x9ec
+#define SUN4I_BACKEND_OCBCOEF_REG(x)		(0x9f0 + (0x4 * (x)))
+#define SUN4I_BACKEND_OCBCONS_REG		0x9fc
+#define SUN4I_BACKEND_SPRCOORCTL_REG(s)		(0xa00 + (0x4 * (s)))
+#define SUN4I_BACKEND_SPRATTCTL_REG(s)		(0xb00 + (0x4 * (s)))
+#define SUN4I_BACKEND_SPRADD_REG(s)		(0xc00 + (0x4 * (s)))
+#define SUN4I_BACKEND_SPRLINEWIDTH_REG(s)	(0xd00 + (0x4 * (s)))
+
+#define SUN4I_BACKEND_SPRPALTAB_OFF		0x4000
+#define SUN4I_BACKEND_GAMMATAB_OFF		0x4400
+#define SUN4I_BACKEND_HWCPATTERN_OFF		0x4800
+#define SUN4I_BACKEND_HWCCOLORTAB_OFF		0x4c00
+#define SUN4I_BACKEND_PIPE_OFF(p)		(0x5000 + (0x400 * (p)))
+
+struct sun4i_backend {
+	struct regmap		*regs;
+
+	struct reset_control	*reset;
+
+	struct clk		*bus_clk;
+	struct clk		*mod_clk;
+	struct clk		*ram_clk;
+};
+
+void sun4i_backend_apply_color_correction(struct sun4i_backend *backend);
+void sun4i_backend_disable_color_correction(struct sun4i_backend *backend);
+
+void sun4i_backend_commit(struct sun4i_backend *backend);
+
+void sun4i_backend_layer_enable(struct sun4i_backend *backend,
+				int layer, bool enable);
+int sun4i_backend_update_layer_coord(struct sun4i_backend *backend,
+				     int layer, struct drm_plane *plane);
+int sun4i_backend_update_layer_formats(struct sun4i_backend *backend,
+				       int layer, struct drm_plane *plane);
+int sun4i_backend_update_layer_buffer(struct sun4i_backend *backend,
+				      int layer, struct drm_plane *plane);
+
+#endif /* _SUN4I_BACKEND_H_ */
diff --git a/drivers/gpu/drm/sun4i/sun4i_crtc.c b/drivers/gpu/drm/sun4i/sun4i_crtc.c
new file mode 100644
index 000000000000..4182a21f5923
--- /dev/null
+++ b/drivers/gpu/drm/sun4i/sun4i_crtc.c
@@ -0,0 +1,120 @@
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
+#include <drm/drmP.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_modes.h>
+
+#include <linux/clk-provider.h>
+#include <linux/ioport.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/regmap.h>
+
+#include <video/videomode.h>
+
+#include "sun4i_backend.h"
+#include "sun4i_crtc.h"
+#include "sun4i_drv.h"
+#include "sun4i_tcon.h"
+
+static void sun4i_crtc_atomic_begin(struct drm_crtc *crtc,
+				    struct drm_crtc_state *old_state)
+{
+	struct sun4i_crtc *scrtc = drm_crtc_to_sun4i_crtc(crtc);
+	struct drm_device *dev = crtc->dev;
+	unsigned long flags;
+
+	if (crtc->state->event) {
+		WARN_ON(drm_crtc_vblank_get(crtc) != 0);
+
+		spin_lock_irqsave(&dev->event_lock, flags);
+		scrtc->event = crtc->state->event;
+		spin_unlock_irqrestore(&dev->event_lock, flags);
+		crtc->state->event = NULL;
+	 }
+}
+
+static void sun4i_crtc_atomic_flush(struct drm_crtc *crtc,
+				    struct drm_crtc_state *old_state)
+{
+	struct sun4i_crtc *scrtc = drm_crtc_to_sun4i_crtc(crtc);
+	struct sun4i_drv *drv = scrtc->drv;
+
+	DRM_DEBUG_DRIVER("Committing plane changes\n");
+
+	sun4i_backend_commit(drv->backend);
+}
+
+static void sun4i_crtc_disable(struct drm_crtc *crtc)
+{
+	struct sun4i_crtc *scrtc = drm_crtc_to_sun4i_crtc(crtc);
+	struct sun4i_drv *drv = scrtc->drv;
+
+	DRM_DEBUG_DRIVER("Disabling the CRTC\n");
+
+	sun4i_tcon_disable(drv->tcon);
+}
+
+static void sun4i_crtc_enable(struct drm_crtc *crtc)
+{
+	struct sun4i_crtc *scrtc = drm_crtc_to_sun4i_crtc(crtc);
+	struct sun4i_drv *drv = scrtc->drv;
+
+	DRM_DEBUG_DRIVER("Enabling the CRTC\n");
+
+	sun4i_tcon_enable(drv->tcon);
+}
+
+static const struct drm_crtc_helper_funcs sun4i_crtc_helper_funcs = {
+	.atomic_begin	= sun4i_crtc_atomic_begin,
+	.atomic_flush	= sun4i_crtc_atomic_flush,
+	.disable	= sun4i_crtc_disable,
+	.enable		= sun4i_crtc_enable,
+};
+
+static const struct drm_crtc_funcs sun4i_crtc_funcs = {
+	.atomic_destroy_state	= drm_atomic_helper_crtc_destroy_state,
+	.atomic_duplicate_state	= drm_atomic_helper_crtc_duplicate_state,
+	.destroy		= drm_crtc_cleanup,
+	.page_flip		= drm_atomic_helper_page_flip,
+	.reset			= drm_atomic_helper_crtc_reset,
+	.set_config		= drm_atomic_helper_set_config,
+};
+
+struct sun4i_crtc *sun4i_crtc_init(struct drm_device *drm)
+{
+	struct sun4i_drv *drv = drm->dev_private;
+	struct sun4i_crtc *scrtc;
+	int ret;
+
+	scrtc = devm_kzalloc(drm->dev, sizeof(*scrtc), GFP_KERNEL);
+	if (!scrtc)
+		return NULL;
+	scrtc->drv = drv;
+
+	ret = drm_crtc_init_with_planes(drm, &scrtc->crtc,
+					drv->primary,
+					NULL,
+					&sun4i_crtc_funcs,
+					NULL);
+	if (ret) {
+		dev_err(drm->dev, "Couldn't init DRM CRTC\n");
+		return NULL;
+	}
+
+	drm_crtc_helper_add(&scrtc->crtc, &sun4i_crtc_helper_funcs);
+
+	return scrtc;
+}
diff --git a/drivers/gpu/drm/sun4i/sun4i_crtc.h b/drivers/gpu/drm/sun4i/sun4i_crtc.h
new file mode 100644
index 000000000000..dec8ce4d9b25
--- /dev/null
+++ b/drivers/gpu/drm/sun4i/sun4i_crtc.h
@@ -0,0 +1,30 @@
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
+#ifndef _SUN4I_CRTC_H_
+#define _SUN4I_CRTC_H_
+
+struct sun4i_crtc {
+	struct drm_crtc			crtc;
+	struct drm_pending_vblank_event	*event;
+
+	struct sun4i_drv		*drv;
+};
+
+static inline struct sun4i_crtc *drm_crtc_to_sun4i_crtc(struct drm_crtc *crtc)
+{
+	return container_of(crtc, struct sun4i_crtc, crtc);
+}
+
+struct sun4i_crtc *sun4i_crtc_init(struct drm_device *drm);
+
+#endif /* _SUN4I_CRTC_H_ */
diff --git a/drivers/gpu/drm/sun4i/sun4i_dotclock.c b/drivers/gpu/drm/sun4i/sun4i_dotclock.c
new file mode 100644
index 000000000000..3ff668cb463c
--- /dev/null
+++ b/drivers/gpu/drm/sun4i/sun4i_dotclock.c
@@ -0,0 +1,160 @@
+/*
+ * Copyright (C) 2016 Free Electrons
+ * Copyright (C) 2016 NextThing Co
+ *
+ * Maxime Ripard <maxime.ripard@free-electrons.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/regmap.h>
+
+#include "sun4i_tcon.h"
+
+struct sun4i_dclk {
+	struct clk_hw	hw;
+	struct regmap	*regmap;
+};
+
+static inline struct sun4i_dclk *hw_to_dclk(struct clk_hw *hw)
+{
+	return container_of(hw, struct sun4i_dclk, hw);
+}
+
+static void sun4i_dclk_disable(struct clk_hw *hw)
+{
+	struct sun4i_dclk *dclk = hw_to_dclk(hw);
+
+	regmap_update_bits(dclk->regmap, SUN4I_TCON0_DCLK_REG,
+			   BIT(SUN4I_TCON0_DCLK_GATE_BIT), 0);
+}
+
+static int sun4i_dclk_enable(struct clk_hw *hw)
+{
+	struct sun4i_dclk *dclk = hw_to_dclk(hw);
+
+	return regmap_update_bits(dclk->regmap, SUN4I_TCON0_DCLK_REG,
+				  BIT(SUN4I_TCON0_DCLK_GATE_BIT),
+				  BIT(SUN4I_TCON0_DCLK_GATE_BIT));
+}
+
+static int sun4i_dclk_is_enabled(struct clk_hw *hw)
+{
+	struct sun4i_dclk *dclk = hw_to_dclk(hw);
+	u32 val;
+
+	regmap_read(dclk->regmap, SUN4I_TCON0_DCLK_REG, &val);
+
+	return val & BIT(SUN4I_TCON0_DCLK_GATE_BIT);
+}
+
+static unsigned long sun4i_dclk_recalc_rate(struct clk_hw *hw,
+					    unsigned long parent_rate)
+{
+	struct sun4i_dclk *dclk = hw_to_dclk(hw);
+	u32 val;
+
+	regmap_read(dclk->regmap, SUN4I_TCON0_DCLK_REG, &val);
+
+	val >>= SUN4I_TCON0_DCLK_DIV_SHIFT;
+	val &= SUN4I_TCON0_DCLK_DIV_WIDTH;
+
+	if (!val)
+		val = 1;
+
+	return parent_rate / val;
+}
+
+static long sun4i_dclk_round_rate(struct clk_hw *hw, unsigned long rate,
+				  unsigned long *parent_rate)
+{
+	return *parent_rate / DIV_ROUND_CLOSEST(*parent_rate, rate);
+}
+
+static int sun4i_dclk_set_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long parent_rate)
+{
+	struct sun4i_dclk *dclk = hw_to_dclk(hw);
+	int div = DIV_ROUND_CLOSEST(parent_rate, rate);
+
+	return regmap_update_bits(dclk->regmap, SUN4I_TCON0_DCLK_REG,
+				  GENMASK(6, 0), div);
+}
+
+static int sun4i_dclk_get_phase(struct clk_hw *hw)
+{
+	struct sun4i_dclk *dclk = hw_to_dclk(hw);
+	u32 val;
+
+	regmap_read(dclk->regmap, SUN4I_TCON0_IO_POL_REG, &val);
+
+	val >>= 28;
+	val &= 3;
+
+	return val * 120;
+}
+
+static int sun4i_dclk_set_phase(struct clk_hw *hw, int degrees)
+{
+	struct sun4i_dclk *dclk = hw_to_dclk(hw);
+
+	regmap_update_bits(dclk->regmap, SUN4I_TCON0_IO_POL_REG,
+			   GENMASK(29, 28),
+			   degrees / 120);
+
+	return 0;
+}
+
+static const struct clk_ops sun4i_dclk_ops = {
+	.disable	= sun4i_dclk_disable,
+	.enable		= sun4i_dclk_enable,
+	.is_enabled	= sun4i_dclk_is_enabled,
+
+	.recalc_rate	= sun4i_dclk_recalc_rate,
+	.round_rate	= sun4i_dclk_round_rate,
+	.set_rate	= sun4i_dclk_set_rate,
+
+	.get_phase	= sun4i_dclk_get_phase,
+	.set_phase	= sun4i_dclk_set_phase,
+};
+
+int sun4i_dclk_create(struct device *dev, struct sun4i_tcon *tcon)
+{
+	const char *clk_name, *parent_name;
+	struct clk_init_data init;
+	struct sun4i_dclk *dclk;
+
+	parent_name = __clk_get_name(tcon->sclk0);
+	of_property_read_string_index(dev->of_node, "clock-output-names", 0,
+				      &clk_name);
+
+	dclk = devm_kzalloc(dev, sizeof(*dclk), GFP_KERNEL);
+	if (!dclk)
+		return -ENOMEM;
+
+	init.name = clk_name;
+	init.ops = &sun4i_dclk_ops;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+
+	dclk->regmap = tcon->regs;
+	dclk->hw.init = &init;
+
+	tcon->dclk = clk_register(dev, &dclk->hw);
+	if (IS_ERR(tcon->dclk))
+		return PTR_ERR(tcon->dclk);
+
+	return 0;
+}
+EXPORT_SYMBOL(sun4i_dclk_create);
+
+int sun4i_dclk_free(struct sun4i_tcon *tcon)
+{
+	clk_unregister(tcon->dclk);
+	return 0;
+}
+EXPORT_SYMBOL(sun4i_dclk_free);
diff --git a/drivers/gpu/drm/sun4i/sun4i_dotclock.h b/drivers/gpu/drm/sun4i/sun4i_dotclock.h
new file mode 100644
index 000000000000..d5e25fa9eff1
--- /dev/null
+++ b/drivers/gpu/drm/sun4i/sun4i_dotclock.h
@@ -0,0 +1,21 @@
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
+#ifndef _SUN4I_DOTCLOCK_H_
+#define _SUN4I_DOTCLOCK_H_
+
+struct sun4i_tcon;
+
+int sun4i_dclk_create(struct device *dev, struct sun4i_tcon *tcon);
+int sun4i_dclk_free(struct sun4i_tcon *tcon);
+
+#endif /* _SUN4I_DOTCLOCK_H_ */
diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
new file mode 100644
index 000000000000..5c64d2105dc7
--- /dev/null
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -0,0 +1,319 @@
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
+#include <linux/component.h>
+#include <linux/of_graph.h>
+
+#include <drm/drmP.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_fb_cma_helper.h>
+#include <drm/drm_gem_cma_helper.h>
+
+#include "sun4i_crtc.h"
+#include "sun4i_drv.h"
+#include "sun4i_framebuffer.h"
+#include "sun4i_layer.h"
+#include "sun4i_tcon.h"
+
+static int sun4i_drv_connector_plug_all(struct drm_device *drm)
+{
+	struct drm_connector *connector, *failed;
+	int ret;
+
+	mutex_lock(&drm->mode_config.mutex);
+	list_for_each_entry(connector, &drm->mode_config.connector_list, head) {
+		ret = drm_connector_register(connector);
+		if (ret) {
+			failed = connector;
+			goto err;
+		}
+	}
+	mutex_unlock(&drm->mode_config.mutex);
+	return 0;
+
+err:
+	list_for_each_entry(connector, &drm->mode_config.connector_list, head) {
+		if (failed == connector)
+			break;
+
+		drm_connector_unregister(connector);
+	}
+	mutex_unlock(&drm->mode_config.mutex);
+
+	return ret;
+}
+
+static int sun4i_drv_enable_vblank(struct drm_device *drm, unsigned int pipe)
+{
+	struct sun4i_drv *drv = drm->dev_private;
+	struct sun4i_tcon *tcon = drv->tcon;
+
+	DRM_DEBUG_DRIVER("Enabling VBLANK on pipe %d\n", pipe);
+
+	sun4i_tcon_enable_vblank(tcon, true);
+
+	return 0;
+}
+
+static void sun4i_drv_disable_vblank(struct drm_device *drm, unsigned int pipe)
+{
+	struct sun4i_drv *drv = drm->dev_private;
+	struct sun4i_tcon *tcon = drv->tcon;
+
+	DRM_DEBUG_DRIVER("Disabling VBLANK on pipe %d\n", pipe);
+
+	sun4i_tcon_enable_vblank(tcon, false);
+}
+
+static const struct file_operations sun4i_drv_fops = {
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
+static struct drm_driver sun4i_drv_driver = {
+	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_PRIME | DRIVER_ATOMIC,
+
+	/* Generic Operations */
+	.fops			= &sun4i_drv_fops,
+	.name			= "sun4i-drm",
+	.desc			= "Allwinner sun4i Display Engine",
+	.date			= "20150629",
+	.major			= 1,
+	.minor			= 0,
+
+	/* GEM Operations */
+	.dumb_create		= drm_gem_cma_dumb_create,
+	.dumb_destroy		= drm_gem_dumb_destroy,
+	.dumb_map_offset	= drm_gem_cma_dumb_map_offset,
+	.gem_free_object	= drm_gem_cma_free_object,
+	.gem_vm_ops		= &drm_gem_cma_vm_ops,
+
+	/* PRIME Operations */
+	.prime_handle_to_fd	= drm_gem_prime_handle_to_fd,
+	.prime_fd_to_handle	= drm_gem_prime_fd_to_handle,
+	.gem_prime_import	= drm_gem_prime_import,
+	.gem_prime_export	= drm_gem_prime_export,
+	.gem_prime_get_sg_table	= drm_gem_cma_prime_get_sg_table,
+	.gem_prime_import_sg_table = drm_gem_cma_prime_import_sg_table,
+	.gem_prime_vmap		= drm_gem_cma_prime_vmap,
+	.gem_prime_vunmap	= drm_gem_cma_prime_vunmap,
+	.gem_prime_mmap		= drm_gem_cma_prime_mmap,
+
+	/* Frame Buffer Operations */
+
+	/* VBlank Operations */
+	.get_vblank_counter	= drm_vblank_count,
+	.enable_vblank		= sun4i_drv_enable_vblank,
+	.disable_vblank		= sun4i_drv_disable_vblank,
+};
+
+static int sun4i_drv_bind(struct device *dev)
+{
+	struct drm_device *drm;
+	struct sun4i_drv *drv;
+	int ret;
+
+	drm = drm_dev_alloc(&sun4i_drv_driver, dev);
+	if (!drm)
+		return -ENOMEM;
+
+	ret = drm_dev_set_unique(drm, dev_name(drm->dev));
+	if (ret)
+		goto free_drm;
+
+	drv = devm_kzalloc(dev, sizeof(*drv), GFP_KERNEL);
+	if (!drv) {
+		ret = -ENOMEM;
+		goto free_drm;
+	}
+	drm->dev_private = drv;
+
+	drm_vblank_init(drm, 1);
+	drm_mode_config_init(drm);
+
+	ret = component_bind_all(drm->dev, drm);
+	if (ret) {
+		dev_err(drm->dev, "Couldn't bind all pipelines components\n");
+		goto free_drm;
+	}
+
+	/* Create our layers */
+	drv->layers = sun4i_layers_init(drm);
+	if (!drv->layers) {
+		dev_err(drm->dev, "Couldn't create the planes\n");
+		ret = -EINVAL;
+		goto free_drm;
+	}
+
+	/* Create our CRTC */
+	drv->crtc = sun4i_crtc_init(drm);
+	if (!drv->crtc) {
+		dev_err(drm->dev, "Couldn't create the CRTC\n");
+		ret = -EINVAL;
+		goto free_drm;
+	}
+	drm->irq_enabled = true;
+
+	/* Create our framebuffer */
+	drv->fbdev = sun4i_framebuffer_init(drm);
+	if (IS_ERR(drv->fbdev)) {
+		dev_err(drm->dev, "Couldn't create our framebuffer\n");
+		ret = PTR_ERR(drv->fbdev);
+		goto free_drm;
+	}
+
+	/* Enable connectors polling */
+	drm_kms_helper_poll_init(drm);
+
+	ret = drm_dev_register(drm, 0);
+	if (ret)
+		goto free_drm;
+
+	ret = sun4i_drv_connector_plug_all(drm);
+	if (ret)
+		goto unregister_drm;
+
+	return 0;
+
+unregister_drm:
+	drm_dev_unregister(drm);
+free_drm:
+	drm_dev_unref(drm);
+	return ret;
+}
+
+static void sun4i_drv_unbind(struct device *dev)
+{
+	struct drm_device *drm = dev_get_drvdata(dev);
+
+	drm_dev_unregister(drm);
+	drm_kms_helper_poll_fini(drm);
+	sun4i_framebuffer_free(drm);
+	drm_vblank_cleanup(drm);
+	drm_dev_unref(drm);
+}
+
+static const struct component_master_ops sun4i_drv_master_ops = {
+	.bind	= sun4i_drv_bind,
+	.unbind	= sun4i_drv_unbind,
+};
+
+static int compare_of(struct device *dev, void *data)
+{
+	DRM_DEBUG_DRIVER("Comparing of node %s with %s\n",
+			 of_node_full_name(dev->of_node),
+			 of_node_full_name(data));
+
+	return dev->of_node == data;
+}
+
+static int sun4i_drv_add_endpoints(struct device *dev,
+				   struct component_match **match,
+				   struct device_node *node)
+{
+	struct device_node *port, *ep, *remote;
+	int count = 0;
+
+	/* Add current component */
+	component_match_add(dev, match, compare_of, node);
+	count++;
+
+	/* Inputs are listed first, then outputs */
+	port = of_graph_get_port_by_id(node, 1);
+	if (!port) {
+		DRM_DEBUG_DRIVER("No output to bind\n");
+		return count;
+	}
+
+	for_each_available_child_of_node(port, ep) {
+		remote = of_graph_get_remote_port_parent(ep);
+		if (!remote) {
+			DRM_DEBUG_DRIVER("Error retrieving the output node\n");
+			of_node_put(remote);
+			continue;
+		}
+
+		/* Walk down our tree */
+		count += sun4i_drv_add_endpoints(dev, match, remote);
+
+		of_node_put(remote);
+	}
+
+	return count;
+}
+
+static int sun4i_drv_probe(struct platform_device *pdev)
+{
+	struct component_match *match = NULL;
+	struct device_node *np = pdev->dev.of_node;
+	int i, count = 0;
+
+	for (i = 0;; i++) {
+		struct device_node *pipeline = of_parse_phandle(np, "pipelines",
+								i);
+		if (!pipeline)
+			break;
+
+		if (!of_device_is_available(pipeline)) {
+			of_node_put(pipeline);
+			continue;
+		}
+
+		count += sun4i_drv_add_endpoints(&pdev->dev, &match,
+						pipeline);
+
+		DRM_DEBUG_DRIVER("Queued %d outputs on pipeline %d\n",
+				 count, i);
+	}
+
+	if (count)
+		return component_master_add_with_match(&pdev->dev,
+						       &sun4i_drv_master_ops,
+						       match);
+	else
+		return 0;
+}
+
+static int sun4i_drv_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static const struct of_device_id sun4i_drv_of_table[] = {
+	{ .compatible = "allwinner,sun5i-a13-display-engine" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sun4i_drv_of_table);
+
+static struct platform_driver sun4i_drv_platform_driver = {
+	.probe		= sun4i_drv_probe,
+	.remove		= sun4i_drv_remove,
+	.driver		= {
+		.name		= "sun4i-drm",
+		.of_match_table	= sun4i_drv_of_table,
+	},
+};
+module_platform_driver(sun4i_drv_platform_driver);
+
+MODULE_AUTHOR("Boris Brezillon <boris.brezillon@free-electrons.com>");
+MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com>");
+MODULE_DESCRIPTION("Allwinner A10 Display Engine DRM/KMS Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.h b/drivers/gpu/drm/sun4i/sun4i_drv.h
new file mode 100644
index 000000000000..597353eab728
--- /dev/null
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.h
@@ -0,0 +1,30 @@
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
+#ifndef _SUN4I_DRV_H_
+#define _SUN4I_DRV_H_
+
+#include <linux/clk.h>
+#include <linux/regmap.h>
+
+struct sun4i_drv {
+	struct sun4i_backend	*backend;
+	struct sun4i_crtc	*crtc;
+	struct sun4i_tcon	*tcon;
+
+	struct drm_plane	*primary;
+	struct drm_fbdev_cma	*fbdev;
+
+	struct sun4i_layer	**layers;
+};
+
+#endif /* _SUN4I_DRV_H_ */
diff --git a/drivers/gpu/drm/sun4i/sun4i_framebuffer.c b/drivers/gpu/drm/sun4i/sun4i_framebuffer.c
new file mode 100644
index 000000000000..a0b30c216a5b
--- /dev/null
+++ b/drivers/gpu/drm/sun4i/sun4i_framebuffer.c
@@ -0,0 +1,54 @@
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
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_fb_cma_helper.h>
+#include <drm/drmP.h>
+
+#include "sun4i_drv.h"
+
+static void sun4i_de_output_poll_changed(struct drm_device *drm)
+{
+	struct sun4i_drv *drv = drm->dev_private;
+
+	if (drv->fbdev)
+		drm_fbdev_cma_hotplug_event(drv->fbdev);
+}
+
+static const struct drm_mode_config_funcs sun4i_de_mode_config_funcs = {
+	.output_poll_changed	= sun4i_de_output_poll_changed,
+	.atomic_check		= drm_atomic_helper_check,
+	.atomic_commit		= drm_atomic_helper_commit,
+	.fb_create		= drm_fb_cma_create,
+};
+
+struct drm_fbdev_cma *sun4i_framebuffer_init(struct drm_device *drm)
+{
+	drm_mode_config_reset(drm);
+
+	drm->mode_config.max_width = 8192;
+	drm->mode_config.max_height = 8192;
+
+	drm->mode_config.funcs = &sun4i_de_mode_config_funcs;
+
+	return drm_fbdev_cma_init(drm, 32,
+				  drm->mode_config.num_crtc,
+				  drm->mode_config.num_connector);
+}
+
+void sun4i_framebuffer_free(struct drm_device *drm)
+{
+	struct sun4i_drv *drv = drm->dev_private;
+
+	drm_fbdev_cma_fini(drv->fbdev);
+	drm_mode_config_cleanup(drm);
+}
diff --git a/drivers/gpu/drm/sun4i/sun4i_framebuffer.h b/drivers/gpu/drm/sun4i/sun4i_framebuffer.h
new file mode 100644
index 000000000000..3afd65252ee0
--- /dev/null
+++ b/drivers/gpu/drm/sun4i/sun4i_framebuffer.h
@@ -0,0 +1,19 @@
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
+#ifndef _SUN4I_FRAMEBUFFER_H_
+#define _SUN4I_FRAMEBUFFER_H_
+
+struct drm_fbdev_cma *sun4i_framebuffer_init(struct drm_device *drm);
+void sun4i_framebuffer_free(struct drm_device *drm);
+
+#endif /* _SUN4I_FRAMEBUFFER_H_ */
diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
new file mode 100644
index 000000000000..068ab806309b
--- /dev/null
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
@@ -0,0 +1,161 @@
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
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_plane_helper.h>
+#include <drm/drmP.h>
+
+#include "sun4i_backend.h"
+#include "sun4i_drv.h"
+#include "sun4i_layer.h"
+
+#define SUN4I_NUM_LAYERS	2
+
+static int sun4i_backend_layer_atomic_check(struct drm_plane *plane,
+					    struct drm_plane_state *state)
+{
+	return 0;
+}
+
+static void sun4i_backend_layer_atomic_disable(struct drm_plane *plane,
+					       struct drm_plane_state *old_state)
+{
+	struct sun4i_layer *layer = plane_to_sun4i_layer(plane);
+	struct sun4i_drv *drv = layer->drv;
+	struct sun4i_backend *backend = drv->backend;
+
+	sun4i_backend_layer_enable(backend, layer->id, false);
+}
+
+static void sun4i_backend_layer_atomic_update(struct drm_plane *plane,
+					      struct drm_plane_state *old_state)
+{
+	struct sun4i_layer *layer = plane_to_sun4i_layer(plane);
+	struct sun4i_drv *drv = layer->drv;
+	struct sun4i_backend *backend = drv->backend;
+
+	sun4i_backend_update_layer_coord(backend, layer->id, plane);
+	sun4i_backend_update_layer_formats(backend, layer->id, plane);
+	sun4i_backend_update_layer_buffer(backend, layer->id, plane);
+	sun4i_backend_layer_enable(backend, layer->id, true);
+}
+
+static struct drm_plane_helper_funcs sun4i_backend_layer_helper_funcs = {
+	.atomic_check	= sun4i_backend_layer_atomic_check,
+	.atomic_disable	= sun4i_backend_layer_atomic_disable,
+	.atomic_update	= sun4i_backend_layer_atomic_update,
+};
+
+static const struct drm_plane_funcs sun4i_backend_layer_funcs = {
+	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
+	.atomic_duplicate_state	= drm_atomic_helper_plane_duplicate_state,
+	.destroy		= drm_plane_cleanup,
+	.disable_plane		= drm_atomic_helper_disable_plane,
+	.reset			= drm_atomic_helper_plane_reset,
+	.update_plane		= drm_atomic_helper_update_plane,
+};
+
+static const uint32_t sun4i_backend_layer_formats[] = {
+	DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_RGB888,
+};
+
+static struct sun4i_layer *sun4i_layer_init_one(struct drm_device *drm,
+						enum drm_plane_type type)
+{
+	struct sun4i_drv *drv = drm->dev_private;
+	struct sun4i_layer *layer;
+	int ret;
+
+	layer = devm_kzalloc(drm->dev, sizeof(*layer), GFP_KERNEL);
+	if (!layer)
+		return ERR_PTR(-ENOMEM);
+
+	ret = drm_universal_plane_init(drm, &layer->plane, BIT(0),
+				       &sun4i_backend_layer_funcs,
+				       sun4i_backend_layer_formats,
+				       ARRAY_SIZE(sun4i_backend_layer_formats),
+				       type,
+				       NULL);
+	if (ret) {
+		dev_err(drm->dev, "Couldn't initialize layer\n");
+		return ERR_PTR(ret);
+	}
+
+	drm_plane_helper_add(&layer->plane,
+			     &sun4i_backend_layer_helper_funcs);
+	layer->drv = drv;
+
+	if (type == DRM_PLANE_TYPE_PRIMARY)
+		drv->primary = &layer->plane;
+
+	return layer;
+}
+
+struct sun4i_layer **sun4i_layers_init(struct drm_device *drm)
+{
+	struct sun4i_drv *drv = drm->dev_private;
+	struct sun4i_layer **layers;
+	int i;
+
+	layers = devm_kcalloc(drm->dev, SUN4I_NUM_LAYERS, sizeof(**layers),
+			      GFP_KERNEL);
+	if (!layers)
+		return ERR_PTR(-ENOMEM);
+
+	/*
+	 * The hardware is a bit unusual here.
+	 *
+	 * Even though it supports 4 layers, it does the composition
+	 * in two separate steps.
+	 *
+	 * The first one is assigning a layer to one of its two
+	 * pipes. If more that 1 layer is assigned to the same pipe,
+	 * and if pixels overlaps, the pipe will take the pixel from
+	 * the layer with the highest priority.
+	 *
+	 * The second step is the actual alpha blending, that takes
+	 * the two pipes as input, and uses the eventual alpha
+	 * component to do the transparency between the two.
+	 *
+	 * This two steps scenario makes us unable to guarantee a
+	 * robust alpha blending between the 4 layers in all
+	 * situations. So we just expose two layers, one per pipe. On
+	 * SoCs that support it, sprites could fill the need for more
+	 * layers.
+	 */
+	for (i = 0; i < SUN4I_NUM_LAYERS; i++) {
+		enum drm_plane_type type = (i == 0)
+					 ? DRM_PLANE_TYPE_PRIMARY
+					 : DRM_PLANE_TYPE_OVERLAY;
+		struct sun4i_layer *layer = layers[i];
+
+		layer = sun4i_layer_init_one(drm, type);
+		if (IS_ERR(layer)) {
+			dev_err(drm->dev, "Couldn't initialize %s plane\n",
+				i ? "overlay" : "primary");
+			return ERR_CAST(layer);
+		};
+
+		DRM_DEBUG_DRIVER("Assigning %s plane to pipe %d\n",
+				 i ? "overlay" : "primary", i);
+		regmap_update_bits(drv->backend->regs, SUN4I_BACKEND_ATTCTL_REG0(i),
+				   SUN4I_BACKEND_ATTCTL_REG0_LAY_PIPESEL_MASK,
+				   SUN4I_BACKEND_ATTCTL_REG0_LAY_PIPESEL(i));
+
+		layer->id = i;
+	};
+
+	return layers;
+}
diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.h b/drivers/gpu/drm/sun4i/sun4i_layer.h
new file mode 100644
index 000000000000..a2f65d7a3f4e
--- /dev/null
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.h
@@ -0,0 +1,30 @@
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
+#ifndef _SUN4I_LAYER_H_
+#define _SUN4I_LAYER_H_
+
+struct sun4i_layer {
+	struct drm_plane	plane;
+	struct sun4i_drv	*drv;
+	int			id;
+};
+
+static inline struct sun4i_layer *
+plane_to_sun4i_layer(struct drm_plane *plane)
+{
+	return container_of(plane, struct sun4i_layer, plane);
+}
+
+struct sun4i_layer **sun4i_layers_init(struct drm_device *drm);
+
+#endif /* _SUN4I_LAYER_H_ */
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
new file mode 100644
index 000000000000..b6e57ed79df4
--- /dev/null
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -0,0 +1,492 @@
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
+#include <drm/drmP.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_modes.h>
+
+#include <linux/component.h>
+#include <linux/ioport.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+
+#include "sun4i_crtc.h"
+#include "sun4i_dotclock.h"
+#include "sun4i_drv.h"
+#include "sun4i_tcon.h"
+
+void sun4i_tcon_disable(struct sun4i_tcon *tcon)
+{
+	DRM_DEBUG_DRIVER("Disabling TCON\n");
+
+	/* Disable the TCON */
+	regmap_update_bits(tcon->regs, SUN4I_TCON_GCTL_REG,
+			   SUN4I_TCON_GCTL_TCON_ENABLE, 0);
+}
+EXPORT_SYMBOL(sun4i_tcon_disable);
+
+void sun4i_tcon_enable(struct sun4i_tcon *tcon)
+{
+	DRM_DEBUG_DRIVER("Enabling TCON\n");
+
+	/* Enable the TCON */
+	regmap_update_bits(tcon->regs, SUN4I_TCON_GCTL_REG,
+			   SUN4I_TCON_GCTL_TCON_ENABLE,
+			   SUN4I_TCON_GCTL_TCON_ENABLE);
+}
+EXPORT_SYMBOL(sun4i_tcon_enable);
+
+void sun4i_tcon_channel_disable(struct sun4i_tcon *tcon, int channel)
+{
+	/* Disable the TCON's channel */
+	if (channel == 0) {
+		regmap_update_bits(tcon->regs, SUN4I_TCON0_CTL_REG,
+				   SUN4I_TCON0_CTL_TCON_ENABLE, 0);
+		clk_disable_unprepare(tcon->dclk);
+	} else if (channel == 1) {
+		regmap_update_bits(tcon->regs, SUN4I_TCON1_CTL_REG,
+				   SUN4I_TCON1_CTL_TCON_ENABLE, 0);
+		clk_disable_unprepare(tcon->sclk1);
+	}
+}
+EXPORT_SYMBOL(sun4i_tcon_channel_disable);
+
+void sun4i_tcon_channel_enable(struct sun4i_tcon *tcon, int channel)
+{
+	/* Enable the TCON's channel */
+	if (channel == 0) {
+		regmap_update_bits(tcon->regs, SUN4I_TCON0_CTL_REG,
+				   SUN4I_TCON0_CTL_TCON_ENABLE,
+				   SUN4I_TCON0_CTL_TCON_ENABLE);
+		clk_prepare_enable(tcon->dclk);
+	} else if (channel == 1) {
+		regmap_update_bits(tcon->regs, SUN4I_TCON1_CTL_REG,
+				   SUN4I_TCON1_CTL_TCON_ENABLE,
+				   SUN4I_TCON1_CTL_TCON_ENABLE);
+		clk_prepare_enable(tcon->sclk1);
+	}
+}
+EXPORT_SYMBOL(sun4i_tcon_channel_enable);
+
+void sun4i_tcon_enable_vblank(struct sun4i_tcon *tcon, bool enable)
+{
+	u32 mask, val = 0;
+
+	DRM_DEBUG_DRIVER("%sabling VBLANK interrupt\n", enable ? "En" : "Dis");
+
+	mask = SUN4I_TCON_GINT0_VBLANK_ENABLE(0) |
+	       SUN4I_TCON_GINT0_VBLANK_ENABLE(1);
+
+	if (enable)
+		val = mask;
+
+	regmap_update_bits(tcon->regs, SUN4I_TCON_GINT0_REG, mask, val);
+}
+EXPORT_SYMBOL(sun4i_tcon_enable_vblank);
+
+static int sun4i_tcon_get_clk_delay(struct drm_display_mode *mode,
+				    int channel)
+{
+	int delay = mode->vtotal - mode->vdisplay;
+
+	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
+		delay /= 2;
+
+	if (channel == 1)
+		delay -= 2;
+
+	delay = min(delay, 30);
+
+	DRM_DEBUG_DRIVER("TCON %d clock delay %u\n", channel, delay);
+
+	return delay;
+}
+
+void sun4i_tcon0_mode_set(struct sun4i_tcon *tcon,
+			  struct drm_display_mode *mode)
+{
+	unsigned int bp, hsync, vsync;
+	u8 clk_delay;
+	u32 val = 0;
+
+	/* Adjust clock delay */
+	clk_delay = sun4i_tcon_get_clk_delay(mode, 1);
+	regmap_update_bits(tcon->regs, SUN4I_TCON0_CTL_REG,
+			   SUN4I_TCON0_CTL_CLK_DELAY_MASK,
+			   SUN4I_TCON0_CTL_CLK_DELAY(clk_delay));
+
+	/* Set the resolution */
+	regmap_write(tcon->regs, SUN4I_TCON0_BASIC0_REG,
+		     SUN4I_TCON0_BASIC0_X(mode->crtc_hdisplay) |
+		     SUN4I_TCON0_BASIC0_Y(mode->crtc_vdisplay));
+
+	/* Set horizontal display timings */
+	bp = mode->crtc_htotal - mode->crtc_hsync_end;
+	DRM_DEBUG_DRIVER("Setting horizontal total %d, backporch %d\n",
+			 mode->crtc_htotal, bp);
+	regmap_write(tcon->regs, SUN4I_TCON0_BASIC1_REG,
+		     SUN4I_TCON0_BASIC1_H_TOTAL(mode->crtc_htotal) |
+		     SUN4I_TCON0_BASIC1_H_BACKPORCH(bp));
+
+	/* Set vertical display timings */
+	bp = mode->crtc_vtotal - mode->crtc_vsync_end;
+	DRM_DEBUG_DRIVER("Setting vertical total %d, backporch %d\n",
+			 mode->crtc_vtotal, bp);
+	regmap_write(tcon->regs, SUN4I_TCON0_BASIC2_REG,
+		     SUN4I_TCON0_BASIC2_V_TOTAL(mode->crtc_vtotal) |
+		     SUN4I_TCON0_BASIC2_V_BACKPORCH(bp));
+
+	/* Set Hsync and Vsync length */
+	hsync = mode->crtc_hsync_end - mode->crtc_hsync_start;
+	vsync = mode->crtc_vsync_end - mode->crtc_vsync_start;
+	DRM_DEBUG_DRIVER("Setting HSYNC %d, VSYNC %d\n", hsync, vsync);
+	regmap_write(tcon->regs, SUN4I_TCON0_BASIC3_REG,
+		     SUN4I_TCON0_BASIC3_V_SYNC(vsync) |
+		     SUN4I_TCON0_BASIC3_H_SYNC(hsync));
+
+	/* Setup the polarity of the various signals */
+	if (!(mode->flags & DRM_MODE_FLAG_PHSYNC))
+		val |= SUN4I_TCON0_IO_POL_HSYNC_POSITIVE;
+
+	if (!(mode->flags & DRM_MODE_FLAG_PVSYNC))
+		val |= SUN4I_TCON0_IO_POL_VSYNC_POSITIVE;
+
+	regmap_update_bits(tcon->regs, SUN4I_TCON0_IO_POL_REG,
+			   SUN4I_TCON0_IO_POL_HSYNC_POSITIVE | SUN4I_TCON0_IO_POL_VSYNC_POSITIVE,
+			   val);
+
+	/* Map output pins to channel 0 */
+	regmap_update_bits(tcon->regs, SUN4I_TCON_GCTL_REG,
+			   SUN4I_TCON_GCTL_IOMAP_MASK,
+			   SUN4I_TCON_GCTL_IOMAP_TCON0);
+
+	/* Enable the output on the pins */
+	regmap_write(tcon->regs, SUN4I_TCON0_IO_TRI_REG, 0);
+}
+EXPORT_SYMBOL(sun4i_tcon0_mode_set);
+
+void sun4i_tcon1_mode_set(struct sun4i_tcon *tcon,
+			  struct drm_display_mode *mode)
+{
+	unsigned int bp, hsync, vsync;
+	u8 clk_delay;
+	u32 val;
+
+	/* Adjust clock delay */
+	clk_delay = sun4i_tcon_get_clk_delay(mode, 1);
+	regmap_update_bits(tcon->regs, SUN4I_TCON1_CTL_REG,
+			   SUN4I_TCON1_CTL_CLK_DELAY_MASK,
+			   SUN4I_TCON1_CTL_CLK_DELAY(clk_delay));
+
+	/* Set interlaced mode */
+	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
+		val = SUN4I_TCON1_CTL_INTERLACE_ENABLE;
+	else
+		val = 0;
+	regmap_update_bits(tcon->regs, SUN4I_TCON1_CTL_REG,
+			   SUN4I_TCON1_CTL_INTERLACE_ENABLE,
+			   val);
+
+	/* Set the input resolution */
+	regmap_write(tcon->regs, SUN4I_TCON1_BASIC0_REG,
+		     SUN4I_TCON1_BASIC0_X(mode->crtc_hdisplay) |
+		     SUN4I_TCON1_BASIC0_Y(mode->crtc_vdisplay));
+
+	/* Set the upscaling resolution */
+	regmap_write(tcon->regs, SUN4I_TCON1_BASIC1_REG,
+		     SUN4I_TCON1_BASIC1_X(mode->crtc_hdisplay) |
+		     SUN4I_TCON1_BASIC1_Y(mode->crtc_vdisplay));
+
+	/* Set the output resolution */
+	regmap_write(tcon->regs, SUN4I_TCON1_BASIC2_REG,
+		     SUN4I_TCON1_BASIC2_X(mode->crtc_hdisplay) |
+		     SUN4I_TCON1_BASIC2_Y(mode->crtc_vdisplay));
+
+	/* Set horizontal display timings */
+	bp = mode->crtc_htotal - mode->crtc_hsync_end;
+	DRM_DEBUG_DRIVER("Setting horizontal total %d, backporch %d\n",
+			 mode->htotal, bp);
+	regmap_write(tcon->regs, SUN4I_TCON1_BASIC3_REG,
+		     SUN4I_TCON1_BASIC3_H_TOTAL(mode->crtc_htotal) |
+		     SUN4I_TCON1_BASIC3_H_BACKPORCH(bp));
+
+	/* Set vertical display timings */
+	bp = mode->crtc_vtotal - mode->crtc_vsync_end;
+	DRM_DEBUG_DRIVER("Setting vertical total %d, backporch %d\n",
+			 mode->vtotal, bp);
+	regmap_write(tcon->regs, SUN4I_TCON1_BASIC4_REG,
+		     SUN4I_TCON1_BASIC4_V_TOTAL(mode->vtotal) |
+		     SUN4I_TCON1_BASIC4_V_BACKPORCH(bp));
+
+	/* Set Hsync and Vsync length */
+	hsync = mode->crtc_hsync_end - mode->crtc_hsync_start;
+	vsync = mode->crtc_vsync_end - mode->crtc_vsync_start;
+	DRM_DEBUG_DRIVER("Setting HSYNC %d, VSYNC %d\n", hsync, vsync);
+	regmap_write(tcon->regs, SUN4I_TCON1_BASIC5_REG,
+		     SUN4I_TCON1_BASIC5_V_SYNC(vsync) |
+		     SUN4I_TCON1_BASIC5_H_SYNC(hsync));
+
+	/* Map output pins to channel 1 */
+	regmap_update_bits(tcon->regs, SUN4I_TCON_GCTL_REG,
+			   SUN4I_TCON_GCTL_IOMAP_MASK,
+			   SUN4I_TCON_GCTL_IOMAP_TCON1);
+
+	/*
+	 * FIXME: Undocumented bits
+	 */
+	if (tcon->has_mux)
+		regmap_write(tcon->regs, SUN4I_TCON_MUX_CTRL_REG, 1);
+}
+EXPORT_SYMBOL(sun4i_tcon1_mode_set);
+
+static void sun4i_tcon_finish_page_flip(struct drm_device *dev,
+					struct sun4i_crtc *scrtc)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->event_lock, flags);
+	if (scrtc->event) {
+		drm_crtc_send_vblank_event(&scrtc->crtc, scrtc->event);
+		drm_crtc_vblank_put(&scrtc->crtc);
+		scrtc->event = NULL;
+	}
+	spin_unlock_irqrestore(&dev->event_lock, flags);
+}
+
+static irqreturn_t sun4i_tcon_handler(int irq, void *private)
+{
+	struct sun4i_tcon *tcon = private;
+	struct drm_device *drm = tcon->drm;
+	struct sun4i_drv *drv = drm->dev_private;
+	struct sun4i_crtc *scrtc = drv->crtc;
+	unsigned int status;
+
+	regmap_read(tcon->regs, SUN4I_TCON_GINT0_REG, &status);
+
+	if (!(status & (SUN4I_TCON_GINT0_VBLANK_INT(0) |
+			SUN4I_TCON_GINT0_VBLANK_INT(1))))
+		return IRQ_NONE;
+
+	drm_crtc_handle_vblank(&scrtc->crtc);
+	sun4i_tcon_finish_page_flip(drm, scrtc);
+
+	/* Acknowledge the interrupt */
+	regmap_update_bits(tcon->regs, SUN4I_TCON_GINT0_REG,
+			   SUN4I_TCON_GINT0_VBLANK_INT(0) |
+			   SUN4I_TCON_GINT0_VBLANK_INT(1),
+			   0);
+
+	return IRQ_HANDLED;
+}
+
+static int sun4i_tcon_init_clocks(struct device *dev,
+				  struct sun4i_tcon *tcon)
+{
+	tcon->clk = devm_clk_get(dev, "ahb");
+	if (IS_ERR(tcon->clk)) {
+		dev_err(dev, "Couldn't get the TCON bus clock\n");
+		return PTR_ERR(tcon->clk);
+	}
+	clk_prepare_enable(tcon->clk);
+
+	tcon->sclk0 = devm_clk_get(dev, "tcon-ch0");
+	if (IS_ERR(tcon->sclk0)) {
+		dev_err(dev, "Couldn't get the TCON channel 0 clock\n");
+		return PTR_ERR(tcon->sclk0);
+	}
+
+	tcon->sclk1 = devm_clk_get(dev, "tcon-ch1");
+	if (IS_ERR(tcon->sclk1)) {
+		dev_err(dev, "Couldn't get the TCON channel 1 clock\n");
+		return PTR_ERR(tcon->sclk1);
+	}
+
+	return sun4i_dclk_create(dev, tcon);
+}
+
+static void sun4i_tcon_free_clocks(struct sun4i_tcon *tcon)
+{
+	sun4i_dclk_free(tcon);
+	clk_disable_unprepare(tcon->clk);
+}
+
+static int sun4i_tcon_init_irq(struct device *dev,
+			       struct sun4i_tcon *tcon)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	int irq, ret;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(dev, "Couldn't retrieve the TCON interrupt\n");
+		return irq;
+	}
+
+	ret = devm_request_irq(dev, irq, sun4i_tcon_handler, 0,
+			       dev_name(dev), tcon);
+	if (ret) {
+		dev_err(dev, "Couldn't request the IRQ\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct regmap_config sun4i_tcon_regmap_config = {
+	.reg_bits	= 32,
+	.val_bits	= 32,
+	.reg_stride	= 4,
+	.max_register	= 0x800,
+};
+
+static int sun4i_tcon_init_regmap(struct device *dev,
+				  struct sun4i_tcon *tcon)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct resource *res;
+	void __iomem *regs;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	regs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(regs)) {
+		dev_err(dev, "Couldn't map the TCON registers\n");
+		return PTR_ERR(regs);
+	}
+
+	tcon->regs = devm_regmap_init_mmio(dev, regs,
+					   &sun4i_tcon_regmap_config);
+	if (IS_ERR(tcon->regs)) {
+		dev_err(dev, "Couldn't create the TCON regmap\n");
+		return PTR_ERR(tcon->regs);
+	}
+
+	/* Make sure the TCON is disabled and all IRQs are off */
+	regmap_write(tcon->regs, SUN4I_TCON_GCTL_REG, 0);
+	regmap_write(tcon->regs, SUN4I_TCON_GINT0_REG, 0);
+	regmap_write(tcon->regs, SUN4I_TCON_GINT1_REG, 0);
+
+	/* Disable IO lines and set them to tristate */
+	regmap_write(tcon->regs, SUN4I_TCON0_IO_TRI_REG, ~0);
+	regmap_write(tcon->regs, SUN4I_TCON1_IO_TRI_REG, ~0);
+
+	return 0;
+}
+
+static int sun4i_tcon_bind(struct device *dev, struct device *master,
+			   void *data)
+{
+	struct drm_device *drm = data;
+	struct sun4i_drv *drv = drm->dev_private;
+	struct sun4i_tcon *tcon;
+	int ret;
+
+	tcon = devm_kzalloc(dev, sizeof(*tcon), GFP_KERNEL);
+	if (!tcon)
+		return -ENOMEM;
+	dev_set_drvdata(dev, tcon);
+	drv->tcon = tcon;
+	tcon->drm = drm;
+
+	if (of_device_is_compatible(dev->of_node, "allwinner,sun5i-a13-tcon"))
+		tcon->has_mux = true;
+
+	tcon->lcd_rst = devm_reset_control_get(dev, "lcd");
+	if (IS_ERR(tcon->lcd_rst)) {
+		dev_err(dev, "Couldn't get our reset line\n");
+		return PTR_ERR(tcon->lcd_rst);
+	}
+
+	/* Make sure our TCON is reset */
+	if (!reset_control_status(tcon->lcd_rst))
+		reset_control_assert(tcon->lcd_rst);
+
+	ret = reset_control_deassert(tcon->lcd_rst);
+	if (ret) {
+		dev_err(dev, "Couldn't deassert our reset line\n");
+		return ret;
+	}
+
+	ret = sun4i_tcon_init_regmap(dev, tcon);
+	if (ret) {
+		dev_err(dev, "Couldn't init our TCON regmap\n");
+		goto err_assert_reset;
+	}
+
+	ret = sun4i_tcon_init_clocks(dev, tcon);
+	if (ret) {
+		dev_err(dev, "Couldn't init our TCON clocks\n");
+		goto err_assert_reset;
+	}
+
+	ret = sun4i_tcon_init_irq(dev, tcon);
+	if (ret) {
+		dev_err(dev, "Couldn't init our TCON interrupts\n");
+		goto err_free_clocks;
+	}
+
+	return 0;
+
+err_free_clocks:
+	sun4i_tcon_free_clocks(tcon);
+err_assert_reset:
+	reset_control_assert(tcon->lcd_rst);
+	return ret;
+}
+
+static void sun4i_tcon_unbind(struct device *dev, struct device *master,
+			      void *data)
+{
+	struct sun4i_tcon *tcon = dev_get_drvdata(dev);
+
+	sun4i_tcon_free_clocks(tcon);
+}
+
+static struct component_ops sun4i_tcon_ops = {
+	.bind	= sun4i_tcon_bind,
+	.unbind	= sun4i_tcon_unbind,
+};
+
+static int sun4i_tcon_probe(struct platform_device *pdev)
+{
+	return component_add(&pdev->dev, &sun4i_tcon_ops);
+}
+
+static int sun4i_tcon_remove(struct platform_device *pdev)
+{
+	component_del(&pdev->dev, &sun4i_tcon_ops);
+
+	return 0;
+}
+
+static const struct of_device_id sun4i_tcon_of_table[] = {
+	{ .compatible = "allwinner,sun5i-a13-tcon" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sun4i_tcon_of_table);
+
+static struct platform_driver sun4i_tcon_platform_driver = {
+	.probe		= sun4i_tcon_probe,
+	.remove		= sun4i_tcon_remove,
+	.driver		= {
+		.name		= "sun4i-tcon",
+		.of_match_table	= sun4i_tcon_of_table,
+	},
+};
+module_platform_driver(sun4i_tcon_platform_driver);
+
+MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com>");
+MODULE_DESCRIPTION("Allwinner A10 Timing Controller Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
new file mode 100644
index 000000000000..35161218c2c1
--- /dev/null
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
@@ -0,0 +1,184 @@
+/*
+ * Copyright (C) 2015 Free Electrons
+ * Copyright (C) 2015 NextThing Co
+ *
+ * Boris Brezillon <boris.brezillon@free-electrons.com>
+ * Maxime Ripard <maxime.ripard@free-electrons.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ */
+
+#ifndef __SUN4I_TCON_H__
+#define __SUN4I_TCON_H__
+
+#include <drm/drm_crtc.h>
+
+#include <linux/kernel.h>
+#include <linux/reset.h>
+
+#define SUN4I_TCON_GCTL_REG			0x0
+#define SUN4I_TCON_GCTL_TCON_ENABLE			BIT(31)
+#define SUN4I_TCON_GCTL_IOMAP_MASK			BIT(0)
+#define SUN4I_TCON_GCTL_IOMAP_TCON1			(1 << 0)
+#define SUN4I_TCON_GCTL_IOMAP_TCON0			(0 << 0)
+
+#define SUN4I_TCON_GINT0_REG			0x4
+#define SUN4I_TCON_GINT0_VBLANK_ENABLE(pipe)		BIT(31 - (pipe))
+#define SUN4I_TCON_GINT0_VBLANK_INT(pipe)		BIT(15 - (pipe))
+
+#define SUN4I_TCON_GINT1_REG			0x8
+#define SUN4I_TCON_FRM_CTL_REG			0x10
+
+#define SUN4I_TCON0_CTL_REG			0x40
+#define SUN4I_TCON0_CTL_TCON_ENABLE			BIT(31)
+#define SUN4I_TCON0_CTL_CLK_DELAY_MASK			GENMASK(8, 4)
+#define SUN4I_TCON0_CTL_CLK_DELAY(delay)		((delay << 4) & SUN4I_TCON0_CTL_CLK_DELAY_MASK)
+
+#define SUN4I_TCON0_DCLK_REG			0x44
+#define SUN4I_TCON0_DCLK_GATE_BIT			(31)
+#define SUN4I_TCON0_DCLK_DIV_SHIFT			(0)
+#define SUN4I_TCON0_DCLK_DIV_WIDTH			(7)
+
+#define SUN4I_TCON0_BASIC0_REG			0x48
+#define SUN4I_TCON0_BASIC0_X(width)			((((width) - 1) & 0xfff) << 16)
+#define SUN4I_TCON0_BASIC0_Y(height)			(((height) - 1) & 0xfff)
+
+#define SUN4I_TCON0_BASIC1_REG			0x4c
+#define SUN4I_TCON0_BASIC1_H_TOTAL(total)		((((total) - 1) & 0x1fff) << 16)
+#define SUN4I_TCON0_BASIC1_H_BACKPORCH(bp)		(((bp) - 1) & 0xfff)
+
+#define SUN4I_TCON0_BASIC2_REG			0x50
+#define SUN4I_TCON0_BASIC2_V_TOTAL(total)		((((total) * 2) & 0x1fff) << 16)
+#define SUN4I_TCON0_BASIC2_V_BACKPORCH(bp)		(((bp) - 1) & 0xfff)
+
+#define SUN4I_TCON0_BASIC3_REG			0x54
+#define SUN4I_TCON0_BASIC3_H_SYNC(width)		((((width) - 1) & 0x7ff) << 16)
+#define SUN4I_TCON0_BASIC3_V_SYNC(height)		(((height) - 1) & 0x7ff)
+
+#define SUN4I_TCON0_HV_IF_REG			0x58
+#define SUN4I_TCON0_CPU_IF_REG			0x60
+#define SUN4I_TCON0_CPU_WR_REG			0x64
+#define SUN4I_TCON0_CPU_RD0_REG			0x68
+#define SUN4I_TCON0_CPU_RDA_REG			0x6c
+#define SUN4I_TCON0_TTL0_REG			0x70
+#define SUN4I_TCON0_TTL1_REG			0x74
+#define SUN4I_TCON0_TTL2_REG			0x78
+#define SUN4I_TCON0_TTL3_REG			0x7c
+#define SUN4I_TCON0_TTL4_REG			0x80
+#define SUN4I_TCON0_LVDS_IF_REG			0x84
+#define SUN4I_TCON0_IO_POL_REG			0x88
+#define SUN4I_TCON0_IO_POL_DCLK_PHASE(phase)		((phase & 3) << 28)
+#define SUN4I_TCON0_IO_POL_HSYNC_POSITIVE		BIT(25)
+#define SUN4I_TCON0_IO_POL_VSYNC_POSITIVE		BIT(24)
+
+#define SUN4I_TCON0_IO_TRI_REG			0x8c
+#define SUN4I_TCON0_IO_TRI_HSYNC_DISABLE		BIT(25)
+#define SUN4I_TCON0_IO_TRI_VSYNC_DISABLE		BIT(24)
+#define SUN4I_TCON0_IO_TRI_DATA_PINS_DISABLE(pins)	GENMASK(pins, 0)
+
+#define SUN4I_TCON1_CTL_REG			0x90
+#define SUN4I_TCON1_CTL_TCON_ENABLE			BIT(31)
+#define SUN4I_TCON1_CTL_INTERLACE_ENABLE		BIT(20)
+#define SUN4I_TCON1_CTL_CLK_DELAY_MASK			GENMASK(8, 4)
+#define SUN4I_TCON1_CTL_CLK_DELAY(delay)		((delay << 4) & SUN4I_TCON1_CTL_CLK_DELAY_MASK)
+
+#define SUN4I_TCON1_BASIC0_REG			0x94
+#define SUN4I_TCON1_BASIC0_X(width)			((((width) - 1) & 0xfff) << 16)
+#define SUN4I_TCON1_BASIC0_Y(height)			(((height) - 1) & 0xfff)
+
+#define SUN4I_TCON1_BASIC1_REG			0x98
+#define SUN4I_TCON1_BASIC1_X(width)			((((width) - 1) & 0xfff) << 16)
+#define SUN4I_TCON1_BASIC1_Y(height)			(((height) - 1) & 0xfff)
+
+#define SUN4I_TCON1_BASIC2_REG			0x9c
+#define SUN4I_TCON1_BASIC2_X(width)			((((width) - 1) & 0xfff) << 16)
+#define SUN4I_TCON1_BASIC2_Y(height)			(((height) - 1) & 0xfff)
+
+#define SUN4I_TCON1_BASIC3_REG			0xa0
+#define SUN4I_TCON1_BASIC3_H_TOTAL(total)		((((total) - 1) & 0x1fff) << 16)
+#define SUN4I_TCON1_BASIC3_H_BACKPORCH(bp)		(((bp) - 1) & 0xfff)
+
+#define SUN4I_TCON1_BASIC4_REG			0xa4
+#define SUN4I_TCON1_BASIC4_V_TOTAL(total)		(((total) & 0x1fff) << 16)
+#define SUN4I_TCON1_BASIC4_V_BACKPORCH(bp)		(((bp) - 1) & 0xfff)
+
+#define SUN4I_TCON1_BASIC5_REG			0xa8
+#define SUN4I_TCON1_BASIC5_H_SYNC(width)		((((width) - 1) & 0x3ff) << 16)
+#define SUN4I_TCON1_BASIC5_V_SYNC(height)		(((height) - 1) & 0x3ff)
+
+#define SUN4I_TCON1_IO_POL_REG			0xf0
+#define SUN4I_TCON1_IO_TRI_REG			0xf4
+#define SUN4I_TCON_CEU_CTL_REG			0x100
+#define SUN4I_TCON_CEU_MUL_RR_REG		0x110
+#define SUN4I_TCON_CEU_MUL_RG_REG		0x114
+#define SUN4I_TCON_CEU_MUL_RB_REG		0x118
+#define SUN4I_TCON_CEU_ADD_RC_REG		0x11c
+#define SUN4I_TCON_CEU_MUL_GR_REG		0x120
+#define SUN4I_TCON_CEU_MUL_GG_REG		0x124
+#define SUN4I_TCON_CEU_MUL_GB_REG		0x128
+#define SUN4I_TCON_CEU_ADD_GC_REG		0x12c
+#define SUN4I_TCON_CEU_MUL_BR_REG		0x130
+#define SUN4I_TCON_CEU_MUL_BG_REG		0x134
+#define SUN4I_TCON_CEU_MUL_BB_REG		0x138
+#define SUN4I_TCON_CEU_ADD_BC_REG		0x13c
+#define SUN4I_TCON_CEU_RANGE_R_REG		0x140
+#define SUN4I_TCON_CEU_RANGE_G_REG		0x144
+#define SUN4I_TCON_CEU_RANGE_B_REG		0x148
+#define SUN4I_TCON_MUX_CTRL_REG			0x200
+#define SUN4I_TCON1_FILL_CTL_REG		0x300
+#define SUN4I_TCON1_FILL_BEG0_REG		0x304
+#define SUN4I_TCON1_FILL_END0_REG		0x308
+#define SUN4I_TCON1_FILL_DATA0_REG		0x30c
+#define SUN4I_TCON1_FILL_BEG1_REG		0x310
+#define SUN4I_TCON1_FILL_END1_REG		0x314
+#define SUN4I_TCON1_FILL_DATA1_REG		0x318
+#define SUN4I_TCON1_FILL_BEG2_REG		0x31c
+#define SUN4I_TCON1_FILL_END2_REG		0x320
+#define SUN4I_TCON1_FILL_DATA2_REG		0x324
+#define SUN4I_TCON1_GAMMA_TABLE_REG		0x400
+
+#define SUN4I_TCON_MAX_CHANNELS		2
+
+struct sun4i_tcon {
+	struct drm_device		*drm;
+	struct regmap			*regs;
+
+	/* Main bus clock */
+	struct clk			*clk;
+
+	/* Clocks for the TCON channels */
+	struct clk			*sclk0;
+	struct clk			*sclk1;
+
+	/* Pixel clock */
+	struct clk			*dclk;
+
+	/* Reset control */
+	struct reset_control		*lcd_rst;
+
+	/* Platform adjustments */
+	bool				has_mux;
+};
+
+/* Global Control */
+void sun4i_tcon_disable(struct sun4i_tcon *tcon);
+void sun4i_tcon_enable(struct sun4i_tcon *tcon);
+
+/* Channel Control */
+void sun4i_tcon_channel_disable(struct sun4i_tcon *tcon, int channel);
+void sun4i_tcon_channel_enable(struct sun4i_tcon *tcon, int channel);
+
+void sun4i_tcon_enable_vblank(struct sun4i_tcon *tcon, bool enable);
+
+/* Mode Related Controls */
+void sun4i_tcon_switch_interlace(struct sun4i_tcon *tcon,
+				 bool enable);
+void sun4i_tcon0_mode_set(struct sun4i_tcon *tcon,
+			  struct drm_display_mode *mode);
+void sun4i_tcon1_mode_set(struct sun4i_tcon *tcon,
+			  struct drm_display_mode *mode);
+
+#endif /* __SUN4I_TCON_H__ */
-- 
2.7.3
