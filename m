From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 29 Oct 2018 10:00:00 +0100
Subject: [PATCH v2 04/15] drm/sun4i: sun6i_mipi_dsi: Add Allwinner A64
 MIPI DSI support
In-Reply-To: <CAMty3ZDLd=vbYUut6Cwo9VKFR4T1u1p58FLg9vhN79JS1=0rag@mail.gmail.com>
References: <20181023155035.9101-1-jagan@amarulasolutions.com>
 <20181023155035.9101-5-jagan@amarulasolutions.com>
 <20181024180632.zrb3lrqsznspmwbk@flea>
 <CAMty3ZDLd=vbYUut6Cwo9VKFR4T1u1p58FLg9vhN79JS1=0rag@mail.gmail.com>
Message-ID: <20181029090000.woypmozwc7sbtusk@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 25, 2018 at 04:32:06PM +0530, Jagan Teki wrote:
> On Wed, Oct 24, 2018 at 11:36 PM Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> >
> > On Tue, Oct 23, 2018 at 09:20:24PM +0530, Jagan Teki wrote:
> > > The MIPI DSI controller on Allwinner A64 is similar to
> > > Allwinner A31 without support of DSI mod clock(CLK_DSI_SCLK)
> > >
> > > So, alter has_mod_clk bool via driver data for respective
> > > SoC's compatible.
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > ---
> > > Changes for v2:
> > > - none
> > >
> > >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 47 ++++++++++++++++++++------
> > >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h |  5 +++
> > >  2 files changed, 41 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > index e3b34a345546..8e9c76febca2 100644
> > > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > @@ -10,6 +10,7 @@
> > >  #include <linux/component.h>
> > >  #include <linux/crc-ccitt.h>
> > >  #include <linux/of_address.h>
> > > +#include <linux/of_device.h>
> > >  #include <linux/pm_runtime.h>
> > >  #include <linux/regmap.h>
> > >  #include <linux/reset.h>
> > > @@ -981,6 +982,8 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
> > >       dsi->host.ops = &sun6i_dsi_host_ops;
> > >       dsi->host.dev = dev;
> > >
> > > +     dsi->variant = of_device_get_match_data(dev);
> > > +
> > >       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > >       base = devm_ioremap_resource(dev, res);
> > >       if (IS_ERR(base)) {
> > > @@ -1001,17 +1004,20 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
> > >               return PTR_ERR(dsi->reset);
> > >       }
> > >
> > > -     dsi->mod_clk = devm_clk_get(dev, "mod");
> > > -     if (IS_ERR(dsi->mod_clk)) {
> > > -             dev_err(dev, "Couldn't get the DSI mod clock\n");
> > > -             return PTR_ERR(dsi->mod_clk);
> > > +     if (dsi->variant->has_mod_clk) {
> > > +             dsi->mod_clk = devm_clk_get(dev, "mod");
> > > +             if (IS_ERR(dsi->mod_clk)) {
> > > +                     dev_err(dev, "Couldn't get the DSI mod clock\n");
> > > +                     return PTR_ERR(dsi->mod_clk);
> > > +             }
> > >       }
> > >
> > >       /*
> > >        * In order to operate properly, that clock seems to be always
> > >        * set to 297MHz.
> > >        */
> > > -     clk_set_rate_exclusive(dsi->mod_clk, 297000000);
> > > +     if (dsi->variant->has_mod_clk)
> > > +             clk_set_rate_exclusive(dsi->mod_clk, 297000000);
> > >
> > >       dphy_node = of_parse_phandle(dev->of_node, "phys", 0);
> > >       ret = sun6i_dphy_probe(dsi, dphy_node);
> > > @@ -1043,7 +1049,8 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
> > >       pm_runtime_disable(dev);
> > >       sun6i_dphy_remove(dsi);
> > >  err_unprotect_clk:
> > > -     clk_rate_exclusive_put(dsi->mod_clk);
> > > +     if (dsi->variant->has_mod_clk)
> > > +             clk_rate_exclusive_put(dsi->mod_clk);
> > >       return ret;
> > >  }
> > >
> > > @@ -1056,7 +1063,8 @@ static int sun6i_dsi_remove(struct platform_device *pdev)
> > >       mipi_dsi_host_unregister(&dsi->host);
> > >       pm_runtime_disable(dev);
> > >       sun6i_dphy_remove(dsi);
> > > -     clk_rate_exclusive_put(dsi->mod_clk);
> > > +     if (dsi->variant->has_mod_clk)
> > > +             clk_rate_exclusive_put(dsi->mod_clk);
> > >
> > >       return 0;
> > >  }
> > > @@ -1066,7 +1074,8 @@ static int __maybe_unused sun6i_dsi_runtime_resume(struct device *dev)
> > >       struct sun6i_dsi *dsi = dev_get_drvdata(dev);
> > >
> > >       reset_control_deassert(dsi->reset);
> > > -     clk_prepare_enable(dsi->mod_clk);
> > > +     if (dsi->variant->has_mod_clk)
> > > +             clk_prepare_enable(dsi->mod_clk);
> > >
> > >       /*
> > >        * Enable the DSI block.
> > > @@ -1094,7 +1103,8 @@ static int __maybe_unused sun6i_dsi_runtime_suspend(struct device *dev)
> > >  {
> > >       struct sun6i_dsi *dsi = dev_get_drvdata(dev);
> > >
> > > -     clk_disable_unprepare(dsi->mod_clk);
> > > +     if (dsi->variant->has_mod_clk)
> > > +             clk_disable_unprepare(dsi->mod_clk);
> > >       reset_control_assert(dsi->reset);
> > >
> > >       return 0;
> > > @@ -1106,9 +1116,24 @@ static const struct dev_pm_ops sun6i_dsi_pm_ops = {
> > >                          NULL)
> > >  };
> > >
> > > +static const struct sun6i_dsi_variant sun6i_a31_dsi = {
> > > +     .has_mod_clk = true,
> > > +};
> > > +
> > > +static const struct sun6i_dsi_variant sun50i_a64_dsi = {
> > > +     .has_mod_clk = false,
> >
> > This is the default already.
> 
> True but we need to assign the .data. how about checking device
> compatible? I'm thinking of difference in driver data in future
> between SoC's

That's not my point. You'll need the structure, but has_mod_clk will
be initialised to false already, so you can drop the explicit
assignment.

> >
> > > +};
> > > +
> > >  static const struct of_device_id sun6i_dsi_of_table[] = {
> > > -     { .compatible = "allwinner,sun6i-a31-mipi-dsi" },
> > > -     { }
> > > +     {
> > > +             .compatible = "allwinner,sun6i-a31-mipi-dsi",
> > > +             .data = &sun6i_a31_dsi,
> > > +     },
> > > +     {
> > > +             .compatible = "allwinner,sun50i-a64-mipi-dsi",
> > > +             .data = &sun50i_a64_dsi,
> > > +     },
> > > +     { /* sentinel */ }
> > >  };
> > >  MODULE_DEVICE_TABLE(of, sun6i_dsi_of_table);
> > >
> > > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
> > > index dbbc5b3ecbda..597b62227019 100644
> > > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
> > > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
> > > @@ -20,6 +20,10 @@ struct sun6i_dphy {
> > >       struct reset_control    *reset;
> > >  };
> > >
> > > +struct sun6i_dsi_variant {
> > > +     bool                    has_mod_clk;
> > > +};
> > > +
> >
> > This should be part of a separate patch.
> 
> How come, because has_mod_clk is using in driver file?

You're doing two things here: Adding a quirk structure, and adding
support for an SoC. This should be two patches.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181029/954195a8/attachment.sig>
