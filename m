From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 11 Jul 2016 16:06:54 +0100
Subject: [PATCH v2 5/6] arm64/dma-mapping: Implement
 DMA_ATTR_PRIVILEGED_EXECUTABLE
In-Reply-To: <20160709020919.6760-6-mitchelh@codeaurora.org>
References: <20160709020919.6760-1-mitchelh@codeaurora.org>
 <20160709020919.6760-6-mitchelh@codeaurora.org>
Message-ID: <5783B60E.3050907@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/07/16 03:09, Mitchel Humpherys wrote:
> The newly added DMA_ATTR_PRIVILEGED_EXECUTABLE is useful for creating
> mappings that are executable by privileged DMA engines.  Implement it in
> dma-iommu.c so that the ARM64 DMA IOMMU mapper can make use of it.
> 
> Signed-off-by: Mitchel Humpherys <mitchelh@codeaurora.org>
> ---
>  arch/arm64/mm/dma-mapping.c |  6 +++---
>  drivers/iommu/dma-iommu.c   | 15 +++++++++++----
>  include/linux/dma-iommu.h   |  3 ++-
>  3 files changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index c566ec83719f..44f676268df6 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -543,7 +543,7 @@ static void *__iommu_alloc_attrs(struct device *dev, size_t size,
>  				 struct dma_attrs *attrs)
>  {
>  	bool coherent = is_device_dma_coherent(dev);
> -	int ioprot = dma_direction_to_prot(DMA_BIDIRECTIONAL, coherent);
> +	int ioprot = dma_direction_to_prot(DMA_BIDIRECTIONAL, coherent, attrs);
>  	size_t iosize = size;
>  	void *addr;
>  
> @@ -697,7 +697,7 @@ static dma_addr_t __iommu_map_page(struct device *dev, struct page *page,
>  				   struct dma_attrs *attrs)
>  {
>  	bool coherent = is_device_dma_coherent(dev);
> -	int prot = dma_direction_to_prot(dir, coherent);
> +	int prot = dma_direction_to_prot(dir, coherent, attrs);
>  	dma_addr_t dev_addr = iommu_dma_map_page(dev, page, offset, size, prot);
>  
>  	if (!iommu_dma_mapping_error(dev, dev_addr) &&
> @@ -755,7 +755,7 @@ static int __iommu_map_sg_attrs(struct device *dev, struct scatterlist *sgl,
>  		__iommu_sync_sg_for_device(dev, sgl, nelems, dir);
>  
>  	return iommu_dma_map_sg(dev, sgl, nelems,
> -			dma_direction_to_prot(dir, coherent));
> +			dma_direction_to_prot(dir, coherent, attrs));
>  }
>  
>  static void __iommu_unmap_sg_attrs(struct device *dev,
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index ea5a9ebf0f78..ccc6219da228 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -132,23 +132,30 @@ EXPORT_SYMBOL(iommu_dma_init_domain);
>   * dma_direction_to_prot - Translate DMA API directions to IOMMU API page flags

Privilege really isn't a direction :(

If we're going to cram more into this function it really wants renaming
and redocumenting.

>   * @dir: Direction of DMA transfer
>   * @coherent: Is the DMA master cache-coherent?
> + * @attrs: DMA attributes for the mapping
>   *
>   * Return: corresponding IOMMU API page protection flags
>   */
> -int dma_direction_to_prot(enum dma_data_direction dir, bool coherent)
> +int dma_direction_to_prot(enum dma_data_direction dir, bool coherent,
> +			  struct dma_attrs *attrs)
>  {
>  	int prot = coherent ? IOMMU_CACHE : 0;
>  
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
> +	if (dma_get_attr(DMA_ATTR_PRIVILEGED_EXECUTABLE, attrs)) {
> +		prot &= ~IOMMU_WRITE;

Hey, we didn't say anything anywhere about anything being privileged
read-only! Frankly, I think this is going to create more problems that
it solves. Implementing IOMMU_PRIV as simply unprivileged no-access
should be sufficient.

Robin.

> +		prot |= IOMMU_PRIV;
> +	}
> +	return prot;
>  }
>  
>  static struct iova *__alloc_iova(struct iova_domain *iovad, size_t size,
> diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
> index 8443bbb5c071..d5a37e58d29b 100644
> --- a/include/linux/dma-iommu.h
> +++ b/include/linux/dma-iommu.h
> @@ -32,7 +32,8 @@ void iommu_put_dma_cookie(struct iommu_domain *domain);
>  int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base, u64 size);
>  
>  /* General helpers for DMA-API <-> IOMMU-API interaction */
> -int dma_direction_to_prot(enum dma_data_direction dir, bool coherent);
> +int dma_direction_to_prot(enum dma_data_direction dir, bool coherent,
> +			  struct dma_attrs *attrs);
>  
>  /*
>   * These implement the bulk of the relevant DMA mapping callbacks, but require
> 
