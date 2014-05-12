From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 May 2014 21:53:41 +0200
Subject: [RFC] Describing arbitrary bus mastering relationships in DT
In-Reply-To: <537112FC.1040204@wwwdotorg.org>
References: <20140501173248.GD3732@e103592.cambridge.arm.com>
 <25333129.urqEa0mCI8@wuerfel> <537112FC.1040204@wwwdotorg.org>
Message-ID: <5235938.KqUI5iMopI@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 12 May 2014 12:29:16 Stephen Warren wrote:
> On 05/12/2014 12:10 PM, Arnd Bergmann wrote:
> > On Monday 12 May 2014 10:19:16 Stephen Warren wrote:
> >> IIRC, the current Nouveau support for Tegra even makes use of that
> >> feature, although I think that's a temporary thing that we're hoping to
> >> get rid of once the Tegra support in Nouveau gets more mature.
> > 
> > But the important point here is that you wouldn't use the dma-mapping
> > API to manage this. First of all, the CPU is special anyway, but also
> > if you do a device-to-device DMA into the GPU address space and that
> > ends up being redirected to memory through the IOMMU, you still wouldn't
> > manage the I/O page tables through the interfaces of the device doing the
> > DMA, but through some private interface of the GPU.
> 
> Why not? If something wants to DMA to a memory region, irrespective of
> whether the GPU MMU (or any MMU) is in between those master transactions
> and the RAM or not, surely the driver should always use the DMA mapping
> API to set that up? Anything else just means using custom APIs, and
> isn't the whole point of the DMA mapping API to provide a standard API
> for that purpose?

It sounds like an abuse of the hardware if you use the GPU's IOMMU
to set up DMA for a random non-GPU DMA master. I'd prefer not to go
there and instead use swiotlb.

	Arnd
