From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Tue, 28 Jun 2016 01:39:53 -0700
Subject: [PATCH 15/21] usb: chipidea: msm: Mux over secondary phy at the
 right time
In-Reply-To: <20160628045137.GB1190@tuxbot>
References: <20160626072838.28082-1-stephen.boyd@linaro.org>
 <20160626072838.28082-16-stephen.boyd@linaro.org>
 <20160628045137.GB1190@tuxbot>
Message-ID: <146710319302.3879.3467806244377582410@sboyd-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Bjorn Andersson (2016-06-27 21:51:37)
> On Sun 26 Jun 00:28 PDT 2016, Stephen Boyd wrote:
> > +static int ci_hdrc_msm_mux_phy(struct ci_hdrc_msm *ci,
> > +                            struct platform_device *pdev)
> > +{
> > +     struct regmap *regmap;
> > +     struct device_node *syscon;
> > +     struct device *dev = &pdev->dev;
> > +     u32 off, val;
> > +     int ret;
> > +
> > +     syscon = of_parse_phandle(dev->of_node, "phy-select", 0);
> > +     if (!syscon)
> > +             return 0;
> > +
> > +     regmap = syscon_node_to_regmap(syscon);
> > +     if (IS_ERR(regmap))
> > +             return PTR_ERR(regmap);
> > +
> > +     ret = of_property_read_u32_index(dev->of_node, "phy-select", 1, &off);
> > +     if (ret < 0) {
> > +             dev_err(dev, "no offset in syscon\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     ret = of_property_read_u32_index(dev->of_node, "phy-select", 2, &val);
> > +     if (ret < 0) {
> > +             dev_err(dev, "no value in syscon\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     ret = regmap_write(regmap, off, val);
> 
> I recently found out (thanks to a comment from Srinivas) that you can
> drop the last two error checks by using
> of_parse_phandle_with_fixed_args() as in:
> 
>   struct of_phandle_args args;
> 
>   ret = of_parse_phandle_with_fixed_args(dev->of_node, "phy-select", 2, 0, &args);
>   if (ret < 0)
>         ...
> 
>   regmap = syscon_node_to_regmap(args.np);
>   of_node_put(args.np);
>   if (IS_ERR(regmap))
>         ...
> 
>   ret = regmap_write(regmap, args.args[0], args.args[1]);

Awesome, thanks. I'll fold this in.

> > +     resource_size_t size;
> >       int ret;
> >  
> >       dev_dbg(&pdev->dev, "ci_hdrc_msm_probe\n");
> > @@ -76,6 +132,15 @@ static int ci_hdrc_msm_probe(struct platform_device *pdev)
> >       if (IS_ERR(clk))
> >               return PTR_ERR(clk);
> >  
> > +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +     if (!res)
> > +             return -ENODEV;
> > +
> > +     size = resource_size(res);
> > +     ci->base = base = devm_ioremap(&pdev->dev, res->start, size);
> > +     if (!base)
> > +             return -ENOMEM;
> 
> Replace these two snippets with:
> 
>   res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>   ci->base = devm_ioremap_resource(&pdev->dev, res);
>   if (IS_ERR(ci->base))
>         return PTR_ERR(ci->base);

Unfortunately I can't do that. I'm mapping the base here without
ioremap_resource() because the ci core is mapping it with
devm_ioremap_resource() and that doesn't allow two callers to map the
same address space. If the ci core was a library and not written as a
sub device driver this could be made to work assuming there was some API
to setup the mapping and then another API to do the rest of the ci core
probe.

Or I can add another event like SETUP that would allow me to mux the phy
over early during the ci device probe. I would still need to get a
handle on the registers for the extcon handler though, so that would
need a think.
