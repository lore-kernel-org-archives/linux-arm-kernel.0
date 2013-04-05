From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 5 Apr 2013 11:07:25 -0600
Subject: mvebu-mbus: defining a DT binding
In-Reply-To: <201304051636.56410.arnd@arndb.de>
References: <20130405150200.7b6dee63@skate> <201304051517.26838.arnd@arndb.de>
 <20130405155149.0b00a592@skate> <201304051636.56410.arnd@arndb.de>
Message-ID: <20130405170725.GB3598@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 05, 2013 at 04:36:56PM +0200, Arnd Bergmann wrote:

> > > Another option would be to not map them by default but let the
> > > mbus driver do as many mappings as possible at boot time based
> > > on the devices that are actually present as children of the mbus
> > > device and not marked as status="disabled".
> > 
> > So the 'ranges' property would be more or less empty? How would the
> > mbus driver know the target/attribute values for each window?
> 
> I think ideally the ranges property would be completely empty
> (absent actually, but that is a detail) at boot, and the mbus driver
> would fill the ranges property as needed. I can see two ways to
> do that:

At a minimum it needs to have the special internal regs target. The
mbus driver cannot relocate that memory, and must be told where the
bootloader left it.

Beyond that, things get muddled, IMHO. DT is being asked to do two
slightly conflicting things - represent the address map from the
bootloader and also provide enough information for Linux to
dynamically reconfigure it.

> a) The mbus driver does a for_each_child_of_node() loop to iterate
> through its children and allocates a new physical address for each
> "reg" property it finds on all devices that are not status="disabled".
> Since the windows are all power-of-two pages in size, a simple
> "first-fit" algorith should be just fine here. The definition of 
> the mbus address space guarantees that the "reg" property has
> all the information needed to do that mapping.

Certainly doable.. ranges would have to be parsed as well, and it is a
bit complex, but very doable.
 
> b) We explicitly make all devices under mbus aware of the fact that
> they they are on mbus, and export a function that they have to call
> to map the window, like

IMHO, this is the nuclear option - it should be avoided. Existing
general drivers like serial and MTD should not need special wrappers
to work..

> > > Do you know which children of the mbus node (if any) we actually
> > > need to access before initializing mbus?
> > 
> > I'm sorry but I don't understand this question. There's nothing to do
> > to 'initialize mbus'. We can add/remove address decoding windows
> > whenever we want.
> 
> Well, we have to set up the windows at one point during the boot process,
> and we cannot access anything behind the windows until they are set up.
> 
> So if for instance the UART we use for DEBUG_LL is behind an MBUS window,
> we cannot easily change its address. My question is which devices fall
> into this category, if any.

Agree, the mbus driver should parse the DTB and construct all the
'static' windows, update the ranges, then populate the children. As is
usual in Linux the bus driver should ensure everything is setup for
the child nodes before their probe function is called.

PEX is a special case, since it has 'dynamic' windows.

> Does the internal registers window contain the MMIO space of the mbus
> device as well?

Yes, the registers the MBUS driver accesses are part of the internal
regs target.

> Do you expect that we always need just one window to map all the internal
> registers, or would there be a reason to split it up into multiple windows
> to reduce the amount of physical address space consumed?

Internal regs is special. There is a single dedicated aperture
register for it. There can be only be one mapping.

> I don't get it yet. I would assume that each PCIe port maps exactly to
> one address window, which solves the problem you describe above very
> nicely. We can do away with the fake "one range for memory" concept
> and just let the mbus driver pick any physical address when we enable
> or hot-plug one of the ports.

The Linux PCI core requires a single host bridge aperture, that is
what the ranges indicate. It is up to the PCI core to select the
address window(s) the PEX will use. When it does this it tells the PCI
driver, which tells the MBUS driver, which ultimately creates the
window. The address selection must be slaved to the PCI core, the MBUS
driver cannot operate autonomously.

This is an unavoidable consequence of merging all the PEX's into a
single root complex. If you recall this was required to support the 10
PEX case. Cross port address assignment is necessary to avoid address
space exhaustion.

> The ranges properties are required so a device driver can call of_iomap().
> Without it, there is no way to convert an address in mbus space into a
> CPU phys_addr_t.

Right. When the mbus driver populates the children nodes, the standard
OF code should be immediately able to get the correct physical address
through all normal OF means.

So, for every target the mbus driver either forces the mbus registers
to match the DT or dynamically assigns a physical address and updates
the DT to reflect that.

Jason
