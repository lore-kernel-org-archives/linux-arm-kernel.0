From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 Mar 2013 11:52:07 +0000
Subject: Integrator PCI base dilemma
In-Reply-To: <20130322103740.GW4977@n2100.arm.linux.org.uk>
References: <CACRpkdaOjFhWR21w5x_rR_60ffQF3Ym_MQd2svNyzm0guwOUoQ@mail.gmail.com>
 <201303220948.28092.arnd@arndb.de>
 <20130322103740.GW4977@n2100.arm.linux.org.uk>
Message-ID: <201303221152.07569.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 22 March 2013, Russell King - ARM Linux wrote:
> On Fri, Mar 22, 2013 at 09:48:27AM +0000, Arnd Bergmann wrote:
> > > That's because it's pretty much built into the way VGA crud works.
> > > VGA BIOSes hard code these addresses into themselves.  Really, so does
> > > the kernel, but non-native architectures are given the chance to offset
> > > this appropriately - and remember that non-native architectures will
> > > run the VGA BIOS via an x86 emulator, which you pretty much have to do
> > > to get VGA cards to initialize properly.
> > 
> > Unfortunately, the offsetting also means that you have a non-zero mem_offset
> > value for the pci host controller, which breaks code that reads the PCI BARs
> > and uses those as physical addresses.
> 
> No, you're confusing two things.
> 
> Firstly, nothing in todays kernel should read PCI BARs and treat them as
> physical addresses.  Userspace is a different matter, but that is entirely
> unrelated to VGA_MAP_MEM().

I understand the part about "should", and I would hope that there is little
code left in the kernel still doing that, but I occasionally see some of
that in old or staging drivers. Try "git grep PCI_BASE_ADDRESS" in the kernel
tree.

> The non-zero mem_offset occurs if your physical address space is different
> from the PCI address space.  Footbridge has this.  PCI memory address 0
> is physical address 0x80000000, because all the SDRAM and DC21285
> peripherals, PCI IO space etc all appear below 0x80000000.  This alone
> mandates mem_offset to be 0x80000000.
> 
> You _could_ tweak a bit which will set PCI bit 31 in the address for that
> window.  That gets you a 1:1 mapping.  But then the VGA addresses are
> inaccessible - and as a side effect of that, XF86 will hit something else
> rather than the PCI bus.
> 
> Now, we don't have to map this, but if we want VGA cards to work with
> vgacon, then there is no option but to do so.  So, the first 16MB of
> PCI space is statically mapped.

Yes, that was exactly my point.

> VGA_MAP_MEM() is then defined to be the _virtual_ address of this mapping.
> 
> If PCI and physical addresses weren't translated in this way, then mem_offset
> would be zero, and VGA_MAP_MEM() would still need to have the virtual
> address of the mapping.
> 
> So, the two things are _entirely_ separate.

My point was that you cannot have a virtual address for the window if
low PCI bus addresses are not even visible in the physical address
space. You could theoretically have some of the low 16MB of physical
address space map to the PCI bus as done on x86, but I'm not aware
of any ARM platforms doing that. This leaves you the choice between
two reasonable values for mem_offset:

a) the start of the physical address space window, mapping pci
   bus address 0. This allows you to provide a meaningful VGA_MAP_MEM
   because the low bus addresses can be mapped into the virtual
   address space, but breaks any code that makes incorrect assumptions
   about mem_offset=0.

b) set mem_offset=0 and have an identity mapped PCI bus window, which
   is what people generally expect after reading the PCI specifications,
   but which breaks the VGA console.

> > I believe XFree86 traditionally did
> > this. I normally recommend to do PCI host bridge drivers with mem_offset=0,
> 
> I wonder how many systems you've broken by telling people to do that,
> because frankly you're wrong.  See the above example on Footbridge
> why you're completely wrong on this point.

It's not completely wrong, it's picking one of two evils. VGA console
is the only thing that needs the low PCI address mapping, and if you
have any more recent GPU, you can use fbcon with a hardware specific
driver that uses the normal PCI BARs.

Also, in many cases, you don't even have the choice in the kernel between
the two options, either PCI is identity mapped or mapped starting at
address zero based on whatever the soc or board designer thought, and the
only thing we can do is tell the kernel what the hardware does.

It looks like cns3xxx, tegra, versatile and ks8695 are all hardwired to a
zero mem_offset, while dc21285, integrator, it8152 and sa1100/pci-nanoengine
map the PCI bus starting at bus address 0.

plat-orion and plat-iop are both configurable and have always been
configured to use mem_offset=0 as far as I can tell. I assume ixp4xx
also falls into this category.

> And XF86 may have traditionally done this, but it will be broken on
> platforms like Footbridge as long as it does this behaviour, irrespective
> of the setting of mem_offset.  Also, having XF86 mess around with the
> PCI configuration in ways that the kernel is not aware of has long been
> viewed as a bug.
> 
> Finally, the kernel has interfaces for mapping PCI BARs, and this is the
> way XF86 should now deal with VGA cards, not by mapping /dev/mem.  The
> old /dev/mem interface is being deprecated for that kind of use.

I'm pretty sure that Xorg gets it right these days, I was just using it
as an example of code in wide use that would not work on footbridge.

	Arnd
