From: aalonso@freescale.com (Alonso Adrian)
Date: Fri, 18 Sep 2015 16:27:37 +0000
Subject: [PATCH v2 5/8] pinctrl: freescale: imx: add ZERO_OFFSET_VALID flag
In-Reply-To: <20150918135248.GB3770@tiger>
References: <1441147753-13239-1-git-send-email-aalonso@freescale.com>
 <1441147753-13239-5-git-send-email-aalonso@freescale.com>
 <20150907012831.GE30746@tiger>
 <BN3PR03MB1509E4893244D963FDA21707A8530@BN3PR03MB1509.namprd03.prod.outlook.com>
 <20150918135248.GB3770@tiger>
Message-ID: <CY1PR03MB15206FAAB4656A6E207FD4E2A8590@CY1PR03MB1520.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: Friday, September 18, 2015 8:53 AM
> To: Alonso Lazcano Adrian-B38018 <aalonso@freescale.com>
> Cc: linux-arm-kernel at lists.infradead.org; shawn.guo at linaro.org;
> linus.walleij at linaro.org; lznuaa at gmail.com; devicetree at vger.kernel.org; Li
> Frank-B20596 <Frank.Li@freescale.com>; Garg Nitin-B37173
> <nitin.garg@freescale.com>; Huang Yongcai-B20788
> <Anson.Huang@freescale.com>; linux-gpio at vger.kernel.org;
> robh+dt at kernel.org; Gong Yibin-B38343 <yibin.gong@freescale.com>
> Subject: Re: [PATCH v2 5/8] pinctrl: freescale: imx: add ZERO_OFFSET_VALID
> flag
> 
> On Tue, Sep 08, 2015 at 04:05:32PM +0000, Alonso Adrian wrote:
> > Hi Shawn,
> >
> > See comments below
> 
> Please use bottom posting, not top posting.
> 
> ...
> 
> > > @@ -536,21 +536,29 @@ static int imx_pinctrl_parse_groups(struct
> device_node *np,
> > >               return -ENOMEM;
> > >
> > >       for (i = 0; i < grp->npins; i++) {
> > > -             u32 mux_reg = be32_to_cpu(*list++);
> > > +             u32 mux_reg;
> > >               u32 conf_reg;
> > >               unsigned int pin_id;
> > >               struct imx_pin_reg *pin_reg;
> > >               struct imx_pin *pin = &grp->pins[i];
> > >
> > > +             mux_reg = be32_to_cpu(*list++);
> > > +             if (!(info->flags & ZERO_OFFSET_VALID) && !mux_reg)
> > > +                     mux_reg = -1;
> > > +
> > >               if (info->flags & SHARE_MUX_CONF_REG) {
> > >                       conf_reg = mux_reg;
> > >               } else {
> > >                       conf_reg = be32_to_cpu(*list++);
> > > -                     if (!conf_reg)
> > > +                     if (!(info->flags & ZERO_OFFSET_VALID) &&
> > > + !conf_reg)
> > >                               conf_reg = -1;
> > >               }
> > >
> > [Adrian] The below assignment is the important thing that this patch
> > does, it allows the pad_id to be zero and match the pad id's according to the
> mux_reg offset.
> > > -             pin_id = mux_reg ? mux_reg / 4 : conf_reg / 4;
> > > +             if (info->flags & ZERO_OFFSET_VALID)
> > > +                     pin_id = mux_reg / 4;
> > > +             else
> > > +                     pin_id = mux_reg ? mux_reg / 4 : conf_reg / 4;
> > > +
> 
> Ah, yes.  So the only code change we need is just the line below, right?
> 
> 	pin_id = (mux_reg != -1) ? mux_reg / 4 : conf_reg / 4;
> 
> Shawn
[Adrian] Yes that will work, let me resend a new patch series with this change, Thanks.
> 
> > >               pin_reg = &info->pin_regs[pin_id];
> > >               pin->pin = pin_id;
> > >               grp->pin_ids[i] = pin_id; @@ -684,7 +692,7 @@ int
> > > imx_pinctrl_probe(struct platform_device *pdev,  {
> > >       struct imx_pinctrl *ipctl;
> > >       struct resource *res;
> > > -     int ret, i;
> > > +     int ret;
> > >
> > >       if (!info || !info->pins || !info->npins) {
> > >               dev_err(&pdev->dev, "wrong pinctrl info\n"); @@
> > > -702,11 +710,6 @@ int imx_pinctrl_probe(struct platform_device *pdev,
> > >       if (!info->pin_regs)
> > >               return -ENOMEM;
> > >
> > > -     for (i = 0; i < info->npins; i++) {
> > > -             info->pin_regs[i].mux_reg = -1;
> > > -             info->pin_regs[i].conf_reg = -1;
> > > -     }
> > > -
> > >       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > >       ipctl->base = devm_ioremap_resource(&pdev->dev, res);
> > >       if (IS_ERR(ipctl->base))
> > > diff --git a/drivers/pinctrl/freescale/pinctrl-imx.h
> > > b/drivers/pinctrl/freescale/pinctrl-imx.h
> > > index 26f8f1c..67c07c2 100644
> > > --- a/drivers/pinctrl/freescale/pinctrl-imx.h
> > > +++ b/drivers/pinctrl/freescale/pinctrl-imx.h
> > > @@ -85,6 +85,7 @@ struct imx_pinctrl_soc_info {  };
> > >
> > >  #define SHARE_MUX_CONF_REG   0x1
> > > +#define ZERO_OFFSET_VALID    0x2
> > >
> > >  #define NO_MUX               0x0
> > >  #define NO_PAD               0x0
> > > --
> > > 2.1.4
> > >
> > >
> > > _______________________________________________
> > > linux-arm-kernel mailing list
> > > linux-arm-kernel at lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
