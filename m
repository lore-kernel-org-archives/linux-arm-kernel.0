From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 21 Jun 2017 09:44:58 +0100
Subject: [PATCH v3 2/2] acpi, gicv3-its, numa: Adding numa node mapping
 for gic-its units
In-Reply-To: <20170621070941.GA6124@localhost>
References: <1498025743-6340-1-git-send-email-ganapatrao.kulkarni@cavium.com>
 <1498025743-6340-3-git-send-email-ganapatrao.kulkarni@cavium.com>
 <20170621070941.GA6124@localhost>
Message-ID: <a3550a73-9345-b360-44e6-949f0b6c42da@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/06/17 08:09, Jayachandran C wrote:
> On Wed, Jun 21, 2017 at 11:45:43AM +0530, Ganapatrao Kulkarni wrote:
>> Add code to parse SRAT ITS Affinity sub table as defined in ACPI 6.2
>> Later in per device probe, ITS devices are mapped to
>> numa node using ITS id to proximity domain mapping.
>>
>> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
>> ---
>>  drivers/irqchip/irq-gic-v3-its.c | 80 +++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 79 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>> index 45ea1933..88cfb32 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -1833,6 +1833,82 @@ static int __init its_of_probe(struct device_node *node)
>>  
>>  #define ACPI_GICV3_ITS_MEM_SIZE (SZ_128K)
>>  
>> +#ifdef CONFIG_ACPI_NUMA
>> +struct its_srat_map {
>> +	u32	numa_node;  /* numa node id */
>> +	u32	its_id;  /* GIC ITS ID */
>> +};
>> +
>> +static struct its_srat_map its_srat_maps[MAX_NUMNODES] __initdata = {
>> +	[0 ... MAX_NUMNODES - 1] = {NUMA_NO_NODE, UINT_MAX} };
>> +
>> +static int its_in_srat __initdata;
>> +
>> +static int __init
>> +acpi_get_its_numa_node(u32 its_id)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < its_in_srat; i++) {
>> +		if (its_id == its_srat_maps[i].its_id)
>> +			return its_srat_maps[i].numa_node;
>> +	}
>> +	return NUMA_NO_NODE;
>> +}
>> +
>> +static int __init
>> +gic_acpi_parse_srat_its(struct acpi_subtable_header *header,
>> +			 const unsigned long end)
>> +{
>> +	int pxm, node;
>> +	struct acpi_srat_its_affinity *its_affinity;
>> +
>> +	its_affinity = (struct acpi_srat_its_affinity *)header;
>> +	if (!its_affinity)
>> +		return -EINVAL;
>> +
>> +	if (its_affinity->header.length <
>> +			sizeof(struct acpi_srat_its_affinity)) {
>> +		pr_err("SRAT:ITS: Invalid SRAT header length: %d\n",
>> +			its_affinity->header.length);
> 
> The original driver does not use pr_fmt properly, it may be worth
> fixing that up rather than having prefixes, here...

Irrespective of what the "proper" usage is, this kind of cleanup doesn't
belong in this series. Feel free to submit a separate patch.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
