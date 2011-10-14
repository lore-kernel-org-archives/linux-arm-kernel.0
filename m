From: subashrp@gmail.com (Subash Patel)
Date: Fri, 14 Oct 2011 10:03:18 +0530
Subject: [Linaro-mm-sig] [PATCH 8/9] ARM: integrate CMA with DMA-mapping
	subsystem
In-Reply-To: <1317909290-29832-10-git-send-email-m.szyprowski@samsung.com>
References: <1317909290-29832-1-git-send-email-m.szyprowski@samsung.com>
	<1317909290-29832-10-git-send-email-m.szyprowski@samsung.com>
Message-ID: <4E97BB8E.3060204@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

As informed to you in private over IRC, below piece of code broke during 
booting EXYNOS4:SMDKV310 with ZONE_DMA enabled.


On 10/06/2011 07:24 PM, Marek Szyprowski wrote:
...
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index fbdd12e..9c27fbd 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -21,6 +21,7 @@
>   #include<linux/gfp.h>
>   #include<linux/memblock.h>
>   #include<linux/sort.h>
> +#include<linux/dma-contiguous.h>
>
>   #include<asm/mach-types.h>
>   #include<asm/prom.h>
> @@ -371,6 +372,13 @@ void __init arm_memblock_init(struct meminfo *mi, struct machine_desc *mdesc)
>   	if (mdesc->reserve)
>   		mdesc->reserve();
>
> +	/* reserve memory for DMA contigouos allocations */
> +#ifdef CONFIG_ZONE_DMA
> +	dma_contiguous_reserve(PHYS_OFFSET + mdesc->dma_zone_size - 1);
> +#else
> +	dma_contiguous_reserve(0);
> +#endif
> +
>   	memblock_analyze();
>   	memblock_dump_all();
>   }
Regards,
Subash
