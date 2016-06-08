From: thunder.leizhen@huawei.com (Leizhen (ThunderTown))
Date: Wed, 8 Jun 2016 15:49:18 +0800
Subject: [PATCH v4 11/14] arm64/numa: support HAVE_MEMORYLESS_NODES
In-Reply-To: <CAFpQJXWjZQFFnSjygW1DYJ1NRfVbkWt+FP3tN3zsGWaaf9-g=g@mail.gmail.com>
References: <1465286898-13828-1-git-send-email-thunder.leizhen@huawei.com>
 <1465286898-13828-12-git-send-email-thunder.leizhen@huawei.com>
 <CAFpQJXVaYT5N3GUCFDnUL8OYOuuSSV4QfC8cXL2ecB=1TN57jQ@mail.gmail.com>
 <5756C4C6.7060706@huawei.com>
 <CAFpQJXUe_eBBR5dBXOGXMCKmbd3n3TUYzFpDNewjVom-iu+3yg@mail.gmail.com>
 <57578004.4050203@huawei.com>
 <CAFpQJXWjZQFFnSjygW1DYJ1NRfVbkWt+FP3tN3zsGWaaf9-g=g@mail.gmail.com>
Message-ID: <5757CDFE.5020204@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/6/8 12:45, Ganapatrao Kulkarni wrote:
> On Wed, Jun 8, 2016 at 7:46 AM, Leizhen (ThunderTown)
> <thunder.leizhen@huawei.com> wrote:
>>
>>
>> On 2016/6/7 22:01, Ganapatrao Kulkarni wrote:
>>> On Tue, Jun 7, 2016 at 6:27 PM, Leizhen (ThunderTown)
>>> <thunder.leizhen@huawei.com> wrote:
>>>>
>>>>
>>>> On 2016/6/7 16:31, Ganapatrao Kulkarni wrote:
>>>>> On Tue, Jun 7, 2016 at 1:38 PM, Zhen Lei <thunder.leizhen@huawei.com> wrote:
>>>>>> Some numa nodes may have no memory. For example:
>>>>>> 1. cpu0 on node0
>>>>>> 2. cpu1 on node1
>>>>>> 3. device0 access the momory from node0 and node1 take the same time.
>>>>>
>>>>> i am wondering, if access to both nodes is same, then why you need numa.
>>>>> the example you are quoting is against the basic principle of "numa"
>>>>> what is device0 here? cpu?
>>>> The device0 can also be a cpu. I drew a simple diagram:
>>>>
>>>>   cpu0     cpu1        cpu2/device0
>>>>     |        |              |
>>>>     |        |              |
>>>>    DDR0     DDR1    No DIMM slots or no DIMM plugged
>>>>  (node0)  (node1)         (node2)
>>>>
>>>
>>> thanks for the clarification. your example is for 3 node system, where
>>> third node is memory less node.
>>> do you see any issue in supporting this topology with existing code?
>> If opened HAVE_MEMORYLESS_NODES, it will pick the nearest node for the cpus on
>> memoryless node.
> 
> i see couple of arch enabled HAVE_MEMORYLESS_NODES, but i don't see
> any code in arch specific numa code for this
> is that means the core code will take care of this?
I just spent some time to read the implementation code of HAVE_MEMORYLESS_NODES on PPC and IA64.
For NODE_DATA initialization, it's similar to mine on IA64. But PPC have no special process, it's
similar to yours. I think the developers of PPC need to fix it.

I picked the code on IA64 as below:
static void __init *memory_less_node_alloc(int nid, unsigned long pernodesize)
{
        void *ptr = NULL;
        u8 best = 0xff;
        int bestnode = -1, node, anynode = 0;

        for_each_online_node(node) {
                if (node_isset(node, memory_less_mask))
                        continue;
                else if (node_distance(nid, node) < best) {
                        best = node_distance(nid, node);
                        bestnode = node;
                }
                anynode = node;
        }

        if (bestnode == -1)
                bestnode = anynode;

        ptr = __alloc_bootmem_node(pgdat_list[bestnode], pernodesize,
                PERCPU_PAGE_SIZE, __pa(MAX_DMA_ADDRESS));

        return ptr;
}

/**
 * memory_less_nodes - allocate and initialize CPU only nodes pernode
 *      information.
 */
