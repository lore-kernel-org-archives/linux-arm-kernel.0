From: dietmar.eggemann@arm.com (Dietmar Eggemann)
Date: Thu, 7 Sep 2017 11:41:09 +0100
Subject: [PATCH 1/4] arm: topology: remove cpu_efficiency
In-Reply-To: <CAKfTPtAvhujS1wpP1JE8OqCfsKXcrFxLQ0207WFg3ZhZjoHnBA@mail.gmail.com>
References: <20170830144120.9312-1-dietmar.eggemann@arm.com>
 <20170830144120.9312-2-dietmar.eggemann@arm.com>
 <CAKfTPtBXkAyAc1aqqqEn6Yt14_Y7LFp3oySY-=G3ZTuG-DR_nA@mail.gmail.com>
 <303d3f7b-5d64-e13a-c4f9-dd575958cafa@arm.com>
 <CAKfTPtAvhujS1wpP1JE8OqCfsKXcrFxLQ0207WFg3ZhZjoHnBA@mail.gmail.com>
Message-ID: <d7c01524-cbd0-70fb-6995-93ac1e2fdaf7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/09/17 13:40, Vincent Guittot wrote:
> On 6 September 2017 at 13:43, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>> Hi Vincent,
>>
>> On 04/09/17 08:49, Vincent Guittot wrote:
>>> Hi Dietmar,
>>>
>>> Removing cpu effificiency table looks good to me. Nevertheless, i have
>>> some comments below for this patch.
>>
>> Thanks for the review!
>>
>>> On 30 August 2017 at 16:41, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:

[...]

I fixed the issue with the continue statement. Moreover, I think we should also
remove the comment block about 'cpu capacity scale management' and 'cpu capacity
table' on top of  parse_dt_topology() because this is now all handled in
drivers/base/arch_topology.c.

-- >8 --

From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Date: Sun, 9 Jul 2017 23:43:43 +0100
Subject: [PATCH] arm: topology: remove cpu_efficiency

Remove the 'cpu_efficiency/clock-frequency dt property' based solution
to set cpu capacity which was only working for Cortex-A15/A7 arm
big.LITTLE systems.

