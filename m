From: robherring2@gmail.com (Rob Herring)
Date: Wed, 20 Mar 2013 18:54:24 -0500
Subject: Integrator PCI base dilemma
In-Reply-To: <CACRpkdaOjFhWR21w5x_rR_60ffQF3Ym_MQd2svNyzm0guwOUoQ@mail.gmail.com>
References: <CACRpkdaOjFhWR21w5x_rR_60ffQF3Ym_MQd2svNyzm0guwOUoQ@mail.gmail.com>
Message-ID: <514A4C30.9080402@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/20/2013 06:15 PM, Linus Walleij wrote:
> When trying to convert the Integrator/AP to use Device Tree
> for the PCI bridge/hose I run into these two problems:
> 
> - Unable to assign vga_base early since this should be a virtual
>   address assigned really early. If I sacrifice this and try to
>   just remap the stuff, I still run into:

This could be a fixed mapping like we did for the i/o space.

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

It's for the same problem you have, but for the i/o space.

> 
> The problem is that at this point at iomap the device tree is not yet
> populated.
> 
> We can attempt to do it later but then the kernel hangs when
> I try to remap the two 16MiB chunks for the non-prefetched
> memory and the config window.
> 
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

Wouldn't the drivers' ioremap create a mapping with the the memory
space? The only user of this mapping may be VGA.

For the config space, how much do you really need? You could ioremap
this on demand. I think this issue came up before on another platform
where the config space was very sparsely accessed.

Rob
