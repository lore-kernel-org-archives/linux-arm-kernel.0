From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Mar 2013 13:02:18 +0000
Subject: Integrator PCI base dilemma
In-Reply-To: <CACRpkdaOjFhWR21w5x_rR_60ffQF3Ym_MQd2svNyzm0guwOUoQ@mail.gmail.com>
References: <CACRpkdaOjFhWR21w5x_rR_60ffQF3Ym_MQd2svNyzm0guwOUoQ@mail.gmail.com>
Message-ID: <201303211302.19058.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 20 March 2013, Linus Walleij wrote:
> When trying to convert the Integrator/AP to use Device Tree
> for the PCI bridge/hose I run into these two problems:
> 
> - Unable to assign vga_base early since this should be a virtual
>   address assigned really early. If I sacrifice this and try to
>   just remap the stuff, I still run into:
> 
> - Unable to ioremap the PCI memory and config window because
>   it is 16 MiB big. (I guess this is the problem?)
> 
> Part of the code path is called from .map_io() and basically looks
> like this:
> 
> int __init pci_v3_early_init(void)
> {
> 	iotable_init(pci_v3_io_desc, ARRAY_SIZE(pci_v3_io_desc));
> 	vga_base = PCI_MEMORY_VADDR;
> 	pci_map_io_early(__phys_to_pfn(PHYS_PCI_IO_BASE));
> 	return 0;
> }
> 
> The VGA console seems to be the sole user (unsure what
> pci_map_io_early() is for), and we like to support VGA console.

Yes, this is certainly required only for the VGA console

> The problem is that at this point at iomap the device tree is not yet
> populated.

I think it's fine to leave the static mapping in place for this,
you don't necessarily have to get it from DT here, since it seems
like a reasonable use of map_io().

> The iomem table looks like this:
> 
> /*
>  * Static mappings for the PCIv3 bridge
>  *
>  * e8000000	40000000	PCI memory		PHYS_PCI_MEM_BASE	(max 512M)
>  * ec000000	61000000	PCI config space	PHYS_PCI_CONFIG_BASE	(max 16M)
>  * fee00000	60000000	PCI IO			PHYS_PCI_IO_BASE	(max 16M)
>  */
> static struct map_desc pci_v3_io_desc[] __initdata __maybe_unused = {
> 	{
> 		.virtual	= (unsigned long)PCI_MEMORY_VADDR,
> 		.pfn		= __phys_to_pfn(PHYS_PCI_MEM_BASE),
> 		.length		= SZ_16M,
> 		.type		= MT_DEVICE
> 	}, {
> 		.virtual	= (unsigned long)PCI_CONFIG_VADDR,
> 		.pfn		= __phys_to_pfn(PHYS_PCI_CONFIG_BASE),
> 		.length		= SZ_16M,
> 		.type		= MT_DEVICE
> 	}
> };
> 
> Does anyone have any hints on how to get out of this need to have the
> base addresses so early?
> 
> Or am I doing something wrong when I try to push in this map
> later? I tried to just ioremap() them later but that doesn't
> seem to work at all. Too big?

I think the key is the VGA_MAP_MEM() function that can be defined in a number
of ways:

arch/alpha/include/asm/vga.h:#define VGA_MAP_MEM(x,s)   ((unsigned long) ioremap(x, s))
arch/arm/include/asm/vga.h:#define VGA_MAP_MEM(x,s)     (vga_base + (x))
arch/ia64/include/asm/vga.h:#define VGA_MAP_MEM(x,s)    ((unsigned long) ioremap_nocache(vga_console_membase + (x
arch/m32r/include/asm/vga.h:#define VGA_MAP_MEM(x,s) (unsigned long)phys_to_virt(x)
arch/mips/include/asm/vga.h:#define VGA_MAP_MEM(x, s)   (0xb0000000L + (unsigned long)(x))
arch/powerpc/include/asm/vga.h:#define VGA_MAP_MEM(x,s) ((unsigned long) ioremap((x), s))
arch/powerpc/include/asm/vga.h:#define VGA_MAP_MEM(x,s) (x + vgacon_remap_base)
arch/sparc/include/asm/vga.h:#define VGA_MAP_MEM(x,s) (x)
arch/tile/include/asm/vga.h:#define VGA_MAP_MEM(x,s)    ((unsigned long) ioremap(x, s))
arch/x86/include/asm/vga.h:#define VGA_MAP_MEM(x, s) (unsigned long)phys_to_virt(x)
arch/xtensa/include/asm/vga.h:#define VGA_MAP_MEM(x,s) (unsigned long)phys_to_virt(x)

On xtensa and x86, the low PCI memory addresses are actually mapped into the
physical address space, so they already have a mapping. It seems the same is
true on sparc, which apparently also relies on a 1:1 mapping of virtual to physical
addresses in the kernel. m32r is probably a copy-paste bug since it has no PCI.

Alpha, IA64, PPC64, and Tile use ioremap there, which seems reasonable especially
given that the at least the vga16fb assumes it can iounmap the pointer returned
by VGA_MAP_MEM when unloading. Again, I'd assume that tile is incorrectly copied from
one of the others, but it might actually work. All but ia64 here rely on the VGA
registers and memory and ROM being mapped into physical addresses 0xA0000-0xC7fff
as they are on PCs.

ARM, MIPS and PPC32 map the registers at boot time into a fixed or known virtual
address, but all implementations are really suspicious:
* On ppc32, nothing is ever assigned to vgacon_remap_base, I assume the last user
  is long gone, this may have been the PREP platform that got marked as BROKEN
  in 2005. A NULL vgacon_remap_base cannot work, since that would imply that the
  VGA memory is mapped into a low virtual address, i.e. user space.
* On MIPS, this seems to work only on the legacy RM200/300/400 platform, although
  I don't actually see where it's being mapped, and none of the platform defconfigs
  enable VGA_CONSOLE.
* On ARM, we have these definitions:

arch/arm/mach-dove/pcie.c:      vga_base = DOVE_PCIE0_MEM_PHYS_BASE;
arch/arm/mach-footbridge/dc21285.c:     vga_base = PCIMEM_BASE;
arch/arm/mach-integrator/integrator_ap.c:       vga_base = PCI_MEMORY_VADDR;
arch/arm/mach-kirkwood/pcie.c:  vga_base = KIRKWOOD_PCIE_MEM_PHYS_BASE;
arch/arm/mach-mv78xx0/pcie.c:   vga_base = MV78XX0_PCIE_MEM_PHYS_BASE;
arch/arm/mach-orion5x/pci.c:    vga_base = ORION5X_PCIE_MEM_PHYS_BASE;
arch/arm/mach-shark/pci.c:      vga_base = 0xe8000000;

Dove/integrator/kirkwood/mv78xx0/orion5x all put a *physical* address in here,
which cannot work, since that is not mapped anywhere.

Footbridge and integrator get it right, presumably because Russell was actually
using that code ;-)
Shark does not map anything to the vga_base, so that does not work. It used
to map a lot of registers, but has not mapped the first megabyte of the PCI
memory space since the start of git history.

Now what does this all tell us? First of all I think you are free to change
it in any way that does not break footbridge, since everything else is already
broken. I think the most logical way forward would be to use the same method
as ia64 and use ioremap() with a platform-specific offset, but keeping the
static mapping would probably be easier to do.

	Arnd
