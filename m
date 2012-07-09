From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 9 Jul 2012 16:21:37 +0000
Subject: [PATCH 01/15] ARM: Add fixed PCI i/o mapping
In-Reply-To: <1341600040-30993-2-git-send-email-robherring2@gmail.com>
References: <1341600040-30993-1-git-send-email-robherring2@gmail.com>
 <1341600040-30993-2-git-send-email-robherring2@gmail.com>
Message-ID: <201207091621.38261.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 06 July 2012, Rob Herring wrote:
>  /*
> + * Setup fixed I/O mapping. Must be called from .map_io function.
> + */
> +#ifdef CONFIG_PCI
> +extern void pci_map_io_pfn(unsigned long pfn[], int nr, int size);
> +#else
> +static inline void pci_map_io_pfn(unsigned long pfn[], int nr, int size) {}
> +#endif
> +static inline void __init pci_map_io_single_pfn(unsigned long pfn)
> +{
> +       pci_map_io_pfn(&pfn, 1, SZ_1M);
> +}
> +
> +static inline void __init pci_map_io_single(unsigned long paddr)
> +{
> +       pci_map_io_single_pfn(__phys_to_pfn(paddr));
> +}

On powerpc, we have a special flag that gets used to register a "primary"
I/O space, which is the one that holds the port numbers between 0 and 1024
because that is the only place that an ISA add-on card can be used in.

I wonder if we want to support that as well, or if we just assume that
the first one to get registered is the primary bus.

	Arnd
