From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 26 Jul 2017 17:47:31 +0800
Subject: [PATCH v2] irqchip/gic-v3-its: Allow GIC ITS number more than
 MAX_NUMNODES
In-Reply-To: <b5545a3e-74a9-0bff-afc7-309c653ca2b3@huawei.com>
References: <1500695652-27025-1-git-send-email-guohanjun@huawei.com>
 <b5545a3e-74a9-0bff-afc7-309c653ca2b3@huawei.com>
Message-ID: <33afd72e-d8de-a8c5-9339-1a98a188ded0@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017/7/25 19:02, John Garry wrote:
> On 22/07/2017 04:54, Hanjun Guo wrote:
>> From: Hanjun Guo <hanjun.guo@linaro.org>
>>
>> When running 4.13-rc1 on top of D05, I got the boot log:
>>
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
>>
>> Fixes: dbd2b8267233 ("irqchip/gic-v3-its: Add ACPI NUMA node mapping")
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>
>> v1->v2:
>>   - Add NULL check in acpi_get_its_numa_node() for no ITS affinity case;
>>   - Free the its_srat_maps after ITS probing.
>>
>>  drivers/irqchip/irq-gic-v3-its.c | 39 
>> ++++++++++++++++++++++++++++++++-------
>>  1 file changed, 32 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c 
>> b/drivers/irqchip/irq-gic-v3-its.c
>> index 3ccdf76..1d692aa 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -1847,13 +1847,16 @@ struct its_srat_map {
>>      u32    its_id;
>>  };
>>
>> -static struct its_srat_map its_srat_maps[MAX_NUMNODES] __initdata;
>> +static struct its_srat_map *its_srat_maps __initdata;
>>  static int its_in_srat __initdata;
>>
>>  static int __init acpi_get_its_numa_node(u32 its_id)
>>  {
>>      int i;
>>
>> +    if (!its_srat_maps)
>> +        return NUMA_NO_NODE;
> 
> Question: Does !its_srat_maps always imply its_in_srat == 0, so we could 
> just fall through the for loop and return NUMA_NO_NODE without this check?
> 
> Or should we be safe/explicit/or falling through loops is a bad coding 
> style?

Hmm, you are right, I missed that point, its_in_srat will
always be 0 if its_srat_maps be NULL, removed the NULL
check and tested it on D03 (without ITS NUMA) and D03 boots
OK, will remove the check in the new version.

Thanks
Hanjun
