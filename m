From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 27 Jul 2015 15:05:38 +0100
Subject: [PATCH v3 3/6] iommu: add ARM short descriptor page table
 allocator.
In-Reply-To: <1437970868.25925.20.camel@mhfsdcap03>
References: <1437037475-9065-1-git-send-email-yong.wu@mediatek.com>	
 <1437037475-9065-4-git-send-email-yong.wu@mediatek.com>	
 <20150721171101.GN31095@arm.com> <1437715466.23932.68.camel@mhfsdcap03>	
 <20150724165325.GC21177@arm.com> <1437970868.25925.20.camel@mhfsdcap03>
Message-ID: <55B63AB2.4050006@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/07/15 05:21, Yong Wu wrote:
[...]
>>>>> +static arm_short_iopte
>>>>> +__arm_short_pte_prot(struct arm_short_io_pgtable *data, int prot, bool large)
>>>>> +{
>>>>> +       arm_short_iopte pteprot;
>>>>> +
>>>>> +       pteprot = ARM_SHORT_PTE_S | ARM_SHORT_PTE_nG;
>>>>> +       pteprot |= large ? ARM_SHORT_PTE_TYPE_LARGE :
>>>>> +                               ARM_SHORT_PTE_TYPE_SMALL;
>>>>> +       if (prot & IOMMU_CACHE)
>>>>> +               pteprot |=  ARM_SHORT_PTE_B | ARM_SHORT_PTE_C;
>>>>> +       if (prot & IOMMU_WRITE)
>>>>> +               pteprot |= large ? ARM_SHORT_PTE_LARGE_TEX0 :
>>>>> +                               ARM_SHORT_PTE_SMALL_TEX0;
>>>>
>>>> This doesn't make any sense. TEX[2:0] is all about memory attributes, not
>>>> permissions, so you're making the mapping write-back, write-allocate but
>>>> that's not what the IOMMU_* values are about.
>>>
>>>       I will delete it.
>>
>> Well, can you not control mapping permissions with the AP bits? The idea
>> of the IOMMU flags are:
>>
>>    IOMMU_CACHE : Install a normal, cacheable mapping (you've got this right)
>>    IOMMU_READ : Allow read access for the device
>>    IOMMU_WRITE : Allow write access for the device
>>    IOMMU_NOEXEC : Disallow execute access for the device
>>
>> so the caller to iommu_map passes in a bitmap of these, which you need to
>> encode in the page-table entry.
>
>  From the spec, AP[2] differentiate the read/write and readonly.
> How about this?:
> //===============
>    #define ARM_SHORT_PGD_FULL_ACCESS  (3 << 10)
>    #define ARM_SHORT_PGD_RDONLY       BIT(15)
>
>    pgdprot |= ARM_SHORT_PGD_FULL_ACCESS;/* or other names? */
>    if(!(prot & IOMMU_WRITE) && (prot & IOMMU_READ))
>       pgdprot |= ARM_SHORT_PGD_RDONLY;
> //===============
> pte is the same.
>
> Sorry, Our HW don't meet the standard spec fully. it don't implement the
> AP bits.
>
>>
>>>>> +static int
>>>>> +_arm_short_map(struct arm_short_io_pgtable *data,
>>>>> +              unsigned int iova, phys_addr_t paddr,
>>>>> +              arm_short_iopte pgdprot, arm_short_iopte pteprot,
>>>>> +              bool large)
>>>>> +{
>>>>> +       const struct iommu_gather_ops *tlb = data->iop.cfg.tlb;
>>>>> +       arm_short_iopte *pgd = data->pgd, *pte;
>>>>> +       void *cookie = data->iop.cookie, *pte_va;
>>>>> +       unsigned int ptenr = large ? 16 : 1;
>>>>> +       int i, quirk = data->iop.cfg.quirks;
>>>>> +       bool ptenew = false;
>>>>> +
>>>>> +       pgd += ARM_SHORT_PGD_IDX(iova);
>>>>> +
>>>>> +       if (!pteprot) { /* section or supersection */
>>>>> +               if (quirk & IO_PGTABLE_QUIRK_SHORT_MTK)
>>>>> +                       pgdprot &= ~ARM_SHORT_PGD_SECTION_XN;
>>>>> +               pte = pgd;
>>>>> +               pteprot = pgdprot;
>>>>> +       } else {        /* page or largepage */
>>>>> +               if (quirk & IO_PGTABLE_QUIRK_SHORT_MTK) {
>>>>> +                       if (large) { /* special Bit */
>>>>
>>>> This definitely needs a better comment! What exactly are you doing here
>>>> and what is that quirk all about?
>>>
>>> I use this quirk is for MTK Special Bit as we don't have the XN bit in
>>> pagetable.
>>
>> I'm still not really clear about what this is.
>
> There is some difference between the standard spec and MTK HW,
> Our hw don't implement some bits, like XN and AP.
> So I add a quirk for MTK special.

When you say it doesn't implement these bits, do you mean that having 
them set will lead to Bad Things happening in the hardware, or that it 
will simply ignore them and not enforce any of the protections they 
imply? The former case would definitely want clearly documenting 
somewhere, whereas for the latter case I'm not sure it's even worth the 
complication of having a quirk - if the value doesn't matter there seems 
little point in doing a special dance just for the sake of semantic 
correctness of the in-memory PTEs, in my opinion.

Robin.
