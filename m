From: sgoel@codeaurora.org (Goel, Sameer)
Date: Fri, 11 May 2018 10:15:03 -0600
Subject: [PATCH] iommu/arm-smmu-v3: Set GBPA to abort all transactions
In-Reply-To: <265a41d4-ec3c-6697-0340-6830807ea10f@arm.com>
References: <1522247980-31892-1-git-send-email-timur@codeaurora.org>
 <3350f0eb84c8c621cf43aa06ed117cfb@www.loen.fr>
 <3772fb2d-01b7-4820-6d13-a0263654dabc@codeaurora.org>
 <438a6180-fca8-d3a1-985f-e595529911f3@arm.com>
 <7756f245-6c63-92d4-d101-4040a45b660b@arm.com>
 <265a41d4-ec3c-6697-0340-6830807ea10f@arm.com>
Message-ID: <22143dc9-4110-3278-3148-66ca5f3d102e@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 4/12/2018 5:56 AM, Marc Zyngier wrote:
> On 12/04/18 11:17, Robin Murphy wrote:
>> On 11/04/18 17:54, Marc Zyngier wrote:
>>> Hi Sammer,
>>>
>>> On 11/04/18 16:58, Goel, Sameer wrote:
>>>>
>>>>
>>>> On 3/28/2018 9:00 AM, Marc Zyngier wrote:
>>>>> On 2018-03-28 15:39, Timur Tabi wrote:
>>>>>> From: Sameer Goel <sgoel@codeaurora.org>
>>>>>>
>>>>>> Set SMMU_GBPA to abort all incoming translations during the SMMU reset
>>>>>> when SMMUEN==0.
>>>>>>
>>>>>> This prevents a race condition where a stray DMA from the crashed primary
>>>>>> kernel can try to access an IOVA address as an invalid PA when SMMU is
>>>>>> disabled during reset in the crash kernel.
>>>>>>
>>>>>> Signed-off-by: Sameer Goel <sgoel@codeaurora.org>
>>>>>> ---
>>>>>>  ?drivers/iommu/arm-smmu-v3.c | 12 ++++++++++++
>>>>>>  ?1 file changed, 12 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>>>>>> index 3f2f1fc68b52..c04a89310c59 100644
>>>>>> --- a/drivers/iommu/arm-smmu-v3.c
>>>>>> +++ b/drivers/iommu/arm-smmu-v3.c
>>>>>> @@ -2458,6 +2458,18 @@ static int arm_smmu_device_reset(struct
>>>>>> arm_smmu_device *smmu, bool bypass)
>>>>>>  ???? if (reg & CR0_SMMUEN)
>>>>>>  ???????? dev_warn(smmu->dev, "SMMU currently enabled! Resetting...\n");
>>>>>>
>>>>>> +??? /*
>>>>>> +???? * Abort all incoming translations. This can happen in a kdump case
>>>>>> +???? * where SMMU is initialized when a prior DMA is pending. Just
>>>>>> +???? * disabling the SMMU in this case might result in writes to invalid
>>>>>> +???? * PAs.
>>>>>> +???? */
>>>>>> +??? ret = arm_smmu_update_gbpa(smmu, 1, GBPA_ABORT);
>>>>>> +??? if (ret) {
>>>>>> +??????? dev_err(smmu->dev, "GBPA not responding to update\n");
>>>>>> +??????? return ret;
>>>>>> +??? }
>>>>>> +
>>>>>>  ???? ret = arm_smmu_device_disable(smmu);
>>>>>>  ???? if (ret)
>>>>>>  ???????? return ret;
>>>>>
>>>>> A tangential question: can we reliably detect that the SMMU already
>>>>> has valid mappings, which would indicate that we're in a pretty bad
>>>>> shape already by the time we set that bit? For all we know, memory
>>>>> could have been corrupted long before we hit this point, and this
>>>>> patch barely narrows the window of opportunity.
>>>>
>>>> :) Yes that is correct. This only covers the kdump scenario. Trying
>>>> to get some reliability when booting up the crash kernel. The system
>>>> is already in a bad state. I don't think that this will happen in a
>>>> normal scenario. But please point me to the GICv3 change and I'll
>>>> have a look.
>>>
>>> See this:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/tree/drivers/irqchip/irq-gic-v3-its.c?h=irq/irqchip-4.17&id=6eb486b66a3094cdcd68dc39c9df3a29d6a51dd5#n3407
>>
>> The nearest equivalent to that is probably the top-level SMMUEN check 
>> that we already have (see the diff context above). To go beyond that 
>> you'd have to chase the old stream table pointer and scan the whole 
>> thing looking for valid contexts, then potentially walk page tables 
>> within those contexts to check for live translations if you really 
>> wanted to be sure. That would be a hell of a lot of work to do in the 
>> boot path.
> Yeah, feels a bit too involved for sanity. I'd simply suggest you taint
> the kernel if you find the SMMU enabled, as you're already on shaky ground.

Ok. I think since this is a kdump kernel a taint is not necessary?
> 
> Thanks,
> 
> 	M.
> 

-- 
 Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc. Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
