From: will.deacon@arm.com (Will Deacon)
Date: Wed, 6 Jan 2010 12:09:07 -0000
Subject: [PATCH 5/5] arm/perfevents: implement perf event support for	ARMv6
In-Reply-To: <20100106001831.GM4179@wear.picochip.com>
References: <1262602122-10373-1-git-send-email-jamie.iles@picochip.com>
	<1262602122-10373-2-git-send-email-jamie.iles@picochip.com>
	<1262602122-10373-3-git-send-email-jamie.iles@picochip.com>
	<1262602122-10373-4-git-send-email-jamie.iles@picochip.com>
	<1262602122-10373-5-git-send-email-jamie.iles@picochip.com>
	<1262602122-10373-6-git-send-email-jamie.iles@picochip.com>
	<20100105222657.GK4179@wear.picochip.com>
	<20100105223147.GB10941@n2100.arm.linux.org.uk>
	<20100106001831.GM4179@wear.picochip.com>
Message-ID: <000501ca8ec9$0c790970$256b1c50$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jamie,

* Jamie Iles wrote:

> Ok, I've tried 2 things:
> 	1. disabling interrupts around perf_event_task_sched_in()
> 	2. undefining __ARCH_WANT_INTERRUPTS_ON_CTXSW
> 
> As far as I can tell, both of these solutions work, although with 2, I had to
> define __ARCH_WANT_INTERRUPTS_ON_CTXSW.

I don't follow what you mean for point (2) when you say you have to define
__ARCH_WANT_INTERRUPTS_ON_CTXSW. I tried defining __ARCH_WANT_INTERRUPTS_ON_CTXSW
only when VIVT caches are present [as Russell mentioned], but I encountered
further locking problems with __new_context [see below].

> Will, Jean - could you give the patch below a go and see if it works on your
> systems? I don't get any lockdep warnings on my platform with this and it
> still runs without the lock debugging.

This patch solves the issue for me. Should this be integrated into your patchset
as that is the first perf code for ARM?

Cheers,

Will


======================================================
[ INFO: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected ]
2.6.33-rc2-tip+ #1
------------------------------------------------------
swapper/0 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
 (cpu_asid_lock){+.+...}, at: [<c0035c14>] __new_context+0x14/0xc4

and this task is already holding:
 (&rq->lock){-.-.-.}, at: [<c030c948>] schedule+0xa8/0x834
which would create a new lock dependency:
 (&rq->lock){-.-.-.} -> (cpu_asid_lock){+.+...}

but this new dependency connects a HARDIRQ-irq-safe lock:
 (&rq->lock){-.-.-.} 
... which became HARDIRQ-irq-safe at:
  [<c0076074>] __lock_acquire+0x5c8/0x17b4
  [<c0077334>] lock_acquire+0xd4/0xec
  [<c030f2e8>] _raw_spin_lock+0x2c/0x3c
  [<c004665c>] scheduler_tick+0x34/0x144
  [<c0058670>] update_process_times+0x40/0x4c
  [<c00720e0>] tick_periodic+0xdc/0x108
  [<c0072130>] tick_handle_periodic+0x24/0xf0
  [<c0036e20>] realview_timer_interrupt+0x24/0x34
  [<c008aa30>] handle_IRQ_event+0x5c/0x144
  [<c008c848>] handle_level_irq+0xc0/0x134
  [<c002a084>] asm_do_IRQ+0x84/0xc0
  [<c002aca4>] __irq_svc+0x44/0xe0
  [<c0309c64>] calibrate_delay+0x84/0x1ac
  [<c0008be0>] start_kernel+0x224/0x2c8
  [<70008080>] 0x70008080

to a HARDIRQ-irq-unsafe lock:
 (cpu_asid_lock){+.+...}
... which became HARDIRQ-irq-unsafe at:
...  [<c0076100>] __lock_acquire+0x654/0x17b4
  [<c0077334>] lock_acquire+0xd4/0xec
  [<c030f2e8>] _raw_spin_lock+0x2c/0x3c
  [<c0035c14>] __new_context+0x14/0xc4
  [<c00d7d74>] flush_old_exec+0x3b8/0x75c
  [<c0109fa8>] load_elf_binary+0x340/0x1288
  [<c00d7500>] search_binary_handler+0x130/0x320
  [<c00d8bcc>] do_execve+0x1c0/0x2d4
  [<c002e558>] kernel_execve+0x34/0x84
  [<c002a7ac>] init_post+0xc0/0x110
  [<c0008730>] kernel_init+0x1b8/0x208
  [<c002c2ec>] kernel_thread_exit+0x0/0x8

