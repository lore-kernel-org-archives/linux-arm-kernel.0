From: will.deacon@arm.com (Will Deacon)
Date: Wed, 2 Aug 2017 09:08:28 +0100
Subject: rcu_sched stall while waiting in csd_lock_wait()
In-Reply-To: <da7c56d6-066a-d123-f0cf-d9a3b97b001e@redhat.com>
References: <da7c56d6-066a-d123-f0cf-d9a3b97b001e@redhat.com>
Message-ID: <20170802080827.GA15219@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pratyush,

On Wed, Aug 02, 2017 at 09:01:19AM +0530, Pratyush Anand wrote:
> I am observing following rcu_sched stall while executing `perf record -a  --
> sleep 1` with one of the arm64 platform. It looks like that stalled cpu was
> waiting in csd_lock_wait() from where it never came out,and so the stall.
> Any help/pointer for further debugging would be very helpful. Problem also
> reproduced with 4.13.0-rc3.

When you say "also", which other kernel(s) show the problem? Is this a
recent regression? Which platform are you running on?

It would be interesting to know what the other CPUs are doing, in particular
the target of the cross-call. Either it crashed spectacularly and didn't
unlock the csd lock, or the IPI somehow wasn't delivered.

Do you see any other splats if you enable lock debugging?

Cheers,

Will