I.e. the 'capacity-dmips-mhz' based solution is now the only one. It is
shared between arm and arm64 and works for every big.LITTLE system no
matter which core types it consists of.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Juri Lelli <juri.lelli@arm.com>
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 arch/arm/kernel/topology.c | 130 ++-------------------------------------------
 1 file changed, 3 insertions(+), 127 deletions(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index bf949a763dbe..5f46d290e34b 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -30,69 +30,11 @@
 #include <asm/cputype.h>
 #include <asm/topology.h>
 
-/*
- * cpu capacity scale management
- */
-
-/*
- * cpu capacity table
- * This per cpu data structure describes the relative capacity of each core.
- * On a heteregenous system, cores don't have the same computation capacity
- * and we reflect that difference in the cpu_capacity field so the scheduler
- * can take this difference into account during load balance. A per cpu
- * structure is preferred because each CPU updates its own cpu_capacity field
- * during the load balance except for idle cores. One idle core is selected
- * to run the rebalance_domains for all idle cores and the cpu_capacity can be
- * updated during this sequence.
- */
-
 #ifdef CONFIG_OF
-struct cpu_efficiency {
-       const char *compatible;
-       unsigned long efficiency;
-};
-
-/*
- * Table of relative efficiency of each processors
- * The efficiency value must fit in 20bit and the final
- * cpu_scale value must be in the range
- *   0 < cpu_scale < 3*SCHED_CAPACITY_SCALE/2
- * in order to return@most 1 when DIV_ROUND_CLOSEST
- * is used to compute the capacity of a CPU.
- * Processors that are not defined in the table,
- * use the default SCHED_CAPACITY_SCALE value for cpu_scale.
- */
-static const struct cpu_efficiency table_efficiency[] = {
-       {"arm,cortex-a15", 3891},
-       {"arm,cortex-a7",  2048},
-       {NULL, },
-};
-
-static unsigned long *__cpu_capacity;
-#define cpu_capacity(cpu)      __cpu_capacity[cpu]
-
-static unsigned long middle_capacity = 1;
-static bool cap_from_dt = true;
-
-/*
- * Iterate all CPUs' descriptor in DT and compute the efficiency
- * (as per table_efficiency). Also calculate a middle efficiency
- * as close as possible to  (max{eff_i} - min{eff_i}) / 2
- * This is later used to scale the cpu_capacity field such that an
- * 'average' CPU is of middle capacity. Also see the comments near
- * table_efficiency[] and update_cpu_capacity().
- */
 static void __init parse_dt_topology(void)
 {
-       const struct cpu_efficiency *cpu_eff;
-       struct device_node *cn = NULL;
-       unsigned long min_capacity = ULONG_MAX;
-       unsigned long max_capacity = 0;
-       unsigned long capacity = 0;
-       int cpu = 0;
-
-       __cpu_capacity = kcalloc(nr_cpu_ids, sizeof(*__cpu_capacity),
-                                GFP_NOWAIT);
+       struct device_node *cn;
+       int cpu;
 
        cn = of_find_node_by_path("/cpus");
        if (!cn) {
@@ -101,9 +43,6 @@ static void __init parse_dt_topology(void)
        }
 
        for_each_possible_cpu(cpu) {
-               const u32 *rate;
-               int len;
-
                /* too early to use cpu->of_node */
                cn = of_get_cpu_node(cpu, NULL);
                if (!cn) {
@@ -113,75 +52,14 @@ static void __init parse_dt_topology(void)
 
                if (topology_parse_cpu_capacity(cn, cpu)) {
                        of_node_put(cn);
-                       continue;
                }
-
-               cap_from_dt = false;
-
-               for (cpu_eff = table_efficiency; cpu_eff->compatible; cpu_eff++)
-                       if (of_device_is_compatible(cn, cpu_eff->compatible))
-                               break;
-
-               if (cpu_eff->compatible == NULL)
-                       continue;
-
-               rate = of_get_property(cn, "clock-frequency", &len);
-               if (!rate || len != 4) {
-                       pr_err("%s missing clock-frequency property\n",
-                               cn->full_name);
-                       continue;
-               }
-
-               capacity = ((be32_to_cpup(rate)) >> 20) * cpu_eff->efficiency;
-
-               /* Save min capacity of the system */
-               if (capacity < min_capacity)
-                       min_capacity = capacity;
-
-               /* Save max capacity of the system */
-               if (capacity > max_capacity)
-                       max_capacity = capacity;
-
-               cpu_capacity(cpu) = capacity;
        }
 
-       /* If min and max capacities are equals, we bypass the update of the
-        * cpu_scale because all CPUs have the same capacity. Otherwise, we
-        * compute a middle_capacity factor that will ensure that the capacity
-        * of an 'average' CPU of the system will be as close as possible to
-        * SCHED_CAPACITY_SCALE, which is the default value, but with the
-        * constraint explained near table_efficiency[].
-        */
-       if (4*max_capacity < (3*(max_capacity + min_capacity)))
-               middle_capacity = (min_capacity + max_capacity)
-                               >> (SCHED_CAPACITY_SHIFT+1);
-       else
-               middle_capacity = ((max_capacity / 3)
-                               >> (SCHED_CAPACITY_SHIFT-1)) + 1;
-
-       if (cap_from_dt)
-               topology_normalize_cpu_scale();
-}
-
-/*
- * Look for a customed capacity of a CPU in the cpu_capacity table during the
- * boot. The update of all CPUs is in O(n^2) for heteregeneous system but the
- * function returns directly for SMP system.
- */
-static void update_cpu_capacity(unsigned int cpu)
-{
-       if (!cpu_capacity(cpu) || cap_from_dt)
-               return;
-
-       topology_set_cpu_scale(cpu, cpu_capacity(cpu) / middle_capacity);
-
-       pr_info("CPU%u: update cpu_capacity %lu\n",
-               cpu, topology_get_cpu_scale(NULL, cpu));
+       topology_normalize_cpu_scale();
 }
 
 #else
 static inline void parse_dt_topology(void) {}
-static inline void update_cpu_capacity(unsigned int cpuid) {}
 #endif
 
  /*
@@ -277,8 +155,6 @@ void store_cpu_topology(unsigned int cpuid)
 
        update_siblings_masks(cpuid);
 
-       update_cpu_capacity(cpuid);
-
        pr_info("CPU%u: thread %d, cpu %d, socket %d, mpidr %x\n",
                cpuid, cpu_topology[cpuid].thread_id,
                cpu_topology[cpuid].core_id,
-- 
2.11.0
