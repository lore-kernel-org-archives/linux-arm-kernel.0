From: mel@csn.ul.ie (Mel Gorman)
Date: Mon, 12 Dec 2011 14:40:30 +0000
Subject: [PATCH 03/11] mm: mmzone: introduce zone_pfn_same_memmap()
In-Reply-To: <op.v6dr4pj43l0zgt@mpn-glaptop>
References: <1321634598-16859-1-git-send-email-m.szyprowski@samsung.com>
 <1321634598-16859-4-git-send-email-m.szyprowski@samsung.com>
 <20111212141953.GD3277@csn.ul.ie> <op.v6dr4pj43l0zgt@mpn-glaptop>
Message-ID: <20111212144030.GF3277@csn.ul.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 12, 2011 at 03:35:03PM +0100, Michal Nazarewicz wrote:
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
> This is not true for CMA.
> 

To be clear, I'm referring to a single page being isolated here. It may
or may not be a high-order page but it's still going to be less then
MAX_ORDER_NR_PAGES so you should be able check when a new block is
entered and pfn_to_page is necessary.

-- 
Mel Gorman
SUSE Labs
