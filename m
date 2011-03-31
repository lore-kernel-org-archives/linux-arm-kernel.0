From: dave@linux.vnet.ibm.com (Dave Hansen)
Date: Thu, 31 Mar 2011 14:14:38 -0700
Subject: [PATCH 04/12] mm: alloc_contig_freed_pages() added
In-Reply-To: <op.vs77qfx03l0zgt@mnazarewicz-glaptop>
References: <1301577368-16095-1-git-send-email-m.szyprowski@samsung.com>
	<1301577368-16095-5-git-send-email-m.szyprowski@samsung.com>
	<1301587083.31087.1032.camel@nimitz>
	<op.vs77qfx03l0zgt@mnazarewicz-glaptop>
Message-ID: <1301606078.31087.1275.camel@nimitz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-03-31 at 23:09 +0200, Michal Nazarewicz wrote:
> On Thu, 31 Mar 2011 17:58:03 +0200, Dave Hansen <dave@linux.vnet.ibm.com>  
> wrote:
> > On Thu, 2011-03-31 at 15:16 +0200, Marek Szyprowski wrote:
> >> +unsigned long alloc_contig_freed_pages(unsigned long start, unsigned  
> >> long end,
> >> +                                      gfp_t flag)
> >> +{
> >> +       unsigned long pfn = start, count;
> >> +       struct page *page;
> >> +       struct zone *zone;
> >> +       int order;
> >> +
> >> +       VM_BUG_ON(!pfn_valid(start));
> >
> > This seems kinda mean.  Could we return an error?  I understand that
> > this is largely going to be an early-boot thing, but surely trying to
> > punt on crappy input beats a full-on BUG().
> 
> Actually, I would have to check but I think that the usage of this function
> (in this patchset) is that the caller expects the function to succeed.  It  
> is quite a low-level function so before running it a lot of preparation is  
> needed and the caller must make sure that several conditions are met.  I don't  
> really see advantage of returning a value rather then BUG()ing.
> 
> Also, CMA does not call this function at boot time.

We BUG_ON() in bootmem.  Basically if we try to allocate an early-boot
structure and fail, we're screwed.  We can't keep running without an
inode hash, or a mem_map[].

This looks like it's going to at least get partially used in drivers, at
least from the examples.  Are these kinds of things that, if the driver
fails to load, that the system is useless and hosed?  Or, is it
something where we might limp along to figure out what went wrong before
we reboot?

-- Dave
