From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 23 Apr 2012 13:01:47 -0600
Subject: [PATCH 1/2] pinctrl: add pinctrl-mxs support
In-Reply-To: <20120423144623.GU26306@S2101-09.ap.freescale.net>
References: <1334823125-24159-1-git-send-email-shawn.guo@linaro.org>
 <20120421164713.GA3408@das-ThinkPad-X61>
 <20120422163255.GD26306@S2101-09.ap.freescale.net>
 <20120423074702.GD24843@shlinux2.ap.freescale.net>
 <20120423144623.GU26306@S2101-09.ap.freescale.net>
Message-ID: <4F95A71B.6090808@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/23/2012 08:46 AM, Shawn Guo wrote:
...
> Pin based SoC does not necessarily means the same pin configuration data
> needs to be repeated pointlessly.
> 
> Let's look at a vivid example.  The following is the pin group of 24bit
> display function with the binding I propose here.
> 
> 	lcdif_pins_a: lcdif-24bit at 0 {
> 		reg = <0>;
> 		fsl,pinmux-ids = <
> 			0x1000 0x1010 0x1020 0x1030
> 			0x1040 0x1050 0x1060 0x1070
> 			0x1080 0x1090 0x10a0 0x10b0
> 			0x10c0 0x10d0 0x10e0 0x10f0
> 			0x1100 0x1110 0x1120 0x1130
> 			0x1140 0x1150 0x1160 0x1170
> 			0x1181 0x1191 0x11a1 0x11b1>;
> 		fsl,drive-strength = <0>;
> 		fsl,voltage = <1>;
> 		fsl,pull-up = <0>;
> 	};
> 
> With the binding you suggest, we will turn above one into the following.
> 
> 	lcdif_pins_a: lcdif-24bit at 0 {
> 		reg = <0>;
> 		fsl,pinmux-ids = <0x1000 4
> 				  0x1010 4
> 				  0x1020 4
> 				  0x1030 4
> 				  0x1040 4
> 				  0x1050 4
> 				  0x1060 4
> 				  0x1070 4
> 				  0x1080 4
> 				  0x1090 4
> 				  0x10a0 4
> 				  0x10b0 4
> 				  0x10c0 4
> 				  0x10d0 4
> 				  0x10e0 4
> 				  0x10f0 4
> 				  0x1100 4
> 				  0x1110 4
> 				  0x1120 4
> 				  0x1130 4
> 				  0x1140 4
> 				  0x1150 4
> 				  0x1160 4
> 				  0x1170 4
> 				  0x1181 4
> 				  0x1191 4
> 				  0x11a1 4
> 				  0x11b1 4>;
> 	};
> 
> Supposing magic number <4> stands for the pin configuration of 4 mA
> drive-strength + 3.3V voltage + internal pull-up disabled, how users
> could understand this magic number?  And what's the point to repeat
> this magic number for 28 times?  I really do not have too much to say
> if you still think it makes more sense than the first one.

I can't really comment on what Dong was suggesting, but. The Tegra
bindings have a 2-level binding - a top-level node per state, and then
an arbitrary number of nodes that configuration something (mux, or
config, or both) for an arbitrary set of pins. That allows you to
represent any possible set of mux/config variations with no duplication
of those mux/config values, e.g.:

                state_i2cmux_ddc: pinmux_i2cmux_ddc {
                        ddc {
                                nvidia,pins = "ddc";
                                nvidia,function = "i2c2";
                        };
                        pta {
                                nvidia,pins = "pta";
                                nvidia,function = "rsvd4";
                        };
                        conf {
                                nvidia,pins = "ddc", "pta";
                                nvidia,pull = <1>;
                        };
                };

This is very flexible and about as minimal as you can get from a
repetitiveness point-of-view.

However, I guess it doesn't play too well into your desire to create the
group and function definitions from device tree. That's part of the
reason I don't like doing that; the SW desire to do that imposes
artificial restrictions on the rest of the binding.

> I think I have a understanding on "function" defined by pinctrl
> subsystem.  To me, mmc0-4bit and mmc0-8bit are two functions.
> Linus, help clarify a little bit?

I suppose there may be disagreement on this, but to me, a function is a
specific mux option (the HW register value typically) that can be
selected for a particular pin. Typically, these mux options would
correspond directly to the HW module whose signals were being muxed onto
that pin.

So for example, Tegra might have the following mux options for some pin:

SDHCI 1     # controller 1
SDHCI 2     # controller 2

but would not have these:

SDHCI 1 4 bit    # controller 1
SDHCI 1 8 bit    # controller 1
SDHCI 2 4 bit    # controller 2
SDHCI 2 8 bit    # controller 2

the difference between 4 bit and 8 bit would be purely driven by which
pins/groups the two controllers were mux'd onto. (Unless the pin
controller HW needed explicit notification of the difference for some
reason - certainly not the case for Tegra)

Of course, this is all without virtual functions. If you're doing
virtual functions, the second set of functions I listed above, with 4
entries, might well be what you'd end up with. But I dislike that since
you're not representing the pure HW capabilities as functions, but
rather some higher level grouped concept.
