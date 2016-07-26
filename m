From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 26 Jul 2016 16:05:17 +0100
Subject: [PATCH v4 4/6] arm64/dma-mapping: Implement DMA_ATTR_PRIVILEGED
In-Reply-To: <20160725191649.13414-5-mitchelh@codeaurora.org>
References: <20160725191649.13414-1-mitchelh@codeaurora.org>
 <20160725191649.13414-5-mitchelh@codeaurora.org>
Message-ID: <f6fa75a9-ce70-e6c5-fd51-2af502bc2f67@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mitch,

On 25/07/16 20:16, Mitchel Humpherys wrote:
> The newly added DMA_ATTR_PRIVILEGED is useful for creating mappings that
> are only accessible to privileged DMA engines.  Implement it in
> dma-iommu.c so that the ARM64 DMA IOMMU mapper can make use of it.
> 
> Signed-off-by: Mitchel Humpherys <mitchelh@codeaurora.org>
> ---
> 
> Notes:
>     v3..v4
>     
>       - Reworked against the new dma attrs format
>     
>     v2..v3
>     
>       - Renamed and redocumented dma_direction_to_prot.
>       - Dropped the stuff making all privileged mappings read-only.
> 
>  arch/arm64/mm/dma-mapping.c |  6 +++---
>  drivers/iommu/dma-iommu.c   | 16 +++++++++++-----
>  include/linux/dma-iommu.h   |  3 ++-
>  3 files changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index c4284c432ae8..1c6f85c56115 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -556,7 +556,7 @@ static void *__iommu_alloc_attrs(struct device *dev, size_t size,
>  				 unsigned long attrs)
>  {
>  	bool coherent = is_device_dma_coherent(dev);
> -	int ioprot = dma_direction_to_prot(DMA_BIDIRECTIONAL, coherent);
> +	int ioprot = dma_info_to_prot(DMA_BIDIRECTIONAL, coherent, attrs);
>  	size_t iosize = size;
>  	void *addr;
>  
> @@ -710,7 +710,7 @@ static dma_addr_t __iommu_map_page(struct device *dev, struct page *page,
>  				   unsigned long attrs)
>  {
>  	bool coherent = is_device_dma_coherent(dev);
> -	int prot = dma_direction_to_prot(dir, coherent);
> +	int prot = dma_info_to_prot(dir, coherent, attrs);
>  	dma_addr_t dev_addr = iommu_dma_map_page(dev, page, offset, size, prot);
>  
>  	if (!iommu_dma_mapping_error(dev, dev_addr) &&
> @@ -768,7 +768,7 @@ static int __iommu_map_sg_attrs(struct device *dev, struct scatterlist *sgl,
>  		__iommu_sync_sg_for_device(dev, sgl, nelems, dir);
>  
>  	return iommu_dma_map_sg(dev, sgl, nelems,
> -			dma_direction_to_prot(dir, coherent));
> +				dma_info_to_prot(dir, coherent, attrs));
>  }
>  
>  static void __iommu_unmap_sg_attrs(struct device *dev,
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 08a1e2f3690f..5e1e495b35f8 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -129,26 +129,32 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base, u64 size
>  EXPORT_SYMBOL(iommu_dma_init_domain);
>  
>  /**
> - * dma_direction_to_prot - Translate DMA API directions to IOMMU API page flags
> + * dma_info_to_prot - Translate DMA API directions and attributes to IOMMU API
> + *                    page flags.
>   * @dir: Direction of DMA transfer
>   * @coherent: Is the DMA master cache-coherent?
> + * @attrs: DMA attributes for the mapping
>   *
>   * Return: corresponding IOMMU API page protection flags
>   */
> -int dma_direction_to_prot(enum dma_data_direction dir, bool coherent)
> +int dma_info_to_prot(enum dma_data_direction dir, bool coherent,
> +		     unsigned long attrs)
>  {
>  	int prot = coherent ? IOMMU_CACHE : 0;
>  

+	if (attrs & DMA_ATTR_PRIVILEGED)
+		prot |= IOMMU_PRIV;
+

then drop the rest of the changes to the switch statement below. It's
taken me an embarrassingly long time to work out why things were blowing
up in __iommu_sync_single_for_device() all with a VA of phys_to_virt(0) ;)

With that change, for the whole series:

Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Tested-by: Robin Murphy <robin.murphy@arm.com>

I guess at this point it may be worth waiting to repost based on -rc1.
Be sure to CC patch 5 to Vinod as the current dmaengine maintainer, as
it's his ack we'll need on that.

Cheers,
Robin.

>  	switch (dir) {
>  	case DMA_BIDIRECTIONAL:
> -		return prot | IOMMU_READ | IOMMU_WRITE;
> +		prot |= IOMMU_READ | IOMMU_WRITE;
>  	case DMA_TO_DEVICE:
> -		return prot | IOMMU_READ;
> +		prot |= IOMMU_READ;
>  	case DMA_FROM_DEVICE:
> -		return prot | IOMMU_WRITE;
> +		prot |= IOMMU_WRITE;
>  	default:
>  		return 0;
>  	}
> +	if (attrs & DMA_ATTR_PRIVILEGED)
> +		prot |= IOMMU_PRIV;
> +	return prot;
>  }
>  
>  static struct iova *__alloc_iova(struct iova_domain *iovad, size_t size,
> diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
> index 81c5c8d167ad..b367613d49ba 100644
> --- a/include/linux/dma-iommu.h
> +++ b/include/linux/dma-iommu.h
> @@ -32,7 +32,8 @@ void iommu_put_dma_cookie(struct iommu_domain *domain);
>  int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base, u64 size);
>  
>  /* General helpers for DMA-API <-> IOMMU-API interaction */
> -int dma_direction_to_prot(enum dma_data_direction dir, bool coherent);
> +int dma_info_to_prot(enum dma_data_direction dir, bool coherent,
> +		     unsigned long attrs);
>  
>  /*
>   * These implement the bulk of the relevant DMA mapping callbacks, but require
> 
