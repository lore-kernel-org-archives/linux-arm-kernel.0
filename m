From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 28 Oct 2016 00:03:16 +0200
Subject: [PATCH v5 1/7] drm: sunxi: Add a basic DRM driver for Allwinner
 DE2
In-Reply-To: <20161025161441.6b248efe9229bd80e3f7a33c@free.fr>
References: <cover.1477142934.git.moinejf@free.fr>
 <8afc5e020c5767face34fe3a9ab300ce9e67ba00.1477142934.git.moinejf@free.fr>
 <20161024140419.ah6hywf3b24pj3fv@lukather>
 <20161025161441.6b248efe9229bd80e3f7a33c@free.fr>
Message-ID: <20161027220316.y7u3h4qsfftryrmp@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 25, 2016 at 04:14:41PM +0200, Jean-Francois Moine wrote:
> > > +Display controller
> > > +==================
> > > +
> > > +Required properties:
> > > +
> > > +- compatible: value should be one of the following
> > > +		"allwinner,sun8i-a83t-display-engine"
> > > +		"allwinner,sun8i-h3-display-engine"
> > > +
> > > +- clocks: must include clock specifiers corresponding to entries in the
> > > +		clock-names property.
> > > +
> > > +- clock-names: must contain
> > > +		"gate": for DE activation
> > > +		"clock": DE clock
> > 
> > We've been calling them bus and mod.
> 
> I can understand "bus" (which is better than "apb"), but why "mod"?

Allwinner has been calling the clocks that are supposed to generate
the external signals (depending on where you were looking) module or
mod clocks (which is also why we have mod in the clock
compatibles). The module 1 clocks being used for the audio and the
module 0 for the rest (SPI, MMC, NAND, display, etc.)

> > > +
> > > +- resets: phandle to the reset of the device
> > > +
> > > +- ports: phandle's to the LCD ports
> > 
> > Please use the OF graph.
> 
> These ports are references to the graph of nodes. See
> 	http://www.kernelhub.org/?msg=911825&p=2

In an OF-graph, your phandle to the LCD controller would be replaced
by an output endpoint.

> 
> 	[snip]
> > > +struct tcon {
> > > +	u32 gctl;
> > > +#define		TCON_GCTL_TCON_En BIT(31)
> > > +	u32 gint0;
> > > +#define		TCON_GINT0_TCON1_Vb_Int_En BIT(30)
> > > +#define		TCON_GINT0_TCON1_Vb_Int_Flag BIT(14)
> > > +	u32 gint1;
> > > +	u32 dum0[13];
> > > +	u32 tcon0_ctl;				/* 0x40 */
> > > +#define		TCON0_CTL_TCON_En BIT(31)
> > > +	u32 dum1[19];
> > > +	u32 tcon1_ctl;				/* 0x90 */
> > > +#define		TCON1_CTL_TCON_En BIT(31)
> > > +#define		TCON1_CTL_Interlace_En BIT(20)
> > > +#define		TCON1_CTL_Start_Delay_SHIFT 4
> > > +#define		TCON1_CTL_Start_Delay_MASK GENMASK(8, 4)
> > > +	u32 basic0;			/* XI/YI */
> > > +	u32 basic1;			/* LS_XO/LS_YO */
> > > +	u32 basic2;			/* XO/YO */
> > > +	u32 basic3;			/* HT/HBP */
> > > +	u32 basic4;			/* VT/VBP */
> > > +	u32 basic5;			/* HSPW/VSPW */
> > > +	u32 dum2;
> > > +	u32 ps_sync;				/* 0xb0 */
> > > +	u32 dum3[15];
> > > +	u32 io_pol;				/* 0xf0 */
> > > +#define		TCON1_IO_POL_IO0_inv BIT(24)
> > > +#define		TCON1_IO_POL_IO1_inv BIT(25)
> > > +#define		TCON1_IO_POL_IO2_inv BIT(26)
> > > +	u32 io_tri;
> > > +	u32 dum4[2];
> > > +
> > > +	u32 ceu_ctl;				/* 0x100 */
> > > +#define     TCON_CEU_CTL_ceu_en BIT(31)
> > > +	u32 dum5[3];
> > > +	u32 ceu_rr;
> > > +	u32 ceu_rg;
> > > +	u32 ceu_rb;
> > > +	u32 ceu_rc;
> > > +	u32 ceu_gr;
> > > +	u32 ceu_gg;
> > > +	u32 ceu_gb;
> > > +	u32 ceu_gc;
> > > +	u32 ceu_br;
> > > +	u32 ceu_bg;
> > > +	u32 ceu_bb;
> > > +	u32 ceu_bc;
> > > +	u32 ceu_rv;
> > > +	u32 ceu_gv;
> > > +	u32 ceu_bv;
> > > +	u32 dum6[45];
> > > +
> > > +	u32 mux_ctl;				/* 0x200 */
> > > +	u32 dum7[63];
> > > +
> > > +	u32 fill_ctl;				/* 0x300 */
> > > +	u32 fill_start0;
> > > +	u32 fill_end0;
> > > +	u32 fill_data0;
> > > +};
> > 
> > Please use defines instead of the structures.
> 
> I think that structures are more readable.

