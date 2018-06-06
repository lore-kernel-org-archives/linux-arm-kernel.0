From: jeremy.linton@arm.com (Jeremy Linton)
Date: Wed, 6 Jun 2018 09:36:27 -0500
Subject: [PATCH] arm64: topology: Avoid checking numa mask for scheduler
 MC selection
In-Reply-To: <3c8a541d-78a1-389a-112c-494f7c1a543d@arm.com>
References: <20180605190837.493505-1-jeremy.linton@arm.com>
 <3c8a541d-78a1-389a-112c-494f7c1a543d@arm.com>
Message-ID: <120c2793-8826-4a7c-cf5c-cb6661602b5a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/2018 05:05 AM, Sudeep Holla wrote:
> 
> 
> On 05/06/18 20:08, Jeremy Linton wrote:
>> The numa mask subset check has problems if !CONFIG_NUMA, over hotplug
>> operations or during early boot. Lets disable the NUMA siblings checks
>> for the time being, as NUMA in socket machines have LLC's that will
>> assure that the scheduler topology isn't "borken".
>>
> 
> ^ broken ? (not sure if usage of borken is intentional :))

Well that is what the scheduler says when it doesn't like the topology.

> 
>> Futher, as a defensive mechanism during hotplug, lets assure that the
> 
> ^ Further

Sure.

> 
>> LLC siblings are also masked.
>>
> 
> Also add the symptoms of the issue we say as Geert suggested me.
> Something like:
> " This often leads to system hang or crash during CPU hotplug and system
> suspend operation. This is mostly observed on HMP systems where the
> CPU compute capacities are different and ends up in different scheduler
> domains. Since cpumask_of_node is returned instead core_sibling, the
> scheduler is confused with incorrect cpumasks(e.g. one CPU in two
> different sched domains at the same time) on CPU hotplug."
> 
> You can add Reported-by: Geert... ?

ok.

> 
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>   arch/arm64/kernel/topology.c | 11 ++++-------
>>   1 file changed, 4 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
>> index 7415c166281f..f845a8617812 100644
>> --- a/arch/arm64/kernel/topology.c
>> +++ b/arch/arm64/kernel/topology.c
>> @@ -215,13 +215,8 @@ EXPORT_SYMBOL_GPL(cpu_topology);
>>   
>>   const struct cpumask *cpu_coregroup_mask(int cpu)
>>   {
>> -	const cpumask_t *core_mask = cpumask_of_node(cpu_to_node(cpu));
>> +	const cpumask_t *core_mask = &cpu_topology[cpu].core_sibling;
>>   
>> -	/* Find the smaller of NUMA, core or LLC siblings */
>> -	if (cpumask_subset(&cpu_topology[cpu].core_sibling, core_mask)) {
>> -		/* not numa in package, lets use the package siblings */
>> -		core_mask = &cpu_topology[cpu].core_sibling;
>> -	}
>>   	if (cpu_topology[cpu].llc_id != -1) {
>>   		if (cpumask_subset(&cpu_topology[cpu].llc_siblings, core_mask))
>>   			core_mask = &cpu_topology[cpu].llc_siblings;
>> @@ -239,8 +234,10 @@ static void update_siblings_masks(unsigned int cpuid)
>>   	for_each_possible_cpu(cpu) {
>>   		cpu_topo = &cpu_topology[cpu];
>>   
>> -		if (cpuid_topo->llc_id == cpu_topo->llc_id)
>> +		if (cpuid_topo->llc_id == cpu_topo->llc_id) {
>>   			cpumask_set_cpu(cpu, &cpuid_topo->llc_siblings);
>> +			cpumask_set_cpu(cpuid, &cpu_topo->llc_siblings);
>> +		}
>>   
>>   		if (cpuid_topo->package_id != cpu_topo->package_id)
>>   			continue;
>>
> 
> Looks good to me for now. I might need to tweek it a bit when I add the
> support to update topology on hotplug. But that's for latter. For now,
> 
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> 
