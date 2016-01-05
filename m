From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 5 Jan 2016 19:40:11 +0100
Subject: [PATCH RFC 2/2] drm: sunxi: Add a basic DRM driver for Allwinner DE2
In-Reply-To: <cover.1452021349.git.moinejf@free.fr>
References: <cover.1452021349.git.moinejf@free.fr>
Message-ID: <58463fd5b674c7eedec4ae05567ee56770a12996.1452021349.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In recent SoCs, as the H3, Allwinner uses a new display interface, DE2.
This patch adds a DRM video driver for this interface,
and also a driver for the HDMI connector found in the H3.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/gpu/drm/Kconfig             |   2 +
 drivers/gpu/drm/Makefile            |   1 +
 drivers/gpu/drm/sunxi/Kconfig       |  21 ++
 drivers/gpu/drm/sunxi/Makefile      |   8 +
 drivers/gpu/drm/sunxi/de2_crtc.c    | 409 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/sunxi/de2_crtc.h    |  42 ++++
 drivers/gpu/drm/sunxi/de2_de.c      | 467 +++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/sunxi/de2_drm.h     |  51 ++++
 drivers/gpu/drm/sunxi/de2_drv.c     | 376 ++++++++++++++++++++++++++++
 drivers/gpu/drm/sunxi/de2_hdmi.c    | 381 ++++++++++++++++++++++++++++
 drivers/gpu/drm/sunxi/de2_hdmi.h    |  34 +++
 drivers/gpu/drm/sunxi/de2_hdmi_h3.c | 478 ++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/sunxi/de2_hdmi_h3.h |  14 ++
 drivers/gpu/drm/sunxi/de2_plane.c   | 102 ++++++++
 14 files changed, 2386 insertions(+)
 create mode 100644 drivers/gpu/drm/sunxi/Kconfig
 create mode 100644 drivers/gpu/drm/sunxi/Makefile
 create mode 100644 drivers/gpu/drm/sunxi/de2_crtc.c
 create mode 100644 drivers/gpu/drm/sunxi/de2_crtc.h
 create mode 100644 drivers/gpu/drm/sunxi/de2_de.c
 create mode 100644 drivers/gpu/drm/sunxi/de2_drm.h
 create mode 100644 drivers/gpu/drm/sunxi/de2_drv.c
 create mode 100644 drivers/gpu/drm/sunxi/de2_hdmi.c
 create mode 100644 drivers/gpu/drm/sunxi/de2_hdmi.h
 create mode 100644 drivers/gpu/drm/sunxi/de2_hdmi_h3.c
 create mode 100644 drivers/gpu/drm/sunxi/de2_hdmi_h3.h
 create mode 100644 drivers/gpu/drm/sunxi/de2_plane.c

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index c4bf9a1..edef0c8 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -266,3 +266,5 @@ source "drivers/gpu/drm/amd/amdkfd/Kconfig"
 source "drivers/gpu/drm/imx/Kconfig"
 
 source "drivers/gpu/drm/vc4/Kconfig"
+
+source "drivers/gpu/drm/sunxi/Kconfig"
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 1e9ff4c..597c246 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -75,3 +75,4 @@ obj-y			+= i2c/
 obj-y			+= panel/
 obj-y			+= bridge/
 obj-$(CONFIG_DRM_FSL_DCU) += fsl-dcu/
