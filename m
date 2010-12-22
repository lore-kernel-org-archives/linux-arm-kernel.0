From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 22 Dec 2010 16:33:20 +0100
Subject: [PATCH 3/6] ARM Realview PCIX map include file changes
In-Reply-To: <20101222140409.29725.82642.stgit@e102602-lin.cambridge.arm.com>
References: <20101222140305.29725.50845.stgit@e102602-lin.cambridge.arm.com>
	<20101222140409.29725.82642.stgit@e102602-lin.cambridge.arm.com>
Message-ID: <201012221633.20748.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 22 December 2010 15:04:09 Colin Tuckley wrote:

> #define REALVIEW_PB11MP_PCI_IO_SIZE            0x1000          /* 4 Kb */

Is the I/O space really just 4 kb? This may easily cause problems,
because the first 4 kb of I/O space are usually reserved for PCI-ISA
bridges and the like. At least the public documentation for PB-X
describes a 64 kb space, which is also what everyone else has.

> +static inline unsigned int pcibios_min_io(void)
> +{
> +       if (machine_is_realview_pb11mp() || machine_is_realview_pba8() ||
> +           machine_is_realview_pbx())
> +               return REALVIEW_PB_PCI_IO_BASE;
> +       else
> +               return 0;
> +}
...
> +
>  #define IO_SPACE_LIMIT 0xffffffff
>  
> -#define __io(a)                __typesafe_io(a)
> +static inline void __iomem *__io(unsigned long addr)
> +{
> +#ifdef CONFIG_PCI
> +       /* check for PCI I/O space */
> +       if (addr >= REALVIEW_PB_PCI_IO_BASE && addr <= REALVIEW_PB_PCI_IO_LIMIT)
> +               return (void __iomem *)((addr - REALVIEW_PB_PCI_IO_BASE) + REALVIEW_PCI_IO_VBASE);
> +       else
> +               return (void __iomem *)addr;
> +#else
> +       return (void __iomem *)addr;
> +#endif
> +}

The I/O space handling still looks really wrong. Why not simply do this:

#define PCIBIOS_MIN_IO 0x1000  /* skip the first 4kb */
#define IO_SPACE_LIMIT 0xffff  /* regular 64 kb I/O space */
#define __io(a) (REALVIEW_PCI_IO_VBASE + (a & IO_SPACE_LIMIT)

If you start the I/O space at REALVIEW_PB_PCI_IO_BASE instead of 0x1000
or 0, you get into all sorts of trouble, e.g. when using /dev/ioport.

	Arnd
