From: thunder.leizhen@huawei.com (leizhen)
Date: Mon, 25 May 2015 10:07:17 +0800
Subject: [PATCH 2/3] iommu/arm-smmu: Add initial driver support for ARM
 SMMUv3 devices
In-Reply-To: <20150521112555.GH21920@arm.com>
References: <1431108046-9675-1-git-send-email-will.deacon@arm.com>
 <1431108046-9675-3-git-send-email-will.deacon@arm.com>
 <5551AE56.6050906@huawei.com> <20150512165500.GE2062@arm.com>
 <55530C4F.5000605@huawei.com> <20150521112555.GH21920@arm.com>
Message-ID: <556283D5.4030901@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/5/21 19:25, Will Deacon wrote:
> Hi again,
> 
> Sorry for the delay in replying, I've been tied up with other stuff.
> 
> On Wed, May 13, 2015 at 09:33:19AM +0100, leizhen wrote:
>> On 2015/5/13 0:55, Will Deacon wrote:
>>> The purpose of the two level approach isn't to save memory; it's to remove
>>> the need for a single (large) contiguous block. Furthermore, we need all
>>> master devices in the system to come up in a state where their transactions
>>> bypass the SMMU (i.e. we don't require them to use the SMMU for
>>> translation). Achieving this necessitates a fully-populated stream-table
>>> before any DMA occurs.
>>
>> OK, but for non-pci devices(maybe pci devices also), initialize all
>> devices(StreamIDs) to bypass mode maybe incorrect. Some devices maybe
>> capable bring attributes by itself, and access different memory with
>> different attributes(device attribute or cacheable attribute); some
>> devices maybe not capable bring attributes by itself, but need access
>> memory with cacheable attribute only, so we should set STE.MTCFG = 1.
>> Provide dts configuration will be better.
> 
> If we want to make use of memory overrides, then I think we should add
> that as a separate patch because it would have implications on the IOMMU
> API. I don't particularly like putting this policy information in the
> device-tree binding on a per-driver basis.

OK. I will reconsider.

> 
>> Furthermore, I don't agree initialize all devices to bypass by default.
>> Suppose a non-pci device's StreamID can be dynamic configured. We require
>> StreamID-A, but the device actually issue StreamID-B because of software
>> configuration fault. We really hope SMMU can report Bad StreamID fault.
> 
> I think the default behaviour has to be to bypass by default, otherwise
> we can break DMA for any devices behind an SMMU but not attached to an
> IOMMU domain. How about I add a cmdline parameter to change the default
> behaviour?
> 

Sure, so that people can choose by themselves. The cmdline parameter will be good
for non-pci devices.

>>> I suppose we could look into populating it based on the ->add_device
>>> callback, which currently does have some range checks
>>> (arm_smmu_sid_in_range). Is that what you had in mind?
>>
>> Yes, maybe attach_dev. But we should allocated the whole Lv1 table base on
>> SMMU_IDR1.SIDSIZE
> 
> I think it needs to be in add_device so that we can implement the default

OK

