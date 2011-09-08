From: dave@linux.vnet.ibm.com (Dave Hansen)
Date: Thu, 08 Sep 2011 11:05:52 -0700
Subject: [PATCH 2/8] mm: alloc_contig_freed_pages() added
In-Reply-To: <1313764064-9747-3-git-send-email-m.szyprowski@samsung.com>
References: <1313764064-9747-1-git-send-email-m.szyprowski@samsung.com>
	<1313764064-9747-3-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1315505152.3114.9.camel@nimitz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-08-19 at 16:27 +0200, Marek Szyprowski wrote:
> +unsigned long alloc_contig_freed_pages(unsigned long start, unsigned long end,
> +				       gfp_t flag)
> +{
> +	unsigned long pfn = start, count;
> +	struct page *page;
> +	struct zone *zone;
> +	int order;
> +
> +	VM_BUG_ON(!pfn_valid(start));
> +	zone = page_zone(pfn_to_page(start));

This implies that start->end are entirely contained in a single zone.
What enforces that?  If some higher layer enforces that, I think we
probably need at least a VM_BUG_ON() in here and a comment about who
enforces it.

> +	spin_lock_irq(&zone->lock);
> +
> +	page = pfn_to_page(pfn);
> +	for (;;) {
> +		VM_BUG_ON(page_count(page) || !PageBuddy(page));
> +		list_del(&page->lru);
> +		order = page_order(page);
> +		zone->free_area[order].nr_free--;
> +		rmv_page_order(page);
> +		__mod_zone_page_state(zone, NR_FREE_PAGES, -(1UL << order));
> +		pfn  += 1 << order;
> +		if (pfn >= end)
> +			break;
> +		VM_BUG_ON(!pfn_valid(pfn));
> +		page += 1 << order;
> +	}

This 'struct page *'++ stuff is OK, but only for small, aligned areas.
For at least some of the sparsemem modes (non-VMEMMAP), you could walk
off of the end of the section_mem_map[] when you cross a MAX_ORDER
boundary.  I'd feel a little bit more comfortable if pfn_to_page() was
being done each time, or only occasionally when you cross a section
boundary.

This may not apply to what ARM is doing today, but it shouldn't be too
difficult to fix up, or to document what's going on.

> +	spin_unlock_irq(&zone->lock);
> +
> +	/* After this, pages in the range can be freed one be one */
> +	page = pfn_to_page(start);
> +	for (count = pfn - start; count; --count, ++page)
> +		prep_new_page(page, 0, flag);
> +
> +	return pfn;
> +}
> +
> +void free_contig_pages(struct page *page, int nr_pages)
> +{
> +	for (; nr_pages; --nr_pages, ++page)
> +		__free_page(page);
> +}

The same thing about 'struct page' pointer math goes here.

-- Dave
