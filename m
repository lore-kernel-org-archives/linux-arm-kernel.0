From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 26 Jul 2017 16:11:05 +0800
Subject: [PATCH v2] irqchip/gic-v3-its: Allow GIC ITS number more than
 MAX_NUMNODES
In-Reply-To: <20170725104758.GC19302@red-moon>
References: <1500695652-27025-1-git-send-email-guohanjun@huawei.com>
 <20170725104758.GC19302@red-moon>
Message-ID: <eec017c3-0d41-fb9f-478c-805368f66179@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017/7/25 18:47, Lorenzo Pieralisi wrote:
> On Sat, Jul 22, 2017 at 11:54:12AM +0800, Hanjun Guo wrote:
>> From: Hanjun Guo <hanjun.guo@linaro.org>
>>
>> When running 4.13-rc1 on top of D05, I got the boot log:
> 
> Nit: You should stick to what the problem is and why you need to solve
> it, "Fixes:" tag gives the commit history you need, the rest (eg "When
> running 4.13-rc1") does not belong in the commit log.

Updated as "After enabling the ITS NUMA support on D05, I got
the boot log:"

> 
>> [    0.000000] SRAT: PXM 0 -> ITS 0 -> Node 0
>> [    0.000000] SRAT: PXM 0 -> ITS 1 -> Node 0
>> [    0.000000] SRAT: PXM 0 -> ITS 2 -> Node 0
>> [    0.000000] SRAT: PXM 1 -> ITS 3 -> Node 1
>> [    0.000000] SRAT: ITS affinity exceeding max count[4]
>>
>> This is wrong on D05 as we have 8 ITSes with 4 NUMA nodes.
>>
>> So dynamically alloc the memory needed instead of using
>> its_srat_maps[MAX_NUMNODES], which count the number of
>> ITS entry(ies) in SRAT and alloc its_srat_maps as needed,
>> then build the mapping of numa node to ITS ID. Of course,
>> its_srat_maps will be freed after ITS probing because
>> we don't need that after boot.
>>
>> After doing this, I got what I wanted:
>>
>> [    0.000000] SRAT: PXM 0 -> ITS 0 -> Node 0
>> [    0.000000] SRAT: PXM 0 -> ITS 1 -> Node 0
>> [    0.000000] SRAT: PXM 0 -> ITS 2 -> Node 0
>> [    0.000000] SRAT: PXM 1 -> ITS 3 -> Node 1
>> [    0.000000] SRAT: PXM 2 -> ITS 4 -> Node 2
>> [    0.000000] SRAT: PXM 2 -> ITS 5 -> Node 2
>> [    0.000000] SRAT: PXM 2 -> ITS 6 -> Node 2
>> [    0.000000] SRAT: PXM 3 -> ITS 7 -> Node 3
> 
> Question (unrelated): how are PCI devices (or better PCI host bridges)
> mapped to ITSs ? I ask because in IORT we currently ignore the notion
> of ITS groups - so it is just out of curiosity (I suspect you have
> a static 1:1 mapping PCI-host-bridge->ITS).

Yes, on D05 we enabled 8 ITSs, and also have 8 PCI hostbridges, here is
the IORT for D05:

https://github.com/hisilicon/OpenPlatformPkg/blob/bb17676e6c529732af8adf438fc2c8ceeb9b3271/Chips/Hisilicon/Hi1616/D05AcpiTables/D05Iort.asl

> 
>> Fixes: dbd2b8267233 ("irqchip/gic-v3-its: Add ACPI NUMA node mapping")
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>
>> v1->v2:
>>    - Add NULL check in acpi_get_its_numa_node() for no ITS affinity case;
>>    - Free the its_srat_maps after ITS probing.
>>
>>   drivers/irqchip/irq-gic-v3-its.c | 39 ++++++++++++++++++++++++++++++++-------
> 
> Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Thanks!

Hanjun
