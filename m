From: tanxiaojun@huawei.com (Tan Xiaojun)
Date: Sat, 25 Feb 2017 16:10:37 +0800
Subject: [tip:perf/urgent] perf/core: Fix the perf_cpu_time_max_percent
 check
In-Reply-To: <tip-1572e45a924f254d9570093abde46430c3172e3d@git.kernel.org>
References: <1487829879-56237-1-git-send-email-tanxiaojun@huawei.com>
 <tip-1572e45a924f254d9570093abde46430c3172e3d@git.kernel.org>
Message-ID: <58B13BFD.2050304@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Peter:

First, thank you for your approval of my last patch and fix my bad description. And I have some questions about perf event and perf_fuzzer.

Recently I was using perf_fuzzer for testing in Hisilicon D03/D05(arm64, linux-4.10-rc1).

As we know perf_fuzzer will write a random value to procfs interface of perf event(like sysctl_perf_cpu_time_max_percent). The value may be 0 or 100, and I get logs like below:

----------------------------------
[ 4046.358811] perf: Dynamic interrupt throttling disabled, can hang your system!
----------------------------------

Most of the time, there is no problem, and the perf_fuzzer test can end without any warings or errors.
But there is a small probability that triggers the RCU and watchdog (The log is attached at the end). It hungs after local_irq_enable() in __do_softirq.

I think this is due to the dynamic interrupt throttling disabled and too many hardware interruptions come. So I limit the sysctl_perf_cpu_time_max_percent can only be set 1 to 99 in the kernel codes. I test more than 20 times in D03, and there are no errors or warnings in the test.

So I want to ask:

1)Is it a problem or not? (It has already given you a warning.)

2)If it is, where we will fix it more appropriate, perf_fuzzer(not set 0 or 100) or kernel(limit 1 to 99), or maybe it is the bug of hardware(too many hardware interruptions)?


Thanks.
Xiaojun.

------------------------------------
[ 3831.245881] perf: Dynamic interrupt throttling disabled, can hang your system!
[ 3844.421731] perf: Dynamic interrupt throttling disabled, can hang your system!
[ 4032.764228] hrtimer: interrupt took 2280 ns
[ 4035.494181] perf: interrupt took too long (1444 > 1), lowering kernel.perf_event_max_sample_rate to 16500
[ 4040.292886] perf: interrupt took too long (5 > 1), lowering kernel.perf_event_max_sample_rate to 5000000
[ 4041.388784] perf: Dynamic interrupt throttling disabled, can hang your system!
[ 4046.358811] perf: Dynamic interrupt throttling disabled, can hang your system!

