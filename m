From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 5 Jan 2016 20:38:17 +0000
Subject: [PATCH RFC 2/2] drm: sunxi: Add a basic DRM driver for Allwinner
 DE2
In-Reply-To: <58463fd5b674c7eedec4ae05567ee56770a12996.1452021349.git.moinejf@free.fr>
References: <cover.1452021349.git.moinejf@free.fr>
 <58463fd5b674c7eedec4ae05567ee56770a12996.1452021349.git.moinejf@free.fr>
Message-ID: <20160105203817.GZ19062@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some comments from an ARM architecture point of view.  I haven't
reviewed it from a DRM point of view yet.

On Tue, Jan 05, 2016 at 07:40:11PM +0100, Jean-Francois Moine wrote:
> +struct tcon {
> +	u32 gctl;
> +#define		TCON_GCTL_TCON_En 0x80000000
> +	u32 gint0;
> +#define		TCON_GINT0_TCON1_Vb_Int_En 0x40000000
> +#define		TCON_GINT0_TCON1_Vb_Int_Flag 0x00001000
> +	u32 gint1;
> +	u32 dum0[13];
> +	u32 tcon0_ctl;
> +#define		TCON0_CTL_TCON_En 0x80000000
> +	u32 dum1[19];
> +	u32 tcon1_ctl;
> +#define		TCON1_CTL_TCON_En 0x80000000
> +#define		TCON1_CTL_Interlace_En 0x00100000
> +#define		TCON1_CTL_Start_Delay_SHIFT 4
> +#define		TCON1_CTL_Start_Delay_MASK 0x000001f0
> +	u32 basic0;			/* XI/YI */
> +	u32 basic1;			/* LS_XO/LS_YO */
> +	u32 basic2;			/* XO/YO */
> +	u32 basic3;			/* HT/HBP */
> +	u32 basic4;			/* VT/VBP */
> +	u32 basic5;			/* HSPW/VSPW */
> +	u32 dum2;
> +	u32 ps_sync;
> +	u32 dum3[15];
> +	u32 io_pol;
> +#define		TCON1_IO_POL_IO0_inv 0x01000000
> +#define		TCON1_IO_POL_IO1_inv 0x02000000
> +#define		TCON1_IO_POL_IO2_inv 0x04000000
> +	u32 io_tri;
> +	u32 dum4[2];
> +
> +	u32 ceu_ctl;			/* 100 */
> +#define     TCON_CEU_CTL_ceu_en 0x80000000
> +	u32 dum5[3];
> +	u32 ceu_rr;
> +	u32 ceu_rg;
> +	u32 ceu_rb;
> +	u32 ceu_rc;
> +	u32 ceu_gr;
> +	u32 ceu_gg;
> +	u32 ceu_gb;
> +	u32 ceu_gc;
> +	u32 ceu_br;
> +	u32 ceu_bg;
> +	u32 ceu_bb;
> +	u32 ceu_bc;
> +	u32 ceu_rv;
> +	u32 ceu_gv;
> +	u32 ceu_bv;
> +	u32 dum6[45];
> +
> +	u32 mux_ctl;			/* 200 */
> +#define		TCON_MUX_CTL_HDMI_SRC_SHIFT 8
> +#define		TCON_MUX_CTL_HDMI_SRC_MASK 0x00000300
> +	u32 dum7[63];
> +
> +	u32 fill_ctl;			/* 300 */
> +	u32 fill_start0;
> +	u32 fill_end0;
> +	u32 fill_data0;
> +};

This sets off warnings bells for me...

