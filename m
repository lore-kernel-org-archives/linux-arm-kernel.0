From: konrad.wilk@oracle.com (Konrad Rzeszutek Wilk)
Date: Thu, 18 Oct 2018 20:25:35 -0400
Subject: [PATCH 05/10] swiotlb: merge swiotlb_unmap_page and unmap_single
In-Reply-To: <20181008080246.20543-6-hch@lst.de>
References: <20181008080246.20543-1-hch@lst.de>
 <20181008080246.20543-6-hch@lst.de>
Message-ID: <20181019002535.GG1251@char.us.oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 08, 2018 at 10:02:41AM +0200, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Thank you!
> ---
>  kernel/dma/swiotlb.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 11dbcd80b4a6..15335f3a1bf3 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -765,9 +765,9 @@ dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
>   * After this call, reads by the cpu to the buffer are guaranteed to see
>   * whatever the device wrote there.
>   */
> -static void unmap_single(struct device *hwdev, dma_addr_t dev_addr,
> -			 size_t size, enum dma_data_direction dir,
> -			 unsigned long attrs)
> +void swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
> +			size_t size, enum dma_data_direction dir,
> +			unsigned long attrs)
>  {
>  	phys_addr_t paddr = dma_to_phys(hwdev, dev_addr);
>  
> @@ -790,13 +790,6 @@ static void unmap_single(struct device *hwdev, dma_addr_t dev_addr,
>  	dma_mark_clean(phys_to_virt(paddr), size);
>  }
>  
> -void swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
> -			size_t size, enum dma_data_direction dir,
> -			unsigned long attrs)
> -{
> -	unmap_single(hwdev, dev_addr, size, dir, attrs);
> -}
> -
>  /*
>   * Make physical memory consistent for a single streaming mode DMA translation
>   * after a transfer.
> @@ -900,7 +893,7 @@ swiotlb_unmap_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
>  	BUG_ON(dir == DMA_NONE);
>  
>  	for_each_sg(sgl, sg, nelems, i)
> -		unmap_single(hwdev, sg->dma_address, sg_dma_len(sg), dir,
> +		swiotlb_unmap_page(hwdev, sg->dma_address, sg_dma_len(sg), dir,
>  			     attrs);
>  }
>  
> -- 
> 2.19.0
> 
