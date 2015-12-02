From: stanimir.varbanov@linaro.org (Stanimir Varbanov)
Date: Wed, 2 Dec 2015 18:47:12 +0200
Subject: [PATCH 2/4] dmaengine: qcom_bam_dma: clear BAM interrupt only if
 it is rised
In-Reply-To: <11168224.Usic9kvUpA@wuerfel>
References: <1448961299-15161-1-git-send-email-stanimir.varbanov@linaro.org>
 <6461444.oollnBsbrb@wuerfel> <565EEA99.3070207@linaro.org>
 <11168224.Usic9kvUpA@wuerfel>
Message-ID: <565F2090.8040103@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/02/2015 03:05 PM, Arnd Bergmann wrote:
> On Wednesday 02 December 2015 14:56:57 Stanimir Varbanov wrote:
>> On 12/01/2015 12:29 PM, Arnd Bergmann wrote:
>>> On Tuesday 01 December 2015 11:14:57 Stanimir Varbanov wrote:
>>>> +       if (srcs & BAM_IRQ) {
>>>>                 clr_mask = readl_relaxed(bam_addr(bdev, 0, BAM_IRQ_STTS));
>>>>  
>>>> -       /* don't allow reorder of the various accesses to the BAM registers */
>>>> -       mb();
>>>> +               /*
>>>> +                * don't allow reorder of the various accesses to the BAM
>>>> +                * registers
>>>> +                */
>>>> +               mb();
>>>>  
>>>> -       writel_relaxed(clr_mask, bam_addr(bdev, 0, BAM_IRQ_CLR));
>>>> +               writel_relaxed(clr_mask, bam_addr(bdev, 0, BAM_IRQ_CLR));
>>>> +       }
>>>>
>>>
>>> I think the comment here should be moved: change the writel_relaxed()
>>> to writel(), which already includes the appropriate barriers, and
>>
>> If we agree with such a change it should be subject to another patch.
> 
> Correct.
> 
>>> add a comment at the readl_relaxed() to explain why it doesn't need
>>> a barrier.
>>
>> Infact I'm not sure that readl_relaxed(BAM_IRQ_STTS) does not need
>> barrier. If I read the code above correctly the mb() should guarantee
>> that all load and store operations before it are happened before the
>> write to BAM_IRQ_CLR register, and on the other hand if we replace
>> writel_relaxed with writel, the writel has wmb() which guarantees only
>> store operations. Did I miss something?
> 
> You are right, we only guarantee that stores to memory are complete
> before we writel() an MMIO register.
> 
> What do you gain from synchronizing reads before an MMIO write?

I don't know just tried to understand the meaning of mb() above.

-- 
regards,
Stan