> bypass case. We could even have one L2 table per PCI bus, but I need to
> think about how big the L1 table should be.
> 
>>>>> +             if (!desc->l2ptr) {
>>>>> +                     dev_err(smmu->dev,
>>>>> +                             "failed to allocate l2 stream table %u\n", i);
>>>>> +                     ret = -ENOMEM;
>>>>> +                     goto out_free_l2;
>>>>> +             }
>>>>> +
>>>>> +             arm_smmu_init_bypass_stes(desc->l2ptr, 1 << STRTAB_SPLIT);
>>>>> +             arm_smmu_write_strtab_l1_desc(strtab, desc);
>>>>> +             strtab += STRTAB_STE_DWORDS;
>>>>> +     }
>>>>> +
>>>>> +     return 0;
>>>>> +
>>>>> +out_free_l2:
>>>>> +     arm_smmu_free_l2_strtab(smmu);
>>>>> +     return ret;
>>>>> +}
>>>>> +
>>>>> +static int arm_smmu_init_strtab(struct arm_smmu_device *smmu)
>>>>> +{
>>>>> +     void *strtab;
>>>>> +     u64 reg;
>>>>> +     u32 size;
>>>>> +     int ret = 0;
>>>>> +
>>>>> +     strtab = dma_zalloc_coherent(smmu->dev, 1 << STRTAB_L1_SZ_SHIFT,
>>>>> +                                  &smmu->strtab_cfg.strtab_dma, GFP_KERNEL);
>>>>
>>>> As above, when Lv2 tables are dynamic allocation, we can create Lv1 table
>>>> base on SMMU_IDR1.SIDSIZE and support non-pic devices. Oh, if SIDSIZE is
>>>> too large, like 32. Maybe we should use 64K size Lv2 table.  But we can
>>>> only use PAGE_SIZE first, for lazy.
>>>
>>> Right now, the l2 tables are 4k and l1 table is 8k. That's (a) nice for
>>> allocation on a system with 4k pages and (b) enough to cover a PCI host
>>> controller. The problem with supporting 32-bit SIDs is that the l1 will
>>> become a sizeable contiguous chunk which we'll have to allocate
>>> regardless.
>>>
>>> So, if we keep the l2 size at 4k for the moment, how big would you like
>>> the l1? For a 32-bit numberspace, it would be 4MB, which I don't think is
>>> practical.
>>
>> Yes, because I don't think SMMU_IDR1.SIDSIZE = 32 really exist, so I said
>> use PAGE_SIZE first.
> 
> Well, I certainly wouldn't rule anything out.
> 
>> But now, this patch only support SMMU_IDR1.SIDSIZE <= 16. Suppose
>> SMMU_IDR1.SIDSIZE = 25?Lv2 table size at 4K, then Lv1 table need 2^(25 -
>> 6 + 3) = 2^22 = 4M. If we pre-allocated all Lv2 table, we need 2^25 * 64 =
>> 2^31 = 2G, that's too big. So we must only allocate Lv2 table when we
>> needed.
> 
> I agree that's way too big, but I have limited things to 16-bit for a reason
> ;)
> 
>> If SMMU_IDR1.SIDSIZE = 32 really exist(or too big), we need dynamic choose
>> Lv2 table size(4K,16K,64K).  Because Lv1 table maybe too big, and can not
>> be allocated by current API, a dts configuration should be added, like
>> lv1-table-base = <0x0 0x0>, and we use ioremap_cache get VA(maybe ioremap,
>> for non-coherent SMMU).
>>
>> Oh, I can do it after your patches upstreamed, because this problem maybe
>> only I met.
> 
> I'll have a think about this and see what I can come up with for version
> 2 of the patch. I'd like to avoid adding additional properties to the DT
> until they're actually needed, though.

OK. Will you support non-pci devices in patch version 2?

> 
>>>>> +     /* Invalidate any cached configuration */
>>>>> +     cmd.opcode = CMDQ_OP_CFGI_ALL;
>>>>> +     arm_smmu_cmdq_issue_cmd(smmu, &cmd);
>>>>> +     cmd.opcode = CMDQ_OP_CMD_SYNC;
>>>>> +     arm_smmu_cmdq_issue_cmd(smmu, &cmd);
>>>>> +
>>>>> +     /* Invalidate any stale TLB entries */
>>>>> +     cmd.opcode = CMDQ_OP_TLBI_EL2_ALL;
>>>>
>>>> Do we need to execute CMDQ_OP_TLBI_EL2_ALL? Linux only run at EL1. It at
>>>> least rely on SMMU_IDR0.Hyp
>>>
>>> The SMMU isn't guaranteed to come up clean out of reset, so it's a good
>>> idea to perform this invalidation in case of junk in the TLB. Given that
>>> Linux owns the stage-2 translation, then this is the right place to do it.
>>
>> OK. But it should be controled by SMMU_IDR0.Hyp. I means:
>> if (SMMU_IDR0.Hyp)
>>         execute command CMDQ_OP_TLBI_EL2_ALL
>>
>> When SMMU_IDR0.Hyp=?0?, this command causes CERROR_ILL
> 
> Well spotted, thanks!
> 
> Will
> 
> .
> 
