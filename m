From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 27 Jan 2016 16:06:30 +0000
Subject: Speeding up dma_unmap
In-Reply-To: <3526786.axKPs51069@wuerfel>
References: <CAJFSRaCRvx=+_fEYAr8OeWGHnnz+rOWjLzLcm+wZiEstbHwxAw@mail.gmail.com>
 <3526786.axKPs51069@wuerfel>
Message-ID: <20160127160630.GQ14823@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2016 at 01:23:27PM +0100, Arnd Bergmann wrote:
> On Wednesday 27 January 2016 00:32:56 Jason Holt wrote:
> > 
> > Failing that, I suppose a very dirty hack would be to
> > data_cache_clean_and_invalidate if the only thing I cared about was
> > getting data from my DMA peripheral as fast as possible.  (I'm on
> > AM335X and seeing no more than 200MB/s from device to CPU with
> > dma_unmap_single, whereas the PRUs can write to main memory at
> > 600MB/s.)
> 
> On your Cortex-A8, we could come up with a way to not invalidate
> the cache at all on unmap, as the comment in __dma_page_dev_to_cpu()
> says:
> 
>         /* FIXME: non-speculating: not required */
>         /* in any case, don't bother invalidating if DMA to device */
>         if (dir != DMA_TO_DEVICE) {
>                 outer_inv_range(paddr, paddr + size);
> 
>                 dma_cache_maint_page(page, off, size, dir, dmac_unmap_area);
>         }
> 
> We already do a cache-invalidate operation on dma_map(), and the kernel
> is not allowed to access the memory in the meantime. On CPU cores
> that do speculative prefetching (Cortex-A9 and higher), we may end
                                   ^^^^^^^^^^^^^^^^^^^^
I would say "Cortex-A9 and newer".

> up reading cache lines back in randomly on a speculative prefetch,
> but as far as I can tell, the Cortex-A8 (or A5/A7) won't do that.

Are you sure about A5 and A7? I'm not even sure about the A8 but there
are good chances that A7 and A5 do speculative prefetches.

-- 
Catalin
