From: Tirumalesh.Chalamarla@caviumnetworks.com (Chalamarla, Tirumalesh)
Date: Wed, 27 Jan 2016 19:05:41 +0000
Subject: iommu/arm-smmu-v2 ASID/VMID calculation
In-Reply-To: <56A75D0A.7000806@arm.com>
References: <198F501C-8D30-4EB5-BC40-4F40BB75D40B@caviumnetworks.com>
 <20160125170312.GJ22927@arm.com>
 <E978AB4F-5CB0-42D8-8152-04C77DB664A1@caviumnetworks.com>
 <6F24A28A-6302-4C48-A933-B47A9735808C@caviumnetworks.com>
 <56A75D0A.7000806@arm.com>
Message-ID: <4074E06E-82EE-45D5-A817-26462CBAADDA@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org






On 1/26/16, 3:48 AM, "Robin Murphy" <robin.murphy@arm.com> wrote:

>On 26/01/16 03:11, Chalamarla, Tirumalesh wrote:
>> one my colleague points out, ASIDPNE also implementation defined.
>
>ASIDPNE only covers whether the SMMU's TLBs may ignore broadcast 
>_invalidation_ or not, not lookups. Broadcast TLB lookups are not a thing.
Agreed.
>
>> Thanks,
>> Tirumalesh.
>>
>>
>>
>> On 1/25/16, 4:48 PM, "linux-arm-kernel on behalf of Chalamarla, Tirumalesh" <linux-arm-kernel-bounces at lists.infradead.org on behalf of Tirumalesh.Chalamarla@caviumnetworks.com> wrote:
>>
>>> I don?t think it followed spec.
>>>
>>> The SMMU spec (IHI0062C) says (section 2.2):
>>>
>>>    - The exact behavior of any TLB functionality is IMPLEMENTATION DEFINED
>>>
>>> Section 2.2 describes the constraints on sharing (e.g. multiple contexts
>>> using the same ASID says):
>>>
>>>       "If multiple context banks have hte same attributes but describe
>>>        different translations, the results of a TLB lookup are UNPREDICTABLE".
>
>Multiple context banks within the same SMMU, that is.
>
>>> The present smmu driver assumes ASID should only be unique per SMMU, this might not be true for all
>>> Implementations.
>
>Where "SMMU" implies "set of context banks behind a single programming 
>interface", i.e. it should be true for all architecturally-compliant 
>implementations.
>
>What if you take your system, fire up two cores with SMP disabled, and 
>run an independent instance of Linux on each, with all the system 
>resources divided up equally between them and no communication? If one 
>OS using one SMMU can make the other OS using a different SMMU go wrong, 
>then the hardware is simply broken. Sure, we can probably quirk ASID 
>allocation in the driver, but it raises the question of what else we 
>would need to do to keep SMMUs which believe they're supposed to be 
>independent from DoS'ing each other..

This analogy is wrong, if 2 different entities running on two cores, SMMU is the least thing that needs to be worried.
Rest aside they must cooperate with each other to coexists. that?s why we needed all the glory Virtualization.  
>
>Robin.
>
>>> On 1/25/16, 9:03 AM, "Will Deacon" <will.deacon@arm.com> wrote:
>>>
>>>> On Thu, Jan 21, 2016 at 06:52:34PM +0000, Chalamarla, Tirumalesh wrote:
>>>>> Hi Will,
>>>>
>>>> Hello,
>>>>
>>>>> Current ASID/VMID calculation logic makes lot of assumption about internal TLB
>>>>> implementation of SMMU,
>>>>
>>>> Not really. It makes assumptions that the hardware follows the architecture,
>>>> which is hardly unreasonable as a starting point.
>>>>
>>>>> Systems like ThunderX have more than one smmu in the system and it can use same
>>>>> TLBs with more than one of them and expects ASID to be unique
>>>>
>>>> ... but that's broken. If you built a system where the CPUs shared a TLB,
>>>> you would run into issues as well.
>>>>
>>>> How does this work with things like arm_smmu_tlb_sync and the TLBGSTATUS
>>>> register?
>>>>
>>>>> Current logic
>>>>>
>>>>> #define ARM_SMMU_CB_ASID(cfg)           ((cfg)->cbndx)
>>>>> #define ARM_SMMU_CB_VMID(cfg)           ((cfg)->cbndx + 1)
>>>>>
>>>>>
>>>>> Can this be replaced by something like
>>>>>
>>>>>
>>>>> #define ARM_SMMU_CB_ASID(cfg, smmu)             (((smmu)->idx << (smmu)->asid_shift) | (cfg)->cbndx)
>>>>> #define ARM_SMMU_CB_VMID(cfg, smmu)             (((smmu)->idx << (smmu)->vmid_shift) | (cfg)->cbndx + 1)
>>>>>
>>>>>
>>>>> Idx and shift can be passed from device-tree.
>>>>>
>>>>>
>>>>> Please let me know if this is acceptable, I will prepare a proper patch
>>>>> and send to list.
>>>>>
>>>>>
>>>>> If this is not acceptable through an alternative suggestion.
>>>>
>>>> If we're going to put something into the device-tree, then it should be
>>>> an erratum property describing the offset to be applied to ASID/VMIDs.
>>>> You also need to take care not to describe overlapping numberspaces.
>>> I don?t think that is an errata.
>>>>
>>>> How many context banks do you implement in each SMMU?
>>> 128.
>>>>
>>>> Will
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel at lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>> _______________________________________________
>> iommu mailing list
>> iommu at lists.linux-foundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>>
>
