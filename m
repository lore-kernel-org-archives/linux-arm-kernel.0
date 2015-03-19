From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Thu, 19 Mar 2015 16:39:50 +0100
Subject: [RFC] pinmux: group and function definitions in the device tree
Message-ID: <20150319153950.GC30114@odux.rfo.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I would like to start a discussion about pinmuxing and device tree bindings.

I am currently writing a new pinmuxing driver using the generic pinconf.
My main concern is about defining functions and which pins belong to a
group.

At the moment, it seems that most drivers using the generic pinconf
define this stuff in a static way. The pinctrl-at91 driver covers many
devices, the new one should do the same for new Atmel devices. Having
the group and function definitions in the driver could involve a huge
file...
I am not sure it is a good thing to embed all these information into a
single zImage...

How can we achieved this? I was thinking about something like this:

pinctrl at fc06a000 {

	[...]

	pinctrl_defs {
		mci0 {
			mci0_ioset0_1bit_grp {
				at91,pins = <68 69 70>;
				at91,mux = <2>;
			};

			mci0_ioset0_4bit_grp {
				at91,pins = <68 69 70 71 72 73>;
				at91,mux = <2>;
			};

			mci0_ioset0_8bit_grp {
				at91,pins = <68 69 70 71 72 73 74 75 76 77>;
				at91,mux = <2>;
			};
		};
	};

	pinctrl_mci0_default: mci0_default {
		mux {
			function = "mci0";
			groups = &mci0_ioset0_8bit_grp;
		};

		conf {
			groups = &mci0_ioset0_8bit_grp;
			bias-pullup;
		};
	};
};

- A subnode for these definitions in order to not parse the whole
  pinctrl node to retrieve groups and functions.
- Using node names as function and group names.
- Can we get generic properties to define the groups? Of course a 'pins'
  property is mandatory. In my case I will need an extra one to tell the
  controller how to mux the pins (a same pin can have up to 7 muxing
  possibilities).


Thanks for your advices.

Ludovic
