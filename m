From: nico@cam.org (Nicolas Pitre)
Date: Fri, 04 Sep 2009 20:56:38 -0400 (EDT)
Subject: ARM highmem stuff - 5687/1
In-Reply-To: <20090904212024.GB10316@n2100.arm.linux.org.uk>
References: <20090902135355.GB12595@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.0909021009010.6044@xanadu.home>
	<20090904183311.GA10316@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.0909041447020.6044@xanadu.home>
	<20090904212024.GB10316@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.0909042032130.6044@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 4 Sep 2009, Russell King - ARM Linux wrote:

> On Fri, Sep 04, 2009 at 03:33:53PM -0400, Nicolas Pitre wrote:
> > On Fri, 4 Sep 2009, Russell King - ARM Linux wrote:
> > > In this case, flush_dcache_page() may just set the PG_dcache_dirty bit
> > > without flushing anything.
> > 
> > But only if there is indeed a mapping and it is unmapped.  In which case 
> > isn't the flush going to happen before the page gets mapped into user 
> > space anyway?
> 
> Only if it still has a mapping at that point.

Hmmmmm... Isn't that a bug?  What if PG_dcache_dirty is set even if 
there is no more mapping for the page?  Wouldn't that mean that the 
kernel view of the page might still have dirty cache lines that could 
eventually overwrite what user space might have written to that page?
In other words, wouldn't that be clearer and safer to always flush the 
cache whenever the bit indicating cache dirtiness is set?

> > > I do know that flush_anon_page() was required to stabilise the list server.
> > 
> > Do you mean __cpuc_flush_dcache_page() inside flush_anon_page()?
> 
> I really don't know.  flush_anon_page() wasn't written incrementally, it
> was written to allow the accesses as described in cachetlb.txt to work as
> expected.  The rationale for this function is further described in commit
> 03beb07664d768db97bf454ae5c9581cd4737bb4.

There it is said:

    Currently, get_user_pages() returns fully coherent pages to the kernel for
    anything other than anonymous pages.  This is a problem for things like
    fuse and the SCSI generic ioctl SG_IO which can potentially wish to do DMA
    to anonymous pages passed in by users.

So I think that matches my earlier theory about such pages marked with 
PG_dcache_dirty that user space didn't fault yet, and therefore still 
not coherent wrt its kernel view.  Doing DMA on such a page would not 
produce intended results unless __cpuc_flush_dcache_page() is used on 
it.

> I really can't comment any further on this, and I'm really concerned
> about changing the current behaviour.  We know what we currently have
> works, and given that we've lost a way to test changes in this area
> anymore, I think it's definitely a case if leaving well alone.

Good enough.  However I'd suggest replacing 
__cpuc_flush_dcache_page(page_address(page)) with 
__flush_dcache_page(NULL, page).  This way the unmapped highmem page 
fix would benefit __flush_anon_page() as well and be located in only one 
place, with otherwise the same result.


Nicolas
