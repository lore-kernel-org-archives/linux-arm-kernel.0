From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 20 Sep 2011 15:02:45 +0100
Subject: DT vs ARM static mappings
In-Reply-To: <4E788E12.8000801@gmail.com>
References: <1316519479.4611.150.camel@hornet.cambridge.arm.com>
	<4E788E12.8000801@gmail.com>
Message-ID: <1316527365.4611.354.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Of course the simplest solution would be to define two different
> > compatible values, eg. "arm,vexpress-legacy" would execute the current
> > map_io implementation, while "arm,vexpress-rs1" would use different one,
> > setting up the other map_desc (the MMIO_P2V macro must die of course,
> > replaced with a runtime-defined virtual base address for the
> > peripherals).
> > 
> > If you believe that's what I should do, say it and stop reading :-)
>
> Yes. Different tiles are fundamentally different boards, so they should
> have different DTs. Using includes should help minimize duplication though.

You've misunderstood me or (most likely ;-) probably I wasn't clear
enough.

There is no doubt the DTs will be different across the "portfolio".

We already have (patches soon) vexpress-v2p-ca9.dts that includes
vexpress-v2m-legacy.dtsi.

A5 will be vexpress-v2p-ca5p.dts+vexpress-v2m-rs1.dtsi, A15
vexpress-v2p-ca15.dts+vexpress-v2m-rs1.dtsi (notice that the A5/A15 are
sharing the v2m bit, as the motherboard is common).

My point is that we should be able to handle _all_ of them using one
DT_MACHINE_START with a single compat value "arm,vexpress". The only
problem with this (so far) is the mapping.

> Think about it this way. How would you solve this without DT? You
> would have a bunch of duplicated data in the kernel for the different
> configs. So you're not any worse off in this regard and still have the
> other advantages of DT.

Exactly my point :-) I want to have as little duplication as possible.
And the static mapping issue is in the way.

> > To my mind it looked like the whole mechanism was not flexible enough,
> > so I wanted to explore other options...
> > 
> > The obvious one was to describe the required static mapping in the DTS.
> > I don't like this idea, though. It can hardly be called "hardware
> > description". Besides, what node would carry such data? "chosen"?
> > Hardly...
> > 
> > Would it contain a "regs" property with the physical address and
> > "virtual-reg" with the virtual one? Again, doesn't sound right to me
> > (especially the virtual bit, however the virtual address could be common
> > between different variants and be defined in the board support code, not
> > the DTS).
> > 
> > I have considered a reference (phandle or an alias?) to the node to be
> > mapped ("peripherals" in my case), but where to define this reference?
> > Any ideas?
> 
> In "chosen" like the kernel command line would be the place, but I don't
> think that is the right approach. Chosen is really for things that
> change frequently and this doesn't really fall in that category.

Again, no argument from me here :-)

The question is - where should it be?

> > There is an additional problem here... The "map_io" is executed before
> > the tree is un-flattened, so:
> > 
> > 1. One can't simply use "of_find_matching_node()" (as in the latest l2x0
> > patches) to find the interesting nodes - the only way of going through
> > the tree is raw of_scan_flat_dt() function. Therefore any conditions
> > more complex then string comparison with the (full) node name are
> > problematic.
> > 
> > 2. The tree mappings (ranges) are not resolved yet, so one can't simply
> > get the effective address of a node. Only "raw" properties are
> > available, so all one can get scanning for "peripherals at 7" node is "0 7
> > 0 0x20000" array, instead of the "0x10000000 0x00020000" that is really
> > important. 
> 
> If you add a compatible field to "motherboard" node, then you can read
> the ranges.

... and then and then scan for the sysregs, and add the offset and base
together... Sounds to me like duplication of the of_translate_*()?

> > Initially I wanted to find the mentioned devices and create individual
> > mappings for them, so the MMIO_P2V would be still valid (if slightly
> > "abused"), but I failed due to the problems mentioned above. And I can't
> > delay this operation till the tree is un-flattened, as the core tile
> > must be probed (via sysreg) in map_io (tile's specific code must be able
> > to create its own mappings):
> 
> Do you really need MMIO_P2V? If you have fixed virtual addresses in the
> kernel and can pull the phys addresses from DT to populate the iotable,
> is that sufficient?

For the third time, 100% agree :-) Well, 90%.

What I need is:

1. Get the phys address from DT. But how? This is getting as back to my
complaints about still-flat tree and ranges, the node to be used to
describe the mapping.

2. The offset inside the mapping will be different (for sysregs it will
be 0 for old mapping, 0x10000 for the new one), so I have to work it out
from the tree as well. And as we are in map_io, the tree is still flat
and... read 1 :-)

> Generally, the trend is to get rid of static mappings as much as
> possible. Doing that first might simplify things.

You can't do ioremap() before kmalloc() is up and running (correct me if
I am wrong), at least you can't do this in map_io. So the static mapping
is a must sometimes. And actually, with the latest Nico's changes:

http://thread.gmane.org/gmane.linux.ports.arm.kernel/132762

it may even be preferred for peripherals (one mapping shared across all
users).

Cheers!

Pawe?
