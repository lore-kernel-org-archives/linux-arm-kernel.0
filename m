From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 2 Feb 2016 16:25:51 +0100
Subject: [PATCH v4 2/2] drm: sunxi: Add a basic DRM driver for Allwinner DE2
In-Reply-To: <cover.1454435944.git.moinejf@free.fr>
References: <cover.1454435944.git.moinejf@free.fr>
Message-ID: <76ae5b406ad64b2717c0b1c62c3005a62b2715b8.1454435944.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In recent SoCs, as the H3, Allwinner uses a new display interface, DE2.
This patch adds a DRM video driver for this interface.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
v4: (no change)
v3:
	- add the hardware cursor
	- simplify and fix the DE2 init sequences
	- generation for all SUNXI SoCs (Andre Przywara)
v2:
	- remarks from Russell King
	- DT documentation added
	- working resolution change with xrandr
	- removal of the HDMI driver
---
 .../devicetree/bindings/display/sunxi.txt          |  81 ++++
 drivers/gpu/drm/Kconfig                            |   2 +
 drivers/gpu/drm/Makefile                           |   1 +
 drivers/gpu/drm/sunxi/Kconfig                      |  20 +
 drivers/gpu/drm/sunxi/Makefile                     |   7 +
 drivers/gpu/drm/sunxi/de2_crtc.c                   | 421 +++++++++++++++++
 drivers/gpu/drm/sunxi/de2_crtc.h                   |  61 +++
 drivers/gpu/drm/sunxi/de2_de.c                     | 505 +++++++++++++++++++++
 drivers/gpu/drm/sunxi/de2_drm.h                    |  40 ++
 drivers/gpu/drm/sunxi/de2_drv.c                    | 377 +++++++++++++++
 drivers/gpu/drm/sunxi/de2_plane.c                  |  91 ++++
 11 files changed, 1606 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sunxi.txt
 create mode 100644 drivers/gpu/drm/sunxi/Kconfig
 create mode 100644 drivers/gpu/drm/sunxi/Makefile
 create mode 100644 drivers/gpu/drm/sunxi/de2_crtc.c
 create mode 100644 drivers/gpu/drm/sunxi/de2_crtc.h
 create mode 100644 drivers/gpu/drm/sunxi/de2_de.c
 create mode 100644 drivers/gpu/drm/sunxi/de2_drm.h
 create mode 100644 drivers/gpu/drm/sunxi/de2_drv.c
 create mode 100644 drivers/gpu/drm/sunxi/de2_plane.c

diff --git a/Documentation/devicetree/bindings/display/sunxi.txt b/Documentation/devicetree/bindings/display/sunxi.txt
new file mode 100644
index 0000000..35f9763
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/sunxi.txt
@@ -0,0 +1,81 @@
+Allwinner sunxi display subsystem
+=================================
+
+The sunxi display subsystems contain a display controller (DE),
+one or two LCD controllers (TCON) and their external interfaces.
+
+Display controller
+==================
+
+Required properties:
+
+- compatible: value should be one of the following
+		"allwinner,sun8i-h3-display-engine"
+
+- clocks: must include clock specifiers corresponding to entries in the
+		clock-names property.
+
+- clock-names: must contain
+		gate: for DE activation
+		clock: DE clock
+
+- resets: phandle to the reset of the device
+
+- ports: phandle's to the LCD ports
+
+LCD controller
+==============
+
+Required properties:
+
+- compatible: value should be one of the following
+		"allwinner,sun8i-h3-lcd"
+
+- clocks: must include clock specifiers corresponding to entries in the
+		clock-names property.
+
+- clock-names: must contain
+		gate: for LCD activation
+		clock: pixel clock
+
+- resets: phandle to the reset of the device
+
+- port: port node with endpoint definitions as defined in
+	Documentation/devicetree/bindings/media/video-interfaces.txt
+
+Example:
+
+	de: de-controller at 01000000 {
+		compatible = "allwinner,sun8i-h3-display-engine";
+		...
+		clocks = <&bus_gates 44>, <&de_clk>;
+		clock-names = "gate", "clock";
+		resets = <&ahb_rst 44>;
+		ports = <&lcd0_p>;
+	};
+
+	lcd0: lcd-controller at 01c0c000 {
+		compatible = "allwinner,sun8i-h3-lcd";
+		...
+		clocks = <&bus_gates 35>, <&tcon0_clk>;
+		clock-names = "gate", "clock";
+		resets = <&ahb_rst 35>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		lcd0_p: port {
+			lcd0_ep: endpoint {
+				remote-endpoint = <&hdmi_ep>;
+			};
+		};
+	};
+
+	hdmi: hdmi at 01ee0000 {
+		...
+		#address-cells = <1>;
+		#size-cells = <0>;
+		port {
+			hdmi_ep: endpoint {
+				remote-endpoint = <&lcd0_ep>;
+			};
+		};
+	};
diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 8ae7ab6..0cec9a1 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -269,3 +269,5 @@ source "drivers/gpu/drm/imx/Kconfig"
 source "drivers/gpu/drm/vc4/Kconfig"
 
 source "drivers/gpu/drm/etnaviv/Kconfig"
+
+source "drivers/gpu/drm/sunxi/Kconfig"
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 61766de..eef53f2 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -74,3 +74,4 @@ obj-y			+= panel/
 obj-y			+= bridge/
 obj-$(CONFIG_DRM_FSL_DCU) += fsl-dcu/
 obj-$(CONFIG_DRM_ETNAVIV) += etnaviv/