+obj-$(CONFIG_DRM_SUNXI) += sunxi/
diff --git a/drivers/gpu/drm/sunxi/Kconfig b/drivers/gpu/drm/sunxi/Kconfig
new file mode 100644
index 0000000..9b4d414
--- /dev/null
+++ b/drivers/gpu/drm/sunxi/Kconfig
@@ -0,0 +1,21 @@
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
+	depends on DRM_SUNXI && MACH_SUN8I
+	select REGMAP_MMIO
+	help
+	  Choose this option if your Allwinner chipset has the DE2 interface
+	  as the H3.
diff --git a/drivers/gpu/drm/sunxi/Makefile b/drivers/gpu/drm/sunxi/Makefile
new file mode 100644
index 0000000..8bb533f
--- /dev/null
+++ b/drivers/gpu/drm/sunxi/Makefile
@@ -0,0 +1,8 @@
+#
+# Makefile for Allwinner's DRM device driver
+#
+
+sunxi-de2-drm-objs := de2_drv.o de2_de.o de2_crtc.o de2_plane.o
+sunxi-de2-hdmi-objs := de2_hdmi.o de2_hdmi_h3.o
+
+obj-$(CONFIG_DRM_SUNXI_DE2) += sunxi-de2-drm.o sunxi-de2-hdmi.o
diff --git a/drivers/gpu/drm/sunxi/de2_crtc.c b/drivers/gpu/drm/sunxi/de2_crtc.c
new file mode 100644
index 0000000..92c20d0
--- /dev/null
+++ b/drivers/gpu/drm/sunxi/de2_crtc.c
@@ -0,0 +1,409 @@
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
+
+#include "de2_drm.h"
+#include "de2_crtc.h"
+
+/* I/O map */
+
+struct tcon {
+	u32 gctl;
+#define		TCON_GCTL_TCON_En 0x80000000
+	u32 gint0;
+#define		TCON_GINT0_TCON1_Vb_Int_En 0x40000000
+#define		TCON_GINT0_TCON1_Vb_Int_Flag 0x00001000
+	u32 gint1;
+	u32 dum0[13];
+	u32 tcon0_ctl;
+#define		TCON0_CTL_TCON_En 0x80000000
+	u32 dum1[19];
+	u32 tcon1_ctl;
+#define		TCON1_CTL_TCON_En 0x80000000
+#define		TCON1_CTL_Interlace_En 0x00100000
+#define		TCON1_CTL_Start_Delay_SHIFT 4
+#define		TCON1_CTL_Start_Delay_MASK 0x000001f0
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
+#define		TCON1_IO_POL_IO0_inv 0x01000000
+#define		TCON1_IO_POL_IO1_inv 0x02000000
+#define		TCON1_IO_POL_IO2_inv 0x04000000
+	u32 io_tri;
+	u32 dum4[2];
+
+	u32 ceu_ctl;			/* 100 */
+#define     TCON_CEU_CTL_ceu_en 0x80000000
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
+#define		TCON_MUX_CTL_HDMI_SRC_MASK 0x00000300
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
+	struct tcon *p_tcon = lcd->mmio;
+	int interlace = mode->flags & DRM_MODE_FLAG_INTERLACE ? 2 : 1;
+	int start_delay;
+	u32 data;
+
+	DRM_DEBUG_DRIVER("\n");
+
+	data = XY(mode->hdisplay - 1, mode->vdisplay / interlace - 1);
+	p_tcon->basic0 = data;
+	p_tcon->basic1 = data;
+	p_tcon->basic2 = data;
+	p_tcon->basic3 = XY(mode->htotal - 1,
+				mode->htotal - mode->hsync_start - 1);
+	p_tcon->basic4 = XY(mode->vtotal * (3 - interlace),
+				mode->vtotal - mode->vsync_start - 1);
+	p_tcon->basic5 = XY(mode->hsync_end - mode->hsync_start - 1,
+				mode->vsync_end - mode->vsync_start - 1);
+
+	p_tcon->ps_sync = XY(1, 1);
+
+	data = TCON1_IO_POL_IO2_inv;
+	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
+		data |= TCON1_IO_POL_IO0_inv;
+	if (mode->flags & DRM_MODE_FLAG_PHSYNC)
+		data |= TCON1_IO_POL_IO1_inv;
+	p_tcon->io_pol = data;
+
+	p_tcon->ceu_ctl &= ~TCON_CEU_CTL_ceu_en;
+
+	if (interlace == 2)
+		p_tcon->tcon1_ctl |= TCON1_CTL_Interlace_En;
+	else
+		p_tcon->tcon1_ctl &= ~TCON1_CTL_Interlace_En;
+
+	p_tcon->fill_ctl = 0;
+	p_tcon->fill_start0 = mode->vtotal + 1;
+	p_tcon->fill_end0 = mode->vtotal;
+	p_tcon->fill_data0 = 0;
+
+	start_delay = (mode->vtotal - mode->vdisplay) / interlace - 5;
+	if (start_delay > 31)
+		start_delay = 31;
+	p_tcon->tcon1_ctl &= ~TCON1_CTL_Start_Delay_MASK;
+	p_tcon->tcon1_ctl |= start_delay << TCON1_CTL_Start_Delay_SHIFT;
+
+	p_tcon->io_tri = 0x0fffffff;
+}
+
+static void de2_crtc_enable(struct drm_crtc *crtc)
+{
+	struct lcd *lcd = crtc_to_lcd(crtc);
+	struct drm_display_mode *mode = &crtc->mode;
+	struct tcon *p_tcon = lcd->mmio;
+
+	DRM_DEBUG_DRIVER("clock %d\n", mode->clock);
+
+	if (mode->clock == 0) {
+		dev_err(lcd->dev, "crtc_start: no clock!\n");
+		return;
+	}
+
+	de2_set_frame_timings(lcd);
+
+	clk_set_rate(lcd->clk, mode->clock * 1000);
+
+	if (lcd->num == 0) {				/* HDMI */
+		p_tcon->mux_ctl &= ~TCON_MUX_CTL_HDMI_SRC_MASK;
+		p_tcon->mux_ctl |= lcd->num << TCON_MUX_CTL_HDMI_SRC_SHIFT;
+	}
+
+	p_tcon->tcon1_ctl |= TCON1_CTL_TCON_En;
+
+	de2_de_enable(lcd->priv, lcd->num);
+
+	if (!lcd->init_done) {
+		lcd->init_done = 1;
+		de2_de_hw_init(lcd->priv, lcd->num);
+	}
+
+	de2_de_panel_init(lcd->priv, lcd->num, mode);
+
+	drm_mode_debug_printmodeline(mode);
+}
+
+static void de2_crtc_disable(struct drm_crtc *crtc)
+{
+	struct lcd *lcd = crtc_to_lcd(crtc);
+	struct tcon *p_tcon = lcd->mmio;
+
+	DRM_DEBUG_DRIVER("\n");
+
+	de2_de_disable(lcd->priv, lcd->num);
+	p_tcon->tcon1_ctl &= ~TCON1_CTL_TCON_En;
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
+static void de2_tcon_init(struct lcd *lcd)
+{
+	struct tcon *p_tcon = lcd->mmio;
+
+	DRM_DEBUG_DRIVER("\n");
+
+	p_tcon->tcon0_ctl &= ~TCON0_CTL_TCON_En;
+	p_tcon->tcon1_ctl &= ~TCON1_CTL_TCON_En;
+	p_tcon->gctl &= ~TCON_GCTL_TCON_En;
+
+	p_tcon->gint0 &= ~(TCON_GINT0_TCON1_Vb_Int_En |
+			TCON_GINT0_TCON1_Vb_Int_Flag);
+
+	p_tcon->gctl |= TCON_GCTL_TCON_En;
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
+					&lcd->planes[0], /* primary plane */
+					NULL,		/* cursor */
+					&de2_crtc_funcs);
+	if (ret < 0)
+		return ret;
+
+	de2_tcon_init(lcd);
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
+	struct tcon *p_tcon = lcd->mmio;
+
+	if (p_tcon)
+		p_tcon->gctl &= ~TCON_GCTL_TCON_En;
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
index 0000000..afddb86
--- /dev/null
+++ b/drivers/gpu/drm/sunxi/de2_crtc.h
@@ -0,0 +1,42 @@
+#ifndef __DE2_CRTC_H__
+#define __DE2_CRTC_H__
+
+/*
+ * Copyright (C) 2015 Jean-Fran??ois Moine
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#include <linux/clk.h>
+#include <linux/reset.h>
+#include <drm/drm_plane_helper.h>
+
+struct priv;
+
+#define N_PLANES 4
+struct lcd {
+	void __iomem *mmio;
+
+	struct device *dev;
+	struct drm_crtc crtc;
+	struct priv *priv;	/* DRM/DE private data */
+
+	short num;		/* LCD index 0/1 */
+	short init_done;
+
+	struct clk *clk;
+	struct clk *gate;
+	struct reset_control *rstc;
+
+	char name[16];
+
+	struct drm_pending_vblank_event *event;
+
+	struct drm_plane planes[N_PLANES];
+};
+
+#define crtc_to_lcd(x) container_of(x, struct lcd, crtc)
+
+#endif /* __DE2_CRTC_H__ */
diff --git a/drivers/gpu/drm/sunxi/de2_de.c b/drivers/gpu/drm/sunxi/de2_de.c
new file mode 100644
index 0000000..92e6e44
--- /dev/null
+++ b/drivers/gpu/drm/sunxi/de2_de.c
@@ -0,0 +1,467 @@
+/*
+ * Allwinner DRM driver - Display Engine 2
+ *
+ * Copyright (C) 2016 Jean-Francois Moine <moinejf@free.fr>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ */
+
+#include "de2_drm.h"
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
+#define		DE_MUX_GLB_CTL_rt_en 0x0000001
+#define		DE_MUX_GLB_CTL_finish_irq_en 0x0000010
+#define		DE_MUX_GLB_CTL_rtwb_port 0x0001000
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
+	} attr[5];
+	u32 dum0[11];
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
+#define			VI_CFG_ATTR_en 0x00000001
+#define			VI_CFG_ATTR_fcolor_en 0x00000010
+#define			VI_CFG_ATTR_fmt_SHIFT 8
+#define			VI_CFG_ATTR_fmt_MASK 0x00001f00
+#define			VI_CFG_ATTR_sel 0x00008000
+#define			VI_CFG_ATTR_top_down 0x00800000
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
+#define			UI_CFG_ATTR_en 0x00000001
+#define			UI_CFG_ATTR_alpmod_SHIFT 1
+#define			UI_CFG_ATTR_alpmod_MASK 0x00000006
+#define			UI_CFG_ATTR_fcolor_en 0x00000010
+#define			UI_CFG_ATTR_fmt_SHIFT 8
+#define			UI_CFG_ATTR_fmt_MASK 0x00001f00
+#define			UI_CFG_ATTR_top_down 0x00800000
+#define			UI_CFG_ATTR_alpha_SHIFT 24
+#define			UI_CFG_ATTR_alpha_MASK 0xff000000
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
+/* BWS */
+struct de_bws {
+	u32 ctl;
+#define			BWS_WIN_en 0x80000000
+	u32 size;
+	u32 win0;
+	u32 win1;
+};
+
+/* all sizes are ((height - 1) << 16) | (width - 1) */
+#define WH(w, h) (((h - 1) << 16) | (w - 1))
+
+#define DE_CORE_CLK_RATE 432000000
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
+void de2_de_enable(struct priv *priv, int lcd_num)
+{
+	u32 data;
+	unsigned long flags;
+
+	DRM_DEBUG_DRIVER("\n");
+
+	spin_lock_irqsave(&de_lock, flags);
+
+	/* enable the DE */
+	data = 1 << lcd_num;				/* 1 bit / lcd */
+	de_write(priv, DE_RESET_REG,
+			de_read(priv, DE_RESET_REG) | data);
+	de_write(priv, DE_GATE_REG,
+			de_read(priv, DE_GATE_REG) | data);
+	de_write(priv, DE_MOD_REG,
+			de_read(priv, DE_MOD_REG) | data);
+
+	spin_unlock_irqrestore(&de_lock, flags);
+}
+
+void de2_de_disable(struct priv *priv, int lcd_num)
+{
+	u32 data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&de_lock, flags);
+
+	data = ~(1 << lcd_num);			/* 1 bit */
+	de_write(priv, DE_MOD_REG,
+			de_read(priv, DE_MOD_REG) & data);
+	de_write(priv, DE_GATE_REG,
+			de_read(priv, DE_GATE_REG) & data);
+	de_write(priv, DE_RESET_REG,
+			de_read(priv, DE_RESET_REG) & data);
+
+	spin_unlock_irqrestore(&de_lock, flags);
+}
+
+/* hardware init of the DE, done once */
+void de2_de_hw_init(struct priv *priv, int lcd_num)
+{
+	int mux_o = (lcd_num == 0) ? DE_MUX0_BASE : DE_MUX1_BASE;
+	int chan;
+	u32 size = WH(1920, 1080);
+	u32 data;
+	unsigned long flags;
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
+	{
+		struct de_glb *p_glb = priv->mmio + mux_o +
+					DE_MUX_GLB_REGS;
+
+		p_glb->ctl = DE_MUX_GLB_CTL_rt_en | DE_MUX_GLB_CTL_rtwb_port;
+		p_glb->status = 0;
+		p_glb->dbuff = 1;	/* double register switch */
+		p_glb->size = size;
+	}
+
+	/* set the VI/UIs channels */
+	for (chan = 0; chan < 4; chan++) {
+		int chan_o = mux_o + DE_MUX_CHAN_REGS +
+				DE_MUX_CHAN_SZ * chan;
+
+		if (chan == 0)
+			memset(priv->mmio + chan_o, 0, sizeof(struct de_vi));
+		else
+			memset(priv->mmio + chan_o, 0, sizeof(struct de_ui));
+		if (chan == 2 && lcd_num != 0)
+			break;		/* lcd1 only 1 VI and 1 UI */
+	}
+
+	/* alpha blending */
+	{
+		struct de_bld *p_bld = priv->mmio + mux_o +
+					DE_MUX_BLD_REGS;
+
+		memset(priv->mmio + mux_o + DE_MUX_BLD_REGS, 0, 0x44);
+		p_bld->out_ctl = 0;
+	}
+
+	/* disable the enhancements */
+	{
+		struct ctl {
+			u32 ctl;
+		} *p;
+
+		p = priv->mmio + mux_o + DE_MUX_VSU_REGS;
+		p->ctl = 0;
+		p = priv->mmio + mux_o + DE_MUX_GSU1_REGS;
+		p->ctl = 0;
+		p = priv->mmio + mux_o + DE_MUX_GSU2_REGS;
+		p->ctl = 0;
+		p = priv->mmio + mux_o + DE_MUX_GSU3_REGS;
+		p->ctl = 0;
+		p = priv->mmio + mux_o + DE_MUX_FCE_REGS;
+		p->ctl = 0;
+		p = priv->mmio + mux_o + DE_MUX_BWS_REGS;
+		p->ctl = 0;
+		p = priv->mmio + mux_o + DE_MUX_LTI_REGS;
+		p->ctl = 0;
+		p = priv->mmio + mux_o + DE_MUX_PEAK_REGS;
+		p->ctl = 0;
+		p = priv->mmio + mux_o + DE_MUX_ASE_REGS;
+		p->ctl = 0;
+		p = priv->mmio + mux_o + DE_MUX_FCC_REGS;
+		p->ctl = 0;
+		p = priv->mmio + mux_o + DE_MUX_DCSC_REGS;
+		p->ctl = 0;
+	}
+
+	spin_unlock_irqrestore(&de_lock, flags);
+}
+
+void de2_de_panel_init(struct priv *priv, int lcd_num,
+			struct drm_display_mode *mode)
+{
+	int mux_o = (lcd_num == 0) ? DE_MUX0_BASE : DE_MUX1_BASE;
+	u32 size = WH(mode->hdisplay, mode->vdisplay);
+	u32 data;
+	unsigned long flags;
+
+	DRM_DEBUG_DRIVER("%dx%d\n", mode->hdisplay, mode->vdisplay);
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
+	{
+		struct de_glb *p_glb = priv->mmio + mux_o +
+					DE_MUX_GLB_REGS;
+
+		p_glb->ctl = DE_MUX_GLB_CTL_rt_en | DE_MUX_GLB_CTL_rtwb_port;
+		p_glb->status = 0;
+		p_glb->dbuff = 1;	/* double register switch */
+		p_glb->size = size;
+	}
+
+	/* alpha blending */
+	{
+		struct de_bld *p_bld = priv->mmio + mux_o +
+					DE_MUX_BLD_REGS;
+
+		p_bld->fcolor_ctl = 0x00000101;
+		p_bld->attr[0].fcolor = 0;
+		p_bld->attr[0].insize = size;
+		p_bld->attr[0].offset = 0;	/* 0, 0 */
+		p_bld->route = 1;
+		p_bld->premultiply = 0;
+		p_bld->bkcolor = 0xff000000;
+		p_bld->output_size = size;
+		p_bld->bld_mode[0] = 0x03010301;	/* SRCOVER */
+		p_bld->bld_mode[1] = 0x03010301;
+		p_bld->bld_mode[2] = 0x03010301;
+		p_bld->out_ctl = 
+			mode->flags & DRM_MODE_FLAG_INTERLACE ? 2 : 0;
+	}
+
+	spin_unlock_irqrestore(&de_lock, flags);
+}
+
+void de2_de_ui_enable(struct priv *priv,
+			int lcd_num, int channel, int layer,
+			dma_addr_t addr, int fmt,
+			int width, int height, int bpp)
+{
+	int mux_o = (lcd_num == 0) ? DE_MUX0_BASE : DE_MUX1_BASE;
+	int chan_o = mux_o + DE_MUX_CHAN_REGS + DE_MUX_CHAN_SZ * channel;
+	u32 pitch = width * bpp / 8;
+	u32 size = WH(width, height);
+	u32 offset = 0;		/* (y << 16) | x */
+	u32 data;
+	unsigned long flags;
+
+	DRM_DEBUG_DRIVER("%d:%d:%d addr: %p\n",
+			lcd_num, channel, layer, (void *) addr);
+
+	switch (fmt) {
+	case DRM_FORMAT_ARGB8888:
+		fmt = 0;	/* DE_FORMAT_ARGB_8888 */
+		break;
+	case DRM_FORMAT_XRGB8888:
+		fmt = 4;	/* DE_FORMAT_XRGB_8888 */
+		break;
+	default:
+		pr_err("format %.4s not yet treated\n", (char *) fmt);
+		return;
+	}
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
+	{
+		struct de_glb *p_glb = priv->mmio + mux_o +
+					DE_MUX_GLB_REGS;
+
+		p_glb->dbuff = 1;	/* double register switch */
+	}
+
+	/* set the UI plane */
+	{
+		struct de_ui *p_ui = priv->mmio + chan_o;
+
+		p_ui->cfg[0].attr = UI_CFG_ATTR_en |
+				(fmt << UI_CFG_ATTR_fmt_SHIFT) |
+				(1 << UI_CFG_ATTR_alpmod_SHIFT) |
+				(0xff << UI_CFG_ATTR_alpha_SHIFT);
+		p_ui->cfg[0].size = size;
+		p_ui->cfg[0].coord = offset;
+		p_ui->cfg[0].pitch = pitch;
+		p_ui->cfg[0].top_laddr = addr;
+		p_ui->ovl_size = size;
+	}
+
+	spin_unlock_irqrestore(&de_lock, flags);
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
+	/* set the clock rate */
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
index 0000000..540ad95
--- /dev/null
+++ b/drivers/gpu/drm/sunxi/de2_drm.h
@@ -0,0 +1,51 @@
+#ifndef __DE2_DRM_H__
+#define __DE2_DRM_H__
+/*
+ * Copyright (C) 2016 Jean-Fran??ois Moine
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
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
+void de2_de_enable(struct priv *priv, int lcd_num);
+void de2_de_disable(struct priv *priv, int lcd_num);
+void de2_de_hw_init(struct priv *priv, int lcd_num);
+void de2_de_panel_init(struct priv *priv, int lcd_num,
+			struct drm_display_mode *mode);
+int de2_de_init(struct priv *priv, struct device *dev);
+void de2_de_cleanup(struct priv *priv);
+void de2_de_ui_enable(struct priv *priv,
+			int lcd_num, int channel,  int layer,
+			dma_addr_t addr, int fmt,
+			int width, int height, int bpp);
+
+/* in de2_plane.c */
+int de2_plane_init(struct drm_device *drm, struct lcd *lcd);
+
+#endif /* __DE2_DRM_H__ */
diff --git a/drivers/gpu/drm/sunxi/de2_drv.c b/drivers/gpu/drm/sunxi/de2_drv.c
new file mode 100644
index 0000000..e48c1fb
--- /dev/null
+++ b/drivers/gpu/drm/sunxi/de2_drv.c
@@ -0,0 +1,376 @@
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
+#define DRIVER_DATE	"20160101"
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
+	drm->mode_config.min_width = 640;
+	drm->mode_config.min_height = 480;
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
+				dev_warn(dev, "parent device of %s is not available\n",
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
+	drm_debug = DRM_UT_DRIVER;
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
diff --git a/drivers/gpu/drm/sunxi/de2_hdmi.c b/drivers/gpu/drm/sunxi/de2_hdmi.c
new file mode 100644
index 0000000..1966733
--- /dev/null
+++ b/drivers/gpu/drm/sunxi/de2_hdmi.c
@@ -0,0 +1,381 @@
+/*
+ * Allwinner DRM driver - HDMI
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
+#include <linux/component.h>
+#include <linux/clk.h>
+#include <linux/hdmi.h>
+#include <linux/of_graph.h>
+
+#include <drm/drmP.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_edid.h>
+#include <drm/drm_of.h>
+
+#include "de2_hdmi.h"
+#include "de2_hdmi_h3.h"
+
+#define conn_to_priv(x) \
+	container_of(x, struct de2_hdmi_priv, connector)
+
+#define enc_to_priv(x) \
+	container_of(x, struct de2_hdmi_priv, encoder)
+
+/* --- encoder functions --- */
+
+static bool de2_hdmi_encoder_mode_fixup(struct drm_encoder *encoder,
+				  const struct drm_display_mode *mode,
+				  struct drm_display_mode *adjusted_mode)
+{
+	DRM_DEBUG_DRIVER("\n");
+
+	return true;
+}
+
+static void de2_hdmi_encoder_mode_set(struct drm_encoder *encoder,
+					struct drm_display_mode *mode,
+					struct drm_display_mode *adjusted_mode)
+{
+	struct de2_hdmi_priv *priv = enc_to_priv(encoder);
+
+	DRM_DEBUG_DRIVER("\n");
+
+	priv->cea_mode = drm_match_cea_mode(mode);
+
+	clk_set_rate(priv->clk, mode->clock * 1000);
+
+	mutex_lock(&priv->mutex);
+	bsp_hdmi_video(priv);
+	mutex_unlock(&priv->mutex);
+}
+
+static void de2_hdmi_encoder_enable(struct drm_encoder *encoder)
+{ 
+	struct de2_hdmi_priv *priv = enc_to_priv(encoder);
+
+	DRM_DEBUG_DRIVER("\n");
+
+	mutex_lock(&priv->mutex);
+	bsp_hdmi_set_video_en(priv, 1);
+	mutex_unlock(&priv->mutex);
+}
+
+static void de2_hdmi_encoder_disable(struct drm_encoder *encoder)
+{ 
+	struct de2_hdmi_priv *priv = enc_to_priv(encoder);
+
+	mutex_lock(&priv->mutex);
+	bsp_hdmi_set_video_en(priv, 0);
+	mutex_unlock(&priv->mutex);
+}
+
+static const struct drm_encoder_helper_funcs de2_hdmi_encoder_helper_funcs = {
+	.mode_fixup = de2_hdmi_encoder_mode_fixup,
+	.mode_set = de2_hdmi_encoder_mode_set,
+	.enable = de2_hdmi_encoder_enable,
+	.disable = de2_hdmi_encoder_disable,
+};
+
+static const struct drm_encoder_funcs de2_hdmi_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
+/* --- connector functions --- */
+
+static int de2_hdmi_connector_mode_valid(struct drm_connector *connector,
+					struct drm_display_mode *mode)
+{
+	if (!drm_match_cea_mode(mode))
+		return MODE_NOMODE;
+	return MODE_OK;
+}
+
+static enum drm_connector_status de2_hdmi_connector_detect(
+				struct drm_connector *connector, bool force)
+{
+	struct de2_hdmi_priv *priv = conn_to_priv(connector);
+	int ret;
+
+	mutex_lock(&priv->mutex);
+	ret = bsp_hdmi_get_hpd(priv);
+	mutex_unlock(&priv->mutex);
+
+	return ret ? connector_status_connected :
+			connector_status_disconnected;
+}
+
+static int read_edid_block(void *data, u8 *buf,
+			unsigned int blk, size_t length)
+{
+	struct de2_hdmi_priv *priv = data;
+	int ret;
+
+	mutex_lock(&priv->mutex);
+	ret = bsp_hdmi_ddc_read(priv,
+				6,
+				blk / 2, (blk & 1) ? 128 : 0,
+				length, buf);
+	mutex_unlock(&priv->mutex);
+
+	return ret;
+}
+
+static int de2_hdmi_connector_get_modes(struct drm_connector *connector)
+{
+	struct de2_hdmi_priv *priv = conn_to_priv(connector);
+	struct edid *edid;
+	int n;
+
+	DRM_DEBUG_DRIVER("\n");
+
+	edid = drm_do_get_edid(connector, read_edid_block, priv);
+
+	if (!edid) {
+		dev_warn(priv->dev, "failed to read EDID\n");
+		return 0;
+	}
+
+	drm_mode_connector_update_edid_property(connector, edid);
+	n = drm_add_edid_modes(connector, edid);
+	priv->is_hdmi_sink = drm_detect_hdmi_monitor(edid);
+
+	DRM_DEBUG_DRIVER("%s EDID ok %d modes\n",
+		priv->is_hdmi_sink ? "HDMI" : "DVI", n);
+
+	kfree(edid);
+
+	return n;
+}
+
+static struct drm_encoder *
+de2_hdmi_connector_best_encoder(struct drm_connector *connector)
+{
+	struct de2_hdmi_priv *priv = conn_to_priv(connector);
+
+	DRM_DEBUG_DRIVER("\n");
+
+	return &priv->encoder;
+}
+
+static const
+struct drm_connector_helper_funcs de2_hdmi_connector_helper_funcs = {
+	.get_modes = de2_hdmi_connector_get_modes,
+	.mode_valid = de2_hdmi_connector_mode_valid,
+	.best_encoder = de2_hdmi_connector_best_encoder,
+};
+
+static void de2_hdmi_connector_destroy(struct drm_connector *connector)
+{
+	drm_connector_unregister(connector);
+	drm_connector_cleanup(connector);
+}
+
+static const struct drm_connector_funcs de2_hdmi_connector_funcs = {
+	.dpms = drm_atomic_helper_connector_dpms,
+	.reset = drm_atomic_helper_connector_reset,
+	.fill_modes = drm_helper_probe_single_connector_modes,
+	.detect = de2_hdmi_connector_detect,
+	.destroy = de2_hdmi_connector_destroy,
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+};
+
+static void de2_hdmi_cleanup(struct de2_hdmi_priv *priv)
+{
+	if (!IS_ERR_OR_NULL(priv->rstc1))
+		reset_control_assert(priv->rstc1);
+	if (!IS_ERR_OR_NULL(priv->rstc0))
+		reset_control_assert(priv->rstc0);
+	clk_disable_unprepare(priv->gate);
+	clk_disable_unprepare(priv->clk_ddc);
+	clk_disable_unprepare(priv->clk);
+}
+
+static int de2_hdmi_bind(struct device *dev, struct device *master, void *data)
+{
+	struct drm_device *drm = data;
+	struct de2_hdmi_priv *priv = dev_get_drvdata(dev);
+	struct drm_encoder *encoder = &priv->encoder;
+	struct drm_connector *connector = &priv->connector;
+	int ret;
+
+	encoder->possible_crtcs =
+			drm_of_find_possible_crtcs(drm, dev->of_node);
+
+	/* if no CRTC, delay */
+	if (encoder->possible_crtcs == 0)
+		return -EPROBE_DEFER;
+
+	/* HDMI init */
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		goto err;
+	ret = clk_prepare_enable(priv->clk_ddc);
+	if (ret)
+		goto err;
+	ret = clk_prepare_enable(priv->gate);
+	if (ret)
+		goto err;
+	ret = reset_control_deassert(priv->rstc0);
+	if (ret)
+		goto err;
+	ret = reset_control_deassert(priv->rstc1);
+	if (ret)
+		goto err;
+
+	mutex_lock(&priv->mutex);
+	bsp_hdmi_init(priv);
+	bsp_hdmi_hrst(priv);		/* hpd reset */
+	mutex_unlock(&priv->mutex);
+
+	/* encoder init */
+	ret = drm_encoder_init(drm, encoder, &de2_hdmi_encoder_funcs,
+			       DRM_MODE_ENCODER_TMDS);
+	if (ret)
+		goto err;
+
+	drm_encoder_helper_add(encoder, &de2_hdmi_encoder_helper_funcs);
+
+	/* connector init */
+	ret = drm_connector_init(drm, connector,
+				 &de2_hdmi_connector_funcs,
+				 DRM_MODE_CONNECTOR_HDMIA);
+	if (ret)
+		goto err_connector;
+
+	connector->interlace_allowed = 1;
+	connector->polled = DRM_CONNECTOR_POLL_CONNECT |
+				 DRM_CONNECTOR_POLL_DISCONNECT;
+	drm_connector_helper_add(connector,
+				 &de2_hdmi_connector_helper_funcs);
+
+	ret = drm_connector_register(connector);
+	if (ret)
+		goto err_register;
+
+	drm_mode_connector_attach_encoder(connector, encoder);
+
+	return 0;
+
+err_register:
+	drm_connector_cleanup(connector);
+err_connector:
+	drm_encoder_cleanup(encoder);
+err:
+	de2_hdmi_cleanup(priv);
+	DRM_DEBUG_DRIVER("err %d\n", ret);
+	return ret;
+}
+
+static void de2_hdmi_unbind(struct device *dev, struct device *master,
+			   void *data)
+{
+	struct de2_hdmi_priv *priv = dev_get_drvdata(dev);
+
+	drm_connector_unregister(&priv->connector);
+	drm_connector_cleanup(&priv->connector);
+	drm_encoder_cleanup(&priv->encoder);
+	de2_hdmi_cleanup(priv);
+}
+
+static const struct component_ops de2_hdmi_ops = {
+	.bind = de2_hdmi_bind,
+	.unbind = de2_hdmi_unbind,
+};
+
+static int de2_hdmi_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct de2_hdmi_priv *priv;
+	struct resource *res;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, priv);
+	priv->dev = dev;
+
+	mutex_init(&priv->mutex);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(dev, "failed to get memory resource\n");
+		return -EINVAL;
+	}
+	priv->mmio = devm_ioremap_resource(dev, res);
+	if (IS_ERR(priv->mmio)) {
+		dev_err(dev, "failed to map registers\n");
+		return PTR_ERR(priv->mmio);
+	}
+
+	priv->gate = devm_clk_get(dev, "gate");
+	if (IS_ERR(priv->gate)) {
+		dev_err(dev, "gate clock err %d\n",
+					(int) PTR_ERR(priv->gate));
+		return PTR_ERR(priv->gate);
+	}
+	priv->clk = devm_clk_get(dev, "clock");
+	if (IS_ERR(priv->clk)) {
+		dev_err(dev, "hdmi clock err %d\n",
+					(int) PTR_ERR(priv->clk));
+		return PTR_ERR(priv->clk);
+	}
+	priv->clk_ddc = devm_clk_get(dev, "ddc-clock");
+	if (IS_ERR(priv->clk_ddc)) {
+		dev_err(dev, "hdmi-ddc clock err %d\n",
+					(int) PTR_ERR(priv->clk_ddc));
+		return PTR_ERR(priv->clk_ddc);
+	}
+	priv->rstc0 = devm_reset_control_get(dev, "hdmi0");
+	if (IS_ERR(priv->rstc0)) {
+		dev_err(dev, "reset controller err %d\n",
+				(int) PTR_ERR(priv->rstc0));
+		return PTR_ERR(priv->rstc0);
+	}
+	priv->rstc1 = devm_reset_control_get(dev, "hdmi1");
+	if (IS_ERR(priv->rstc1)) {
+		dev_err(dev, "reset controller err %d\n",
+				(int) PTR_ERR(priv->rstc1));
+		return PTR_ERR(priv->rstc1);
+	}
+
+	return component_add(dev, &de2_hdmi_ops);
+}
+
+static int de2_hdmi_remove(struct platform_device *pdev)
+{
+	component_del(&pdev->dev, &de2_hdmi_ops);
+
+	return 0;
+}
+
+static const struct of_device_id de2_hdmi_dt_ids[] = {
+	{ .compatible = "allwinner,sun8i-h3-hdmi", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, de2_hdmi_dt_ids);
+
+static struct platform_driver de2_hdmi_driver = {
+	.probe = de2_hdmi_probe,
+	.remove = de2_hdmi_remove,
+	.driver = {
+		.name = "sun8i-h3-hdmi",
+		.of_match_table = of_match_ptr(de2_hdmi_dt_ids),
+	},
+};
+
+module_platform_driver(de2_hdmi_driver);
+
+MODULE_AUTHOR("Jean-Francois Moine <moinejf@free.fr>");
+MODULE_DESCRIPTION("Allwinner DE2 HDMI encoder/connector");
+MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/sunxi/de2_hdmi.h b/drivers/gpu/drm/sunxi/de2_hdmi.h
new file mode 100644
index 0000000..840a4c8
--- /dev/null
+++ b/drivers/gpu/drm/sunxi/de2_hdmi.h
@@ -0,0 +1,34 @@
+#ifndef __DE2_HDMI_H__
+#define __DE2_HDMI_H__
+/*
+ * Copyright (C) 2015 Jean-Fran??ois Moine
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#include <linux/clk.h>
+#include <linux/reset.h>
+#include <drm/drmP.h>
+
+struct de2_hdmi_priv {
+	struct device *dev;
+	void __iomem *mmio;
+
+	struct drm_encoder encoder;
+	struct drm_connector connector;
+
+	struct clk *clk;
+	struct clk *clk_ddc;
+	struct clk *gate;
+	struct reset_control *rstc0;
+	struct reset_control *rstc1;
+
+	struct mutex mutex;
+	u8 cea_mode;
+	bool is_hdmi_sink;
+	bool is_yuv;
+};
+
+#endif /* __DE2_HDMI_H__ */
diff --git a/drivers/gpu/drm/sunxi/de2_hdmi_h3.c b/drivers/gpu/drm/sunxi/de2_hdmi_h3.c
new file mode 100644
index 0000000..c54b090
--- /dev/null
+++ b/drivers/gpu/drm/sunxi/de2_hdmi_h3.c
@@ -0,0 +1,478 @@
+/*
+ * Allwinner H3 HDMI lowlevel functions
+ *
+ * Copyright (C) 2016 Jean-Francois Moine <moinejf@free.fr>
+ *
+ * Adapted from the file
+ *	lichee/linux-3.4/drivers/video/sunxi/disp2/hdmi/aw/hdmi_bsp_sun8iw7.c
+ * with no license nor copyright.
+ */
+
+#include <drm/drmP.h>
+
+#include "de2_hdmi.h"
+#include "de2_hdmi_h3.h"
+
+struct para_tab {
+	u32 para[19];
+};
+
+struct pcm_sf {
+	u32 	sf;
+	unsigned char	cs_sf;
+};
+
+/*
+ * [0] = vic (cea Video ID)
+ * [1] used in hdmi_phy_set / bsp_hdmi_audio
+ * [2..17] used in bsp_hdmi_video
+ */
+static const struct para_tab ptbl[] = {
+	{{  6,  1, 1,  1,  5,  3, 0, 1, 4, 0, 0, 160,  20,  38, 124, 240, 22, 0, 0}},
+	{{ 21, 11, 1,  1,  5,  3, 1, 1, 2, 0, 0, 160,  32,  24, 126,  32, 24, 0, 0}},
+	{{  2, 11, 0,  0,  2,  6, 1, 0, 9, 0, 0, 208, 138,  16,  62, 224, 45, 0, 0}},
+	{{ 17, 11, 0,  0,  2,  5, 2, 0, 5, 0, 0, 208, 144,  12,  64,  64, 49, 0, 0}},
+	{{ 19,  4, 0, 96,  5,  5, 2, 2, 5, 1, 0,   0, 188, 184,  40, 208, 30, 1, 1}},
+	{{  4,  4, 0, 96,  5,  5, 2, 1, 5, 0, 0,   0, 114, 110,  40, 208, 30, 1, 1}},
+	{{ 20,  4, 0, 97,  7,  5, 4, 2, 2, 2, 0, 128, 208,  16,  44,  56, 22, 1, 1}},
+	{{  5,  4, 0, 97,  7,  5, 4, 1, 2, 0, 0, 128,  24,  88,  44,  56, 22, 1, 1}},
+	{{ 31,  2, 0, 96,  7,  5, 4, 2, 4, 2, 0, 128, 208,  16,  44,  56, 45, 1, 1}},
+	{{ 16,  2, 0, 96,  7,  5, 4, 1, 4, 0, 0, 128,  24,  88,  44,  56, 45, 1, 1}},
+	{{ 32,  4, 0, 96,  7,  5, 4, 3, 4, 2, 0, 128,  62, 126,  44,  56, 45, 1, 1}},
+	{{ 33,  4, 0,  0,  7,  5, 4, 2, 4, 2, 0, 128, 208,  16,  44,  56, 45, 1, 1}},
+	{{ 34,  4, 0,  0,  7,  5, 4, 1, 4, 0, 0, 128,  24,  88,  44,  56, 45, 1, 1}},
+	{{160,  2, 0, 96,  7,  5, 8, 3, 4, 2, 0, 128,  62, 126,  44, 157, 45, 1, 1}},
+	{{147,  2, 0, 96,  5,  5, 5, 2, 5, 1, 0,   0, 188, 184,  40, 190, 30, 1, 1}},
+	{{132,  2, 0, 96,  5,  5, 5, 1, 5, 0, 0,   0, 114, 110,  40, 160, 30, 1, 1}},
+	{{257,  1, 0, 96, 15, 10, 8, 2, 8, 0, 0,   0,  48, 176,  88, 112, 90, 1, 1}},
+	{{258,  1, 0, 96, 15, 10, 8, 5, 8, 4, 0,   0, 160,  32,  88, 112, 90, 1, 1}},
+};
+
+static inline void hdmi_writeb(struct de2_hdmi_priv *priv,
+			u32 addr, u8 data)
+{
+	writeb_relaxed(data, priv->mmio + addr);
+}
+
+static inline void hdmi_writel(struct de2_hdmi_priv *priv,
+			u32 addr, u32 data)
+{
+	writel_relaxed(data, priv->mmio + addr);
+}
+
+static inline u8 hdmi_readb(struct de2_hdmi_priv *priv,
+			u32 addr)
+{
+	return readb_relaxed(priv->mmio + addr);
+}
+
+static inline u32 hdmi_readl(struct de2_hdmi_priv *priv,
+			u32 addr)
+{
+	return readl_relaxed(priv->mmio + addr);
+}
+
+static void hdmi_phy_init(struct de2_hdmi_priv *priv)
+{
+	int to_cnt;
+	u32 tmp;
+
+	hdmi_writel(priv, 0x10020, 0);
+	hdmi_writel(priv, 0x10020, 1 << 0);
+	udelay(5);
+	hdmi_writel(priv, 0x10020, hdmi_readl(priv, 0x10020) | (1 << 16));
+	hdmi_writel(priv, 0x10020, hdmi_readl(priv, 0x10020) | (1 << 1));
+	udelay(10);
+	hdmi_writel(priv, 0x10020, hdmi_readl(priv, 0x10020) | (1 << 2));
+	udelay(5);
+	hdmi_writel(priv, 0x10020, hdmi_readl(priv, 0x10020) | (1 << 3));
+	udelay(40);
+	hdmi_writel(priv, 0x10020, hdmi_readl(priv, 0x10020) | (1 << 19));
+	udelay(100);
+	hdmi_writel(priv, 0x10020, hdmi_readl(priv, 0x10020) | (1 << 18));
+	hdmi_writel(priv, 0x10020, hdmi_readl(priv, 0x10020) | (7 << 4));
+
+	to_cnt = 10;
+	while (1) {
+		if ((hdmi_readl(priv, 0x10038) & 0x80) == 0x80)
+			break;
+		udelay(200);
+		if (--to_cnt == 0) {
+			pr_warn("hdmi phy init timeout\n");
+			break;
+		}
+	}
+
+	hdmi_writel(priv, 0x10020, hdmi_readl(priv, 0x10020) | (0xf << 8));
+	hdmi_writel(priv, 0x10020, hdmi_readl(priv, 0x10020) | (1 << 7));
+
+	hdmi_writel(priv, 0x1002c, 0x39dc5040);
+	hdmi_writel(priv, 0x10030, 0x80084343);
+	msleep(10);
+	hdmi_writel(priv, 0x10034, 0x00000001);
+	hdmi_writel(priv, 0x1002c, hdmi_readl(priv, 0x1002c) | 0x02000000);
+	msleep(100);
+	tmp = hdmi_readl(priv, 0x10038);
+	hdmi_writel(priv, 0x1002c, hdmi_readl(priv, 0x1002c) | 0xc0000000);
+	hdmi_writel(priv, 0x1002c, hdmi_readl(priv, 0x1002c) |
+						((tmp >> 11) & 0x3f));
+	hdmi_writel(priv, 0x10020, 0x01ff0f7f);
+	hdmi_writel(priv, 0x10024, 0x80639000);
+	hdmi_writel(priv, 0x10028, 0x0f81c405);
+}
+
+static int get_vid(u32 id)
+{
+	u32 i;
+
+	for (i = 0; i < ARRAY_SIZE(ptbl); i++) {
+		if (id == ptbl[i].para[0])
+			return i;
+	}
+
+	return -1;
+}
+
+static int hdmi_phy_set(struct de2_hdmi_priv *priv, int i)
+{
+	u32 tmp;
+
+	hdmi_writel(priv, 0x10020, hdmi_readl(priv, 0x10020) & ~0xf000);
+	switch (ptbl[i].para[1]) {
+	case 1:
+
+		hdmi_writel(priv, 0x1002c, 0x31dc5fc0);	/* or 0x30dc5fc0 ? */
+		hdmi_writel(priv, 0x10030, 0x800863c0);
+		msleep(10);
+		hdmi_writel(priv, 0x10034, 0x00000001);
+		hdmi_writel(priv, 0x1002c, hdmi_readl(priv, 0x1002c) |
+						0x02000000);
+		msleep(200);
+		tmp = hdmi_readl(priv, 0x10038);
+		hdmi_writel(priv, 0x1002c, hdmi_readl(priv, 0x1002c) |
+							0xc0000000);
+		if (((tmp >> 11) & 0x3f) < 0x3d)
+			hdmi_writel(priv, 0x1002c, hdmi_readl(priv, 0x1002c) |
+					(((tmp >> 11) & 0x3f) + 2));
+		else
+			hdmi_writel(priv, 0x1002c, hdmi_readl(priv, 0x1002c) |
+								0x3f);
+		msleep(100);
+		hdmi_writel(priv, 0x10020, 0x01ffff7f);
+		hdmi_writel(priv, 0x10024, 0x8063b000);
+		hdmi_writel(priv, 0x10028, 0x0f8246b5);
+		break;
+	case 2:				/* 1080P @ 60 & 50 */
+		hdmi_writel(priv, 0x1002c, 0x39dc5040);
+		hdmi_writel(priv, 0x10030, 0x80084381);
+		msleep(10);
+		hdmi_writel(priv, 0x10034, 0x00000001);
+		hdmi_writel(priv, 0x1002c, hdmi_readl(priv, 0x1002c) |
+							0x02000000);
+		msleep(100);
+		tmp = hdmi_readl(priv, 0x10038);
+		hdmi_writel(priv, 0x1002c, hdmi_readl(priv, 0x1002c) |
+							0xc0000000);
+		hdmi_writel(priv, 0x1002c, hdmi_readl(priv, 0x1002c) |
+						((tmp >> 11) & 0x3f));
+		hdmi_writel(priv, 0x10020, 0x01ffff7f);
+		hdmi_writel(priv, 0x10024, 0x8063a800);
+		hdmi_writel(priv, 0x10028, 0x0f81c485);
+		break;
+	case 4:				/* 720P @ 50 & 60, 1080I, 1080P */
+		hdmi_writel(priv, 0x1002c, 0x39dc5040);
+		hdmi_writel(priv, 0x10030, 0x80084343);
+		msleep(10);
+		hdmi_writel(priv, 0x10034, 0x00000001);
+		hdmi_writel(priv, 0x1002c, hdmi_readl(priv, 0x1002c) |
+							0x02000000);
+		msleep(100);
+		tmp = hdmi_readl(priv, 0x10038);
+		hdmi_writel(priv, 0x1002c, hdmi_readl(priv, 0x1002c) |
+							0xc0000000);
+		hdmi_writel(priv, 0x1002c, hdmi_readl(priv, 0x1002c) |
+						((tmp >> 11) & 0x3f));
+		hdmi_writel(priv, 0x10020, 0x01ffff7f);
+		hdmi_writel(priv, 0x10024, 0x8063b000);
+		hdmi_writel(priv, 0x10028, 0x0f81c405);
+		break;
+	case 11:				/* 480P/576P */
+		hdmi_writel(priv, 0x1002c, 0x39dc5040);
+		hdmi_writel(priv, 0x10030, 0x8008430a);
+		msleep(10);
+		hdmi_writel(priv, 0x10034, 0x00000001);
+		hdmi_writel(priv, 0x1002c, hdmi_readl(priv, 0x1002c) |
+							0x02000000);
+		msleep(100);
+		tmp = hdmi_readl(priv, 0x10038);
+		hdmi_writel(priv, 0x1002c, hdmi_readl(priv, 0x1002c) |
+							0xc0000000);
+		hdmi_writel(priv, 0x1002c, hdmi_readl(priv, 0x1002c) |
+						((tmp >> 11) & 0x3f));
+		hdmi_writel(priv, 0x10020, 0x01ffff7f);
+		hdmi_writel(priv, 0x10024, 0x8063b000);
+		hdmi_writel(priv, 0x10028, 0x0f81c405);
+		break;
+	default:
+		return -1;
+	}
+	return 0;
+}
+
+static void bsp_hdmi_inner_init(struct de2_hdmi_priv *priv)
+{
+	hdmi_writeb(priv, 0x10010, 0x45);
+	hdmi_writeb(priv, 0x10011, 0x45);
+	hdmi_writeb(priv, 0x10012, 0x52);
+	hdmi_writeb(priv, 0x10013, 0x54);
+	hdmi_writeb(priv, 0x8080,  0x00);
+	udelay(1);
+	hdmi_writeb(priv, 0xf01f, 0x00);
+	hdmi_writeb(priv, 0x8403, 0xff);
+	hdmi_writeb(priv, 0x904c, 0xff);
+	hdmi_writeb(priv, 0x904e, 0xff);
+	hdmi_writeb(priv, 0xd04c, 0xff);
+	hdmi_writeb(priv, 0x8250, 0xff);
+	hdmi_writeb(priv, 0x8a50, 0xff);
+	hdmi_writeb(priv, 0x8272, 0xff);
+	hdmi_writeb(priv, 0x40c0, 0xff);
+	hdmi_writeb(priv, 0x86f0, 0xff);
+	hdmi_writeb(priv, 0x0ee3, 0xff);
+	hdmi_writeb(priv, 0x8ee2, 0xff);
+	hdmi_writeb(priv, 0xa049, 0xf0);
+	hdmi_writeb(priv, 0xb045, 0x1e);
+	hdmi_writeb(priv, 0x00c1, 0x00);
+	hdmi_writeb(priv, 0x00c1, 0x03);
+	hdmi_writeb(priv, 0x00c0, 0x00);
+	hdmi_writeb(priv, 0x40c1, 0x10);
+	hdmi_writeb(priv, 0x0010, 0xff);
+	hdmi_writeb(priv, 0x0011, 0xff);
+	hdmi_writeb(priv, 0x8010, 0xff);
+	hdmi_writeb(priv, 0x8011, 0xff);
+	hdmi_writeb(priv, 0x0013, 0xff);
+	hdmi_writeb(priv, 0x8012, 0xff);
+	hdmi_writeb(priv, 0x8013, 0xff);
+}
+
+void bsp_hdmi_init(struct de2_hdmi_priv *priv)
+{
+	hdmi_phy_init(priv);
+	bsp_hdmi_inner_init(priv);
+}
+
+void bsp_hdmi_set_video_en(struct de2_hdmi_priv *priv,
+			unsigned char enable)
+{
+	if (enable)
+		hdmi_writel(priv, 0x10020,
+			hdmi_readl(priv, 0x10020) | (0x0f << 12));
+	else
+		hdmi_writel(priv, 0x10020,
+			hdmi_readl(priv, 0x10020) & ~(0x0f << 12));
+}
+
+/* initialize */
+int bsp_hdmi_video(struct de2_hdmi_priv *priv)
+{
+	int i = get_vid(priv->cea_mode);	/* ptbl index */
+	int csc;				/* color space */
+
+	if (i < 0)
+		return i;
+
+	switch (priv->cea_mode) {
+	case 2:				/* 480P */
+	case 6:				/* 1440x480I */
+	case 17:			/* 576P */
+	case 21:			/* 1440x576I */
+		csc = 1;		/* BT601 */
+		break;
+	default:
+		csc = 2;		/* BT709 */
+		break;
+	}
+	if (hdmi_phy_set(priv, i) != 0)
+		return -1;
+
+	bsp_hdmi_inner_init(priv);
+
+	hdmi_writeb(priv, 0x0840, 0x01);
+	hdmi_writeb(priv, 0x4845, 0x00);
+	hdmi_writeb(priv, 0x0040, ptbl[i].para[3] | 0x10);
+	hdmi_writeb(priv, 0x10001, ptbl[i].para[3] < 96 ? 0x03 : 0x00);
+	hdmi_writeb(priv, 0x8040, ptbl[i].para[4]);
+	hdmi_writeb(priv, 0x4043, ptbl[i].para[5]);
+	hdmi_writeb(priv, 0x8042, ptbl[i].para[6]);
+	hdmi_writeb(priv, 0x0042, ptbl[i].para[7]);
+	hdmi_writeb(priv, 0x4042, ptbl[i].para[8]);
+	hdmi_writeb(priv, 0x4041, ptbl[i].para[9]);
+	hdmi_writeb(priv, 0xc041, ptbl[i].para[10]);
+	hdmi_writeb(priv, 0x0041, ptbl[i].para[11]);
+	hdmi_writeb(priv, 0x8041, ptbl[i].para[12]);
+	hdmi_writeb(priv, 0x4040, ptbl[i].para[13]);
+	hdmi_writeb(priv, 0xc040, ptbl[i].para[14]);
+	hdmi_writeb(priv, 0x0043, ptbl[i].para[15]);
+	hdmi_writeb(priv, 0x8043, ptbl[i].para[16]);
+	hdmi_writeb(priv, 0x0045, 0x0c);
+	hdmi_writeb(priv, 0x8044, 0x20);
+	hdmi_writeb(priv, 0x8045, 0x01);
+	hdmi_writeb(priv, 0x0046, 0x0b);
+	hdmi_writeb(priv, 0x0047, 0x16);
+	hdmi_writeb(priv, 0x8046, 0x21);
+	hdmi_writeb(priv, 0x3048, ptbl[i].para[2] ? 0x21 : 0x10);
+	hdmi_writeb(priv, 0x0401, ptbl[i].para[2] ? 0x41 : 0x40);
+	hdmi_writeb(priv, 0x8400, 0x07);
+	hdmi_writeb(priv, 0x8401, 0x00);
+	hdmi_writeb(priv, 0x0402, 0x47);
+	hdmi_writeb(priv, 0x0800, 0x01);
+	hdmi_writeb(priv, 0x0801, 0x07);
+	hdmi_writeb(priv, 0x8800, 0x00);
+	hdmi_writeb(priv, 0x8801, 0x00);
+	hdmi_writeb(priv, 0x0802, 0x00);
+	hdmi_writeb(priv, 0x0803, 0x00);
+	hdmi_writeb(priv, 0x8802, 0x00);
+	hdmi_writeb(priv, 0x8803, 0x00);
+
+	if (priv->is_hdmi_sink) {
+		hdmi_writeb(priv, 0xb045, 0x08);
+		hdmi_writeb(priv, 0x2045, 0x00);
+		hdmi_writeb(priv, 0x2044, 0x0c);
+		hdmi_writeb(priv, 0x6041, 0x03);
+		hdmi_writeb(priv, 0xa044, (ptbl[i].para[0] & 0x100) == 0x100 ?
+					0x20 : (ptbl[i].para[0] & 0x80) == 0x80 ?
+					0x40 :
+					0x00 );
+		hdmi_writeb(priv, 0xa045, (ptbl[i].para[0] & 0x100) == 0x100 ?
+					(ptbl[i].para[0] & 0x7f) : 0x00);
+		hdmi_writeb(priv, 0x2046, 0x00);
+		hdmi_writeb(priv, 0x3046, 0x01);
+		hdmi_writeb(priv, 0x3047, 0x11);
+		hdmi_writeb(priv, 0x4044, 0x00);
+		hdmi_writeb(priv, 0x0052, 0x00);
+		hdmi_writeb(priv, 0x8051, 0x11);
+
+		hdmi_writeb(priv, 0x10010, 0x45);
+		hdmi_writeb(priv, 0x10011, 0x45);
+		hdmi_writeb(priv, 0x10012, 0x52);
+		hdmi_writeb(priv, 0x10013, 0x54);
+		hdmi_writeb(priv, 0x0040, hdmi_readb(priv, 0x0040) | 0x08);
+
+		hdmi_writeb(priv, 0x10010, 0x52);
+		hdmi_writeb(priv, 0x10011, 0x54);
+		hdmi_writeb(priv, 0x10012, 0x41);
+		hdmi_writeb(priv, 0x10013, 0x57);
+		hdmi_writeb(priv, 0x4045, priv->is_yuv ? 0x02 : 0x00);
+		if (ptbl[i].para[17] == 0)
+			hdmi_writeb(priv, 0xc044, (csc << 6) | 0x18);
+		else if (ptbl[i].para[17] == 1)
+			hdmi_writeb(priv, 0xc044, (csc << 6) | 0x28);
+		else
+			hdmi_writeb(priv, 0xc044, (csc << 6) | 0x08);
+
+		hdmi_writeb(priv, 0xc045, priv->is_yuv ? 0x00 : 0x08);
+		hdmi_writeb(priv, 0x4046, ptbl[i].para[0]&0x7f);
+	}
+
+	hdmi_writeb(priv, 0x0082, 0x00);
+	hdmi_writeb(priv, 0x0081, 0x00);
+
+	hdmi_writeb(priv, 0x0840, 0x00);
+
+	return 0;
+}
+
+
+/* get a block of EDID */
+int bsp_hdmi_ddc_read(struct de2_hdmi_priv *priv,
+			char cmd, char pointer, char off,
+			int nbyte, char *pbuf)
+{
+	u32 to_cnt;
+	int ret = 0;
+	
+	hdmi_writeb(priv, 0x10010, 0x45);
+	hdmi_writeb(priv, 0x10011, 0x45);
+	hdmi_writeb(priv, 0x10012, 0x52);
+	hdmi_writeb(priv, 0x10013, 0x54);
+	hdmi_writeb(priv, 0x4ee1, 0x00);
+	to_cnt = 50;
+	while ((hdmi_readb(priv, 0x4ee1) & 0x01) != 0x01) {
+		udelay(10);
+		if (--to_cnt == 0) {	/* wait for 500us for timeout */
+			pr_warn("hdmi ddc reset timeout\n");
+			break;
+		}
+	}
+
+	hdmi_writeb(priv, 0x8ee3, 0x05);
+	hdmi_writeb(priv, 0x0ee3, 0x08);
+	hdmi_writeb(priv, 0x4ee2, 0xd8);
+	hdmi_writeb(priv, 0xcee2, 0xfe);
+
+	while (nbyte > 0) {
+		hdmi_writeb(priv, 0x0ee0, 0xa0 >> 1);	/* DDC addr */
+		hdmi_writeb(priv, 0x0ee1, off);		/* DDC offset */
+		hdmi_writeb(priv, 0x4ee0, 0x60 >> 1);	/* DDC segment addr */
+		hdmi_writeb(priv, 0xcee0, pointer);	/* DDC segment */
+		hdmi_writeb(priv, 0x0ee2, 0x02);	/* start command */
+
+		to_cnt = 50;				/* timeout 100ms */
+		while (1) {
+			if ((hdmi_readb(priv, 0x0013) & 0x02) == 0x02) {
+				hdmi_writeb(priv, 0x0013,
+					hdmi_readb(priv, 0x0013) & 0x02);
+				*pbuf++ = hdmi_readb(priv, 0x8ee1);
+				break;
+			}
+			if ((hdmi_readb(priv, 0x0013) & 0x01) == 0x01) {
+				hdmi_writeb(priv, 0x0013,
+					hdmi_readb(priv, 0x0013) & 0x01);
+				pr_warn("hdmi ddc read error, byte cnt = %d\n",
+					 nbyte);
+				ret = -1;
+				break;
+			}
+			if (--to_cnt == 0) {
+				pr_warn("hdmi ddc read timeout, byte cnt = %d\n",
+					 nbyte);
+				ret = -1;
+				break;
+			}
+			msleep(2);
+		}
+		if (ret)
+			break;
+		nbyte--;
+		off++;
+	}
+	hdmi_writeb(priv, 0x10010, 0x52);
+	hdmi_writeb(priv, 0x10011, 0x54);
+	hdmi_writeb(priv, 0x10012, 0x41);
+	hdmi_writeb(priv, 0x10013, 0x57);
+
+	return ret;
+}
+
+int bsp_hdmi_get_hpd(struct de2_hdmi_priv *priv)
+{
+	int ret;
+
+	hdmi_writeb(priv, 0x10010, 0x45);
+	hdmi_writeb(priv, 0x10011, 0x45);
+	hdmi_writeb(priv, 0x10012, 0x52);
+	hdmi_writeb(priv, 0x10013, 0x54);
+
+	ret = (hdmi_readl(priv, 0x10038) & 0x80000) ? 1 : 0;
+
+	hdmi_writeb(priv, 0x10010, 0x52);
+	hdmi_writeb(priv, 0x10011, 0x54);
+	hdmi_writeb(priv, 0x10012, 0x41);
+	hdmi_writeb(priv, 0x10013, 0x57);
+
+	return ret;
+}
+
+void bsp_hdmi_hrst(struct de2_hdmi_priv *priv)
+{
+	hdmi_writeb(priv, 0x00c1, 0x04);
+}
diff --git a/drivers/gpu/drm/sunxi/de2_hdmi_h3.h b/drivers/gpu/drm/sunxi/de2_hdmi_h3.h
new file mode 100644
index 0000000..59fb6ca
--- /dev/null
+++ b/drivers/gpu/drm/sunxi/de2_hdmi_h3.h
@@ -0,0 +1,14 @@
+#ifndef __DE2_HDMI_H3_H__
+#define __DE2_HDMI_H3_H__
+
+void bsp_hdmi_set_video_en(struct de2_hdmi_priv *priv,
+			unsigned char enable);
+int bsp_hdmi_video(struct de2_hdmi_priv *priv);
+int bsp_hdmi_ddc_read(struct de2_hdmi_priv *priv,
+			char cmd, char pointer, char offset,
+			int nbyte, char *pbuf);
+int bsp_hdmi_get_hpd(struct de2_hdmi_priv *priv);
+void bsp_hdmi_init(struct de2_hdmi_priv *priv);
+void bsp_hdmi_hrst(struct de2_hdmi_priv *priv);
+
+#endif /* __DE2_HDMI_H3_H__ */
diff --git a/drivers/gpu/drm/sunxi/de2_plane.c b/drivers/gpu/drm/sunxi/de2_plane.c
new file mode 100644
index 0000000..53f6c79
--- /dev/null
+++ b/drivers/gpu/drm/sunxi/de2_plane.c
@@ -0,0 +1,102 @@
+/*
+ * Allwinner DRM driver - DE2 Planes
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
+#include <drm/drm_gem_cma_helper.h>
+
+#include "de2_drm.h"
+#include "de2_crtc.h"
+
+/* primary plane */
+static const uint32_t primary_formats[] = {
+	DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_XRGB8888,
+};
+
+static void primary_plane_update(struct drm_plane *plane,
+				struct drm_plane_state *old_state)
+{
+	struct drm_plane_state *state = plane->state;
+	struct drm_crtc *crtc = state->crtc;
+	struct lcd *lcd = crtc_to_lcd(crtc);
+	struct drm_framebuffer *fb = state->fb;
+	struct drm_gem_cma_object *gem;
+	int plane_num = plane - lcd->planes;
+	int crtc_x, crtc_y, src_x, src_y;
+	dma_addr_t start;
+
+	if (!crtc || !fb) {
+		DRM_DEBUG_DRIVER("no crtc/fb\n");
+		return;
+	}
+
+	if (!lcd->init_done)
+		return;
+
+	src_x = state->src_x >> 16;
+	src_y = state->src_y >> 16;
+	crtc_x = state->crtc_x;
+	crtc_y = state->crtc_y;
+
+	DRM_DEBUG_DRIVER("%dx%d+%d+%d %.4s\n",
+			state->crtc_w, state->crtc_h, crtc_x, crtc_y,
+			(char *) &fb->pixel_format);
+
+	gem = drm_fb_cma_get_gem_obj(fb, 0);
+
+	start = gem->paddr + fb->offsets[0] +
+			src_y * fb->pitches[0] + src_x;
+
+	if (plane_num == 0) {
+		de2_de_ui_enable(lcd->priv, lcd->num,
+			1, 0,			/* UI 0, layer 0 */
+			start, fb->pixel_format,
+			state->crtc_w,
+			state->crtc_h,
+			fb->bits_per_pixel);
+	} else {
+		DRM_DEBUG_DRIVER("no plane #%d\n", plane_num);
+	}
+}
+
+static const struct drm_plane_helper_funcs primary_plane_helper_funcs = {
+	.atomic_update = primary_plane_update,
+};
+
+static const struct drm_plane_funcs primary_plane_funcs = {
+	.update_plane = drm_primary_helper_update,
+	.disable_plane = drm_primary_helper_disable,
+	.destroy = drm_primary_helper_destroy,
+	.reset = drm_atomic_helper_plane_reset,
+	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
+};
+
+int de2_plane_init(struct drm_device *drm, struct lcd *lcd)
+{
+	int ret;
+
+	ret = drm_universal_plane_init(drm, &lcd->planes[0], 0,
+				&primary_plane_funcs,
+				primary_formats, ARRAY_SIZE(primary_formats),
+				DRM_PLANE_TYPE_PRIMARY);
+	if (ret < 0) {
+		dev_err(lcd->dev, "Couldn't initialize primary plane\n");
+		return ret;
+	}
+
+	drm_plane_helper_add(&lcd->planes[0],
+			     &primary_plane_helper_funcs);
+
+	return ret;
+}
-- 
2.6.4
