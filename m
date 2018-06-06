From: ptesarik@suse.cz (Petr Tesarik)
Date: Wed, 6 Jun 2018 13:41:34 +0200
Subject: panic kexec broken on ARM64?
In-Reply-To: <20180606100024.50be6b75@ezekiel.suse.cz>
References: <20180605100151.7fd54381@ezekiel.suse.cz>
 <8028219f-0d14-eafd-86b7-359ee927bcd3@arm.com>
 <5e539510-01b7-ebc5-778e-b49a5261f9bc@i2se.com>
 <20180606100024.50be6b75@ezekiel.suse.cz>
Message-ID: <20180606134134.41b963b0@ezekiel.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 6 Jun 2018 10:00:24 +0200
Petr Tesarik <ptesarik@suse.cz> wrote:

> On Wed, 6 Jun 2018 09:02:04 +0200
> Stefan Wahren <stefan.wahren@i2se.com> wrote:
> 
> > Hi Petr,
> > 
> > Am 05.06.2018 um 19:46 schrieb James Morse:  
> > > Hi Petr,
> > >
> > > (CC: +Akashi, Marc)
> > >
> > > On 05/06/18 09:01, Petr Tesarik wrote:    
> > >> I have observed hangs after crash on a Raspberry Pi 3 Model B+ board
> > >> when a panic kernel is loaded.    
> > > kdump is a best-effort thing, it looks like this is a case where the
> > > crashed-kernel can't tear itself down.
> > >
> > > Do you have the rest of the stack trace? Was it handling an irq when it decided
> > > to panic?:
> > > https://lkml.org/lkml/2018/3/13/1134    
> > 
> > the Raspberry Pi 3 B+ support is very fresh (linux-next). Since i didn't 
> > see a version, i need to doublecheck.
> > 
> > You are actually using linux-next and not the downstream kernel?  
> 
> Very good point. I'll try again with linux-next.

It took me some time to set up everything correctly again...

Unfortunately, it makes no difference. I set a hardware breakpoint on
machine_crash_shutdown, followed by a breakpoint at __switch_to, and it
did trigger:

(gdb) lx-version 
Linux version 4.17.0-next-20180605-18-default (root at thunderx10) (gcc version 4.8.5 (SUSE Linux)) #1 SMP Wed Jun 6 10:26:46 CEST 2018
(gdb) bt
#0  __switch_to (prev=0xffff80002b428240, next=0xffff000008c32700 <init_task>) at arch/arm64/kernel/process.c:419
#1  0xffff0000088003d4 in context_switch (rf=<optimized out>, next=<optimized out>, prev=<optimized out>, rq=<optimized out>) at kernel/sched/core.c:2860
#2  __schedule (preempt=false) at kernel/sched/core.c:3502
#3  0xffff00000880092c in schedule () at kernel/sched/core.c:3546
#4  0xffff000008803e24 in schedule_timeout (timeout=<optimized out>) at kernel/time/timer.c:1801
#5  0xffff00000880144c in do_wait_for_common (state=<optimized out>, timeout=<optimized out>, action=<optimized out>, x=<optimized out>)
    at kernel/sched/completion.c:83
#6  __wait_for_common (state=<optimized out>, timeout=<optimized out>, action=<optimized out>, x=<optimized out>) at kernel/sched/completion.c:104
#7  wait_for_common (x=0xffff80002d0ef548, timeout=500, state=<optimized out>) at kernel/sched/completion.c:115
#8  0xffff000008801554 in wait_for_completion_timeout (x=0xffff80002d0ef548, timeout=<optimized out>) at kernel/sched/completion.c:155
#9  0xffff0000008f5ef8 in usb_start_wait_urb (urb=0xffff80002c593400, timeout=5000, actual_length=0xffff80002d0ef5dc) at drivers/usb/core/message.c:62
#10 0xffff0000008f602c in usb_internal_control_msg (timeout=<optimized out>, len=<optimized out>, data=<optimized out>, cmd=<optimized out>, pipe=<optimized out>, 
    usb_dev=<optimized out>) at drivers/usb/core/message.c:101
#11 usb_control_msg (dev=0xffff80002c684000, pipe=2147484800, request=161 '\241', requesttype=192 '\300', value=0, index=152, data=0xffff80002d421c80, size=4, 
    timeout=5000) at drivers/usb/core/message.c:152
#12 0xffff000000f29e10 in lan78xx_read_reg (index=152, data=0xffff80002d0ef66c, dev=<optimized out>, dev=<optimized out>) at drivers/net/usb/lan78xx.c:449
#13 0xffff000000f2c018 in lan78xx_irq_bus_sync_unlock (irqd=<optimized out>) at drivers/net/usb/lan78xx.c:1954
#14 0xffff0000081168e4 in chip_bus_sync_unlock (desc=<optimized out>) at kernel/irq/internals.h:147
#15 __irq_put_desc_unlock (desc=0xffff80002e7a9400, flags=<optimized out>, bus=true) at kernel/irq/irqdesc.c:837
#16 0xffff0000081176c0 in irq_put_desc_busunlock (flags=<optimized out>, desc=<optimized out>) at kernel/irq/internals.h:173
#17 irq_set_irqchip_state (irq=<optimized out>, which=IRQCHIP_STATE_ACTIVE, val=false) at kernel/irq/manage.c:2205
#18 0xffff00000809e0b0 in machine_kexec_mask_interrupts () at arch/arm64/kernel/machine_kexec.c:233
#19 machine_crash_shutdown (regs=<optimized out>) at arch/arm64/kernel/machine_kexec.c:259
#20 0xffff00000815b358 in __crash_kexec (regs=0xffff80002d0efb50) at kernel/kexec_core.c:943
#21 0xffff00000815b45c in crash_kexec (regs=0xffff80002d0efb50) at kernel/kexec_core.c:965
#22 0xffff00000808dc84 in die (str=<optimized out>, regs=0xffff80002d0efb50, err=<optimized out>) at arch/arm64/kernel/traps.c:210
#23 0xffff0000080a2114 in die_kernel_fault (msg=0xffff000008a09c88 "NULL pointer dereference", addr=0, esr=2516582468, regs=<optimized out>)
    at arch/arm64/mm/fault.c:269
#24 0xffff0000080a1d68 in __do_kernel_fault (addr=0, esr=2516582468, regs=0xffff80002d0efb50) at arch/arm64/mm/fault.c:297
#25 0xffff000008806e38 in do_page_fault (addr=0, esr=2516582468, regs=0xffff80002d0efb50) at arch/arm64/mm/fault.c:599
#26 0xffff0000088070dc in do_translation_fault (addr=0, esr=<optimized out>, regs=<optimized out>) at arch/arm64/mm/fault.c:608
#27 0xffff0000080812cc in do_mem_abort (addr=0, esr=2516582468, regs=0xffff80002d0efb50) at arch/arm64/mm/fault.c:744
#28 0xffff000008082ed0 in el1_sync () at arch/arm64/kernel/entry.S:583
Backtrace stopped: previous frame identical to this frame (corrupt stack?)
(gdb)

The system hanged in the idle thread after continuing here.

Petr T
