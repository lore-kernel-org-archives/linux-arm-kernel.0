From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 3 Aug 2018 12:20:48 -0400 (EDT)
Subject: [PATCH] ARM: mm: fix pci_ioremap_io() offset check
In-Reply-To: <20180803144044.21725-1-thomas.petazzoni@bootlin.com>
References: <20180803144044.21725-1-thomas.petazzoni@bootlin.com>
Message-ID: <nycvar.YSQ.7.76.1808031220080.13885@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 3 Aug 2018, Thomas Petazzoni wrote:

> IO_SPACE_LIMIT is the ending address of the PCI IO space, i.e
> something like 0xfffff (and not 0x100000).
> 
> Therefore, when offset = 0xf0000 is passed as argument, this function
> fails even though the offset + SZ_64K fits below the
> IO_SPACE_LIMIT. This makes the last chunk of 64 KB of the I/O space
> not usable as it cannot be mapped.
> 
> This patch fixes that by substracing 1 to offset + SZ_64K, so that we
> compare the addrss of the last byte of the I/O space against
> IO_SPACE_LIMIT instead of the address of the first byte of what is
> after the I/O space.
> 
> Fixes: c2794437091a4 ("ARM: Add fixed PCI i/o mapping")
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Acked-by: Nicolas Pitre <nico@linaro.org>


> ---
>  arch/arm/mm/ioremap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
> index fc91205ff46c..5bf9443cfbaa 100644
> --- a/arch/arm/mm/ioremap.c
> +++ b/arch/arm/mm/ioremap.c
> @@ -473,7 +473,7 @@ void pci_ioremap_set_mem_type(int mem_type)
>  
>  int pci_ioremap_io(unsigned int offset, phys_addr_t phys_addr)
>  {
> -	BUG_ON(offset + SZ_64K > IO_SPACE_LIMIT);
> +	BUG_ON(offset + SZ_64K - 1 > IO_SPACE_LIMIT);
>  
>  	return ioremap_page_range(PCI_IO_VIRT_BASE + offset,
>  				  PCI_IO_VIRT_BASE + offset + SZ_64K,
> -- 
> 2.14.4
> 
> 
