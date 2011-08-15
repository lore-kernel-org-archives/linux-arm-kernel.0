From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 15 Aug 2011 09:09:40 -0700
Subject: [RFC PATCH 10/12] arm/tegra: Add device tree support to pinmux
	driver
In-Reply-To: <20110813104850.GD2643@pulham.picochip.com>
References: <1313189697-21287-1-git-send-email-swarren@nvidia.com>
	<1313189697-21287-11-git-send-email-swarren@nvidia.com>
	<20110813104323.GC2643@pulham.picochip.com>
	<20110813104850.GD2643@pulham.picochip.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04AEA25055@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jamie Iles wrote at Saturday, August 13, 2011 4:49 AM:
> On Sat, Aug 13, 2011 at 11:43:23AM +0100, Jamie Iles wrote:
> > Hi Stephen,
> >
> > On Fri, Aug 12, 2011 at 04:54:55PM -0600, Stephen Warren wrote:
...
> > > diff --git a/arch/arm/mach-tegra/pinmux.c b/arch/arm/mach-tegra/pinmux.c
...
> > > +#ifdef CONFIG_OF
> > > +static void __init tegra_pinmux_probe_dt(struct platform_device *pdev)
> > > +{
> > > +	int pg;
> > > +
> > > +	for (pg = 0; pg < TEGRA_MAX_PINGROUP; pg++) {
> > > +		const char *pg_name = pingroup_name(pg);
> > > +		struct tegra_pingroup_config config;
> > > +		struct device_node *pg_node;
> > > +		int ret;
> > > +		const char *s;
> > > +
> > > +		pg_node = of_find_child_node_by_name(pdev->dev.of_node,
> > > +						     pg_name);
> > > +		if (pg_node == NULL)
> > > +			continue;
> >
> > Rather than iterating over all of the mux names in the pinmux driver and
> > searching for a matching DT node, could you not do it the other way
> > round?  So do an for_each_child_of_node() on the pinmux node then find
> > the matching pingroup keyed by the node name?  This would eliminate
> > of_find_child_node_by_name().  You could also catch invalid
> > configurations for non-existent pins this way.
> 
> I just re-read your introduction email and saw you've already discussed
> this!  Would this require an explicit pin name property though or could
> you just key off of the pg_node->name?

No, I think pg_node->name will work out fine; it's what of_find_child_node_by_name
is using anyway.

-- 
nvpublic
