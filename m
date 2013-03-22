From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 22 Mar 2013 10:37:40 +0000
Subject: Integrator PCI base dilemma
In-Reply-To: <201303220948.28092.arnd@arndb.de>
References: <CACRpkdaOjFhWR21w5x_rR_60ffQF3Ym_MQd2svNyzm0guwOUoQ@mail.gmail.com>
 <201303211302.19058.arnd@arndb.de>
 <20130321234004.GV4977@n2100.arm.linux.org.uk>
 <201303220948.28092.arnd@arndb.de>
Message-ID: <20130322103740.GW4977@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 22, 2013 at 09:48:27AM +0000, Arnd Bergmann wrote:
> > That's because it's pretty much built into the way VGA crud works.
> > VGA BIOSes hard code these addresses into themselves.  Really, so does
> > the kernel, but non-native architectures are given the chance to offset
> > this appropriately - and remember that non-native architectures will
> > run the VGA BIOS via an x86 emulator, which you pretty much have to do
> > to get VGA cards to initialize properly.
> 
> Unfortunately, the offsetting also means that you have a non-zero mem_offset
> value for the pci host controller, which breaks code that reads the PCI BARs
> and uses those as physical addresses.

No, you're confusing two things.

Firstly, nothing in todays kernel should read PCI BARs and treat them as
physical addresses.  Userspace is a different matter, but that is entirely
unrelated to VGA_MAP_MEM().

The non-zero mem_offset occurs if your physical address space is different
from the PCI address space.  Footbridge has this.  PCI memory address 0
is physical address 0x80000000, because all the SDRAM and DC21285
peripherals, PCI IO space etc all appear below 0x80000000.  This alone
mandates mem_offset to be 0x80000000.

You _could_ tweak a bit which will set PCI bit 31 in the address for that
window.  That gets you a 1:1 mapping.  But then the VGA addresses are
inaccessible - and as a side effect of that, XF86 will hit something else
rather than the PCI bus.

Now, we don't have to map this, but if we want VGA cards to work with
vgacon, then there is no option but to do so.  So, the first 16MB of
PCI space is statically mapped.

VGA_MAP_MEM() is then defined to be the _virtual_ address of this mapping.

If PCI and physical addresses weren't translated in this way, then mem_offset
would be zero, and VGA_MAP_MEM() would still need to have the virtual
address of the mapping.

So, the two things are _entirely_ separate.

> I believe XFree86 traditionally did
> this. I normally recommend to do PCI host bridge drivers with mem_offset=0,

I wonder how many systems you've broken by telling people to do that,
because frankly you're wrong.  See the above example on Footbridge
why you're completely wrong on this point.

And XF86 may have traditionally done this, but it will be broken on
platforms like Footbridge as long as it does this behaviour, irrespective
of the setting of mem_offset.  Also, having XF86 mess around with the
PCI configuration in ways that the kernel is not aware of has long been
viewed as a bug.

Finally, the kernel has interfaces for mapping PCI BARs, and this is the
way XF86 should now deal with VGA cards, not by mapping /dev/mem.  The
old /dev/mem interface is being deprecated for that kind of use.

> > > Now what does this all tell us? First of all I think you are free to change
> > > it in any way that does not break footbridge, since everything else is already
> > > broken.
> > 
> > Footbridge and Integrator/AP.
> 
> Yes, I was assuming that Linus would keep Integrator/AP working since that is
> what he uses.

It's entirely possible that Linus doesn't use a VGA card with Integrator/AP
if Linus is not using MILO - because MILO was the only boot loader for
that platform which had an x86 emulator built in to run the VGA BIOS to
initialize the VGA card.

There are two boot loaders I'm aware of which are capable of doing this,
and those are MILO and my boot loader for Footbridge platforms (which,
incidentally, now runs ATA card BIOSes too complete with input support
and can push out the VGA output via serial and accept keypresses via
serial) - and that doesn't work on Integrator/AP.
