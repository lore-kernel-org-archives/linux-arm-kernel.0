From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 20 Sep 2011 12:51:19 +0100
Subject: DT vs ARM static mappings
Message-ID: <1316519479.4611.150.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

Apologies for the length of the text below, but the problem is
complex... (or at least it seems to be)

While working on DT support for ARM Versatile Express I faced an
interesting problem... Some background first, to set a common ground and
test my understanding of the problem ;-)

ARM machine description contains a "map_io" method, which is used to
create static memory mappings (using iotable_init() function) for things
like peripherals or SRAMs. At least that's the theory, because most of
the platforms are doing much more stuff there, like clocking/GPIOs/UARTs
initialization, hardware probing etc.

Now the Versatile Express platform: it consists of a motherboard with a
set of peripherals and a processor daughterboard (core tile), both
connected via a static memory bus, which is mapped into processor's
physical address space. The motherboard can be shared between different
types of the tiles (eg. A9, A5, A15 etc.). The present one is probed byt
he motherboard firmware and exposed in "system registers".

Everything is fine so far. The interesting part starts here:

http://infocenter.arm.com/help/topic/com.arm.doc.dui0447e/CACIHGFE.html

In brief, depending on the configuration, the system can have one of
two, totally different, memory maps (please, do spare me the "but why
did they do that" comments - not my idea nor decision, I just have to
live with this ;-), depending on the core tile being used.

In result, the static mapping as defined currently in
arch/arm/mach-vexpress/v2m.c for A9 variant:

#define V2M_PA_CS7      0x10000000

static struct map_desc v2m_io_desc[] __initdata = {
        {
                .virtual        = __MMIO_P2V(V2M_PA_CS7),
                .pfn            = __phys_to_pfn(V2M_PA_CS7),
                .length         = SZ_128K,
                .type           = MT_DEVICE,
        },
};

is no longer valid for A5/A15. It would rather look like this:

#define V2M_PA_CS3      0x1c000000

static struct map_desc v2m_io_desc[] __initdata = {
        {
                .virtual        = __MMIO_P2V(V2M_PA_CS3),
                .pfn            = __phys_to_pfn(V2M_PA_CS3),
                .length         = SZ_2M,
                .type           = MT_DEVICE,
        },
};

Not only the peripherals base address is changed but also "internal"
alignment, thus offsets to peripherals. Some of them are not being
ioremap()ed, but directly used via the static mapping and MMIO_P2V macro
(like "readl(MMIO_P2V(V2M_SYS_PROCID0))" in v2m_populate_ct_desc(void)
function). For example, these two:

#define V2M_SYSREGS             (V2M_PA_CS7 + 0x00000000)
#define V2M_SYSCTL              (V2M_PA_CS7 + 0x00001000)

would have to become:

#define V2M_SYSREGS             (V2M_PA_CS3 + 0x00010000)
#define V2M_SYSCTL              (V2M_PA_CS3 + 0x00020000)

My current DTS for the original memory map looks like that (fragments):

{
        motherboard {
                ranges = <7 0 0x10000000 0x00020000>;
                #address-cells = <2>; // SMB chipselect number and offset
                #size-cells = <1>;
	
                peripherals at 7 {
			ranges = <0 7 0 0x20000>;
                        #address-cells = <1>;
                        #size-cells = <1>;

                        sysreg at 00000 {
                                reg = <0x00000 0x1000>;
                        };      
                        
                        sysctl at 01000 {
                                reg = <0x01000 0x1000>;
                        };
		}
	}		
}
		
DTS for the second memory map would just have the addresses changed.
Unfortunately, because of the static mappings being hardcoded in the
board support file, one kernel won't Just Work (TM) with different DTBs.

Of course the simplest solution would be to define two different
compatible values, eg. "arm,vexpress-legacy" would execute the current
map_io implementation, while "arm,vexpress-rs1" would use different one,
setting up the other map_desc (the MMIO_P2V macro must die of course,
replaced with a runtime-defined virtual base address for the
peripherals).

If you believe that's what I should do, say it and stop reading :-)

To my mind it looked like the whole mechanism was not flexible enough,
so I wanted to explore other options...

The obvious one was to describe the required static mapping in the DTS.
I don't like this idea, though. It can hardly be called "hardware
description". Besides, what node would carry such data? "chosen"?
Hardly...

Would it contain a "regs" property with the physical address and
"virtual-reg" with the virtual one? Again, doesn't sound right to me
(especially the virtual bit, however the virtual address could be common
between different variants and be defined in the board support code, not
the DTS).

I have considered a reference (phandle or an alias?) to the node to be
mapped ("peripherals" in my case), but where to define this reference?
Any ideas?

There is an additional problem here... The "map_io" is executed before
the tree is un-flattened, so:

1. One can't simply use "of_find_matching_node()" (as in the latest l2x0
patches) to find the interesting nodes - the only way of going through
the tree is raw of_scan_flat_dt() function. Therefore any conditions
more complex then string comparison with the (full) node name are
problematic.

2. The tree mappings (ranges) are not resolved yet, so one can't simply
get the effective address of a node. Only "raw" properties are
available, so all one can get scanning for "peripherals at 7" node is "0 7
0 0x20000" array, instead of the "0x10000000 0x00020000" that is really
important.

Initially I wanted to find the mentioned devices and create individual
mappings for them, so the MMIO_P2V would be still valid (if slightly
"abused"), but I failed due to the problems mentioned above. And I can't
delay this operation till the tree is un-flattened, as the core tile
must be probed (via sysreg) in map_io (tile's specific code must be able
to create its own mappings):

static void __init v2m_map_io(void)
{       
        iotable_init(v2m_io_desc, ARRAY_SIZE(v2m_io_desc)); 
        v2m_populate_ct_desc();
        ct_desc->map_io();
}

Any comments, ideas and suggestions how to tackle this situation are
more than welcome.

Cheers!

Pawe?
