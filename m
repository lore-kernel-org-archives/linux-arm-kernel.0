From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 Oct 2010 23:28:45 +0200
Subject: [PATCH 3/6] ARM Realview PCIX map include file changes
In-Reply-To: <20101020130305.22199.2458.stgit@e102602-lin.cambridge.arm.com>
References: <20101020125554.22199.78597.stgit@e102602-lin.cambridge.arm.com>
	<20101020130305.22199.2458.stgit@e102602-lin.cambridge.arm.com>
Message-ID: <201010202328.45993.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 20 October 2010 15:03:05 Colin Tuckley wrote:
> This patch adds the memory map PCI support to the include
> files for the Realview Northbridge based boards.
> 
>  #include <asm/sizes.h>
> +#include <asm/mach-types.h>
> +
> +/*
> + * PCI space virtual addresses
> + */
> +#define REALVIEW_PCI_VIRT_BASE		0xF8000000
> +#define REALVIEW_PCI_CFG_VIRT_BASE	0xF9000000
> +#define PCIX_UNIT_BASE			0xF8000000
> +#define REALVIEW_PCI_IO_VBASE		0xFA000000

Please use the correct type virt base definition, i.e. void __iomem *, so you can
use readl/writel on them.

We should also coordinate this with the xilinx PCI patches that I sent.
We are both using the same virtual base for the IO range (fa00000),
but I named the macro differently (REALVIEW_PCI_IO_VIRT_BASE). I'm fine
either way, but there is no point having two different names for the
same thing.

> +/*
> + * PCI space physical addresses and sizes
> + */
> +#define REALVIEW_PB_PCI_BASE		0x90040000	/* PCI-X Unit base */
> +#define REALVIEW_PB_PCI_BASE_SIZE	0x00010000	/* 4 Kb + 60Kb reserved */
> +#define REALVIEW_PB_PCI_IO_BASE		0x90050000	/* IO Region on AHB */
> +#define REALVIEW_PB_PCI_IO_SIZE		0x00010000	/* 64 Kb */
> +#define REALVIEW_PB_PCI_IO_LIMIT       (REALVIEW_PB_PCI_IO_BASE + REALVIEW_PB_PCI_IO_SIZE - 1)
> +#define REALVIEW_PB_PCI_MEM_BASE	0xA0000000	/* MEM Region on AHB */
> +#define REALVIEW_PB_PCI_MEM_SIZE	0x20000000	/* 512 MB */

The naming for these seems screwed up -- it does not apply to all realview pb.

> +/*
> + * These are needed so that generic pci code doesn't know about our
> + * machine specific details.
> + */
> +#define PCIBIOS_MIN_IO		pcibios_min_io()
> +#define PCIBIOS_MIN_MEM		pcibios_min_mem()

PCIBIOS_MIN_IO should always just be 0x1000, PCIBIOS_MIN_MEM is generally
ignored.

>  #define IO_SPACE_LIMIT 0xffffffff

IO_SPACE_LIMIT is also wrong, it should not be larger than the space you have
reserved at 0xFA000000, possibly just 0xffff, which is enough in practice.

> +static inline void __iomem *__io(unsigned long addr)
> +{
> +#ifdef CONFIG_PCI
> +	/* check for PCI I/O space */
> +	if (addr >= REALVIEW_PB_PCI_IO_BASE && addr <= REALVIEW_PB_PCI_IO_LIMIT)
> +		return (void __iomem *)((addr - REALVIEW_PB_PCI_IO_BASE) + REALVIEW_PCI_IO_VBASE);
> +	else
> +		return (void __iomem *)addr;
> +#else
> +	return (void __iomem *)addr;
> +#endif
> +}

No need for the #ifdef here, if you don't have PCI, nobody will call __io anyway.

Just make this

#define __io(x) (REALVIEW_PCI_IO_VBASE + x)

	Arnd