10-175-112-211:~ #
10-175-112-211:~ #
10-175-112-211:~ # [ 4270.928905] perf: Dynamic interrupt throttling disabled, can hang your system!
[ 4270.945154] perf: Dynamic interrupt throttling disabled, can hang your system!
[ 4271.906280] perf: Dynamic interrupt throttling disabled, can hang your system!
[ 4294.491755] INFO: rcu_preempt self-detected stall on CPU
[ 4294.495755] INFO: rcu_preempt detected stalls on CPUs/tasks:
[ 4294.495761]  14-...: (6 GPs behind) idle=d65/140000000000002/0 softirq=6173/6173 fqs=2566
[ 4294.495761]  (detected by 7, t=5252 jiffies, g=58964, c=58963, q=186)
[ 4294.495766] Task dump for CPU 14:
[ 4294.495768] perf_fuzzer     R  running task        0 31306   5036 0x00000202
[ 4294.495771] Call trace:
[ 4294.495778] [<ffff000008085634>] __switch_to+0x8c/0xac
[ 4294.495783] [<ffff00000815ef38>] event_function_call+0x88/0xf0
[ 4294.495785] [<ffff00000815f058>] _perf_event_enable+0x54/0x80
[ 4294.495788] [<ffff00000815ea2c>] perf_event_for_each_child+0x38/0x98
[ 4294.495791] [<ffff000008166a48>] perf_event_task_enable+0x58/0xa0
[ 4294.495794] [<ffff0000080d11e0>] SyS_prctl+0x2a0/0x3fc
[ 4294.495796] [<ffff000008082f8c>] __sys_trace_return+0x0/0x4
[ 4294.569983]  14-...: (6 GPs behind) idle=d65/140000000000002/0 softirq=6173/6173 fqs=2576
[ 4294.578228]   (t=5272 jiffies g=58964 c=58963 q=186)
[ 4294.583187] Task dump for CPU 14:
[ 4294.586505] perf_fuzzer     R  running task        0 31306   5036 0x00000202
[ 4294.593541] Call trace:
[ 4294.595995] [<ffff0000080883d4>] dump_backtrace+0x0/0x240
[ 4294.601388] [<ffff000008088628>] show_stack+0x14/0x1c
[ 4294.606435] [<ffff0000080e5f84>] sched_show_task+0x130/0x174
[ 4294.612087] [<ffff0000080e8948>] dump_cpu_task+0x40/0x4c
[ 4294.617391] [<ffff00000816f944>] rcu_dump_cpu_stacks+0xa4/0xec
[ 4294.623215] [<ffff00000811a160>] rcu_check_callbacks+0x9d8/0xc70
[ 4294.629212] [<ffff00000811e0e8>] update_process_times+0x2c/0x58
[ 4294.635124] [<ffff00000812d1cc>] tick_sched_handle.isra.17+0x20/0x60
[ 4294.641465] [<ffff00000812d250>] tick_sched_timer+0x44/0x88
[ 4294.647027] [<ffff00000811e980>] __hrtimer_run_queues+0xe8/0x14c
[ 4294.653024] [<ffff00000811ef04>] hrtimer_interrupt+0x9c/0x1e0
[ 4294.658766] [<ffff000008793a94>] arch_timer_handler_virt+0x2c/0x38
[ 4294.664938] [<ffff00000810f554>] handle_percpu_devid_irq+0x78/0x12c
[ 4294.671195] [<ffff00000810a5ec>] generic_handle_irq+0x24/0x38
[ 4294.676932] [<ffff00000810ac84>] __handle_domain_irq+0x60/0xac
[ 4294.682756] [<ffff0000080816e4>] gic_handle_irq+0x74/0x174
[ 4294.688234] Exception stack(0xffff803ffffb2df0 to 0xffff803ffffb2f20)
[ 4294.694664] 2de0:                                   ffff803ffffb2e20 0001000000000000
[ 4294.702480] 2e00: ffff803ffffb2f50 ffff0000080c29b0 0000000040000145 000000000000001b
[ 4294.710291] 2e20: 0000000000000700 ffff000008ed3300 ffff000008ed3300 0000803ff7214000
[ 4294.718106] 2e40: 000000000ccccccd 0000000000000020 001df84284000000 0000000001572fe1
[ 4294.725917] 2e60: 0000000000000000 0000000000000002 0000000000000002 0000ffffda3b0880
[ 4294.733729] 2e80: 0000000000000018 00000003e8000000 ffff000008ba6000 0000803ff7214000
[ 4294.741544] 2ea0: ffff0000080d0f40 000000000000e654 0000ffffda3b0690 ffff000008d9b000
[ 4294.749357] 2ec0: 0000000000000000 ffff000008d9fb08 ffff000008d9b000 ffff000008bc5728
[ 4294.757172] 2ee0: 000000000000001b ffff000008ba1000 ffff803ffffb3090 0000000000000282
[ 4294.764983] 2f00: ffff803f6e7bb200 ffff803ffffb2f50 ffff0000080c2e40 ffff803ffffb2f50
[ 4294.772798] [<ffff0000080827f4>] el1_irq+0xb4/0x128
[ 4294.777673] [<ffff0000080c2e40>] irq_exit+0xd0/0x118
[ 4294.782632] [<ffff00000810ac88>] __handle_domain_irq+0x64/0xac
[ 4294.788456] [<ffff0000080816e4>] gic_handle_irq+0x74/0x174
[ 4294.793934] Exception stack(0xffff803f5c07fbb0 to 0xffff803f5c07fce0)
[ 4294.800362] fba0:                                   0000000000000000 ffff803f6e7bb200
[ 4294.808177] fbc0: 0000000000008d5b 00000000000001c0 0000000000000000 0000000000000006
[ 4294.815992] fbe0: 0000000000000015 00000000dc7d24d2 00000000000000a7 00000000ffffff80
[ 4294.823803] fc00: 00000000ffffffd0 0000ffffda3b0880 0000000000000018 00000003e8000000
[ 4294.831618] fc20: 00028d3784000000 000069ade8000000 ffff0000080d0f40 0000ffff7b2584c0
[ 4294.839432] fc40: 0000ffffda3b0690 0000000000000140 0000000000000000 ffff803f6deaf108
[ 4294.847247] fc60: ffff00000815e680 ffff803f6dfa7000 ffff000008165b34 0000000000000000
[ 4294.855062] fc80: 00000000000000a7 ffff000008902000 ffff803f6e7bb200 ffff803f5c07fce0
[ 4294.862877] fca0: ffff0000081318f0 ffff803f5c07fce0 ffff0000081318f4 0000000020000145
[ 4294.870691] fcc0: ffff803f5c07fce0 ffff0000081318f0 0001000000000000 00000000000000a7
[ 4294.878506] [<ffff0000080827f4>] el1_irq+0xb4/0x128
[ 4294.883377] [<ffff0000081318f4>] generic_exec_single+0xe4/0x120
[ 4294.889289] [<ffff000008131a3c>] smp_call_function_single+0x10c/0x164
[ 4294.895719] [<ffff00000815ee94>] task_function_call+0x40/0x5c
[ 4294.901456] [<ffff00000815ef38>] event_function_call+0x88/0xf0
[ 4294.907282] [<ffff00000815f058>] _perf_event_enable+0x54/0x80
[ 4294.913018] [<ffff00000815ea2c>] perf_event_for_each_child+0x38/0x98
[ 4294.919359] [<ffff000008166a48>] perf_event_task_enable+0x58/0xa0
[ 4294.925443] [<ffff0000080d11e0>] SyS_prctl+0x2a0/0x3fc
[ 4294.930573] [<ffff000008082f8c>] __sys_trace_return+0x0/0x4

