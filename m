From: mel@csn.ul.ie (Mel Gorman)
Date: Mon, 12 Dec 2011 14:42:29 +0000
Subject: [PATCH 01/11] mm: page_alloc: handle MIGRATE_ISOLATE in
 free_pcppages_bulk()
In-Reply-To: <op.v6drko0p3l0zgt@mpn-glaptop>
References: <1321634598-16859-1-git-send-email-m.szyprowski@samsung.com>
 <1321634598-16859-2-git-send-email-m.szyprowski@samsung.com>
 <20111212134235.GB3277@csn.ul.ie> <op.v6drko0p3l0zgt@mpn-glaptop>
Message-ID: <20111212144229.GH3277@csn.ul.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 12, 2011 at 03:23:02PM +0100, Michal Nazarewicz wrote:
> >On Fri, Nov 18, 2011 at 05:43:08PM +0100, Marek Szyprowski wrote:
> >>From: Michal Nazarewicz <mina86@mina86.com>
> >>diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> >>index 9dd443d..58d1a2e 100644
> >>--- a/mm/page_alloc.c
> >>+++ b/mm/page_alloc.c
> >>@@ -628,6 +628,18 @@ static void free_pcppages_bulk(struct zone *zone, int count,
> >> 			page = list_entry(list->prev, struct page, lru);
> >> 			/* must delete as __free_one_page list manipulates */
> >> 			list_del(&page->lru);
> >>+
> >>+			/*
> >>+			 * When page is isolated in set_migratetype_isolate()
> >>+			 * function it's page_private is not changed since the
> >>+			 * function has no way of knowing if it can touch it.
> >>+			 * This means that when a page is on PCP list, it's
> >>+			 * page_private no longer matches the desired migrate
> >>+			 * type.
> >>+			 */
> >>+			if (get_pageblock_migratetype(page) == MIGRATE_ISOLATE)
> >>+				set_page_private(page, MIGRATE_ISOLATE);
> >>+
> 
> On Mon, 12 Dec 2011 14:42:35 +0100, Mel Gorman <mel@csn.ul.ie> wrote:
> >How much of a problem is this in practice?
> 
> IIRC, this lead to allocation being made from area marked as isolated
> or some such.
> 

And I believe that nothing prevents that from happening. I was just
wondering how common it was in practice. Draining the per-cpu lists
should work as a substitute either way.

-- 
Mel Gorman
SUSE Labs
