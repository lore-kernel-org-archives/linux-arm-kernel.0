From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 24 Jan 2017 16:29:42 +0000
Subject: [RFC 2/4] irqchip, gicv3-its:Workaround for HiSilicon erratum
 161010801
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA8174AC5FC@lhreml504-mbs>
References: <5886262C.6070108@huawei.com> <58875B0D.4080303@huawei.com>
 <aa915b29-453f-6817-500f-1c6b457c0368@arm.com>
 <5f303abc-209b-3828-ca8c-4ec0977f89ea@arm.com>
 <5FC3163CFD30C246ABAA99954A238FA8174AC552@lhreml504-mbs>
 <9764b04c-f610-ecca-e4ee-021d16371d7d@arm.com>
 <5FC3163CFD30C246ABAA99954A238FA8174AC5FC@lhreml504-mbs>
Message-ID: <df0b6b06-cf44-3ddf-c4f0-e0cc24399f61@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/01/17 16:14, Shameerali Kolothum Thodi wrote:
>>>>> Let's contemplate this for a moment. If we're on the affected ITS,
>>>> we're
>>>>> using the physical address of the GITS_TRANSLATER register. What
>>>>> guarantees that this is not going to conflict with an IOVA that DMA
>>>> is
>>>>> going to use? From looking at these patches, my feeling is "not
>>>> much".
>>>>>
>>>>> So if I'm right, you're opening the door to some interesting memory
>>>>> corruption if the two regions ever intersect.
>>>>>
>>>>> Robin, what do you think?
>>>>
>>>> Yup. Unless the ITS physical address is actually reserved from the
>>>> IOVA domain, it's still free to be allocated for DMA mappings, and
>> if
>>>> that ever happens then you'll get odd bits of data landing in the
>> ITS
>>>> instead of RAM, and maybe even locked-up devices or worse if the
>>>> doorbell gives back decode errors on read attempts. It's essentially
>>>> the exact same problem as we have with memory-mapped PCI windows,
>> and
>>>> needs to be solved in the same fashion, i.e. between the SMMU and
>> the
>>>> IOMMU-DMA code.
>>>
>>> Is this something that can incorporated in Eric's latest patch
>> series[1]?
>>> It does mentions reserved regions can be:
>>> - directly mapped regions
>>> - regions that cannot be iommu mapped (PCI host bridge windows, ...)
>>> - MSI regions (because they belong to another address space or
>> because
>>>   they are not translated by the IOMMU and need special handling)
>>>
>>> Though I am not clear our case comes under "the MSI regions that are
>>> not translated by the IOMMU and need special handling" or not.
>>
>> Well, given that in your case, the IOMMU never sees the MSI write, it
>> definitely falls into the "not translated" category.
>>
>> As for handling it on top of Eric's series, that's probably the most
>> reasonable thing to do, which also means that none of this should
>> appear in the ITS driver. Robin seems to have an idea on how to
>> approach this.
> 
> Ok. Thanks for that Marc/Robin.
> 
> But I am not sure we can get away with ITS driver. Because current vfio
> patch series[1] treats GICV3 ITS as irq safe and is setting 
> IRQ_DOMAIN_FLAG_MSI_REMAP in ITS driver. But this is not the case with
> our ITS. 

The ITS itself is perfectly safe, as it does perform device isolation
just fine (at least as far as I can tell from this bug description).

There is two things we need to take care of:
- When the device is used on the host, the hardwired MSI region must be
excluded from the DMA IOVA allocator, and the iommu_dma_map_msi_msg()
call becomes a NOP.
- When the device is assigned to VFIO, the MSI region must be exposed to
userspace through /sys so that it knows that the guest RAM cannot alias
with this region (or face the corruption we've talked about above).

None of that actually involves the ITS. Eric's stuff has some of the
initial infrastructure, but there is of course more to it. I'll let
Robin chime in and correct me if I've missed something (very likely).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
