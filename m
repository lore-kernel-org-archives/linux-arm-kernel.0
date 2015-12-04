From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 4 Dec 2015 10:50:01 +0000
Subject: [PATCH] drivers: dma-coherent: use ioremap_wc() for DMA_MEMORY_MAP
In-Reply-To: <1448029226-4914-1-git-send-email-brian.starkey@arm.com>
References: <1448029226-4914-1-git-send-email-brian.starkey@arm.com>
Message-ID: <20151204105000.GD10123@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2015 at 02:20:26PM +0000, Brian Starkey wrote:
> When the DMA_MEMORY_MAP flag is used, memory which can be accessed
> directly should be returned, so use ioremap_wc() instead of ioremap().
> Also, ensure that the correct memset operation is used in
> dma_alloc_from_coherent() with respect to the region's flags.
> 
> This fixes the below alignment fault on arm64, caused by invalid use
> of memset() on Device memory.

This is indeed affecting both arm32 and arm64 systems.

> diff --git a/drivers/base/dma-coherent.c b/drivers/base/dma-coherent.c
> index 55b8398..45358d0 100644
> --- a/drivers/base/dma-coherent.c
> +++ b/drivers/base/dma-coherent.c
> @@ -31,7 +31,10 @@ static int dma_init_coherent_memory(phys_addr_t phys_addr, dma_addr_t device_add
>  	if (!size)
>  		goto out;
>  
> -	mem_base = ioremap(phys_addr, size);
> +	if (flags & DMA_MEMORY_MAP)
> +		mem_base = ioremap_wc(phys_addr, size);
> +	else
> +		mem_base = ioremap(phys_addr, size);

I wonder whether a memremap() approach for the DMA_MEMORY_MAP case would
be better. This API was added recently by commit 92281dee825f ("arch:
introduce memremap()"). It only supports write-back and write-through
but we could add a MEMREMAP_WC flag for this case.

-- 
Catalin
