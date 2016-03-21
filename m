From: will.deacon@arm.com (Will Deacon)
Date: Mon, 21 Mar 2016 18:01:47 +0000
Subject: [PATCH] arm64/dma-mapping: Add DMA_ATTR_ALLOC_SINGLE_PAGES support
In-Reply-To: <1456944866-15990-1-git-send-email-yong.wu@mediatek.com>
References: <1456944866-15990-1-git-send-email-yong.wu@mediatek.com>
Message-ID: <20160321180147.GR23397@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 03, 2016 at 02:54:26AM +0800, Yong Wu wrote:
> Sometimes it is not worth for the iommu allocating big chunks.
> Here we enable DMA_ATTR_ALLOC_SINGLE_PAGES which could help avoid to
> allocate big chunks while iommu allocating buffer.
> 
> More information about this attribute, please check Doug's commit[1].
> 
> [1]: https://lkml.org/lkml/2016/1/11/720
> 
> Cc: Robin Murphy <robin.murphy@arm.com>
> Suggested-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
> 
> Our video drivers may soon use this.
> 
>  arch/arm64/mm/dma-mapping.c |  4 ++--
>  drivers/iommu/dma-iommu.c   | 14 ++++++++++----
>  include/linux/dma-iommu.h   |  4 ++--
>  3 files changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index 331c4ca..3225e3ca 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -562,8 +562,8 @@ static void *__iommu_alloc_attrs(struct device *dev, size_t size,
>  		struct page **pages;
>  		pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL, coherent);
>  
> -		pages = iommu_dma_alloc(dev, iosize, gfp, ioprot, handle,
> -					flush_page);
> +		pages = iommu_dma_alloc(dev, iosize, gfp, ioprot, attrs,
> +					handle, flush_page);
>  		if (!pages)
>  			return NULL;
>  
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 72d6182..3569cb6 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -190,7 +190,8 @@ static void __iommu_dma_free_pages(struct page **pages, int count)
>  	kvfree(pages);
>  }
>  
> -static struct page **__iommu_dma_alloc_pages(unsigned int count, gfp_t gfp)
> +static struct page **__iommu_dma_alloc_pages(unsigned int count, gfp_t gfp,
> +					     struct dma_attrs *attrs)
>  {
>  	struct page **pages;
>  	unsigned int i = 0, array_size = count * sizeof(*pages);
> @@ -203,6 +204,10 @@ static struct page **__iommu_dma_alloc_pages(unsigned int count, gfp_t gfp)
>  	if (!pages)
>  		return NULL;
>  
> +	/* Go straight to 4K chunks if caller says it's OK. */
> +	if (dma_get_attr(DMA_ATTR_ALLOC_SINGLE_PAGES, attrs))
> +		order = 0;

I have a slight snag with this, in that you don't consult the IOMMU
pgsize_bitmap at any point, and assume that it can map pages at the
same granularity as the CPU. The documentation for
DMA_ATTR_ALLOC_SINGLE_PAGES seems to be weaker than that.

Will
