From: mina86@mina86.com (Michal Nazarewicz)
Date: Fri, 25 Nov 2011 22:08:16 +0100
Subject: [PATCH] mm: cma: hack/workaround for some allocation issues
In-Reply-To: <1322239387-31394-1-git-send-email-m.szyprowski@samsung.com>
References: <1321634598-16859-1-git-send-email-m.szyprowski@samsung.com>
 <1322239387-31394-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <op.v5isz2nh3l0zgt@mpn-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 25 Nov 2011 17:43:07 +0100, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> This is a quick and dirty patch and hack to solve some memory allocation
> issues that appeared at CMA v17 after switching migration code from
> hotplug to memory compaction. Especially the issue with watermark
> adjustment need a real fix instead of disabling the code.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>
> Hello,
>
> This patch fixes the issues that have been reported recently. It should
> be considered only as a temporary solution until a new version of CMA
> patches is ready.
>
> Best regards
> --
> Marek Szyprowski
> Samsung Poland R&D Center
>
> ---
>  mm/compaction.c |    5 ++++-
>  mm/page_alloc.c |   12 +++++++++---
>  2 files changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 3e07341..41976f8 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -79,8 +79,9 @@ isolate_freepages_range(struct zone *zone,
>  skip:
>  			if (freelist)
>  				goto next;
> +failed:
>  			for (; start < pfn; ++start)
> -				__free_page(pfn_to_page(pfn));
> +				__free_page(pfn_to_page(start));
>  			return 0;
>  		}

Yeah, my mistake, sorry about that. ;)


> @@ -91,6 +92,8 @@ skip:
>  			struct page *p = page;
>  			for (i = isolated; i; --i, ++p)
>  				list_add(&p->lru, freelist);
> +		} else if (!isolated) {
> +			goto failed;
>  		}
> next:
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 714b1c1..b4a46c7 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1303,12 +1303,12 @@ int split_free_page(struct page *page)
> 	zone = page_zone(page);
>  	order = page_order(page);
> -
> +#if 0
>  	/* Obey watermarks as if the page was being allocated */
>  	watermark = low_wmark_pages(zone) + (1 << order);
>  	if (!zone_watermark_ok(zone, 0, watermark, 0, 0))
>  		return 0;
> -
> +#endif
>  	/* Remove page from free list */
>  	list_del(&page->lru);
>  	zone->free_area[order].nr_free--;

Come to think of it, this watermark check seem a little meaningless in case of
CMA.  With CMA the pages that we are splitting here have migrate type ISOLATE
so they aren't ?free? at all.  Buddy will never use them for allocation.  That
means that we don't really allocate any pages, we just want to split them into
order-0 pages.

Also, if we bail out now, it's a huge waste of time and efforts.

So, if the watermarks need to be checked, they should somewhere before we do
migration and stuff.  This may be due to my ignorance, but I don't know whether
we really need the watermark check if we decide to use plain alloc_page() as
allocator for migrate_pages() rather then compaction_alloc().

> @@ -5734,6 +5734,12 @@ static unsigned long pfn_align_to_maxpage_up(unsigned long pfn)
>  	return ALIGN(pfn, MAX_ORDER_NR_PAGES);
>  }
>+static struct page *
> +cma_migrate_alloc(struct page *page, unsigned long private, int **x)
> +{
> +	return alloc_page(GFP_HIGHUSER_MOVABLE);
> +}
> +
>  static int __alloc_contig_migrate_range(unsigned long start, unsigned long end)
>  {
>  	/* This function is based on compact_zone() from compaction.c. */
> @@ -5801,7 +5807,7 @@ static int __alloc_contig_migrate_range(unsigned long start, unsigned long end)
>  		}
> 		/* Try to migrate. */
> -		ret = migrate_pages(&cc.migratepages, compaction_alloc,
> +		ret = migrate_pages(&cc.migratepages, cma_migrate_alloc,
>  				    (unsigned long)&cc, false, cc.sync);
> 		/* Migrated all of them? Great! */

Yep, that makes sense to me.  compaction_alloc() takes only free pages (ie. pages
 from buddy system) from given zone.  This means that no pages get discarded or
swapped to disk.  This makes sense for compaction since it's opportunistic in its
nature.  We, however, want pages to be discarded/swapped if that's the only way of
getting pages to migrate to.

Of course, with this change the ?(unsigneg long)&cc? part can be safely replaced
with ?NULL? and ?cc.nr_freepages -= release_freepages(&cc.freepages);? at the end
of the function (not visible in this patch) with the next line removed.

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Micha? ?mina86? Nazarewicz    (o o)
ooo +----<email/xmpp: mpn@google.com>--------------ooO--(_)--Ooo--
