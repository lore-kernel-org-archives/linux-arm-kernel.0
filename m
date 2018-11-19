From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 19 Nov 2018 19:36:44 +0000
Subject: [PATCH 06/10] swiotlb: use swiotlb_map_page in
 swiotlb_map_sg_attrs
In-Reply-To: <9922f377-ee87-ba36-8d28-26af0f7822e5@arm.com>
References: <20181008080246.20543-1-hch@lst.de>
 <20181008080246.20543-7-hch@lst.de>
 <CANcMJZAzrxA9LGNvP-epv2DwsUacEM_hcgA1n5gmaPuWRJG4iw@mail.gmail.com>
 <20181109074955.GA27489@lst.de>
 <9922f377-ee87-ba36-8d28-26af0f7822e5@arm.com>
Message-ID: <ad8ed3ba-12e8-3031-7c66-035b6d9ad6cd@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/11/2018 16:37, Robin Murphy wrote:
> On 09/11/2018 07:49, Christoph Hellwig wrote:
>> On Tue, Nov 06, 2018 at 05:27:14PM -0800, John Stultz wrote:
>>> But at that point if I just re-apply "swiotlb: use swiotlb_map_page in
>>> swiotlb_map_sg_attrs", I reproduce the hangs.
>>>
>>> Any suggestions for how to further debug what might be going wrong
>>> would be appreciated!
>>
>> Very odd.? In the end map_sg and map_page are defined to do the same
>> things to start with.? The only real issue we had in this area was:
>>
>> "[PATCH v2] of/device: Really only set bus DMA mask when appropriate"
>>
>> so with current mainline + that you still see a problem, and if you
>> rever the commit we are replying to it still goes away?
> 
> OK, after quite a bit of trying I have managed to provoke a 
> similar-looking problem with straight 4.20-rc1 on my Juno board - so far 
> my "reproducer" is to decompress a ~10GB .tar.xz off an external USB 
> hard disk, wherein after somewhere between 5 minutes and half an hour or 
> so it tends to falls over with xz choking on corrupt data and/or a USB 
> error.
> 
>  From the presentation, this really smells like there's some corner in 
> which we're either missing cache maintenance or doing it to the wrong 
> address - I've not seen any issues with Juno's main PCIe-attached I/O, 
> but the EHCI here is non-coherent (and 32-bit, so the bus_dma_mask thing 
> doesn't matter) as are the HiKey UFS and SD controller.
> 
> I'll keep digging...

OK, having brought my Hikey to life and reproduced John's stall with 
rc1, what's going on is that at some point dma_map_sg() returns 0, which 
causes the SCSI/UFS layer to go round in circles repeatedly trying to 
map the same list(s) equally unsuccessfully.

Why does dma_map_sg() fail? Turns out what we all managed to overlook is 
that this patch *does* introduce a subtle change in behaviour, in that 
previously the non-bounced case assigned dev_addr to sg->dma_address 
without looking at it; now with the swiotlb_map_page() call we check the 
return value against DIRECT_MAPPING_ERROR regardless of whether it was 
bounced or not.

Flash back to the other thread when I said "...but I suspect there may 
well be non-IOMMU platforms where DMA to physical address 0 is a thing 
:("? I have the 3GB Hikey where all the RAM is below 32 bits so SWIOTLB 
never ever bounces, but sure enough, guess where that RAM starts...

So in fact it looks like patch #4 technically introduces the first 
instance of this problem, we're just getting lucky not to hit it with a 
map_page/map_single case such that direct_mapping_error() would wrongly 
report failure for page 0. The bad news (for me) is that that can't have 
anything to do with my apparent memory corruption thing above, so now I 
still need to figure out what the hell is going on there.

Robin.
