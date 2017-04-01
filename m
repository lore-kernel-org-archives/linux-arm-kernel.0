From: dongas86@gmail.com (Dong Aisheng)
Date: Sat, 1 Apr 2017 12:10:07 +0800
Subject: [PATCH v7 2/2] soc/imx: Add GPCv2 power gating driver
In-Reply-To: <1490803711.29083.25.camel@pengutronix.de>
References: <20170321145004.21265-1-andrew.smirnov@gmail.com>
 <20170321145004.21265-3-andrew.smirnov@gmail.com>
 <20170324062451.GB12604@b29396-OptiPlex-7040>
 <1490279749.29056.33.camel@pengutronix.de>
 <20170330075111.GC29432@b29396-OptiPlex-7040>
 <1490803711.29083.25.camel@pengutronix.de>
Message-ID: <20170401041007.GC24882@b29396-OptiPlex-7040>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lucas,

Thanks for the explaination.

On Wed, Mar 29, 2017 at 06:08:31PM +0200, Lucas Stach wrote:
> Hi Dong,
> 
> Am Donnerstag, den 30.03.2017, 15:51 +0800 schrieb Dong Aisheng:
> > Hi Lucas,
> > 
> > On Thu, Mar 23, 2017 at 03:35:49PM +0100, Lucas Stach wrote:
> > > Hi Dong,
> > > 
> > > Am Freitag, den 24.03.2017, 14:24 +0800 schrieb Dong Aisheng:
> > > [...]
> > > > > +static struct platform_driver imx7_pgc_domain_driver = {
> > > > > +	.driver = {
> > > > > +		.name = "imx7-pgc",
> > > > > +	},
> > > > > +	.probe    = imx7_pgc_domain_probe,
> > > > > +	.remove   = imx7_pgc_domain_remove,
> > > > > +	.id_table = imx7_pgc_domain_id,
> > > > > +};
> > > > > +builtin_platform_driver(imx7_pgc_domain_driver)
> > > > 
> > > > Again, i have a fundamental question about this patch implementation
> > > > that why we choose above way to register the power domain?
> > > > 
> > > > I'm sorry that i did not know too much history.
> > > > Would you guys please help share some information?
> > > > 
> > > > Because AFAIK this way will register each domain as a power domain
> > > > provider which is a bit violate the real HW and current power domain
> > > > framework design. And it is a bit more complicated to use than before.
> > > > 
> > > > IMHO i would rather prefer the old traditional and simpler way that one
> > > > provider (GPC) supplies multiple domains (PCIE/MIPI/HSIC PHY domain)
> > > > than this patch does.
> > > > 
> > > > However, i might be wrong. Please help to clear.
> > > 
> > > This way we can properly describe each power domain with the regulator
> > > supplying the domain and the clocks of the devices inside the domain in
> > > the device tree.
> > > 
> > 
> > Thanks for the explaination. I understand that purpose.
> > 
> > Now my concern is why we doing things like this:
> > Builtin two platforms driver and use one to dynamically create
> > device to trigger another driver bind to register the domain.
> > 
> > static int imx7_pgc_domain_probe(struct platform_device *pdev)
> > {
> >         of_genpd_add_provider_simple(domain->dev->of_node,
> >                                            &domain->genpd);
> > }
> > 
> > static struct platform_driver imx7_pgc_domain_driver = {
> >         .driver = {
> >                 .name = "imx7-pgc",
> >         },
> >         .probe    = imx7_pgc_domain_probe,
> > };
> > builtin_platform_driver(imx7_pgc_domain_driver)
> > 
> > 
> > static int imx_gpcv2_probe(struct platform_device *pdev)
> > {
> > 
> >         for_each_child_of_node(pgc_np, np) {
> >                 pd_pdev = platform_device_alloc("imx7-pgc-domain",
> >                                                 domain_index);
> >                 ret = platform_device_add(pd_pdev);
> > 	}
> > }
> > 
> > static struct platform_driver imx_gpc_driver = {
> >         .driver = {
> >                 .name = "imx-gpcv2",
> >                 .of_match_table = imx_gpcv2_dt_ids,
> >         }, 
> >         .probe = imx_gpcv2_probe,
> > };
> > builtin_platform_driver(imx_gpc_driver)
> > 
> > Is there any special purpose or i missed something?
> 
> Yes, clocks and regulators can be looked up by the devices attached to
> the DT nodes. This makes handling of those easy (or at all possible, the
> regulator API doesn't allow to get regulators without the proper devnode
> attached to a DT node).
> 

That probably is not true.
Regulator API does allow to get regulators without dev or devnode parameter.
e.g. reg_arm = regulator_get(NULL, "vddarm");

However, i did feel like that this using is not quite suitable for DT
users while it introduces limitation and dependencies in device tree.

Then, platform driver/device mode seems truely a better approach for this
issue.

