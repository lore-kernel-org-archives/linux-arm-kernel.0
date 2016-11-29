From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 29 Nov 2016 13:05:56 -0800
Subject: [alsa-devel] [PATCH v2] clkdev: add devm_of_clk_get()
In-Reply-To: <87y409cw71.wl%kuninori.morimoto.gx@renesas.com>
References: <87ziptixv7.wl%kuninori.morimoto.gx@renesas.com>
 <20160707122636.GP1041@n2100.armlinux.org.uk>
 <8760shgfzu.wl%kuninori.morimoto.gx@renesas.com>
 <146794140875.73491.7115209079607438738@resonance>
 <871t34hlin.wl%kuninori.morimoto.gx@renesas.com>
 <878twndi54.wl%kuninori.morimoto.gx@renesas.com>
 <8737isvwc6.wl%kuninori.morimoto.gx@renesas.com>
 <20161123191037.GE25626@codeaurora.org>
 <87a8cpejn5.wl%kuninori.morimoto.gx@renesas.com>
 <87y409cw71.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <20161129210556.GC6095@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/24, Kuninori Morimoto wrote:
> 
> Hi Stephen, again
> 
> > > I've seen bindings that have the 'clocks' property at the top
> > > level and the appropriate 'clock-names' property to relate the
> > > clocks to a subnode.
> > > 
> > >  	sound_soc {
> > > 		clocks = <&xxx>, <&xxx>;
> > > 		clock-names = "cpu", "codec";
> > >  		...
> > >  		cpu {
> > >  			...
> > >  		};
> > >  		codec {
> > >  			...
> > >  		};
> > >  	};
> > > 
> > > Then the subnodes call clk_get() with the top level device and
> > > the name of their node and things match up. I suppose this
> > > binding is finalized though, so we can't really do that?
> > > 
> > > I see that the gpio framework has a similar design called
> > > devm_get_gpiod_from_child(), so how about we add a
> > > devm_get_clk_from_child() API? That would more closely match the
> > > intent here, which is to restrict the clk_get() operation to
> > > child nodes of the device passed as the first argument.
> > > 
> > > struct clk *devm_get_clk_from_child(struct device *dev,
> > > 				    const char *con_id,
> > > 				    struct device_node *child);
> 
> Thanks, but, my point is that Linux already have "of_clk_get()",
> but we don't have its devm_ version.
> The point is that of_clk_get() can get clock from "device_node".
> Why having devm_ version become so problem ?

The problem is that it encourages the use of of_clk_get() when
clk_get() is more desirable. Ideally of_clk_get() is never used
when a device exists. In this case, it seems like we need to
support it though, hence the suggestion of having a
devm_get_clk_from_child() API, that explicitly reads as "get a
clock from a child node of this device". The distinction is
important, because of_clk_get() should rarely be used.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
