From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 8 Jun 2017 14:59:07 +0100
Subject: [PATCH 06/44] iommu/dma: don't rely on DMA_ERROR_CODE
In-Reply-To: <20170608132609.32662-7-hch@lst.de>
References: <20170608132609.32662-1-hch@lst.de>
 <20170608132609.32662-7-hch@lst.de>
Message-ID: <0bfb0841-f054-78de-628d-a0955336bcb4@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoph,

On 08/06/17 14:25, Christoph Hellwig wrote:
> DMA_ERROR_CODE is not a public API and will go away soon.  dma dma-iommu
> driver already implements a proper ->mapping_error method, so it's only
> using the value internally.  Add a new local define using the value
> that arm64 which is the only current user of dma-iommu.

It would be fine to just use 0, since dma-iommu already makes sure that
that will never be allocated for a valid DMA address.

Otherwise, looks good!

Robin.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/iommu/dma-iommu.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 62618e77bedc..638aea814b94 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -31,6 +31,8 @@
>  #include <linux/scatterlist.h>
>  #include <linux/vmalloc.h>
>  
> +#define IOMMU_MAPPING_ERROR	(~(dma_addr_t)0)
> +
>  struct iommu_dma_msi_page {
>  	struct list_head	list;
>  	dma_addr_t		iova;
> @@ -500,7 +502,7 @@ void iommu_dma_free(struct device *dev, struct page **pages, size_t size,
>  {
>  	__iommu_dma_unmap(iommu_get_domain_for_dev(dev), *handle, size);
>  	__iommu_dma_free_pages(pages, PAGE_ALIGN(size) >> PAGE_SHIFT);
> -	*handle = DMA_ERROR_CODE;
> +	*handle = IOMMU_MAPPING_ERROR;
>  }
>  
>  /**
> @@ -533,7 +535,7 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
>  	dma_addr_t iova;
>  	unsigned int count, min_size, alloc_sizes = domain->pgsize_bitmap;
>  
> -	*handle = DMA_ERROR_CODE;
> +	*handle = IOMMU_MAPPING_ERROR;
>  
>  	min_size = alloc_sizes & -alloc_sizes;
>  	if (min_size < PAGE_SIZE) {
> @@ -627,11 +629,11 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
>  
>  	iova = iommu_dma_alloc_iova(domain, size, dma_get_mask(dev), dev);
>  	if (!iova)
> -		return DMA_ERROR_CODE;
> +		return IOMMU_MAPPING_ERROR;
>  
>  	if (iommu_map(domain, iova, phys - iova_off, size, prot)) {
>  		iommu_dma_free_iova(cookie, iova, size);
> -		return DMA_ERROR_CODE;
> +		return IOMMU_MAPPING_ERROR;
>  	}
>  	return iova + iova_off;
>  }
> @@ -671,7 +673,7 @@ static int __finalise_sg(struct device *dev, struct scatterlist *sg, int nents,
>  
>  		s->offset += s_iova_off;
>  		s->length = s_length;
> -		sg_dma_address(s) = DMA_ERROR_CODE;
> +		sg_dma_address(s) = IOMMU_MAPPING_ERROR;
>  		sg_dma_len(s) = 0;
>  
>  		/*
> @@ -714,11 +716,11 @@ static void __invalidate_sg(struct scatterlist *sg, int nents)
>  	int i;
>  
>  	for_each_sg(sg, s, nents, i) {
> -		if (sg_dma_address(s) != DMA_ERROR_CODE)
> +		if (sg_dma_address(s) != IOMMU_MAPPING_ERROR)
>  			s->offset += sg_dma_address(s);
>  		if (sg_dma_len(s))
>  			s->length = sg_dma_len(s);
> -		sg_dma_address(s) = DMA_ERROR_CODE;
> +		sg_dma_address(s) = IOMMU_MAPPING_ERROR;
>  		sg_dma_len(s) = 0;
>  	}
>  }
> @@ -836,7 +838,7 @@ void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
>  
>  int iommu_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
>  {
> -	return dma_addr == DMA_ERROR_CODE;
> +	return dma_addr == IOMMU_MAPPING_ERROR;
>  }
>  
>  static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
> 
