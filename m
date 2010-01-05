From: jpihet@mvista.com (Jean Pihet)
Date: Tue, 5 Jan 2010 19:23:40 +0100
Subject: [PATCH 5/5] arm/perfevents: implement perf event support for ARMv6
In-Reply-To: <000401ca8e31$fac86820$f0593860$@deacon@arm.com>
References: <1262602122-10373-1-git-send-email-jamie.iles@picochip.com>
	<1262602122-10373-6-git-send-email-jamie.iles@picochip.com>
	<000401ca8e31$fac86820$f0593860$@deacon@arm.com>
Message-ID: <201001051923.40756.jpihet@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will, Jamie,

On Tuesday 05 January 2010 19:07:44 Will Deacon wrote:
> Hi Jamie,
>
> I've been trying to test your patches with a quad-core ARM 11MPCore on a
> Realview PB11MP board.
>
> Unfortunately, I occasionally experience a complete system hang during some
> profiling runs. I don't think it's your fault however, as it can occur even
> when monitoring only software events. I've managed to reproduce this on the
> tip/master branch and got the following information [I enabled lock
> debugging]:

This is the exact same problem as I have when stressing the system a little 
bit.

Jean
>
> =================================
> [ INFO: inconsistent lock state ]
> 2.6.33-rc2-tip+ #5
> ---------------------------------
> inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
> perf/1463 [HC0[0]:SC0[0]:HE1:SE1] takes:
>  (&ctx->lock){?.....}, at: [<c009e538>] __perf_event_sched_in+0x20/0x168
> {IN-HARDIRQ-W} state was registered at:
>   [<c00718b0>] __lock_acquire+0x5c8/0x17b4
>   [<c0072b70>] lock_acquire+0xd4/0xec
>   [<c0315700>] _raw_spin_lock+0x2c/0x3c
>   [<c00a20f8>] perf_ctx_adjust_freq+0xc/0x1dc
>   [<c00a230c>] perf_event_task_tick+0x44/0xb4
>   [<c0041f4c>] scheduler_tick+0xec/0x144
>   [<c0053eb8>] update_process_times+0x40/0x4c
>   [<c006d91c>] tick_periodic+0xdc/0x108
>   [<c006d96c>] tick_handle_periodic+0x24/0xf0
>   [<c0030124>] ipi_timer+0x34/0x44
>   [<c002a3cc>] do_local_timer+0x50/0x80
>   [<c002aca4>] __irq_svc+0x44/0xe0
>   [<c002c388>] default_idle+0x28/0x2c
>   [<c002c8ac>] cpu_idle+0x8c/0xe4
>   [<70008080>] 0x70008080
> irq event stamp: 454
> hardirqs last  enabled at (454): [<c0315d30>]
> _raw_spin_unlock_irq+0x24/0x2c hardirqs last disabled at (453):
> [<c0315784>] _raw_spin_lock_irq+0x18/0x50 softirqs last  enabled at (0):
> [<c0045650>] copy_process+0x328/0xf70 softirqs last disabled at (0):
> [<(null)>] (null)
>
> other info that might help us debug this:
> no locks held by perf/1463.
>
> stack backtrace:
> [<c0031694>] (unwind_backtrace+0x0/0xd4) from [<c006ff88>]
> (print_usage_bug+0x16c/0x1ac) [<c006ff88>] (print_usage_bug+0x16c/0x1ac)
> from [<c00702f0>] (mark_lock+0x328/0x5f0) [<c00702f0>]
> (mark_lock+0x328/0x5f0) from [<c007193c>] (__lock_acquire+0x654/0x17b4)
> [<c007193c>] (__lock_acquire+0x654/0x17b4) from [<c0072b70>]
> (lock_acquire+0xd4/0xec) [<c0072b70>] (lock_acquire+0xd4/0xec) from
> [<c0315700>] (_raw_spin_lock+0x2c/0x3c) [<c0315700>]
> (_raw_spin_lock+0x2c/0x3c) from [<c009e538>]
> (__perf_event_sched_in+0x20/0x168) [<c009e538>]
> (__perf_event_sched_in+0x20/0x168) from [<c009e6c8>]
> (perf_event_task_sched_in+0x48/0x58) [<c009e6c8>]
> (perf_event_task_sched_in+0x48/0x58) from [<c003f2dc>]
> (finish_task_switch+0x34/0xb4) [<c003f2dc>] (finish_task_switch+0x34/0xb4)
> from [<c03133e0>] (schedule+0x728/0x834) [<c03133e0>]
> (schedule+0x728/0x834) from [<c00d5190>] (pipe_wait+0x64/0x84) [<c00d5190>]
> (pipe_wait+0x64/0x84) from [<c00d59d8>] (pipe_read+0x3ac/0x428)
> [<c00d59d8>] (pipe_read+0x3ac/0x428) from [<c00cdd34>]
> (do_sync_read+0x94/0xe0) [<c00cdd34>] (do_sync_read+0x94/0xe0) from
> [<c00ce868>] (vfs_read+0xa8/0x150) [<c00ce868>] (vfs_read+0xa8/0x150) from
> [<c00ce9bc>] (sys_read+0x3c/0x68) [<c00ce9bc>] (sys_read+0x3c/0x68) from
> [<c002b140>] (ret_fast_syscall+0x0/0x38)
>
> This occurs more frequently when profiling code that spawns child processes
> [e.g. gcc] but I've see it happen with sleep too. It also happens if I pass
> maxcpus=1 as a bootarg.
>
> Have you seen this happen on your board? I've failed to reproduce it on my
> x86 machine.
>
> Will
>
> * Jamie Iles wrote:
> > This patch implements support for ARMv6 performance counters in the
> > Linux performance events subsystem. ARMv6 architectures that have the
> > performance counters should enable HW_PERF_EVENTS and define the
> > interrupts for the counters in arch/arm/kernel/perf_event.c
> >
> > This implementation also provides an ARM PMU abstraction layer to allow
> > ARMv7 and others to be supported in the future by adding new a
> > 'struct arm_pmu'.
> >
> > Signed-off-by: Jamie Iles <jamie.iles@picochip.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Ingo Molnar <mingo@elte.hu>
> > Cc: Jean Pihet <jpihet@mvista.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm/Kconfig             |    8 +
> >  arch/arm/kernel/Makefile     |    1 +
> >  arch/arm/kernel/perf_event.c | 1338
> > ++++++++++++++++++++++++++++++++++++++++++ 3 files changed, 1347
> > insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/kernel/perf_event.c
>
> <truncated>