> +static void de2_set_frame_timings(struct lcd *lcd)
> +{
> +	struct drm_crtc *crtc = &lcd->crtc;
> +	const struct drm_display_mode *mode = &crtc->mode;
> +	struct tcon *p_tcon = lcd->mmio;
> +	int interlace = mode->flags & DRM_MODE_FLAG_INTERLACE ? 2 : 1;
> +	int start_delay;
> +	u32 data;
> +
> +	DRM_DEBUG_DRIVER("\n");
> +
> +	data = XY(mode->hdisplay - 1, mode->vdisplay / interlace - 1);
> +	p_tcon->basic0 = data;
> +	p_tcon->basic1 = data;
> +	p_tcon->basic2 = data;
> +	p_tcon->basic3 = XY(mode->htotal - 1,
> +				mode->htotal - mode->hsync_start - 1);
> +	p_tcon->basic4 = XY(mode->vtotal * (3 - interlace),
> +				mode->vtotal - mode->vsync_start - 1);
> +	p_tcon->basic5 = XY(mode->hsync_end - mode->hsync_start - 1,
> +				mode->vsync_end - mode->vsync_start - 1);
> +
> +	p_tcon->ps_sync = XY(1, 1);
> +
> +	data = TCON1_IO_POL_IO2_inv;
> +	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
> +		data |= TCON1_IO_POL_IO0_inv;
> +	if (mode->flags & DRM_MODE_FLAG_PHSYNC)
> +		data |= TCON1_IO_POL_IO1_inv;
> +	p_tcon->io_pol = data;
> +
> +	p_tcon->ceu_ctl &= ~TCON_CEU_CTL_ceu_en;
> +
> +	if (interlace == 2)
> +		p_tcon->tcon1_ctl |= TCON1_CTL_Interlace_En;
> +	else
> +		p_tcon->tcon1_ctl &= ~TCON1_CTL_Interlace_En;
> +
> +	p_tcon->fill_ctl = 0;
> +	p_tcon->fill_start0 = mode->vtotal + 1;
> +	p_tcon->fill_end0 = mode->vtotal;
> +	p_tcon->fill_data0 = 0;
> +
> +	start_delay = (mode->vtotal - mode->vdisplay) / interlace - 5;
> +	if (start_delay > 31)
> +		start_delay = 31;
> +	p_tcon->tcon1_ctl &= ~TCON1_CTL_Start_Delay_MASK;
> +	p_tcon->tcon1_ctl |= start_delay << TCON1_CTL_Start_Delay_SHIFT;

Here, the compiler might read tcon1_ctl, clear the bits, merge the
new bits in, and write them back.  Or it might decide to read,
clear bits, write back, set the new bits, and write back again.
What happens if start_delay were written as zero?

> +
> +	p_tcon->io_tri = 0x0fffffff;

This whole thing even more so - the compiler is free to reorder
these accesses, merge them together, etc.  If the compiler decides
to inline this into callers, then it can merge these accesses with
accesses in the caller functions too.

This is why we have IO accessors; they prevent the compiler doing
these kinds of optimisations, and to ensure correctness, we have
sparse, and we mark MMIO memory with __iomem to prevent this kind
of programming mistake.

Please use sparse to check your work, and also use the IO accessors.

The same comments apply elsewhere.

> +}
> +
> +static void de2_crtc_enable(struct drm_crtc *crtc)
> +{
> +	struct lcd *lcd = crtc_to_lcd(crtc);
> +	struct drm_display_mode *mode = &crtc->mode;
> +	struct tcon *p_tcon = lcd->mmio;
> +
> +	DRM_DEBUG_DRIVER("clock %d\n", mode->clock);
> +
> +	if (mode->clock == 0) {
> +		dev_err(lcd->dev, "crtc_start: no clock!\n");
> +		return;
> +	}

Why do you need to check this here?

> +
> +	de2_set_frame_timings(lcd);
> +
> +	clk_set_rate(lcd->clk, mode->clock * 1000);

What if the clock can't support the rate?

...

> +	/* set the VI/UIs channels */
> +	for (chan = 0; chan < 4; chan++) {
> +		int chan_o = mux_o + DE_MUX_CHAN_REGS +
> +				DE_MUX_CHAN_SZ * chan;
> +
> +		if (chan == 0)
> +			memset(priv->mmio + chan_o, 0, sizeof(struct de_vi));
> +		else
> +			memset(priv->mmio + chan_o, 0, sizeof(struct de_ui));

The compiler is allowed to optimise memset() any way it chooses; it makes
no guarantees what so ever, and the compiler is allowed to assume that it
is accessing memory which has no side effects.  It's even allowed to use
unaligned accesses if it so pleases, which are illegal for MMIO memory on
ARM.  memset_io() must be used instead.  Sparse would have found this
as well.

...

> +static int de2_hdmi_connector_mode_valid(struct drm_connector *connector,
> +					struct drm_display_mode *mode)
> +{
> +	if (!drm_match_cea_mode(mode))
> +		return MODE_NOMODE;

Maybe detect modes with a zero clock here instead?

> +	return MODE_OK;
> +}

...

> +static void hdmi_phy_init(struct de2_hdmi_priv *priv)
> +{
> +	int to_cnt;
> +	u32 tmp;
> +
> +	hdmi_writel(priv, 0x10020, 0);
> +	hdmi_writel(priv, 0x10020, 1 << 0);
> +	udelay(5);

udelay() does not delay precisely; it may return slightly short of the
requested delay.  I hope you've made allowance for that.


-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
