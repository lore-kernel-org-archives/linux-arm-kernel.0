From: jeremy.linton@arm.com (Jeremy Linton)
Date: Tue, 27 Feb 2018 14:18:47 -0600
Subject: [PATCH v7 13/13] arm64: topology: divorce MC scheduling domain
 from core_siblings
In-Reply-To: <20180301155216.GI4589@e105550-lin.cambridge.arm.com>
References: <20180228220619.6992-1-jeremy.linton@arm.com>
 <20180228220619.6992-14-jeremy.linton@arm.com>
 <20180301155216.GI4589@e105550-lin.cambridge.arm.com>
Message-ID: <5d6bf4cf-2f6d-d123-f17f-d47d8e74c16c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


First, thanks for taking a look at this.

On 03/01/2018 09:52 AM, Morten Rasmussen wrote:
> Hi Jeremy,
> 
> On Wed, Feb 28, 2018 at 04:06:19PM -0600, Jeremy Linton wrote:
>> Now that we have an accurate view of the physical topology
>> we need to represent it correctly to the scheduler. In the
>> case of NUMA in socket, we need to assure that the sched domain
>> we build for the MC layer isn't larger than the DIE above it.
> 
> MC shouldn't be larger than any of the NUMA domains either.

Right, that is one of the things this patch is assuring..

> 
>> To do this correctly, we should really base that on the cache
>> topology immediately below the NUMA node (for NUMA in socket) >> or below the physical package for normal NUMA configurations.
> 
> That means we wouldn't support multi-die NUMA nodes?

You mean a bottom level NUMA domain that crosses multiple sockets/dies? 
That should work. This patch is picking the widest cache layer below the 
smallest of the package or numa grouping. What actually happens depends 
on the topology. Given a case where there are multiple dies in a socket, 
and the numa domain is at the socket level the MC is going to reflect 
the caching topology immediately below the socket. In the case of 
multiple dies, with a cache that crosses them in socket, then the MC is 
basically going to be the socket, otherwise if the widest cache is per 
die, or some narrower grouping (cluster?) then that is what ends up in 
the MC. (this is easier with some pictures)

> 
>> This patch creates a set of early cache_siblings masks, then
>> when the scheduler requests the coregroup mask we pick the
>> smaller of the physical package siblings, or the numa siblings
>> and locate the largest cache which is an entire subset of
>> those siblings. If we are unable to find a proper subset of
>> cores then we retain the original behavior and return the
>> core_sibling list.
> 
> IIUC, for numa-in-package it is a strict requirement that there is a
> cache that span the entire NUMA node? For example, having a NUMA node
> consisting of two clusters with per-cluster caches only wouldn't be
> supported?

Everything is supported, the MC is reflecting the cache topology. We 
just use the physical/numa topology to help us pick which layer of cache 
topology lands in the MC. (unless of course we fail to find a PPTT/cache 
topology, in which case we fallback to the old behavior of the 
core_siblings which can reflect the MPIDR/etc).

> 
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>   arch/arm64/include/asm/topology.h |  5 +++
>>   arch/arm64/kernel/topology.c      | 64 +++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 69 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
>> index 6b10459e6905..08db3e4e44e1 100644
>> --- a/arch/arm64/include/asm/topology.h
>> +++ b/arch/arm64/include/asm/topology.h
>> @@ -4,12 +4,17 @@
>>   
>>   #include <linux/cpumask.h>
>>   
>> +#define MAX_CACHE_CHECKS 4
>> +
>>   struct cpu_topology {
>>   	int thread_id;
>>   	int core_id;
>>   	int package_id;
>> +	int cache_id[MAX_CACHE_CHECKS];
>>   	cpumask_t thread_sibling;
>>   	cpumask_t core_sibling;
>> +	cpumask_t cache_siblings[MAX_CACHE_CHECKS];
>> +	int cache_level;
>>   };
>>   
>>   extern struct cpu_topology cpu_topology[NR_CPUS];
>> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
>> index bd1aae438a31..1809dc9d347c 100644
>> --- a/arch/arm64/kernel/topology.c
>> +++ b/arch/arm64/kernel/topology.c
>> @@ -212,8 +212,42 @@ static int __init parse_dt_topology(void)
>>   struct cpu_topology cpu_topology[NR_CPUS];
>>   EXPORT_SYMBOL_GPL(cpu_topology);
>>   
>> +static void find_llc_topology_for_cpu(int cpu)
> 
> Isn't it more find core/node siblings? Or is it a requirement that the
> last level cache spans exactly one NUMA node? For example, a package
> level cache isn't allowed for numa-in-package?

