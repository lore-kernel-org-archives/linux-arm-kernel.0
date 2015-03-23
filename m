From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 23 Mar 2015 07:44:24 +0100
Subject: [RFC] pinmux: group and function definitions in the device tree
In-Reply-To: <20150320150609.GB32259@odux.rfo.atmel.com>
References: <20150319153950.GC30114@odux.rfo.atmel.com>
 <20150319185637.GV4927@pengutronix.de>
 <20150320150609.GB32259@odux.rfo.atmel.com>
Message-ID: <20150323064424.GD9742@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 20, 2015 at 04:06:09PM +0100, Ludovic Desroches wrote:
> On Thu, Mar 19, 2015 at 07:56:37PM +0100, Sascha Hauer wrote:
> > On Thu, Mar 19, 2015 at 04:39:50PM +0100, Ludovic Desroches wrote:
> > > 	[...]
> > > 
> > > 	pinctrl_defs {
> > > 		mci0 {
> > > 			mci0_ioset0_1bit_grp {
> > > 				at91,pins = <68 69 70>;
> > > 				at91,mux = <2>;
> > > 			};
> > > 
> > > 			mci0_ioset0_4bit_grp {
> > > 				at91,pins = <68 69 70 71 72 73>;
> > > 				at91,mux = <2>;
> > > 			};
> > > 
> > > 			mci0_ioset0_8bit_grp {
> > > 				at91,pins = <68 69 70 71 72 73 74 75 76 77>;
> > > 				at91,mux = <2>;
> > > 			};
> > > 		};
> > > 	};
> > 
> > Why are different groups here? Do you want to put them into the dtsi?
> 
> We used to have a configuration per pin in our products. On next ones we
> will have some constraints ie. on the controller side we still have a
> configuration per pin but we will introduced the notion of iosets. This
> notion involves that timings are guaranteed only in one ioset. That's
> why we can't mix signals from several iosets because. On the controller side
> we can do all we want so I would like to use groups as a software protection.

What does happen when you mix signals of different iosets? It won't work
so the developer will change it. What do you need the software
protection for?

> i2c0 {
> 	i2c0_ioset0_grp {
> 		pins  = <PINMUX_PIN(71, 4),
> 			 PINMUX_PIN(72, 4)>;
> 	};
> 	i2c0_ioset1_grp {
> 		pins  = <PINMUX_PIN(91, 6),
> 			 PINMUX_PIN(92, 6)>;
> 	};
> 	i2c0_ioset2_grp {
> 		pins  = <PINMUX_PIN(108, 1),
> 			 PINMUX_PIN(109, 1)>;
> 	};
> };
> 
> 
> > This would mean you have to carry a lot of groups in each dtsi from
> > which only a small fraction is used. We did that on i.MX but no longer
> > do this since the dtbs get very big.
> 
> Yes I would like to put it in the dtsi file. For sure we will have big
> dtbs. If we put that in the driver we will increase the size of our
> kernel. If every one does this, we will have a lot of unused code for a
> multiplatform kernel. Where is the best place to put this?

If you put only the needed ones in each dts then you won't have to carry
all unused groups in all dtbs.

I think the idea you follow here is that you want to put all possible
combinations (mci0_ioset0_4bit_grp, mci0_ioset1_1bit_grp) into the dtsi
and let the board dts just pick one. For i.MX we realized that this does
not scale because the number of possibilities is too high. Very often
new boards had to introduce new pingroups in the dtsi because they did
not yet exist or even did exist in a slightly different configuration.
Out of tree dts files were painful because they often caused merge
conflicts in the dtsi files. Also there there was the risk that two new
groups were introduced with the same name but different meanings because
someone else was faster (and chose the next free number in the 'ioset'
counter).
We removed the groups in the dtsi files altogether and put them into
each board dts individually. This also made it easy to add the
additional pins (Write protect, card detect) to the same groups.

> > > - A subnode for these definitions in order to not parse the whole
> > >   pinctrl node to retrieve groups and functions.
> > > - Using node names as function and group names.
> > > - Can we get generic properties to define the groups? Of course a 'pins'
> > >   property is mandatory. In my case I will need an extra one to tell the
> > >   controller how to mux the pins (a same pin can have up to 7 muxing
> > >   possibilities).
> > 
> > Did you have a look at the RFC I sent for these kind of controllers [1] and
> > the final result for the Mediatek driver currently in Linux-next [2]?.
> > 
> > The binding has both the config and the pins in a single node and thus
> > is very compact.
> > 
> 
> Thanks for the links. Well I had a look to them and now I am a bit
> lost...
> 
> I agree with this binding but it involves to get rid of
> pinconf_generic_dt_node_to_map_all, isn't it? What do group and function
> become? It seems these concepts have disappeared.

The binding I suggested changes nothing with pinconf, only the pinmux
information is added to the same node. You can still call
pinconf_generic_dt_node_to_map_all() on the nodes, it will simply ignore
the pinmux information. You would have to handle them separately (or
write some generic helper if you like)

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
