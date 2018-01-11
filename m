From: romain.izard.pro@gmail.com (Romain Izard)
Date: Thu, 11 Jan 2018 15:36:34 +0100
Subject: "perf record" leads to a watchdog reset on a SAMA5D2 SoC
Message-ID: <CAGkQfmNUxJXxqkMhLS1p7HT+tqkPYsqQxZpSv7UEQrn=oMC5_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

While trying to use perf on a device based on a SAMA5D2 SoC, I encountered a
systematic watchdog reboot. Simply calling "perf record /bin/true" is enough
to trigger this condition.

I have reproduced the issue on a SAMA5D2 Xplained demo board, with a 4.14.11
kernel, leading to "rcu_preempt self-detected stall on CPU" kernel messages
once the watchdog was disabled. But this was depending on the kernel
configuration - the sama5_defconfig configuration would not show the issue,
but adding the following options to this defconfig was be enough:

+CONFIG_PERF_EVENTS=y
+CONFIG_PREEMPT=y
+CONFIG_FUNCTION_TRACER=y
+# CONFIG_DYNAMIC_FTRACE is not set


There are complex interactions between the options, and in the case of the
original device DYNAMIC_FTRACE was set. But when trying to reduce the number
of changed flags between the default and a configuration reproducing the
issue, I ended up in a situation where enabling or disabling DYNAMIC_FTRACE
is the difference that triggered the problem.

Here is an example of the error (repeated every 30s) in the kernel log:

8<----------------------------------------------------------------------

INFO: rcu_preempt self-detected stall on CPU
        0-...: (1413 ticks this GP) idle=7fe/140000000000002/0
softirq=1011/1011 fqs=0
         (t=2100 jiffies g=86 c=85 q=63)
rcu_preempt kthread starved for 2100 jiffies! g86 c85 f0x0
RCU_GP_WAIT_FQS(3) ->state=0x402 ->cpu=0
rcu_preempt     I    0     8      2 0x00000000
[<c0824d60>] (__schedule) from [<c082519c>] (schedule+0x58/0xb8)
[<c082519c>] (schedule) from [<c0828bb8>] (schedule_timeout+0x1d8/0x3fc)
[<c0828bb8>] (schedule_timeout) from [<c0169d60>] (rcu_gp_kthread+0x628/0xab4)
[<c0169d60>] (rcu_gp_kthread) from [<c013d7c4>] (kthread+0x134/0x164)
[<c013d7c4>] (kthread) from [<c0108308>] (ret_from_fork+0x14/0x2c)
Task dump for CPU 0:
perf            R  running task        0   842    836 0x00000002
[<c010f6e4>] (unwind_backtrace) from [<c010c9c8>] (show_stack+0x20/0x24)
[<c010c9c8>] (show_stack) from [<c0145314>] (sched_show_task.part.22+0xc4/0xe0)
[<c0145314>] (sched_show_task.part.22) from [<c0148c4c>]
(dump_cpu_task+0x40/0x44)
[<c0148c4c>] (dump_cpu_task) from [<c016bfac>] (rcu_dump_cpu_stacks+0x8c/0xcc)
[<c016bfac>] (rcu_dump_cpu_stacks) from [<c016ad30>]
(rcu_check_callbacks+0x628/0xa5c)
[<c016ad30>] (rcu_check_callbacks) from [<c0170e0c>]
(update_process_times+0x40/0x6c)
[<c0170e0c>] (update_process_times) from [<c0181888>]
(tick_sched_handle+0x64/0x68)
[<c0181888>] (tick_sched_handle) from [<c0181adc>] (tick_sched_timer+0x58/0xb4)
[<c0181adc>] (tick_sched_timer) from [<c0171ca0>]
(__hrtimer_run_queues.constprop.5+0x174/0x330)
[<c0171ca0>] (__hrtimer_run_queues.constprop.5) from [<c0172154>]
(hrtimer_interrupt+0xa4/0x260)
[<c0172154>] (hrtimer_interrupt) from [<c05efd30>] (ch2_irq+0x38/0x40)
[<c05efd30>] (ch2_irq) from [<c015ab4c>] (__handle_irq_event_percpu+0x6c/0x258)
[<c015ab4c>] (__handle_irq_event_percpu) from [<c015ad64>]
(handle_irq_event_percpu+0x2c/0x68)
[<c015ad64>] (handle_irq_event_percpu) from [<c015adfc>]
(handle_irq_event+0x5c/0x94)
[<c015adfc>] (handle_irq_event) from [<c015e418>]
(handle_fasteoi_irq+0xbc/0x198)
[<c015e418>] (handle_fasteoi_irq) from [<c0159c7c>]
(generic_handle_irq+0x34/0x44)
[<c0159c7c>] (generic_handle_irq) from [<c015a390>]
(__handle_domain_irq+0x80/0xec)
[<c015a390>] (__handle_domain_irq) from [<c010157c>] (aic5_handle+0xd0/0xf8)
[<c010157c>] (aic5_handle) from [<c010d70c>] (__irq_svc+0x6c/0xa8)
Exception stack(0xde63fd18 to 0xde63fd60)
fd00:                                                       00000000 c0a077dc
fd20: c0d86200 00000000 c0d86200 00000000 00000000 00000202 de63fe20 df007600
fd40: c0d7c3cc de63fdbc de63fd58 de63fd68 c03d3cb4 c0101648 200b0113 ffffffff
[<c010d70c>] (__irq_svc) from [<c0101648>] (__do_softirq+0xa0/0x350)
[<c0101648>] (__do_softirq) from [<c0122a4c>] (irq_exit+0xfc/0x138)
[<c0122a4c>] (irq_exit) from [<c015a394>] (__handle_domain_irq+0x84/0xec)
[<c015a394>] (__handle_domain_irq) from [<c010157c>] (aic5_handle+0xd0/0xf8)
[<c010157c>] (aic5_handle) from [<c010d70c>] (__irq_svc+0x6c/0xa8)
Exception stack(0xde63fe20 to 0xde63fe68)
fe20: 00000000 c01c265c 00000000 00000000 600b0013 c01c612c de57f600 de63e000
fe40: df284c00 00000000 00000000 de63fe8c de63fe08 de63fe70 c0145178 c0187214
fe60: 600b0013 ffffffff
[<c010d70c>] (__irq_svc) from [<c0187214>] (smp_call_function_single+0x38/0x60)
[<c0187214>] (smp_call_function_single) from [<c01c2fd4>]
(task_function_call+0x3c/0x54)
[<c01c2fd4>] (task_function_call) from [<c01c5754>]
(perf_install_in_context+0x5c/0x19c)
[<c01c5754>] (perf_install_in_context) from [<c01cf9f0>]
(SyS_perf_event_open+0xb88/0xdcc)
[<c01cf9f0>] (SyS_perf_event_open) from [<c0108220>] (ret_fast_syscall+0x0/0x54)

8<----------------------------------------------------------------------


I'm not sure of how to interpret the issue. Is it because the CPU is too
busy servicing the trace code during ticks to do anything else?


Best regards,
-- 
Romain Izard
