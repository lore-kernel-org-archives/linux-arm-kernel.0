From: gpkulkarni@gmail.com (Ganapatrao Kulkarni)
Date: Tue, 7 Jun 2016 13:58:18 +0530
Subject: [PATCH v4 12/14] arm64/numa: remove some useless code
In-Reply-To: <1465286898-13828-13-git-send-email-thunder.leizhen@huawei.com>
References: <1465286898-13828-1-git-send-email-thunder.leizhen@huawei.com>
 <1465286898-13828-13-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <CAFpQJXU+YFCkEawQZYFWSayYgi4c5=N2H8mxzz2XhVbSbTeBMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 7, 2016 at 1:38 PM, Zhen Lei <thunder.leizhen@huawei.com> wrote:
> 1. Currently only cpu0 set on cpu_possible_mask and percpu areas have not
>    been initialized.
> 2. No reason to limit cpu0 must belongs to node0.

even smp init assumes cpu0/boot processor.
is this patch tested on any hardware?
can you describe your testing hardware?
>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  arch/arm64/mm/numa.c | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
> index d73b0a0..92b1692 100644
> --- a/arch/arm64/mm/numa.c
> +++ b/arch/arm64/mm/numa.c
> @@ -93,7 +93,6 @@ void numa_clear_node(unsigned int cpu)
>   */
>  static void __init setup_node_to_cpumask_map(void)
>  {
> -       unsigned int cpu;
>         int node;
>
>         /* setup nr_node_ids if not done yet */
> @@ -106,9 +105,6 @@ static void __init setup_node_to_cpumask_map(void)
>                 cpumask_clear(node_to_cpumask_map[node]);
>         }
>
> -       for_each_possible_cpu(cpu)
> -               set_cpu_numa_node(cpu, NUMA_NO_NODE);
> -

do you see this init of setting node id to NUMA_NO_NODE  for each cpu
happening any where else?
otherwise, better to have initialised node id/NUMA_NO_NODE to every
cpu otherwise default  node id will be shown as zero
which is not correct.

>         /* cpumask_of_node() will now work */
>         pr_debug("Node to cpumask map for %d nodes\n", nr_node_ids);
>  }
> @@ -379,10 +375,6 @@ static int __init numa_init(int (*init_func)(void))
>
>         setup_node_to_cpumask_map();
>
> -       /* init boot processor */
> -       cpu_to_node_map[0] = 0;
> -       map_cpu_to_node(0, 0);
> -

otherwise, how you set numa info for cpu0/boot-processor?

thanks
Ganapat
>         return 0;
>  }
>
> --
> 2.5.0
>
>
>

thanks
ganapat

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
