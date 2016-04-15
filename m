From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 15 Apr 2016 13:30:14 +0100
Subject: SMMU problem found on LS2085A with 4.6-rc3
In-Reply-To: <571022AD.1060909@linaro.org>
References: <570E9EA9.2070903@linaro.org> <570F8739.1060508@arm.com>
 <571022AD.1060909@linaro.org>
Message-ID: <5710DED6.3010008@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/04/16 00:07, Shi, Yang wrote:
> Hi Robin,
>
> On 4/14/2016 5:04 AM, Robin Murphy wrote:
>> Hi Yang,
>>
>> On 13/04/16 20:31, Shi, Yang wrote:
>>> Hi Will & Robin,
>>>
>>> I just ran some quick test on my LS2085A board, which has 8 Cortex A57
>>> cores, with 4.6-rc3 kernel, but I found a regression issue with SMMU.
>>>
>>> SMMU driver reports:
>>>
>>> arm_smmu_global_fault: 297974 callbacks suppressed
>>> arm_smmu_global_fault: 298561 callbacks suppressed
>>> arm-smmu 5000000.iommu:         GFSR 0x80000004, GFSYNR0 0x00000008,
>>> GFSYNR1 0x00000300, GFSYNR2 0x00000000
>>> arm-smmu 5000000.iommu:         GFSR 0x80000004, GFSYNR0 0x00000008,
>>> GFSYNR1 0x00000300, GFSYNR2 0x00000000
>>> arm-smmu 5000000.iommu:         GFSR 0x80000004, GFSYNR0 0x00000008,
>>> GFSYNR1 0x00000300, GFSYNR2 0x00000000
>>> arm-smmu 5000000.iommu:         GFSR 0x80000004, GFSYNR0 0x00000008,
>>> GFSYNR1 0x00000300, GFSYNR2 0x00000000
>>> arm-smmu 5000000.iommu:         GFSR 0x80000004, GFSYNR0 0x00000008,
>>> GFSYNR1 0x00000300, GFSYNR2 0x00000000
>>> arm-smmu 5000000.iommu:         GFSR 0x80000004, GFSYNR0 0x00000008,
>>> GFSYNR1 0x00000300, GFSYNR2 0x00000000
>>> arm-smmu 5000000.iommu:         GFSR 0x80000004, GFSYNR0 0x00000008,
>>> GFSYNR1 0x00000300, GFSYNR2 0x00000000
>>> arm-smmu 5000000.iommu:         GFSR 0x80000004, GFSYNR0 0x00000008,
>>> GFSYNR1 0x00000300, GFSYNR2 0x00000000
>>> arm-smmu 5000000.iommu:         GFSR 0x80000004, GFSYNR0 0x00000008,
>>> GFSYNR1 0x00000300, GFSYNR2 0x00000000
>>> arm-smmu 5000000.iommu:         GFSR 0x80000004, GFSYNR0 0x00000008,
>>> GFSYNR1 0x00000300, GFSYNR2 0x00000000
>>> arm-smmu 5000000.iommu: Unexpected global fault, this could be serious
>>> arm-smmu 5000000.iommu: Unexpected global fault, this could be serious
>>> arm-smmu 5000000.iommu: Unexpected global fault, this could be serious
>>> arm-smmu 5000000.iommu: Unexpected global fault, this could be serious
>>> arm-smmu 5000000.iommu: Unexpected global fault, this could be serious
>>> arm-smmu 5000000.iommu: Unexpected global fault, this could be serious
>>> arm-smmu 5000000.iommu: Unexpected global fault, this could be serious
>>> arm-smmu 5000000.iommu: Unexpected global fault, this could be serious
>>> arm-smmu 5000000.iommu: Unexpected global fault, this could be serious
>>> arm-smmu 5000000.iommu: Unexpected global fault, this could be serious
>>
>> That's a stream match conflict fault, so you've somehow got two devices
>> using the same stream ID attached to different domains, and at least one
>> of them is trying to do DMA.
>>
>>> But, it is good with 4.5 kernel. I found the below commit causes it:
>>>
>>> commit 9adb95949a343dac53b1cd81dc973b5f815c88d4
>>> Author: Robin Murphy <robin.murphy@arm.com>
>>> Date:   Tue Jan 26 18:06:36 2016 +0000
>>>
>>>      iommu/arm-smmu: Support DMA-API domains
>>>
>>>      With DMA mapping ops provided by the iommu-dma code, only a minimal
>>>      contribution from the IOMMU driver is needed to create a suitable
>>>      DMA-API domain for them to use. Implement this for the ARM SMMUs.
>>>
>>>      Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>>      Signed-off-by: Will Deacon <will.deacon@arm.com>
>>>
>>> Any idea?
>>
>> My first guess would be the same thing as [1] - does that patch help?
>
> No, it can't cease the fault.
>
>>
>> Beyond that, what does your DT look like? The one in mainline has one
>> token mmu-masters property which isn't even valid, so nothing ever gets
>
> Mine has mmu-masters property too, but removing it doesn't solve the
> problem.

OK, now things really stop making sense. Without the mmu-masters 
property the SMMU driver will do nothing but probe the SMMU device 
itself. Therefore I can only assume the bootloader magic for the 
Freescale vendor kernel must be rewriting your DT (our board always just 
says "fdt_fixup_smmu: WARNING: no SMMU node found" despite the mainline 
DT containing the SMMU, so I'm not sure exactly what it's looking for). 
Can you see what it's done via /sys/fimware/fdt (or 
/sys/firmware/devicetree/base/ if you can face hunting down phandles 
manually)? As a further sanity check, what do you see in 
/sys/kernel/iommu_groups/*/devices/ and do they differ between the two 
kernels?

Secondly, the stream match conflict can only occur if the SMRs are 
actually programmed. Since with Will's fix for the conflicts Eric saw we 
should attach to the default domain without touching the initial bypass 
entries in the SMRs, I'm at a loss to see how you could still get into 
this state with that patch applied.

As the transactions provoking the fault are apparently instruction 
fetches on a 00xx stream ID, which I've not seen before, my first guess 
would be it's something to do with the management complex (which I can't 
get to work with the staging driver due to firmware incompatibility), 
but then looking at the general lack of connection to the DMA API within 
that driver, maybe not?

Robin.

>
> Thanks,
> Yang
>
>
>> attached to the SMMU - indeed I've happily booted -rc3 on an LS2085A
>> earlier this week - so there's clearly something going on there.
>>
>> More generally, I'd note that the mmu-masters binding will never fully
>> work on this board - you can get the platform devices to cooperate by
>> programming the assorted ICID registers to ensure they present unique
>> stream IDs, but PCI devices cannot work at all because there's no way to
>> make the stream IDs coming out of the root complex be equal to the PCI
>> RID in the way it relies on. In that sense, any regression here is quite
>> likely just a shift from "subtly not working" to "loudly and obnoxiously
>> not working". Conversely, those reasons have also proved it a really
>> useful platform for implementing and testing the iommu-map binding[2]
>> (with an awful hack in the PCI driver to program the lookup table
>> suitably) :D
>>
>> Robin.
>>
>> [1]:http://thread.gmane.org/gmane.linux.kernel.iommu/12810
>> [2]:http://thread.gmane.org/gmane.linux.kernel.iommu/12454
>>
>>>
>>> Thanks,
>>> Yang
>>>
>>
>
