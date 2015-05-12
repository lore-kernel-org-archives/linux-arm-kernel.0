From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 12 May 2015 15:47:37 +0200
Subject: [PATCH 3/5] soc: Mediatek: Add SCPSYS power domain driver
In-Reply-To: <CABuKBe+cuE=NVjm8UOC9=z2rgxR8_fmn_UEMSQbK8ywCGvskTg@mail.gmail.com>
References: <1431372206-1237-1-git-send-email-s.hauer@pengutronix.de>
 <1431372206-1237-4-git-send-email-s.hauer@pengutronix.de>
 <CABuKBe+cuE=NVjm8UOC9=z2rgxR8_fmn_UEMSQbK8ywCGvskTg@mail.gmail.com>
Message-ID: <20150512134737.GW6325@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 12, 2015 at 01:52:06PM +0200, Matthias Brugger wrote:
> 2015-05-11 21:23 GMT+02:00 Sascha Hauer <s.hauer@pengutronix.de>:
> > This adds a power domain driver for the Mediatek SCPSYS unit.
> >
> > The System Control Processor System (SCPSYS) has several power
> > management related tasks in the system. The tasks include thermal
> > measurement, dynamic voltage frequency scaling (DVFS), interrupt
> > filter and lowlevel sleep control. The System Power Manager (SPM)
> > inside the SCPSYS is for the MTCMOS power domain control.
> >
> > For now this driver only adds power domain support, the more
> > advanced features are not yet supported. The driver implements
> > the generic PM domain device tree bindings, the first user will
> > most likely be the Mediatek AFE audio driver.
> >
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  .../devicetree/bindings/soc/mediatek/scpsys.txt    |   2 +
> >  drivers/soc/mediatek/Kconfig                       |   8 +
> >  drivers/soc/mediatek/Makefile                      |   1 +
> >  drivers/soc/mediatek/mtk-scpsys.c                  | 416 +++++++++++++++++++++
> >  include/dt-bindings/power/mt8173-power.h           |  15 +
> >  5 files changed, 442 insertions(+)
> >  create mode 100644 drivers/soc/mediatek/mtk-scpsys.c
> >  create mode 100644 include/dt-bindings/power/mt8173-power.h
> >
> > diff --git a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
> > index 4764a03..87f2091 100644
> > --- a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
> > +++ b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
> > @@ -15,6 +15,7 @@ Required properties:
> >  - compatible: Must be "mediatek,mt8173-scpsys"
> >  - #power-domain-cells: Must be 1
> >  - reg: Address range of the SCPSYS unit
> > +- infracfg: must contain a phandle to the infracfg controller
> >
> >  Example:
> >
> > @@ -22,6 +23,7 @@ Example:
> >                 #power-domain-cells = <1>;
> >                 compatible = "mediatek,mt8173-scpsys";
> >                 reg = <0 0x10006000 0 0x1000>;
> > +               infracfg = <&infracfg>;
> >         };

This hunk shouldn't be here btw, fixed.

> > +       pd_data->num_domains = NUM_DOMAINS;
> > +
> > +       for (i = 0; i < NUM_DOMAINS; i++) {
> > +               struct scp_domain *scpd = &scp->domains[i];
> > +
> > +               if (scp_domain_data[i].clk_name) {
> > +                       const char *name = scp_domain_data[i].clk_name;
> > +
> > +                       scpd->clk = devm_clk_get(&pdev->dev, name);
> > +                       if (IS_ERR(scpd->clk)) {
> > +                               dev_err(&pdev->dev, "Failed to get %s clk: %ld\n",
> > +                                               name, PTR_ERR(scpd->clk));
> > +                               return PTR_ERR(scpd->clk);
> > +                       }
> > +               }
> > +       }
> > +
> > +       for (i = 0; i < NUM_DOMAINS; i++) {
> 
> Why two for loops?

I'm sure there was a reason in earlier versions, but now it seems rather
useless. I'll make this a single loop.

> 
> static const?

Yes.

Thanks for reviewing.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
