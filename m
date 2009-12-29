From: jpihet@mvista.com (Jean Pihet)
Date: Tue, 29 Dec 2009 14:52:16 +0100
Subject: Perf Event support for ARMv7 (was: Re: [PATCH 5/5]
	arm/perfevents: implement perf event support for ARMv6)
In-Reply-To: <20091228075748.GC20039@elte.hu>
References: <1260875712-29712-1-git-send-email-jamie.iles@picochip.com>
	<200912221751.39662.jpihet@mvista.com>
	<20091228075748.GC20039@elte.hu>
Message-ID: <200912291452.16856.jpihet@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ingo, Jamie,

On Monday 28 December 2009 08:57:48 Ingo Molnar wrote:
> * Jean Pihet <jpihet@mvista.com> wrote:
> > The code is for review, it has been checked, compiled and boot tested on
> > OMAP3 (Cortex-A8). Unfortunately I am still facing some cross compilation
> > problems of the tools/perf utility.
>
> Have you managed to solve these cross-compilation problems? If yes, it
> would be nice to merge the fixes into upstream perf.
Yes I got them resolved but I needed to make a few changes:
- -Werror removed from the CFLAGS definition in tools/perf/Makefile. Without 
the change the compilation stops after a warning about include paths.
- the rmb() macro in tools/perf/perf.h prevents the compilation. I changed it 
to the definition from arch/arm/include/asm/system.h (asm 
volatile("":::"memory")). Where is the original definition from? Why is it 
specific to perf_events?

What do you think about those changes? Should they be submitted separately?

I tested the ARMv7 code on the Cortex-A8 processor. The code looks fine but 
when I load the CPU I am running into spinlock recursion problems (in 
perf_ctx_adjust_freq).
Does those problem happen on ARMv6 as well?
Here is the backtrace:

BUG: spinlock recursion on CPU#0, cp/1049
 lock: c7ab4600, .magic: dead4ead, .owner: cp/1049, .owner_cpu: 0
[<c00415e0>] (unwind_backtrace+0x0/0xdc) from [<c0200c7c>] 
(do_raw_spin_lock+0x48/0x14c)
[<c0200c7c>] (do_raw_spin_lock+0x48/0x14c) from [<c00b7ca4>] 
(perf_ctx_adjust_freq+0xc/0x1b4)
[<c00b7ca4>] (perf_ctx_adjust_freq+0xc/0x1b4) from [<c00b7e84>] 
(perf_event_task_tick+0x38/0x9c)
[<c00b7e84>] (perf_event_task_tick+0x38/0x9c) from [<c0078d9c>] 
(update_process_times+0x3c/0x48)
[<c0078d9c>] (update_process_times+0x3c/0x48) from [<c00907fc>] 
(tick_sched_timer+0x80/0xbc)
[<c00907fc>] (tick_sched_timer+0x80/0xbc) from [<c0087f3c>] 
(__run_hrtimer+0xc8/0x158)
[<c0087f3c>] (__run_hrtimer+0xc8/0x158) from [<c008823c>] 
(hrtimer_interrupt+0x130/0x310)
[<c008823c>] (hrtimer_interrupt+0x130/0x310) from [<c0048244>] 
(omap2_gp_timer_interrupt+0x20/0x2c)
[<c0048244>] (omap2_gp_timer_interrupt+0x20/0x2c) from [<c009dc14>] 
(handle_IRQ_event+0x70/0x184)
[<c009dc14>] (handle_IRQ_event+0x70/0x184) from [<c009f7a8>] 
(handle_level_irq+0xa4/0x118)
[<c009f7a8>] (handle_level_irq+0xa4/0x118) from [<c003b070>] 
(asm_do_IRQ+0x70/0x90)
[<c003b070>] (asm_do_IRQ+0x70/0x90) from [<c042d2f0>] (__irq_svc+0x30/0x80)
Exception stack(0xc7a89890 to 0xc7a898d8)
9880:                                     00000000 c05bc1e0 0000001e 00000010
98a0: 00000004 c05bc1e0 c7a7e8a8 c05bc160 c0606550 c7bccdc0 c05db260 c7a8997c
98c0: 00000000 c7a898d8 c0041f44 c01f6034 40000013 ffffffff
[<c042d2f0>] (__irq_svc+0x30/0x80) from [<c01f6034>] 
(_test_and_set_bit_le+0x20/0x34)
BUG: spinlock lockup on CPU#0, cp/1049, c7ab4600
[<c00415e0>] (unwind_backtrace+0x0/0xdc) from [<c0200d44>] 
(do_raw_spin_lock+0x110/0x14c)
[<c0200d44>] (do_raw_spin_lock+0x110/0x14c) from [<c00b7ca4>] 
(perf_ctx_adjust_freq+0xc/0x1b4)
[<c00b7ca4>] (perf_ctx_adjust_freq+0xc/0x1b4) from [<c00b7e84>] 
(perf_event_task_tick+0x38/0x9c)
[<c00b7e84>] (perf_event_task_tick+0x38/0x9c) from [<c0078d9c>] 
(update_process_times+0x3c/0x48)
[<c0078d9c>] (update_process_times+0x3c/0x48) from [<c00907fc>] 
(tick_sched_timer+0x80/0xbc)
[<c00907fc>] (tick_sched_timer+0x80/0xbc) from [<c0087f3c>] 
(__run_hrtimer+0xc8/0x158)
[<c0087f3c>] (__run_hrtimer+0xc8/0x158) from [<c008823c>] 
(hrtimer_interrupt+0x130/0x310)
[<c008823c>] (hrtimer_interrupt+0x130/0x310) from [<c0048244>] 
(omap2_gp_timer_interrupt+0x20/0x2c)
[<c0048244>] (omap2_gp_timer_interrupt+0x20/0x2c) from [<c009dc14>] 
(handle_IRQ_event+0x70/0x184)
[<c009dc14>] (handle_IRQ_event+0x70/0x184) from [<c009f7a8>] 
(handle_level_irq+0xa4/0x118)
[<c009f7a8>] (handle_level_irq+0xa4/0x118) from [<c003b070>] 
(asm_do_IRQ+0x70/0x90)
[<c003b070>] (asm_do_IRQ+0x70/0x90) from [<c042d2f0>] (__irq_svc+0x30/0x80)
Exception stack(0xc7a89890 to 0xc7a898d8)
9880:                                     00000000 c05bc1e0 0000001e 00000010
98a0: 00000004 c05bc1e0 c7a7e8a8 c05bc160 c0606550 c7bccdc0 c05db260 c7a8997c
98c0: 00000000 c7a898d8 c0041f44 c01f6034 40000013 ffffffff

>
> 	Ingo

Regards,
Jean
