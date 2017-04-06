From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 6 Apr 2017 15:45:37 +0100
Subject: [PATCH V10 06/12] of: device: Fix overflow of coherent_dma_mask
In-Reply-To: <CAL_JsqLsE378hfs=xNvSdPV2r+7H81cAFzOwtda2W+mFVoohuA@mail.gmail.com>
References: <1489086061-9356-1-git-send-email-sricharan@codeaurora.org>
 <1491301105-5274-1-git-send-email-sricharan@codeaurora.org>
 <1491301105-5274-7-git-send-email-sricharan@codeaurora.org>
 <58E5E7B7.1050400@gmail.com> <b081f333-084d-ffa5-635f-f7f1c0232ac3@arm.com>
 <CAL_JsqLsE378hfs=xNvSdPV2r+7H81cAFzOwtda2W+mFVoohuA@mail.gmail.com>
Message-ID: <ca028e7a-eca5-6ca4-7679-3dc393aa575b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/04/17 14:56, Rob Herring wrote:
> On Thu, Apr 6, 2017 at 5:24 AM, Robin Murphy <robin.murphy@arm.com> wrote:
>> On 06/04/17 08:01, Frank Rowand wrote:
>>> On 04/04/17 03:18, Sricharan R wrote:
>>>> Size of the dma-range is calculated as coherent_dma_mask + 1
>>>> and passed to arch_setup_dma_ops further. It overflows when
>>>> the coherent_dma_mask is set for full 64 bits 0xFFFFFFFFFFFFFFFF,
>>>> resulting in size getting passed as 0 wrongly. Fix this by
>>>> passsing in max(mask, mask + 1). Note that in this case
>>>> when the mask is set to full 64bits, we will be passing the mask
>>>> itself to arch_setup_dma_ops instead of the size. The real fix
>>>> for this should be to make arch_setup_dma_ops receive the
>>>> mask and handle it, to be done in the future.
>>>>
>>>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>>>> ---
>>>>  drivers/of/device.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/of/device.c b/drivers/of/device.c
>>>> index c17c19d..c2ae6bb 100644
>>>> --- a/drivers/of/device.c
>>>> +++ b/drivers/of/device.c
>>>> @@ -107,7 +107,7 @@ void of_dma_configure(struct device *dev, struct device_node *np)
>>>>      ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
>>>>      if (ret < 0) {
>>>>              dma_addr = offset = 0;
>>>> -            size = dev->coherent_dma_mask + 1;
>>>> +            size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
>>>>      } else {
>>>>              offset = PFN_DOWN(paddr - dma_addr);
>>>>              dev_dbg(dev, "dma_pfn_offset(%#08lx)\n", offset);
>>>>
>>>
>>> NACK.
>>>
>>> Passing an invalid size to arch_setup_dma_ops() is only part of the problem.
>>> size is also used in of_dma_configure() before calling arch_setup_dma_ops():
>>>
>>>         dev->coherent_dma_mask = min(dev->coherent_dma_mask,
>>>                                      DMA_BIT_MASK(ilog2(dma_addr + size)));
>>>         *dev->dma_mask = min((*dev->dma_mask),
>>>                              DMA_BIT_MASK(ilog2(dma_addr + size)));
>>>
>>> which would be incorrect for size == 0xffffffffffffffffULL when
>>> dma_addr != 0.  So the proposed fix really is not papering over
>>> the base problem very well.
>>
>> I'm not sure I agree there. Granted, there exist many more problematic
>> aspects than are dealt with here (I've got more patches cooking to sort
>> out some of the other issues we have with dma-ranges), but considering
>> size specifically:
>>
>> - It is not possible to explicitly specify a range with a size of 2^64
>> in DT. If someone does specify a size of 0, they've done a silly thing
>> and should not be surprised that it ends badly.
> 
> And because of this, we allow ~0 (both 32 and 64 bit) in DT dma-ranges
> and fix these up as 2^32 and 2^64 sizes.

...which is what Frank's patch gets rid of.

Robin.

> 
> Rob
> 
