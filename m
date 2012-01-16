From: mel@csn.ul.ie (Mel Gorman)
Date: Mon, 16 Jan 2012 09:01:10 +0000
Subject: [PATCH 04/11] mm: page_alloc: introduce alloc_contig_range()
In-Reply-To: <op.v71gpt1b3l0zgt@mpn-glaptop>
References: <1325162352-24709-1-git-send-email-m.szyprowski@samsung.com>
 <1325162352-24709-5-git-send-email-m.szyprowski@samsung.com>
 <20120110141613.GB3910@csn.ul.ie> <op.v71gpt1b3l0zgt@mpn-glaptop>
Message-ID: <20120116090110.GA2929@csn.ul.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2012 at 09:04:31PM +0100, Michal Nazarewicz wrote:
> >On Thu, Dec 29, 2011 at 01:39:05PM +0100, Marek Szyprowski wrote:
> >>From: Michal Nazarewicz <mina86@mina86.com>
> >>+	/* Make sure all pages are isolated. */
> >>+	if (!ret) {
> >>+		lru_add_drain_all();
> >>+		drain_all_pages();
> >>+		if (WARN_ON(test_pages_isolated(start, end)))
> >>+			ret = -EBUSY;
> >>+	}
> 
> On Tue, 10 Jan 2012 15:16:13 +0100, Mel Gorman <mel@csn.ul.ie> wrote:
> >Another global IPI seems overkill. Drain pages only from the local CPU
> >(drain_pages(get_cpu()); put_cpu()) and test if the pages are isolated.
> 
> Is get_cpu() + put_cpu() required? Won't drain_local_pages() work?
> 

drain_local_pages() calls smp_processor_id() without preemption
disabled. 

-- 
Mel Gorman
SUSE Labs
