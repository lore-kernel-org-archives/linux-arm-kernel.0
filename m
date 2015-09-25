From: aalonso@freescale.com (Alonso Adrian)
Date: Fri, 25 Sep 2015 19:16:49 +0000
Subject: [PATCH v5 4/7] pinctrl: freescale: imx: allow mux_reg offset zero
In-Reply-To: <20150925190725.GX3529@tiger>
References: <1443128043-21063-1-git-send-email-aalonso@freescale.com>
 <1443128043-21063-4-git-send-email-aalonso@freescale.com>
 <20150925104726.GJ11805@pengutronix.de> <20150925190725.GX3529@tiger>
Message-ID: <BN3PR03MB150994443644800594BE9BA2A8420@BN3PR03MB1509.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: Friday, September 25, 2015 2:07 PM
> To: Markus Pargmann <mpa@pengutronix.de>
> Cc: Alonso Lazcano Adrian-B38018 <aalonso@freescale.com>; linux-arm-
> kernel at lists.infradead.org; shawn.guo at linaro.org; linus.walleij at linaro.org;
> lznuaa at gmail.com; devicetree at vger.kernel.org; Li Frank-B20596
> <Frank.Li@freescale.com>; Garg Nitin-B37173 <nitin.garg@freescale.com>;
> Huang Yongcai-B20788 <Anson.Huang@freescale.com>; linux-
> gpio at vger.kernel.org; robh+dt at kernel.org; kernel at pengutronix.de; Gong
> Yibin-B38343 <yibin.gong@freescale.com>
> Subject: Re: [PATCH v5 4/7] pinctrl: freescale: imx: allow mux_reg offset zero
> 
> On Fri, Sep 25, 2015 at 12:47:26PM +0200, Markus Pargmann wrote:
> > On Thu, Sep 24, 2015 at 03:54:00PM -0500, Adrian Alonso wrote:
> > > Allow mux_reg offset zero to be a valid pin_id, on imx7d mux_conf
> > > reg offset is zero for iomuxc-lspr controller
> > >
> > > Signed-off-by: Adrian Alonso <aalonso@freescale.com>
> > > ---
> > > Changes for V2: Resend
> > > Changes for V3: Resend
> > > Changes for V4: Simplify pin_id assigment when ZERO_OFFSET_VALID is
> > > set Changes for V5:
> > > - Drop patch pinctrl: freescale: imx: add ZERO_OFFSET_VALID flag
> > > - Allow mux_reg ZERO OFFSET as pin_id
> > >
> > >  drivers/pinctrl/freescale/pinctrl-imx.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c
> > > b/drivers/pinctrl/freescale/pinctrl-imx.c
> > > index b9c6deb..23348d8 100644
> > > --- a/drivers/pinctrl/freescale/pinctrl-imx.c
> > > +++ b/drivers/pinctrl/freescale/pinctrl-imx.c
> > > @@ -550,7 +550,7 @@ static int imx_pinctrl_parse_groups(struct
> device_node *np,
> > >  				conf_reg = -1;
> > >  		}
> > >
> > > -		pin_id = mux_reg ? mux_reg / 4 : conf_reg / 4;
> > > +		pin_id = (mux_reg != -1) ? mux_reg / 4 : conf_reg / 4;
> >
> > This will break compatibility with imx35 and imx25 pinctrl drivers.
> > They have definitions where mux_reg can be 0x0. See imx35-pinfunc.h
> > and
> > imx25-pinfunc.h:
> >
> > 	git grep -E "0x0+ 0x.* 0x.* 0x.* 0x.*"
> >
> > This mux_reg behaviour was not described in the DT binding
> > documentation. But it is used by some platforms. So even if you change
> > the pincfunc headers to use "-1", it would break devicetrees compiled
> > with earlier kernel versions.
> 
> Ah, sorry, I'm screwed on the previous review.  So we still need the flag
> ZERO_OFFSET_VALID to convert invalid 0 mux_reg to -1.
> 
> @Adrian,
> 
> Will the following change just work for you?
@Shawn, yes the change will work, do you want me to prepare a new patch series?
> 
> Shawn
> 
> diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c
> b/drivers/pinctrl/freescale/pinctrl-imx.c
> index d7b98ba36825..ae801ba7e226 100644
> --- a/drivers/pinctrl/freescale/pinctrl-imx.c
> +++ b/drivers/pinctrl/freescale/pinctrl-imx.c
> @@ -542,6 +542,9 @@ static int imx_pinctrl_parse_groups(struct device_node
> *np,
>                 struct imx_pin_reg *pin_reg;
>                 struct imx_pin *pin = &grp->pins[i];
> 
> +               if (!(info->flags & ZERO_OFFSET_VALID) && !mux_reg)
> +                       mux_reg = -1;
> +
>                 if (info->flags & SHARE_MUX_CONF_REG) {
>                         conf_reg = mux_reg;
>                 } else {
> @@ -550,7 +553,7 @@ static int imx_pinctrl_parse_groups(struct device_node
> *np,
>                                 conf_reg = -1;
>                 }
> 
> -               pin_id = mux_reg ? mux_reg / 4 : conf_reg / 4;
> +               pin_id = (mux_reg != -1) ? mux_reg / 4 : conf_reg / 4;
>                 pin_reg = &info->pin_regs[pin_id];
>                 pin->pin = pin_id;
>                 grp->pin_ids[i] = pin_id;