> [11108.758804] task: ffff801782490000 task.stack: ffff801782574000
> [11108.764710] PC is at smp_call_function_single+0x128/0x178
> [11108.770089] LR is at smp_call_function_single+0x11c/0x178
> [11108.775470] pc : [<ffff0000081615ac>] lr : [<ffff0000081615a0>] pstate:
> 20400145
> [11108.782848] sp : ffff801782577b80
> [11108.786147] x29: ffff801782577b80 x28: ffff8017815c3800
> [11108.791442] x27: ffff0000087f1000 x26: 000000000000001d
> [11108.796737] x25: 0000000000000000 x24: ffff0000081ddc90
> [11108.802032] x23: ffff000008c73000 x22: 0000000000000006
> [11108.807327] x21: ffff0000081da548 x20: ffff801782577c18
> [11108.812623] x19: ffff000008c73000 x18: 0000fffffa011c30
> [11108.817918] x17: 0000000000000000 x16: 0000000000000000
> [11108.823213] x15: 00000000006ed000 x14: 0000000000620170
> [11108.828508] x13: ffffffffffffffff x12: 0000000000000005
> [11108.833803] x11: 0000000000000000 x10: 00000000ffffffff
> [11108.839098] x9 : 0000fffffa011e40 x8 : 000000000000001d
> [11108.844393] x7 : 0000000000000000 x6 : ffff801782577bc8
> [11108.849689] x5 : 0000000000000040 x4 : ffff801782577be0
> [11108.854984] x3 : ffff801782577be0 x2 : 0000000000000000
> [11108.860279] x1 : 0000000000000003 x0 : 0000000000000000
> [11108.865574]
> [11141.885599] INFO: rcu_sched self-detected stall on CPU
> [11141.889777] 	7-...: (5982 ticks this GP) idle=2fb/140000000000001/0
> softirq=604/604 fqs=2995
> [11141.898281] 	 (t=6000 jiffies g=11855 c=11854 q=19196)
> [11141.903404] Task dump for CPU 7:
> [11141.906615] perf            R  running task        0  2357   2329 0x00000202
> [11141.913647] Call trace:
> [11141.916081] [<ffff000008088770>] dump_backtrace+0x0/0x270
> [11141.921460] [<ffff000008088a04>] show_stack+0x24/0x2c
> [11141.926496] [<ffff0000080fcd50>] sched_show_task+0xec/0x130
> [11141.932050] [<ffff0000080fe7e8>] dump_cpu_task+0x48/0x54
> [11141.937347] [<ffff0000081ee314>] rcu_dump_cpu_stacks+0xac/0xf4
> [11141.943163] [<ffff000008144b94>] rcu_check_callbacks+0x7a0/0xa84
> [11141.949152] [<ffff00000814ae98>] update_process_times+0x34/0x5c
> [11141.955055] [<ffff00000815c7ec>] tick_sched_handle.isra.15+0x38/0x70
> [11141.961390] [<ffff00000815c86c>] tick_sched_timer+0x48/0x88
> [11141.966946] [<ffff00000814b84c>] __hrtimer_run_queues+0x150/0x2e4
> [11141.973022] [<ffff00000814c264>] hrtimer_interrupt+0xa0/0x1d4
> [11141.978754] [<ffff000008650898>] arch_timer_handler_phys+0x3c/0x48
> [11141.984916] [<ffff000008137c40>] handle_percpu_devid_irq+0x98/0x210
> [11141.991164] [<ffff0000081321a4>] generic_handle_irq+0x34/0x4c
> [11141.996893] [<ffff000008132868>] __handle_domain_irq+0x6c/0xc4
> [11142.002710] [<ffff000008081608>] gic_handle_irq+0x94/0x190
> [11142.008178] Exception stack(0xffff801782577a50 to 0xffff801782577b80)
> [11142.014602] 7a40:                                   0000000000000000
> 0000000000000003
> [11142.022414] 7a60: 0000000000000000 ffff801782577be0 ffff801782577be0
> 0000000000000040
> [11142.030226] 7a80: ffff801782577bc8 0000000000000000 000000000000001d
> 0000fffffa011e40
> [11142.038039] 7aa0: 00000000ffffffff 0000000000000000 0000000000000005
> ffffffffffffffff
> [11142.045851] 7ac0: 0000000000620170 00000000006ed000 0000000000000000
> 0000000000000000
> [11142.053664] 7ae0: 0000fffffa011c30 ffff000008c73000 ffff801782577c18
> ffff0000081da548
> [11142.061477] 7b00: 0000000000000006 ffff000008c73000 ffff0000081ddc90
> 0000000000000000
> [11142.069289] 7b20: 000000000000001d ffff0000087f1000 ffff8017815c3800
> ffff801782577b80
> [11142.077101] 7b40: ffff0000081615a0 ffff801782577b80 ffff0000081615ac
> 0000000020400145
> [11142.084914] 7b60: 0000001b00000019 ffff801782577c18 0001000000000000
> ffff801782577bc8
> [11142.092727] [<ffff000008082eb4>] el1_irq+0xb4/0x140
> [11142.097588] [<ffff0000081615ac>] smp_call_function_single+0x128/0x178
> [11142.104014] [<ffff0000081d8124>] cpu_function_call+0x40/0x64
> [11142.109654] [<ffff0000081d837c>] event_function_call+0x100/0x108
> [11142.115643] [<ffff0000081d83d0>] _perf_event_disable+0x4c/0x74
> [11142.121459] [<ffff0000081d7f78>] perf_event_for_each_child+0x38/0x98
> [11142.127796] [<ffff0000081e110c>] perf_ioctl+0xec/0x7b4
> [11142.132920] [<ffff00000829e564>] do_vfs_ioctl+0xcc/0x7bc
> [11142.138213] [<ffff00000829ece4>] SyS_ioctl+0x90/0xa4
> [11142.143161] [<ffff0000080834a0>] __sys_trace_return+0x0/0x4
> [11142.148717] INFO: rcu_sched detected stalls on CPUs/tasks:
> [11142.154187] 	7-...: (5983 ticks this GP) idle=2fb/140000000000000/0
> softirq=604/604 fqs=2995
> [11142.162692] 	(detected by 8, t=6027 jiffies, g=11855, c=11854, q=19211)
> [11142.169289] Task dump for CPU 7:
> [11142.172500] perf            R  running task        0  2357   2329 0x00000202
> [11142.179531] Call trace:
> [11142.181964] [<ffff0000080857c8>] __switch_to+0x64/0x70
> [11142.187088] [<ffff000008c20000>] cpu_number+0x0/0x8
> 
> 
> -- 
> Regards
> Pratyush
