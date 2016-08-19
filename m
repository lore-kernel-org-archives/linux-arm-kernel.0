From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Thu, 18 Aug 2016 19:01:47 -0700
Subject: [PATCH 1/1] ARM: dma: fix dma_max_pfn()
In-Reply-To: <20160818230754.GE1041@n2100.armlinux.org.uk>
References: <1471435517-7840-1-git-send-email-rogerq@ti.com>
 <1471435517-7840-2-git-send-email-rogerq@ti.com>
 <20160818142459.GX1041@n2100.armlinux.org.uk>
 <8003b6ed-6071-9384-1b88-0b84604bdce8@oracle.com>
 <20160818230754.GE1041@n2100.armlinux.org.uk>
Message-ID: <f8a05c02-df36-a0cf-6433-c67eb4a0f5b6@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/18/2016 4:07 PM, Russell King - ARM Linux wrote:
> On Thu, Aug 18, 2016 at 09:55:55AM -0700, Santosh Shilimkar wrote:
>> Hi Russell,
>>
>> On 8/18/2016 7:24 AM, Russell King - ARM Linux wrote:
>>> On Wed, Aug 17, 2016 at 03:05:17PM +0300, Roger Quadros wrote:
>>>> Since commit 6ce0d2001692 ("ARM: dma: Use dma_pfn_offset for dma address translation"),
>>>> dma_to_pfn() already returns the PFN with the physical memory start offset
>>>> so we don't need to add it again.
>>>>
>>>> This fixes USB mass storage lock-up problem on systems that can't do DMA
>>>> over the entire physical memory range (e.g.) Keystone 2 systems with 4GB RAM
>>>> can only do DMA over the first 2GB. [K2E-EVM].
>>>>
>>>> What happens there is that without this patch SCSI layer sets a wrong
>>>> bounce buffer limit in scsi_calculate_bounce_limit() for the USB mass
>>>> storage device. dma_max_pfn() evaluates to 0x8fffff and bounce_limit
>>>> is set to 0x8fffff000 whereas maximum DMA'ble physical memory on Keystone 2
>>>> is 0x87fffffff. This results in non DMA'ble pages being given to the
>>>> USB controller and hence the lock-up.
>>>>
>>>> NOTE: in the above case, USB-SCSI-device's dma_pfn_offset was showing as 0.
>>>> This should have really been 0x780000 as on K2e, LOWMEM_START is 0x80000000
>>>> and HIGHMEM_START is 0x800000000. DMA zone is 2GB so dma_max_pfn should be
>>>> 0x87ffff. The incorrect dma_pfn_offset for the USB storage device is because
>>>> USB devices are not correctly inheriting the dma_pfn_offset from the
>>>> USB host controller. This will be fixed by a separate patch.
>>>
>>> I'd like to hear from Santosh, as the author of the original change.
>>> The original commit doesn't mention which platform it was intended for
>>> or what the problem was, which would've been helpful.
>>>
>> From what I recollect, we did these changes to make the max pfn behave
>> same on ARM arch as other archs. This patch was evolved as part of
>> fixing the max*pfn assumption.
>
> To me, the proposed patch _looks_ correct, because...
>
>>>> diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
>>>> index d009f79..bf02dbd 100644
>>>> --- a/arch/arm/include/asm/dma-mapping.h
>>>> +++ b/arch/arm/include/asm/dma-mapping.h
>>>> @@ -111,7 +111,7 @@ static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
>>>> /* The ARM override for dma_max_pfn() */
>>>> static inline unsigned long dma_max_pfn(struct device *dev)
>>>> {
>>>> -	return PHYS_PFN_OFFSET + dma_to_pfn(dev, *dev->dma_mask);
>>>> +	return dma_to_pfn(dev, *dev->dma_mask);
>>>> }
>>>> #define dma_max_pfn(dev) dma_max_pfn(dev)
>> By doing this change I hope we don't break other drivers on Keystone so
>> am not sure about the change.
>
> dma_to_pfn() returns the page frame number referenced from physical
> address zero - the default implementation of dma_to_pfn() is
> bus_to_pfn(), which is __phys_to_pfn(x), which is just x >> PAGE_SHIFT.
> The other thing about dma_to_pfn() is that it should return a
> zero-referenced PFN number, where PFN 0 = physical address 0.
>
> If there is some offset for keystone2, that should be taken care of
> via "dev->dma_pfn_offset", and not offsetting the return value from
> dma_to_pfn().
>
> So I'm 99.9% convinced that the proposed change is correct.
>
I will got with that then :-) and take my objection back. Just
saying that if there other breakages which I can't recollect now,
those drivers needs to be patched as well.
