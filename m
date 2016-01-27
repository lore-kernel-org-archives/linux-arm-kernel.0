From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 27 Jan 2016 13:23:27 +0100
Subject: Speeding up dma_unmap
In-Reply-To: <CAJFSRaCRvx=+_fEYAr8OeWGHnnz+rOWjLzLcm+wZiEstbHwxAw@mail.gmail.com>
References: <CAJFSRaCRvx=+_fEYAr8OeWGHnnz+rOWjLzLcm+wZiEstbHwxAw@mail.gmail.com>
Message-ID: <3526786.axKPs51069@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 January 2016 00:32:56 Jason Holt wrote:
> 
> Failing that, I suppose a very dirty hack would be to
> data_cache_clean_and_invalidate if the only thing I cared about was
> getting data from my DMA peripheral as fast as possible.  (I'm on
> AM335X and seeing no more than 200MB/s from device to CPU with
> dma_unmap_single, whereas the PRUs can write to main memory at
> 600MB/s.)

On your Cortex-A8, we could come up with a way to not invalidate
the cache at all on unmap, as the comment in __dma_page_dev_to_cpu()
says:

        /* FIXME: non-speculating: not required */
        /* in any case, don't bother invalidating if DMA to device */
        if (dir != DMA_TO_DEVICE) {
                outer_inv_range(paddr, paddr + size);

                dma_cache_maint_page(page, off, size, dir, dmac_unmap_area);
        }


We already do a cache-invalidate operation on dma_map(), and the kernel
is not allowed to access the memory in the meantime. On CPU cores
that do speculative prefetching (Cortex-A9 and higher), we may end
up reading cache lines back in randomly on a speculative prefetch,
but as far as I can tell, the Cortex-A8 (or A5/A7) won't do that.

How does the performance change if you hack that file to simply not
do the invalidate?

	Arnd
