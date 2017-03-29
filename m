From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 29 Mar 2017 13:55:32 +0100
Subject: [PATCH] arm64/dma-mapping: fix DMA_ATTR_FORCE_CONTIGUOUS mmaping
 code
In-Reply-To: <1490781926-6209-1-git-send-email-a.hajda@samsung.com>
References: <CGME20170329100540eucas1p22d428e33aa678cbef0a24dd249820451@eucas1p2.samsung.com>
 <1490781926-6209-1-git-send-email-a.hajda@samsung.com>
Message-ID: <15b1be13-625f-db74-d213-ad1df86f7eb5@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/03/17 11:05, Andrzej Hajda wrote:
> In case of DMA_ATTR_FORCE_CONTIGUOUS allocations vm_area->pages
> is invalid. __iommu_mmap_attrs and __iommu_get_sgtable cannot use
> it. In first case temporary pages array is passed to iommu_dma_mmap,
> in 2nd case single entry sg table is created directly instead
> of calling helper.
> 
> Fixes: 44176bb ("arm64: Add support for DMA_ATTR_FORCE_CONTIGUOUS to IOMMU")
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
> Hi,
> 
> I am not familiar with this framework so please don't be too cruel ;)
> Alternative solution I see is to always create vm_area->pages,
> I do not know which approach is preferred.
> 
> Regards
> Andrzej
> ---
>  arch/arm64/mm/dma-mapping.c | 40 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 38 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index f7b5401..bba2bc8 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -704,7 +704,30 @@ static int __iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
>  		return ret;
>  
>  	area = find_vm_area(cpu_addr);
> -	if (WARN_ON(!area || !area->pages))
> +	if (WARN_ON(!area))

>From the look of things, it doesn't seem strictly necessary to change
this, but whether that's a good thing is another matter. I'm not sure
that dma_common_contiguous_remap() should really be leaving a dangling
pointer in area->pages as it apparently does... :/

> +		return -ENXIO;
> +
> +	if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
> +		struct page *page = vmalloc_to_page(cpu_addr);
> +		unsigned int count = size >> PAGE_SHIFT;
> +		struct page **pages;
> +		unsigned long pfn;
> +		int i;
> +
> +		pages = kmalloc_array(count, sizeof(*pages), GFP_KERNEL);
> +		if (!pages)
> +			return -ENOMEM;
> +
> +		for (i = 0, pfn = page_to_pfn(page); i < count; i++)
> +			pages[i] = pfn_to_page(pfn + i);
> +
> +		ret = iommu_dma_mmap(pages, size, vma);

/**
 * iommu_dma_mmap - Map a buffer into provided user VMA
 * @pages: Array representing buffer from iommu_dma_alloc()
   ...

In this case, the buffer has not come from iommu_dma_alloc(), so passing
into iommu_dma_mmap() is wrong by contract, even if having to fake up a
page array wasn't enough of a red flag. Given that a FORCE_CONTIGUOUS
allocation is essentially the same as for the non-IOMMU case, I think it
should be sufficient to defer to that path, i.e.:

	if (attrs & DMA_ATTR_FORCE_CONTIGUOUS)
		return __swiotlb_mmap(dev, vma, cpu_addr,
				phys_to_dma(virt_to_phys(cpu_addr)),
				size, attrs);

> +		kfree(pages);
> +
> +		return ret;
> +	}
> +
> +	if (WARN_ON(!area->pages))
>  		return -ENXIO;
>  
>  	return iommu_dma_mmap(area->pages, size, vma);
> @@ -717,7 +740,20 @@ static int __iommu_get_sgtable(struct device *dev, struct sg_table *sgt,
>  	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
>  	struct vm_struct *area = find_vm_area(cpu_addr);
>  
> -	if (WARN_ON(!area || !area->pages))
> +	if (WARN_ON(!area))
> +		return -ENXIO;
> +
> +	if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
> +		int ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
> +
> +		if (!ret)
> +			sg_set_page(sgt->sgl, vmalloc_to_page(cpu_addr),
> +				PAGE_ALIGN(size), 0);
> +
> +		return ret;
> +	}

As above, this may as well just go straight to the non-IOMMU version,
although I agree with Russell's concerns[1] that in general is is not
safe to assume a coherent allocation is backed by struct pages at all.

Robin.

[1]:http://lists.infradead.org/pipermail/linux-arm-kernel/2017-March/496068.html

> +
> +	if (WARN_ON(!area->pages))
>  		return -ENXIO;
>  
>  	return sg_alloc_table_from_pages(sgt, area->pages, count, 0, size,
> 
