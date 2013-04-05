From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 5 Apr 2013 10:27:37 -0600
Subject: mvebu-mbus: defining a DT binding
In-Reply-To: <20130405150200.7b6dee63@skate>
References: <20130405150200.7b6dee63@skate>
Message-ID: <20130405162737.GA3598@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 05, 2013 at 03:02:00PM +0200, Thomas Petazzoni wrote:

>  * The address decoding windows are in fact defined by the ranges =
>    <...> property of the mbus node. Here, in the example provided by
>    Jason, this ranges = <...> property is part of the SoC-level .dtsi.
>    However, some boards will have to add some board-specific windows
>    (adjusted to the size of their NOR, or FPGA, for example).

Right. The things Linux does to try and re-use parts of the DT are
nice, but I don't think they should strongly guide the design of the
binding.. Someone recently said that the DT is designed to be machine
parseable not human readable..

In any event, the 'default' mbus window locations in the static DTB
should match the configuration the bootloader sets when it boots
Linux. Ideally some basic level of functionality should be possible
without the dynamic mbus driver..

So to me, this is already a guide that this might have to be board
specific anyhow.

>  * I am not sure to understand why the nand, crypto and pcie-controller
>    nodes are outside of the internal registers. Well, I understand it's
>    because those devices need a special address decoding window. But it
>    sounds strange because those devices also have internal registers
>    (which is why Jason used 'MAPDEF_INTERNAL + offset' in the reg
>    property).

This is a arbitary choice, of course. Arnd: The issue is how do you
refer to two MBUS windows in a single device node.

>From a design perspective, the chip has an internal regs blocks. I
modeled that block directly with a bus node (internal_regs at f1000000).
It has a single ranges, that is 0 based. This makes the 'regs' of the
children exactly match the datasheet.  Everything that couldn't fit in
there I treated as an exception, and placed directly under mbus
instead.

The main alternative made less sense to me:

mbus {
  ranges = <MAPDEF_INTERNAL 0xf1000000 0x100000
 [..]

  everything@?? {
       ranges = <0x00000000 MAPDEF_INTERNAL 0x100000
                 0x10000000 MAPDEF_CRYPTO 0x800>
  }
}

The 'everything' node is very muddled to me.

>  * Regarding the PCIe binding, Jason Gunthorpe suggests the use of a
>    'marvell,mbus-targets' attribute so that the PCIe driver knows what
>    target/attribute values to use to create the window. Currently, the
>    PCIe driver uses a name (like "pcie0.3") that it gives to the
>    mvebu-mbus driver, which then translates this name to the real
>    target/attribute values using per-SoC tables that associate names
>    (pcie0.3) with values (say 0x4 / 0x42).

Right, my intention with this was to eliminate the tables from the
mbus driver and move them into the DT. It made no sense to use the
MAPDEF stuff for the ranges, but then require driver hard-wiring for
PEX.

FWIW, I belive this should all be done on top of the nice stuff from
Steven Warren that enables the preprocessor for dts. That is why I
wrote the sample in preprocessor language.

Regards,
Jason
