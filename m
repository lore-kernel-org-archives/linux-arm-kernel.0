From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 29 Jun 2015 10:08:04 +0100
Subject: dma_sync_single_for_cpu takes a really long time
In-Reply-To: <CAF6-1L6Xhsk3CwTvu6rAvYGYX3XvcwbmP582tVPEuiVaDnFpRA@mail.gmail.com>
References: <CAF6-1L6sjGc1VySi=oQGzOEm-e5jauznh+jzmdDgmJQWLbA_pA@mail.gmail.com>
 <20150628223039.GV7557@n2100.arm.linux.org.uk>
 <CAF6-1L6Xhsk3CwTvu6rAvYGYX3XvcwbmP582tVPEuiVaDnFpRA@mail.gmail.com>
Message-ID: <20150629090804.GX7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 29, 2015 at 08:07:52AM +0200, Sylvain Munaut wrote:
> Hi,
> 
> 
> Thanks for the quick and detailed answer.
> 
> 
> > Flushing a large chunk of memory one cache line at a time takes a long
> > time, there's really nothing "new" about that.
> 
> So when invalidating cache, you have to do it for every possible cache line
> address ? There is not an instruction to invalidate a whole range ?

Correct.

ARM did "have a go" at providing an instruction which operated on a cache
range in hardware, but it was a disaster, and was removed later on.  The
disaster about it is if you got an exception (eg, interrupt) while the
instruction was executing, it would stop doing the cache maintanence, and
jump to the exception handler.  When the exception handler returned, it
would restart the instruction, not from where it left off, but from the
very beginning.

With a sufficiently frequent interrupt rate and a large enough area, the
result is very effective at preventing the CPU from making any progress.

> Also, I noticed that dma_sync_single_for_device takes a while too even
> though I would have expected it to be a no-op for the FROM_DEVICE case.

In the FROM_DEVICE case, we perform cache maintanence before the DMA
starts, to ensure that there are no dirty cache lines which may get
evicted and overwrite the newly DMA'd data.

However, we also need to perform cache maintanence after DMA has finished
to ensure that the data in the cache is up to date with the newly DMA'd
data.  During the DMA operation, the CPU can speculatively load data into
its caches, which may or may not be the newly DMA'd data - we just don't
know.

> I can guarantee that I never wrote to this memory zone, so there is nothing
> in any write-back buffer, is there anyway to convey this guarantee to the
> API ? Or should I just not call dma_sync_single_for_device at all ?

It's not about whether you wrote to it.  It's whether the CPU speculatively
loaded data into its cache.

This is one of the penalties of having a non-coherent CPU cache with
features such as speculative prefetching to give a performance boost for
non-DMA cases - the DMA use case gets even worse, because the necessary
cache maintanence overheads double.  You can no longer rely on "this
memory area hasn't been touched by the program, so no data will be loaded
into the cache prior to my access" which you can with non-speculative
prefetching CPUs.

> > It's the expense that has to be paid for using cacheable mappings on a
> > CPU which is not DMA coherent - something which I've brought up over
> > the years with ARM, but it's not something that ARM believe is wanted
> > by their silicon partners.
> >
> > What we _could_ do is decide that if the buffer is larger than some
> > factor of the cache size, to just flush the entire cache.  However, that
> > penalises the case where none of the data is in the cache - and in all
> > probably  very little of the frame is actually sitting in the cache at
> > that moment.
> 
> If I wanted to give that a shot, how would I do that in my module ?
> 
> As a start, I tried calling outer_inv_all() instead of outer_inv_range(),
> but it turned out to be a really bad idea (just freezes the system)

_Invalidating_ the L2 destroyes data in the cache which may not have been
written back - it's effectively undoing the data modifications that have
yet to be written back to memory.  That's will cause things to break.

Also, the L2 cache has problems if you use the _all() functions (which
operate on cache set/way) and another CPU also wants to do some other
operation (like a sync, as part of a barrier.)

The trade-off is either never to use the _all() functions while other CPUs
are running, or pay a heavy penalty on every IO access and Linux memory
barrier caused by having to spinlock every L2 cache operation, and run
all L2 operations with interrupts disabled.

> > However, if you're going to read the entire frame through a cacheable
> > mapping, you're probably going to end up flushing your cache several
> > times over through doing that
> 
> Isn't there some intermediary between coherent and cacheable, a bit like
> write combine for read ?

Unfortunately not.  IIRC, some CPUs like PXA had a "read buffer" which
would do that, but that was a PXA specific extension, and never became
part of the ARM architecture itself.

> The Zynq TRM mention something about having independent control on inner
> and outer cacheability for instance. If only one was enabled, then at least
> the other wouldn't have to be invalidated ?

We then start running into other problems: there are only 8 memory types,
7 of which are usable (one is "implementation specific").  All of these
are already used by Linux...

I do feel your pain in this.  I think there has been some pressure on this
issue, because ARM finally made a coherent bus available on SMP systems,
which silicon vendors can use to maintain coherency with the caches.  It's
then up to silicon vendors to use that facility.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
