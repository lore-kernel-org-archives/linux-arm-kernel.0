From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 25 Mar 2013 14:29:35 +0100
Subject: [RFC PATCH] CLK: Allow parent clock and rate to be configured in
 DT.
In-Reply-To: <51503007.5020403@parkeon.com>
References: <20130319170933.28337.50448.stgit@localhost>
 <20130325101707.GZ1906@pengutronix.de>
 <51503007.5020403@parkeon.com>
Message-ID: <20130325132935.GE1906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 25, 2013 at 12:07:51PM +0100, Martin Fuzzey wrote:
> Hi Sascha,
> 
> thanks for the comments.
> 
> [corrected Mike's email address - I originally sent it to the old one]
> 
> On 25/03/13 11:17, Sascha Hauer wrote:
> >On Tue, Mar 19, 2013 at 06:09:33PM +0100, Martin Fuzzey wrote:
> >>Even on platforms where the entire clock tree is not represented in the DT
> >>it can still be useful to allow parents and rates to be set from the DT.
> >>
> >>An example of such a case is when a multiplexable clock output from a SOC
> >>is used to supply external chips (eg an audio codec connected to the i.MX53
> >>cko1 pin).
> >>
> >>The cko1 pin can output various internal clock signals but, in
> >>order to obtain a suitable frequency for the codec, an appropriate parent must
> >>be selected.
> >>
> >>Another example is setting root clock dividers.
> >>
> >>This is board specific rather than device driver or platform clock framework
> >>specific information and thus would be better in the DT.
> >I see what the patch does and that it could be very useful, but there's
> >a problem: The devicetree is for hardware *description*, not
> >*configuration*.
> >
> >>+For example:
> >>+	clock-configuration {
> >>+		compatible = "clock-configuration";
> >>+		clko1 {
> >>+			clocks = <&clks 160>; /* cko1_sel */
> >>+			parent = <&clks 114>; /* pll3_sw */
> >>+		};
> >>+
> >>+		esdhca {
> >>+			clocks = <&clks 102>; /* esdhc_a_podf */
> >>+			clock-frequency = <200000000>;
> >>+		};
> >This example shows this. For some reason we adjust the esdhc frequency
> >to 200MHz in the code currently, but this is because it matches our
> >current usecase. Once you move this into devicetree, we can't change
> >this anymore in the kernel, even if we find a much better way to adjust
> >the frequency in the future (i.e. smaller values might be good for power
> >savings, higher values might increase performance, we even might
> >dynamically change this frequency).
> >
> Yes but the problem is that the rates are currently set in
> clk-imx51-53.c which should be generic
> to all such platforms whereas, as you point out, there may well be
> valid reasons to choose
> different values depending on the board design and / or intended
> application.

Put it differently. OpenBSD might have much better clock support.
Imagine it can dynamically figure out the correct esdhc frequencies
for different usecases on the fly. In this situation it would be
counterproductive if Linux requires static values for these in the
devicetree.

> 
> The cko case is even worse - due to a board design decision that
> clock needs to have
> a frequency suitable for supplying some external chip. We don't want
> board specific code in
> the platform clock code and we're trying to get away from board files...

The codec could be provided a phandle to the cko clk. This is hardware
description and is fine for putting into the devicetree.

> 
> >So no, this shouldn't be in the devicetree, even though it's very
> >tempting to do so.
> >
> >I wonder when someone comes up with a 'configtree' where we could put in
> >such stuff.
> I don't understand why we need a seperate tree for this why can't just
> a subtree of the DT be used?
> 
> After all the DT already contains "configuration" nodes such as "chosen".
> 
> Indeed Documentation/devicetree/usage-model.txt  says:
>     "The chosen node may also optionally contain an arbitrary number of
>     additional properties for platform-specific configuration data."
> 
> So what stops us simply placing the clock-configuration node above
> under chosen? (which already works - just tested it)

What stops us doing so is that currently we have the policy that the
devicetree is hardware description only, even if there are already
counteraxamples in the devicetree.

I know that we currently have no place to put such information. There
recently was a similar discussion with CMA descriptions in the
devicetree and I remember several other discussions of the same type,
all of which ended at the dont-know-but-not-in-the-devicetree point.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
