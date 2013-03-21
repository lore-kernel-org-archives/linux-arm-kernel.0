From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 21 Mar 2013 23:40:04 +0000
Subject: Integrator PCI base dilemma
In-Reply-To: <201303211302.19058.arnd@arndb.de>
References: <CACRpkdaOjFhWR21w5x_rR_60ffQF3Ym_MQd2svNyzm0guwOUoQ@mail.gmail.com>
 <201303211302.19058.arnd@arndb.de>
Message-ID: <20130321234004.GV4977@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gah.  Wrap failure.

On Thu, Mar 21, 2013 at 01:02:18PM +0000, Arnd Bergmann wrote:
> Alpha, IA64, PPC64, and Tile use ioremap there, which seems reasonable
> especially given that the at least the vga16fb assumes it can iounmap
> the pointer returned by VGA_MAP_MEM when unloading.

Be. Very. Careful. with that.

Look at vgacon.  vgacon gets used on ARM.  vga16fb does not.  vgacon
does not use VGA_MAP_MEM() in a way compatible with our ioremap() -
things like the font ops will end up creating multiple mappings which
will eventually full the ioremap() space if you do go down that route.

> Again, I'd assume that tile is incorrectly copied from
> one of the others, but it might actually work. All but ia64 here rely
> on the VGA registers and memory and ROM being mapped into physical
> addresses 0xA0000-0xC7fff as they are on PCs.

That's because it's pretty much built into the way VGA crud works.
VGA BIOSes hard code these addresses into themselves.  Really, so does
the kernel, but non-native architectures are given the chance to offset
this appropriately - and remember that non-native architectures will
run the VGA BIOS via an x86 emulator, which you pretty much have to do
to get VGA cards to initialize properly.

I've tried the manual initialization with a S3 VGA card.  It was
acceptable but the black level was too high.  I could never sort that
out until I switched to running the VGA BIOS instead.

> ARM, MIPS and PPC32 map the registers at boot time into a fixed or known
> virtual address, but all implementations are really suspicious:
> * On ARM, we have these definitions:
> 
> arch/arm/mach-dove/pcie.c:      vga_base = DOVE_PCIE0_MEM_PHYS_BASE;
> arch/arm/mach-footbridge/dc21285.c:     vga_base = PCIMEM_BASE;
> arch/arm/mach-integrator/integrator_ap.c:       vga_base = PCI_MEMORY_VADDR;
> arch/arm/mach-kirkwood/pcie.c:  vga_base = KIRKWOOD_PCIE_MEM_PHYS_BASE;
> arch/arm/mach-mv78xx0/pcie.c:   vga_base = MV78XX0_PCIE_MEM_PHYS_BASE;
> arch/arm/mach-orion5x/pci.c:    vga_base = ORION5X_PCIE_MEM_PHYS_BASE;
> arch/arm/mach-shark/pci.c:      vga_base = 0xe8000000;
> 
> Dove/integrator/kirkwood/mv78xx0/orion5x all put a *physical* address in here,
> which cannot work, since that is not mapped anywhere.

Erm, no.  Look again at Integrator.  PCI_MEMORY_*V*ADDR.
arch/arm/mach-integrator/include/mach/platform.h:#define PCI_MEMORY_VADDR IOMEM(0xe8000000)

And we have a static mapping for that memory space in place - and I've
had VGA cards (Permedia3) working there when I had an AP system, so it
has worked in the past.

DC21285 works (or at least used to) because I have that on the machine
over -----> there, but its running an old kernel because both IDE and
ATA subsystems were pretty fscked last time I tried to update it, and
my network doesn't work very well without that machine working!  I do
need to try again at some point to upgrade its kernel.

> Footbridge and integrator get it right, presumably because Russell
> was actually using that code ;-)

... and for Footbridge, still do.  Remember, though that this whole
vga_base thing is a relatively recent addition due to the single zImage
project, so any mistakes with the above need proper research to see
whether they're bugs introduced by that activity.

> Now what does this all tell us? First of all I think you are free to change
> it in any way that does not break footbridge, since everything else is already
> broken.

Footbridge and Integrator/AP.

> I think the most logical way forward would be to use the same method
> as ia64 and use ioremap() with a platform-specific offset, but keeping the
> static mapping would probably be easier to do.

No, our ioremap() will definitely break here.
