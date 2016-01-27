From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 27 Jan 2016 12:22:30 +0100
Subject: Speeding up dma_unmap
In-Reply-To: <CAJFSRaCRvx=+_fEYAr8OeWGHnnz+rOWjLzLcm+wZiEstbHwxAw@mail.gmail.com>
References: <CAJFSRaCRvx=+_fEYAr8OeWGHnnz+rOWjLzLcm+wZiEstbHwxAw@mail.gmail.com>
Message-ID: <CAKv+Gu_t1Kc+D=LjTfgXpevWadnDHiUtdWL8K73nA39Ch7-G4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 January 2016 at 09:32, Jason Holt <jholt@google.com> wrote:
> I'm new to the DMA API and looking for a sanity check.
>
> As I understand it, dma_unmap_* is slow (for data coming from a device
> to the CPU) on some ARM CPUs because the *_inv_range() functions have
> to iterate in cache line sized steps through the entire buffer,
> telling the cache controller "invalidate this if you have it".
>
> For buffers larger than the size of the data cache, might it be faster
> to go the other direction and check each line of the cache to see if
> it's inside the buffer, then invalidate it if it is?  (I believe the
> buffer must be contiguous in physical memory, so I assume that'd be a
> simple bottom < x < top check).
>
> So for a 256K L2 cache and 4MB buffer, we'd only have to check 256K
> worth of cache lines instead of 4MB when we unmap.
>
> Failing that, I suppose a very dirty hack would be to
> data_cache_clean_and_invalidate if the only thing I cared about was
> getting data from my DMA peripheral as fast as possible.  (I'm on
> AM335X and seeing no more than 200MB/s from device to CPU with
> dma_unmap_single, whereas the PRUs can write to main memory at
> 600MB/s.)
>

This may work in practice, but it violates the architecture, and may
cause hard to diagnose problems on coherent systems.

The reason is that cache maintenance by virtual address and cache
maintenance by set/way are completely different things, and set/way
operations are not broadcast to other cores or system caches, which
means you are not architecturally guaranteed to see the data in main
memory after you have invalidated your caches by set/way. None of this
is likely to affect your Cortex-A8 system, but it is not a good idea
in general. (Note that you would still need to invalidate the entire
cache, since making inferences about the relation between cache
geometry and the layout of physical memory is not portable either, and
since your buffer size exceeds the L2 set size, every cache line could
potentially hold some of your data anyway.)

-- 
Ard.
