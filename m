From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 22 Apr 2016 16:40:20 +0100
Subject: [PATCH v7 6/7] iommu/arm-smmu: do not advertise
 IOMMU_CAP_INTR_REMAP
In-Reply-To: <571A0D61.5010009@linaro.org>
References: <1461086687-2658-1-git-send-email-eric.auger@linaro.org>
 <1461086687-2658-7-git-send-email-eric.auger@linaro.org>
 <571A080A.4040406@arm.com> <571A0D61.5010009@linaro.org>
Message-ID: <571A45E4.5050006@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/04/16 12:39, Eric Auger wrote:
> Hi Robin,
> On 04/22/2016 01:16 PM, Robin Murphy wrote:
>> Hi Eric, Alex,
>>
>> On 19/04/16 18:24, Eric Auger wrote:
>>> Do not advertise IOMMU_CAP_INTR_REMAP for arm-smmu(-v3). Indeed the
>>> irq_remapping capability is abstracted on irqchip side for ARM as
>>> opposed to Intel IOMMU featuring IRQ remapping HW.
>>>
>>> So to check IRQ remapping capability, the msi domain needs to be
>>> checked instead.
>>>
>>> This commit needs to be applied after "vfio/type1: also check IRQ
>>> remapping capability at msi domain" else the legacy interrupt
>>> assignment gets broken with arm-smmu.
>>
>> Hmm, that smells of papering over a different problem. I may have missed
>> it, but I don't see anything changing legacy interrupt behaviour in this
>> series - are legacy INTx (or platform) interrupts intrinsically safe
>> because they're physically wired, or intrinsically unsafe because they
>> could be shared?
>
> I think it is safe. With legacy/platform interrupts we have:
> vfio pci driver physical IRQ handler signals an irqfd.
> upon this irqfd signaling KVM injects a virtual IRQ.
>
> So the assigned device does not have any way to trigger a storm of
> interrupts on the host, as opposed to with MSI.
>
> Does it make sense to you?

I think so, thanks for the explanation. In that case, I'm strongly in 
favour of applying this patch and un-breaking legacy interrupts 
regardless of MSI support. I'll keep investigating to see what I can 
figure out.

Robin.

> Best Regards
>
> Eric
>
>   If it's the latter then I don't see how the IOMMU or
>> MSI controller changes anything in that respect, and if it's the former
>> then surely we should support that right now without the SMMU having to
>> lie about MSI isolation? I started looking into it but I'm a bit lost...
>>
>> Robin.
>>
>>> Signed-off-by: Eric Auger <eric.auger@linaro.org>
>>> ---
>>>    drivers/iommu/arm-smmu-v3.c | 3 ++-
>>>    drivers/iommu/arm-smmu.c    | 3 ++-
>>>    2 files changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>>> index afd0dac..1d0106c 100644
>>> --- a/drivers/iommu/arm-smmu-v3.c
>>> +++ b/drivers/iommu/arm-smmu-v3.c
>>> @@ -1386,7 +1386,8 @@ static bool arm_smmu_capable(enum iommu_cap cap)
>>>        case IOMMU_CAP_CACHE_COHERENCY:
>>>            return true;
>>>        case IOMMU_CAP_INTR_REMAP:
>>> -        return true; /* MSIs are just memory writes */
>>> +        /* interrupt translation handled at MSI controller level */
>>> +        return false;
>>>        case IOMMU_CAP_NOEXEC:
>>>            return true;
>>>        default:
>>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>>> index 492339f..6232b2a 100644
>>> --- a/drivers/iommu/arm-smmu.c
>>> +++ b/drivers/iommu/arm-smmu.c
>>> @@ -1312,7 +1312,8 @@ static bool arm_smmu_capable(enum iommu_cap cap)
>>>             */
>>>            return true;
>>>        case IOMMU_CAP_INTR_REMAP:
>>> -        return true; /* MSIs are just memory writes */
>>> +        /* interrupt translation handled at MSI controller level */
>>> +        return false;
>>>        case IOMMU_CAP_NOEXEC:
>>>            return true;
>>>        default:
>>>
>>
>