> > Can we just use one or a simple core_initcall(imx_gpcv2_probe) cause
> > this probably should be registered early for other consumers?
> 
> Initcall levels are not going to work. We are dealing with regulators,
> which can have supplies that are only probed when other modules are
> loaded. 

I see. A clear explain.

> If we need the domains to be up before the consumers, the only
> way to deal with that is to select CONFIG_PM and
> CONFIG_PM_GENERIC_DOMAINS from the platform, so we have proper probe
> defer handling for consumer devices of the power domains.
> 

A bit confuse about these words...

> > Personally i'd be more like Rockchip's power domain implementation.
> 
> Why?
> 
> > See:
> > arch/arm/boot/dts/rk3288.dtsi
> > drivers/soc/rockchip/pm_domains.c
> > Dcumentation/devicetree/bindings/soc/rockchip/power_domain.txt
> > 
> > How about refer to the Rockchip's way?
> 
> Why? We just changed the way how it's done for GPCv1, after more than 1
> year of those patches being on the list. Why should we do it differently
> for GPCv2?
> 

Hmm?

I just thought your GPCv1 change was picked a few weeks ago (Feb 17 2017)
and there's no current users in kernel of the new binding.
That's why i come out of the idea if we could improve it before any users.

Maybe i made mistake?

See:
commit 721cabf6c6600dbe689ee2782bc087270e97e652
Author: Lucas Stach <l.stach@pengutronix.de>
Date:   Fri Feb 17 20:02:44 2017 +0100

    soc: imx: move PGC handling to a new GPC driver
    
    This is an almost complete re-write of the previous GPC power gating control
    code found in the IMX architecture code. It supports both the old and the new
    DT binding, allowing more domains to be added later and generally makes the
    driver easier to extend, while keeping compatibility with existing DTBs.
    
    As the result, all functionality regarding the power gating controller
    gets removed from the IMX architecture GPC driver.  It keeps only the
    IRQ controller code in the architecture, as this is closely coupled to
    the CPU idle implementation.
    
    Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
    Signed-off-by: Shawn Guo <shawnguo@kernel.org>

> > 
> > Then it could also address our issues and the binding would be
> > still like:
> > gpc: gpc at 303a0000 {
> >         compatible = "fsl,imx7d-gpc";
> >         reg = <0x303a0000 0x1000>;
> >         interrupt-controller;
> >         interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
> >         #interrupt-cells = <3>;
> >         interrupt-parent = <&intc>;
> > 
> >         pgc {
> >                 #address-cells = <1>;
> >                 #size-cells = <0>;
> > 
> >                 pgc_pcie_phy: power-domain at IMX7_POWER_DOMAIN_PCIE_PHY {
> >                         reg = <IMX7_POWER_DOMAIN_PCIE_PHY>;
> >                         power-supply = <&reg_1p0d>;
> > 			clocks = <xxx>;
> >                 };
> > 
> > 		....
> >         };
> > };
> > 
> > It also drops #power-domain-cells and register domain by
> > one provider with multi domains which is more align with HW.
> > 
> > How do you think of it?
> 
> How is this more aligned with the hardware? Both options are an
> arbitrary abstraction chosen in the DT binding.
> 

GPC is a Power Controller which controls multi power domains to subsystem
by its different registers bits.
e.g. PCIE/MIPI/USB HSIC PHY.
? 0xC00 ~ 0xC3F: PGC for MIPI PHY
? 0xC40 ~ 0xC7F: PGC for PCIE_PHY
? 0xD00 ~ 0xD3F: PGC for USB HSIC PHY

So i thought it looks more like GPC is a power domain provider with multi
domains support to different subsystems from HW point of view.

Isn't that true?

And there's also other two concerns:
First, current genpd sysfs output still not include provider.
e.g.
root at imx6qdlsolo:~# cat /sys/kernel/debug/pm_genpd/pm_genpd_summary 
domain                          status          slaves
    /device                                             runtime status
----------------------------------------------------------------------
PU                              off-0           
    /devices/soc0/soc/130000.gpu                        suspended
    /devices/soc0/soc/134000.gpu                        suspended
    /devices/soc0/soc/2204000.gpu                       suspended
    /devices/soc0/soc/2000000.aips-bus/2040000.vpu      suspended
ARM                             off-0           

I wonder it might be a bit mess once the provider is added while each
domain is registered as a virtual provider.

Second, it sacrifices a bit performance when look-up PM domain in
genpd_get_from_provider if every domain is a provider.

Though it is arguable that currently only 3 domains support on MX7,
but who knows the future when it becomes much more.

However, i did see many exist users in kernel using one provider one
domain way. Maybe i'm over worried and it's not big deal.

Rafael,
Would you provide some guidance on this issue?

> Regards,
> Lucas
> 

Regards
Dong Aisheng
