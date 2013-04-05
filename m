From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 5 Apr 2013 18:58:05 +0200
Subject: mvebu-mbus: defining a DT binding
In-Reply-To: <20130405162737.GA3598@obsidianresearch.com>
References: <20130405150200.7b6dee63@skate>
 <20130405162737.GA3598@obsidianresearch.com>
Message-ID: <201304051858.05567.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 April 2013, Jason Gunthorpe wrote:
> On Fri, Apr 05, 2013 at 03:02:00PM +0200, Thomas Petazzoni wrote:
> 
> >  * The address decoding windows are in fact defined by the ranges =
> >    <...> property of the mbus node. Here, in the example provided by
> >    Jason, this ranges = <...> property is part of the SoC-level .dtsi.
> >    However, some boards will have to add some board-specific windows
> >    (adjusted to the size of their NOR, or FPGA, for example).
> 
> Right. The things Linux does to try and re-use parts of the DT are
> nice, but I don't think they should strongly guide the design of the
> binding.. Someone recently said that the DT is designed to be machine
> parseable not human readable..
> 
> In any event, the 'default' mbus window locations in the static DTB
> should match the configuration the bootloader sets when it boots
> Linux. Ideally some basic level of functionality should be possible
> without the dynamic mbus driver..
> 
> So to me, this is already a guide that this might have to be board
> specific anyhow.

I mentioned three options before, what you describe is one of
them:

a) make the ranges in the DT refer to what the hardware is set to,
as you explain above. This makes it easy to run an OS without an
mbus driver, but somewhat harder to reassign the windows at run-time

b) set the ranges to the windows we want to have in Linux. This is closer
to what we have at the moment, where we basically configure mbus from
a static configuration, and allow the windows that are to be dynamic
(e.g. PCIe) to be left out of this.

c) Try to keep the ranges property empty at boot time, except possibly
the internal register window, and find the optimum address map at
boot time based on which devices are enabled.

> >  * I am not sure to understand why the nand, crypto and pcie-controller
> >    nodes are outside of the internal registers. Well, I understand it's
> >    because those devices need a special address decoding window. But it
> >    sounds strange because those devices also have internal registers
> >    (which is why Jason used 'MAPDEF_INTERNAL + offset' in the reg
> >    property).
> 
> This is a arbitary choice, of course. Arnd: The issue is how do you
> refer to two MBUS windows in a single device node.
> 
> From a design perspective, the chip has an internal regs blocks. I
> modeled that block directly with a bus node (internal_regs at f1000000).
> It has a single ranges, that is 0 based. This makes the 'regs' of the
> children exactly match the datasheet.  Everything that couldn't fit in
> there I treated as an exception, and placed directly under mbus
> instead.

Makes sense.
> The main alternative made less sense to me:
> 
> mbus {
>   ranges = <MAPDEF_INTERNAL 0xf1000000 0x100000
>  [..]
> 
>   everything@?? {
>        ranges = <0x00000000 MAPDEF_INTERNAL 0x100000
>                  0x10000000 MAPDEF_CRYPTO 0x800>
>   }
> }
> 
> The 'everything' node is very muddled to me.

Yes, that would neither clarify it to the reader nor actually
reflect what the hardware does.

	Arnd
