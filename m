From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 10 Jan 2017 13:25:12 +0000
Subject: [PATCH v2] arm64: do not set dma masks that device connection
 can't handle
In-Reply-To: <07253eaa-5729-0f15-42b6-e8403f1f0412@cogentembedded.com>
References: <1483947002-16410-1-git-send-email-nikita.yoush@cogentembedded.com>
 <20170110115132.GD21598@arm.com>
 <07253eaa-5729-0f15-42b6-e8403f1f0412@cogentembedded.com>
Message-ID: <11daacde-5399-039f-80a3-01d7bd13e9e8@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/01/17 12:47, Nikita Yushchenko wrote:
> Hi
> 
>> The point here is that an IOMMU doesn't solve your issue, and the
>> IOMMU-backed DMA ops need the same treatment. In light of that, it really
>> feels to me like the DMA masks should be restricted in of_dma_configure
>> so that the parent mask is taken into account there, rather than hook
>> into each set of DMA ops to intercept set_dma_mask. We'd still need to
>> do something to stop dma_set_mask widening the mask if it was restricted
>> by of_dma_configure, but I think Robin (cc'd) was playing with that.
> 
> What issue "IOMMU doesn't solve"?
> 
> Issue I'm trying to address is - inconsistency within swiotlb
> dma_map_ops, where (1) any wide mask is silently accepted, but (2) then
> mask is used to decide if bounce buffers are needed or not. This
> inconsistency causes NVMe+R-Car cobmo not working (and breaking memory
> instead).

The fundamental underlying problem is the "any wide mask is silently
accepted" part, and that applies equally to IOMMU ops as well.

> I just can't think out what similar issue iommu can have.
> Do you mean that in iommu case, mask also must not be set to whatever
> wider than initial value? Why? What is the use of mask in iommu case? Is
> there any real case when iommu can't address all memory existing in the
> system?

There's a very subtle misunderstanding there - the DMA mask does not
describe the memory a device can address, it describes the range of
addresses the device is capable of generating. Yes, in the non-IOMMU
case they are equivalent, but once you put an IOMMU in between, the
problem is merely shifted from "what range of physical addresses can
this device access" to "what range of IOVAs is valid to give to this
device" - the fact that those IOVAs can map to any underlying physical
address only obviates the need for any bouncing at the memory end; it
doesn't remove the fact that the device has a hardware addressing
limitation which needs to be accommodated.

The thread Will linked to describes that equivalent version of your
problem - the IOMMU gives the device 48-bit addresses which get
erroneously truncated because it doesn't know that only 42 bits are
actually wired up. That situation still requires the device's DMA mask
to correctly describe its addressing capability just as yours does.

> NVMe maintainer has just stated that they expect
> set_dma_mask(DMA_BIT_MASK(64)) to always succeed, and are going to error
> out driver probe if that call fails.  They claim that architecture must
> always be able to dma_map() whatever memory existing in the system - via
> iommu or swiotlb or whatever. Their direction is to remove bounce
> buffers from block and other layers.

I have to say I'm in full agreement with that - having subsystems do
their own bouncing is generally redundant, although there are some
edge-cases like MMC_BLOCK_BOUNCE (which is primarily about aligning and
coalescing buffers than working around DMA limitations per se).

> With this direction, semantics of dma mask becomes even more
> questionable. I'd say dma_mask is candidate for removal (or to move to
> swiotlb's or iommu's local area)

We still need a way for drivers to communicate a device's probed
addressing capability to SWIOTLB, so there's always going to have to be
*some* sort of public interface. Personally, the change in semantics I'd
like to see is to make dma_set_mask() only fail if DMA is entirely
disallowed - in the normal case it would always succeed, but the DMA API
implementation would be permitted to set a smaller mask than requested
(this is effectively what the x86 IOMMU ops do already). The significant
work that would require, though, is changing all the drivers currently
using this sort of pattern:

	if (!dma_set_mask(dev, DMA_BIT_MASK(64))
		/* put device into 64-bit mode */
	else if (!dma_set_mask(dev, DMA_BIT_MASK(32))
		/* put device into 32-bit mode */
	else
		/* error */

to something like this:

	if (!dma_set_mask(dev, DMA_BIT_MASK(64))
		/* error */
	if (dma_get_mask(dev) > DMA_BIT_MASK(32))
		/* put device into 64-bit mode */
	else
		/* put device into 32-bit mode */

Which would be a pretty major job.

Robin.
