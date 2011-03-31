From: dave@linux.vnet.ibm.com (Dave Hansen)
Date: Thu, 31 Mar 2011 08:58:03 -0700
Subject: [PATCH 04/12] mm: alloc_contig_freed_pages() added
In-Reply-To: <1301577368-16095-5-git-send-email-m.szyprowski@samsung.com>
References: <1301577368-16095-1-git-send-email-m.szyprowski@samsung.com>
	<1301577368-16095-5-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1301587083.31087.1032.camel@nimitz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-03-31 at 15:16 +0200, Marek Szyprowski wrote:
> 
> +unsigned long alloc_contig_freed_pages(unsigned long start, unsigned long end,
> +                                      gfp_t flag)
> +{
> +       unsigned long pfn = start, count;
> +       struct page *page;
> +       struct zone *zone;
> +       int order;
> +
> +       VM_BUG_ON(!pfn_valid(start));

This seems kinda mean.  Could we return an error?  I understand that
this is largely going to be an early-boot thing, but surely trying to
punt on crappy input beats a full-on BUG().

	if (!pfn_valid(start))
		return -1;

> +       zone = page_zone(pfn_to_page(start));
> +
> +       spin_lock_irq(&zone->lock);
> +
> +       page = pfn_to_page(pfn);
> +       for (;;) {
> +               VM_BUG_ON(page_count(page) || !PageBuddy(page));
> +               list_del(&page->lru);
> +               order = page_order(page);
> +               zone->free_area[order].nr_free--;
> +               rmv_page_order(page);
> +               __mod_zone_page_state(zone, NR_FREE_PAGES, -(1UL << order));
> +               pfn  += 1 << order;
> +               if (pfn >= end)
> +                       break;

If start->end happens to span the end of a zone, I believe this will
jump out of the zone.  It will still be pfn_valid(), but potentially not
in the same zone. 

> +               VM_BUG_ON(!pfn_valid(pfn));
> +               page += 1 << order;
> +       }

That will break on SPARSEMEM.  You potentially need to revalidate the
pfn->page mapping on every MAX_ORDER pfn change.  It's easiest to just
do pfn_to_page() on each loop.

> +
> +       spin_unlock_irq(&zone->lock); 
> 
> +void free_contig_pages(struct page *page, int nr_pages)
> +{
> +       for (; nr_pages; --nr_pages, ++page)
> +               __free_page(page);
> +}

Can't help but notice that this resembles a bit of a patch I posted last
week:

http://www.spinics.net/lists/linux-mm/msg16364.html

We'll have to make sure we only have one copy of this in the end.

-- Dave
