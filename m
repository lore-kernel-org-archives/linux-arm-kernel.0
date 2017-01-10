From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 10 Jan 2017 14:16:57 +0000
Subject: [PATCH v2] arm64: do not set dma masks that device connection
 can't handle
In-Reply-To: <6116278.nQQUSuo3l4@wuerfel>
References: <1483947002-16410-1-git-send-email-nikita.yoush@cogentembedded.com>
 <07253eaa-5729-0f15-42b6-e8403f1f0412@cogentembedded.com>
 <11daacde-5399-039f-80a3-01d7bd13e9e8@arm.com> <6116278.nQQUSuo3l4@wuerfel>
Message-ID: <5c5cd4fd-4854-a2dd-10b6-9cc98e63a85c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/01/17 13:42, Arnd Bergmann wrote:
> On Tuesday, January 10, 2017 1:25:12 PM CET Robin Murphy wrote:
>> On 10/01/17 12:47, Nikita Yushchenko wrote:
>>>> The point here is that an IOMMU doesn't solve your issue, and the
>>>> IOMMU-backed DMA ops need the same treatment. In light of that, it really
>>>> feels to me like the DMA masks should be restricted in of_dma_configure
>>>> so that the parent mask is taken into account there, rather than hook
>>>> into each set of DMA ops to intercept set_dma_mask. We'd still need to
>>>> do something to stop dma_set_mask widening the mask if it was restricted
>>>> by of_dma_configure, but I think Robin (cc'd) was playing with that.
>>>
>>> What issue "IOMMU doesn't solve"?
>>>
>>> Issue I'm trying to address is - inconsistency within swiotlb
>>> dma_map_ops, where (1) any wide mask is silently accepted, but (2) then
>>> mask is used to decide if bounce buffers are needed or not. This
>>> inconsistency causes NVMe+R-Car cobmo not working (and breaking memory
>>> instead).
>>
>> The fundamental underlying problem is the "any wide mask is silently
>> accepted" part, and that applies equally to IOMMU ops as well.
> 
> It's a much rarer problem for the IOMMU case though, because it only
> impacts devices that are restricted to addressing of less than 32-bits.
> 
> If you have an IOMMU enabled, the dma-mapping interface does not care
> if the device can do wider than 32 bit addressing, as it will never
> hand out IOVAs above 0xffffffff.

I can assure you that it will - we constrain allocations to the
intersection of the IOMMU domain aperture (normally the IOMMU's physical
input address width) and the given device's DMA mask. If both of those
are >32 bits then >32-bit IOVAs will fall out. For the arm64/common
implementation I have prototyped a copy of the x86 optimisation which
always first tries to get 32-bit IOVAs for PCI devices, but even then it
can start returning higher addresses if the 32-bit space fills up.

>>> I just can't think out what similar issue iommu can have.
>>> Do you mean that in iommu case, mask also must not be set to whatever
>>> wider than initial value? Why? What is the use of mask in iommu case? Is
>>> there any real case when iommu can't address all memory existing in the
>>> system?
>>
>> There's a very subtle misunderstanding there - the DMA mask does not
>> describe the memory a device can address, it describes the range of
>> addresses the device is capable of generating. Yes, in the non-IOMMU
>> case they are equivalent, but once you put an IOMMU in between, the
>> problem is merely shifted from "what range of physical addresses can
>> this device access" to "what range of IOVAs is valid to give to this
>> device" - the fact that those IOVAs can map to any underlying physical
>> address only obviates the need for any bouncing at the memory end; it
>> doesn't remove the fact that the device has a hardware addressing
>> limitation which needs to be accommodated.
>>
>> The thread Will linked to describes that equivalent version of your
>> problem - the IOMMU gives the device 48-bit addresses which get
>> erroneously truncated because it doesn't know that only 42 bits are
>> actually wired up. That situation still requires the device's DMA mask
>> to correctly describe its addressing capability just as yours does.
> 
> That problem should only impact virtual machines which have a guest
> bus address space covering more than 42 bits of physical RAM, whereas
> the problem we have with swiotlb is for the dma-mapping interface.

As above, it impacts DMA API use for anything whose addressing
capability is narrower than the IOMMU's reported input size and whose
driver is able to blindly set a too-big DMA mask. It just happens to be
the case that the stars line up on most systems, and for 32-bit devices
who keep the default DMA mask.

I actually have a third variation of this problem involving a PCI root
complex which *could* drive full-width (40-bit) addresses, but won't,
due to the way its PCI<->AXI interface is programmed. That would require
even more complicated dma-ranges handling to describe the windows of
valid physical addresses which it *will* pass, so I'm not pressing the
issue - let's just get the basic DMA mask case fixed first.

>>> With this direction, semantics of dma mask becomes even more
>>> questionable. I'd say dma_mask is candidate for removal (or to move to
>>> swiotlb's or iommu's local area)
>>
>> We still need a way for drivers to communicate a device's probed
>> addressing capability to SWIOTLB, so there's always going to have to be
>> *some* sort of public interface. Personally, the change in semantics I'd
>> like to see is to make dma_set_mask() only fail if DMA is entirely
>> disallowed - in the normal case it would always succeed, but the DMA API
>> implementation would be permitted to set a smaller mask than requested
>> (this is effectively what the x86 IOMMU ops do already).
> 
> With swiotlb enabled, it only needs to fail if the mask does not contain
> the swiotlb bounce buffer area, either because the start of RAM is outside
> of the mask, or the bounce area has been allocated at the end of ZONE_DMA
> and the mask is smaller than ZONE_DMA.

Agreed, I'd managed to overlook that specific case, but I'd be inclined
to consider "impossible" a subset of "disallowed" still :)

Robin.
