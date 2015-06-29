From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 29 Jun 2015 14:29:27 +0100
Subject: dma_sync_single_for_cpu takes a really long time
In-Reply-To: <CAF6-1L6xn6-6FxPivSvC5Wwyjr-YjO5QEL1ep4rLZML9xZx2RA@mail.gmail.com>
References: <CAF6-1L6sjGc1VySi=oQGzOEm-e5jauznh+jzmdDgmJQWLbA_pA@mail.gmail.com>
 <20150628223039.GV7557@n2100.arm.linux.org.uk>
 <CAF6-1L6Xhsk3CwTvu6rAvYGYX3XvcwbmP582tVPEuiVaDnFpRA@mail.gmail.com>
 <20150629090804.GX7557@n2100.arm.linux.org.uk>
 <CAF6-1L6xn6-6FxPivSvC5Wwyjr-YjO5QEL1ep4rLZML9xZx2RA@mail.gmail.com>
Message-ID: <20150629132927.GD7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 29, 2015 at 02:30:19PM +0200, Sylvain Munaut wrote:
> >> I can guarantee that I never wrote to this memory zone, so there is nothing
> >> in any write-back buffer, is there anyway to convey this guarantee to the
> >> API ? Or should I just not call dma_sync_single_for_device at all ?
> >
> > It's not about whether you wrote to it.  It's whether the CPU speculatively
> > loaded data into its cache.
> 
> That I don't understand.
> 
> I see how that zone can be in cache (even though if it's on page
> boundaries, it should never have been speculatively prefetched right
> ?). But if I never wrote to that buffer, the cache lines for it can't
> possibly be marked as 'dirty'.

Any cache line can be speculatively prefetched, and remember that cache
lines are naturally aligned, there's nothing special about page boundaries
as such (a page boundary is also a cache line boundary.)  So it's possible
the cache lines either side of a page boundary to be speculated if there
is a cacheable mapping present.

> So doing a 'clean' on them should end up doing nothing. and the
> sequence for a FROM_DMA exchange should be :
> 
> while (<transfer in progress>) {
>    - Give the buffer to DMA ( dma_sync_single_for_device ) : Should be
> no-op, but is not <===
>    - Let the DMA do the write
>    - Invalidate cache ( dma_sync_single_for_cpu )
>    - Let the CPU do its thing on the data
> }
> 
> Now I _do_ see that on the very first usage of the buffer I'd need to
> do a clean. Because that memory could have been used for something
> else before. But if I keep re-using that buffer and never write to it,
> that only need to be done once.

Hmm...  I _guess_ there is no reason why:

	addr = dma_map_single(dev, virt, size, DMA_FROM_DEVICE);
	while (whatever) {
		let device DMA to addr
		dma_sync_single_for_cpu(dev, addr, size, DMA_FROM_DEVICE);
		let CPU _read_ the buffer
	}
	dma_unmap_single(dev, addr, size, DMA_FROM_DEVICE);

would not be safe - there are places in the DMA API documentation that
suggest that is valid (Documentation/DMA-API-HOWTO.txt), provided the
CPU does not write to the buffer.

The implication in the above document is that a driver can eliminate the
dma_sync_single_for_device() call _iff_ the code does not write to the
buffer.  In other words, it's up to the driver to omit that call depending
on the driver's coded behaviour, but it's not the architecture's decision
to make dma_sync_single_for_device(..., DMA_FROM_DEVICE) be a no-op
(since the architecture code can't know whether the driver wrote to the
buffer for some reason.)

There is a final point to remember when dealing with the above, and that
is whether you have cache lines overlapping at the beginning and/or end
of the buffer which may be written to, which could then be evicted,
overwriting the DMA'd data.

The above should work with the existing implementation, so I'd encourage
you to try it and report back.

> > Also, the L2 cache has problems if you use the _all() functions (which
> > operate on cache set/way) and another CPU also wants to do some other
> > operation (like a sync, as part of a barrier.)
> 
> Oh so even outer_flush_all() is not usable ?

Correct - there are only three users of outer_flush_all() and all those
users only call the function in paths where the other CPUs have already
been shut down and IRQs are disabled.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
