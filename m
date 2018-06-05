From: james.morse@arm.com (James Morse)
Date: Tue, 5 Jun 2018 18:46:42 +0100
Subject: panic kexec broken on ARM64?
In-Reply-To: <20180605100151.7fd54381@ezekiel.suse.cz>
References: <20180605100151.7fd54381@ezekiel.suse.cz>
Message-ID: <8028219f-0d14-eafd-86b7-359ee927bcd3@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Petr,

(CC: +Akashi, Marc)

On 05/06/18 09:01, Petr Tesarik wrote:
> I have observed hangs after crash on a Raspberry Pi 3 Model B+ board
> when a panic kernel is loaded.

kdump is a best-effort thing, it looks like this is a case where the
crashed-kernel can't tear itself down.

Do you have the rest of the stack trace? Was it handling an irq when it decided
to panic?:
https://lkml.org/lkml/2018/3/13/1134


> I attached a hardware debugger and found
> out that all CPU cores were stopped except one which was stuck in the
> idle thread. It seems that irq_set_irqchip_state() may sleep, which is
> definitely not safe after a kernel panic.

I don't know much about irqchip stuff, but __irq_get_desc_lock() takes a
raw_spin_lock(), and calls gic_irq_get_irqchip_state() which is just poking
around in mmio registers, this should all be safe unless you re-entered the same
code.


> If I'm right, then this is broken in general, but I have only ever seen
> it on RPi 3 Model B+ (even RPi3 Model B works fine), so the issue may
> be more subtle.

Is there a hardware difference around the interrupt controller on these?


> FWIW the code for 32-bit ARM seems to work just fine
> without this code in machine_kexec_mask_interrupts():
> 
>                 /*
>                  * First try to remove the active state. If this
>                  * fails, try to EOI the interrupt.
>                  */
>                 ret = irq_set_irqchip_state(i, IRQCHIP_STATE_ACTIVE, false);
> 
> I wonder what breaks if this call to irq_set_irqchip_state() is removed.

My understanding is this is to reset all interrupts so the new kernel doesn't
spend its first waking minutes declaring all these pending interrupts as
spurious as the device drivers haven't (re-)claimed them yet.

I don't know if/how this is done on 32bit.


> For reference, here is a stack trace of the process which originally
> triggered the panic:
> 
> #0  __switch_to (prev=0xffff000008e62a00 <init_task>, next=0xffff80002b796080) at ../arch/arm64/kernel/process.c:355
> #1  0xffff0000088f584c in context_switch (rf=<optimized out>, next=<optimized out>, prev=<optimized out>, rq=<optimized out>) at ../kernel/sched/core.c:2896
> #2  __schedule (preempt=false) at ../kernel/sched/core.c:3457
> #3  0xffff0000088f5eac in schedule () at ../kernel/sched/core.c:3516
> #4  0xffff0000088f9448 in schedule_timeout (timeout=<optimized out>) at ../kernel/time/timer.c:1743
> #5  0xffff0000088f6afc in do_wait_for_common (state=<optimized out>, timeout=500, action=<optimized out>, x=<optimized out>) at ../kernel/sched/completion.c:77
> #6  __wait_for_common (state=<optimized out>, timeout=<optimized out>, action=<optimized out>, x=<optimized out>) at ../kernel/sched/completion.c:96
> #7  wait_for_common (x=0xffff000008e53848 <init_thread_union+14408>, timeout=500, state=<optimized out>) at ../kernel/sched/completion.c:104
> #8  0xffff0000088f6c1c in wait_for_completion_timeout (x=0xffff000008e53848 <init_thread_union+14408>, timeout=500) at ../kernel/sched/completion.c:144
> #9  0xffff000000a19f1c in usb_start_wait_urb (urb=0xffff80002c1cd700, timeout=5000, actual_length=0xffff000008e538dc <init_thread_union+14556>)
>     at ../drivers/usb/core/message.c:61

(USB?!)

