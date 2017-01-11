From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 11 Jan 2017 16:50:43 +0000
Subject: [PATCH] arm64: avoid increasing DMA masks above what hardware
 supports
In-Reply-To: <105b0b38-8c48-3355-4951-435c5dca18a4@cogentembedded.com>
References: <11daacde-5399-039f-80a3-01d7bd13e9e8@arm.com>
 <1484056844-9567-1-git-send-email-nikita.yoush@cogentembedded.com>
 <dca35acf-1adf-aa85-7a0b-d0c6ec702fa1@arm.com>
 <67314806-361d-e0ac-9292-37542160ead5@cogentembedded.com>
 <57459a4a-2c57-e081-8f27-cb83f23b5815@arm.com>
 <09cac197-9e57-5d3e-e742-f29c00051813@cogentembedded.com>
 <c5bada32-fbaf-3631-268b-db49dffe3eb9@arm.com>
 <105b0b38-8c48-3355-4951-435c5dca18a4@cogentembedded.com>
Message-ID: <9d75e177-5b34-9e9f-7775-32e6f39a9e88@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/01/17 16:03, Nikita Yushchenko wrote:
> 
> 
> 11.01.2017 17:50, Robin Murphy ?????:
>> On 11/01/17 13:41, Nikita Yushchenko wrote:
>>>> Yes, I think that ought to work, although the __iommu_setup_dma_ops()
>>>> call will still want a real size reflecting the default mask
>>>
>>> I see iommu_dma_ops do not define set_dma_mask.
>>>
>>> So what if setup was done for size reflecting one mask and then driver
>>> changes mask?  Will things still operate correctly?
>>
>> We've overridden dma_set_mask() at the function level, so it should
>> always apply regardless. Besides, none of the arm64 ops implement
>> .set_dma_mask anyway, so we could possibly drop the references to it
>> altogether.
>>
>> Conversely, I suppose we could just implement said callback for
>> swiotlb_dma_ops and iommu_dma_ops with the parent_dma_mask-checking
>> function and drop the HAVE_ARCH_DMA_SET_MASK override instead. I'm not
>> sure which approach is preferable - the latter seems arguably cleaner in
>> isolation, but would also be less consistent with how the coherent mask
>> has to be handled. Ho hum.
> 
> I mean, before patch is applied.
> 
> In the current mainline codebase, arm64 iommu does setup dependent on
> [default] dma_mask, but does not anyhow react on dma mask change.
> 
> I don't know much details about arm64 iommu, but from distant view this
> combination looks incorrect:
> - if behavior of this hardware should depend on dma_mask of device, then
> it should handle mask change,
> - if behavior of this hardware should not depend on dma_mask of device,
> then what for to pass size to it's setup?

Ah, right, I did indeed misunderstand. The IOMMU code is happy with the
DMA masks changing, since it always checks the appropriate one at the
point of IOVA allocation. The initial size given to
__iommu_setup_dma_ops() really just sets up a caching threshold in the
IOVA domain - if there is an explicitly-configured mask, then it's
generally good to set the limit based on that, but otherwise the default
32-bit limit is fine even if the driver subsequently alters the device's
mask(s) before making DMA API calls. Your patch won't actually change
any behaviour in this regard, as long as it still passes a 4GB size by
default.

Robin.
