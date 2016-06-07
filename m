From: thunder.leizhen@huawei.com (Leizhen (ThunderTown))
Date: Tue, 7 Jun 2016 20:42:21 +0800
Subject: [PATCH v4 12/14] arm64/numa: remove some useless code
In-Reply-To: <CAFpQJXU+YFCkEawQZYFWSayYgi4c5=N2H8mxzz2XhVbSbTeBMQ@mail.gmail.com>
References: <1465286898-13828-1-git-send-email-thunder.leizhen@huawei.com>
 <1465286898-13828-13-git-send-email-thunder.leizhen@huawei.com>
 <CAFpQJXU+YFCkEawQZYFWSayYgi4c5=N2H8mxzz2XhVbSbTeBMQ@mail.gmail.com>
Message-ID: <5756C12D.4030608@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/6/7 16:28, Ganapatrao Kulkarni wrote:
> On Tue, Jun 7, 2016 at 1:38 PM, Zhen Lei <thunder.leizhen@huawei.com> wrote:
>> 1. Currently only cpu0 set on cpu_possible_mask and percpu areas have not
>>    been initialized.
>> 2. No reason to limit cpu0 must belongs to node0.
> 
> even smp init assumes cpu0/boot processor.
Yes, we define boot cpu as cpu0. But we can not force cpu0 must belongs to node0.
For example, we use the same Image and dtb run on two boards. On the first board,
BIOS choose cpu-A as boot cpu. But on the other board, BIOS may choose CPU-B as
boot cpu. Although this case is difficult to appear, but we can not sure that it
will not appear.

> is this patch tested on any hardware?
Yes, I tested it on our D02 board.

> can you describe your testing hardware?
Althoug D02 only contains one hardware numa node. But the implementation of numa
software is hardware independent, so I define some logical numa nodes. For example:
treat each core as a numa node, and subdivide momory.

>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  arch/arm64/mm/numa.c | 8 --------
>>  1 file changed, 8 deletions(-)
>>
>> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
>> index d73b0a0..92b1692 100644
>> --- a/arch/arm64/mm/numa.c
>> +++ b/arch/arm64/mm/numa.c
>> @@ -93,7 +93,6 @@ void numa_clear_node(unsigned int cpu)
>>   */
>>  static void __init setup_node_to_cpumask_map(void)
>>  {
>> -       unsigned int cpu;
>>         int node;
>>
>>         /* setup nr_node_ids if not done yet */
>> @@ -106,9 +105,6 @@ static void __init setup_node_to_cpumask_map(void)
>>                 cpumask_clear(node_to_cpumask_map[node]);
>>         }
>>
>> -       for_each_possible_cpu(cpu)
>> -               set_cpu_numa_node(cpu, NUMA_NO_NODE);
>> -
> 
> do you see this init of setting node id to NUMA_NO_NODE  for each cpu
> happening any where else?
I have used below code to verify my judgement, it's only "cpu=0" printed.

for_each_possible_cpu(cpu)
	pr_info("setup_node_to_cpumask_map: cpu=%d\n", cpu);

Actually, the execution sequence is as below:
1. setup_arch
   1) bootmem_init();   -->arm64_numa_init
   2) smp_init_cpus();	-->smp_cpu_setup --> set_cpu_possible(cpu, true);

So that, the above deleted code only set cpu0 to NUMA_NO_NODE. And the below
deleted code set cpu0 to nid0. In fact, the default value of cpu_to_node(0)
is also zero. So I said these code take no effect.

> otherwise, better to have initialised node id/NUMA_NO_NODE to every
> cpu otherwise default  node id will be shown as zero
> which is not correct.
> 
>>         /* cpumask_of_node() will now work */
>>         pr_debug("Node to cpumask map for %d nodes\n", nr_node_ids);
>>  }
>> @@ -379,10 +375,6 @@ static int __init numa_init(int (*init_func)(void))
>>
>>         setup_node_to_cpumask_map();
>>
>> -       /* init boot processor */
>> -       cpu_to_node_map[0] = 0;
>> -       map_cpu_to_node(0, 0);
>> -
> 
> otherwise, how you set numa info for cpu0/boot-processor?
I have done it in the previous patch.

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index d099306..9e15297 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -620,6 +620,7 @@ static void __init of_parse_and_init_cpus(void)
 			}

 			bootcpu_valid = true;
+			early_map_cpu_to_node(0, of_node_to_nid(dn));

 			/*
 			 * cpu_logical_map has already been
diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
index df5c842..d73b0a0 100644
--- a/arch/arm64/mm/numa.c
+++ b/arch/arm64/mm/numa.c
@@ -128,6 +128,14 @@ void __init early_map_cpu_to_node(unsigned int cpu, int nid)
 		nid = 0;

 	cpu_to_node_map[cpu] = nid;
+
+	/*
+	 * We should set the numa node of cpu0 as soon as possible, because it
+	 * has already been set up online before. cpu_to_node(0) will soon be
+	 * called.
+	 */
+	if (!cpu)
+		set_cpu_numa_node(cpu, nid);
 }

> 
> thanks
> Ganapat
>>         return 0;
>>  }
>>
>> --
>> 2.5.0
>>
>>
>>
> 
> thanks
> ganapat
> 
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> .
> 
