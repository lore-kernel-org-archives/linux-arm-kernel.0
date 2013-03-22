From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 Mar 2013 09:48:27 +0000
Subject: Integrator PCI base dilemma
In-Reply-To: <20130321234004.GV4977@n2100.arm.linux.org.uk>
References: <CACRpkdaOjFhWR21w5x_rR_60ffQF3Ym_MQd2svNyzm0guwOUoQ@mail.gmail.com>
 <201303211302.19058.arnd@arndb.de>
 <20130321234004.GV4977@n2100.arm.linux.org.uk>
Message-ID: <201303220948.28092.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 March 2013, Russell King - ARM Linux wrote:
> Gah.  Wrap failure.
> 
> On Thu, Mar 21, 2013 at 01:02:18PM +0000, Arnd Bergmann wrote:
> > Alpha, IA64, PPC64, and Tile use ioremap there, which seems reasonable
> > especially given that the at least the vga16fb assumes it can iounmap
> > the pointer returned by VGA_MAP_MEM when unloading.
> 
> Be. Very. Careful. with that.
> 
> Look at vgacon.  vgacon gets used on ARM.  vga16fb does not.  vgacon
> does not use VGA_MAP_MEM() in a way compatible with our ioremap() -
> things like the font ops will end up creating multiple mappings which
> will eventually full the ioremap() space if you do go down that route.

Ah, so we have two drivers using the same interface based on conflicting
assumptions, nice.

I guess ioremap would still work on ARM  if we already have a static
mapping, but in that case there is no need to use ioremap in the first
place.

To fix this properly, we could add a matching VGA_UNMAP_MEM() interface
and use it consistently in both drivers. I don't think anyone has the
energy to do that and get it merged, but I would review patches ;-)

> > Again, I'd assume that tile is incorrectly copied from
> > one of the others, but it might actually work. All but ia64 here rely
> > on the VGA registers and memory and ROM being mapped into physical
> > addresses 0xA0000-0xC7fff as they are on PCs.
> 
> That's because it's pretty much built into the way VGA crud works.
> VGA BIOSes hard code these addresses into themselves.  Really, so does
> the kernel, but non-native architectures are given the chance to offset
> this appropriately - and remember that non-native architectures will
> run the VGA BIOS via an x86 emulator, which you pretty much have to do
> to get VGA cards to initialize properly.

Unfortunately, the offsetting also means that you have a non-zero mem_offset
value for the pci host controller, which breaks code that reads the PCI BARs
and uses those as physical addresses. I believe XFree86 traditionally did
this. I normally recommend to do PCI host bridge drivers with mem_offset=0,
meaning you have a window of valid PCI memory space addresses that match
the physical address at which they are visible to the CPU. This of course
means that VGA_MAP_MEM() cannot work, because the ISA compatible memory
space addresses end up outside of the window.

> > arch/arm/mach-dove/pcie.c:      vga_base = DOVE_PCIE0_MEM_PHYS_BASE;
> > arch/arm/mach-footbridge/dc21285.c:     vga_base = PCIMEM_BASE;
> > arch/arm/mach-integrator/integrator_ap.c:       vga_base = PCI_MEMORY_VADDR;
> > arch/arm/mach-kirkwood/pcie.c:  vga_base = KIRKWOOD_PCIE_MEM_PHYS_BASE;
> > arch/arm/mach-mv78xx0/pcie.c:   vga_base = MV78XX0_PCIE_MEM_PHYS_BASE;
> > arch/arm/mach-orion5x/pci.c:    vga_base = ORION5X_PCIE_MEM_PHYS_BASE;
> > arch/arm/mach-shark/pci.c:      vga_base = 0xe8000000;
> > 
> > Dove/integrator/kirkwood/mv78xx0/orion5x all put a *physical* address in here,
> > which cannot work, since that is not mapped anywhere.
> 
> Erm, no.  Look again at Integrator.  PCI_MEMORY_*V*ADDR.
> arch/arm/mach-integrator/include/mach/platform.h:#define PCI_MEMORY_VADDR IOMEM(0xe8000000)

Right. My brain was thinking correctly, but my fingers typed it out wrong ;-)

> > Footbridge and integrator get it right, presumably because Russell
> > was actually using that code ;-)
> 
> ... and for Footbridge, still do.  Remember, though that this whole
> vga_base thing is a relatively recent addition due to the single zImage
> project, so any mistakes with the above need proper research to see
> whether they're bugs introduced by that activity.

Yes. It took me a while yesterday to go through the history for shark, as
I feared we broke VGA_MAP_MEM during the conversion, but I'm pretty sure it
was already broken before.

> > Now what does this all tell us? First of all I think you are free to change
> > it in any way that does not break footbridge, since everything else is already
> > broken.
> 
> Footbridge and Integrator/AP.

Yes, I was assuming that Linus would keep Integrator/AP working since that is
what he uses.

> > I think the most logical way forward would be to use the same method
> > as ia64 and use ioremap() with a platform-specific offset, but keeping the
> > static mapping would probably be easier to do.
> 
> No, our ioremap() will definitely break here.

Ok, so let's keep the static mapping method.

	Arnd