That's not really the point. No one in the kernel uses it (and even
you use defines for registers offset in some places of that
patch). And then you have Andr? arguments.

> > > +void de2_disable_vblank(struct drm_device *drm, unsigned crtc)
> > > +{
> > > +	struct priv *priv = drm->dev_private;
> > > +	struct lcd *lcd = priv->lcds[crtc];
> > > +
> > > +	tcon_write(lcd->mmio, gint0,
> > > +			 tcon_read(lcd->mmio, gint0) &
> > > +					~TCON_GINT0_TCON1_Vb_Int_En);
> > > +}
> > > +
> > > +/* panel functions */
> > 
> > Panel functions? In the CRTC driver?
> 
> Yes, dumb panel.

What do you mean by that? Using a Parallel/RGB interface?

> 
> > > +static void de2_set_frame_timings(struct lcd *lcd)
> > > +{
> > > +	struct drm_crtc *crtc = &lcd->crtc;
> > > +	const struct drm_display_mode *mode = &crtc->mode;
> > > +	int interlace = mode->flags & DRM_MODE_FLAG_INTERLACE ? 2 : 1;
> > > +	int start_delay;
> > > +	u32 data;
> > > +
> > > +	data = XY(mode->hdisplay - 1, mode->vdisplay / interlace - 1);
> > > +	tcon_write(lcd->mmio, basic0, data);
> > > +	tcon_write(lcd->mmio, basic1, data);
> > > +	tcon_write(lcd->mmio, basic2, data);
> > > +	tcon_write(lcd->mmio, basic3,
> > > +			XY(mode->htotal - 1,
> > > +				mode->htotal - mode->hsync_start - 1));
> > > +	tcon_write(lcd->mmio, basic4,
> > > +			XY(mode->vtotal * (3 - interlace),
> > > +				mode->vtotal - mode->vsync_start - 1));
> > > +	tcon_write(lcd->mmio, basic5,
> > > +			 XY(mode->hsync_end - mode->hsync_start - 1,
> > > +				mode->vsync_end - mode->vsync_start - 1));
> > > +
> > > +	tcon_write(lcd->mmio, ps_sync, XY(1, 1));
> > > +
> > > +	data = TCON1_IO_POL_IO2_inv;
> > > +	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
> > > +		data |= TCON1_IO_POL_IO0_inv;
> > > +	if (mode->flags & DRM_MODE_FLAG_PHSYNC)
> > > +		data |= TCON1_IO_POL_IO1_inv;
> > > +	tcon_write(lcd->mmio, io_pol, data);
> > > +
> > > +	tcon_write(lcd->mmio, ceu_ctl,
> > > +		tcon_read(lcd->mmio, ceu_ctl) & ~TCON_CEU_CTL_ceu_en);
> > > +
> > > +	data = tcon_read(lcd->mmio, tcon1_ctl);
> > > +	if (interlace == 2)
> > > +		data |= TCON1_CTL_Interlace_En;
> > > +	else
> > > +		data &= ~TCON1_CTL_Interlace_En;
> > > +	tcon_write(lcd->mmio, tcon1_ctl, data);
> > > +
> > > +	tcon_write(lcd->mmio, fill_ctl, 0);
> > > +	tcon_write(lcd->mmio, fill_start0, mode->vtotal + 1);
> > > +	tcon_write(lcd->mmio, fill_end0, mode->vtotal);
> > > +	tcon_write(lcd->mmio, fill_data0, 0);
> > > +
> > > +	start_delay = (mode->vtotal - mode->vdisplay) / interlace - 5;
> > > +	if (start_delay > 31)
> > > +		start_delay = 31;
> > > +	data = tcon_read(lcd->mmio, tcon1_ctl);
> > > +	data &= ~TCON1_CTL_Start_Delay_MASK;
> > > +	data |= start_delay << TCON1_CTL_Start_Delay_SHIFT;
> > > +	tcon_write(lcd->mmio, tcon1_ctl, data);
> > > +
> > > +	tcon_write(lcd->mmio, io_tri, 0x0fffffff);
> > > +}
> > 
> > Some comments here would be nice, there's a lot of non trivial things.
> 
> ... and no documentation. I just set the values I saw in the I/O memory
> when running the legacy driver.

