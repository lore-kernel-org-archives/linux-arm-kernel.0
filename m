From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 07 Jun 2013 09:54:18 +0200
Subject: [PATCH v3 06/11] staging: drm/imx: Add LDB support
In-Reply-To: <51B18E54.5030501@tqsc.de>
References: <1364484215-13935-1-git-send-email-p.zabel@pengutronix.de>
 <1364484215-13935-7-git-send-email-p.zabel@pengutronix.de>
 <51B18E54.5030501@tqsc.de>
Message-ID: <1370591658.4470.9.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, den 07.06.2013, 09:40 +0200 schrieb Markus Niebel:
> Am 28.03.2013 16:23, wrote Philipp Zabel:
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> > 
> > This adds support for the LVDS Display Bridge contained
> > in i.MX5 and i.MX6 SoCs.
> > 
> > Bit mapping, data width, and video timings are configurable
> > via device tree. Dual-channel mode is supported for a single
> > high-resolution source.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > ---
> > Changes since v2:
> >  - Removed commented out code
> >  - Replaced magic constants
> >  - Select OF_VIDEOMODE
> > ---
> >  .../devicetree/bindings/staging/imx-drm/ldb.txt    |  99 ++++
> >  drivers/staging/imx-drm/Kconfig                    |   8 +
> >  drivers/staging/imx-drm/Makefile                   |   1 +
> >  drivers/staging/imx-drm/imx-ldb.c                  | 609 +++++++++++++++++++++
> >  4 files changed, 717 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/staging/imx-drm/ldb.txt
> >  create mode 100644 drivers/staging/imx-drm/imx-ldb.c
> > 
[...]
> > diff --git a/drivers/staging/imx-drm/imx-ldb.c b/drivers/staging/imx-drm/imx-ldb.c
> > new file mode 100644
> > index 0000000..75607b3
> > --- /dev/null
> > +++ b/drivers/staging/imx-drm/imx-ldb.c
> > @@ -0,0 +1,609 @@
[...]
> > +static void imx_ldb_set_clock(struct imx_ldb *ldb, int mux, int chno,
> > +		unsigned long serial_clk, unsigned long di_clk)
> > +{
> > +	int ret;
> > +
> > +	dev_dbg(ldb->dev, "%s: now: %ld want: %ld\n", __func__,
> > +			clk_get_rate(ldb->clk_pll[chno]), serial_clk);
> > +	clk_set_rate(ldb->clk_pll[chno], serial_clk);
> > +
> > +	dev_dbg(ldb->dev, "%s after: %ld\n", __func__,
> > +			clk_get_rate(ldb->clk_pll[chno]));
> > +
> > +	dev_dbg(ldb->dev, "%s: now: %ld want: %ld\n", __func__,
> > +			clk_get_rate(ldb->clk[chno]),
> > +			(long int)di_clk);
> > +	clk_set_rate(ldb->clk[chno], di_clk);
> > +
> > +	dev_dbg(ldb->dev, "%s after: %ld\n", __func__,
> > +			clk_get_rate(ldb->clk[chno]));
> > +
> > +	/* set display clock mux to LDB input clock */
> 
> I think this will fail on i.MX53 with split mode enable in case of
> mux != chno, since ipu_di<n> can only be muxed to ldb_di<n>_gate.
>
>> +     ret = clk_set_parent(ldb->clk_sel[mux], ldb->clk[chno]);

That is true. We should use both ldb_di<n>_gates in split mode on
i.MX53, with both ldb_di<n>_sel derived from the same parent.

>> +     if (ret) {
>> +             dev_err(ldb->dev, "unable to set di%d parent clock to ldb_di%d\n", mux, chno);
>> +     }
>> +}
>> +
>> +static void imx_ldb_encoder_prepare(struct drm_encoder *encoder)
>> +{
>> +     struct imx_ldb_channel *imx_ldb_ch = enc_to_imx_ldb_ch(encoder);
>> +     struct imx_ldb *ldb = imx_ldb_ch->ldb;
>> +     struct drm_display_mode *mode = &encoder->crtc->mode;
>> +     unsigned long serial_clk;
>> +     unsigned long di_clk = mode->clock * 1000;
>> +     int mux = imx_drm_encoder_get_mux_id(imx_ldb_ch->imx_drm_encoder,
>> +                                          encoder->crtc);
>> +
>> +     if (ldb->ldb_ctrl & LDB_SPLIT_MODE_EN) {
>> +             /* dual channel LVDS mode */
>> +             serial_clk = 3500UL * mode->clock;
> 
> See comment in imx_ldb_set_clock
>
>> +             imx_ldb_set_clock(ldb, mux, 0, serial_clk, di_clk);
>> +             imx_ldb_set_clock(ldb, mux, 1, serial_clk, di_clk);
[...]

regards
Philipp