static void __init memory_less_nodes(void)
{
        unsigned long pernodesize;
        void *pernode;
        int node;

        for_each_node_mask(node, memory_less_mask) {
                pernodesize = compute_pernodesize(node);
                pernode = memory_less_node_alloc(node, pernodesize);
                fill_pernode(node, __pa(pernode), pernodesize);
        }

        return;
}



> 
>>
>> For example, in include/linux/topology.h
>> #ifdef CONFIG_HAVE_MEMORYLESS_NODES
>> ...
>> static inline int cpu_to_mem(int cpu)
>> {
>>         return per_cpu(_numa_mem_, cpu);
>> }
>> ...
>> #else
>> ...
>> static inline int cpu_to_mem(int cpu)
>> {
>>         return cpu_to_node(cpu);
>> }
>> ...
>> #endif
>>
>>> I think, this use case should be supported with present code.
>>>
>>>>>>
>>>>>> So, we can not simply classify device0 to node0 or node1, but we can
>>>>>> define a node2 which distances to node0 and node1 are the same.
>>>>>>
>>>>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>>>>> ---
>>>>>>  arch/arm64/Kconfig      |  4 ++++
>>>>>>  arch/arm64/kernel/smp.c |  1 +
>>>>>>  arch/arm64/mm/numa.c    | 43 +++++++++++++++++++++++++++++++++++++++++--
>>>>>>  3 files changed, 46 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>>>>> index 05c1bf1..5904a62 100644
>>>>>> --- a/arch/arm64/Kconfig
>>>>>> +++ b/arch/arm64/Kconfig
>>>>>> @@ -581,6 +581,10 @@ config NEED_PER_CPU_EMBED_FIRST_CHUNK
>>>>>>         def_bool y
>>>>>>         depends on NUMA
>>>>>>
>>>>>> +config HAVE_MEMORYLESS_NODES
>>>>>> +       def_bool y
>>>>>> +       depends on NUMA
>>>>>> +
>>>>>>  source kernel/Kconfig.preempt
>>>>>>  source kernel/Kconfig.hz
>>>>>>
>>>>>> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
>>>>>> index d099306..9e15297 100644
>>>>>> --- a/arch/arm64/kernel/smp.c
>>>>>> +++ b/arch/arm64/kernel/smp.c
>>>>>> @@ -620,6 +620,7 @@ static void __init of_parse_and_init_cpus(void)
>>>>>>                         }
>>>>>>
>>>>>>                         bootcpu_valid = true;
>>>>>> +                       early_map_cpu_to_node(0, of_node_to_nid(dn));
>>>>>>
>>>>>>                         /*
>>>>>>                          * cpu_logical_map has already been
>>>>>> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
>>>>>> index df5c842..d73b0a0 100644
>>>>>> --- a/arch/arm64/mm/numa.c
>>>>>> +++ b/arch/arm64/mm/numa.c
>>>>>> @@ -128,6 +128,14 @@ void __init early_map_cpu_to_node(unsigned int cpu, int nid)
>>>>>>                 nid = 0;
>>>>>>
>>>>>>         cpu_to_node_map[cpu] = nid;
>>>>>> +
>>>>>> +       /*
>>>>>> +        * We should set the numa node of cpu0 as soon as possible, because it
>>>>>> +        * has already been set up online before. cpu_to_node(0) will soon be
>>>>>> +        * called.
>>>>>> +        */
>>>>>> +       if (!cpu)
>>>>>> +               set_cpu_numa_node(cpu, nid);
>>>>>>  }
>>>>>>
>>>>>>  #ifdef CONFIG_HAVE_SETUP_PER_CPU_AREA
>>>>>> @@ -215,6 +223,35 @@ int __init numa_add_memblk(int nid, u64 start, u64 end)
>>>>>>         return ret;
>>>>>>  }
>>>>>>
>>>>>> +static u64 __init alloc_node_data_from_nearest_node(int nid, const size_t size)
>>>>>> +{
>>>>>> +       int i, best_nid, distance;
>>>>>> +       u64 pa;
>>>>>> +       DECLARE_BITMAP(nodes_map, MAX_NUMNODES);
>>>>>> +
>>>>>> +       bitmap_zero(nodes_map, MAX_NUMNODES);
>>>>>> +       bitmap_set(nodes_map, nid, 1);
>>>>>> +
>>>>>> +find_nearest_node:
>>>>>> +       best_nid = NUMA_NO_NODE;
>>>>>> +       distance = INT_MAX;
>>>>>> +
>>>>>> +       for_each_clear_bit(i, nodes_map, MAX_NUMNODES)
>>>>>> +               if (numa_distance[nid][i] < distance) {
>>>>>> +                       best_nid = i;
>>>>>> +                       distance = numa_distance[nid][i];
>>>>>> +               }
>>>>>> +
>>>>>> +       pa = memblock_alloc_nid(size, SMP_CACHE_BYTES, best_nid);
>>>>>> +       if (!pa) {
>>>>>> +               BUG_ON(best_nid == NUMA_NO_NODE);
>>>>>> +               bitmap_set(nodes_map, best_nid, 1);
>>>>>> +               goto find_nearest_node;
>>>>>> +       }
>>>>>> +
>>>>>> +       return pa;
>>>>>> +}
>>>>>> +
>>>
>>> why do we need this function in arch specific code.
>> I also considered put these code(include HAVE_SETUP_PER_CPU_AREA) into drivers/of/of_numa.c,
>> but if I do that, it will make acpi numa dependent on of numa.
> 
> numa core/common code is mainly in directory mm/
> drivers/of/of_numa.c implements only device tree numa binding.

