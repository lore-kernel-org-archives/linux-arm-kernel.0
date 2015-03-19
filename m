From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 19 Mar 2015 19:56:37 +0100
Subject: [RFC] pinmux: group and function definitions in the device tree
In-Reply-To: <20150319153950.GC30114@odux.rfo.atmel.com>
References: <20150319153950.GC30114@odux.rfo.atmel.com>
Message-ID: <20150319185637.GV4927@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 19, 2015 at 04:39:50PM +0100, Ludovic Desroches wrote:
> Hi,
> 
> I would like to start a discussion about pinmuxing and device tree bindings.
> 
> I am currently writing a new pinmuxing driver using the generic pinconf.
> My main concern is about defining functions and which pins belong to a
> group.
> 
> At the moment, it seems that most drivers using the generic pinconf
> define this stuff in a static way. The pinctrl-at91 driver covers many
> devices, the new one should do the same for new Atmel devices. Having
> the group and function definitions in the driver could involve a huge
> file...
> I am not sure it is a good thing to embed all these information into a
> single zImage...
> 
> How can we achieved this? I was thinking about something like this:
> 
> pinctrl at fc06a000 {
> 
> 	[...]
> 
> 	pinctrl_defs {
> 		mci0 {
> 			mci0_ioset0_1bit_grp {
> 				at91,pins = <68 69 70>;
> 				at91,mux = <2>;
> 			};
> 
> 			mci0_ioset0_4bit_grp {
> 				at91,pins = <68 69 70 71 72 73>;
> 				at91,mux = <2>;
> 			};
> 
> 			mci0_ioset0_8bit_grp {
> 				at91,pins = <68 69 70 71 72 73 74 75 76 77>;
> 				at91,mux = <2>;
> 			};
> 		};
> 	};

Why are different groups here? Do you want to put them into the dtsi?
This would mean you have to carry a lot of groups in each dtsi from
which only a small fraction is used. We did that on i.MX but no longer
do this since the dtbs get very big.

> 
> 	pinctrl_mci0_default: mci0_default {
> 		mux {
> 			function = "mci0";
> 			groups = &mci0_ioset0_8bit_grp;
> 		};
> 
> 		conf {
> 			groups = &mci0_ioset0_8bit_grp;
> 			bias-pullup;
> 		};
> 	};
> };
> 
> - A subnode for these definitions in order to not parse the whole
>   pinctrl node to retrieve groups and functions.
> - Using node names as function and group names.
> - Can we get generic properties to define the groups? Of course a 'pins'
>   property is mandatory. In my case I will need an extra one to tell the
>   controller how to mux the pins (a same pin can have up to 7 muxing
>   possibilities).

Did you have a look at the RFC I sent for these kind of controllers [1] and
the final result for the Mediatek driver currently in Linux-next [2]?.

The binding has both the config and the pins in a single node and thus
is very compact.

Sascha

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-October/296491.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/318452.html

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
