From: dongas86@gmail.com (Dong Aisheng)
Date: Tue, 11 Apr 2017 11:22:36 +0800
Subject: [PATCH v7 2/2] soc/imx: Add GPCv2 power gating driver
In-Reply-To: <1490963291.29083.69.camel@pengutronix.de>
References: <20170321145004.21265-1-andrew.smirnov@gmail.com>
 <20170321145004.21265-3-andrew.smirnov@gmail.com>
 <20170324062451.GB12604@b29396-OptiPlex-7040>
 <1490279749.29056.33.camel@pengutronix.de>
 <20170330075111.GC29432@b29396-OptiPlex-7040>
 <1490803711.29083.25.camel@pengutronix.de>
 <20170401041007.GC24882@b29396-OptiPlex-7040>
 <1490963291.29083.69.camel@pengutronix.de>
Message-ID: <20170411032236.GB9067@b29396-OptiPlex-7040>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 31, 2017 at 02:28:11PM +0200, Lucas Stach wrote:
> Hi Dong,
> 
> Am Samstag, den 01.04.2017, 12:10 +0800 schrieb Dong Aisheng:
> [...]
> > > If we need the domains to be up before the consumers, the only
> > > way to deal with that is to select CONFIG_PM and
> > > CONFIG_PM_GENERIC_DOMAINS from the platform, so we have proper probe
> > > defer handling for consumer devices of the power domains.
> > > 
> > 
> > A bit confuse about these words...
> 
> If those options are selected we get proper PROBE_DEFER handling for
> consumers of the power domain, so probe order doesn't matter.
> 
> > > > Personally i'd be more like Rockchip's power domain implementation.
> > > 
> > > Why?
> > > 
> > > > See:
> > > > arch/arm/boot/dts/rk3288.dtsi
> > > > drivers/soc/rockchip/pm_domains.c
> > > > Dcumentation/devicetree/bindings/soc/rockchip/power_domain.txt
> > > > 
> > > > How about refer to the Rockchip's way?
> > > 
> > > Why? We just changed the way how it's done for GPCv1, after more than 1
> > > year of those patches being on the list. Why should we do it differently
> > > for GPCv2?
> > > 
> > 
> > Hmm?
> > 
> > I just thought your GPCv1 change was picked a few weeks ago (Feb 17 2017)
> > and there's no current users in kernel of the new binding.
> > That's why i come out of the idea if we could improve it before any users.
> > 
> > Maybe i made mistake?
> 
> The patches to change this have been out for over 1 year. I'm less than
> motivated to change the binding again, after it has gone through the DT
> review and has finally been picked up.
> 
> > See:
> > commit 721cabf6c6600dbe689ee2782bc087270e97e652
> > Author: Lucas Stach <l.stach@pengutronix.de>
> > Date:   Fri Feb 17 20:02:44 2017 +0100
> > 
> >     soc: imx: move PGC handling to a new GPC driver
> >     
> >     This is an almost complete re-write of the previous GPC power gating control
> >     code found in the IMX architecture code. It supports both the old and the new
> >     DT binding, allowing more domains to be added later and generally makes the
> >     driver easier to extend, while keeping compatibility with existing DTBs.
> >     
> >     As the result, all functionality regarding the power gating controller
> >     gets removed from the IMX architecture GPC driver.  It keeps only the
> >     IRQ controller code in the architecture, as this is closely coupled to
> >     the CPU idle implementation.
> >     
> >     Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> >     Signed-off-by: Shawn Guo <shawnguo@kernel.org>
> > 
> > > > 
> > > > Then it could also address our issues and the binding would be
> > > > still like:
> > > > gpc: gpc at 303a0000 {
> > > >         compatible = "fsl,imx7d-gpc";
> > > >         reg = <0x303a0000 0x1000>;
> > > >         interrupt-controller;
> > > >         interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
> > > >         #interrupt-cells = <3>;
> > > >         interrupt-parent = <&intc>;
> > > > 
> > > >         pgc {
> > > >                 #address-cells = <1>;
> > > >                 #size-cells = <0>;
> > > > 
> > > >                 pgc_pcie_phy: power-domain at IMX7_POWER_DOMAIN_PCIE_PHY {
> > > >                         reg = <IMX7_POWER_DOMAIN_PCIE_PHY>;
> > > >                         power-supply = <&reg_1p0d>;
> > > > 			clocks = <xxx>;
> > > >                 };
> > > > 
> > > > 		....
> > > >         };
> > > > };
> > > > 
> > > > It also drops #power-domain-cells and register domain by
> > > > one provider with multi domains which is more align with HW.
> > > > 
> > > > How do you think of it?
> > > 
> > > How is this more aligned with the hardware? Both options are an
> > > arbitrary abstraction chosen in the DT binding.
> > > 
> > 
> > GPC is a Power Controller which controls multi power domains to subsystem
> > by its different registers bits.
> > e.g. PCIE/MIPI/USB HSIC PHY.
> > ? 0xC00 ~ 0xC3F: PGC for MIPI PHY
> > ? 0xC40 ~ 0xC7F: PGC for PCIE_PHY
> > ? 0xD00 ~ 0xD3F: PGC for USB HSIC PHY
> > 
> > So i thought it looks more like GPC is a power domain provider with multi
> > domains support to different subsystems from HW point of view.
> > 
> > Isn't that true?
> 
> Linux and hardware devices are not required to match 1:1. There is
> nothing that would make subdividing a single hardware device into
> multiple ones bad style.
> 
> > 
> > And there's also other two concerns:
> > First, current genpd sysfs output still not include provider.
> > e.g.
> > root at imx6qdlsolo:~# cat /sys/kernel/debug/pm_genpd/pm_genpd_summary 
> > domain                          status          slaves
> >     /device                                             runtime status
> > ----------------------------------------------------------------------
> > PU                              off-0           
> >     /devices/soc0/soc/130000.gpu                        suspended
> >     /devices/soc0/soc/134000.gpu                        suspended
> >     /devices/soc0/soc/2204000.gpu                       suspended
> >     /devices/soc0/soc/2000000.aips-bus/2040000.vpu      suspended
> > ARM                             off-0           
> > 
> > I wonder it might be a bit mess once the provider is added while each
> > domain is registered as a virtual provider.
> 
> The provider is a Linux device. Linux devices don't necessarily have to
> correspond to hardware devices. There is no such rule.
> 
> > 
> > Second, it sacrifices a bit performance when look-up PM domain in
> > genpd_get_from_provider if every domain is a provider.
> > 
> The performance penalty of a list walk won't hurt us in the probe path,
> where we are (re-)probing entire devices. There is a lot more going on
> than a simple list walk.
> 

It is mostly care in a simulation platform like Zebu while the code
execution time is quite long even it's very small in real word.

> > Though it is arguable that currently only 3 domains support on MX7,
> > but who knows the future when it becomes much more.
> > 
> > However, i did see many exist users in kernel using one provider one
> > domain way. Maybe i'm over worried and it's not big deal.
> 
> I see that one provider with multiple domains is used more often, that
> doesn't means it's necessarily better. At least I haven't hear a
> convincing argument on why the chosen implementation in the GPC driver
> is worse than the alternative.
> 

Well, this is not a strong objection. I could also accept it if no
objection from maintainer.

And seems Shawn already picked the patches. So never mind,
let's keep going on.

Regards
Dong Aisheg

> Regards,
> Lucas
> 