10-175-112-211:~ #
10-175-112-211:~ # [ 4321.341680] NMI watchdog: BUG: soft lockup - CPU#14 stuck for 22s! [perf_fuzzer:31306]
[ 4321.349583] Modules linked in:
[ 4321.352641]
[ 4321.354146] CPU: 14 PID: 31306 Comm: perf_fuzzer Not tainted 4.10.0-rc1-ga1d2732-dirty #7
[ 4321.362306] Hardware name: Huawei Taishan 2180 /BC11SPCC, BIOS 1.31 06/23/2016
[ 4321.369515] task: ffff803f6e7bb200 task.stack: ffff803f5c07c000
[ 4321.375428] PC is at __do_softirq+0xc0/0x240
[ 4321.379698] LR is at irq_exit+0xd0/0x118
[ 4321.383618] pc : [<ffff0000080c29b0>] lr : [<ffff0000080c2e40>] pstate: 40000145
[ 4321.390999] sp : ffff803ffffb2f50
[ 4321.394314] x29: ffff803ffffb2f50 x28: ffff803f6e7bb200
[ 4321.399619] x27: 0000000000000282 x26: ffff803ffffb3090
[ 4321.404922] x25: ffff000008ba1000 x24: 000000000000001b
[ 4321.410229] x23: ffff000008bc5728 x22: ffff000008d9b000
[ 4321.415532] x21: ffff000008d9fb08 x20: 0000000000000000
[ 4321.420836] x19: ffff000008d9b000 x18: 0000ffffda3b0690
[ 4321.426139] x17: 000000000000e654 x16: ffff0000080d0f40
[ 4321.431444] x15: 0000803ff7214000 x14: ffff000008ba6000
[ 4321.436747] x13: 00000003e8000000 x12: 0000000000000018
[ 4321.442053] x11: 0000ffffda3b0880 x10: 0000000000000002
[ 4321.447356] x9 : 0000000000000002 x8 : 0000000000000000
[ 4321.452659] x7 : 0000000001572fe1 x6 : 001df84284000000
[ 4321.457965] x5 : 0000000000000020 x4 : 000000000ccccccd
[ 4321.463270] x3 : 0000803ff7214000 x2 : ffff000008ed3300
[ 4321.468577] x1 : ffff000008ed3300 x0 : 0000000000000700
[ 4321.473882]

Message from syslogd at localhost at Feb 25 11:07:22 ...
 kernel:[ 4321.341680] NMI watchdog: BUG: soft lockup - CPU#14 stuck for 22s! [perf_fuzzer:31306]