That's bad (but definitely not your fault) :/

> > > +	lcd->gate = devm_clk_get(dev, "gate");		/* optional */
> > 
> > Having some kind of error checking would still be nice.
> 
> And cancel the device creation?

Well, yes. If it cannot enable it, it will at best not work properly,
at worst be reset, so it won't be very useful anyway.

> > > +	if (!IS_ERR(lcd->rstc)) {
> > > +		ret = reset_control_deassert(lcd->rstc);
> > > +		if (ret) {
> > > +			dev_err(dev, "reset deassert err %d\n", ret);
> > > +			goto err;
> > > +		}
> > > +	}
> > > +
> > > +	if (!IS_ERR(lcd->gate)) {
> > > +		ret = clk_prepare_enable(lcd->gate);
> > > +		if (ret)
> > > +			goto err2;
> > > +	}
> > > +
> > > +	ret = clk_prepare_enable(lcd->clk);
> > > +	if (ret)
> > > +		goto err2;
> > 
> > Is there any reason not to do that in the enable / disable? Leaving
> > clocks running while the device has no guarantee that it's going to be
> > used seems like a waste of resources.
> 
> If the machine does not need video (network server, router..), it is simpler
> to prevent the video driver to be loaded (DT, module black list...).

You might not have control on any of it, or you might just have no
monitor attached for example. Recompiling the kernel or updating the
DT when you want to plug an HDMI monitor seems like a poor UX :)

> > > +static const struct {
> > > +	char chan;
> > > +	char layer;
> > > +	char pipe;
> > > +} plane2layer[DE2_N_PLANES] = {
> > > +	[DE2_PRIMARY_PLANE] =	{0, 0, 0},
> > > +	[DE2_CURSOR_PLANE] =	{1, 0, 1},
> > > +	[DE2_VI_PLANE] =	{0, 1, 0},
> > > +};
> > 
> > Comments?
> 
> This
> 	primary plane is channel 0 (VI), layer 0, pipe 0
> 	cursor plane is channel 1 (UI), layer 0, pipe 1
> 	overlay plane is channel 0 (VI), layer 1, pipe 0
> or the full explanation:
>     Constraints:
> 	The VI channels can do RGB or YUV, while UI channels can do RGB
> 	only.
> 	The LCD 0 has 1 VI channel and 4 UI channels, while
> 	LCD 1 has only 1 VI channel and 1 UI channel.
> 	The cursor must go to a channel bigger than the primary channel,
> 	otherwise it is not transparent.
>     First try:
> 	Letting the primary plane (usually RGB) in the 2nd channel (UI),
> 	as this is done in the legacy driver, asks for the cursor to go
> 	to the next channel (UI), but this one does not exist in LCD1.
>     Retained layout:
> 	So, we must use only 2 channels for the same behaviour on LCD0
> 	(H3) and LCD1 (A83T)
> 	The retained combination is:
> 		- primary plane in the first channel (VI),
> 		- cursor plane inthe 2nd channel (UI), and
> 		- overlay plane in the 1st channel (VI).
> 
> 	Note that there could be 3 overlay planes (a channel has 4
> 	layers), but I am not sure that the A83T or the H3 could
> 	support 3 simultaneous video streams...

Do you know if the pipe works in the old display engine?

Especially about the two-steps composition that wouldn't allow you to
have alpha on all the planes?

If it is similar, I think hardcoding the pipe number is pretty bad,
because that would restrict the combination of planes and formats,
while some other might have worked.