As above, IA64 also have a similar implementation under arch/ia64 directory.
And it seems the implementation of IA64 and mine cann't be merged into one.
So I suggest that currently stay these code here.

> 
>>
>>> dont you think common code will take care of this? when you define
>>> HAVE_MEMORYLESS_NODES
>>
>> I have searched CONFIG_HAVE_MEMORYLESS_NODES in *.c, but did not find the relevant content.
>> So maybe other ARCHs also missed this.
> 
> as mentioned above, arch code may not need any changes for this.
>>
>>>
>>>>>>  /**
>>>>>>   * Initialize NODE_DATA for a node on the local memory
>>>>>>   */
>>>>>> @@ -228,7 +265,9 @@ static void __init setup_node_data(int nid, u64 start_pfn, u64 end_pfn)
>>>>>>         pr_info("Initmem setup node %d [mem %#010Lx-%#010Lx]\n",
>>>>>>                 nid, start_pfn << PAGE_SHIFT, (end_pfn << PAGE_SHIFT) - 1);
>>>>>>
>>>>>> -       nd_pa = memblock_alloc_try_nid(nd_size, SMP_CACHE_BYTES, nid);
>>>
>>> this function try to allocate from a nid, if fails, it allocates from
>>> node 0(local node).
>>> this is ok for memory less node i guess.
>> Yes, the function is OK, but the performance is not.
>>
>> Suppose there are 3 nodes:
>> 1. cpu0 on node0, cpu1 on node1, cpu2 on node2.
>> 2. cpu2 access the memory on node1 take 1us, but access the memory on node1 take 5us.
>>    That is, distance[2,1] is shorter than distance[2,0].
>> 3. And node2 is a memoryless node.
>>
>> So if NODE_DATA(2) allocated from node0, it will take more time than allocted from node1 at run time.
>> Because NODE_DATA will be accessed at run time.
>>
>>>
>>>>>> +       nd_pa = memblock_alloc_nid(nd_size, SMP_CACHE_BYTES, nid);
>>>>>> +       if (!nd_pa)
>>>>>> +               nd_pa = alloc_node_data_from_nearest_node(nid, nd_size);
>>>>>>         nd = __va(nd_pa);
>>>>>>
>>>>>>         /* report and initialize */
>>>>>> @@ -238,7 +277,7 @@ static void __init setup_node_data(int nid, u64 start_pfn, u64 end_pfn)
>>>>>>         if (tnid != nid)
>>>>>>                 pr_info("    NODE_DATA(%d) on node %d\n", nid, tnid);
>>>>>>
>>>>>> -       node_data[nid] = nd;
>>>>>> +       NODE_DATA(nid) = nd;
>>>>>>         memset(NODE_DATA(nid), 0, sizeof(pg_data_t));
>>>>>>         NODE_DATA(nid)->node_id = nid;
>>>>>>         NODE_DATA(nid)->node_start_pfn = start_pfn;
>>>>>> --
>>>>>> 2.5.0
>>>>>>
>>>>>>
>>>>> Ganapat
>>>>>>
>>>>>> _______________________________________________
>>>>>> linux-arm-kernel mailing list
>>>>>> linux-arm-kernel at lists.infradead.org
>>>>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>>>
>>>>> .
>>>>>
>>>>
>>>
>>> .
>>>
>>
> 
> thanks
> Ganapat
> 
> .
> 
