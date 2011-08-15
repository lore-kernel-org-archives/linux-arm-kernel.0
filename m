From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 15 Aug 2011 13:44:53 -0700
Subject: [RFC PATCH 10/12] arm/tegra: Add device tree support to pinmux
	driver
In-Reply-To: <20110815203617.GB22355@gallagher>
References: <1313189697-21287-1-git-send-email-swarren@nvidia.com>
	<1313189697-21287-11-git-send-email-swarren@nvidia.com>
	<20110815200716.GA22355@gallagher> <20110815203617.GB22355@gallagher>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04AEA25174@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jamie Iles wrote at Monday, August 15, 2011 2:36 PM:
> On Mon, Aug 15, 2011 at 09:07:16PM +0100, Jamie Iles wrote:
> > Hi Stephen,
> >
> > On Fri, Aug 12, 2011 at 04:54:55PM -0600, Stephen Warren wrote:
> > > Signed-off-by: Stephen Warren <swarren@nvidia.com>
...
> > > diff --git a/arch/arm/mach-tegra/pinmux.c b/arch/arm/mach-tegra/pinmux.c
...
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
> > > +
> > > +		config.pingroup = pg;
> > > +
> > > +		ret = of_property_read_string(pg_node, "nvidia,function", &s);
...
> > > +		ret = of_property_read_string(pg_node, "nvidia,pull", &s);
...
> > > +		if (of_find_property(pg_node, "nvidia,tristate", NULL))
...
> > > +		tegra_pinmux_config_pingroup(&config);
> > > +
> > > +		of_node_put(pg_node);
> > > +	}
> > > +}
> >
> > I need to implement DT muxing configuration for my platform, and I believe
> > that what you have here would work fine for me too, and to avoid duplicating
> > the same thing, I wonder if this could be a little more generic.
> >
> > So if the platform specific pinmux driver called the pinmux parser with a
> > callback for a pingroup configuration function then this wouldn't need the
> > nvidia specific properties.  I'd envisage the setup callback to be something
> > like:
> >
> > 	int pingroup_configure(const char *name, unsigned long flags);
> 
> and it if this took the device_node too then the platform specific bits could
> handle more esoteric properties if required.  I'll have a go at prototyping
> this tomorrow unless there are any obvious reasons that this is a stupid idea!

I expect some of the code could be shared.

The only worry I have is whether some SoCs don't configure things like
pinmux function in the same place as pad function (pullup/down, tristate),
and hence whether a generic binding is generally applicable. I suppose the
code could always ignore unused properties.

I wonder how much of this is relevant to Linus W's pinctrl API?

Note that in the updated patch series I just posted, I reworked the binding
a little; Tegra has two sets of pin-groups, one configuring muxing, pullup/
down, and tri-state, and the other configuring various driver strength/
rate properties. Hence, the tree is now e.g.:

	pinmux: pinmux at 70000000 {
		compatible = "nvidia,tegra20-pinmux";
		reg = < 0x70000000 0xc00 >;
		nvidia,mux-groups {
			cdev1 {
				nvidia,function = "plla_out";
			};
			cdev2 {
				nvidia,function = "pllp_out4";
				nvidia,pull-down;
				nvidia,tristate;
			};
		};
		nvidia,drive-groups {
			sdio1 {
				nvidia,schmitt;
				nvidia,drive-power = <1>;
				nvidia,pull-down-strength = <31>;
				nvidia,pull-up-strength = <31>;
				nvidia,slew-rate-rising = <3>;
				nvidia,slew-rate-falling = <3>;
			};
		};
	};

But it's probably still reasonably easy to make the parser for the mux-groups
node generic. Perhaps it makes sense for all SoCs to have a "mux-settings"
node, even if they don't have any other custom nodes?

-- 
nvpublic