> > > +static inline void de_write(struct priv *priv, int reg, u32 data)
> > > +{
> > > +	writel_relaxed(data, priv->mmio + reg);
> > > +}
> > > +
> > > +static inline u32 de_read(struct priv *priv, int reg)
> > > +{
> > > +	return readl_relaxed(priv->mmio + reg);
> > > +}
> > > +
> > > +static void de_lcd_select(struct priv *priv,
> > > +			int lcd_num,
> > > +			void __iomem *mux_o)
> > > +{
> > > +	u32 data;
> > > +
> > > +	/* select the LCD */
> > > +	data = de_read(priv, DE_SEL_REG);
> > > +	data &= ~1;
> > > +	de_write(priv, DE_SEL_REG, data);
> > > +
> > > +	/* double register switch */
> > > +	glb_write(mux_o + DE_MUX_GLB_REGS, dbuff, 1);
> > > +}
> > > +
> > > +void de2_de_plane_update(struct priv *priv,
> > > +			int lcd_num, int plane_ix,
> > > +			struct drm_plane_state *state,
> > > +			struct drm_plane_state *old_state)
> > > +{
> > > +	struct drm_framebuffer *fb = state->fb;
> > > +	struct drm_gem_cma_object *gem;
> > > +	void __iomem *mux_o = priv->mmio;
> > > +	void __iomem *chan_o;
> > > +	u32 size = WH(state->crtc_w, state->crtc_h);
> > > +	u32 coord;
> > > +	u32 screen_size;
> > > +	u32 data, fcolor;
> > > +	u32 ui_sel, alpha_glob;
> > > +	int chan, layer, x, y;
> > > +	unsigned fmt;
> > > +	unsigned long flags;
> > > +
> > > +	chan = plane2layer[plane_ix].chan;
> > > +	layer = plane2layer[plane_ix].layer;
> > > +
> > > +	mux_o += (lcd_num == 0) ? DE_MUX0_BASE : DE_MUX1_BASE;
> > > +	chan_o = mux_o;
> > > +	chan_o += DE_MUX_CHAN_REGS + DE_MUX_CHAN_SZ * chan;
> > > +
> > > +	x = state->crtc_x >= 0 ? state->crtc_x : 0;
> > > +	y = state->crtc_y >= 0 ? state->crtc_y : 0;
> > > +	coord = XY(x, y);
> > > +
> > > +	/* handle the cursor move */
> > > +	if (plane_ix == DE2_CURSOR_PLANE
> > > +	 && fb == old_state->fb) {
> > > +		spin_lock_irqsave(&de_lock, flags);
> > > +		de_lcd_select(priv, lcd_num, mux_o);
> > > +		if (chan == 0)
> > > +			vi_write(chan_o, cfg[layer].coord, coord);
> > > +		else
> > > +			ui_write(chan_o, cfg[layer].coord, coord);
> > > +		spin_unlock_irqrestore(&de_lock, flags);
> > > +		return;
> > > +	}
> > > +
> > > +	gem = drm_fb_cma_get_gem_obj(fb, 0);
> > > +
> > > +	ui_sel = alpha_glob = 0;
> > > +	switch (fb->pixel_format) {
> > > +	case DRM_FORMAT_ARGB8888:
> > > +		fmt = DE2_FORMAT_ARGB_8888;
> > > +		ui_sel = VI_CFG_ATTR_ui_sel;
> > > +		break;
> > > +	case DRM_FORMAT_BGRA8888:
> > > +		fmt = DE2_FORMAT_BGRA_8888;
> > > +		ui_sel = VI_CFG_ATTR_ui_sel;
> > > +		break;
> > > +	case DRM_FORMAT_XRGB8888:
> > > +		fmt = DE2_FORMAT_XRGB_8888;
> > > +		ui_sel = VI_CFG_ATTR_ui_sel;
> > > +		alpha_glob = (1 << UI_CFG_ATTR_alpmod_SHIFT) |
> > > +				(0xff << UI_CFG_ATTR_alpha_SHIFT);
> > > +		break;
> > > +	case DRM_FORMAT_RGB888:
> > > +		fmt = DE2_FORMAT_RGB_888;
> > > +		ui_sel = VI_CFG_ATTR_ui_sel;
> > > +		break;
> > > +	case DRM_FORMAT_BGR888:
> > > +		fmt = DE2_FORMAT_BGR_888;
> > > +		ui_sel = VI_CFG_ATTR_ui_sel;
> > > +		break;
> > > +	case DRM_FORMAT_YUYV:
> > > +		fmt = DE2_FORMAT_YUV422_I_YUYV;
> > > +		break;
> > > +	case DRM_FORMAT_YVYU:
> > > +		fmt = DE2_FORMAT_YUV422_I_YVYU;
> > > +		break;
> > > +	case DRM_FORMAT_YUV422:
> > > +		fmt = DE2_FORMAT_YUV422_P;
> > > +		break;
> > > +	case DRM_FORMAT_YUV420:
> > > +		fmt = DE2_FORMAT_YUV420_P;
> > > +		break;
> > > +	case DRM_FORMAT_UYVY:
> > > +		fmt = DE2_FORMAT_YUV422_I_UYVY;
> > > +		break;
> > > +	default:
> > > +		pr_err("format %.4s not yet treated\n",
> > > +			(char *) &fb->pixel_format);
> > > +		return;
> > > +	}
> > > +
> > > +	spin_lock_irqsave(&de_lock, flags);
> > > +
> > > +	screen_size = plane_ix == DE2_PRIMARY_PLANE ?
> > > +			size :
> > > +			glb_read(mux_o + DE_MUX_GLB_REGS, size);
> > > +
> > > +	/* prepare the activation of alpha blending (1 bit per plane) */
> > > +	fcolor = bld_read(mux_o + DE_MUX_BLD_REGS, fcolor_ctl)
> > > +			| (0x100 << plane2layer[plane_ix].pipe);
> > > +
> > > +	de_lcd_select(priv, lcd_num, mux_o);
> > > +
> > > +	if (chan == 0) {	/* VI channel */
> > > +		int i;
> > > +
> > > +		data = VI_CFG_ATTR_en | (fmt << VI_CFG_ATTR_fmt_SHIFT) |
> > > +					ui_sel;
> > > +		vi_write(chan_o, cfg[layer].attr, data);
> > > +		vi_write(chan_o, cfg[layer].size, size);
> > > +		vi_write(chan_o, cfg[layer].coord, coord);
> > > +		for (i = 0; i < VI_N_PLANES; i++) {
> > > +			vi_write(chan_o, cfg[layer].pitch[i],
> > > +					fb->pitches[i] ? fb->pitches[i] :
> > > +							fb->pitches[0]);
> > > +			vi_write(chan_o, cfg[layer].top_laddr[i],
> > > +				gem->paddr + fb->offsets[i]);
> > > +			vi_write(chan_o, fcolor[layer], 0xff000000);
> > > +		}
> > > +		if (layer == 0)
> > > +			vi_write(chan_o, ovl_size[0], screen_size);
> > > +
> > > +	} else {		/* UI channel */
> > > +		data = UI_CFG_ATTR_en | (fmt << UI_CFG_ATTR_fmt_SHIFT) |
> > > +			alpha_glob;
> > > +		ui_write(chan_o, cfg[layer].attr, data);
> > > +		ui_write(chan_o, cfg[layer].size, size);
> > > +		ui_write(chan_o, cfg[layer].coord, coord);
> > > +		ui_write(chan_o, cfg[layer].pitch, fb->pitches[0]);
> > > +		ui_write(chan_o, cfg[layer].top_laddr,
> > > +				gem->paddr + fb->offsets[0]);
> > > +		if (layer == 0)
> > > +			ui_write(chan_o, ovl_size, screen_size);
> > > +	}
> > > +	bld_write(mux_o + DE_MUX_BLD_REGS, fcolor_ctl, fcolor);
> > > +
> > > +	spin_unlock_irqrestore(&de_lock, flags);
> > > +}
> > 
> > Splitting that into functions would make it a bit more trivial and
> > readable.
> 
> Not sure: there is a lot of common data and different I/O accesses.

