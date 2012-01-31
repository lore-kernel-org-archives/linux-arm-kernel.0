From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 31 Jan 2012 17:23:59 +0100
Subject: [PATCH 02/15] mm: page_alloc: update migrate type of pages on pcp
 when isolating
In-Reply-To: <20120130161447.GU25268@csn.ul.ie>
References: <1327568457-27734-1-git-send-email-m.szyprowski@samsung.com>
 <1327568457-27734-3-git-send-email-m.szyprowski@samsung.com>
 <20120130111522.GE25268@csn.ul.ie> <op.v8wlu8ws3l0zgt@mpn-glaptop>
 <20120130161447.GU25268@csn.ul.ie>
Message-ID: <022e01cce034$bc6cf440$3546dcc0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Monday, January 30, 2012 5:15 PM Mel Gorman wrote:

> On Mon, Jan 30, 2012 at 04:41:22PM +0100, Michal Nazarewicz wrote:
> > On Mon, 30 Jan 2012 12:15:22 +0100, Mel Gorman <mel@csn.ul.ie> wrote:

(snipped)

> > >>+		page = pfn_to_page(pfn);
> > >>+		if (PageBuddy(page)) {
> > >>+			pfn += 1 << page_order(page);
> > >>+		} else if (page_count(page) == 0) {
> > >>+			set_page_private(page, MIGRATE_ISOLATE);
> > >>+			++pfn;
> > >
> > >This is dangerous for two reasons. If the page_count is 0, it could
> > >be because the page is in the process of being freed and is not
> > >necessarily on the per-cpu lists yet and you cannot be sure if the
> > >contents of page->private are important. Second, there is nothing to
> > >prevent another CPU allocating this page from its per-cpu list while
> > >the private field is getting updated from here which might lead to
> > >some interesting races.
> > >
> > >I recognise that what you are trying to do is respond to Gilad's
> > >request that you really check if an IPI here is necessary. I think what
> > >you need to do is check if a page with a count of 0 is encountered
> > >and if it is, then a draining of the per-cpu lists is necessary. To
> > >address Gilad's concerns, be sure to only this this once per attempt at
> > >CMA rather than for every page encountered with a count of 0 to avoid a
> > >storm of IPIs.
> >
> > It's actually more then that.
> >
> > This is the same issue that I first fixed with a change to free_pcppages_bulk()
> > function[1].  At the time of positing, you said you'd like me to try and find
> > a different solution which would not involve paying the price of calling
> > get_pageblock_migratetype().  Later I also realised that this solution is
> > not enough.
> >
> > [1] http://article.gmane.org/gmane.linux.kernel.mm/70314
> >
> 
> Yes. I had forgotten the history but looking at that patch again,
> I would reach the conclusion that this was adding a new call to
> get_pageblock_migratetype() in the bulk free path. That would affect
> everybody whether they were using CMA or not.

This will be a bit ugly, but we can also use that code and compile it conditionally
when CMA has been enabled. Pages, which have incorrect migrate type on free finally
causes pageblock migration type change from MIGRATE_CMA to MIGRATE_MOVABLE. This is
not a problem for non-CMA case where only pageblocks with MIGRATE_MOVABLE migration
type are being isolated.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
