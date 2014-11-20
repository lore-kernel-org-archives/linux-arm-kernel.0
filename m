From: dingtianhong@huawei.com (Ding Tianhong)
Date: Thu, 20 Nov 2014 17:21:23 +0800
Subject: For the problem when using swiotlb
In-Reply-To: <2121725.INdNoXW7GO@wuerfel>
References: <5469E26B.2010905@huawei.com> <2522857.bNQToYpBNt@wuerfel>
 <546DA795.9080209@huawei.com> <2121725.INdNoXW7GO@wuerfel>
Message-ID: <546DB293.1040500@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/11/20 17:02, Arnd Bergmann wrote:
> On Thursday 20 November 2014 16:34:29 Ding Tianhong wrote:
>>>
>>> I didn't mean the dma_pfn_offset. The problem is that the of_dma_configure
>>> code currently doesn't look at the mask. As I explained in my reply to
>>> Catalin, it should set the mask to the size of the dma-ranges if that is
>>> 32-bit or smaller, and dma_set_mask should look at the same dma-ranges
>>> property to decide what to set the mask to when a driver asks for a
>>> mask larger than 64-bit.
>>>
>> ok, I think the your reply to catalin is clear, I got it, add a
>> appropriate mask for the dev is
>> reasonable, I think it should be fixed later.
>>
>> But in my case, if I don't use the DMA_CMA, the dma_alloc_coherent
>> should use the swiotlb directly which maximum is 16M,
>> so unless I use the kmalloc otherwise I have no better idea for that.
> 
> But if you just change your driver to set the 64-bit DMA mask,
> it will no longer use the swiotlb and work much faster without
> that. You have to do it anyway, even once we fix the architecture
> code.
> 

Yes, I did, it is useful, thanks.

> The fix in the architecture code is just required so things don't
> break if you have a 64-bit DMA capable device on a 32-bit bus.
> 
> On a related note, we should really fix the network and scsi core
> code not lot just look at PCI_DMA_BUS_IS_PHYS but check the presence
> of an IOMMU for devices that are limited to 32-bit DMA, so we fall
> back to block bounce and lowmem SKB instead of swiotlb for IOMMU-less
> devices.
> 
agree.

> Which driver are you using BTW?
> 
soc ppe drivers which is not upstream yet, and sas drivers.

> 	Arnd

Regards
Ding

> 
> .
> 
