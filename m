From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 25 Oct 2016 16:14:41 +0200
Subject: [PATCH v5 1/7] drm: sunxi: Add a basic DRM driver for Allwinner
 DE2
In-Reply-To: <20161024140419.ah6hywf3b24pj3fv@lukather>
References: <cover.1477142934.git.moinejf@free.fr>
 <8afc5e020c5767face34fe3a9ab300ce9e67ba00.1477142934.git.moinejf@free.fr>
 <20161024140419.ah6hywf3b24pj3fv@lukather>
Message-ID: <20161025161441.6b248efe9229bd80e3f7a33c@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 24 Oct 2016 16:04:19 +0200
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> Hi,

Hi Maxime,

> On Fri, Oct 21, 2016 at 09:26:18AM +0200, Jean-Francois Moine wrote:
> > Allwinner's recent SoCs, as A64, A83T and H3, contain a new display
> > engine, DE2.
> > This patch adds a DRM video driver for this device.
> > 
> > Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> 
> Output from checkpatch:
> total: 0 errors, 20 warnings, 83 checks, 1799 lines checked
> 
> > ---
> >  .../bindings/display/sunxi/sunxi-de2.txt           |  83 +++
> >  drivers/gpu/drm/Kconfig                            |   2 +
> >  drivers/gpu/drm/Makefile                           |   1 +
> >  drivers/gpu/drm/sunxi/Kconfig                      |  21 +
> >  drivers/gpu/drm/sunxi/Makefile                     |   7 +
> >  drivers/gpu/drm/sunxi/de2_crtc.c                   | 475 +++++++++++++++++
> >  drivers/gpu/drm/sunxi/de2_crtc.h                   |  63 +++
> >  drivers/gpu/drm/sunxi/de2_de.c                     | 591 +++++++++++++++++++++
> >  drivers/gpu/drm/sunxi/de2_drm.h                    |  47 ++
> >  drivers/gpu/drm/sunxi/de2_drv.c                    | 378 +++++++++++++
> >  drivers/gpu/drm/sunxi/de2_plane.c                  | 119 +++++
> >  11 files changed, 1787 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/sunxi/sunxi-de2.txt
> >  create mode 100644 drivers/gpu/drm/sunxi/Kconfig
> >  create mode 100644 drivers/gpu/drm/sunxi/Makefile
> >  create mode 100644 drivers/gpu/drm/sunxi/de2_crtc.c
> >  create mode 100644 drivers/gpu/drm/sunxi/de2_crtc.h
> >  create mode 100644 drivers/gpu/drm/sunxi/de2_de.c
> >  create mode 100644 drivers/gpu/drm/sunxi/de2_drm.h
> >  create mode 100644 drivers/gpu/drm/sunxi/de2_drv.c
> >  create mode 100644 drivers/gpu/drm/sunxi/de2_plane.c
> > 
> > diff --git a/Documentation/devicetree/bindings/display/sunxi/sunxi-de2.txt b/Documentation/devicetree/bindings/display/sunxi/sunxi-de2.txt
> > new file mode 100644
> > index 0000000..f9cd67a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/sunxi/sunxi-de2.txt
> > @@ -0,0 +1,83 @@
> > +Allwinner sunxi Display Engine 2 subsystem
> > +==========================================
> > +
> > +The sunxi DE2 subsystem contains a display controller (DE2),
> 
> sunxi is a made up name, and doesn't really mean anything. You can
> call it either sun8i (because it was introduced in that family).

OK.

> > +one or two LCD controllers (TCON) and their external interfaces.
> > +
> > +Display controller
> > +==================
> > +
> > +Required properties:
> > +
> > +- compatible: value should be one of the following
> > +		"allwinner,sun8i-a83t-display-engine"
> > +		"allwinner,sun8i-h3-display-engine"
> > +
> > +- clocks: must include clock specifiers corresponding to entries in the
> > +		clock-names property.
> > +
> > +- clock-names: must contain
> > +		"gate": for DE activation
> > +		"clock": DE clock
> 
> We've been calling them bus and mod.

I can understand "bus" (which is better than "apb"), but why "mod"?

> > +
> > +- resets: phandle to the reset of the device
> > +
> > +- ports: phandle's to the LCD ports
> 
> Please use the OF graph.

These ports are references to the graph of nodes. See
	http://www.kernelhub.org/?msg=911825&p=2

	[snip]
> > diff --git a/drivers/gpu/drm/sunxi/de2_crtc.c b/drivers/gpu/drm/sunxi/de2_crtc.c
> > new file mode 100644
> > index 0000000..dae0fab
> > --- /dev/null
> > +++ b/drivers/gpu/drm/sunxi/de2_crtc.c
> > @@ -0,0 +1,475 @@
> > +/*
> > + * Allwinner DRM driver - DE2 CRTC
> > + *
> > + * Copyright (C) 2016 Jean-Francois Moine <moinejf@free.fr>
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License as
> > + * published by the Free Software Foundation; either version 2 of
> > + * the License, or (at your option) any later version.
> > + */
> > +
> > +#include <linux/component.h>
> > +#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_atomic_helper.h>
> > +#include <asm/io.h>
> > +#include <linux/of_irq.h>
> > +
> > +#include "de2_drm.h"
> > +#include "de2_crtc.h"
> > +
> > +/* I/O map */
> > +
> > +struct tcon {
> > +	u32 gctl;
> > +#define		TCON_GCTL_TCON_En BIT(31)
> > +	u32 gint0;
> > +#define		TCON_GINT0_TCON1_Vb_Int_En BIT(30)
> > +#define		TCON_GINT0_TCON1_Vb_Int_Flag BIT(14)
> > +	u32 gint1;
> > +	u32 dum0[13];
> > +	u32 tcon0_ctl;				/* 0x40 */
> > +#define		TCON0_CTL_TCON_En BIT(31)
> > +	u32 dum1[19];
> > +	u32 tcon1_ctl;				/* 0x90 */
> > +#define		TCON1_CTL_TCON_En BIT(31)
> > +#define		TCON1_CTL_Interlace_En BIT(20)
> > +#define		TCON1_CTL_Start_Delay_SHIFT 4
> > +#define		TCON1_CTL_Start_Delay_MASK GENMASK(8, 4)
> > +	u32 basic0;			/* XI/YI */
> > +	u32 basic1;			/* LS_XO/LS_YO */
> > +	u32 basic2;			/* XO/YO */
> > +	u32 basic3;			/* HT/HBP */
> > +	u32 basic4;			/* VT/VBP */
> > +	u32 basic5;			/* HSPW/VSPW */
> > +	u32 dum2;
> > +	u32 ps_sync;				/* 0xb0 */
> > +	u32 dum3[15];
> > +	u32 io_pol;				/* 0xf0 */
> > +#define		TCON1_IO_POL_IO0_inv BIT(24)
> > +#define		TCON1_IO_POL_IO1_inv BIT(25)
> > +#define		TCON1_IO_POL_IO2_inv BIT(26)
> > +	u32 io_tri;
> > +	u32 dum4[2];
> > +
> > +	u32 ceu_ctl;				/* 0x100 */
> > +#define     TCON_CEU_CTL_ceu_en BIT(31)
> > +	u32 dum5[3];
> > +	u32 ceu_rr;
> > +	u32 ceu_rg;
> > +	u32 ceu_rb;
> > +	u32 ceu_rc;
> > +	u32 ceu_gr;
> > +	u32 ceu_gg;
> > +	u32 ceu_gb;
> > +	u32 ceu_gc;
> > +	u32 ceu_br;
> > +	u32 ceu_bg;
> > +	u32 ceu_bb;
> > +	u32 ceu_bc;
> > +	u32 ceu_rv;
> > +	u32 ceu_gv;
> > +	u32 ceu_bv;
> > +	u32 dum6[45];
> > +
> > +	u32 mux_ctl;				/* 0x200 */
> > +	u32 dum7[63];
> > +
> > +	u32 fill_ctl;				/* 0x300 */
> > +	u32 fill_start0;
> > +	u32 fill_end0;
> > +	u32 fill_data0;
> > +};
> 
> Please use defines instead of the structures.

