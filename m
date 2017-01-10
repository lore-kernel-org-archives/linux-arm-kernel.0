From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Jan 2017 14:12:18 +0100
Subject: [PATCH v2] arm64: do not set dma masks that device connection
 can't handle
In-Reply-To: <07253eaa-5729-0f15-42b6-e8403f1f0412@cogentembedded.com>
References: <1483947002-16410-1-git-send-email-nikita.yoush@cogentembedded.com>
 <20170110115132.GD21598@arm.com>
 <07253eaa-5729-0f15-42b6-e8403f1f0412@cogentembedded.com>
Message-ID: <2642601.V6IY0ZAJpg@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, January 10, 2017 3:47:25 PM CET Nikita Yushchenko wrote:
> 
> > The point here is that an IOMMU doesn't solve your issue, and the
> > IOMMU-backed DMA ops need the same treatment. In light of that, it really
> > feels to me like the DMA masks should be restricted in of_dma_configure
> > so that the parent mask is taken into account there, rather than hook
> > into each set of DMA ops to intercept set_dma_mask.

of_dma_configure() sets up a 32-bit mask, which is assumed to always work
in the kernel. We can't change it to a larger mask because that would
break drivers that have to restrict devices to 32-bit.

If the bus addressing is narrower than 32 bits however, the initial mask
should probably be limited to whatever the bus supports, but that is not
the problem we are trying to solve here.

> > We'd still need to
> > do something to stop dma_set_mask widening the mask if it was restricted
> > by of_dma_configure, but I think Robin (cc'd) was playing with that.
> 
> What issue "IOMMU doesn't solve"?
> 
> Issue I'm trying to address is - inconsistency within swiotlb
> dma_map_ops, where (1) any wide mask is silently accepted, but (2) then
> mask is used to decide if bounce buffers are needed or not. This
> inconsistency causes NVMe+R-Car cobmo not working (and breaking memory
> instead).

It's not just an inconsistency, it's a known bug that we really
need to fix.

> I just can't think out what similar issue iommu can have.
> Do you mean that in iommu case, mask also must not be set to whatever
> wider than initial value? Why? What is the use of mask in iommu case? Is
> there any real case when iommu can't address all memory existing in the
> system?

I think the problem that Will is referring to is when the IOMMU has
a virtual address space that is wider than the DMA mask of the device:
In this case, dma_map_single() might return a dma_addr_t that is not
reachable by the device.

I'd consider that a separate bug that needs to be worked around in
the IOMMU code.

> NVMe maintainer has just stated that they expect
> set_dma_mask(DMA_BIT_MASK(64)) to always succeed, and are going to error
> out driver probe if that call fails.  They claim that architecture must
> always be able to dma_map() whatever memory existing in the system - via
> iommu or swiotlb or whatever. Their direction is to remove bounce
> buffers from block and other layers.
> 
> With this direction, semantics of dma mask becomes even more
> questionable. I'd say dma_mask is candidate for removal (or to move to
> swiotlb's or iommu's local area)

Removing dma_mask is not realistic any time soon, there are too many things
in the kernel that use it for one thing or another, so any changes here
have to be done really carefully. We definitely need the mask to support
architectures without swiotlb.

	Arnd
