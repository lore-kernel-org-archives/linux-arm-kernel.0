From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 21 Sep 2010 14:30:00 +0200
Subject: [PATCH v2 2/3] [ARM] tegra: add PCI Express support
In-Reply-To: <bb6c83c24e809d944beb2950c60cd89257baa1ea.1285070872.git.mike@compulab.co.il>
References: <cover.1285070872.git.mike@compulab.co.il>
	<bb6c83c24e809d944beb2950c60cd89257baa1ea.1285070872.git.mike@compulab.co.il>
Message-ID: <201009211430.00325.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
> CC: Arnd Bergmann <arnd@arndb.de>
> CC: Russell King <linux@arm.linux.org.uk>
> CC: Colin Cross <ccross@google.com>
> CC: Gary King <GKing@nvidia.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

On Tuesday 21 September 2010, Mike Rapoport wrote:
> 
>  /* On TEGRA, many peripherals are very closely packed in
>   * two 256MB io windows (that actually only use about 64KB
> @@ -67,10 +67,20 @@ void tegra_iounmap(volatile void __iomem *addr);
>  
>  #define IO_ADDRESS(n) ((void __iomem *) IO_TO_VIRT(n))
>  
> +#ifdef CONFIG_TEGRA_PCI
> +extern void __iomem *tegra_pcie_io_base;
> +
> +static inline void __iomem *__io(unsigned long addr)
> +{
> +       return tegra_pcie_io_base + (addr & IO_SPACE_LIMIT);
> +}
> +#else
>  static inline void __iomem *__io(unsigned long addr)
>  {
>         return (void __iomem *)addr;
>  }
> +#endif
> +
>  #define __io(a)         __io(a)
>  #define __mem_pci(a)    (a)

I wonder what the #else path is for. If you don't have PCI, who would
call __io? And wouldn't that result in a NULL pointer dereference?

	Arnd
