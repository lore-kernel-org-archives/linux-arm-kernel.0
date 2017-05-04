From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 4 May 2017 15:03:07 +0100
Subject: [PATCH] arm64: Fix the DMA mmap and get_sgtable API with
 DMA_ATTR_FORCE_CONTIGUOUS
In-Reply-To: <7d0445e5-ddb3-7d0f-4749-c63b54beff43@arm.com>
References: <1493143232-2245-1-git-send-email-catalin.marinas@arm.com>
 <7d0445e5-ddb3-7d0f-4749-c63b54beff43@arm.com>
Message-ID: <20170504140306.GB25108@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 04, 2017 at 12:29:37PM +0100, Robin Murphy wrote:
> On 25/04/17 19:00, Catalin Marinas wrote:
> > While honouring the DMA_ATTR_FORCE_CONTIGUOUS on arm64 (commit
> > 44176bb38fa4: "arm64: Add support for DMA_ATTR_FORCE_CONTIGUOUS to
> > IOMMU"), the existing uses of dma_mmap_attrs() and dma_get_sgtable()
> > have been broken by passing a physically contiguous vm_struct with an
> > invalid pages pointer through the common iommu API.
> > 
> > Since the coherent allocation with DMA_ATTR_FORCE_CONTIGUOUS uses CMA,
> > this patch simply reuses the existing swiotlb logic for mmap and
> > get_sgtable.
> > 
> > Note that the current implementation of get_sgtable (both swiotlb and
> > iommu) is broken if dma_declare_coherent_memory() is used since such
> > memory does not have a corresponding struct page. To be addressed in a
> > separate patch.
> > 
> > Fixes: 44176bb38fa4 ("arm64: Add support for DMA_ATTR_FORCE_CONTIGUOUS to IOMMU")
> > Reported-by: Andrzej Hajda <a.hajda@samsung.com>
> > Cc: Andrzej Hajda <a.hajda@samsung.com>
> > Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > ---
> > 
> > Here's my attempt of fixing this, though I'd like to wait for Robin's review
> > (who's currently on holiday until next week).
> > 
> > Not tested.
> 
> The general approach is sound, and I can't see anything that looks
> obviously wrong with the implementation, although I have no easy way of
> testing it either:
> 
> Acked-by: Robin Murphy <robin.murphy@arm.com>

Thanks for looking at this patch.

Going through the past threads on this, I wonder whether the attribute
is actually used anywhere (in which case we may be better off reverting
the original patch). If improved IOMMU performance is required, there
are likely better ways to achieve this like using a different page size
at the IOMMU level.

-- 
Catalin