I think that structures are more readable.

> > +
> > +#define XY(x, y) (((x) << 16) | (y))
> > +
> > +#define tcon_read(base, member) \
> > +	readl_relaxed(base + offsetof(struct tcon, member))
> > +#define tcon_write(base, member, data) \
> > +	writel_relaxed(data, base + offsetof(struct tcon, member))
> > +
> > +/* vertical blank functions */
> > +static void de2_atomic_flush(struct drm_crtc *crtc,
> > +			struct drm_crtc_state *old_state)
> > +{
> > +	struct drm_pending_vblank_event *event = crtc->state->event;
> > +
> > +	if (event) {
> > +		crtc->state->event = NULL;
> > +		spin_lock_irq(&crtc->dev->event_lock);
> > +		if (drm_crtc_vblank_get(crtc) == 0)
> > +			drm_crtc_arm_vblank_event(crtc, event);
> > +		else
> > +			drm_crtc_send_vblank_event(crtc, event);
> > +		spin_unlock_irq(&crtc->dev->event_lock);
> > +	}
> > +}
> > +
> > +static irqreturn_t de2_lcd_irq(int irq, void *dev_id)
> > +{
> > +	struct lcd *lcd = (struct lcd *) dev_id;
> > +	u32 isr;
> > +
> > +	isr = tcon_read(lcd->mmio, gint0);
> > +
> > +	drm_crtc_handle_vblank(&lcd->crtc);
> > +
> > +	tcon_write(lcd->mmio, gint0, isr & ~TCON_GINT0_TCON1_Vb_Int_Flag);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +int de2_enable_vblank(struct drm_device *drm, unsigned crtc)
> > +{
> > +	struct priv *priv = drm->dev_private;
> > +	struct lcd *lcd = priv->lcds[crtc];
> > +
> > +	tcon_write(lcd->mmio, gint0,
> > +			tcon_read(lcd->mmio, gint0) |
> > +					TCON_GINT0_TCON1_Vb_Int_En);
> 
> That's a weird indentation
> 
> > +	return 0;
> > +}
> > +
> > +void de2_disable_vblank(struct drm_device *drm, unsigned crtc)
> > +{
> > +	struct priv *priv = drm->dev_private;
> > +	struct lcd *lcd = priv->lcds[crtc];
> > +
> > +	tcon_write(lcd->mmio, gint0,
> > +			 tcon_read(lcd->mmio, gint0) &
> > +					~TCON_GINT0_TCON1_Vb_Int_En);
> > +}
> > +
> > +/* panel functions */
> 
> Panel functions? In the CRTC driver?

Yes, dumb panel.

> > +static void de2_set_frame_timings(struct lcd *lcd)
> > +{
> > +	struct drm_crtc *crtc = &lcd->crtc;
> > +	const struct drm_display_mode *mode = &crtc->mode;
> > +	int interlace = mode->flags & DRM_MODE_FLAG_INTERLACE ? 2 : 1;
> > +	int start_delay;
> > +	u32 data;
> > +
> > +	data = XY(mode->hdisplay - 1, mode->vdisplay / interlace - 1);
> > +	tcon_write(lcd->mmio, basic0, data);
> > +	tcon_write(lcd->mmio, basic1, data);
> > +	tcon_write(lcd->mmio, basic2, data);
> > +	tcon_write(lcd->mmio, basic3,
> > +			XY(mode->htotal - 1,
> > +				mode->htotal - mode->hsync_start - 1));
> > +	tcon_write(lcd->mmio, basic4,
> > +			XY(mode->vtotal * (3 - interlace),
> > +				mode->vtotal - mode->vsync_start - 1));
> > +	tcon_write(lcd->mmio, basic5,
> > +			 XY(mode->hsync_end - mode->hsync_start - 1,
> > +				mode->vsync_end - mode->vsync_start - 1));
> > +
> > +	tcon_write(lcd->mmio, ps_sync, XY(1, 1));
> > +
> > +	data = TCON1_IO_POL_IO2_inv;
> > +	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
> > +		data |= TCON1_IO_POL_IO0_inv;
> > +	if (mode->flags & DRM_MODE_FLAG_PHSYNC)
> > +		data |= TCON1_IO_POL_IO1_inv;
> > +	tcon_write(lcd->mmio, io_pol, data);
> > +
> > +	tcon_write(lcd->mmio, ceu_ctl,
> > +		tcon_read(lcd->mmio, ceu_ctl) & ~TCON_CEU_CTL_ceu_en);
> > +
> > +	data = tcon_read(lcd->mmio, tcon1_ctl);
> > +	if (interlace == 2)
> > +		data |= TCON1_CTL_Interlace_En;
> > +	else
> > +		data &= ~TCON1_CTL_Interlace_En;
> > +	tcon_write(lcd->mmio, tcon1_ctl, data);
> > +
> > +	tcon_write(lcd->mmio, fill_ctl, 0);
> > +	tcon_write(lcd->mmio, fill_start0, mode->vtotal + 1);
> > +	tcon_write(lcd->mmio, fill_end0, mode->vtotal);
> > +	tcon_write(lcd->mmio, fill_data0, 0);
> > +
> > +	start_delay = (mode->vtotal - mode->vdisplay) / interlace - 5;
> > +	if (start_delay > 31)
> > +		start_delay = 31;
> > +	data = tcon_read(lcd->mmio, tcon1_ctl);
> > +	data &= ~TCON1_CTL_Start_Delay_MASK;
> > +	data |= start_delay << TCON1_CTL_Start_Delay_SHIFT;
> > +	tcon_write(lcd->mmio, tcon1_ctl, data);
> > +
> > +	tcon_write(lcd->mmio, io_tri, 0x0fffffff);
> > +}
> 
> Some comments here would be nice, there's a lot of non trivial things.

... and no documentation. I just set the values I saw in the I/O memory
when running the legacy driver.

> > +
> > +static void de2_crtc_enable(struct drm_crtc *crtc)
> > +{
> > +	struct lcd *lcd = crtc_to_lcd(crtc);
> > +	struct drm_display_mode *mode = &crtc->mode;
> > +
> > +	DRM_DEBUG_DRIVER("\n");
> 
> Log something useful, or don't.

This was useful when the driver was crashing only God knew where.

> > +
> > +	clk_set_rate(lcd->clk, mode->clock * 1000);
> > +
> > +	de2_set_frame_timings(lcd);
> > +
> > +	tcon_write(lcd->mmio, tcon1_ctl,
> > +		tcon_read(lcd->mmio, tcon1_ctl) | TCON1_CTL_TCON_En);
> > +
> > +	de2_de_panel_init(lcd->priv, lcd->num, mode);
> 
> panel_init in the CRTC enable? Shouldn't that be in the panel driver?
> or at least the encoder?

I will change to 'dumb panel'.

> > +
> > +	drm_mode_debug_printmodeline(mode);
> 
> This is already printed by the core.

Not at this time.

	[snip]
> > +static int de2_lcd_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct device_node *np = dev->of_node, *tmp, *parent, *port;
> > +	struct lcd *lcd;
> > +	struct resource *res;
> > +	int id, irq, ret;
> > +
> > +	id = of_alias_get_id(np, "lcd");
> > +	if (id < 0) {
> > +		dev_err(dev, "no alias for lcd\n");
> > +		id = 0;
> > +	}
> > +	lcd = devm_kzalloc(dev, sizeof *lcd, GFP_KERNEL);
> > +	if (!lcd) {
> > +		dev_err(dev, "failed to allocate private data\n");
> > +		return -ENOMEM;
> > +	}
> > +	dev_set_drvdata(dev, lcd);
> > +	lcd->dev = dev;
> > +	lcd->num = id;
> 
> What do you need this number for?

It permits access to the overlay planes in the DE2.

> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	if (!res) {
> > +		dev_err(dev, "failed to get memory resource\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	lcd->mmio = devm_ioremap_resource(dev, res);
> > +	if (IS_ERR(lcd->mmio)) {
> > +		dev_err(dev, "failed to map registers\n");
> > +		return PTR_ERR(lcd->mmio);
> > +	}
> > +
> > +	snprintf(lcd->name, sizeof(lcd->name), "sunxi-lcd%d", id);
> > +
> > +	/* possible CRTCs */
> > +	parent = np;
> > +	tmp = of_get_child_by_name(np, "ports");
> > +	if (tmp)
> > +		parent = tmp;
> > +	port = of_get_child_by_name(parent, "port");
> > +	of_node_put(tmp);
> > +	if (!port) {
> > +		dev_err(dev, "no port node\n");
> > +		return -ENXIO;
> > +	}
> > +	lcd->crtc.port = port;
> > +
> > +	lcd->gate = devm_clk_get(dev, "gate");		/* optional */
> 
> Having some kind of error checking would still be nice.

And cancel the device creation?

> > +
> > +	lcd->clk = devm_clk_get(dev, "clock");
> > +	if (IS_ERR(lcd->clk)) {
> > +		dev_err(dev, "video clock err %d\n", (int) PTR_ERR(lcd->clk));
> > +		ret = PTR_ERR(lcd->clk);
> > +		goto err;
> > +	}
> > +
> > +	lcd->rstc = devm_reset_control_get_optional(dev, NULL);
> 
> Ditto.
> 
> > +
> > +	irq = irq_of_parse_and_map(np, 0);
> > +	if (irq <= 0 || irq == NO_IRQ) {
> > +		dev_err(dev, "unable to get irq lcd %d\n", id);
> > +		ret = -EINVAL;
> > +		goto err;
> > +	}
> 
> You can use platform_get_irq for that.

Right. Thanks.

> > +
> > +	if (!IS_ERR(lcd->rstc)) {
> > +		ret = reset_control_deassert(lcd->rstc);
> > +		if (ret) {
> > +			dev_err(dev, "reset deassert err %d\n", ret);
> > +			goto err;
> > +		}
> > +	}
> > +
> > +	if (!IS_ERR(lcd->gate)) {
> > +		ret = clk_prepare_enable(lcd->gate);
> > +		if (ret)
> > +			goto err2;
> > +	}
> > +
> > +	ret = clk_prepare_enable(lcd->clk);
> > +	if (ret)
> > +		goto err2;
> 
> Is there any reason not to do that in the enable / disable? Leaving
> clocks running while the device has no guarantee that it's going to be
> used seems like a waste of resources.

If the machine does not need video (network server, router..), it is simpler
to prevent the video driver to be loaded (DT, module black list...).

> > +
> > +	de2_tcon_init(lcd);
> > +
> > +	ret = devm_request_irq(dev, irq, de2_lcd_irq, 0,
> > +				lcd->name, lcd);
> > +	if (ret < 0) {
> > +		dev_err(dev, "unable to request irq %d\n", irq);
> > +		goto err2;
> > +	}
> > +
> > +	return component_add(dev, &de2_lcd_ops);
> > +
> > +err2:
> > +	if (!IS_ERR_OR_NULL(lcd->rstc))
> > +		reset_control_assert(lcd->rstc);
> > +	clk_disable_unprepare(lcd->gate);
> > +	clk_disable_unprepare(lcd->clk);
> > +err:
> > +	of_node_put(lcd->crtc.port);
> > +	return ret;
> > +}
> > +
> > +static int de2_lcd_remove(struct platform_device *pdev)
> > +{
> > +	struct lcd *lcd = platform_get_drvdata(pdev);
> > +
> > +	component_del(&pdev->dev, &de2_lcd_ops);
> > +
> > +	if (!IS_ERR_OR_NULL(lcd->rstc))
> > +		reset_control_assert(lcd->rstc);
> > +	clk_disable_unprepare(lcd->gate);
> > +	clk_disable_unprepare(lcd->clk);
> > +	of_node_put(lcd->crtc.port);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id de2_lcd_ids[] = {
> > +	{ .compatible = "allwinner,sun8i-a83t-lcd", },
> > +	{ }
> > +};
> > +
> > +struct platform_driver de2_lcd_platform_driver = {
> > +	.probe = de2_lcd_probe,
> > +	.remove = de2_lcd_remove,
> > +	.driver = {
> > +		.name = "sunxi-de2-lcd",
> > +		.of_match_table = of_match_ptr(de2_lcd_ids),
> > +	},
> > +};
> > diff --git a/drivers/gpu/drm/sunxi/de2_crtc.h b/drivers/gpu/drm/sunxi/de2_crtc.h
> > new file mode 100644
> > index 0000000..efbe45d
> > --- /dev/null
> > +++ b/drivers/gpu/drm/sunxi/de2_crtc.h
> > @@ -0,0 +1,63 @@
> > +#ifndef __DE2_CRTC_H__
> > +#define __DE2_CRTC_H__
> > +/*
> > + * Copyright (C) 2016 Jean-Fran?ois Moine
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License as
> > + * published by the Free Software Foundation; either version 2 of
> > + * the License, or (at your option) any later version.
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/reset.h>
> > +#include <drm/drm_plane_helper.h>
> > +
> > +struct priv;
> > +
> > +enum de2_plane2 {
> > +	DE2_PRIMARY_PLANE,
> > +	DE2_CURSOR_PLANE,
> > +	DE2_VI_PLANE,
> > +	DE2_N_PLANES,
> > +};
> > +struct lcd {
> > +	void __iomem *mmio;
> > +
> > +	struct device *dev;
> > +	struct drm_crtc crtc;
> > +	struct priv *priv;	/* DRM/DE private data */
> > +
> > +	short num;		/* LCD number in hardware */
> > +	short crtc_idx;		/* CRTC index in drm */
> > +
> > +	struct clk *clk;
> > +	struct clk *gate;
> > +	struct reset_control *rstc;
> > +
> > +	char name[16];
> > +
> > +	struct drm_pending_vblank_event *event;
> > +
> > +	struct drm_plane planes[DE2_N_PLANES];
> > +};
> > +
> > +#define crtc_to_lcd(x) container_of(x, struct lcd, crtc)
> > +
> > +/* in de2_de.c */
> > +void de2_de_enable(struct priv *priv, int lcd_num);
> > +void de2_de_disable(struct priv *priv, int lcd_num);
> > +void de2_de_hw_init(struct priv *priv, int lcd_num);
> > +void de2_de_panel_init(struct priv *priv, int lcd_num,
> > +			struct drm_display_mode *mode);
> > +void de2_de_plane_disable(struct priv *priv,
> > +			int lcd_num, int plane_ix);
> > +void de2_de_plane_update(struct priv *priv,
> > +			int lcd_num, int plane_ix,
> > +			struct drm_plane_state *state,
> > +			struct drm_plane_state *old_state);
> 
> Does it need to be exported?

I don't understand the question.

> > +
> > +/* in de2_plane.c */
> > +int de2_plane_init(struct drm_device *drm, struct lcd *lcd);
> > +
> > +#endif /* __DE2_CRTC_H__ */
> > diff --git a/drivers/gpu/drm/sunxi/de2_de.c b/drivers/gpu/drm/sunxi/de2_de.c
> > new file mode 100644
> > index 0000000..0d8cb62
> > --- /dev/null
> > +++ b/drivers/gpu/drm/sunxi/de2_de.c
> > @@ -0,0 +1,591 @@
> > +/*
> > + * ALLWINNER DRM driver - Display Engine 2
> > + *
> > + * Copyright (C) 2016 Jean-Francois Moine <moinejf@free.fr>
> > + * Copyright (c) 2016 Allwinnertech Co., Ltd.
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License as
> > + * published by the Free Software Foundation; either version 2 of
> > + * the License, or (at your option) any later version.
> > + */
> > +
> > +#include <asm/io.h>
> > +#include <drm/drm_gem_cma_helper.h>
> > +
> > +#include "de2_drm.h"
> > +#include "de2_crtc.h"
> > +
> > +static DEFINE_SPINLOCK(de_lock);
> > +
> > +#define DE_CLK_RATE_A83T 504000000	/* pll-de */
> > +#define DE_CLK_RATE_H3 432000000	/* de */
> 
> This can be set in the DT.

That's what I had in first releases, but, recently, I saw a 'set
parent' code in a clock driver, because 'it is not the plan to expose'
some clocks in the DT. I am glad to move these clock rate settings
back to the DT.

> > +
> > +/* I/O map */
> > +
> > +#define DE_MOD_REG 0x0000	/* 1 bit per LCD */
> > +#define DE_GATE_REG 0x0004
> > +#define DE_RESET_REG 0x0008
> > +#define DE_DIV_REG 0x000c	/* 4 bits per LCD */
> > +#define DE_SEL_REG 0x0010
> > +
> > +#define DE_MUX0_BASE 0x00100000
> > +#define DE_MUX1_BASE 0x00200000
> > +
> > +/* MUX registers (addr / MUX base) */
> > +#define DE_MUX_GLB_REGS 0x00000		/* global control */
> > +#define DE_MUX_BLD_REGS 0x01000		/* alpha blending */
> > +#define DE_MUX_CHAN_REGS 0x02000	/* VI/UI overlay channels */
> > +#define		DE_MUX_CHAN_SZ 0x1000	/* size of a channel */
> > +#define DE_MUX_VSU_REGS 0x20000		/* VSU */
> > +#define DE_MUX_GSU1_REGS 0x30000	/* GSUs */
> > +#define DE_MUX_GSU2_REGS 0x40000
> > +#define DE_MUX_GSU3_REGS 0x50000
> > +#define DE_MUX_FCE_REGS 0xa0000		/* FCE */
> > +#define DE_MUX_BWS_REGS 0xa2000		/* BWS */
> > +#define DE_MUX_LTI_REGS 0xa4000		/* LTI */
> > +#define DE_MUX_PEAK_REGS 0xa6000	/* PEAK */
> > +#define DE_MUX_ASE_REGS 0xa8000		/* ASE */
> > +#define DE_MUX_FCC_REGS 0xaa000		/* FCC */
> > +#define DE_MUX_DCSC_REGS 0xb0000	/* DCSC/SMBL */
> > +
> > +/* global control */
> > +struct de_glb {
> > +	u32 ctl;
> > +#define		DE_MUX_GLB_CTL_rt_en BIT(0)
> > +#define		DE_MUX_GLB_CTL_finish_irq_en BIT(4)
> > +#define		DE_MUX_GLB_CTL_rtwb_port BIT(12)
> > +	u32 status;
> > +	u32 dbuff;
> > +	u32 size;
> > +};
> > +
> > +/* alpha blending */
> > +struct de_bld {
> > +	u32 fcolor_ctl;			/* 00 */
> > +	struct {
> > +		u32 fcolor;
> > +		u32 insize;
> > +		u32 offset;
> > +		u32 dum;
> > +	} attr[4];
> > +	u32 dum0[15];			/* (end of clear offset) */
> > +	u32 route;			/* 80 */
> > +	u32 premultiply;
> > +	u32 bkcolor;
> > +	u32 output_size;
> > +	u32 bld_mode[4];
> > +	u32 dum1[4];
> > +	u32 ck_ctl;			/* b0 */
> > +	u32 ck_cfg;
> > +	u32 dum2[2];
> > +	u32 ck_max[4];			/* c0 */
> > +	u32 dum3[4];
> > +	u32 ck_min[4];			/* e0 */
> > +	u32 dum4[3];
> > +	u32 out_ctl;			/* fc */
> > +};
> > +
> > +/* VI channel */
> > +struct de_vi {
> > +	struct {
> > +		u32 attr;
> > +#define			VI_CFG_ATTR_en BIT(0)
> > +#define			VI_CFG_ATTR_fcolor_en BIT(4)
> > +#define			VI_CFG_ATTR_fmt_SHIFT 8
> > +#define			VI_CFG_ATTR_fmt_MASK GENMASK(12, 8)
> > +#define			VI_CFG_ATTR_ui_sel BIT(15)
> > +#define			VI_CFG_ATTR_top_down BIT(23)
> > +		u32 size;
> > +		u32 coord;
> > +#define VI_N_PLANES 3
> > +		u32 pitch[VI_N_PLANES];
> > +		u32 top_laddr[VI_N_PLANES];
> > +		u32 bot_laddr[VI_N_PLANES];
> > +	} cfg[4];
> > +	u32 fcolor[4];			/* c0 */
> > +	u32 top_haddr[VI_N_PLANES];	/* d0 */
> > +	u32 bot_haddr[VI_N_PLANES];	/* dc */
> > +	u32 ovl_size[2];		/* e8 */
> > +	u32 hori[2];			/* f0 */
> > +	u32 vert[2];			/* f8 */
> > +};
> > +
> > +/* UI channel */
> > +struct de_ui {
> > +	struct {
> > +		u32 attr;
> > +#define			UI_CFG_ATTR_en BIT(0)
> > +#define			UI_CFG_ATTR_alpmod_SHIFT 1
> > +#define			UI_CFG_ATTR_alpmod_MASK GENMASK(2, 1)
> > +#define			UI_CFG_ATTR_fcolor_en BIT(4)
> > +#define			UI_CFG_ATTR_fmt_SHIFT 8
> > +#define			UI_CFG_ATTR_fmt_MASK GENMASK(12, 8)
> > +#define			UI_CFG_ATTR_top_down BIT(23)
> > +#define			UI_CFG_ATTR_alpha_SHIFT 24
> > +#define			UI_CFG_ATTR_alpha_MASK GENMASK(31, 24)
> > +		u32 size;
> > +		u32 coord;
> > +		u32 pitch;
> > +		u32 top_laddr;
> > +		u32 bot_laddr;
> > +		u32 fcolor;
> > +		u32 dum;
> > +	} cfg[4];			/* 00 */
> > +	u32 top_haddr;			/* 80 */
> > +	u32 bot_haddr;
> > +	u32 ovl_size;			/* 88 */
> > +};
> 
> Please use defines instead of the structures.

Juggling with data in arrays is painful when the offsets are defined by
defines, and structures are so much readable.

> > +
> > +/* coordinates and sizes */
> > +#define XY(x, y) (((y) << 16) | (x))
> > +#define WH(w, h) (((h - 1) << 16) | (w - 1))
> > +
> > +/* UI video formats */
> > +#define DE2_FORMAT_ARGB_8888 0
> > +#define DE2_FORMAT_BGRA_8888 3
> > +#define DE2_FORMAT_XRGB_8888 4
> > +#define DE2_FORMAT_RGB_888 8
> > +#define DE2_FORMAT_BGR_888 9
> > +
> > +/* VI video formats */
> > +#define DE2_FORMAT_YUV422_I_YVYU 1	/* Y-V-Y-U */
> > +#define DE2_FORMAT_YUV422_I_UYVY 2	/* U-Y-V-Y */
> > +#define DE2_FORMAT_YUV422_I_YUYV 3	/* Y-U-Y-V */
> > +#define DE2_FORMAT_YUV422_P 6		/* YYYY UU VV planar */
> > +#define DE2_FORMAT_YUV420_P 10		/* YYYY U V planar */
> > +
> > +#define glb_read(base, member) \
> > +	readl_relaxed(base + offsetof(struct de_glb, member))
> > +#define glb_write(base, member, data) \
> > +	writel_relaxed(data, base + offsetof(struct de_glb, member))
> > +#define bld_read(base, member) \
> > +	readl_relaxed(base + offsetof(struct de_bld, member))
> > +#define bld_write(base, member, data) \
> > +	writel_relaxed(data, base + offsetof(struct de_bld, member))
> > +#define ui_read(base, member) \
> > +	readl_relaxed(base + offsetof(struct de_ui, member))
> > +#define ui_write(base, member, data) \
> > +	writel_relaxed(data, base + offsetof(struct de_ui, member))
> > +#define vi_read(base, member) \
> > +	readl_relaxed(base + offsetof(struct de_vi, member))
> > +#define vi_write(base, member, data) \
> > +	writel_relaxed(data, base + offsetof(struct de_vi, member))
> > +
> > +static const struct {
> > +	char chan;
> > +	char layer;
> > +	char pipe;
> > +} plane2layer[DE2_N_PLANES] = {
> > +	[DE2_PRIMARY_PLANE] =	{0, 0, 0},
> > +	[DE2_CURSOR_PLANE] =	{1, 0, 1},
> > +	[DE2_VI_PLANE] =	{0, 1, 0},
> > +};
> 
> Comments?

This
	primary plane is channel 0 (VI), layer 0, pipe 0
	cursor plane is channel 1 (UI), layer 0, pipe 1
	overlay plane is channel 0 (VI), layer 1, pipe 0
or the full explanation:
    Constraints:
	The VI channels can do RGB or YUV, while UI channels can do RGB
	only.
	The LCD 0 has 1 VI channel and 4 UI channels, while
	LCD 1 has only 1 VI channel and 1 UI channel.
	The cursor must go to a channel bigger than the primary channel,
	otherwise it is not transparent.
    First try:
	Letting the primary plane (usually RGB) in the 2nd channel (UI),
	as this is done in the legacy driver, asks for the cursor to go
	to the next channel (UI), but this one does not exist in LCD1.
    Retained layout:
	So, we must use only 2 channels for the same behaviour on LCD0
	(H3) and LCD1 (A83T)
	The retained combination is:
		- primary plane in the first channel (VI),
		- cursor plane inthe 2nd channel (UI), and
		- overlay plane in the 1st channel (VI).

	Note that there could be 3 overlay planes (a channel has 4
	layers), but I am not sure that the A83T or the H3 could
	support 3 simultaneous video streams...

> > +static inline void de_write(struct priv *priv, int reg, u32 data)
> > +{
> > +	writel_relaxed(data, priv->mmio + reg);
> > +}
> > +
> > +static inline u32 de_read(struct priv *priv, int reg)
> > +{
> > +	return readl_relaxed(priv->mmio + reg);
> > +}
> > +
> > +static void de_lcd_select(struct priv *priv,
> > +			int lcd_num,
> > +			void __iomem *mux_o)
> > +{
> > +	u32 data;
> > +
> > +	/* select the LCD */
> > +	data = de_read(priv, DE_SEL_REG);
> > +	data &= ~1;
> > +	de_write(priv, DE_SEL_REG, data);
> > +
> > +	/* double register switch */
> > +	glb_write(mux_o + DE_MUX_GLB_REGS, dbuff, 1);
> > +}
> > +
> > +void de2_de_plane_update(struct priv *priv,
> > +			int lcd_num, int plane_ix,
> > +			struct drm_plane_state *state,
> > +			struct drm_plane_state *old_state)
> > +{
> > +	struct drm_framebuffer *fb = state->fb;
> > +	struct drm_gem_cma_object *gem;
> > +	void __iomem *mux_o = priv->mmio;
> > +	void __iomem *chan_o;
> > +	u32 size = WH(state->crtc_w, state->crtc_h);
> > +	u32 coord;
> > +	u32 screen_size;
> > +	u32 data, fcolor;
> > +	u32 ui_sel, alpha_glob;
> > +	int chan, layer, x, y;
> > +	unsigned fmt;
> > +	unsigned long flags;
> > +
> > +	chan = plane2layer[plane_ix].chan;
> > +	layer = plane2layer[plane_ix].layer;
> > +
> > +	mux_o += (lcd_num == 0) ? DE_MUX0_BASE : DE_MUX1_BASE;
> > +	chan_o = mux_o;
> > +	chan_o += DE_MUX_CHAN_REGS + DE_MUX_CHAN_SZ * chan;
> > +
> > +	x = state->crtc_x >= 0 ? state->crtc_x : 0;
> > +	y = state->crtc_y >= 0 ? state->crtc_y : 0;
> > +	coord = XY(x, y);
> > +
> > +	/* handle the cursor move */
> > +	if (plane_ix == DE2_CURSOR_PLANE
> > +	 && fb == old_state->fb) {
> > +		spin_lock_irqsave(&de_lock, flags);
> > +		de_lcd_select(priv, lcd_num, mux_o);
> > +		if (chan == 0)
> > +			vi_write(chan_o, cfg[layer].coord, coord);
> > +		else
> > +			ui_write(chan_o, cfg[layer].coord, coord);
> > +		spin_unlock_irqrestore(&de_lock, flags);
> > +		return;
> > +	}
> > +
> > +	gem = drm_fb_cma_get_gem_obj(fb, 0);
> > +
> > +	ui_sel = alpha_glob = 0;
> > +	switch (fb->pixel_format) {
> > +	case DRM_FORMAT_ARGB8888:
> > +		fmt = DE2_FORMAT_ARGB_8888;
> > +		ui_sel = VI_CFG_ATTR_ui_sel;
> > +		break;
> > +	case DRM_FORMAT_BGRA8888:
> > +		fmt = DE2_FORMAT_BGRA_8888;
> > +		ui_sel = VI_CFG_ATTR_ui_sel;
> > +		break;
> > +	case DRM_FORMAT_XRGB8888:
> > +		fmt = DE2_FORMAT_XRGB_8888;
> > +		ui_sel = VI_CFG_ATTR_ui_sel;
> > +		alpha_glob = (1 << UI_CFG_ATTR_alpmod_SHIFT) |
> > +				(0xff << UI_CFG_ATTR_alpha_SHIFT);
> > +		break;
> > +	case DRM_FORMAT_RGB888:
> > +		fmt = DE2_FORMAT_RGB_888;
> > +		ui_sel = VI_CFG_ATTR_ui_sel;
> > +		break;
> > +	case DRM_FORMAT_BGR888:
> > +		fmt = DE2_FORMAT_BGR_888;
> > +		ui_sel = VI_CFG_ATTR_ui_sel;
> > +		break;
> > +	case DRM_FORMAT_YUYV:
> > +		fmt = DE2_FORMAT_YUV422_I_YUYV;
> > +		break;
> > +	case DRM_FORMAT_YVYU:
> > +		fmt = DE2_FORMAT_YUV422_I_YVYU;
> > +		break;
> > +	case DRM_FORMAT_YUV422:
> > +		fmt = DE2_FORMAT_YUV422_P;
> > +		break;
> > +	case DRM_FORMAT_YUV420:
> > +		fmt = DE2_FORMAT_YUV420_P;
> > +		break;
> > +	case DRM_FORMAT_UYVY:
> > +		fmt = DE2_FORMAT_YUV422_I_UYVY;
> > +		break;
> > +	default:
> > +		pr_err("format %.4s not yet treated\n",
> > +			(char *) &fb->pixel_format);
> > +		return;
> > +	}
> > +
> > +	spin_lock_irqsave(&de_lock, flags);
> > +
> > +	screen_size = plane_ix == DE2_PRIMARY_PLANE ?
> > +			size :
> > +			glb_read(mux_o + DE_MUX_GLB_REGS, size);
> > +
> > +	/* prepare the activation of alpha blending (1 bit per plane) */
> > +	fcolor = bld_read(mux_o + DE_MUX_BLD_REGS, fcolor_ctl)
> > +			| (0x100 << plane2layer[plane_ix].pipe);
> > +
> > +	de_lcd_select(priv, lcd_num, mux_o);
> > +
> > +	if (chan == 0) {	/* VI channel */
> > +		int i;
> > +
> > +		data = VI_CFG_ATTR_en | (fmt << VI_CFG_ATTR_fmt_SHIFT) |
> > +					ui_sel;
> > +		vi_write(chan_o, cfg[layer].attr, data);
> > +		vi_write(chan_o, cfg[layer].size, size);
> > +		vi_write(chan_o, cfg[layer].coord, coord);
> > +		for (i = 0; i < VI_N_PLANES; i++) {
> > +			vi_write(chan_o, cfg[layer].pitch[i],
> > +					fb->pitches[i] ? fb->pitches[i] :
> > +							fb->pitches[0]);
> > +			vi_write(chan_o, cfg[layer].top_laddr[i],
> > +				gem->paddr + fb->offsets[i]);
> > +			vi_write(chan_o, fcolor[layer], 0xff000000);
> > +		}
> > +		if (layer == 0)
> > +			vi_write(chan_o, ovl_size[0], screen_size);
> > +
> > +	} else {		/* UI channel */
> > +		data = UI_CFG_ATTR_en | (fmt << UI_CFG_ATTR_fmt_SHIFT) |
> > +			alpha_glob;
> > +		ui_write(chan_o, cfg[layer].attr, data);
> > +		ui_write(chan_o, cfg[layer].size, size);
> > +		ui_write(chan_o, cfg[layer].coord, coord);
> > +		ui_write(chan_o, cfg[layer].pitch, fb->pitches[0]);
> > +		ui_write(chan_o, cfg[layer].top_laddr,
> > +				gem->paddr + fb->offsets[0]);
> > +		if (layer == 0)
> > +			ui_write(chan_o, ovl_size, screen_size);
> > +	}
> > +	bld_write(mux_o + DE_MUX_BLD_REGS, fcolor_ctl, fcolor);
> > +
> > +	spin_unlock_irqrestore(&de_lock, flags);
> > +}
> 
> Splitting that into functions would make it a bit more trivial and
> readable.

Not sure: there is a lot of common data and different I/O accesses.

> > +void de2_de_plane_disable(struct priv *priv,
> > +			int lcd_num, int plane_ix)
> > +{
> > +	void __iomem *mux_o = priv->mmio;
> > +	void __iomem *chan_o;
> > +	u32 fcolor;
> > +	int chan, layer, chan_disable = 0;
> > +	unsigned long flags;
> > +
> > +	chan = plane2layer[plane_ix].chan;
> > +	layer = plane2layer[plane_ix].layer;
> > +
> > +	mux_o += (lcd_num == 0) ? DE_MUX0_BASE : DE_MUX1_BASE;
> > +	chan_o = mux_o;
> > +	chan_o += DE_MUX_CHAN_REGS + DE_MUX_CHAN_SZ * chan;
> > +
> > +	/* (only 2 layers) */
> > +	if (chan == 0) {
> > +		if (vi_read(chan_o, cfg[1 - layer].attr) == 0)
> > +			chan_disable = 1;
> > +	} else {
> > +		if (ui_read(chan_o, cfg[1 - layer].attr) == 0)
> > +			chan_disable = 1;
> > +	}
> > +
> > +	spin_lock_irqsave(&de_lock, flags);
> > +
> > +	fcolor = bld_read(mux_o + DE_MUX_BLD_REGS, fcolor_ctl);
> > +
> > +	de_lcd_select(priv, lcd_num, mux_o);
> > +
> > +	if (chan == 0)
> > +		vi_write(chan_o, cfg[layer].attr, 0);
> > +	else
> > +		ui_write(chan_o, cfg[layer].attr, 0);
> > +
> > +	if (chan_disable)
> > +		bld_write(mux_o + DE_MUX_BLD_REGS, fcolor_ctl,
> > +			fcolor & ~(0x100 << plane2layer[plane_ix].pipe));
> > +
> > +	spin_unlock_irqrestore(&de_lock, flags);
> > +}
> 
> Can't you just disable it?

Which 'it'? A layer must be disabled and it is not useful to let the
DE2 processor to scan a pipe (channel) without any layer.

> > +void de2_de_panel_init(struct priv *priv, int lcd_num,
> > +			struct drm_display_mode *mode)
> > +{
> > +	void __iomem *mux_o = priv->mmio;
> > +	u32 size = WH(mode->hdisplay, mode->vdisplay);
> > +	unsigned i;
> > +	unsigned long flags;
> > +
> > +	mux_o += (lcd_num == 0) ? DE_MUX0_BASE : DE_MUX1_BASE;
> > +
> > +	DRM_DEBUG_DRIVER("%dx%d\n", mode->hdisplay, mode->vdisplay);
> > +
> > +	spin_lock_irqsave(&de_lock, flags);
> > +
> > +	de_lcd_select(priv, lcd_num, mux_o);
> > +
> > +	glb_write(mux_o + DE_MUX_GLB_REGS, size, size);
> > +
> > +	/* set alpha blending */
> > +	for (i = 0; i < 4; i++) {
> > +		bld_write(mux_o + DE_MUX_BLD_REGS, attr[i].fcolor, 0xff000000);
> > +		bld_write(mux_o + DE_MUX_BLD_REGS, attr[i].insize, size);
> > +	}
> > +	bld_write(mux_o + DE_MUX_BLD_REGS, output_size, size);
> > +	bld_write(mux_o + DE_MUX_BLD_REGS, out_ctl,
> > +			mode->flags & DRM_MODE_FLAG_INTERLACE ? 2 : 0);
> > +
> > +	spin_unlock_irqrestore(&de_lock, flags);
> > +}
> > +
> > +void de2_de_enable(struct priv *priv, int lcd_num)
> > +{
	[snip]
> > +}
> > +
> > +void de2_de_disable(struct priv *priv, int lcd_num)
> > +{
> > +	u32 data;
> > +
> > +	data = ~(1 << lcd_num);
> > +	de_write(priv, DE_MOD_REG,
> > +			de_read(priv, DE_MOD_REG) & data);
> > +	de_write(priv, DE_GATE_REG,
> > +			de_read(priv, DE_GATE_REG) & data);
> > +	de_write(priv, DE_RESET_REG,
> > +			de_read(priv, DE_RESET_REG) & data);
> > +}
> > +
> > +int de2_de_init(struct priv *priv, struct device *dev)
> > +{
> > +	struct resource *res;
> > +	int ret;
> > +
> > +	DRM_DEBUG_DRIVER("\n");
> > +
> > +	res = platform_get_resource(to_platform_device(dev),
> > +				IORESOURCE_MEM, 0);
> > +	if (!res) {
> > +		dev_err(dev, "failed to get memory resource\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	priv->mmio = devm_ioremap_resource(dev, res);
> > +	if (IS_ERR(priv->mmio)) {
> > +		dev_err(dev, "failed to map registers\n");
> > +		return PTR_ERR(priv->mmio);
> > +	}
> > +
> > +	priv->gate = devm_clk_get(dev, "gate");	/* optional */
> 
> Error checking
> 
> > +
> > +	priv->clk = devm_clk_get(dev, "clock");
> > +	if (IS_ERR(priv->clk)) {
> > +		dev_err(dev, "video clock err %d\n", (int) PTR_ERR(priv->clk));
> > +		return PTR_ERR(priv->clk);
> > +	}
> > +
> > +	priv->rstc = devm_reset_control_get_optional(dev, NULL);
> > +
> > +	if (!IS_ERR(priv->rstc)) {
> > +		ret = reset_control_deassert(priv->rstc);
> > +		if (ret) {
> > +			dev_err(dev, "reset deassert err %d\n", ret);
> > +			return ret;
> > +		}
> > +	}
> > +
> > +	if (!IS_ERR(priv->gate)) {
> > +		ret = clk_prepare_enable(priv->gate);
> > +		if (ret)
> > +			goto err_gate;
> > +	}
> > +
> > +	ret = clk_prepare_enable(priv->clk);
> > +	if (ret)
> > +		goto err_enable;
> > +	if (priv->soc_type == SOC_A83T)
> > +		clk_set_rate(priv->clk, DE_CLK_RATE_A83T);
> > +	else
> > +		clk_set_rate(priv->clk, DE_CLK_RATE_H3);
> > +
> > +	/* set the A83T clock divider = 500 / 250 */
> > +	if (priv->soc_type == SOC_A83T)
> > +		de_write(priv, DE_DIV_REG,
> > +				0x00000011);	/* div = 2 for both LCDs */
> > +
> > +	return 0;
> > +
> > +err_enable:
> > +	clk_disable_unprepare(priv->gate);
> > +err_gate:
> > +	if (!IS_ERR(priv->rstc))
> > +		reset_control_assert(priv->rstc);
> > +	return ret;
> > +}
> > +
> > +void de2_de_cleanup(struct priv *priv)
> > +{
> > +	clk_disable_unprepare(priv->clk);
> > +	clk_disable_unprepare(priv->gate);
> > +	if (!IS_ERR(priv->rstc))
> > +		reset_control_assert(priv->rstc);
> > +}
	[snip]
> > diff --git a/drivers/gpu/drm/sunxi/de2_drv.c b/drivers/gpu/drm/sunxi/de2_drv.c
> > new file mode 100644
> > index 0000000..5daa15c
> > --- /dev/null
> > +++ b/drivers/gpu/drm/sunxi/de2_drv.c
	[snip]
> > +
> > +#ifdef CONFIG_PM_SLEEP
> > +/*
> > + * Power management
> > + */
> > +static int de2_pm_suspend(struct device *dev)
> > +{
> > +	struct drm_device *drm = dev_get_drvdata(dev);
> > +
> > +	drm_kms_helper_poll_disable(drm);
> > +	return 0;
> > +}
> > +
> > +static int de2_pm_resume(struct device *dev)
> > +{
> > +	struct drm_device *drm = dev_get_drvdata(dev);
> > +
> > +	drm_kms_helper_poll_enable(drm);
> > +	return 0;
> > +}
> > +#endif
> > +
> > +static const struct dev_pm_ops de2_pm_ops = {
> > +	SET_SYSTEM_SLEEP_PM_OPS(de2_pm_suspend, de2_pm_resume)
> > +};
> 
> Why do you need that? How did you test it? There's no runtime_pm calls
> in your kernel.

That's not tested. I will remove this.

	[snip]
> > +static struct platform_driver de2_drm_platform_driver = {
> > +	.probe      = de2_drm_probe,
> > +	.remove     = de2_drm_remove,
> > +	.driver     = {
> > +		.name = DRIVER_NAME,
> > +		.pm = &de2_pm_ops,
> > +		.of_match_table = de2_drm_of_match,
> > +	},
> > +};
> > +
> > +static int __init de2_drm_init(void)
> > +{
> > +	int ret;
> > +
> > +/* uncomment to activate the drm traces at startup time */
> > +/*	drm_debug = DRM_UT_CORE | DRM_UT_DRIVER | DRM_UT_KMS |
> > +			DRM_UT_PRIME | DRM_UT_ATOMIC; */
> 
> That's useless.

Right, but it seems that some people don't know how to debug a DRM
driver. This is only a reminder.

> > +	DRM_DEBUG_DRIVER("\n");
> > +
> > +	ret = platform_driver_register(&de2_lcd_platform_driver);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = platform_driver_register(&de2_drm_platform_driver);
> > +	if (ret < 0)
> > +		platform_driver_unregister(&de2_lcd_platform_driver);
> > +
> > +	return ret;
> > +}
> 
> And that really shouldn't be done that way.

May you explain?

> > +static void __exit de2_drm_fini(void)
> > +{
> > +	platform_driver_unregister(&de2_lcd_platform_driver);
> > +	platform_driver_unregister(&de2_drm_platform_driver);
> > +}
> > +
> > +module_init(de2_drm_init);
> > +module_exit(de2_drm_fini);
> > +
> > +MODULE_AUTHOR("Jean-Francois Moine <moinejf@free.fr>");
> > +MODULE_DESCRIPTION("Allwinner DE2 DRM Driver");
> > +MODULE_LICENSE("GPL v2");
> > diff --git a/drivers/gpu/drm/sunxi/de2_plane.c b/drivers/gpu/drm/sunxi/de2_plane.c
> > new file mode 100644
> > index 0000000..b338684
> > --- /dev/null
> > +++ b/drivers/gpu/drm/sunxi/de2_plane.c
> > @@ -0,0 +1,119 @@
> > +/*
> > + * Allwinner DRM driver - DE2 planes
> > + *
> > + * Copyright (C) 2016 Jean-Francois Moine <moinejf@free.fr>
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License as
> > + * published by the Free Software Foundation; either version 2 of
> > + * the License, or (at your option) any later version.
> > + */
> > +
> > +#include <drm/drm_atomic_helper.h>
> > +#include <drm/drm_plane_helper.h>
> > +#include <drm/drm_crtc_helper.h>
> > +
> > +#include "de2_drm.h"
> > +#include "de2_crtc.h"
> > +
> > +/* plane formats */
> > +static const uint32_t ui_formats[] = {
> > +	DRM_FORMAT_ARGB8888,
> > +	DRM_FORMAT_BGRA8888,
> > +	DRM_FORMAT_XRGB8888,
> > +	DRM_FORMAT_RGB888,
> > +	DRM_FORMAT_BGR888,
> > +};
> > +
> > +static const uint32_t vi_formats[] = {
> > +	DRM_FORMAT_XRGB8888,
> > +	DRM_FORMAT_YUYV,
> > +	DRM_FORMAT_YVYU,
> > +	DRM_FORMAT_YUV422,
> > +	DRM_FORMAT_YUV420,
> > +	DRM_FORMAT_UYVY,
> > +	DRM_FORMAT_BGRA8888,
> > +	DRM_FORMAT_RGB888,
> > +	DRM_FORMAT_BGR888,
> > +};
	[snip]
> > +static int de2_one_plane_init(struct drm_device *drm,
> > +				struct drm_plane *plane,
> > +				int type, int possible_crtcs,
> > +				const uint32_t *formats,
> > +				int nformats)
> > +{
> > +	int ret;
> > +
> > +	ret = drm_universal_plane_init(drm, plane, possible_crtcs,
> > +				&plane_funcs,
> > +				formats, nformats, type, NULL);
> > +	if (ret >= 0)
> > +		drm_plane_helper_add(plane, &plane_helper_funcs);
> > +
> > +	return ret;
> > +}
> > +
> > +int de2_plane_init(struct drm_device *drm, struct lcd *lcd)
> > +{
> > +	int ret, possible_crtcs = 1 << lcd->crtc_idx;
> > +
> > +	ret = de2_one_plane_init(drm, &lcd->planes[DE2_PRIMARY_PLANE],
> > +				DRM_PLANE_TYPE_PRIMARY, possible_crtcs,
> > +				ui_formats, ARRAY_SIZE(ui_formats));
> > +	if (ret >= 0)
> > +		ret = de2_one_plane_init(drm, &lcd->planes[DE2_CURSOR_PLANE],
> > +				DRM_PLANE_TYPE_CURSOR, possible_crtcs,
> > +				ui_formats, ARRAY_SIZE(ui_formats));
> 
> Nothing looks really special about that cursor plane. Any reasion not
> to make it an overlay?

As explained above (channel/layer/pipe plane definitions), the cursor
cannot go in a channel lower or equal to the one of the primary plane.
Then, it must be known and, so, have an explicit plane.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