> #10 0xffff000000a1a05c in usb_internal_control_msg (timeout=<optimized out>, len=<optimized out>, data=<optimized out>, cmd=<optimized out>, pipe=<optimized out>, 
>     usb_dev=<optimized out>) at ../drivers/usb/core/message.c:100
> #11 usb_control_msg (dev=0xffff80002c348000, pipe=2147484800, request=161 '\241', requesttype=192 '\300', value=0, index=152, data=0xffff80002b6fa080, size=4, 
>     timeout=5000) at ../drivers/usb/core/message.c:151
> #12 0xffff000001001cd0 in lan78xx_read_reg (index=152, data=0xffff000008e5396c <init_thread_union+14700>, dev=<optimized out>, dev=<optimized out>)
>     at ../drivers/net/usb/lan78xx.c:425
> #13 0xffff00000100365c in lan78xx_irq_bus_sync_unlock (irqd=<optimized out>) at ../drivers/net/usb/lan78xx.c:1909

I'm not sure what these 'struct irq_chip' outside drivers/irqchip are,
presumably irq-controllers can be nested, and devices believe they are interrupt
controllers too.

This looks like yours is actually a network chip on the other end of a usb bus.
Any configuration attempt involves taking mutexs, allocating memory and sitting
on a wait queue until the response comes, (all relying on a different kind of
interrupt).

So for this network-irqcontroller-chip its not safe to call
irq_set_irqchip_state() from irq context. (you also survived taking a mutex and
allocating a few buffers before hitting the wait queue).

I'm not sure how this should be fixed, but as suggested on that irqchip thread
above, having a irqchip-specific separate 'reset' API could do something more
drastic than trying to modify the configuration, which requires these
locks/memory-allocation.


> #14 0xffff00000813e590 in chip_bus_sync_unlock (desc=<optimized out>) at ../kernel/irq/internals.h:129
> #15 __irq_put_desc_unlock (desc=0xffff80002c361c00, flags=128, bus=true) at ../kernel/irq/irqdesc.c:804
> #16 0xffff00000813f604 in irq_put_desc_busunlock (flags=<optimized out>, desc=<optimized out>) at ../kernel/irq/internals.h:155
> #17 irq_set_irqchip_state (irq=<optimized out>, which=<optimized out>, val=false) at ../kernel/irq/manage.c:2136
> #18 0xffff00000809b7d4 in machine_kexec_mask_interrupts () at ../arch/arm64/kernel/machine_kexec.c:233
> #19 machine_crash_shutdown (regs=<optimized out>) at ../arch/arm64/kernel/machine_kexec.c:259
> #20 0xffff000008180fd4 in __crash_kexec (regs=0xffff000008e53d70 <init_thread_union+15728>) at ../kernel/kexec_core.c:943
> #21 0xffff0000081810e4 in crash_kexec (regs=0xffff000008e53d70 <init_thread_union+15728>) at ../kernel/kexec_core.c:965
> #22 0xffff00000808ab58 in die (str=<optimized out>, regs=0xffff000008e53d70 <init_thread_union+15728>, err=-2046820348) at ../arch/arm64/kernel/traps.c:266
> #23 0xffff0000080a1c14 in __do_kernel_fault (mm=0x0, addr=0, esr=2248146948, regs=0xffff000008e53d70 <init_thread_union+15728>) at ../arch/arm64/mm/fault.c:226
> #24 0xffff0000088fc8dc in do_page_fault (addr=0, esr=2248146948, regs=0xffff000008e53d70 <init_thread_union+15728>) at ../arch/arm64/mm/fault.c:476
> #25 0xffff0000088fccdc in do_translation_fault (addr=0, esr=2248146948, regs=0xffff000008e53d70 <init_thread_union+15728>) at ../arch/arm64/mm/fault.c:502
> #26 0xffff000008081478 in do_mem_abort (addr=0, esr=2248146948, regs=0xffff000008e53d70 <init_thread_union+15728>) at ../arch/arm64/mm/fault.c:657
> #27 0xffff000008082dd0 in el1_sync () at ../arch/arm64/kernel/entry.S:548

What was going on just before this NULL deference? This looks like CPU0's idle
thread stack, which rules out another irq.


Thanks,

James
