From: mel@csn.ul.ie (Mel Gorman)
Date: Mon, 30 Jan 2012 11:55:48 +0000
Subject: [PATCH 04/15] mm: compaction: introduce isolate_freepages_range()
In-Reply-To: <20120130114820.GG25268@csn.ul.ie>
References: <1327568457-27734-1-git-send-email-m.szyprowski@samsung.com>
 <1327568457-27734-5-git-send-email-m.szyprowski@samsung.com>
 <20120130114820.GG25268@csn.ul.ie>
Message-ID: <20120130115548.GH25268@csn.ul.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2012 at 11:48:20AM +0000, Mel Gorman wrote:
> > +		if (!zone)
> > +			zone = page_zone(pfn_to_page(pfn));
> > +		else if (zone != page_zone(pfn_to_page(pfn)))
> > +			break;
> > +
> 
> So what you are checking for here is if you straddle zones.
> You could just initialise zone outside of the for loop. You can
> then check outside the loop if end_pfn is in a different zone to
> start_pfn. If it is, either adjust end_pfn accordingly or bail the
> entire operation avoiding the need for release_freepages() later. This
> will be a little cheaper.
> 

Whoops, silly me! You are watching for overlapping zones which can
happen in some rare configurations and for that checking page_zone()
like this is necessary. You can still initialise zone outside the loop
but the page_zone() check is still necessary.

My bad.

-- 
Mel Gorman
SUSE Labs
