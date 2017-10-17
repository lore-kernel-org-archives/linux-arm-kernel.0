From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Tue, 17 Oct 2017 14:28:01 +0200
Subject: [PATCH v2 1/1] arm: topology: remove cpu_efficiency
In-Reply-To: <20171012140028.21599-2-dietmar.eggemann@arm.com>
References: <20171012140028.21599-1-dietmar.eggemann@arm.com>
 <20171012140028.21599-2-dietmar.eggemann@arm.com>
Message-ID: <CAKfTPtARJC161pXeqrz_d5wxqXPLczGCm_dbZ3fW54CAXuDTmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dietmar,

On 12 October 2017 at 16:00, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> Remove the 'cpu_efficiency/clock-frequency dt property' based solution
> to set cpu capacity which was only working for Cortex-A15/A7 arm
> big.LITTLE systems.
>
> I.e. the 'capacity-dmips-mhz' based solution is now the only one. It is
> shared between arm and arm64 and works for every big.LITTLE system no
> matter which core types it consists of.
>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Juri Lelli <juri.lelli@gmail.com>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>  arch/arm/kernel/topology.c | 132 ++-------------------------------------------
>  1 file changed, 4 insertions(+), 128 deletions(-)
>
> diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
> index 24ac3cab411d..15cc131ae387 100644
> --- a/arch/arm/kernel/topology.c
> +++ b/arch/arm/kernel/topology.c
> @@ -30,69 +30,11 @@
>  #include <asm/cputype.h>
>  #include <asm/topology.h>
>
> -/*
> - * cpu capacity scale management
> - */
> -
> -/*
> - * cpu capacity table
> - * This per cpu data structure describes the relative capacity of each core.
> - * On a heteregenous system, cores don't have the same computation capacity
> - * and we reflect that difference in the cpu_capacity field so the scheduler
> - * can take this difference into account during load balance. A per cpu
> - * structure is preferred because each CPU updates its own cpu_capacity field
> - * during the load balance except for idle cores. One idle core is selected
> - * to run the rebalance_domains for all idle cores and the cpu_capacity can be
> - * updated during this sequence.
> - */
> -
>  #ifdef CONFIG_OF
> -struct cpu_efficiency {
> -       const char *compatible;
> -       unsigned long efficiency;
> -};
> -
> -/*
> - * Table of relative efficiency of each processors
> - * The efficiency value must fit in 20bit and the final
> - * cpu_scale value must be in the range
> - *   0 < cpu_scale < 3*SCHED_CAPACITY_SCALE/2
> - * in order to return at most 1 when DIV_ROUND_CLOSEST
> - * is used to compute the capacity of a CPU.
> - * Processors that are not defined in the table,
> - * use the default SCHED_CAPACITY_SCALE value for cpu_scale.
> - */
> -static const struct cpu_efficiency table_efficiency[] = {
> -       {"arm,cortex-a15", 3891},
> -       {"arm,cortex-a7",  2048},
> -       {NULL, },
> -};
> -
> -static unsigned long *__cpu_capacity;
> -#define cpu_capacity(cpu)      __cpu_capacity[cpu]
> -
> -static unsigned long middle_capacity = 1;
> -static bool cap_from_dt = true;
> -
> -/*
> - * Iterate all CPUs' descriptor in DT and compute the efficiency
> - * (as per table_efficiency). Also calculate a middle efficiency
> - * as close as possible to  (max{eff_i} - min{eff_i}) / 2
> - * This is later used to scale the cpu_capacity field such that an
> - * 'average' CPU is of middle capacity. Also see the comments near
> - * table_efficiency[] and update_cpu_capacity().
> - */
>  static void __init parse_dt_topology(void)
>  {
> -       const struct cpu_efficiency *cpu_eff;
> -       struct device_node *cn = NULL;
> -       unsigned long min_capacity = ULONG_MAX;
> -       unsigned long max_capacity = 0;
> -       unsigned long capacity = 0;
> -       int cpu = 0;
> -
> -       __cpu_capacity = kcalloc(nr_cpu_ids, sizeof(*__cpu_capacity),
> -                                GFP_NOWAIT);
> +       struct device_node *cn;
> +       int cpu;
>
>         cn = of_find_node_by_path("/cpus");
>         if (!cn) {
> @@ -101,9 +43,6 @@ static void __init parse_dt_topology(void)
>         }
>
>         for_each_possible_cpu(cpu) {
> -               const u32 *rate;
> -               int len;
> -
>                 /* too early to use cpu->of_node */
>                 cn = of_get_cpu_node(cpu, NULL);
>                 if (!cn) {
> @@ -111,76 +50,15 @@ static void __init parse_dt_topology(void)
>                         continue;
>                 }
>
> -               if (topology_parse_cpu_capacity(cn, cpu)) {
> +               if (topology_parse_cpu_capacity(cn, cpu))
>                         of_node_put(cn);

We should call the of_node_put unconditionally  to balance the
of_get_cpu_node, isn't it ?
Note that this problem is also present without your change

> -                       continue;
> -               }
> -
> -               cap_from_dt = false;
> -
> -               for (cpu_eff = table_efficiency; cpu_eff->compatible; cpu_eff++)
> -                       if (of_device_is_compatible(cn, cpu_eff->compatible))
> -                               break;
> -
> -               if (cpu_eff->compatible == NULL)
> -                       continue;
> -
> -               rate = of_get_property(cn, "clock-frequency", &len);
> -               if (!rate || len != 4) {
> -                       pr_err("%pOF missing clock-frequency property\n", cn);
> -                       continue;
> -               }
> -
> -               capacity = ((be32_to_cpup(rate)) >> 20) * cpu_eff->efficiency;
> -
> -               /* Save min capacity of the system */
> -               if (capacity < min_capacity)
> -                       min_capacity = capacity;
> -
> -               /* Save max capacity of the system */
> -               if (capacity > max_capacity)
> -                       max_capacity = capacity;
> -
> -               cpu_capacity(cpu) = capacity;
>         }
>
> -       /* If min and max capacities are equals, we bypass the update of the
> -        * cpu_scale because all CPUs have the same capacity. Otherwise, we
> -        * compute a middle_capacity factor that will ensure that the capacity
> -        * of an 'average' CPU of the system will be as close as possible to
> -        * SCHED_CAPACITY_SCALE, which is the default value, but with the
> -        * constraint explained near table_efficiency[].
> -        */
> -       if (4*max_capacity < (3*(max_capacity + min_capacity)))
> -               middle_capacity = (min_capacity + max_capacity)
> -                               >> (SCHED_CAPACITY_SHIFT+1);
> -       else
> -               middle_capacity = ((max_capacity / 3)
> -                               >> (SCHED_CAPACITY_SHIFT-1)) + 1;
> -
> -       if (cap_from_dt)
> -               topology_normalize_cpu_scale();
> -}
> -
> -/*
> - * Look for a customed capacity of a CPU in the cpu_capacity table during the
> - * boot. The update of all CPUs is in O(n^2) for heteregeneous system but the
> - * function returns directly for SMP system.
> - */
> -static void update_cpu_capacity(unsigned int cpu)
> -{
> -       if (!cpu_capacity(cpu) || cap_from_dt)
> -               return;
> -
> -       topology_set_cpu_scale(cpu, cpu_capacity(cpu) / middle_capacity);
> -
> -       pr_info("CPU%u: update cpu_capacity %lu\n",
> -               cpu, topology_get_cpu_scale(NULL, cpu));
> +       topology_normalize_cpu_scale();
>  }
>
>  #else
>  static inline void parse_dt_topology(void) {}
> -static inline void update_cpu_capacity(unsigned int cpuid) {}
>  #endif
>
>   /*
> @@ -276,8 +154,6 @@ void store_cpu_topology(unsigned int cpuid)
>
>         update_siblings_masks(cpuid);
>
> -       update_cpu_capacity(cpuid);
> -
>         pr_info("CPU%u: thread %d, cpu %d, socket %d, mpidr %x\n",
>                 cpuid, cpu_topology[cpuid].thread_id,
>                 cpu_topology[cpuid].core_id,
> --
> 2.11.0
>