other info that might help us debug this:

1 lock held by swapper/0:
 #0:  (&rq->lock){-.-.-.}, at: [<c030c948>] schedule+0xa8/0x834

the dependencies between HARDIRQ-irq-safe lock and the holding lock:
-> (&rq->lock){-.-.-.} ops: 0 {
   IN-HARDIRQ-W at:  
 [<c0076074>] __lock_acquire+0x5c8/0x17b4
                        [<c0077334>] lock_acquire+0xd4/0xec
                        [<c030f2e8>] _raw_spin_lock+0x2c/0x3c
                        [<c004665c>] scheduler_tick+0x34/0x144
                        [<c0058670>] update_process_times+0x40/0x4c
                        [<c00720e0>] tick_periodic+0xdc/0x108
                        [<c0072130>] tick_handle_periodic+0x24/0xf0
                        [<c0036e20>] realview_timer_interrupt+0x24/0x34
                        [<c008aa30>] handle_IRQ_event+0x5c/0x144
                        [<c008c848>] handle_level_irq+0xc0/0x134
                        [<c002a084>] asm_do_IRQ+0x84/0xc0
                        [<c002aca4>] __irq_svc+0x44/0xe0
                        [<c0309c64>] calibrate_delay+0x84/0x1ac
                        [<c0008be0>] start_kernel+0x224/0x2c8
                        [<70008080>] 0x70008080
   IN-SOFTIRQ-W at:  
                        [<c0076098>] __lock_acquire+0x5ec/0x17b4
                        [<c0077334>] lock_acquire+0xd4/0xec
                        [<c030f2e8>] _raw_spin_lock+0x2c/0x3c
                        [<c004492c>] double_rq_lock+0x40/0x84
                        [<c0045c90>] run_rebalance_domains+0x208/0x510
                        [<c0051510>] __do_softirq+0xe8/0x1e4
                        [<c002a3cc>] do_local_timer+0x50/0x80
                        [<c002aca4>] __irq_svc+0x44/0xe0
                        [<c002c388>] default_idle+0x28/0x2c
                        [<c002c8ac>] cpu_idle+0x8c/0xe4
                        [<c0008c28>] start_kernel+0x26c/0x2c8
                        [<70008080>] 0x70008080
   IN-RECLAIM_FS-W at:
                           [<c0076170>] __lock_acquire+0x6c4/0x17b4
                           [<c0077334>] lock_acquire+0xd4/0xec
                           [<c030f2e8>] _raw_spin_lock+0x2c/0x3c
                           [<c003f35c>] task_rq_lock+0x40/0x78
                           [<c0045fc8>] set_cpus_allowed_ptr+0x30/0x1bc
                           [<c00b426c>] kswapd+0x78/0x620
                           [<c0066a5c>] kthread+0x7c/0x84
                           [<c002c2ec>] kernel_thread_exit+0x0/0x8
   INITIAL USE at:   
                       [<c0076188>] __lock_acquire+0x6dc/0x17b4
                       [<c0077334>] lock_acquire+0xd4/0xec
                       [<c030f3e4>] _raw_spin_lock_irqsave+0x40/0x54
                       [<c004302c>] rq_attach_root+0x14/0x10c
                       [<c000c780>] sched_init+0x234/0x35c
                       [<c0008b28>] start_kernel+0x16c/0x2c8
                       [<70008080>] 0x70008080
 }
 ... key      at: [<c044ef3c>] __key.45524+0x0/0x8
 ... acquired at:
   [<c0075a4c>] check_irq_usage+0x58/0xb8
   [<c0076b54>] __lock_acquire+0x10a8/0x17b4
   [<c0077334>] lock_acquire+0xd4/0xec
   [<c030f2e8>] _raw_spin_lock+0x2c/0x3c
   [<c0035c14>] __new_context+0x14/0xc4
   [<c030cf50>] schedule+0x6b0/0x834
   [<c002c8ec>] cpu_idle+0xcc/0xe4
   [<70008080>] 0x70008080

