From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 24 Jan 2017 16:30:29 +0000
Subject: [RFC 2/4] irqchip, gicv3-its:Workaround for HiSilicon erratum
 161010801
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA8174AC5FC@lhreml504-mbs>
References: <5886262C.6070108@huawei.com> <58875B0D.4080303@huawei.com>
 <aa915b29-453f-6817-500f-1c6b457c0368@arm.com>
 <5f303abc-209b-3828-ca8c-4ec0977f89ea@arm.com>
 <5FC3163CFD30C246ABAA99954A238FA8174AC552@lhreml504-mbs>
 <9764b04c-f610-ecca-e4ee-021d16371d7d@arm.com>
 <5FC3163CFD30C246ABAA99954A238FA8174AC5FC@lhreml504-mbs>
Message-ID: <0a89ccd6-213f-98c5-e883-976a49c3f7d3@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/01/17 16:14, Shameerali Kolothum Thodi wrote:
> 
> 
>> -----Original Message-----
>> From: Marc Zyngier [mailto:marc.zyngier at arm.com]
>> Sent: Tuesday, January 24, 2017 3:50 PM
>> To: Shameerali Kolothum Thodi; Robin Murphy; mark.rutland at arm.com;
>> will.deacon at arm.com; eric.auger at redhat.com
>> Cc: linux-arm-kernel at lists.infradead.org; Linuxarm; linux-
>> kernel at vger.kernel.org; devicetree at vger.kernel.org; John Garry;
>> Guohanjun (Hanjun Guo)
>> Subject: Re: [RFC 2/4] irqchip, gicv3-its:Workaround for HiSilicon
>> erratum 161010801
>>
>> On 24/01/17 15:39, Shameerali Kolothum Thodi wrote:
>>> +Eric
>>>
>>>> -----Original Message-----
>>>> From: Robin Murphy [mailto:robin.murphy at arm.com]
>>>> Sent: Tuesday, January 24, 2017 2:42 PM
>>>> To: Marc Zyngier; Shameerali Kolothum Thodi; mark.rutland at arm.com;
>>>> will.deacon at arm.com
>>>> Cc: linux-arm-kernel at lists.infradead.org; Linuxarm; linux-
>>>> kernel at vger.kernel.org; devicetree at vger.kernel.org; John Garry;
>>>> Guohanjun (Hanjun Guo)
>>>> Subject: Re: [RFC 2/4] irqchip, gicv3-its:Workaround for HiSilicon
>>>> erratum 161010801
>>>>
>>>> On 24/01/17 14:11, Marc Zyngier wrote:
>>>>> + Robin,
>>>>>
>>>>> On 24/01/17 13:47, Shameerali Kolothum Thodi wrote:
>>>>>> The HiSilicon erratum 161010801 describes the limitation of
>> certain
>>>>>> HiSilicon platforms to support the SMMU mappings for MSI
>>>> transactions.
>>>>>>
>>>>>> On these platforms GICv3 ITS translator is presented with the
>>>> deviceID
>>>>>> by extending the MSI payload data to 64 bits to include the
>>>> deviceID.
>>>>>> Hence, the PCIe controller on this platforms has to differentiate
>>>> the
>>>>>> MSI payload against other DMA payload and has to modify the MSI
>>>> payload.
>>>>>> This basically makes it difficult for this platforms to have a
>> SMMU
>>>>>> translation for MSI. Also these platforms doesn't have a proper
>>>>>> IIDR register to use the existing IIDR based quirk mechanism.
>>>>>>
>>>>>> This workaround based on the devicetree binding property, supports
>>>>>> bypassing the SMMU for the MSI transactions on this platforms.
>>>>>>
>>>>>> Signed-off-by: shameer <shameerali.kolothum.thodi@huawei.com>
>>>>>> ---
>>>>>>  arch/arm64/Kconfig               | 15 ++++++++++++
>>>>>>  drivers/irqchip/irq-gic-common.h |  1 +
>>>>>> drivers/irqchip/irq-gic-v3-its.c | 52
>>>> +++++++++++++++++++++++++++++++++++++++-
>>>>>>  3 files changed, 67 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig index
>>>>>> 0ae0427..8d600b0 100644
>>>>>> --- a/arch/arm64/Kconfig
>>>>>> +++ b/arch/arm64/Kconfig
>>>>>> @@ -485,6 +485,21 @@ config CAVIUM_ERRATUM_27456
>>>>>>
>>>>>>  	  If unsure, say Y.
>>>>>>
>>>>>> +config HISILICON_ERRATUM_161010801
>>>>>> +	bool "HiSilicon erratum 161010801"
>>>>>> +	default y
>>>>>> +	help
>>>>>> +	  Enable workaround for erratum 161010801.
>>>>>> +
>>>>>> +	  This implements a gicv3-its errata workaround for
>> HiSilicon
>>>>>> +	  platforms Hip05/Hip07. These platforms cannot support the
>> MSI
>>>>>> +	  interrupt remapping and MSI transaction has to be
>> bypassed by
>>>> SMMU.
>>>>>> +
>>>>>> +	  The fix is to avoid calling the remapping hook into the
>> SMMU
>>>>>> +	  driver from the its_irq_compose_msi_msg().
>>>>>> +
>>>>>> +	  If unsure, say Y.
>>>>>> +
>>>>>>  endmenu
>>>>>>
>>>>>>
>>>>>> diff --git a/drivers/irqchip/irq-gic-common.h
>>>>>> b/drivers/irqchip/irq-
>>>> gic-common.h
>>>>>> index 205e5fd..de0385a 100644
>>>>>> --- a/drivers/irqchip/irq-gic-common.h
>>>>>> +++ b/drivers/irqchip/irq-gic-common.h
>>>>>> @@ -26,6 +26,7 @@ struct gic_quirk {
>>>>>>  	void (*init)(void *data);
>>>>>>  	u32 iidr;
>>>>>>  	u32 mask;
>>>>>> +	const char *erratum;
>>>>>>  };
>>>>>>
>>>>>>  int gic_configure_irq(unsigned int irq, unsigned int type, diff
>>>>>> --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-
>>>> gic-v3-its.c
>>>>>> index f471939..0a326f6 100644
>>>>>> --- a/drivers/irqchip/irq-gic-v3-its.c
>>>>>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>>>>>> @@ -44,6 +44,7 @@
>>>>>>  #define ITS_FLAGS_CMDQ_NEEDS_FLUSHING		(1ULL << 0)
>>>>>>  #define ITS_FLAGS_WORKAROUND_CAVIUM_22375	(1ULL << 1)
>>>>>>  #define ITS_FLAGS_WORKAROUND_CAVIUM_23144	(1ULL << 2)
>>>>>> +#define ITS_FLAGS_WORKAROUND_HISILICON_161010801	(1ULL << 3)
>>>>>>
>>>>>>  #define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING	(1 << 0)
>>>>>>
>>>>>> @@ -659,7 +660,8 @@ static void its_irq_compose_msi_msg(struct
>>>> irq_data *d, struct msi_msg *msg)
>>>>>>  	msg->address_hi		= upper_32_bits(addr);
>>>>>>  	msg->data		= its_get_event_id(d);
>>>>>>
>>>>>> -	iommu_dma_map_msi_msg(d->irq, msg);
>>>>>> +	if (!(its->flags &
>> ITS_FLAGS_WORKAROUND_HISILICON_161010801))
>>>>>> +		iommu_dma_map_msi_msg(d->irq, msg);
>>>>>
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

As far as I understand, it *is* the case, and largely the reason we're
here in the first place. "MSI remapping" is an x86-specific term for the
part of their IOMMU which intercepts writes to the architectural MSI
region and can "remap" a given device's interrupts to different targets
on the CPU side - i.e. more or less the same thing the ITS does with the
device ID data which your implementation apparently needs this
address-matching widget to append to the write. If your ITS couldn't
actually distinguish between requesters (like a GICv2m) we'd have a
*much* bigger problem.

Robin.

> 
> Thanks,
> Shameer
> 
> [1] https://github.com/eauger/linux/commit/df2a17bd8cc73b5a381ed1570870a2aeb6f7e068
> 
> 