Yes, its a core siblings group, but more like a 
widest_core_siblings_sharing_a_cache_equalorsmaller_than_the_smallest_of_numa_or_package()

LLC is a bit of a misnomer because its the 'LLC' within the package/px 
domain. Is possible there is a LLC grouping larger than whatever we pick 
but we don't care.


> 
>> +{
>> +	/* first determine if we are a NUMA in package */
>> +	const cpumask_t *node_mask = cpumask_of_node(cpu_to_node(cpu));
>> +	int indx;
>> +
>> +	if (!cpumask_subset(node_mask, &cpu_topology[cpu].core_sibling)) {
>> +		/* not numa in package, lets use the package siblings */
>> +		node_mask = &cpu_topology[cpu].core_sibling;
>> +	}
>> +
>> +	/*
>> +	 * node_mask should represent the smallest package/numa grouping
>> +	 * lets search for the largest cache smaller than the node_mask.
>> +	 */
>> +	for (indx = 0; indx < MAX_CACHE_CHECKS; indx++) {
>> +		cpumask_t *cache_sibs = &cpu_topology[cpu].cache_siblings[indx];
>> +
>> +		if (cpu_topology[cpu].cache_id[indx] < 0)
>> +			continue;
>> +
>> +		if (cpumask_subset(cache_sibs, node_mask))
>> +			cpu_topology[cpu].cache_level = indx;
> 
> I don't this guarantees that the cache level we found matches exactly
> the NUMA node. Taking the two cluster NUMA node example from above, we
> would set cache_level to point at the per-cluster cache as it is a
> subset of the NUMA node but it would only span half of the node. Or am I
> missing something?

I think you got it. If the system is a traditional ARM system with 
shared L2's at the cluster level and it doesn't have any L3's/etc and 
the NUMA node crosses multiple clusters then you get the cluster L2 
grouping in the MC.

I think this is what we want. Particularly, since the newer/larger 
machines do have L3+'s contained within their sockets or numa domains, 
so you end up with that as the MC.


> 
>> +	}
>> +}
>> +
>>   const struct cpumask *cpu_coregroup_mask(int cpu)
>>   {
>> +	int *llc = &cpu_topology[cpu].cache_level;
>> +
>> +	if (*llc == -1)
>> +		find_llc_topology_for_cpu(cpu);
>> +
>> +	if (*llc != -1)
>> +		return &cpu_topology[cpu].cache_siblings[*llc];
>> +
>>   	return &cpu_topology[cpu].core_sibling;
>>   }
>>   
>> @@ -221,6 +255,7 @@ static void update_siblings_masks(unsigned int cpuid)
>>   {
>>   	struct cpu_topology *cpu_topo, *cpuid_topo = &cpu_topology[cpuid];
>>   	int cpu;
>> +	int idx;
>>   
>>   	/* update core and thread sibling masks */
>>   	for_each_possible_cpu(cpu) {
>> @@ -229,6 +264,16 @@ static void update_siblings_masks(unsigned int cpuid)
>>   		if (cpuid_topo->package_id != cpu_topo->package_id)
>>   			continue;
>>   
>> +		for (idx = 0; idx < MAX_CACHE_CHECKS; idx++) {
>> +			cpumask_t *lsib;
>> +			int cput_id = cpuid_topo->cache_id[idx];
>> +
>> +			if (cput_id == cpu_topo->cache_id[idx]) {
>> +				lsib = &cpuid_topo->cache_siblings[idx];
>> +				cpumask_set_cpu(cpu, lsib);
>> +			}
> 
> Shouldn't the cache_id validity be checked here? I don't think it breaks
> anything though.

It could be, but since its explicitly looking for unified caches its 
likely that some of the levels are invalid. Invalid levels get ignored 
later on so we don't really care if they are valid here.

> 
> Overall, I think this is more or less in line with the MC domain
> shrinking I just mentioned in the v6 discussion. It is mostly the corner
> cases and assumption about the system topology I'm not sure about.

I think its the corner cases i'm taking care of. The simple fix in v6 is 
to take the smaller of core_siblings or node_siblings, but that ignores 
cases with split L3s (or the L2 only example above). The idea here is to 
assure that MC is following a cache topology. In my mind, it is more a 
question of how that is picked. The other way I see to do this, is with 
a PX domain flag in the PPTT. We could then pick the core grouping one 
below that flag. Doing it that way affords the firmware vendors a lever 
they can pull to optimize a given machine for the linux scheduler behavior.

This seems a good first pass given that isn't in the ACPI spec.
