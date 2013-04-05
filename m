From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 5 Apr 2013 19:28:13 +0200
Subject: mvebu-mbus: defining a DT binding
In-Reply-To: <20130405170725.GB3598@obsidianresearch.com>
References: <20130405150200.7b6dee63@skate> <201304051636.56410.arnd@arndb.de>
 <20130405170725.GB3598@obsidianresearch.com>
Message-ID: <201304051928.14119.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 April 2013, Jason Gunthorpe wrote:
> On Fri, Apr 05, 2013 at 04:36:56PM +0200, Arnd Bergmann wrote:
> > I think ideally the ranges property would be completely empty
> > (absent actually, but that is a detail) at boot, and the mbus driver
> > would fill the ranges property as needed. I can see two ways to
> > do that:
> 
> At a minimum it needs to have the special internal regs target. The
> mbus driver cannot relocate that memory, and must be told where the
> bootloader left it.

Ok, I see.

> Beyond that, things get muddled, IMHO. DT is being asked to do two
> slightly conflicting things - represent the address map from the
> bootloader and also provide enough information for Linux to
> dynamically reconfigure it.

Right.

> > a) The mbus driver does a for_each_child_of_node() loop to iterate
> > through its children and allocates a new physical address for each
> > "reg" property it finds on all devices that are not status="disabled".
> > Since the windows are all power-of-two pages in size, a simple
> > "first-fit" algorith should be just fine here. The definition of 
> > the mbus address space guarantees that the "reg" property has
> > all the information needed to do that mapping.
> 
> Certainly doable.. ranges would have to be parsed as well, and it is a
> bit complex, but very doable.

One small complication that I realized now is that the windows on the
PCIe bus must be contiguous and not have other windows in the middle
because of the way that PCI resource allocation works in Linux at
the moment.

This means the mbus driver would probably need to sort the windows
by size first and allocate space from one end for all non-PCIe devices
and then we can let the PCIe driver announce the remaining space as
available for other devices to the PCIe core.

> > b) We explicitly make all devices under mbus aware of the fact that
> > they they are on mbus, and export a function that they have to call
> > to map the window, like
> 
> IMHO, this is the nuclear option - it should be avoided. Existing
> general drivers like serial and MTD should not need special wrappers
> to work..

If the internal regs have to be a special case, most of the devices
just stay regular platform devices and keep working as before, we'd
just have to special-case the drivers that are not on the internal
register window.

> > Well, we have to set up the windows at one point during the boot process,
> > and we cannot access anything behind the windows until they are set up.
> > 
> > So if for instance the UART we use for DEBUG_LL is behind an MBUS window,
> > we cannot easily change its address. My question is which devices fall
> > into this category, if any.
> 
> Agree, the mbus driver should parse the DTB and construct all the
> 'static' windows, update the ranges, then populate the children. As is
> usual in Linux the bus driver should ensure everything is setup for
> the child nodes before their probe function is called.

We should be able to handle this very easily if we don't call the mbus
device itself compatible="simple-bus" because it is not. Instead we
the probe function of the mbus device can assign all the windows and
then add its children by calling of_platform_populate() on itself.

> > Does the internal registers window contain the MMIO space of the mbus
> > device as well?
> 
> Yes, the registers the MBUS driver accesses are part of the internal
> regs target.

ok.

> > Do you expect that we always need just one window to map all the internal
> > registers, or would there be a reason to split it up into multiple windows
> > to reduce the amount of physical address space consumed?
> 
> Internal regs is special. There is a single dedicated aperture
> register for it. There can be only be one mapping.

Ok, that simplifies the number of options we have, which is probably
a good thing.

> > I don't get it yet. I would assume that each PCIe port maps exactly to
> > one address window, which solves the problem you describe above very
> > nicely. We can do away with the fake "one range for memory" concept
> > and just let the mbus driver pick any physical address when we enable
> > or hot-plug one of the ports.
> 
> The Linux PCI core requires a single host bridge aperture, that is
> what the ranges indicate. It is up to the PCI core to select the
> address window(s) the PEX will use. When it does this it tells the PCI
> driver, which tells the MBUS driver, which ultimately creates the
> window. The address selection must be slaved to the PCI core, the MBUS
> driver cannot operate autonomously.
> 
> This is an unavoidable consequence of merging all the PEX's into a
> single root complex. If you recall this was required to support the 10
> PEX case. Cross port address assignment is necessary to avoid address
> space exhaustion.

Right, I remembered that already and wrote above that we need to leave
a single phys_addr_t range for all the PCIe ranges after assigning
everything else. However, I think the DT representation should still
reflect what the hardware looks like, meaning that the ranges property
of the root complex can have one static range for each port, translating
the 4GB address space of the port to the 4GB mbus window.

When the PCIe core actually gets around to enable the port and assign
a PCIe memory resource, we can use the information from the ranges
property and the PCIe memory aperture to set up the mbus window.

	Arnd
