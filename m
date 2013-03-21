From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Mar 2013 16:17:08 +0000
Subject: Integrator PCI base dilemma
In-Reply-To: <514B098E.8020608@gmail.com>
References: <CACRpkdaOjFhWR21w5x_rR_60ffQF3Ym_MQd2svNyzm0guwOUoQ@mail.gmail.com>
 <CACRpkdbLjhg-EuTBM4-_-xWV+_dDoA-RNo3FOUDN8Ka0w77sGA@mail.gmail.com>
 <514B098E.8020608@gmail.com>
Message-ID: <201303211617.08531.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 March 2013, Rob Herring wrote:
> On 03/21/2013 04:16 AM, Linus Walleij wrote:
> > On Thu, Mar 21, 2013 at 12:54 AM, Rob Herring <robherring2@gmail.com> wrote:
> >> On 03/20/2013 06:15 PM, Linus Walleij wrote:
> > 
> >>> - Unable to assign vga_base early since this should be a virtual
> >>>   address assigned really early. If I sacrifice this and try to
> >>>   just remap the stuff, I still run into:
> >>
> >> This could be a fixed mapping like we did for the i/o space.
> > 
> > Hm, can you point me to the relevant topics so I can read up on it?
> 
> Look at pci_reserve_io, pci_map_io_early and pci_ioremap_io and the
> patches that added those. The whole reason pci_map_io_early was added
> was to solve exactly the same problem with some platforms needing early
> access to i/o space.

Given that we are only talking about integrator and footbridge here,
I think adding a lot of new infrastructure is overkill. This may change
if we get new systems that would like to come up with VGA console, but
I don't see that happen at this point.

> >> Wouldn't the drivers' ioremap create a mapping with the the memory
> >> space? The only user of this mapping may be VGA.
> > 
> > Well the VGA console is supposed to be as early as possible so
> > in some sense it's like an earlyprint dilemma. The way the mechanism
> > works right now is to give a raw pointer into the remapped
> > PCI non-prefetched memory, then the VGA console assumes that
> > the VGA device will be right there, att offset zero.
> > 
> > (Maybe there is some guarantee that PCI VGA devices will appear
> > first in that memory space, or it would be hard to do stunts like
> > this... I admit I haven't done much of PCI in my life.)
> 
> I believe it is setup by the BIOS and fixed on x86. There's probably
> some bootloader setup assumptions for ARM.
> 
> Does VGA need all 16MB as well?

There is some magic ISA-compatible range that normal PCI devices stay
out of. VGA really only needs the 160KB range from bus address 0xA0000
to 0xC7FFF, see /proc/iomem on your PC.

> >> For the config space, how much do you really need? You could ioremap
> >> this on demand. I think this issue came up before on another platform
> >> where the config space was very sparsely accessed.
> > 
> > Yes I think you're right here. So there may be a way to avoid the
> > big chunk of 16MiB remapping and avoid using a static offset for this.
> > 
> > So I end up only keeping one 16MiB remapping for the memory and
> > another static mapping for the I/O memoryspace.
> > 
> > And we basically have no way to get rid of these static maps :-/
> 
> You don't really have to get rid of the static map necessarily. It just
> needs to be more generic. If you fix the virtual address across
> platforms, then you just need to get the phys address out of the DT.

Again, that would work, but out of the two platforms left with VGA console,
Integrator is the only one with DT. Is that worth it?

	Arnd
