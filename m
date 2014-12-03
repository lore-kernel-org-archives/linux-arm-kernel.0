From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 3 Dec 2014 12:17:50 +0000
Subject: [RFC] implement arm64_adjust_dma_zone as arm32 does?
In-Reply-To: <20141203190220.4415c21a@xhacker>
References: <20141203175855.114d6717@xhacker>
 <20141203102431.GA7373@e104818-lin.cambridge.arm.com>
 <20141203190220.4415c21a@xhacker>
Message-ID: <20141203121750.GC7373@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 03, 2014 at 11:02:20AM +0000, Jisheng Zhang wrote:
> Dear Catalin,
> 
> On Wed, 3 Dec 2014 02:24:32 -0800
> Catalin Marinas <catalin.marinas@arm.com> wrote:
> 
> > On Wed, Dec 03, 2014 at 09:58:55AM +0000, Jisheng Zhang wrote:
> > > If one platform has one limitation only some banks are DMA-able, for
> > > example 0-2GB. Under arm32, we can set the dma_zone_size, then
> > > arm_adjust_dma_zone() will set the correct dma zone for us. But under
> > > arm64, we can't do it.
> > 
> > Do you really have plans for such platform (and it won't have an IOMMU)
> > or it's just theoretical? Currently ZONE_DMA is limited to the bottom
> > 32-bit of RAM. The arm32 dma_zone_size relies on the machine descriptors
> > which we don't have on arm64.
> 
> Thanks for your detailed clarification. Yes, there's plan for such platform and
> there's no IOMMU.
[...]
> > What we could do is re-introduce ZONE_DMA32 for 32-bit dma masks and a
> > ZONE_DMA for smaller masks. The problem is describing such ZONE_DMA mask
> > via DT but very early before we set up the zones. A quick hack would be
> > to limit ZONE_DMA to the minimum of 32-bit limit or the end of the first
> > memblock, so you describe it as such in DT (but then we penalise
> > platforms that can do DMA on all memblocks).
> 
> We can keep ZONE_DMA32 out from arm64, just describe the ZONE_DMA mask via.
> DT as you pointed out, then setup the matching dma zone.
> 
> I'm wondering whether setting up ZONE_DMA mask via. DT is acceptable or not?

That would be better than machine descriptors, but I can't think of a
nice way to describe this (dma-ranges in the top DT node or a new
property for the memory node?).

We could try to get the minimum of all dma-ranges specified in the DT
for those buses which are not hooked to an IOMMU but setting up ZONE_DMA
needs to be done very early, before even unflattening the DT.

Cc'ing some arm-soc and DT people.

-- 
Catalin
