From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 29 Mar 2017 18:08:31 +0200
Subject: [PATCH v7 2/2] soc/imx: Add GPCv2 power gating driver
In-Reply-To: <20170330075111.GC29432@b29396-OptiPlex-7040>
References: <20170321145004.21265-1-andrew.smirnov@gmail.com>
 <20170321145004.21265-3-andrew.smirnov@gmail.com>
 <20170324062451.GB12604@b29396-OptiPlex-7040>
 <1490279749.29056.33.camel@pengutronix.de>
 <20170330075111.GC29432@b29396-OptiPlex-7040>
Message-ID: <1490803711.29083.25.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dong,

Am Donnerstag, den 30.03.2017, 15:51 +0800 schrieb Dong Aisheng:
> Hi Lucas,
> 
> On Thu, Mar 23, 2017 at 03:35:49PM +0100, Lucas Stach wrote:
> > Hi Dong,
> > 
> > Am Freitag, den 24.03.2017, 14:24 +0800 schrieb Dong Aisheng:
> > [...]
> > > > +static struct platform_driver imx7_pgc_domain_driver = {
> > > > +	.driver = {
> > > > +		.name = "imx7-pgc",
> > > > +	},
> > > > +	.probe    = imx7_pgc_domain_probe,
> > > > +	.remove   = imx7_pgc_domain_remove,
> > > > +	.id_table = imx7_pgc_domain_id,
> > > > +};
> > > > +builtin_platform_driver(imx7_pgc_domain_driver)
> > > 
> > > Again, i have a fundamental question about this patch implementation
> > > that why we choose above way to register the power domain?
> > > 
> > > I'm sorry that i did not know too much history.
> > > Would you guys please help share some information?
> > > 
> > > Because AFAIK this way will register each domain as a power domain
> > > provider which is a bit violate the real HW and current power domain
> > > framework design. And it is a bit more complicated to use than before.
> > > 
> > > IMHO i would rather prefer the old traditional and simpler way that one
> > > provider (GPC) supplies multiple domains (PCIE/MIPI/HSIC PHY domain)
> > > than this patch does.
> > > 
> > > However, i might be wrong. Please help to clear.
> > 
> > This way we can properly describe each power domain with the regulator
> > supplying the domain and the clocks of the devices inside the domain in
> > the device tree.
> > 
> 
> Thanks for the explaination. I understand that purpose.
> 
> Now my concern is why we doing things like this:
> Builtin two platforms driver and use one to dynamically create
> device to trigger another driver bind to register the domain.
> 
> static int imx7_pgc_domain_probe(struct platform_device *pdev)
> {
>         of_genpd_add_provider_simple(domain->dev->of_node,
>                                            &domain->genpd);
> }
> 
> static struct platform_driver imx7_pgc_domain_driver = {
>         .driver = {
>                 .name = "imx7-pgc",
>         },
>         .probe    = imx7_pgc_domain_probe,
> };
> builtin_platform_driver(imx7_pgc_domain_driver)
> 
> 
> static int imx_gpcv2_probe(struct platform_device *pdev)
> {
> 
>         for_each_child_of_node(pgc_np, np) {
>                 pd_pdev = platform_device_alloc("imx7-pgc-domain",
>                                                 domain_index);
>                 ret = platform_device_add(pd_pdev);
> 	}
> }
> 
> static struct platform_driver imx_gpc_driver = {
>         .driver = {
>                 .name = "imx-gpcv2",
>                 .of_match_table = imx_gpcv2_dt_ids,
>         }, 
>         .probe = imx_gpcv2_probe,
> };
> builtin_platform_driver(imx_gpc_driver)
> 
> Is there any special purpose or i missed something?

Yes, clocks and regulators can be looked up by the devices attached to
the DT nodes. This makes handling of those easy (or at all possible, the
regulator API doesn't allow to get regulators without the proper devnode
attached to a DT node).

> Can we just use one or a simple core_initcall(imx_gpcv2_probe) cause
> this probably should be registered early for other consumers?

Initcall levels are not going to work. We are dealing with regulators,
which can have supplies that are only probed when other modules are
loaded. If we need the domains to be up before the consumers, the only
way to deal with that is to select CONFIG_PM and
CONFIG_PM_GENERIC_DOMAINS from the platform, so we have proper probe
defer handling for consumer devices of the power domains.

> Personally i'd be more like Rockchip's power domain implementation.

Why?

> See:
> arch/arm/boot/dts/rk3288.dtsi
> drivers/soc/rockchip/pm_domains.c
> Dcumentation/devicetree/bindings/soc/rockchip/power_domain.txt
> 
> How about refer to the Rockchip's way?

Why? We just changed the way how it's done for GPCv1, after more than 1
year of those patches being on the list. Why should we do it differently
for GPCv2?

> 
> Then it could also address our issues and the binding would be
> still like:
> gpc: gpc at 303a0000 {
>         compatible = "fsl,imx7d-gpc";
>         reg = <0x303a0000 0x1000>;
>         interrupt-controller;
>         interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
>         #interrupt-cells = <3>;
>         interrupt-parent = <&intc>;
> 
>         pgc {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
> 
>                 pgc_pcie_phy: power-domain at IMX7_POWER_DOMAIN_PCIE_PHY {
>                         reg = <IMX7_POWER_DOMAIN_PCIE_PHY>;
>                         power-supply = <&reg_1p0d>;
> 			clocks = <xxx>;
>                 };
> 
> 		....
>         };
> };
> 
> It also drops #power-domain-cells and register domain by
> one provider with multi domains which is more align with HW.
> 
> How do you think of it?

How is this more aligned with the hardware? Both options are an
arbitrary abstraction chosen in the DT binding.

Regards,
Lucas
