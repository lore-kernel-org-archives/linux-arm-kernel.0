From: neko@bakuhatsu.net (Matt Sealey)
Date: Fri, 27 Sep 2013 13:33:35 -0500
Subject: device tree binding documentation outdated
In-Reply-To: <20130927174916.GD12758@n2100.arm.linux.org.uk>
References: <20130926195158.GS12758@n2100.arm.linux.org.uk>
 <CAOMZO5ANsZGcpvmtBE7d0q0E6+f0bE_U8CBF7G2v3xtqoLbqcA@mail.gmail.com>
 <20130926205906.GT12758@n2100.arm.linux.org.uk>
 <CAOMZO5Dj7o3qBH2hzPFWjepgpt5XR5qKmQorKS6jH_7=gnY5cg@mail.gmail.com>
 <20130927121357.GY12758@n2100.arm.linux.org.uk>
 <20130927132601.GL25146@S2101-09.ap.freescale.net>
 <20130927151900.GA12758@n2100.arm.linux.org.uk>
 <CAHCPf3t8=mJn-RCz3C1cY6zqsH9ds8UANKpKx9ZpwPM6WjJt3g@mail.gmail.com>
 <20130927174916.GD12758@n2100.arm.linux.org.uk>
Message-ID: <CAHCPf3sC7bY=p4vpBQFpRUmyPspT_PVjx0rH9cm1ov=SqkO+Vg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 27, 2013 at 12:49 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Sep 27, 2013 at 11:52:52AM -0500, Matt Sealey wrote:
>> Russell,
>>
>> There is a chicken bit in the IOMUXC GPR1 (IOMUXC+0x4 bit 21, it's on
>> page 1927 of the i.MX6DQRM Rev 1 04/2013) which turns on or off the
>> ENET_REF_CLK loopback. You could need to clear it to make the pad an
>> input to the i.MX6 rather than an output to the PHY.. while it may
>> seem like this removes the need for the SION bit in the pin you want,
>> that's actually also required otherwise the pad mux latch 'sees' the
>> data but the input latch behind it doesn't.
>>
>> There is a great diagram somewhere in the manual (Figure 28-1, right
>> at the top of the GPIO docs) - SION *forces* data (it's the input_on
>> signal in the diagram IIRC) to the gpio data register behind the
>> IOMUX, but the logic behind every muxed pad is almost the same across
>> the SoC.
>
> The manual which Fabio pointed me at (iMX 6Solo/6DualLite - IMX6SDLRM.pdf)
> doesn't correspond - figure 28-1 is something entirely different.

I use the Quad/Dual (not Lite) manual for reference, most of it is
identical.. I keep forgetting there is another one, sorry.

It's at the top of the GPIO section, though (figure 29-1 in your manual).

> Okay, but from what I'm working from (which works) the order is:
>
> - Set IOMUXC GPR1 bit 21.

Just to clarify: set or clear? It should be clear if the PHY provides
the clock to the MAC, and set if the MAC provides the clock to the
PHY. There can be only one, Highlander!

> - Set ipg/ahb ethernet clock to 50MHz

Hmm.. this might be a touch low, but it's not the issue here. The way
I recall this working, the IP has a clock (IPG, AHB as above) and
there is a MAC clock too which you're generating from DIV_SELECT in
the ENET_PLL. They don't have to be the same..

> - IOMUX settings applied, including setting the reference clock SION bit

Which definitely implies the clock is input to the MAC...

> - Reset lowered, wait 2ms, reset raised
> - imx6_init_fec(fec_data_rgmii) called
>
> After that is the time that the phy is configured to supply the 125MHz
> reference clock into the IMX6.
>
> That order seems to be happening with my 3.12-rc1 kernel, although a
> little more spread out.

If the GPR1 bit isn't set right what you're getting is different
clocks when they should be sharing the same one... extra edges from
the internal ref clock (from ENET_PLL by default) might add a couple
extra bytes here and there if the PHY sends on edges it's clock and
the MAC receives on edges on the internal clock.

In 3.12-ish I see mach-imx/mach-imx6q.c:imx6q_1588_init() is setting
the bit, which means the reference clock is coming from
ENET_PLL[DIV_SELECT] and not the pad.

If you set it to 1, it sets pad loopback which means you'd output a
125MHz clock towards a pad you marked as input to the i.MX6 - the
IOMUX block will twiddle some internal flops from clock -> output
block but since it's not hooked to the pad, nothing will come of it.
But the MAC will use it to latch data over MDIO.

None of the boards in the tree right now seem to use an external PHY
clock at all, which is why they all work; they provide the PHY clock
from the i.MX6Q to an RGMII PHY (this is the lowest power way to do
it!).

This is wrong for you... but I have seen a couple that do it this way.
There was some terrible confusion with older MX6 tapeouts where this
bit wasn't documented and using RMII was a complete afterthought...
the manual reflects it now but I am fairly sure there is a quirk that
needs addressing.

In theory the i.MX6SL EVK has RMII but I am also fairly sure the
SoloLite doesn't have the option to use anything but RMII and either
fortuitous software or chicken-bit-does-nothing-here design is helping
it out.

I'm gonna go look at the manual some more.. for reference, this is
also a great design guide - IMX6QD6SDLHDG.pdf (it's on the same site
as you got the RM). Chapter 12 is comprehensive in it's discussion of
i.MX6QD[L] and RMII ethernet evil.

Does anyone at Freescale want to donate a SabreSD for Dual or Quad
(not-lite) and an i.MX6SL EVK this way? I may be able to scrounge up a
couple CuBox-i units but I think supporting the reference designs is
worth doing. Also I kind of want/need JTAG access and I am sure
SolidRun didn't even go so far as putting pads on the PCB...

-- 
Matt <neko@bakuhatsu.net>
