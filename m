From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 23 Jul 2012 09:22:07 +0200
Subject: [PATCH][RFC] arm: dma-mapping: Add support for allocating/mapping
 cached buffers
In-Reply-To: <5009BFE0.5050501@codeaurora.org>
References: <1342202506-12449-1-git-send-email-lauraa@codeaurora.org>
 <1342202506-12449-2-git-send-email-lauraa@codeaurora.org>
 <009901cd63e1$2d6445b0$882cd110$%szyprowski@samsung.com>
 <5009BFE0.5050501@codeaurora.org>
Message-ID: <038d01cd68a3$e23d7990$a6b86cb0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org




> -----Original Message-----
> From: Laura Abbott [mailto:lauraa at codeaurora.org]
> Sent: Friday, July 20, 2012 10:30 PM
> To: Marek Szyprowski
> Cc: linaro-mm-sig at lists.linaro.org; 'Russell King'; linux-arm-msm at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH][RFC] arm: dma-mapping: Add support for allocating/mapping cached buffers
> 
> On 7/16/2012 10:58 PM, Marek Szyprowski wrote:
> > Hi Laura,
> >
> > On Friday, July 13, 2012 8:02 PM Laura Abbott wrote:
> >
> >> There are currently no dma allocation APIs that support cached
> >> buffers. For some use cases, caching provides a signficiant
> >> performance boost that beats write-combining regions. Add
> >> apis to allocate and map a cached DMA region.
> >>
> >> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
> >
> > I agree that there is a need for cached contiguous memory blocks. I see that your patch
> > is based on some older version of CMA/dma-mapping code. In v3.5-rc1 CMA has been merged
> > to mainline kernel together with DMA-mapping redesign patches, so an attribute approach
> > can be used instead of adding new functions to the API. My original idea was to utilize
> > the dma_alloc_nonconsistent() call and DMA_ATTR_NONCONSISTENT for allocating/mapping
> > cached contiguous buffers, but I didn't have enough time for completing this work.
> >
> > The main missing piece is the API for managing cache synchronization on such buffers.
> > There is a dma_cache_synch() functions but it is broken from the API point of view. To
> > replace it with something better, some additional work is needed for all drivers which
> > already use it. Also some work in needed for cleanup dma_alloc_nonconsistent()
> > implementations for all the architectures using dma_map_ops approach. All this is on my
> > TODO list, but I currently I'm really busy with other tasks related to CMA (mainly
> > bugfixes for some special use-cases).
> >
> 
> In what is the dma_cache_sync API broken? Just curious at this point.

There are two issues with it:
1. There is no clear buffer ownership definition like it is done for 
   dma_sync_single_for_cpu/device() functions.
2. DMA address argument is missing, which is required for clean and robust implementation 
   on some architectures.

I would like to completely remove dma_cache_sync() and replace it with 
dma_sync_single_for_cpu/device(), but this probably require a bit more discussion and fixing 
all current clients of dma_cache_sync().

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
