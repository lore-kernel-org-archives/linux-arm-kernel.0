From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 22 Feb 2012 17:26:43 +0100
Subject: [PATCHv22 13/16] drivers: add Contiguous Memory Allocator
In-Reply-To: <alpine.DEB.2.00.1202212121560.962@localhost>
References: <1329507036-24362-1-git-send-email-m.szyprowski@samsung.com>
 <1329507036-24362-14-git-send-email-m.szyprowski@samsung.com>
 <alpine.DEB.2.00.1202212121560.962@localhost>
Message-ID: <000001ccf17e$c3e50040$4baf00c0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tuesday, February 21, 2012 10:30 PM Aaro Koskinen wrote:

> On Fri, 17 Feb 2012, Marek Szyprowski wrote:
> > +/**
> > + * dma_release_from_contiguous() - release allocated pages
> > + * @dev:   Pointer to device for which the pages were allocated.
> > + * @pages: Allocated pages.
> > + * @count: Number of allocated pages.
> > + *
> > + * This function releases memory allocated by dma_alloc_from_contiguous().
> > + * It returns false when provided pages do not belong to contiguous area and
> > + * true otherwise.
> > + */
> > +bool dma_release_from_contiguous(struct device *dev, struct page *pages,
> > +				 int count)
> > +{
> > +	struct cma *cma = dev_get_cma_area(dev);
> > +	unsigned long pfn;
> > +
> > +	if (!cma || !pages)
> > +		return false;
> > +
> > +	pr_debug("%s(page %p)\n", __func__, (void *)pages);
> > +
> > +	pfn = page_to_pfn(pages);
> > +
> > +	if (pfn < cma->base_pfn || pfn >= cma->base_pfn + cma->count)
> > +		return false;
> > +
> > +	VM_BUG_ON(pfn + count > cma->base_pfn);
> 
> Are you sure the VM_BUG_ON() condition is correct here?

Thanks for pointing this bug. '+ cma->count' is missing in the second part.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
