From: mel@csn.ul.ie (Mel Gorman)
Date: Mon, 30 Jan 2012 14:52:30 +0000
Subject: [PATCH 08/15] mm: mmzone: MIGRATE_CMA migration type added
In-Reply-To: <op.v8wepotk3l0zgt@mpn-glaptop>
References: <1327568457-27734-1-git-send-email-m.szyprowski@samsung.com>
 <1327568457-27734-9-git-send-email-m.szyprowski@samsung.com>
 <20120130123542.GL25268@csn.ul.ie> <op.v8wepotk3l0zgt@mpn-glaptop>
Message-ID: <20120130145230.GQ25268@csn.ul.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2012 at 02:06:50PM +0100, Michal Nazarewicz wrote:
> >>@@ -1017,11 +1049,14 @@ __rmqueue_fallback(struct zone *zone, int order, int start_migratetype)
> >> 			rmv_page_order(page);
> >>
> >> 			/* Take ownership for orders >= pageblock_order */
> >>-			if (current_order >= pageblock_order)
> >>+			if (current_order >= pageblock_order &&
> >>+			    !is_pageblock_cma(page))
> >> 				change_pageblock_range(page, current_order,
> >> 							start_migratetype);
> >>
> >>-			expand(zone, page, order, current_order, area, migratetype);
> >>+			expand(zone, page, order, current_order, area,
> >>+			       is_migrate_cma(start_migratetype)
> >>+			     ? start_migratetype : migratetype);
> >>
> >
> >What is this check meant to be doing?
> >
> >start_migratetype is determined by allocflags_to_migratetype() and
> >that never will be MIGRATE_CMA so is_migrate_cma(start_migratetype)
> >should always be false.
> 
> Right, thanks!  This should be the other way around, ie.:
> 
> +			expand(zone, page, order, current_order, area,
> +			       is_migrate_cma(migratetype)
> +			     ? migratetype : start_migratetype);
> 
> I'll fix this and the calls to is_pageblock_cma().
> 

That makes a lot more sense. Thanks.

I have a vague recollection that there was a problem with finding
unmovable pages in MIGRATE_CMA regions. This might have been part of
the problem.

-- 
Mel Gorman
SUSE Labs
