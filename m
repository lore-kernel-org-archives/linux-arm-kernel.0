From: jamie@shareable.org (Jamie Lokier)
Date: Tue, 29 Sep 2009 01:50:40 +0100
Subject: arm_syscall cacheflush breakage on VIPT platforms
In-Reply-To: <e06498070909281318o5c7818c5sd413c7da965b9593@mail.gmail.com>
References: <20090928092919.GA30271@localhost>
	<20090928133109.GM30271@localhost>
	<20090928134232.GG10671@n2100.arm.linux.org.uk>
	<200909281610.32674.laurent.pinchart@ideasonboard.com>
	<20090928141510.GG19778@shareable.org>
	<e06498070909281318o5c7818c5sd413c7da965b9593@mail.gmail.com>
Message-ID: <20090929005040.GB5527@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Steven Walter wrote:
> On Mon, Sep 28, 2009 at 10:15 AM, Jamie Lokier <jamie@shareable.org> wrote:
> > Laurent Pinchart wrote:
> >> > I'd much rather just say "no, userspace DMA is *never* going to ever
> >> > be supported" and call it a day, but I suspect no one's going to like
> >> > that either.
> >>
> >> In that case developers will all create their own incompatible solutions and
> >> the situation will likely get worse. Do you think it would be possible to
> >> create a clean DMA-to-userspace API specific to the ARM architecture ?
> >
> > I hate to spell out the obvious, but a fine solution is to _not_ DMA
> > directly to userspace, but to kmalloc() a large buffer in your own
> > driver, DMA into the buffer (it's kernel memory so that's ok), and
> > _then_ mmap() that buffer into userspace after the DMA. ?Going the
> > other way, mmap(), write from userspace, munmap(), then do the DMA to
> > the device.
> 
> It's not that simple when you have VIVT caches.
> 
> For example, consider the to-device case.  Userspace mmap()s the
> buffer and writes into it.  They indicate to the device driver that
> the data is ready for DMA.  Unfortunately, a simple dma_map_single of
> the kmalloc'd buffer is not sufficient.  That will only clean
> cachelines that fall into the kernel address range, and userspace
> stored into the buffer using the userspace address range.

Read the mail again.

The point is to write to the buffer and then call munmap() before
doing DMA.

> The problem exists for the from-device case on the second and
> subsequent DMA.  After the app reads from the buffer the first time,
> the cache may potentially contain stale cache lines that need to be
> invalidated, and dma_unmap_single will not invalidate them.

That's why it unmaps the buffer over DMA operations.

If munmap() doesn't unmap properly you have bigger problems than DMA.

Does munmap() work for this, or does that contain a nasty surprise too?

[ msync() would be logical a place to put explicit pre-DMA and
post-DMA cache requests, to avoid needing to unmap.  But I don't hold
much hope for msync() doing the right thing at this time.  If it turns
out that explicit cache cleaning and flushing are needed, though,
msync() would be a logical place to put it, perhaps with new flags. ]

-- Jamie
