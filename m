From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 18 Feb 2015 10:22:25 +0100
Subject: [PATCH 01/11] mfd: add the Berlin controller driver
In-Reply-To: <20150218090958.GA18042@x1>
References: <1423671332-24580-1-git-send-email-antoine.tenart@free-electrons.com>
 <1423671332-24580-2-git-send-email-antoine.tenart@free-electrons.com>
 <20150216124808.GC14545@x1> <20150217092020.GC4507@kwain>
 <20150217115447.GA3989@x1> <20150218084004.GD21937@kwain>
 <20150218090958.GA18042@x1>
Message-ID: <20150218092225.GE21937@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 18, 2015 at 09:09:58AM +0000, Lee Jones wrote:
> On Wed, 18 Feb 2015, Antoine Tenart wrote:
> 
> > On Tue, Feb 17, 2015 at 11:54:48AM +0000, Lee Jones wrote:
> > > On Tue, 17 Feb 2015, Antoine Tenart wrote:
> > > > On Mon, Feb 16, 2015 at 12:48:08PM +0000, Lee Jones wrote:
> > > > > On Wed, 11 Feb 2015, Antoine Tenart wrote:
> > > 
> > > > > > +static int berlin_ctrl_probe(struct platform_device *pdev)
> > > > > > +{
> > > > > > +	struct device *dev = &pdev->dev;
> > > > > > +	const struct of_device_id *match;
> > > > > > +	const struct berlin_ctrl_priv *priv;
> > > > > > +	int ret;
> > > > > > +
> > > > > > +	match = of_match_node(berlin_ctrl_of_match, dev->of_node);
> > > > > > +	if (!match)
> > > > > > +		return -EINVAL;
> > > > > > +
> > > > > > +	priv = match->data;
> > > > > > +
> > > > > > +	ret = mfd_add_devices(dev, 0, priv->devs, priv->ndevs, NULL, -1, NULL);
> > > > > > +	if (ret) {
> > > > > > +		dev_err(dev, "Failed to add devices: %d\n", ret);
> > > > > > +		return ret;
> > > > > > +	}
> > > > > > +
> > > > > > +	return 0;
> > > > > > +}
> > > > > 
> > > > > I'm not sure I see the point in this driver.  Why can't you just
> > > > > register these devices directly from DT?
> > > > 
> > > > All these devices share the same bank of registers and we previously
> > > > used a single node. But with many devices sharing a single node, this is
> > > > problematic to register all the devices from DT. Using this MFD driver
> > > > to do it is a proper solution in this case.
> > > 
> > > Tell me more.  What are the problems you encountered?
> > 
> > So we had a single node, chip-controller, accessed by multiple
> > devices -and drivers-. We ended up with:
> > 
> > chip: chip-control at ea0000 {
> > 	compatible = "marvell,berlin2q-chip-ctrl";
> > 	reg = <0xea0000 0x400>, <0xdd0170 0x10>;
> > 	#clock-cells = <1>;
> > 	#reset-cells = <2>;
> > 	clocks = <&refclk>;
> > 	clock-names = "refclk";
> > 
> > 	[pinmux nodes]
> > };
> > 
> > In addition to being a mess, how can you probe various drivers with this
> > single node? We had to probe a clock driver in addition to the
> > pin-controller and reset drivers. We ended up using arch_initcall() in
> > the reset driver, which was *not* acceptable.
> > 
> > These chip and system controllers are not an IP, but helps not spreading
> > this bank of registers all over the DT.
> > 
> > The solution to this problem is to introduce an mtd driver which
> > registers all the sub-devices described by these chip and system
> > controller nodes.
> 
> I'm still not convinced that your problem can't be solved in DT, but
> creating a single psudo-hardware node is not correct either.  What
> does the h/w _really_ look like?  Is all of this stuff on a single
> chip? 

There is no specific IP for these registers, but we do not want them
spread all over the DT nodes so they're summed up into this chip node.

SO we have all those registers into a chip/system node and sub-nodes for
the devices using them.

> If so, I would expect to see something like:
> 
> control at ea0000 {
> 	compatible = "marvel,control";
> 
> 	pinctrl at xxxxx {
> 		compatible = "marvel,pinctrl";
> 	};
> 
> 	reset at xxxxx {
> 		compatible = "marvel,reset";
> 	};
> };

That's exactly the point of this series: having one sub-node per device.

With this series applied, we have (the clock being a sub-node of the
chip-controller node is part of another series following this one):

chip: chip-controller at ea0000 {
        compatible = "marvell,berlin2q-chip-ctrl", "syscon";
        reg = <0xea0000 0x400>, <0xdd0170 0x10>;
        #clock-cells = <1>;
        clocks = <&refclk>;
        clock-names = "refclk";

        soc_pinctrl: pin-controller {
                compatible = "marvell,berlin2q-soc-pinctrl";

                twsi0_pmux: twsi0-pmux {
                        groups = "G6";
                        function = "twsi0";
                };

                twsi1_pmux: twsi1-pmux {
                        groups = "G7";
                        function = "twsi1";
                };
        };

        chip_rst: reset {
                compatible = "marvell,berlin2-reset";
                #reset-cells = <2>;
        };
};

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
