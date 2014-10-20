From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 20 Oct 2014 09:42:55 +0200
Subject: [PATCH] arm: dma-mapping: fix compilation error when CONFIG_MMU is
 not present
In-Reply-To: <1413734340-53108-1-git-send-email-stefan.hengelein@fau.de>
References: <1413734340-53108-1-git-send-email-stefan.hengelein@fau.de>
Message-ID: <5444BCFF.8030803@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2014-10-19 17:59, Stefan Hengelein wrote:
> When CONFIG_MMU is not present, the variable 'atomic_pool' and the
> function '__in_atomic_pool' are undeclared but used in part of the
> code. Therefore, the compilation breaks.
> Now, they are defined to dummy values when CONFIG_MMU is undefined.
>
> This error was found with vampyr.

Frankly, those variables are used only when CONFIG_MMU or
CONFIG_ARM_DMA_USE_IOMMU are set. The latter imho makes only sense
together with CONFIG_MMU, so the issue reported here doesn't really
happen in real world.

> Signed-off-by: Stefan Hengelein <stefan.hengelein@fau.de>
> ---
>   arch/arm/mm/dma-mapping.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index c245d90..7d04cf7 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -573,12 +573,14 @@ static inline pgprot_t __get_dma_pgprot(struct dma_attrs *attrs, pgprot_t prot)
>   #else	/* !CONFIG_MMU */
>   
>   #define nommu() 1
> +#define atomic_pool 0
>   
>   #define __get_dma_pgprot(attrs, prot)	__pgprot(0)
>   #define __alloc_remap_buffer(dev, size, gfp, prot, ret, c)	NULL
>   #define __alloc_from_pool(size, ret_page)			NULL
>   #define __alloc_from_contiguous(dev, size, prot, ret, c)	NULL
>   #define __free_from_pool(cpu_addr, size)			0
> +#define __in_atomic_pool(start, size)				0
>   #define __free_from_contiguous(dev, page, cpu_addr, size)	do { } while (0)
>   #define __dma_free_remap(cpu_addr, size)			do { } while (0)
>   

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
