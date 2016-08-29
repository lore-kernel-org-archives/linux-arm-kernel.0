From: thunder.leizhen@huawei.com (Leizhen (ThunderTown))
Date: Mon, 29 Aug 2016 14:55:42 +0800
Subject: [PATCH v7 12/14] arm64/numa: remove the limitation that cpu0 must
 bind to node0
In-Reply-To: <20160826154942.GK30302@arm.com>
References: <1472024693-12912-1-git-send-email-thunder.leizhen@huawei.com>
 <1472024693-12912-13-git-send-email-thunder.leizhen@huawei.com>
 <20160826154942.GK30302@arm.com>
Message-ID: <57C3DC6E.4040406@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/8/26 23:49, Will Deacon wrote:
> On Wed, Aug 24, 2016 at 03:44:51PM +0800, Zhen Lei wrote:
>> 1. Currently only cpu0 set on cpu_possible_mask and percpu areas have not
>>    been initialized.
This description refer to below:
-	for_each_possible_cpu(cpu)
-		set_cpu_numa_node(cpu, NUMA_NO_NODE);

1. When the above code is executed, only the bit of cpu0 was set on cpu_possible_mask.
   So that, only set_cpu_numa_node(0, NUMA_NO_NODE); will be executed.
2. set_cpu_numa_node will access percpu variable numa_node, but setup_per_cpu_areas is
   called after current time. Without the first problem, it will lead kernel crash.

I changed the title of this patch in v7, the original is "remove some useless code".
I think I should separate this into a new patch.



>> 2. No reason to limit cpu0 must belongs to node0.
> 
> Whilst I suspect you're using enumerated lists in order to try to make
> things clearer, I'm having a really hard time understanding the commit
> messages you have in this series. It's actually much better if you
> structure them as concise paragraphs explaining:
> 
>   - What is the problem that you're fixing?
> 
>   - How does that problem manifest?
> 
>   - How does the patch fix it?
> 
> As far as I can see, this patch just removes a bunch of code with no
> explanation as to why it's not required or any problems caused by
> keeping it around.
> 
> Will
> 
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  arch/arm64/mm/numa.c | 12 ++----------
>>  1 file changed, 2 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
>> index 114180f..07a1978 100644
>> --- a/arch/arm64/mm/numa.c
>> +++ b/arch/arm64/mm/numa.c
>> @@ -94,7 +94,6 @@ void numa_clear_node(unsigned int cpu)
>>   */
>>  static void __init setup_node_to_cpumask_map(void)
>>  {
>> -	unsigned int cpu;
>>  	int node;
>>
>>  	/* setup nr_node_ids if not done yet */
>> @@ -107,9 +106,6 @@ static void __init setup_node_to_cpumask_map(void)
>>  		cpumask_clear(node_to_cpumask_map[node]);
>>  	}
>>
>> -	for_each_possible_cpu(cpu)
>> -		set_cpu_numa_node(cpu, NUMA_NO_NODE);
>> -
>>  	/* cpumask_of_node() will now work */
>>  	pr_debug("Node to cpumask map for %d nodes\n", nr_node_ids);
>>  }
>> @@ -119,13 +115,13 @@ static void __init setup_node_to_cpumask_map(void)
>>   */
>>  void numa_store_cpu_info(unsigned int cpu)
>>  {
>> -	map_cpu_to_node(cpu, numa_off ? 0 : cpu_to_node_map[cpu]);
>> +	map_cpu_to_node(cpu, cpu_to_node_map[cpu]);
>>  }
>>
>>  void __init early_map_cpu_to_node(unsigned int cpu, int nid)
>>  {
>>  	/* fallback to node 0 */
>> -	if (nid < 0 || nid >= MAX_NUMNODES)
>> +	if (nid < 0 || nid >= MAX_NUMNODES || numa_off)
>>  		nid = 0;
After the below code have been removed, we should make the corresponding adjustment.
otherwise, kernel will be crashed if "numa=off" was set in bootargs.

>>
>>  	cpu_to_node_map[cpu] = nid;
>> @@ -375,10 +371,6 @@ static int __init numa_init(int (*init_func)(void))
>>
>>  	setup_node_to_cpumask_map();
>>
>> -	/* init boot processor */
>> -	cpu_to_node_map[0] = 0;
>> -	map_cpu_to_node(0, 0);
These code limit cpu0 must belong to node0, but our current implementation deesn't
have this limitation.

>> -
>>  	return 0;
>>  }
>>
>> --
>> 2.5.0
>>
>>
> 
> .
> 
