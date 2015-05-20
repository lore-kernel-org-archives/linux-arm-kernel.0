From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 20 May 2015 17:20:06 +0100
Subject: [RFC] arm: DMA-API contiguous cacheable memory
In-Reply-To: <CAE=W-e2LZN9cEvTQNm0z1_ZMg1mKs=o2TcEy5QRkiEPMMFWuPg@mail.gmail.com>
References: <CAE=W-e24oDH5RZfPftRg_xYBiG+b9Sj09vpyay9EwqOo9cVX1w@mail.gmail.com>
 <20150519163436.GZ21251@e104818-lin.cambridge.arm.com>
 <CAE=W-e1qynowbccHpYntWwwZPZOMHAVXH=Yj3ukyr_X8WKwQJQ@mail.gmail.com>
 <2882347.Nj1Dq9Wlqh@wuerfel>
 <20150519223444.GO2067@n2100.arm.linux.org.uk>
 <CAE=W-e2LZN9cEvTQNm0z1_ZMg1mKs=o2TcEy5QRkiEPMMFWuPg@mail.gmail.com>
Message-ID: <20150520162005.GP2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 20, 2015 at 02:57:36PM +0200, Lorenzo Nava wrote:
> so probably currently is impossible to allocate a contiguous cachable
> DMA memory. You can't use CMA, and the only functions which allow you
> to use it are not compatible with sync functions.
> Do you think the problem is the CMA design, the DMA API design, or
> there is no problem at all and this is not something useful?

Well, the whole issue of DMA from userspace is a fraught topic.  I
consider what we have at the moment as mere luck than anything else -
there are architecture maintainers who'd like to see dma_mmap_* be
deleted from the kernel.

However, I have a problem with what you're trying to do.

You want to allocate a large chunk of memory for DMA.  Large chunks
of memory can _only_ come from CMA - the standard Linux allocators do
_not_ cope well with large allocations.  Even 16K allocations can
become difficult after the system has been running for a while.  So,
CMA is really the only way to go to obtain large chunks of memory.

You want this large chunk of memory to be cacheable.  CMA might be
able to provide that.

You want to DMA to this memory, and then read from it.  The problem
there is, how do you ensure that the data you're reading is the data
that the DMA wrote there.  If you have caching enabled, the caching
model that we _have_ to assume is that the cache is infinite, and that
it speculates aggressively.  This means that we can not guarantee that
any data read through a cacheable mapping will be coherent with the
DMA'd data.

So, we have to flush the cache.  The problem is that with an infinite
cache size model, we have to flush all possible lines associated with
the buffer, because we don't know which might be in the cache and
which are not.

Of course, caches are finite, and we can say that if the size of the
region being flushed is greater than the cache size (or multiple of the
cache size), we _could_ just flush the entire cache instead.  (This can
only work for non-SG stuff, as we don't know before hand how large the
SG is in bytes.)

However, here's the problem.  As I mentioned above, we have dma_mmap_*
stuff, which works for memory allocated by dma_alloc_coherent().  The
only reason mapping that memory into userspace works is because (for
the non-coherent cache case) we map it in such a way that the caches
are disabled, and this works fine.  For the coherent cache case, it
doesn't matter that we map it with the caches enabled.  So both of these
work.

When you have a non-coherent cache _and_ you want the mapping to be
cacheable, you have extra problems to worry about.  You need to know
the type of the CPU cache.  If the CPU cache is physically indexed,
physically tagged, then you can perform cache maintanence on any
mapping of that memory, and you will hit the appropriate cache lines.
For other types of caches, this is not true.  Hence, a userspace
mapping of non-coherent cacheable memory with a cache which makes use
of virtual addresses would need to be flushed at the virtual aliases -
this is precisely why kernel arch maintainers don't like DMA from
userspace.  It's brings with it huge problems.

Thankfully, ARMv7 caches are PIPT - but that doesn't really give us
"permission" to just consider PIPT for this case, especially for
something which is used between arch code and driver code.

What I'm trying to say is that what you're asking for is not a simple
issue - it needs lots of thought and consideration, more than I have
time to spare (or likely have time to spare in the future, _most_ of
my time is wasted trying to deal with the flood of email from these
mailing lists rather than doing any real work - even non-relevant email
has a non-zero time cost as it takes a certain amount of time to decide
whether an email is relevant or not.)

> Anyway it's not completely clear to me which is the difference between:
>   - allocating memory and use sync function on memory mapped with dma_map_*()
>   - allocating memory with dma_alloc_*() (with cacheable attributes)
> and use the sync functions on it

Let me say _for the third time_: dma_sync_*() on memory returned from
dma_alloc_*() is not permitted.  Anyone who tells you different is
just plain wrong, and is telling you to do something which is _not_
supported by the API, and _will_ fail with some implementations
including the ARM implementation if it uses the atomic pool to satisfy
your allocation.

> It looks that the second just make alloc + map in a single step
> instead of splitting the operation in two steps.
> I'm sure I'm losing something, can you please help me understand that?

The problem is that you're hitting two different costs: the cost from
accessing data via an uncacheable mapping, vs the cost of having to do
cache maintanence to ensure that you're reading the up-to-date data.

At the end of the day, there's only one truth here: large DMA buffers
on architectures which are not cache-coherent suck and require a non-zero
cost to ensure that you can read the data written to the buffer by DMA,
or that DMA can see the data you have written to the buffer.

The final thing to mention is that the ARM cache maintanence instructions
are not available in userspace, so you can't have userspace taking care
of flushing the caches where they need to...

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
