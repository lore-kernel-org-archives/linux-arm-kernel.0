From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Fri, 4 May 2012 08:17:36 +0200
Subject: [PATCHv3 1/4] ARM: tegra: Add Tegra AHB driver
In-Reply-To: <4FA2C34F.5060406@wwwdotorg.org>
References: <1336061147-10245-1-git-send-email-hdoyu@nvidia.com><4FA2C34F.5060406@wwwdotorg.org>
Message-ID: <20120504.091736.839941449020176796.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCHv3 1/4] ARM: tegra: Add Tegra AHB driver
Date: Thu, 3 May 2012 19:41:35 +0200
Message-ID: <4FA2C34F.5060406@wwwdotorg.org>

> On 05/03/2012 10:05 AM, Hiroshi DOYU wrote:
> > Tegra AHB Bus conforms to the AMBA Specification (Rev 2.0) Advanced
> > High-performance Bus (AHB) architecture.
> > 
> > The AHB Arbiter controls AHB bus master arbitration. This effectively
> > forms a second level of arbitration for access to the memory
> > controller through the AHB Slave Memory device. The AHB pre-fetch
> > logic can be configured to enhance performance for devices doing
> > sequential access. Each AHB master is assigned to either the high or
> > low priority bin. Both Tegra20/30 have this AHB bus.
> > 
> > Some of configuration param could be passed from DT too.
> 
> > diff --git a/drivers/amba/tegra-ahb.c b/drivers/amba/tegra-ahb.c
> > +static u32 tegra_ahb_gizmo[] = {
> 
> const?

Yes.

> > +static int __init tegra_ahb_module_init(void)
> > +{
> > +	return platform_driver_register(&tegra_ahb_driver);
> > +}
> > +postcore_initcall(tegra_ahb_module_init);
> 
> Can this be a module_init() instead of postcore_initcall()?

Since this driver configures prefetch size from AHB client devices,
it's better to make this driver available before other AHB client
drivers get ready. So "postcore_initcall()" seems to make sense if
there's no other better initcall.

> > +
> > +static void __exit tegra_ahb_module_exit(void)
> > +{
> > +	platform_driver_unregister(&tegra_ahb_driver);
> > +}
> > +module_exit(tegra_ahb_module_exit);
> 
> If so, all of the previous two quoted chunks can be replaced with just:
> 
> module_platform_driver(tegra_ahb_module_init);
