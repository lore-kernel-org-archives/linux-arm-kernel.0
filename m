From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 30 Apr 2018 12:41:52 +0100
Subject: [PATCH v2 2/5] dma-mapping: Introduce dma_iommu_detach_device()
 API
In-Reply-To: <20180430110231.GF2476@ulmo>
References: <20180425101051.15349-1-thierry.reding@gmail.com>
 <20180425101051.15349-2-thierry.reding@gmail.com>
 <20180425151934.GC16075@infradead.org> <20180426121136.GD11985@ulmo>
 <20180430110231.GF2476@ulmo>
Message-ID: <e549979d-9f53-a329-da1a-ed5139958762@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/04/18 12:02, Thierry Reding wrote:
> On Thu, Apr 26, 2018 at 02:11:36PM +0200, Thierry Reding wrote:
>> On Wed, Apr 25, 2018 at 08:19:34AM -0700, Christoph Hellwig wrote:
>>> On Wed, Apr 25, 2018 at 12:10:48PM +0200, Thierry Reding wrote:
>>>> From: Thierry Reding <treding@nvidia.com>
>>>>
>>>> The dma_iommu_detach_device() API can be used by drivers to forcibly
>>>> detach a device from an IOMMU that architecture code might have attached
>>>> to. This is useful for drivers that need explicit control over the IOMMU
>>>> using the IOMMU API directly.
>>>
>>> Given that no one else implements it making it a generic API seems
>>> rather confusing.  For now I'd rename it to
>>> arm_dma_iommu_detach_device() and only implement it in arm.
>>
>> That'd be suboptimal because this code is used on both 32-bit and 64-bit
>> ARM. If we make the function 32-bit ARM specific then the driver code
>> would need to use an #ifdef to make sure compilation doesn't break on
>> 64-bit ARM.
> 
> Do you still want me to make this ARM specific? While I haven't
> encountered this issue on 64-bit ARM yet, I think it would happen there
> as well, under the right circumstances. I could take a shot at
> implementing the equivalent there (which means essentially implementing
> it for drivers/iommu/dma-iommu.c and calling that from 64-bit ARM code).

It sounds like things are getting a bit backwards here: iommu-dma should 
have nothing to do with this, since if you've explicitly attached the 
device to your own IOMMU domain then you're already bypassing everything 
it knows about and has control over. Arch code calling into iommu-dma to 
do something which makes arch code not use iommu-dma makes very little 
sense.

AFAICS the only aspect of arm_iommu_detach_device() which actually 
matters in this case is the set_dma_ops() bit, so what we're really 
after is a generic way for drivers to say "Hey, I actually have my own 
MMU (or want to control the one you already know about) so please give 
me direct DMA ops", which the arch code handles as appropriate (maybe 
it's also allowed to fail in cases like swiotlb=force or when there is 
RAM beyond the device's DMA mask).

Robin.
