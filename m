From: tfiga@chromium.org (Tomasz Figa)
Date: Wed, 17 Jan 2018 16:16:49 +0900
Subject: [PATCH v2 01/13] iommu/rockchip: Request irqs in rk_iommu_probe()
In-Reply-To: <5A5EF672.6040304@rock-chips.com>
References: <20180116132540.18939-1-jeffy.chen@rock-chips.com>
 <20180116132540.18939-2-jeffy.chen@rock-chips.com>
 <CAAFQd5AO6_GYMs0xac-4ECFH9pn_ssg8jsFVoif0WDQ-daSuRA@mail.gmail.com>
 <5A5EF672.6040304@rock-chips.com>
Message-ID: <CAAFQd5Bnv3cLJ0wWY4+LJ+0GzDcm0F9QArY+QfFg692hd6UPjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 17, 2018 at 4:08 PM, JeffyChen <jeffy.chen@rock-chips.com> wrote:
> Hi Tomasz,
>
> Thanks for your reply.
>
> On 01/17/2018 12:21 PM, Tomasz Figa wrote:
>>
>> Hi Jeffy,
>>
>> Thanks for the patch. Please see my comments inline.
>>
>> On Tue, Jan 16, 2018 at 10:25 PM, Jeffy Chen <jeffy.chen@rock-chips.com>
>> wrote:
>>
>> Please add patch description.
>
>
> ok, will do.
>>
>>
>>> Suggested-by: Robin Murphy <robin.murphy@arm.com>
>>> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>>> ---
>>
>> [snip]
>>>
>>> -       for (i = 0; i < iommu->num_irq; i++) {
>>> -               iommu->irq[i] = platform_get_irq(pdev, i);
>>> -               if (iommu->irq[i] < 0) {
>>> -                       dev_err(dev, "Failed to get IRQ, %d\n",
>>> iommu->irq[i]);
>>> +       num_irq = of_irq_count(dev->of_node);
>>> +       for (i = 0; i < num_irq; i++) {
>>> +               irq = platform_get_irq(pdev, i);
>>
>>
>> This lacks consistency. of_irq_count() is used for counting, but
>> platform_get_irq() is used for getting. Either platform_ or of_ API
>> should be used for both and I'd lean for platform_, since it's more
>> general.
>
> hmmm, right, i was thinking of removing num_irq, and do something like:
> while (nr++) {
>   err = platform_get_irq(dev, nr);
>   if (err == -EPROBE_DEFER)
>      break;
>   if (err < 0)
>      return err;
>   ....
> }
>
> but forgot to do that..

Was there anything wrong with platform_irq_count() used by existing code?

>
>>
>>> +               if (irq < 0) {
>>> +                       dev_err(dev, "Failed to get IRQ, %d\n", irq);
>>>                          return -ENXIO;
>>>                  }
>>> +               err = devm_request_irq(iommu->dev, irq, rk_iommu_irq,
>>> +                                      IRQF_SHARED, dev_name(dev),
>>> iommu);
>>> +               if (err)
>>> +                       return err;
>>>          }
>>
>>
>> Looks like there is some more initialization below. Is the driver okay
>> with the IRQ being potentially fired right here? (Shared IRQ handlers
>> might be run at request_irq() time for testing.)
>>
> right, forget about that. maybe we can check iommu->domain not NULL in
> rk_iommu_irq()

Maybe we could just move IRQ requesting to the end of probe?

Best regards,
Tomasz
