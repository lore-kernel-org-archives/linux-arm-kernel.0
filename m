From: dave@linux.vnet.ibm.com (Dave Hansen)
Date: Thu, 31 Mar 2011 13:33:39 -0700
Subject: [PATCH 04/12] mm: alloc_contig_freed_pages() added
In-Reply-To: <20110331192429.GD14441@home.goodmis.org>
References: <1301577368-16095-1-git-send-email-m.szyprowski@samsung.com>
	<1301577368-16095-5-git-send-email-m.szyprowski@samsung.com>
	<1301587083.31087.1032.camel@nimitz>
	<20110331192429.GD14441@home.goodmis.org>
Message-ID: <1301603619.31087.1203.camel@nimitz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-03-31 at 15:24 -0400, Steven Rostedt wrote:
> On Thu, Mar 31, 2011 at 08:58:03AM -0700, Dave Hansen wrote:
> > On Thu, 2011-03-31 at 15:16 +0200, Marek Szyprowski wrote:
> > > 
> > > +unsigned long alloc_contig_freed_pages(unsigned long start, unsigned long end,
> > > +                                      gfp_t flag)
> > > +{
> > > +       unsigned long pfn = start, count;
> > > +       struct page *page;
> > > +       struct zone *zone;
> > > +       int order;
> > > +
> > > +       VM_BUG_ON(!pfn_valid(start));
> > 
> > This seems kinda mean.  Could we return an error?  I understand that
> > this is largely going to be an early-boot thing, but surely trying to
> > punt on crappy input beats a full-on BUG().
> > 
> > 	if (!pfn_valid(start))
> > 		return -1;
> 
> But still keep the warning?
> 
> 	if (WARN_ON(!pfn_valid(start))
> 		return -1;

Sure.  You might also want to make sure you're respecting __GFP_NOWARN
if you're going to do that, or maybe just warn once per boot.


-- Dave
