From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Wed, 10 Jan 2018 09:31:45 +0000
Subject: [PATCH 11/33] dma-mapping: move swiotlb arch helpers to a new
 header
In-Reply-To: <20180110080027.13879-12-hch@lst.de>
References: <20180110080027.13879-1-hch@lst.de>
 <20180110080027.13879-12-hch@lst.de>
Message-ID: <b2bd6f4b-a932-5251-517b-83bbccfe7c53@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/01/18 08:00, Christoph Hellwig wrote:
> index 9110988b92a1..f00833acb626 100644
> --- a/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
> +++ b/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
> @@ -61,6 +61,14 @@ static inline void plat_post_dma_flush(struct device *dev)
>  {
>  }
>  
> +static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
> +{
> +	if (!dev->dma_mask)
> +		return false;
> +
> +	return addr + size <= *dev->dma_mask;
> +}
> +

I know it is copy&paste, but it seems it has off by one error and it should be

return addr + size - 1 <= *dev->dma_mask;


>  dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr);
>  phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr);
>  

snip...

> diff --git a/arch/mips/include/asm/mach-loongson64/dma-coherence.h b/arch/mips/include/asm/mach-loongson64/dma-coherence.h
> index 1602a9e9e8c2..5cfda8f893e9 100644
> --- a/arch/mips/include/asm/mach-loongson64/dma-coherence.h
> +++ b/arch/mips/include/asm/mach-loongson64/dma-coherence.h
> @@ -17,6 +17,14 @@
>  
>  struct device;
>  
> +static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
> +{
> +	if (!dev->dma_mask)
> +		return false;
> +
> +	return addr + size <= *dev->dma_mask;


ditto

Cheers
Vladimir