You could still have different ones to set the buffers, formats and
coordinates for example.

> > > +void de2_de_plane_disable(struct priv *priv,
> > > +			int lcd_num, int plane_ix)
> > > +{
> > > +	void __iomem *mux_o = priv->mmio;
> > > +	void __iomem *chan_o;
> > > +	u32 fcolor;
> > > +	int chan, layer, chan_disable = 0;
> > > +	unsigned long flags;
> > > +
> > > +	chan = plane2layer[plane_ix].chan;
> > > +	layer = plane2layer[plane_ix].layer;
> > > +
> > > +	mux_o += (lcd_num == 0) ? DE_MUX0_BASE : DE_MUX1_BASE;
> > > +	chan_o = mux_o;
> > > +	chan_o += DE_MUX_CHAN_REGS + DE_MUX_CHAN_SZ * chan;
> > > +
> > > +	/* (only 2 layers) */
> > > +	if (chan == 0) {
> > > +		if (vi_read(chan_o, cfg[1 - layer].attr) == 0)
> > > +			chan_disable = 1;
> > > +	} else {
> > > +		if (ui_read(chan_o, cfg[1 - layer].attr) == 0)
> > > +			chan_disable = 1;
> > > +	}
> > > +
> > > +	spin_lock_irqsave(&de_lock, flags);
> > > +
> > > +	fcolor = bld_read(mux_o + DE_MUX_BLD_REGS, fcolor_ctl);
> > > +
> > > +	de_lcd_select(priv, lcd_num, mux_o);
> > > +
> > > +	if (chan == 0)
> > > +		vi_write(chan_o, cfg[layer].attr, 0);
> > > +	else
> > > +		ui_write(chan_o, cfg[layer].attr, 0);
> > > +
> > > +	if (chan_disable)
> > > +		bld_write(mux_o + DE_MUX_BLD_REGS, fcolor_ctl,
> > > +			fcolor & ~(0x100 << plane2layer[plane_ix].pipe));
> > > +
> > > +	spin_unlock_irqrestore(&de_lock, flags);
> > > +}
> > 
> > Can't you just disable it?
> 
> Which 'it'? A layer must be disabled and it is not useful to let the
> DE2 processor to scan a pipe (channel) without any layer.

