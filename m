From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Tue, 21 Feb 2012 21:30:07 +0000 (UTC)
Subject: [PATCHv22 13/16] drivers: add Contiguous Memory Allocator
In-Reply-To: <1329507036-24362-14-git-send-email-m.szyprowski@samsung.com>
References: <1329507036-24362-1-git-send-email-m.szyprowski@samsung.com>
 <1329507036-24362-14-git-send-email-m.szyprowski@samsung.com>
Message-ID: <alpine.DEB.2.00.1202212121560.962@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, 17 Feb 2012, Marek Szyprowski wrote:
> +/**
> + * dma_release_from_contiguous() - release allocated pages
> + * @dev:   Pointer to device for which the pages were allocated.
> + * @pages: Allocated pages.
> + * @count: Number of allocated pages.
> + *
> + * This function releases memory allocated by dma_alloc_from_contiguous().
> + * It returns false when provided pages do not belong to contiguous area and
> + * true otherwise.
> + */
> +bool dma_release_from_contiguous(struct device *dev, struct page *pages,
> +				 int count)
> +{
> +	struct cma *cma = dev_get_cma_area(dev);
> +	unsigned long pfn;
> +
> +	if (!cma || !pages)
> +		return false;
> +
> +	pr_debug("%s(page %p)\n", __func__, (void *)pages);
> +
> +	pfn = page_to_pfn(pages);
> +
> +	if (pfn < cma->base_pfn || pfn >= cma->base_pfn + cma->count)
> +		return false;
> +
> +	VM_BUG_ON(pfn + count > cma->base_pfn);

Are you sure the VM_BUG_ON() condition is correct here?

> +	mutex_lock(&cma_mutex);
> +	bitmap_clear(cma->bitmap, pfn - cma->base_pfn, count);
> +	free_contig_range(pfn, count);
> +	mutex_unlock(&cma_mutex);
> +
> +	return true;
> +}

A.
