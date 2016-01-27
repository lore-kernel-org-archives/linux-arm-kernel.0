From: jholt@google.com (Jason Holt)
Date: Wed, 27 Jan 2016 00:32:56 -0800
Subject: Speeding up dma_unmap
Message-ID: <CAJFSRaCRvx=+_fEYAr8OeWGHnnz+rOWjLzLcm+wZiEstbHwxAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm new to the DMA API and looking for a sanity check.

As I understand it, dma_unmap_* is slow (for data coming from a device
to the CPU) on some ARM CPUs because the *_inv_range() functions have
to iterate in cache line sized steps through the entire buffer,
telling the cache controller "invalidate this if you have it".

For buffers larger than the size of the data cache, might it be faster
to go the other direction and check each line of the cache to see if
it's inside the buffer, then invalidate it if it is?  (I believe the
buffer must be contiguous in physical memory, so I assume that'd be a
simple bottom < x < top check).

So for a 256K L2 cache and 4MB buffer, we'd only have to check 256K
worth of cache lines instead of 4MB when we unmap.

Failing that, I suppose a very dirty hack would be to
data_cache_clean_and_invalidate if the only thing I cared about was
getting data from my DMA peripheral as fast as possible.  (I'm on
AM335X and seeing no more than 200MB/s from device to CPU with
dma_unmap_single, whereas the PRUs can write to main memory at
600MB/s.)