10-175-112-211:~ #
10-175-112-211:~ # [ 4349.341680] NMI watchdog: BUG: soft lockup - CPU#14 stuck for 22s! [perf_fuzzer:31306]
[ 4349.349580] Modules linked in:
[ 4349.352637]
[ 4349.354138] CPU: 14 PID: 31306 Comm: perf_fuzzer Tainted: G             L  4.10.0-rc1-ga1d2732-dirty #7
[ 4349.363506] Hardware name: Huawei Taishan 2180 /BC11SPCC, BIOS 1.31 06/23/2016
[ 4349.370714] task: ffff803f6e7bb200 task.stack: ffff803f5c07c000
[ 4349.376624] PC is at __do_softirq+0xc0/0x240
[ 4349.380893] LR is at irq_exit+0xd0/0x118
[ 4349.384815] pc : [<ffff0000080c29b0>] lr : [<ffff0000080c2e40>] pstate: 40000145
[ 4349.392195] sp : ffff803ffffb2f50
[ 4349.395513] x29: ffff803ffffb2f50 x28: ffff803f6e7bb200
[ 4349.400817] x27: 0000000000000282 x26: ffff803ffffb3090
[ 4349.406121] x25: ffff000008ba1000 x24: 000000000000001b
[ 4349.411424] x23: ffff000008bc5728 x22: ffff000008d9b000
[ 4349.416727] x21: ffff000008d9fb08 x20: 0000000000000000
[ 4349.422032] x19: ffff000008d9b000 x18: 0000ffffda3b0690
[ 4349.427337] x17: 000000000000e654 x16: ffff0000080d0f40
[ 4349.432640] x15: 0000803ff7214000 x14: ffff000008ba6000
[ 4349.437944] x13: 00000003e8000000 x12: 0000000000000018
[ 4349.443248] x11: 0000ffffda3b0880 x10: 0000000000000002
[ 4349.448552] x9 : 0000000000000002 x8 : 0000000000000000
[ 4349.453856] x7 : 0000000001572fe1 x6 : 001df84284000000
[ 4349.459162] x5 : 0000000000000020 x4 : 000000000ccccccd
[ 4349.464465] x3 : 0000803ff7214000 x2 : ffff000008ed3300
[ 4349.469769] x1 : ffff000008ed3300 x0 : 0000000000000700
[ 4349.475072]
------------------------------------
part of objdump code:

ffff0000080c29a8:       b820683f        str     wzr, [x1,x0]
        return flags;
}

static inline void arch_local_irq_enable(void)
{
        asm volatile(
ffff0000080c29ac:       d50342ff        msr     daifclr, #0x2

        local_irq_enable();

        h = softirq_vec;
ffff0000080c29b0:       90006920        adrp    x0, ffff000008de6000 <boot_args>

        while ((softirq_bit = ffs(pending))) {
                unsigned int vec_nr;
                int prev_count;

                h += softirq_bit - 1;
ffff0000080c29b4:       928000f4        mov     x20, #0xfffffffffffffff8        // #-8
        /* Reset the pending bitmask before enabling irqs */
        set_softirq_pending(0);

        local_irq_enable();

        h = softirq_vec;
ffff0000080c29b8:       9106001c        add     x28, x0, #0x180
                unsigned int vec_nr;
                int prev_count;

                h += softirq_bit - 1;


-----------------------------------------



On 2017/2/24 17:15, tip-bot for Tan Xiaojun wrote:
> Commit-ID:  1572e45a924f254d9570093abde46430c3172e3d
> Gitweb:     http://git.kernel.org/tip/1572e45a924f254d9570093abde46430c3172e3d
> Author:     Tan Xiaojun <tanxiaojun@huawei.com>
> AuthorDate: Thu, 23 Feb 2017 14:04:39 +0800
> Committer:  Ingo Molnar <mingo@kernel.org>
> CommitDate: Fri, 24 Feb 2017 08:56:33 +0100
> 
> perf/core: Fix the perf_cpu_time_max_percent check
> 
> Use "proc_dointvec_minmax" instead of "proc_dointvec" to check the input
> value from user-space.
> 
> If not, we can set a big value and some vars will overflow like
> "sysctl_perf_event_sample_rate" which will cause a lot of unexpected
> problems.
> 
> Signed-off-by: Tan Xiaojun <tanxiaojun@huawei.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: <acme@kernel.org>
> Cc: <alexander.shishkin@linux.intel.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Stephane Eranian <eranian@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Vince Weaver <vincent.weaver@maine.edu>
> Link: http://lkml.kernel.org/r/1487829879-56237-1-git-send-email-tanxiaojun at huawei.com
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>  kernel/events/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index d4e3f8d..c1c1cdf 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -455,7 +455,7 @@ int perf_cpu_time_max_percent_handler(struct ctl_table *table, int write,
>  				void __user *buffer, size_t *lenp,
>  				loff_t *ppos)
>  {
> -	int ret = proc_dointvec(table, write, buffer, lenp, ppos);
> +	int ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
>  
>  	if (ret || !write)
>  		return ret;
> 
> .
> 
