From: gpkulkarni@gmail.com (Ganapatrao Kulkarni)
Date: Tue, 20 Sep 2016 10:15:57 +0530
Subject: [PATCH] arm64, numa: Add cpu_to_node() implementation.
In-Reply-To: <1474310970-21264-1-git-send-email-ddaney.cavm@gmail.com>
References: <1474310970-21264-1-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <CAFpQJXVqoHv06YBd41YYKtJC5FFgGTHB-Yj4FwKKELsDTveOVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[sending again, previous email was not text]

On Tue, Sep 20, 2016 at 12:19 AM, David Daney <ddaney.cavm@gmail.com> wrote:
> From: David Daney <david.daney@cavium.com>
>
> The wq_numa_init() function makes a private CPU to node map by calling
> cpu_to_node() early in the boot process, before the non-boot CPUs are
> brought online.  Since the default implementation of cpu_to_node()
> returns zero for CPUs that have never been brought online, the
> workqueue system's view is that *all* CPUs are on node zero.
>
> When the unbound workqueue for a non-zero node is created, the
> tsk_cpus_allowed() for the worker threads is the empty set because
> there are, in the view of the workqueue system, no CPUs on non-zero
> nodes.  The code in try_to_wake_up() using this empty cpumask ends up
> using the cpumask empty set value of NR_CPUS as an index into the
> per-CPU area pointer array, and gets garbage as it is one past the end
> of the array.  This results in:
>
> [    0.881970] Unable to handle kernel paging request at virtual address fffffb1008b926a4
> [    1.970095] pgd = fffffc00094b0000
> [    1.973530] [fffffb1008b926a4] *pgd=0000000000000000, *pud=0000000000000000, *pmd=0000000000000000
> [    1.982610] Internal error: Oops: 96000004 [#1] SMP
> [    1.987541] Modules linked in:
> [    1.990631] CPU: 48 PID: 295 Comm: cpuhp/48 Tainted: G        W       4.8.0-rc6-preempt-vol+ #9
> [    1.999435] Hardware name: Cavium ThunderX CN88XX board (DT)
> [    2.005159] task: fffffe0fe89cc300 task.stack: fffffe0fe8b8c000
> [    2.011158] PC is at try_to_wake_up+0x194/0x34c
> [    2.015737] LR is at try_to_wake_up+0x150/0x34c
> [    2.020318] pc : [<fffffc00080e7468>] lr : [<fffffc00080e7424>] pstate: 600000c5
> [    2.027803] sp : fffffe0fe8b8fb10
> [    2.031149] x29: fffffe0fe8b8fb10 x28: 0000000000000000
> [    2.036522] x27: fffffc0008c63bc8 x26: 0000000000001000
> [    2.041896] x25: fffffc0008c63c80 x24: fffffc0008bfb200
> [    2.047270] x23: 00000000000000c0 x22: 0000000000000004
> [    2.052642] x21: fffffe0fe89d25bc x20: 0000000000001000
> [    2.058014] x19: fffffe0fe89d1d00 x18: 0000000000000000
> [    2.063386] x17: 0000000000000000 x16: 0000000000000000
> [    2.068760] x15: 0000000000000018 x14: 0000000000000000
> [    2.074133] x13: 0000000000000000 x12: 0000000000000000
> [    2.079505] x11: 0000000000000000 x10: 0000000000000000
> [    2.084879] x9 : 0000000000000000 x8 : 0000000000000000
> [    2.090251] x7 : 0000000000000040 x6 : 0000000000000000
> [    2.095621] x5 : ffffffffffffffff x4 : 0000000000000000
> [    2.100991] x3 : 0000000000000000 x2 : 0000000000000000
> [    2.106364] x1 : fffffc0008be4c24 x0 : ffffff0ffffada80
> [    2.111737]
> [    2.113236] Process cpuhp/48 (pid: 295, stack limit = 0xfffffe0fe8b8c020)
> [    2.120102] Stack: (0xfffffe0fe8b8fb10 to 0xfffffe0fe8b90000)
> [    2.125914] fb00:                                   fffffe0fe8b8fb80 fffffc00080e7648
> .
> .
> .
> [    2.442859] Call trace:
> [    2.445327] Exception stack(0xfffffe0fe8b8f940 to 0xfffffe0fe8b8fa70)
> [    2.451843] f940: fffffe0fe89d1d00 0000040000000000 fffffe0fe8b8fb10 fffffc00080e7468
> [    2.459767] f960: fffffe0fe8b8f980 fffffc00080e4958 ffffff0ff91ab200 fffffc00080e4b64
> [    2.467690] f980: fffffe0fe8b8f9d0 fffffc00080e515c fffffe0fe8b8fa80 0000000000000000
> [    2.475614] f9a0: fffffe0fe8b8f9d0 fffffc00080e58e4 fffffe0fe8b8fa80 0000000000000000
> [    2.483540] f9c0: fffffe0fe8d10000 0000000000000040 fffffe0fe8b8fa50 fffffc00080e5ac4
> [    2.491465] f9e0: ffffff0ffffada80 fffffc0008be4c24 0000000000000000 0000000000000000
> [    2.499387] fa00: 0000000000000000 ffffffffffffffff 0000000000000000 0000000000000040
> [    2.507309] fa20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> [    2.515233] fa40: 0000000000000000 0000000000000000 0000000000000000 0000000000000018
> [    2.523156] fa60: 0000000000000000 0000000000000000
> [    2.528089] [<fffffc00080e7468>] try_to_wake_up+0x194/0x34c
> [    2.533723] [<fffffc00080e7648>] wake_up_process+0x28/0x34
> [    2.539275] [<fffffc00080d3764>] create_worker+0x110/0x19c
> [    2.544824] [<fffffc00080d69dc>] alloc_unbound_pwq+0x3cc/0x4b0
> [    2.550724] [<fffffc00080d6bcc>] wq_update_unbound_numa+0x10c/0x1e4
> [    2.557066] [<fffffc00080d7d78>] workqueue_online_cpu+0x220/0x28c
> [    2.563234] [<fffffc00080bd288>] cpuhp_invoke_callback+0x6c/0x168
> [    2.569398] [<fffffc00080bdf74>] cpuhp_up_callbacks+0x44/0xe4
> [    2.575210] [<fffffc00080be194>] cpuhp_thread_fun+0x13c/0x148
> [    2.581027] [<fffffc00080dfbac>] smpboot_thread_fn+0x19c/0x1a8
> [    2.586929] [<fffffc00080dbd64>] kthread+0xdc/0xf0
> [    2.591776] [<fffffc0008083380>] ret_from_fork+0x10/0x50
> [    2.597147] Code: b00057e1 91304021 91005021 b8626822 (b8606821)
> [    2.603464] ---[ end trace 58c0cd36b88802bc ]---
> [    2.608138] Kernel panic - not syncing: Fatal exception
>
> Fix by supplying a cpu_to_node() implementation that returns correct
> node mappings.
>
> Cc: <stable@vger.kernel.org> # 4.7.x-
> Signed-off-by: David Daney <david.daney@cavium.com>
>

Acked-by: Ganapatrao Kulkarni <gkulkarni@cavium.com>

> ---
>  arch/arm64/include/asm/topology.h |  3 +++
>  arch/arm64/mm/numa.c              | 18 ++++++++++++++++++
>  2 files changed, 21 insertions(+)
>
> diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
> index 8b57339..8d935447 100644
> --- a/arch/arm64/include/asm/topology.h
> +++ b/arch/arm64/include/asm/topology.h
> @@ -30,6 +30,9 @@ int pcibus_to_node(struct pci_bus *bus);
>                                  cpu_all_mask :                         \
>                                  cpumask_of_node(pcibus_to_node(bus)))
>
> +int cpu_to_node(int cpu);
> +#define cpu_to_node cpu_to_node
> +
>  #endif /* CONFIG_NUMA */
>
>  #include <asm-generic/topology.h>
> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
> index 5bb15ea..e76281b 100644
> --- a/arch/arm64/mm/numa.c
> +++ b/arch/arm64/mm/numa.c
> @@ -130,6 +130,24 @@ void __init early_map_cpu_to_node(unsigned int cpu, int nid)
>         cpu_to_node_map[cpu] = nid;
>  }
>
> +int cpu_to_node(int cpu)
> +{
> +       int nid;
> +
> +       /*
> +        * Return 0 for unknown mapping so that we report something
> +        * sensible if firmware doesn't supply a proper mapping.
> +        */
> +       if (cpu < 0 || cpu >= NR_CPUS)
> +               return 0;
> +
> +       nid = cpu_to_node_map[cpu];
> +       if (nid == NUMA_NO_NODE)
> +               nid = 0;
> +       return nid;
> +}
> +EXPORT_SYMBOL(cpu_to_node);
> +
>  /**
>   * numa_add_memblk - Set node id to memblk
>   * @nid: NUMA node ID of the new memblk
> --
> 1.8.3.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