+obj-$(CONFIG_DRM_SUNXI) += sunxi/
diff --git a/drivers/gpu/drm/sunxi/Kconfig b/drivers/gpu/drm/sunxi/Kconfig
new file mode 100644
index 0000000..e452930
--- /dev/null
+++ b/drivers/gpu/drm/sunxi/Kconfig
@@ -0,0 +1,20 @@
+#
+# Allwinner Video configuration
+#
+
+config DRM_SUNXI
+	tristate "DRM Support for Allwinner Video"
+	depends on DRM && ARCH_SUNXI
+	depends on OF
+	select DRM_KMS_HELPER
+	select DRM_KMS_CMA_HELPER
+	select DRM_GEM_CMA_HELPER
+	help
+	  Choose this option if you have a Allwinner chipset.
+
+config DRM_SUNXI_DE2
+	tristate "Support for Allwinner Video with DE2 interface"
+	depends on DRM_SUNXI
+	help
+	  Choose this option if your Allwinner chipset has the DE2 interface
+	  as the H3.
diff --git a/drivers/gpu/drm/sunxi/Makefile b/drivers/gpu/drm/sunxi/Makefile
new file mode 100644
index 0000000..3778877
--- /dev/null
+++ b/drivers/gpu/drm/sunxi/Makefile
@@ -0,0 +1,7 @@
+#
+# Makefile for Allwinner's DRM device driver
+#
+
+sunxi-de2-drm-objs := de2_drv.o de2_de.o de2_crtc.o de2_plane.o
+
+obj-$(CONFIG_DRM_SUNXI_DE2) += sunxi-de2-drm.o
diff --git a/drivers/gpu/drm/sunxi/de2_crtc.c b/drivers/gpu/drm/sunxi/de2_crtc.c
new file mode 100644
index 0000000..b5a093e
--- /dev/null
+++ b/drivers/gpu/drm/sunxi/de2_crtc.c
@@ -0,0 +1,421 @@
+/*
+ * Allwinner DRM driver - DE2 CRTC
+ *
+ * Copyright (C) 2016 Jean-Francois Moine <moinejf@free.fr>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ */
+
+#include <linux/component.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_atomic_helper.h>
+#include <asm/io.h>
+
+#include "de2_drm.h"
+#include "de2_crtc.h"
+
+/* I/O map */
+
+struct tcon {
+	u32 gctl;
+#define		TCON_GCTL_TCON_En BIT(31)
+	u32 gint0;
+#define		TCON_GINT0_TCON1_Vb_Int_En BIT(30)
+#define		TCON_GINT0_TCON1_Vb_Int_Flag BIT(12)
+	u32 gint1;
+	u32 dum0[13];
+	u32 tcon0_ctl;
+#define		TCON0_CTL_TCON_En BIT(31)
+	u32 dum1[19];
+	u32 tcon1_ctl;
+#define		TCON1_CTL_TCON_En BIT(31)
+#define		TCON1_CTL_Interlace_En BIT(20)
+#define		TCON1_CTL_Start_Delay_SHIFT 4
+#define		TCON1_CTL_Start_Delay_MASK GENMASK(8, 4)
+	u32 basic0;			/* XI/YI */
+	u32 basic1;			/* LS_XO/LS_YO */
+	u32 basic2;			/* XO/YO */
+	u32 basic3;			/* HT/HBP */
+	u32 basic4;			/* VT/VBP */
+	u32 basic5;			/* HSPW/VSPW */
+	u32 dum2;
+	u32 ps_sync;
+	u32 dum3[15];
+	u32 io_pol;
+#define		TCON1_IO_POL_IO0_inv BIT(24)
+#define		TCON1_IO_POL_IO1_inv BIT(25)
+#define		TCON1_IO_POL_IO2_inv BIT(26)
+	u32 io_tri;
+	u32 dum4[2];
+
+	u32 ceu_ctl;			/* 100 */
+#define     TCON_CEU_CTL_ceu_en BIT(31)
+	u32 dum5[3];
+	u32 ceu_rr;
+	u32 ceu_rg;
+	u32 ceu_rb;
+	u32 ceu_rc;
+	u32 ceu_gr;
+	u32 ceu_gg;
+	u32 ceu_gb;
+	u32 ceu_gc;
+	u32 ceu_br;
+	u32 ceu_bg;
+	u32 ceu_bb;
+	u32 ceu_bc;
+	u32 ceu_rv;
+	u32 ceu_gv;
+	u32 ceu_bv;
+	u32 dum6[45];
+
+	u32 mux_ctl;			/* 200 */
+#define		TCON_MUX_CTL_HDMI_SRC_SHIFT 8
+#define		TCON_MUX_CTL_HDMI_SRC_MASK GENMASK(9, 8)
+	u32 dum7[63];
+
+	u32 fill_ctl;			/* 300 */
+	u32 fill_start0;
+	u32 fill_end0;
+	u32 fill_data0;
+};
+
+#define XY(x, y) (((x) << 16) | (y))
+
+#define tcon_read(base, member) \
+	readl_relaxed(base + offsetof(struct tcon, member))
+#define tcon_write(base, member, data) \
+	writel_relaxed(data, base + offsetof(struct tcon, member))
+
+/*
+ * vertical blank functions
+ */
+int de2_enable_vblank(struct drm_device *drm, unsigned crtc)
+{
+	return 0;
+}
+
+void de2_disable_vblank(struct drm_device *drm, unsigned crtc)
+{
+}
+
+static void de2_set_frame_timings(struct lcd *lcd)
+{
+	struct drm_crtc *crtc = &lcd->crtc;
+	const struct drm_display_mode *mode = &crtc->mode;
+	int interlace = mode->flags & DRM_MODE_FLAG_INTERLACE ? 2 : 1;
+	int start_delay;
+	u32 data;
+
+	DRM_DEBUG_DRIVER("\n");
+
+	data = XY(mode->hdisplay - 1, mode->vdisplay / interlace - 1);
+	tcon_write(lcd->mmio, basic0, data);
+	tcon_write(lcd->mmio, basic1, data);
+	tcon_write(lcd->mmio, basic2, data);
+	tcon_write(lcd->mmio, basic3,
+			XY(mode->htotal - 1,
+				mode->htotal - mode->hsync_start - 1));
+	tcon_write(lcd->mmio, basic4,
+			XY(mode->vtotal * (3 - interlace),
+				mode->vtotal - mode->vsync_start - 1));
+	tcon_write(lcd->mmio, basic5,
+			 XY(mode->hsync_end - mode->hsync_start - 1,
+				mode->vsync_end - mode->vsync_start - 1));
+
+	tcon_write(lcd->mmio, ps_sync, XY(1, 1));
+
+	data = TCON1_IO_POL_IO2_inv;
+	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
+		data |= TCON1_IO_POL_IO0_inv;
+	if (mode->flags & DRM_MODE_FLAG_PHSYNC)
+		data |= TCON1_IO_POL_IO1_inv;
+	tcon_write(lcd->mmio, io_pol, data);
+
+	tcon_write(lcd->mmio, ceu_ctl,
+		tcon_read(lcd->mmio, ceu_ctl) & ~TCON_CEU_CTL_ceu_en);
+
+	data = tcon_read(lcd->mmio, tcon1_ctl);
+	if (interlace == 2)
+		data |= TCON1_CTL_Interlace_En;
+	else
+		data &= ~TCON1_CTL_Interlace_En;
+	tcon_write(lcd->mmio, tcon1_ctl, data);
+
+	tcon_write(lcd->mmio, fill_ctl, 0);
+	tcon_write(lcd->mmio, fill_start0, mode->vtotal + 1);
+	tcon_write(lcd->mmio, fill_end0, mode->vtotal);
+	tcon_write(lcd->mmio, fill_data0, 0);
+
+	start_delay = (mode->vtotal - mode->vdisplay) / interlace - 5;
+	if (start_delay > 31)
+		start_delay = 31;
+	data = tcon_read(lcd->mmio, tcon1_ctl);
+	data &= ~TCON1_CTL_Start_Delay_MASK;
+	data |= start_delay << TCON1_CTL_Start_Delay_SHIFT;
+	tcon_write(lcd->mmio, tcon1_ctl, data);
+
+	tcon_write(lcd->mmio, io_tri, 0x0fffffff);
+}
+
+static void de2_crtc_enable(struct drm_crtc *crtc)
+{
+	struct lcd *lcd = crtc_to_lcd(crtc);
+	struct drm_display_mode *mode = &crtc->mode;
+	u32 data;
+
+	DRM_DEBUG_DRIVER("\n");
+
+	de2_set_frame_timings(lcd);
+
+	clk_set_rate(lcd->clk, mode->clock * 1000);
+
+	if (lcd->num == 0) {				/* HDMI */
+		data = tcon_read(lcd->mmio, mux_ctl);
+		data &= ~TCON_MUX_CTL_HDMI_SRC_MASK;
+		data |= lcd->num << TCON_MUX_CTL_HDMI_SRC_SHIFT;
+		tcon_write(lcd->mmio, mux_ctl, data);
+	}
+
+	tcon_write(lcd->mmio, tcon1_ctl,
+		tcon_read(lcd->mmio, tcon1_ctl) | TCON1_CTL_TCON_En);
+
+	de2_de_panel_init(lcd->priv, lcd->num, mode);
+
+	drm_mode_debug_printmodeline(mode);
+}
+
+static void de2_crtc_disable(struct drm_crtc *crtc)
+{
+	struct lcd *lcd = crtc_to_lcd(crtc);
+
+	DRM_DEBUG_DRIVER("\n");
+
+	tcon_write(lcd->mmio, tcon1_ctl,
+		tcon_read(lcd->mmio, tcon1_ctl) & ~TCON1_CTL_TCON_En);
+}
+
+static const struct drm_crtc_funcs de2_crtc_funcs = {
+	.destroy	= drm_crtc_cleanup,
+	.set_config	= drm_atomic_helper_set_config,
+	.page_flip	= drm_atomic_helper_page_flip,
+	.reset		= drm_atomic_helper_crtc_reset,
+	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
+};
+
+static const struct drm_crtc_helper_funcs de2_crtc_helper_funcs = {
+	.enable		= de2_crtc_enable,
+	.disable	= de2_crtc_disable,
+};
+
+static void de2_tcon_enable(struct lcd *lcd)
+{
+	DRM_DEBUG_DRIVER("\n");
+
+	tcon_write(lcd->mmio, tcon0_ctl,
+		tcon_read(lcd->mmio, tcon0_ctl) & ~TCON0_CTL_TCON_En);
+	tcon_write(lcd->mmio, tcon1_ctl,
+		tcon_read(lcd->mmio, tcon1_ctl) & ~TCON1_CTL_TCON_En);
+	tcon_write(lcd->mmio, gctl,
+		tcon_read(lcd->mmio, gctl) & ~TCON_GCTL_TCON_En);
+
+	tcon_write(lcd->mmio, gint0,
+		tcon_read(lcd->mmio, gint0) & ~(TCON_GINT0_TCON1_Vb_Int_En |
+						TCON_GINT0_TCON1_Vb_Int_Flag));
+
+	tcon_write(lcd->mmio, gctl,
+		tcon_read(lcd->mmio, gctl) | TCON_GCTL_TCON_En);
+}
+
+static int de2_crtc_init(struct drm_device *drm, struct lcd *lcd)
+{
+	struct drm_crtc *crtc = &lcd->crtc;
+	int ret;
+
+	ret = de2_plane_init(drm, lcd);
+	if (ret < 0)
+		return ret;
+
+	ret = drm_crtc_init_with_planes(drm, crtc,
+					&lcd->planes[DE2_PRIMARY_PLANE],
+					&lcd->planes[DE2_CURSOR_PLANE],
+					&de2_crtc_funcs, NULL);
+	if (ret < 0)
+		return ret;
+
+	de2_tcon_enable(lcd);
+
+	de2_de_enable(lcd->priv, lcd->num);
+
+	drm_crtc_helper_add(crtc, &de2_crtc_helper_funcs);
+
+	return 0;
+}
+
+/*
+ * device init
+ */
+static int de2_lcd_bind(struct device *dev, struct device *master,
+			void *data)
+{
+	struct drm_device *drm = data;
+	struct priv *priv = drm->dev_private;
+	struct lcd *lcd = dev_get_drvdata(dev);
+	int ret;
+
+	lcd->priv = priv;
+
+	ret = de2_crtc_init(drm, lcd);
+	if (ret < 0) {
+		dev_err(dev, "failed to init the crtc\n");
+		return ret;
+	}
+
+	priv->lcds[lcd->num] = lcd;
+
+	return 0;
+}
+
+static void de2_lcd_unbind(struct device *dev, struct device *master,
+			void *data)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct lcd *lcd = platform_get_drvdata(pdev);
+
+	if (lcd->mmio) {
+		if (lcd->priv)
+			de2_de_disable(lcd->priv, lcd->num);
+		tcon_write(lcd->mmio, gctl,
+			tcon_read(lcd->mmio, gctl) & ~TCON_GCTL_TCON_En);
+	}
+}
+
+static const struct component_ops de2_lcd_ops = {
+	.bind = de2_lcd_bind,
+	.unbind = de2_lcd_unbind,
+};
+
+static int de2_lcd_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node, *tmp, *parent, *port;
+	struct lcd *lcd;
+	struct resource *res;
+	int id, ret;
+
+	id = of_alias_get_id(np, "lcd");
+	if (id < 0) {
+		dev_err(dev, "no alias for lcd\n");
+		id = 0;
+	}
+	lcd = devm_kzalloc(dev, sizeof *lcd, GFP_KERNEL);
+	if (!lcd) {
+		dev_err(dev, "failed to allocate private data\n");
+		return -ENOMEM;
+	}
+	dev_set_drvdata(dev, lcd);
+	lcd->dev = dev;
+	lcd->num = id;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(dev, "failed to get memory resource\n");
+		return -EINVAL;
+	}
+
+	lcd->mmio = devm_ioremap_resource(dev, res);
+	if (IS_ERR(lcd->mmio)) {
+		dev_err(dev, "failed to map registers\n");
+		return PTR_ERR(lcd->mmio);
+	}
+
+	snprintf(lcd->name, sizeof(lcd->name), "sunxi-lcd%d", id);
+
+	/* possible CRTCs */
+	parent = np;
+	tmp = of_get_child_by_name(np, "ports");
+	if (tmp)
+		parent = tmp;
+	port = of_get_child_by_name(parent, "port");
+	of_node_put(tmp);
+	if (!port) {
+		dev_err(dev, "no port node\n");
+		return -ENXIO;
+	}
+	lcd->crtc.port = port;
+
+	lcd->gate = devm_clk_get(dev, "gate");
+	if (IS_ERR(lcd->gate)) {
+		dev_err(dev, "gate clock err %d\n", (int) PTR_ERR(lcd->gate));
+		ret = PTR_ERR(lcd->gate);
+		goto err;
+	}
+
+	lcd->clk = devm_clk_get(dev, "clock");
+	if (IS_ERR(lcd->clk)) {
+		dev_err(dev, "video clock err %d\n", (int) PTR_ERR(lcd->clk));
+		ret = PTR_ERR(lcd->clk);
+		goto err;
+	}
+
+	lcd->rstc = devm_reset_control_get(dev, NULL);
+	if (IS_ERR(lcd->rstc)) {
+		dev_err(dev, "reset controller err %d\n",
+				(int) PTR_ERR(lcd->rstc));
+		ret = PTR_ERR(lcd->rstc);
+		goto err;
+	}
+
+	ret = clk_prepare_enable(lcd->clk);
+	if (ret)
+		goto err;
+	ret = clk_prepare_enable(lcd->gate);
+	if (ret)
+		goto err;
+
+	ret = reset_control_deassert(lcd->rstc);
+	if (ret) {
+		dev_err(dev, "reset deassert err %d\n", ret);
+		goto err;
+	}
+
+	return component_add(&pdev->dev, &de2_lcd_ops);
+
+err:
+	clk_disable_unprepare(lcd->gate);
+	clk_disable_unprepare(lcd->clk);
+	of_node_put(lcd->crtc.port);
+	return ret;
+}
+
+static int de2_lcd_remove(struct platform_device *pdev)
+{
+	struct lcd *lcd = platform_get_drvdata(pdev);
+
+	component_del(&pdev->dev, &de2_lcd_ops);
+
+	if (!IS_ERR_OR_NULL(lcd->rstc))
+		reset_control_assert(lcd->rstc);
+	clk_disable_unprepare(lcd->gate);
+	clk_disable_unprepare(lcd->clk);
+	of_node_put(lcd->crtc.port);
+
+	return 0;
+}
+
+static const struct of_device_id de2_lcd_ids[] = {
+	{ .compatible = "allwinner,sun8i-h3-lcd", },
+	{ }
+};
+
+struct platform_driver de2_lcd_platform_driver = {
+	.probe = de2_lcd_probe,
+	.remove = de2_lcd_remove,
+	.driver = {
+		.name = "sun8i-h3-lcd",
+		.of_match_table = of_match_ptr(de2_lcd_ids),
+	},
+};
diff --git a/drivers/gpu/drm/sunxi/de2_crtc.h b/drivers/gpu/drm/sunxi/de2_crtc.h
new file mode 100644
index 0000000..789bd6e
--- /dev/null
+++ b/drivers/gpu/drm/sunxi/de2_crtc.h
@@ -0,0 +1,61 @@
+#ifndef __DE2_CRTC_H__
+#define __DE2_CRTC_H__
+/*
+ * Copyright (C) 2016 Jean-Fran??ois Moine
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ */
+
+#include <linux/clk.h>
+#include <linux/reset.h>
+#include <drm/drm_plane_helper.h>
+
+struct priv;
+
+enum de2_plane2 {
+	DE2_PRIMARY_PLANE,
+	DE2_CURSOR_PLANE,
+	DE2_N_PLANES,
+};
+struct lcd {
+	void __iomem *mmio;
+
+	struct device *dev;
+	struct drm_crtc crtc;
+	struct priv *priv;	/* DRM/DE private data */
+
+	int num;		/* LCD index 0/1 */
+
+	struct clk *clk;
+	struct clk *gate;
+	struct reset_control *rstc;
+
+	char name[16];
+
+	struct drm_pending_vblank_event *event;
+
+	struct drm_plane planes[DE2_N_PLANES];
+};
+
+#define crtc_to_lcd(x) container_of(x, struct lcd, crtc)
+
+/* in de2_de.c */
+void de2_de_enable(struct priv *priv, int lcd_num);
+void de2_de_disable(struct priv *priv, int lcd_num);
+void de2_de_hw_init(struct priv *priv, int lcd_num);
+void de2_de_panel_init(struct priv *priv, int lcd_num,
+			struct drm_display_mode *mode);
+void de2_de_plane_disable(struct priv *priv,
+			int lcd_num, int plane_ix);
+void de2_de_plane_update(struct priv *priv,
+			int lcd_num, int plane_ix,
+			struct drm_plane_state *state,
+			struct drm_plane_state *old_state);
+
+/* in de2_plane.c */
+int de2_plane_init(struct drm_device *drm, struct lcd *lcd);
+
+#endif /* __DE2_CRTC_H__ */
diff --git a/drivers/gpu/drm/sunxi/de2_de.c b/drivers/gpu/drm/sunxi/de2_de.c
new file mode 100644
index 0000000..9469b11
--- /dev/null
+++ b/drivers/gpu/drm/sunxi/de2_de.c
@@ -0,0 +1,505 @@
+/*
+ * ALLWINNER DRM driver - Display Engine 2
+ *
+ * Copyright (C) 2016 Jean-Francois Moine <moinejf@free.fr>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ */
+
+#include <asm/io.h>
+#include <drm/drm_gem_cma_helper.h>
+
+#include "de2_drm.h"
+#include "de2_crtc.h"
+
+static DEFINE_SPINLOCK(de_lock);
+
+/* I/O map */
+
+#define DE_MOD_REG 0x0000	/* 1 bit per LCD */
+#define DE_GATE_REG 0x0004
+#define DE_RESET_REG 0x0008
+#define DE_DIV_REG 0x000c	/* 4 bits per LCD */
+#define DE_SEL_REG 0x0010
+
+#define DE_MUX0_BASE 0x00100000
+#define DE_MUX1_BASE 0x00200000
+
+/* MUX registers (addr / MUX base) */
+#define DE_MUX_GLB_REGS 0x00000		/* global control */
+#define DE_MUX_BLD_REGS 0x01000		/* alpha blending */
+#define DE_MUX_CHAN_REGS 0x02000	/* VI/UI overlay channels */
+#define		DE_MUX_CHAN_SZ 0x1000	/* size of a channel */
+#define DE_MUX_VSU_REGS 0x20000		/* VSU */
+#define DE_MUX_GSU1_REGS 0x40000	/* GSUs */
+#define DE_MUX_GSU2_REGS 0x60000
+#define DE_MUX_GSU3_REGS 0x80000
+#define DE_MUX_FCE_REGS 0xa0000		/* FCE */
+#define DE_MUX_BWS_REGS 0xa2000		/* BWS */
+#define DE_MUX_LTI_REGS 0xa4000		/* LTI */
+#define DE_MUX_PEAK_REGS 0xa6000	/* PEAK */
+#define DE_MUX_ASE_REGS 0xa8000		/* ASE */
+#define DE_MUX_FCC_REGS 0xaa000		/* FCC */
+#define DE_MUX_DCSC_REGS 0xb0000	/* DCSC */
+
+/* global control */
+struct de_glb {
+	u32 ctl;
+#define		DE_MUX_GLB_CTL_rt_en BIT(0)
+#define		DE_MUX_GLB_CTL_finish_irq_en BIT(4)
+#define		DE_MUX_GLB_CTL_rtwb_port BIT(12)
+	u32 status;
+	u32 dbuff;
+	u32 size;
+};
+
+/* alpha blending */
+struct de_bld {
+	u32 fcolor_ctl;			/* 00 */
+	struct {
+		u32 fcolor;
+		u32 insize;
+		u32 offset;
+		u32 dum;
+	} attr[4];
+	u32 dum0[15];			/* (end of clear offset) */
+	u32 route;			/* 80 */
+	u32 premultiply;
+	u32 bkcolor;
+	u32 output_size;
+	u32 bld_mode[4];
+	u32 dum1[4];
+	u32 ck_ctl;			/* b0 */
+	u32 ck_cfg;
+	u32 dum2[2];
+	u32 ck_max[4];
+	u32 dum3[4];
+	u32 ck_min[4];
+	u32 dum4[3];
+	u32 out_ctl;			/* fc */
+};
+
+/* VI channel */
+struct de_vi {
+	struct {
+		u32 attr;
+#define			VI_CFG_ATTR_en BIT(0)
+#define			VI_CFG_ATTR_fcolor_en BIT(4)
+#define			VI_CFG_ATTR_fmt_SHIFT 8
+#define			VI_CFG_ATTR_fmt_MASK GENMASK(12, 8)
+#define			VI_CFG_ATTR_ui_sel BIT(15)
+#define			VI_CFG_ATTR_top_down BIT(23)
+		u32 size;
+		u32 coord;
+		u32 pitch[3];
+		u32 top_laddr[3];
+		u32 bot_laddr[3];
+	} cfg[4];
+	u32 fcolor[4];			/* c0 */
+	u32 top_haddr[3];		/* d0 */
+	u32 bot_haddr[3];		/* dc */
+	u32 ovl_size[2];		/* e8 */
+	u32 hori[2];			/* f0 */
+	u32 vert[2];			/* f8 */
+};
+
+/* UI channel */
+struct de_ui {
+	struct {
+		u32 attr;
+#define			UI_CFG_ATTR_en BIT(0)
+#define			UI_CFG_ATTR_alpmod_SHIFT 1
+#define			UI_CFG_ATTR_alpmod_MASK GENMASK(2, 1)
+#define			UI_CFG_ATTR_fcolor_en BIT(4)
+#define			UI_CFG_ATTR_fmt_SHIFT 8
+#define			UI_CFG_ATTR_fmt_MASK GENMASK(12, 8)
+#define			UI_CFG_ATTR_top_down BIT(23)
+#define			UI_CFG_ATTR_alpha_SHIFT 24
+#define			UI_CFG_ATTR_alpha_MASK GENMASK(31, 24)
+		u32 size;
+		u32 coord;
+		u32 pitch;
+		u32 top_laddr;
+		u32 bot_laddr;
+		u32 fcolor;
+		u32 dum;
+	} cfg[4];			/* 00 */
+	u32 top_haddr;			/* 80 */
+	u32 bot_haddr;
+	u32 ovl_size;			/* 88 */
+};
+
+#define DE_CORE_CLK_RATE 432000000
+
+/* coordinates and sizes */
+#define XY(x, y) (((y) << 16) | (x))
+#define WH(w, h) (((h - 1) << 16) | (w - 1))
+
+/* UI video formats */
+#define DE2_FORMAT_ARGB_8888 0
+#define DE2_FORMAT_XRGB_8888 4
+#define DE2_FORMAT_RGB_888 8
+#define DE2_FORMAT_BGR_888 9
+
+#define glb_read(base, member) \
+	readl_relaxed(base + offsetof(struct de_glb, member))
+#define glb_write(base, member, data) \
+	writel_relaxed(data, base + offsetof(struct de_glb, member))
+#define bld_read(base, member) \
+	readl_relaxed(base + offsetof(struct de_bld, member))
+#define bld_write(base, member, data) \
+	writel_relaxed(data, base + offsetof(struct de_bld, member))
+#define ui_read(base, member) \
+	readl_relaxed(base + offsetof(struct de_ui, member))
+#define ui_write(base, member, data) \
+	writel_relaxed(data, base + offsetof(struct de_ui, member))
+#define vi_read(base, member) \
+	readl_relaxed(base + offsetof(struct de_vi, member))
+#define vi_write(base, member, data) \
+	writel_relaxed(data, base + offsetof(struct de_vi, member))
+
+static const struct {
+	char chan;
+	char layer;
+} plane2layer[DE2_N_PLANES] = {
+	[DE2_PRIMARY_PLANE] = {.chan = 1, .layer = 0,},
+	[DE2_CURSOR_PLANE] = {.chan = 2, .layer = 0,},
+};
+
+static inline void de_write(struct priv *priv, int reg, u32 data)
+{
+	writel_relaxed(data, priv->mmio + reg);
+}
+
+static inline u32 de_read(struct priv *priv, int reg)
+{
+	return readl_relaxed(priv->mmio + reg);
+}
+
+static void de_lcd_select(struct priv *priv,
+			int lcd_num,
+			void __iomem *mux_o)
+{
+	u32 data;
+
+	/* select the LCD */
+	data = de_read(priv, DE_SEL_REG);
+	if (lcd_num == 0)
+		data &= ~1;
+	else
+		data |= 1;
+	de_write(priv, DE_SEL_REG, data);
+
+	/* double register switch */
+	glb_write(mux_o + DE_MUX_GLB_REGS, dbuff, 1);
+}
+
+void de2_de_plane_update(struct priv *priv,
+			int lcd_num, int plane_ix,
+			struct drm_plane_state *state,
+			struct drm_plane_state *old_state)
+{
+	struct drm_framebuffer *fb = state->fb;
+	struct drm_gem_cma_object *gem;
+	void __iomem *mux_o = priv->mmio;
+	void __iomem *chan_o;
+	u32 size = WH(state->crtc_w, state->crtc_h);
+	u32 coord = XY(state->crtc_x, state->crtc_y);
+	u32 screen_size;
+	u32 data;
+	int chan, layer;
+	unsigned fmt, alpha_glob;
+	unsigned long flags;
+
+	mux_o += (lcd_num == 0) ? DE_MUX0_BASE : DE_MUX1_BASE;
+
+	chan = plane2layer[plane_ix].chan;
+	layer = plane2layer[plane_ix].layer;
+
+	chan_o = mux_o;
+	chan_o += DE_MUX_CHAN_REGS + DE_MUX_CHAN_SZ * chan;
+
+	if (fb == old_state->fb
+	 && ui_read(chan_o, cfg[layer].attr) != 0) {
+		spin_lock_irqsave(&de_lock, flags);
+		de_lcd_select(priv, lcd_num, mux_o);
+		ui_write(chan_o, cfg[layer].coord, coord);
+		spin_unlock_irqrestore(&de_lock, flags);
+		return;
+	}
+
+	gem = drm_fb_cma_get_gem_obj(fb, 0);
+
+	alpha_glob = 0;
+	switch (fb->pixel_format) {
+	case DRM_FORMAT_ARGB8888:
+		fmt = DE2_FORMAT_ARGB_8888;
+		break;
+	case DRM_FORMAT_XRGB8888:
+		fmt = DE2_FORMAT_XRGB_8888;
+		alpha_glob = 1;
+		break;
+	case DRM_FORMAT_RGB888:
+		fmt = DE2_FORMAT_RGB_888;
+		break;
+	case DRM_FORMAT_BGR888:
+		fmt = DE2_FORMAT_BGR_888;
+		break;
+	default:
+		pr_err("format %.4s not yet treated\n",
+			(char *) &fb->pixel_format);
+		return;
+	}
+
+	spin_lock_irqsave(&de_lock, flags);
+
+	if (plane_ix == DE2_PRIMARY_PLANE)
+		screen_size = size;
+	else
+		screen_size = glb_read(mux_o + DE_MUX_GLB_REGS, size);
+
+	de_lcd_select(priv, lcd_num, mux_o);
+
+	data = UI_CFG_ATTR_en |
+			(fmt << UI_CFG_ATTR_fmt_SHIFT);
+	if (alpha_glob)
+		data |= (1 << UI_CFG_ATTR_alpmod_SHIFT) |
+			(0xff << UI_CFG_ATTR_alpha_SHIFT);
+	ui_write(chan_o, cfg[layer].attr, data);
+	ui_write(chan_o, cfg[layer].size, size);
+	ui_write(chan_o, cfg[layer].coord, coord);
+	ui_write(chan_o, cfg[layer].pitch, fb->pitches[0]);
+	ui_write(chan_o, cfg[layer].top_laddr,
+			gem->paddr + fb->offsets[0]);
+	ui_write(chan_o, ovl_size, screen_size);
+
+	if (plane_ix == DE2_PRIMARY_PLANE)
+		bld_write(mux_o + DE_MUX_BLD_REGS,
+					fcolor_ctl, 0x0101);
+	else
+		bld_write(mux_o + DE_MUX_BLD_REGS,
+					fcolor_ctl, 0x0301);
+
+	spin_unlock_irqrestore(&de_lock, flags);
+}
+
+void de2_de_plane_disable(struct priv *priv,
+			int lcd_num, int plane_ix)
+{
+	void __iomem *mux_o = priv->mmio;
+	void __iomem *chan_o;
+	int chan, layer;
+	unsigned long flags;
+
+	chan = plane2layer[plane_ix].chan;
+	layer = plane2layer[plane_ix].layer;
+
+	mux_o += (lcd_num == 0) ? DE_MUX0_BASE : DE_MUX1_BASE;
+	chan_o = mux_o + DE_MUX_CHAN_REGS + DE_MUX_CHAN_SZ * chan;
+
+	spin_lock_irqsave(&de_lock, flags);
+
+	de_lcd_select(priv, lcd_num, mux_o);
+
+	ui_write(chan_o, cfg[layer].attr, 0);
+	bld_write(mux_o + DE_MUX_BLD_REGS, fcolor_ctl, 0x0101);
+
+	spin_unlock_irqrestore(&de_lock, flags);
+}
+
+void de2_de_panel_init(struct priv *priv, int lcd_num,
+			struct drm_display_mode *mode)
+{
+	void __iomem *mux_o = priv->mmio;
+	u32 size = WH(mode->hdisplay, mode->vdisplay);
+	unsigned i;
+	unsigned long flags;
+
+	mux_o += (lcd_num == 0) ? DE_MUX0_BASE : DE_MUX1_BASE;
+
+	DRM_DEBUG_DRIVER("%dx%d\n", mode->hdisplay, mode->vdisplay);
+
+	spin_lock_irqsave(&de_lock, flags);
+
+	de_lcd_select(priv, lcd_num, mux_o);
+
+	glb_write(mux_o + DE_MUX_GLB_REGS, size, size);
+
+	/* set alpha blending */
+	for (i = 0; i < 4; i++)
+		bld_write(mux_o + DE_MUX_BLD_REGS, attr[i].insize, size);
+	bld_write(mux_o + DE_MUX_BLD_REGS, output_size, size);
+	bld_write(mux_o + DE_MUX_BLD_REGS, out_ctl,
+			mode->flags & DRM_MODE_FLAG_INTERLACE ? 2 : 0);
+
+	spin_unlock_irqrestore(&de_lock, flags);
+}
+
+void de2_de_enable(struct priv *priv, int lcd_num)
+{
+	void __iomem *mux_o = priv->mmio;
+	unsigned chan;
+	u32 size = WH(1920, 1080);
+	u32 data;
+	unsigned long flags;
+
+	DRM_DEBUG_DRIVER("\n");
+
+	data = 1 << lcd_num;			/* 1 bit / lcd */
+	de_write(priv, DE_RESET_REG,
+			de_read(priv, DE_RESET_REG) | data);
+	de_write(priv, DE_GATE_REG,
+			de_read(priv, DE_GATE_REG) | data);
+	de_write(priv, DE_MOD_REG,
+			de_read(priv, DE_MOD_REG) | data);
+
+	mux_o += (lcd_num == 0) ? DE_MUX0_BASE : DE_MUX1_BASE;
+
+	DRM_DEBUG_DRIVER("\n");
+
+	spin_lock_irqsave(&de_lock, flags);
+
+	/* select the LCD */
+	data = de_read(priv, DE_SEL_REG);
+	if (lcd_num == 0)
+		data &= ~1;
+	else
+		data |= 1;
+	de_write(priv, DE_SEL_REG, data);
+
+	/* start init */
+	glb_write(mux_o + DE_MUX_GLB_REGS, ctl,
+		DE_MUX_GLB_CTL_rt_en | DE_MUX_GLB_CTL_rtwb_port);
+	glb_write(mux_o + DE_MUX_GLB_REGS, status, 0);
+	glb_write(mux_o + DE_MUX_GLB_REGS, dbuff, 1);	/* dble reg switch */
+	glb_write(mux_o + DE_MUX_GLB_REGS, size, size);
+
+	/* clear the VI/UI channels */
+	for (chan = 0; chan < 4; chan++) {
+		void __iomem *chan_o = mux_o + DE_MUX_CHAN_REGS +
+				DE_MUX_CHAN_SZ * chan;
+
+		if (chan == 0)
+			memset_io(chan_o, 0, sizeof(struct de_vi));
+		else
+			memset_io(chan_o, 0, sizeof(struct de_ui));
+		if (chan == 2 && lcd_num != 0)
+			break;		/* lcd1 only 1 VI and 1 UI */
+	}
+
+	/* clear and set alpha blending */
+	memset_io(mux_o + DE_MUX_BLD_REGS, 0, offsetof(struct de_bld, dum0));
+	bld_write(mux_o + DE_MUX_BLD_REGS, fcolor_ctl, 0x00000101);
+						/* fcolor for primary */
+	bld_write(mux_o + DE_MUX_BLD_REGS, route, 0x0021);
+					/* prepare route primary and cursor */
+	bld_write(mux_o + DE_MUX_BLD_REGS, premultiply, 0);
+	bld_write(mux_o + DE_MUX_BLD_REGS, bkcolor, 0xff000000);
+	bld_write(mux_o + DE_MUX_BLD_REGS, bld_mode[0], 0x03010301);
+								/* SRCOVER */
+	bld_write(mux_o + DE_MUX_BLD_REGS, bld_mode[1], 0x03010301);
+	bld_write(mux_o + DE_MUX_BLD_REGS, bld_mode[2], 0x03010301);
+	bld_write(mux_o + DE_MUX_BLD_REGS, out_ctl, 0);
+
+	/* disable the enhancements */
+	writel_relaxed(0, mux_o + DE_MUX_VSU_REGS);
+	writel_relaxed(0, mux_o + DE_MUX_GSU1_REGS);
+	writel_relaxed(0, mux_o + DE_MUX_GSU2_REGS);
+	writel_relaxed(0, mux_o + DE_MUX_GSU3_REGS);
+	writel_relaxed(0, mux_o + DE_MUX_FCE_REGS);
+	writel_relaxed(0, mux_o + DE_MUX_BWS_REGS);
+	writel_relaxed(0, mux_o + DE_MUX_LTI_REGS);
+	writel_relaxed(0, mux_o + DE_MUX_PEAK_REGS);
+	writel_relaxed(0, mux_o + DE_MUX_ASE_REGS);
+	writel_relaxed(0, mux_o + DE_MUX_FCC_REGS);
+	writel_relaxed(0, mux_o + DE_MUX_DCSC_REGS);
+
+	spin_unlock_irqrestore(&de_lock, flags);
+}
+
+void de2_de_disable(struct priv *priv, int lcd_num)
+{
+	u32 data;
+
+	data = ~(1 << lcd_num);
+	de_write(priv, DE_MOD_REG,
+			de_read(priv, DE_MOD_REG) & data);
+	de_write(priv, DE_GATE_REG,
+			de_read(priv, DE_GATE_REG) & data);
+	de_write(priv, DE_RESET_REG,
+			de_read(priv, DE_RESET_REG) & data);
+}
+
+int de2_de_init(struct priv *priv, struct device *dev)
+{
+	struct resource *res;
+	int ret;
+
+	DRM_DEBUG_DRIVER("\n");
+
+	res = platform_get_resource(to_platform_device(dev),
+				IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(dev, "failed to get memory resource\n");
+		return -EINVAL;
+	}
+
+	priv->mmio = devm_ioremap_resource(dev, res);
+	if (IS_ERR(priv->mmio)) {
+		dev_err(dev, "failed to map registers\n");
+		return PTR_ERR(priv->mmio);
+	}
+
+	priv->gate = devm_clk_get(dev, "gate");
+	if (IS_ERR(priv->gate)) {
+		dev_err(dev, "gate clock err %d\n", (int) PTR_ERR(priv->gate));
+		return PTR_ERR(priv->gate);
+	}
+
+	priv->clk = devm_clk_get(dev, "clock");
+	if (IS_ERR(priv->clk)) {
+		dev_err(dev, "video clock err %d\n", (int) PTR_ERR(priv->clk));
+		return PTR_ERR(priv->clk);
+	}
+
+	priv->rstc = devm_reset_control_get(dev, NULL);
+	if (IS_ERR(priv->rstc)) {
+		dev_err(dev, "reset controller err %d\n",
+				(int) PTR_ERR(priv->rstc));
+		return PTR_ERR(priv->rstc);
+	}
+
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		return ret;
+	ret = clk_prepare_enable(priv->gate);
+	if (ret)
+		goto err_gate;
+
+	/* the DE has a fixed clock rate */
+	clk_set_rate(priv->clk, DE_CORE_CLK_RATE);
+
+	ret = reset_control_deassert(priv->rstc);
+	if (ret) {
+		dev_err(dev, "reset deassert err %d\n", ret);
+		goto err_reset;
+	}
+
+	return 0;
+
+err_reset:
+	clk_disable_unprepare(priv->gate);
+err_gate:
+	clk_disable_unprepare(priv->clk);
+	return ret;
+}
+
+void de2_de_cleanup(struct priv *priv)
+{
+	reset_control_assert(priv->rstc);
+	clk_disable_unprepare(priv->gate);
+	clk_disable_unprepare(priv->clk);
+}
diff --git a/drivers/gpu/drm/sunxi/de2_drm.h b/drivers/gpu/drm/sunxi/de2_drm.h
new file mode 100644
index 0000000..1e6cf6d
--- /dev/null
+++ b/drivers/gpu/drm/sunxi/de2_drm.h
@@ -0,0 +1,40 @@
+#ifndef __DE2_DRM_H__
+#define __DE2_DRM_H__
+/*
+ * Copyright (C) 2016 Jean-Fran??ois Moine
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ */
+
+#include <linux/clk.h>
+#include <linux/reset.h>
+#include <drm/drmP.h>
+#include <drm/drm_fb_cma_helper.h>
+
+struct lcd;
+
+#define N_LCDS 2
+struct priv {
+	void __iomem *mmio;
+	struct clk *clk;
+	struct clk *gate;
+	struct reset_control *rstc;
+
+	struct drm_fbdev_cma *fbdev;
+
+	struct lcd *lcds[N_LCDS];
+};
+
+/* in de2_crtc.c */
+int de2_enable_vblank(struct drm_device *drm, unsigned crtc);
+void de2_disable_vblank(struct drm_device *drm, unsigned crtc);
+extern struct platform_driver de2_lcd_platform_driver;
+
+/* in de2_de.c */
+int de2_de_init(struct priv *priv, struct device *dev);
+void de2_de_cleanup(struct priv *priv);
+
+#endif /* __DE2_DRM_H__ */
diff --git a/drivers/gpu/drm/sunxi/de2_drv.c b/drivers/gpu/drm/sunxi/de2_drv.c
new file mode 100644
index 0000000..bfb9100
--- /dev/null
+++ b/drivers/gpu/drm/sunxi/de2_drv.c
@@ -0,0 +1,377 @@
+/*
+ * Allwinner DRM driver - DE2 DRM driver
+ *
+ * Copyright (C) 2016 Jean-Francois Moine <moinejf@free.fr>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/pm.h>
+#include <linux/pm_runtime.h>
+#include <linux/of_graph.h>
+#include <linux/component.h>
+#include <drm/drm_of.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_gem_cma_helper.h>
+
+#include "de2_drm.h"
+
+#define DRIVER_NAME	"sunxi-de2"
+#define DRIVER_DESC	"Allwinner DRM DE2"
+#define DRIVER_DATE	"20160201"
+#define DRIVER_MAJOR	1
+#define DRIVER_MINOR	0
+
+static void de2_fb_output_poll_changed(struct drm_device *drm)
+{
+	struct priv *priv = drm->dev_private;
+
+	if (priv->fbdev)
+		drm_fbdev_cma_hotplug_event(priv->fbdev);
+}
+
+static const struct drm_mode_config_funcs de2_mode_config_funcs = {
+	.fb_create = drm_fb_cma_create,
+	.output_poll_changed = de2_fb_output_poll_changed,
+	.atomic_check = drm_atomic_helper_check,
+	.atomic_commit = drm_atomic_helper_commit,
+};
+
+/*
+ * DRM operations:
+ */
+static void de2_lastclose(struct drm_device *drm)
+{
+	struct priv *priv = drm->dev_private;
+
+	if (priv->fbdev)
+		drm_fbdev_cma_restore_mode(priv->fbdev);
+}
+
+static const struct file_operations de2_fops = {
+	.owner		= THIS_MODULE,
+	.open		= drm_open,
+	.release	= drm_release,
+	.unlocked_ioctl	= drm_ioctl,
+	.poll		= drm_poll,
+	.read		= drm_read,
+	.llseek		= no_llseek,
+	.mmap		= drm_gem_cma_mmap,
+};
+
+static struct drm_driver de2_drm_driver = {
+	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_PRIME |
+					DRIVER_ATOMIC,
+	.lastclose		= de2_lastclose,
+	.get_vblank_counter	= drm_vblank_no_hw_counter,
+	.enable_vblank		= de2_enable_vblank,
+	.disable_vblank		= de2_disable_vblank,
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
+	.fops			= &de2_fops,
+	.name			= DRIVER_NAME,
+	.desc			= DRIVER_DESC,
+	.date			= DRIVER_DATE,
+	.major			= DRIVER_MAJOR,
+	.minor			= DRIVER_MINOR,
+};
+
+#ifdef CONFIG_PM_SLEEP
+/*
+ * Power management
+ */
+static int de2_pm_suspend(struct device *dev)
+{
+	struct drm_device *drm = dev_get_drvdata(dev);
+
+	drm_kms_helper_poll_disable(drm);
+	return 0;
+}
+
+static int de2_pm_resume(struct device *dev)
+{
+	struct drm_device *drm = dev_get_drvdata(dev);
+
+	drm_kms_helper_poll_enable(drm);
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops de2_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(de2_pm_suspend, de2_pm_resume)
+};
+
+/*
+ * Platform driver
+ */
+
+static int de2_drm_bind(struct device *dev)
+{
+	struct drm_device *drm;
+	struct priv *priv;
+	int ret;
+
+	DRM_DEBUG_DRIVER("\n");
+
+	drm = drm_dev_alloc(&de2_drm_driver, dev);
+	if (!drm)
+		return -ENOMEM;
+
+	ret = drm_dev_set_unique(drm, dev_name(dev));
+	if (ret < 0)
+		goto out1;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		dev_err(dev, "failed to allocate private area\n");
+		ret = -ENOMEM;
+		goto out1;
+	}
+
+	dev_set_drvdata(dev, drm);
+	drm->dev_private = priv;
+
+	drm_mode_config_init(drm);
+	drm->mode_config.min_width = 32;	/* needed for cursor */
+	drm->mode_config.min_height = 32;
+	drm->mode_config.max_width = 1920;
+	drm->mode_config.max_height = 1080;
+	drm->mode_config.funcs = &de2_mode_config_funcs;
+
+	ret = drm_dev_register(drm, 0);
+	if (ret < 0)
+		goto out2;
+
+	/* initialize the display engine */
+	ret = de2_de_init(priv, dev);
+	if (ret)
+		goto out3;
+
+	/* start the subdevices */
+	ret = component_bind_all(dev, drm);
+	if (ret < 0)
+		goto out3;
+
+	DRM_DEBUG_DRIVER("%d crtcs %d connectors\n",
+			 drm->mode_config.num_crtc,
+			 drm->mode_config.num_connector);
+
+	ret = drm_vblank_init(drm, drm->mode_config.num_crtc);
+	if (ret < 0)
+		dev_warn(dev, "failed to initialize vblank\n");
+
+	drm_mode_config_reset(drm);
+
+	priv->fbdev = drm_fbdev_cma_init(drm,
+					32,	/* bpp */
+					drm->mode_config.num_crtc,
+					drm->mode_config.num_connector);
+	if (IS_ERR(priv->fbdev)) {
+		ret = PTR_ERR(priv->fbdev);
+		priv->fbdev = NULL;
+		goto out4;
+	}
+
+	drm_kms_helper_poll_init(drm);
+
+	return 0;
+
+out4:
+	component_unbind_all(dev, drm);
+out3:
+	drm_dev_unregister(drm);
+out2:
+	kfree(priv);
+out1:
+	drm_dev_unref(drm);
+	return ret;
+}
+
+static void de2_drm_unbind(struct device *dev)
+{
+	struct drm_device *drm = dev_get_drvdata(dev);
+	struct priv *priv = drm->dev_private;
+
+	if (priv)
+		drm_fbdev_cma_fini(priv->fbdev);
+
+	drm_kms_helper_poll_fini(drm);
+
+	component_unbind_all(dev, drm);
+
+	drm_dev_unregister(drm);
+
+	drm_mode_config_cleanup(drm);
+
+	if (priv) {
+		de2_de_cleanup(priv);
+		kfree(priv);
+	}
+
+	drm_dev_unref(drm);
+}
+
+static const struct component_master_ops de2_drm_comp_ops = {
+	.bind = de2_drm_bind,
+	.unbind = de2_drm_unbind,
+};
+
+static int compare_of(struct device *dev, void *data)
+{
+	return dev->of_node == data;
+}
+
+static int de2_drm_add_components(struct device *dev,
+				  int (*compare_of)(struct device *, void *),
+				  const struct component_master_ops *m_ops)
+{
+	struct device_node *ep, *port, *remote;
+	struct component_match *match = NULL;
+	int i;
+
+	if (!dev->of_node)
+		return -EINVAL;
+
+	/* bind the CRTCs */
+	for (i = 0; ; i++) {
+		port = of_parse_phandle(dev->of_node, "ports", i);
+		if (!port)
+			break;
+
+		if (!of_device_is_available(port->parent)) {
+			of_node_put(port);
+			continue;
+		}
+
+		component_match_add(dev, &match, compare_of, port->parent);
+		of_node_put(port);
+	}
+
+	if (i == 0) {
+		dev_err(dev, "missing 'ports' property\n");
+		return -ENODEV;
+	}
+	if (!match) {
+		dev_err(dev, "no available port\n");
+		return -ENODEV;
+	}
+
+	/* bind the encoders/connectors */
+	for (i = 0; ; i++) {
+		port = of_parse_phandle(dev->of_node, "ports", i);
+		if (!port)
+			break;
+
+		if (!of_device_is_available(port->parent)) {
+			of_node_put(port);
+			continue;
+		}
+
+		for_each_child_of_node(port, ep) {
+			remote = of_graph_get_remote_port_parent(ep);
+			if (!remote || !of_device_is_available(remote)) {
+				of_node_put(remote);
+				continue;
+			}
+			if (!of_device_is_available(remote->parent)) {
+				dev_warn(dev,
+					 "parent device of %s is not available\n",
+					 remote->full_name);
+				of_node_put(remote);
+				continue;
+			}
+
+			component_match_add(dev, &match, compare_of, remote);
+			of_node_put(remote);
+		}
+		of_node_put(port);
+	}
+
+	return component_master_add_with_match(dev, m_ops, match);
+}
+
+static int de2_drm_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	ret = de2_drm_add_components(&pdev->dev,
+				     compare_of,
+				     &de2_drm_comp_ops);
+	if (ret == -EINVAL)
+		ret = -ENXIO;
+	return ret;
+}
+
+static int de2_drm_remove(struct platform_device *pdev)
+{
+	component_master_del(&pdev->dev, &de2_drm_comp_ops);
+
+	return 0;
+}
+
+static struct of_device_id de2_drm_of_match[] = {
+	{ .compatible = "allwinner,sun8i-h3-display-engine" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, de2_drm_of_match);
+
+static struct platform_driver de2_drm_platform_driver = {
+	.probe      = de2_drm_probe,
+	.remove     = de2_drm_remove,
+	.driver     = {
+		.name = "sun8i-h3-display-engine",
+		.pm = &de2_pm_ops,
+		.of_match_table = de2_drm_of_match,
+	},
+};
+
+static int __init de2_drm_init(void)
+{
+	int ret;
+
+/* uncomment to activate the drm traces at startup time */
+/*	drm_debug = DRM_UT_CORE | DRM_UT_DRIVER | DRM_UT_KMS |
+			DRM_UT_PRIME | DRM_UT_ATOMIC; */
+
+	DRM_DEBUG_DRIVER("\n");
+
+	ret = platform_driver_register(&de2_lcd_platform_driver);
+	if (ret < 0)
+		return ret;
+
+	ret = platform_driver_register(&de2_drm_platform_driver);
+	if (ret < 0)
+		platform_driver_unregister(&de2_lcd_platform_driver);
+
+	return ret;
+}
+
+static void __exit de2_drm_fini(void)
+{
+	platform_driver_unregister(&de2_lcd_platform_driver);
+	platform_driver_unregister(&de2_drm_platform_driver);
+}
+
+module_init(de2_drm_init);
+module_exit(de2_drm_fini);
+
+MODULE_AUTHOR("Jean-Francois Moine <moinejf@free.fr>");
+MODULE_DESCRIPTION("Allwinner DE2 DRM Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/sunxi/de2_plane.c b/drivers/gpu/drm/sunxi/de2_plane.c
new file mode 100644
index 0000000..ae3e13f
--- /dev/null
+++ b/drivers/gpu/drm/sunxi/de2_plane.c
@@ -0,0 +1,91 @@
+/*
+ * Allwinner DRM driver - DE2 planes
+ *
+ * Copyright (C) 2016 Jean-Francois Moine <moinejf@free.fr>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ */
+
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_plane_helper.h>
+#include <drm/drm_crtc_helper.h>
+
+#include "de2_drm.h"
+#include "de2_crtc.h"
+
+/* plane formats */
+static const uint32_t ui_formats[] = {
+	DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_RGB888,
+	DRM_FORMAT_BGR888,
+};
+
+static void de2_plane_disable(struct drm_plane *plane,
+				struct drm_plane_state *old_state)
+{
+	struct drm_crtc *crtc = old_state->crtc;
+	struct lcd *lcd = crtc_to_lcd(crtc);
+	int plane_num = plane - lcd->planes;
+
+	de2_de_plane_disable(lcd->priv, lcd->num, plane_num);
+}
+
+static void de2_plane_update(struct drm_plane *plane,
+				struct drm_plane_state *old_state)
+{
+	struct drm_plane_state *state = plane->state;
+	struct drm_crtc *crtc = state->crtc;
+	struct lcd *lcd = crtc_to_lcd(crtc);
+	struct drm_framebuffer *fb = state->fb;
+	int plane_num = plane - lcd->planes;
+
+	if (!crtc || !fb) {
+		DRM_DEBUG_DRIVER("no crtc/fb\n");
+		return;
+	}
+
+	de2_de_plane_update(lcd->priv, lcd->num, plane_num,
+			    state, old_state);
+}
+
+static const struct drm_plane_helper_funcs plane_helper_funcs = {
+	.atomic_disable = de2_plane_disable,
+	.atomic_update = de2_plane_update,
+};
+
+static const struct drm_plane_funcs plane_funcs = {
+	.update_plane = drm_atomic_helper_update_plane,
+	.disable_plane = drm_atomic_helper_disable_plane,
+	.destroy = drm_plane_cleanup,
+	.reset = drm_atomic_helper_plane_reset,
+	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
+};
+
+int de2_plane_init(struct drm_device *drm, struct lcd *lcd)
+{
+	int ret, i;
+
+	for (i = 0; i < ARRAY_SIZE(lcd->planes); i++) {
+		ret = drm_universal_plane_init(drm, &lcd->planes[i], 0,
+					&plane_funcs,
+					ui_formats, ARRAY_SIZE(ui_formats),
+					i == DE2_PRIMARY_PLANE ?
+						DRM_PLANE_TYPE_PRIMARY :
+						DRM_PLANE_TYPE_CURSOR,
+					NULL);
+		if (ret < 0) {
+			dev_err(lcd->dev,
+				"Couldn't initialize plane err %d\n", ret);
+			return ret;
+		}
+		drm_plane_helper_add(&lcd->planes[i],
+				     &plane_helper_funcs);
+	}
+
+	return 0;
+}
-- 
2.7.0
