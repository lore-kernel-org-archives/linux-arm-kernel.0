From: mel@csn.ul.ie (Mel Gorman)
Date: Mon, 12 Dec 2011 15:51:43 +0000
Subject: [PATCH 03/11] mm: mmzone: introduce zone_pfn_same_memmap()
In-Reply-To: <op.v6dswtfw3l0zgt@mpn-glaptop>
References: <1321634598-16859-1-git-send-email-m.szyprowski@samsung.com>
 <1321634598-16859-4-git-send-email-m.szyprowski@samsung.com>
 <20111212141953.GD3277@csn.ul.ie> <op.v6dr4pj43l0zgt@mpn-glaptop>
 <20111212144030.GF3277@csn.ul.ie> <op.v6dswtfw3l0zgt@mpn-glaptop>
Message-ID: <20111212155143.GJ3277@csn.ul.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 12, 2011 at 03:51:55PM +0100, Michal Nazarewicz wrote:
> >On Fri, Nov 18, 2011 at 05:43:10PM +0100, Marek Szyprowski wrote:
> >>From: Michal Nazarewicz <mina86@mina86.com>
> >>diff --git a/mm/compaction.c b/mm/compaction.c
> >>index 6afae0e..09c9702 100644
> >>--- a/mm/compaction.c
> >>+++ b/mm/compaction.c
> >>@@ -111,7 +111,10 @@ skip:
> >>
> >> next:
> >> 		pfn += isolated;
> >>-		page += isolated;
> >>+		if (zone_pfn_same_memmap(pfn - isolated, pfn))
> >>+			page += isolated;
> >>+		else
> >>+			page = pfn_to_page(pfn);
> >> 	}
> 
> On Mon, 12 Dec 2011 15:19:53 +0100, Mel Gorman <mel@csn.ul.ie> wrote:
> >Is this necessary?
> >
> >We are isolating pages, the largest of which is a MAX_ORDER_NR_PAGES
> >page.  [...]
> 
> On Mon, 12 Dec 2011 15:40:30 +0100, Mel Gorman <mel@csn.ul.ie> wrote:
> >To be clear, I'm referring to a single page being isolated here. It may
> >or may not be a high-order page but it's still going to be less then
> >MAX_ORDER_NR_PAGES so you should be able check when a new block is
> >entered and pfn_to_page is necessary.
> 
> Do you mean something like:
> 
> if (same pageblock)
> 	just do arithmetic;
> else
> 	use pfn_to_page;
> 

something like the following untested snippet.

/*
 * Resolve pfn_to_page every MAX_ORDER_NR_PAGES to handle the case where
 * memmap is not contiguous such as with SPARSEMEM memory model without
 * VMEMMAP
 */
pfn += isolated;
page += isolated;
if ((pfn & ~(MAX_ORDER_NR_PAGES-1)) == 0)
	page = pfn_to_page(pfn);

That would be closer to what other PFN walkers do

> ?
> 
> I've discussed it with Dave and he suggested that approach as an
> optimisation since in some configurations zone_pfn_same_memmap()
> is always true thus compiler will strip the else part, whereas
> same pageblock test will be false on occasions regardless of kernel
> configuration.
> 

Ok, while I recognise it's an optimisation, it's a very small
optimisation and I'm not keen on introducing something new for
CMA that has been coped with in the past by always walking PFNs in
pageblock-sized ranges with pfn_valid checks where necessary.

See setup_zone_migrate_reserve as one example where pfn_to_page is
only called once per pageblock and calls pageblock_is_reserved()
for examining pages within a pageblock. Still, if you really want
the helper, at least keep it in compaction.c as there should be no
need to have it in mmzone.h

-- 
Mel Gorman
SUSE Labs
