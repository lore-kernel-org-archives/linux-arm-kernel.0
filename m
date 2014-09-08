From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 08 Sep 2014 13:54:06 +0200
Subject: [PATCH v7 2/5] ARM: imx6: gpc: Add PU power domain for GPU/VPU
In-Reply-To: <CAPDyKFovJOVyKRNSA+sEjd4mXA9QYYYDQEAvTzkptj8FDzgWTQ@mail.gmail.com>
References: <1409060791-23167-1-git-send-email-p.zabel@pengutronix.de>
 <1409060791-23167-3-git-send-email-p.zabel@pengutronix.de>
 <CAPDyKFovJOVyKRNSA+sEjd4mXA9QYYYDQEAvTzkptj8FDzgWTQ@mail.gmail.com>
Message-ID: <1410177246.3981.34.camel@paszta.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf,

thank you for the comments.

Am Dienstag, den 26.08.2014, 21:48 +0200 schrieb Ulf Hansson:
[...]
> > @@ -139,3 +161,184 @@ void __init imx_gpc_init(void)
> >         gic_arch_extn.irq_unmask = imx_gpc_irq_unmask;
> >         gic_arch_extn.irq_set_wake = imx_gpc_irq_set_wake;
> >  }
> > +
> > +#ifdef CONFIG_PM
> 
> Hi Philipp,
> 
> Should this be CONFIG_PM_GENERIC_DOMAINS?

Yes, I'll change this.

[...]
> > +static int imx_gpc_genpd_init(struct device *dev, struct regulator *pu_reg)
> > +{
> > +       struct clk *clk;
> > +       bool is_off;
> > +       int i;
> > +
> > +       imx6q_pu_domain.base.of_node = dev->of_node;
> > +       imx6q_pu_domain.reg = pu_reg;
> > +
> > +       for (i = 0; ; i++) {
> > +               clk = of_clk_get(dev->of_node, i);
> > +               if (IS_ERR(clk))
> > +                       break;
> > +               if (i >= GPC_CLK_MAX) {
> > +                       dev_err(dev, "more than %d clocks\n", GPC_CLK_MAX);
> > +                       goto clk_err;
> > +               }
> > +               imx6q_pu_domain.clk[i] = clk;
> > +       }
> > +       imx6q_pu_domain.num_clks = i;
> > +
> > +       is_off = IS_ENABLED(CONFIG_PM_RUNTIME);
> > +       if (is_off)
> > +               imx6q_pm_pu_power_off(&imx6q_pu_domain.base);
> 
> Could you elaborate why is_off depends on CONFIG_PM_RUNTIME? That
> seems strange to me. :-)
> 
> Additionally, I think it would be better to leave the domain "on"
> state. Wouldn't that even be required for some drivers to be able to
> succeed probing of these devices?

The devices in the PU power domain are Vivante GPUs and the CODA Video
Processing Unit. These are platform devices that don't need to be active
to enumerate before being probed. The drivers support runtime PM, so if
CONFIG_PM_RUNTIME is enabled, it is safe to disable the PU power domain
on boot. The drivers will probe and request for the power domain to be
enabled via runtime PM before accessing the hardware.

If CONFIG_PM_RUNTIME is disabled, the power domain needs to stay enabled
at all times.

[...]
> > +static struct platform_driver imx_gpc_driver = {
> > +       .driver = {
> > +               .name = "imx-gpc",
> > +               .owner = THIS_MODULE,
> > +               .of_match_table = imx_gpc_dt_ids,
> > +       },
> > +       .probe = imx_gpc_probe,
> > +};
> > +
> > +static int __init imx_pgc_init(void)
> > +{
> > +       return platform_driver_register(&imx_gpc_driver);
> > +}
> > +subsys_initcall(imx_pgc_init);
> 
> Could initialization of the generic power domain at subsys_init level,
> mean that some other drivers may already be probed?
>
> Are you sure none of those drivers handles devices within your power
> domain, thus causing attachment of the power domain to fail?

The GPU and VPU drivers are standard module_platform_drivers, those will
be probed later at device_initcall times.

regards
Philipp
