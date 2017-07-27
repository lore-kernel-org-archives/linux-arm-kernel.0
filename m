From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu, 27 Jul 2017 15:36:21 +0800
Subject: [PATCH v2] irqchip/gic-v3-its: Allow GIC ITS number more than
 MAX_NUMNODES
In-Reply-To: <5e8aacb2-9c20-0f4a-2c5e-721fe82bfc60@arm.com>
References: <1500695652-27025-1-git-send-email-guohanjun@huawei.com>
 <20170725104758.GC19302@red-moon>
 <eec017c3-0d41-fb9f-478c-805368f66179@linaro.org>
 <5e8aacb2-9c20-0f4a-2c5e-721fe82bfc60@arm.com>
Message-ID: <b14f3a93-6d9d-3be0-ae3e-12b1ac510df2@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

On 2017/7/26 19:05, Robin Murphy wrote:
> On 26/07/17 09:11, Hanjun Guo wrote:
>> On 2017/7/25 18:47, Lorenzo Pieralisi wrote:
>>> On Sat, Jul 22, 2017 at 11:54:12AM +0800, Hanjun Guo wrote:
>>>> From: Hanjun Guo <hanjun.guo@linaro.org>
>>>>
>>>> When running 4.13-rc1 on top of D05, I got the boot log:
>>>
>>> Nit: You should stick to what the problem is and why you need to solve
>>> it, "Fixes:" tag gives the commit history you need, the rest (eg "When
>>> running 4.13-rc1") does not belong in the commit log.
>>
>> Updated as "After enabling the ITS NUMA support on D05, I got
>> the boot log:"
>>
>>>
>>>> [    0.000000] SRAT: PXM 0 -> ITS 0 -> Node 0
>>>> [    0.000000] SRAT: PXM 0 -> ITS 1 -> Node 0
>>>> [    0.000000] SRAT: PXM 0 -> ITS 2 -> Node 0
>>>> [    0.000000] SRAT: PXM 1 -> ITS 3 -> Node 1
>>>> [    0.000000] SRAT: ITS affinity exceeding max count[4]
>>>>
>>>> This is wrong on D05 as we have 8 ITSes with 4 NUMA nodes.
>>>>
>>>> So dynamically alloc the memory needed instead of using
>>>> its_srat_maps[MAX_NUMNODES], which count the number of
>>>> ITS entry(ies) in SRAT and alloc its_srat_maps as needed,
>>>> then build the mapping of numa node to ITS ID. Of course,
>>>> its_srat_maps will be freed after ITS probing because
>>>> we don't need that after boot.
>>>>
>>>> After doing this, I got what I wanted:
>>>>
>>>> [    0.000000] SRAT: PXM 0 -> ITS 0 -> Node 0
>>>> [    0.000000] SRAT: PXM 0 -> ITS 1 -> Node 0
>>>> [    0.000000] SRAT: PXM 0 -> ITS 2 -> Node 0
>>>> [    0.000000] SRAT: PXM 1 -> ITS 3 -> Node 1
>>>> [    0.000000] SRAT: PXM 2 -> ITS 4 -> Node 2
>>>> [    0.000000] SRAT: PXM 2 -> ITS 5 -> Node 2
>>>> [    0.000000] SRAT: PXM 2 -> ITS 6 -> Node 2
>>>> [    0.000000] SRAT: PXM 3 -> ITS 7 -> Node 3
>>>
>>> Question (unrelated): how are PCI devices (or better PCI host bridges)
>>> mapped to ITSs ? I ask because in IORT we currently ignore the notion
>>> of ITS groups - so it is just out of curiosity (I suspect you have
>>> a static 1:1 mapping PCI-host-bridge->ITS).
>>
>> Yes, on D05 we enabled 8 ITSs, and also have 8 PCI hostbridges, here is
>> the IORT for D05:
>>
>> https://github.com/hisilicon/OpenPlatformPkg/blob/bb17676e6c529732af8adf438fc2c8ceeb9b3271/Chips/Hisilicon/Hi1616/D05AcpiTables/D05Iort.asl
> 
> On a further side note, do the SMMUs really have no interrupts, or is
> that just a hack to avoid MBIgen-related problems? Now that we have
> working probe-deferral for IOMMU masters, it ought to be possible to
> address any dependency by deferring the SMMU itself until the IRQs are
> available. At a glance I guess ACPI doesn't make it as easy as
> of_irq_get() does, but it might be worth looking into.

SMMUs on D05 have interrupts as SMMU spec defined, but as you said they
are routed to MBIgen.

For now, IORT can support two types of interrupt for SMMU, one is SPI
which connect to GICD, the other one is using MSI which describing the
mapping of smmu dev id to ITS.

So interrupts connecting to MBIgen or other interrupt controller are not
supported, but I investigated that for a while and I think we can update
the IORT table to support other interrupt controllers by introducing
"ACPI device object full path name" in the IORT that the SMMU interrupts
are referring.

Thanks
Hanjun