Oh, so that's what it does.

I really think that you should put as much comments as possible on
what you found out working on this, especially because of the lack of
documentation.

> > > +static int __init de2_drm_init(void)
> > > +{
> > > +	int ret;
> > > +
> > > +/* uncomment to activate the drm traces at startup time */
> > > +/*	drm_debug = DRM_UT_CORE | DRM_UT_DRIVER | DRM_UT_KMS |
> > > +			DRM_UT_PRIME | DRM_UT_ATOMIC; */
> > 
> > That's useless.
> 
> Right, but it seems that some people don't know how to debug a DRM
> driver. This is only a reminder.
> 
> > > +	DRM_DEBUG_DRIVER("\n");
> > > +
> > > +	ret = platform_driver_register(&de2_lcd_platform_driver);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	ret = platform_driver_register(&de2_drm_platform_driver);
> > > +	if (ret < 0)
> > > +		platform_driver_unregister(&de2_lcd_platform_driver);
> > > +
> > > +	return ret;
> > > +}
> > 
> > And that really shouldn't be done that way.
> 
> May you explain?

This goes against the whole idea of the device and driver
model. Drivers should only register themselves, device should be
created by buses (or by using some external components if the bus
can't: DT, ACPI, etc.). If there's a match, you get probed.

A driver that creates its own device just to probe itself violates
that.

> > > +int de2_plane_init(struct drm_device *drm, struct lcd *lcd)
> > > +{
> > > +	int ret, possible_crtcs = 1 << lcd->crtc_idx;
> > > +
> > > +	ret = de2_one_plane_init(drm, &lcd->planes[DE2_PRIMARY_PLANE],
> > > +				DRM_PLANE_TYPE_PRIMARY, possible_crtcs,
> > > +				ui_formats, ARRAY_SIZE(ui_formats));
> > > +	if (ret >= 0)
> > > +		ret = de2_one_plane_init(drm, &lcd->planes[DE2_CURSOR_PLANE],
> > > +				DRM_PLANE_TYPE_CURSOR, possible_crtcs,
> > > +				ui_formats, ARRAY_SIZE(ui_formats));
> > 
> > Nothing looks really special about that cursor plane. Any reasion not
> > to make it an overlay?
> 
> As explained above (channel/layer/pipe plane definitions), the cursor
> cannot go in a channel lower or equal to the one of the primary plane.
> Then, it must be known and, so, have an explicit plane.

If you were to make it a plane, you could use atomic_check to check
this and make sure this doesn't happen. And you would gain a generic
plane that can be used for other purposes if needed.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161028/82ba1eba/attachment-0001.sig>
