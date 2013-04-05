From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 5 Apr 2013 23:01:27 +0200
Subject: mvebu-mbus: defining a DT binding
In-Reply-To: <20130405203652.GA10505@obsidianresearch.com>
References: <20130405150200.7b6dee63@skate> <201304052149.33533.arnd@arndb.de>
 <20130405203652.GA10505@obsidianresearch.com>
Message-ID: <201304052301.27231.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 April 2013, Jason Gunthorpe wrote:
> On Fri, Apr 05, 2013 at 09:49:33PM +0200, Arnd Bergmann wrote:

> Notes
>  - The PEX link cannot be encoded in the highest DWORD due to the OF
>    PCI rules, lets just use the lower 2 dws instead. MAPDEP_X is a 2
>    dword value.

Ok, I wondered about whether it's allowed but then concluded that it
was ok for the root bridge but not for P2P bridges. Your solution
nicely sidesteps the problem.

>  - The bridge ranges would be offset 0 length 4G-1 in the DT since
>    the value is not known. However firmware could do PCI address
>    assignment and fill in corrected values.

I don't undestand this part. It would make the topmost byte in the
4GB bus space unadressable, which seems strange. Why can't we use
the entire 4GB? Maybe we should leave at least a page?

>  - Although unnecessary for Linux, the PCI driver could fill in the bridge
>    ranges to reflect the actual bridge setup.

Correct. The IEEE PCI binding talks about this, and it seems reasonable
for actual OF implementations, but I think we can be a little sloppy
here.

>  - The top level mbus ranges can reflect the address translation:
> 
>    MAPDEF_PEX0 + 0xC0000000   0xC0000000 0x10000 // Identity map MMIO
>    MAPDEF_PEX0_IO             0xD0000000 0x10000 // Translate 0xD0000000 to IO 0

Right.

>  - A full featured firmware could fill in the various ranges to
>    represent a working PCI bus configuration

Yes, although Linux normally doesn't expect the firmware to do that. On
PowerPC, we support both ways, either trusting the firmware to completely
probe the PCI bus and fill all the properties, or doing everything
ourselves. Given that Linux already has to do it for PCIe hotplug,
there is little value in the former unless you run under a hypervisor
that does not let you reconfigure the PCI resources (e.g. some
versions of IBM pSeries).

> So the PCI driver would now have to dynamically determine on its own a
> host bridge aperture based on available space in the resource tree,
> this is done instead of parsing ranges. I guess we could have a
> 'linux,host-aperture' or something as a stop gap.

The PCI driver already has to communicate with the MBUS driver, so
it can just ask MBUS to return the largest unassigned continugous 
physical address range.

> The driver should create each root bridge by pulling
>  - reg = the device.fn of the config space
>  - assigned-addresess = the PEX internal register block
>  - ranges = The target ID's for the PEX
> 
> So there is no longer a need to assume in the DT binding that a
> particular device.fn refers to a particular PEX.
> 
> If this is the way to go, I hope it can be a revision on top of the
> existing PCI patch set?

Sounds good to me.

> Did I miss anything Arnd?

The only part I'm unsure about is the question above about the missing
byte in the 4GB address space.

	Arnd
