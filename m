From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 22 Mar 2013 12:12:18 +0000
Subject: Integrator PCI base dilemma
In-Reply-To: <201303221152.07569.arnd@arndb.de>
References: <CACRpkdaOjFhWR21w5x_rR_60ffQF3Ym_MQd2svNyzm0guwOUoQ@mail.gmail.com>
 <201303220948.28092.arnd@arndb.de>
 <20130322103740.GW4977@n2100.arm.linux.org.uk>
 <201303221152.07569.arnd@arndb.de>
Message-ID: <20130322121218.GD4977@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 22, 2013 at 11:52:07AM +0000, Arnd Bergmann wrote:
> On Friday 22 March 2013, Russell King - ARM Linux wrote:
> > On Fri, Mar 22, 2013 at 09:48:27AM +0000, Arnd Bergmann wrote:
> > > > That's because it's pretty much built into the way VGA crud works.
> > > > VGA BIOSes hard code these addresses into themselves.  Really, so does
> > > > the kernel, but non-native architectures are given the chance to offset
> > > > this appropriately - and remember that non-native architectures will
> > > > run the VGA BIOS via an x86 emulator, which you pretty much have to do
> > > > to get VGA cards to initialize properly.
> > > 
> > > Unfortunately, the offsetting also means that you have a non-zero mem_offset
> > > value for the pci host controller, which breaks code that reads the PCI BARs
> > > and uses those as physical addresses.
> > 
> > No, you're confusing two things.
> > 
> > Firstly, nothing in todays kernel should read PCI BARs and treat them as
> > physical addresses.  Userspace is a different matter, but that is entirely
> > unrelated to VGA_MAP_MEM().
> 
> I understand the part about "should", and I would hope that there is little
> code left in the kernel still doing that, but I occasionally see some of
> that in old or staging drivers. Try "git grep PCI_BASE_ADDRESS" in the kernel
> tree.

Well, anything which does stuff like this:

            for (i = 0xC8000; i < 0xE8000; i += 0x4000) {
                ha->brd = ioremap(i, sizeof(u16));
                pci_write_config_dword(pdev, PCI_BASE_ADDRESS_0, i);

is broken for a whole load of reasons not just because of the write to
the PCI configuration register.  The same probably applies elsewhere.

> It's not completely wrong, it's picking one of two evils. VGA console
> is the only thing that needs the low PCI address mapping, and if you
> have any more recent GPU, you can use fbcon with a hardware specific
> driver that uses the normal PCI BARs.

I'm afraid that is not entirely true.  Many VGA cards require access
to the VGA window to access MMIO registers to tell them what to do...
And remember my earlier point - you must have something to run the
VGA BIOS to setup the VGA card, and it _will_ want to initialize it
in VGA mode using the VGA window.  So if you can't access that on
your PCI bus, you can't ever have a VGA card plugged in.

> Also, in many cases, you don't even have the choice in the kernel between
> the two options, either PCI is identity mapped or mapped starting at
> address zero based on whatever the soc or board designer thought, and the
> only thing we can do is tell the kernel what the hardware does.

Exactly which is why you're wrong. :)  If the hardware enforces a
separation of the physical address space from the PCI address space
by way of an offset translation, then you have no option but to have
a non-zero mem_offset.

> It looks like cns3xxx, tegra, versatile and ks8695 are all hardwired to a
> zero mem_offset, while dc21285, integrator, it8152 and sa1100/pci-nanoengine
> map the PCI bus starting at bus address 0.

Don't read too much into the versatile stuff.  All that is very very much
untested and fragile.  It's fairly buggered at the moment as it stands,
and as far as I can tell there's absolutely no way to know what the right
solution is - because the ARM documentation is extremely poor and all the
real hardware has been stuffed through the mincer.

So that leaves cns3xxx, tegra and ks8695 being the non-plat ones which
are "different" from the majority on ARM.
