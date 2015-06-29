From: s.munaut@whatever-company.com (Sylvain Munaut)
Date: Mon, 29 Jun 2015 14:30:19 +0200
Subject: dma_sync_single_for_cpu takes a really long time
In-Reply-To: <20150629090804.GX7557@n2100.arm.linux.org.uk>
References: <CAF6-1L6sjGc1VySi=oQGzOEm-e5jauznh+jzmdDgmJQWLbA_pA@mail.gmail.com>
 <20150628223039.GV7557@n2100.arm.linux.org.uk>
 <CAF6-1L6Xhsk3CwTvu6rAvYGYX3XvcwbmP582tVPEuiVaDnFpRA@mail.gmail.com>
 <20150629090804.GX7557@n2100.arm.linux.org.uk>
Message-ID: <CAF6-1L6xn6-6FxPivSvC5Wwyjr-YjO5QEL1ep4rLZML9xZx2RA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> I can guarantee that I never wrote to this memory zone, so there is nothing
>> in any write-back buffer, is there anyway to convey this guarantee to the
>> API ? Or should I just not call dma_sync_single_for_device at all ?
>
> It's not about whether you wrote to it.  It's whether the CPU speculatively
> loaded data into its cache.

That I don't understand.

I see how that zone can be in cache (even though if it's on page
boundaries, it should never have been speculatively prefetched right
?). But if I never wrote to that buffer, the cache lines for it can't
possibly be marked as 'dirty'.

So doing a 'clean' on them should end up doing nothing. and the
sequence for a FROM_DMA exchange should be :

while (<transfer in progress>) {
   - Give the buffer to DMA ( dma_sync_single_for_device ) : Should be
no-op, but is not <===
   - Let the DMA do the write
   - Invalidate cache ( dma_sync_single_for_cpu )
   - Let the CPU do its thing on the data
}

Now I _do_ see that on the very first usage of the buffer I'd need to
do a clean. Because that memory could have been used for something
else before. But if I keep re-using that buffer and never write to it,
that only need to be done once.


>> As a start, I tried calling outer_inv_all() instead of outer_inv_range(),
>> but it turned out to be a really bad idea (just freezes the system)
>
> _Invalidating_ the L2 destroyes data in the cache which may not have been
> written back - it's effectively undoing the data modifications that have
> yet to be written back to memory.  That's will cause things to break.

Yeah, that was a really dumb thing to try ... after reading up last
night on how caching works in ARM A9 and the PL310 L2, I see that.


> Also, the L2 cache has problems if you use the _all() functions (which
> operate on cache set/way) and another CPU also wants to do some other
> operation (like a sync, as part of a barrier.)

Oh so even outer_flush_all() is not usable ?


Cheers,

    Sylvain