the dependencies between the lock to be acquired and HARDIRQ-irq-unsafe lock:
-> (cpu_asid_lock){+.+...} ops: 0 {
   HARDIRQ-ON-W at:  
                        [<c0076100>] __lock_acquire+0x654/0x17b4
                        [<c0077334>] lock_acquire+0xd4/0xec
                        [<c030f2e8>] _raw_spin_lock+0x2c/0x3c
                        [<c0035c14>] __new_context+0x14/0xc4
                        [<c00d7d74>] flush_old_exec+0x3b8/0x75c
                        [<c0109fa8>] load_elf_binary+0x340/0x1288
                        [<c00d7500>] search_binary_handler+0x130/0x320
                        [<c00d8bcc>] do_execve+0x1c0/0x2d4
                        [<c002e558>] kernel_execve+0x34/0x84
                        [<c002a7ac>] init_post+0xc0/0x110
                        [<c0008730>] kernel_init+0x1b8/0x208
                        [<c002c2ec>] kernel_thread_exit+0x0/0x8
   SOFTIRQ-ON-W at:  
                        [<c0076124>] __lock_acquire+0x678/0x17b4
                        [<c0077334>] lock_acquire+0xd4/0xec
                        [<c030f2e8>] _raw_spin_lock+0x2c/0x3c
                        [<c0035c14>] __new_context+0x14/0xc4
                        [<c00d7d74>] flush_old_exec+0x3b8/0x75c
                        [<c0109fa8>] load_elf_binary+0x340/0x1288
                        [<c00d7500>] search_binary_handler+0x130/0x320
                        [<c00d8bcc>] do_execve+0x1c0/0x2d4
                        [<c002e558>] kernel_execve+0x34/0x84
                        [<c002a7ac>] init_post+0xc0/0x110
                        [<c0008730>] kernel_init+0x1b8/0x208
                        [<c002c2ec>] kernel_thread_exit+0x0/0x8
   INITIAL USE at:   
                       [<c0076188>] __lock_acquire+0x6dc/0x17b4
                       [<c0077334>] lock_acquire+0xd4/0xec
                       [<c030f2e8>] _raw_spin_lock+0x2c/0x3c
                       [<c0035c14>] __new_context+0x14/0xc4
                       [<c00d7d74>] flush_old_exec+0x3b8/0x75c
                       [<c0109fa8>] load_elf_binary+0x340/0x1288
                       [<c00d7500>] search_binary_handler+0x130/0x320
                       [<c00d8bcc>] do_execve+0x1c0/0x2d4
                       [<c002e558>] kernel_execve+0x34/0x84
                       [<c002a7ac>] init_post+0xc0/0x110
                       [<c0008730>] kernel_init+0x1b8/0x208
                       [<c002c2ec>] kernel_thread_exit+0x0/0x8
 }
 ... key      at: [<c042c57c>] cpu_asid_lock+0x10/0x1c
 ... acquired at:
   [<c0075a4c>] check_irq_usage+0x58/0xb8
   [<c0076b54>] __lock_acquire+0x10a8/0x17b4
   [<c0077334>] lock_acquire+0xd4/0xec
   [<c030f2e8>] _raw_spin_lock+0x2c/0x3c
   [<c0035c14>] __new_context+0x14/0xc4
   [<c030cf50>] schedule+0x6b0/0x834
   [<c002c8ec>] cpu_idle+0xcc/0xe4
 [<70008080>] 0x70008080


stack backtrace:
[<c0031760>] (unwind_backtrace+0x0/0xd4) from [<c0075984>] (check_usage+0x3f0/0x460)
[<c0075984>] (check_usage+0x3f0/0x460) from [<c0075a4c>] (check_irq_usage+0x58/0xb8)
[<c0075a4c>] (check_irq_usage+0x58/0xb8) from [<c0076b54>] (__lock_acquire+0x10a8/0x17b4)
[<c0076b54>] (__lock_acquire+0x10a8/0x17b4) from [<c0077334>] (lock_acquire+0xd4/0xec)
[<c0077334>] (lock_acquire+0xd4/0xec) from [<c030f2e8>] (_raw_spin_lock+0x2c/0x3c)
[<c030f2e8>] (_raw_spin_lock+0x2c/0x3c) from [<c0035c14>] (__new_context+0x14/0xc4)
[<c0035c14>] (__new_context+0x14/0xc4) from [<c030cf50>] (schedule+0x6b0/0x834)
[<c030cf50>] (schedule+0x6b0/0x834) from [<c002c8ec>] (cpu_idle+0xcc/0xe4)
[<c002c8ec>] (cpu_idle+0xcc/0xe4) from [<70008080>] (0x70008080)
