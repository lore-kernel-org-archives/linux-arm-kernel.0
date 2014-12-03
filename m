From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 3 Dec 2014 10:24:32 +0000
Subject: [RFC] implement arm64_adjust_dma_zone as arm32 does?
In-Reply-To: <20141203175855.114d6717@xhacker>
References: <20141203175855.114d6717@xhacker>
Message-ID: <20141203102431.GA7373@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 03, 2014 at 09:58:55AM +0000, Jisheng Zhang wrote:
> If one platform has one limitation only some banks are DMA-able, for example
> 0-2GB. Under arm32, we can set the dma_zone_size, then arm_adjust_dma_zone()
> will set the correct dma zone for us. But under arm64, we can't do it.

Do you really have plans for such platform (and it won't have an IOMMU)
or it's just theoretical? Currently ZONE_DMA is limited to the bottom
32-bit of RAM. The arm32 dma_zone_size relies on the machine descriptors
which we don't have on arm64.

> Or set dma-range in dts, then use swiotlb to bounce?

The problem is that swiotlb is only guaranteed to live in the ZONE_DMA,
so it doesn't buy you much if dma-ranges specify something smaller than
ZONE_DMA.

Similarly for CMA (coherent allocations), the reserved CMA area is
limited to ZONE_DMA (currently 32-bit mask).

> Could you kindly please give one suggestion about how to handle this
> situation?

First of all I need to know if that's a real case and we don't look into
it for fun.

What we could do is re-introduce ZONE_DMA32 for 32-bit dma masks and a
ZONE_DMA for smaller masks. The problem is describing such ZONE_DMA mask
via DT but very early before we set up the zones. A quick hack would be
to limit ZONE_DMA to the minimum of 32-bit limit or the end of the first
memblock, so you describe it as such in DT (but then we penalise
platforms that can do DMA on all memblocks).

-- 
Catalin
