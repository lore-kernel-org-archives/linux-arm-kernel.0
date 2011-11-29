From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 29 Nov 2011 09:13:37 -0800
Subject: [PATCH V2] arm/tegra: convert tegra20 to GIC devicetree binding
In-Reply-To: <4ED4D78A.6000400@ti.com>
References: <1322528052-6516-1-git-send-email-swarren@nvidia.com>
 <4ED4D78A.6000400@ti.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF174FDAFADC@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cousson, Benoit wrote at Tuesday, November 29, 2011 6:01 AM:
> Hi Stephen & Peter,
> 
> On 11/29/2011 1:54 AM, Stephen Warren wrote:
> > From: pdeschrijver at nvidia.com<pdeschrijver@nvidia.com>
> 
> [...]
> 
> > @@ -125,6 +131,14 @@ void __init tegra_init_irq(void)
> >   	gic_arch_extn.irq_unmask = tegra_unmask;
> >   	gic_arch_extn.irq_retrigger = tegra_retrigger;
> >
> > -	gic_init(0, 29, IO_ADDRESS(TEGRA_ARM_INT_DIST_BASE),
> > -		 IO_ADDRESS(TEGRA_ARM_PERIF_BASE + 0x100));
> > +#ifdef CONFIG_OF
> > +	/* Check if there is a devicetree present as of_irq_init doesn't
> > +	 * indicate if an interrupt controller node was found.
> > +	 */
> > +	if (of_find_node_by_path("/"))
> > +		of_irq_init(tegra_irq_match);
> > +	else
> > +#endif
> 
> For the same kind of need, I found the following API:
> 
> of_have_populated_dt()
> 
> Moreover, it returns false if !CONFIG_OF, so it will avoid the #ifdef.

That sounds like a great idea. Unfortunately, of_irq_init() is a DT-only
function. Exynos has the following in mainline to solve this:

        if (!of_have_populated_dt())
                gic_init_bases(...);
#ifdef CONFIG_OF
        else
                of_irq_init(exynos4_dt_irq_match);
#endif

Perhaps we should add a dummy of_irq_init() too, so that we can remove
this ifdef.

-- 
nvpublic
