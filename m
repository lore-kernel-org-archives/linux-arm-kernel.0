From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Fri, 20 Mar 2015 16:06:09 +0100
Subject: [RFC] pinmux: group and function definitions in the device tree
In-Reply-To: <20150319185637.GV4927@pengutronix.de>
References: <20150319153950.GC30114@odux.rfo.atmel.com>
 <20150319185637.GV4927@pengutronix.de>
Message-ID: <20150320150609.GB32259@odux.rfo.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 19, 2015 at 07:56:37PM +0100, Sascha Hauer wrote:
> On Thu, Mar 19, 2015 at 04:39:50PM +0100, Ludovic Desroches wrote:
> > Hi,
> > 
> > I would like to start a discussion about pinmuxing and device tree bindings.
> > 
> > I am currently writing a new pinmuxing driver using the generic pinconf.
> > My main concern is about defining functions and which pins belong to a
> > group.
> > 
> > At the moment, it seems that most drivers using the generic pinconf
> > define this stuff in a static way. The pinctrl-at91 driver covers many
> > devices, the new one should do the same for new Atmel devices. Having
> > the group and function definitions in the driver could involve a huge
> > file...
> > I am not sure it is a good thing to embed all these information into a
> > single zImage...
> > 
> > How can we achieved this? I was thinking about something like this:
> > 
> > pinctrl at fc06a000 {
> > 
> > 	[...]
> > 
> > 	pinctrl_defs {
> > 		mci0 {
> > 			mci0_ioset0_1bit_grp {
> > 				at91,pins = <68 69 70>;
> > 				at91,mux = <2>;
> > 			};
> > 
> > 			mci0_ioset0_4bit_grp {
> > 				at91,pins = <68 69 70 71 72 73>;
> > 				at91,mux = <2>;
> > 			};
> > 
> > 			mci0_ioset0_8bit_grp {
> > 				at91,pins = <68 69 70 71 72 73 74 75 76 77>;
> > 				at91,mux = <2>;
> > 			};
> > 		};
> > 	};
> 
> Why are different groups here? Do you want to put them into the dtsi?

We used to have a configuration per pin in our products. On next ones we
will have some constraints ie. on the controller side we still have a
configuration per pin but we will introduced the notion of iosets. This
notion involves that timings are guaranteed only in one ioset. That's
why we can't mix signals from several iosets because. On the controller side
we can do all we want so I would like to use groups as a software protection.

I have several groups because I can only choose the 4bit group and use other
pins for an other device.

Example:

mci0 {
	mci0_ioset0_1bit_grp {
		pins = <PINMUX_PIN(68, 2),
			PINMUX_PIN(69, 2),
			PINMUX_PIN(70, 2)>;
	};
	mci0_ioset0_4bit_grp {
		pins = <PINMUX_PIN(68, 2),
			PINMUX_PIN(69, 2),
			PINMUX_PIN(70, 2),
			PINMUX_PIN(71, 2),
			PINMUX_PIN(72, 2),
			PINMUX_PIN(73, 2)>;
	};
	mci0_ioset0_8bit_grp {
		pins = <PINMUX_PIN(68, 2),
			PINMUX_PIN(69, 2),
			PINMUX_PIN(70, 2),
			PINMUX_PIN(71, 2),
			PINMUX_PIN(72, 2),
			PINMUX_PIN(73, 2),
			PINMUX_PIN(74, 2),
			PINMUX_PIN(75, 2),
			PINMUX_PIN(76, 2),
			PINMUX_PIN(77, 2)>;
	};
	mci0_ioset1_1bit_grp {
		pins = <PINMUX_PIN(153, 1),
			PINMUX_PIN(154, 1),
			PINMUX_PIN(155, 1)>;
	};
};

i2c0 {
	i2c0_ioset0_grp {
		pins  = <PINMUX_PIN(71, 4),
			 PINMUX_PIN(72, 4)>;
	};
	i2c0_ioset1_grp {
		pins  = <PINMUX_PIN(91, 6),
			 PINMUX_PIN(92, 6)>;
	};
	i2c0_ioset2_grp {
		pins  = <PINMUX_PIN(108, 1),
			 PINMUX_PIN(109, 1)>;
	};
};


> This would mean you have to carry a lot of groups in each dtsi from
> which only a small fraction is used. We did that on i.MX but no longer
> do this since the dtbs get very big.

Yes I would like to put it in the dtsi file. For sure we will have big
dtbs. If we put that in the driver we will increase the size of our
kernel. If every one does this, we will have a lot of unused code for a
multiplatform kernel. Where is the best place to put this?

> 
> > 
> > 	pinctrl_mci0_default: mci0_default {
> > 		mux {
> > 			function = "mci0";
> > 			groups = &mci0_ioset0_8bit_grp;
> > 		};
> > 
> > 		conf {
> > 			groups = &mci0_ioset0_8bit_grp;
> > 			bias-pullup;
> > 		};
> > 	};
> > };
> > 
> > - A subnode for these definitions in order to not parse the whole
> >   pinctrl node to retrieve groups and functions.
> > - Using node names as function and group names.
> > - Can we get generic properties to define the groups? Of course a 'pins'
> >   property is mandatory. In my case I will need an extra one to tell the
> >   controller how to mux the pins (a same pin can have up to 7 muxing
> >   possibilities).
> 
> Did you have a look at the RFC I sent for these kind of controllers [1] and
> the final result for the Mediatek driver currently in Linux-next [2]?.
> 
> The binding has both the config and the pins in a single node and thus
> is very compact.
> 

Thanks for the links. Well I had a look to them and now I am a bit
lost...

I agree with this binding but it involves to get rid of
pinconf_generic_dt_node_to_map_all, isn't it? What do group and function
become? It seems these concepts have disappeared.

I am disappointed because I have the feeling that the only remaining
part of the generic pinconf are the configuration properties.

> Sascha
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-October/296491.html
> [2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/318452.html
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> --
> To unsubscribe from this list: send the line "unsubscribe linux-gpio" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
