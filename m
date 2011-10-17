From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 17 Oct 2011 14:21:07 +0200
Subject: [PATCH 2/9] mm: alloc_contig_freed_pages() added
In-Reply-To: <20111014162933.d8fead58.akpm@linux-foundation.org>
References: <1317909290-29832-1-git-send-email-m.szyprowski@samsung.com>
	<1317909290-29832-3-git-send-email-m.szyprowski@samsung.com>
	<20111014162933.d8fead58.akpm@linux-foundation.org>
Message-ID: <01b201cc8cc7$3f6117d0$be234770$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Andrew,

Thanks for your comments. I will try to address them in the next round of
CMA patches.

On Saturday, October 15, 2011 1:30 AM Andrew Morton wrote:

(snipped)

> > +
> > +void free_contig_pages(unsigned long pfn, unsigned nr_pages)
> > +{
> > +	struct page *page = pfn_to_page(pfn);
> > +
> > +	while (nr_pages--) {
> > +		__free_page(page);
> > +		++pfn;
> > +		if (likely(zone_pfn_same_memmap(pfn - 1, pfn)))
> > +			++page;
> > +		else
> > +			page = pfn_to_page(pfn);
> > +	}
> > +}
> 
> You're sure these functions don't need EXPORT_SYMBOL()?  Maybe the
> design is that only DMA core calls into here (if so, that's good).

Drivers should not call it, it is intended to be used by low-level DMA
code. Do you think that a comment about missing EXPORT_SYMBOL is 
required?

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
