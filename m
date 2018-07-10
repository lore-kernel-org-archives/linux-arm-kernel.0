From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 10 Jul 2018 16:01:35 +0100
Subject: [PATCH v5 0/7] arm64: perf: Support for chained counters
In-Reply-To: <20180710143105.GC9022@arm.com>
References: <1531213084-27417-1-git-send-email-suzuki.poulose@arm.com>
 <20180710143105.GC9022@arm.com>
Message-ID: <50b0107c-b01d-956a-bd85-d588bf9869ee@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/10/2018 03:31 PM, Will Deacon wrote:
> Hi Suzuki,
> 
> On Tue, Jul 10, 2018 at 09:57:57AM +0100, Suzuki K Poulose wrote:
>> This series adds support for counting PMU events using 64bit counters
>> for arm64 PMU.
>>
>> The Arm v8 PMUv3 supports combining two adjacent 32bit counters
>> (low even and hig odd counters) to count a given "event" in 64bit mode.
>> This series adds the support for 64bit events in the core arm_pmu driver
>> infrastructure and adds the support for armv8 64bit kernel PMU to use
>> chained counters to count in 64bit mode. For CPU cycles, we use the cycle
>> counter in 64bit mode, only when requested. If the cycle counter is not
>> available, we fall back to chaining the counters.
>>
>> Tested on Juno, Fast models. Applies on 4.18-rc4
> 
> Thanks, this looks pretty good to me. How far did you get with the perf
> fuzzer?

Hi Will,

I ran perf_fuzzer on Juno and the fuzzer hung with RCU stalls.
However, this was reproducible without the series. I am yet to
investigate the RCU stall.

Log below (from 4.18-rc3, without the series).

[445885.968489] perf_fuzzer     R  running task        0 11468   4397 
0x00000003
[445885.975568] Call trace:
[445885.978084]  ret_from_fork+0x0/0x1c
[445963.841606] INFO: rcu_preempt self-detected stall on CPU
[445963.845814] INFO: rcu_preempt detected stalls on CPUs/tasks:
[445963.846957] 	2-....: (1 GPs behind) idle=376/1/4611686018427387908 
softirq=57145/57145 fqs=54519307
[445963.852649] 	
[445963.861784] 	2-....: (1 GPs behind) idle=376/1/4611686018427387908 
softirq=57145/57145 fqs=54519307
[445963.861787]  (t=109254007 jiffies g=61092 c=61091 q=1517144)
[445963.878244] 	
[445963.878245] Task dump for CPU 2:
[445963.878250] perf_fuzzer     R
[445963.879897] (detected by 0, t=109254007 jiffies, g=61092, c=61091, 
q=1517144)
[445963.883167]   running task        0 11468   4397 0x00000003
[445963.898932] Call trace:
[445963.901439]  dump_backtrace+0x0/0x1e0
[445963.905149]  show_stack+0x24/0x30
[445963.908516]  sched_show_task+0x220/0x2c0
[445963.912484]  dump_cpu_task+0x48/0x58
[445963.916109]  rcu_dump_cpu_stacks+0xa0/0xe0
[445963.920250]  rcu_check_callbacks+0xa40/0xc20
[445963.924564]  update_process_times+0x34/0x60
[445963.928791]  tick_sched_handle.isra.5+0x44/0x68
[445963.933361]  tick_sched_timer+0x50/0xa0
[445963.937244]  __hrtimer_run_queues+0x19c/0x6d0
[445963.941644]  hrtimer_interrupt+0xec/0x248
[445963.945699]  arch_timer_handler_phys+0x3c/0x50
[445963.950184]  handle_percpu_devid_irq+0xcc/0x4a0
[445963.954754]  generic_handle_irq+0x34/0x50
[445963.958808]  __handle_domain_irq+0x68/0xc0
[445963.962948]  gic_handle_irq+0x60/0xb8
[445963.966657]  el1_irq+0xb4/0x130
[445963.969851]  __do_softirq+0xcc/0x5c4
[445963.973475]  irq_exit+0x12c/0x138
[445963.976841]  __handle_domain_irq+0x6c/0xc0
[445963.980981]  gic_handle_irq+0x60/0xb8
[445963.984691]  el0_irq_naked+0x50/0x5c
[445963.988316] Task dump for CPU 2:
[445963.991601] perf_fuzzer     R  running task        0 11468   4397 
0x00000003
[445963.998679] Call trace:
[445964.001194]  ret_from_fork+0x0/0x1c
root at localhost:~# uname -a
Linux localhost.localdomain 4.18.0-rc3 #117 SMP PREEMPT Thu Jul 5 
11:47:12 BST 2018 aarch64 aarch64 aarch64 GNU/Linux

Suzuki
