From: anders.roxell@linaro.org (Anders Roxell)
Date: Wed, 31 Oct 2018 16:30:38 +0100
Subject: [RFC PATCH] arm64/mm: hit DEBUG_LOCKS_WARN_ON
In-Reply-To: <405fca92-dd11-0a52-119e-9f3065b1a48a@arm.com>
References: <20181031121356.30654-1-anders.roxell@linaro.org>
 <405fca92-dd11-0a52-119e-9f3065b1a48a@arm.com>
Message-ID: <CADYN=9KEwTrZR6NooYANbbVXERD-_AQOW7b+tgW-dhkVnkNhYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 31 Oct 2018 at 13:37, James Morse <james.morse@arm.com> wrote:
>
> Hi Anders,
>

Hi James,

> (CC: +linux-arm-kernel at lists.infradead.org)

Thanks, I missed that.

>
> On 31/10/2018 12:13, Anders Roxell wrote:
> > I'm running an arm64 kernel in a qemu guest and I hit this
> > DEBUG_LOCKS_WARN_ON and this patch removes the warning. The
> > interrupts_enabled(reqs) should reflect the irq->enabled state of the
> > kgdb test process
>
> (I know nothing about kgdb, please forgive the stupid questions:)
>
> Where does this 'irq->enabled state of the kgdb test process' come from?
> What happens if it takes an interrupt, then you single-step the
> interrupt handler? (How can any state in memory get updated...)
>
>
> > when it hit the breakpoint, and that should be the
> > same as the current->hardirqs_enabled flag
> >
> > [   25.682116] kgdbts:RUN singlestep test 1000 iterations
> > [   25.695926] ------------[ cut here ]------------
> > [   25.696410] DEBUG_LOCKS_WARN_ON(current->hardirqs_enabled)
> > [   25.697407] WARNING: CPU: 0 PID: 1 at ../kernel/locking/lockdep.c:3761 check_flags+0x64/0x198
> > [   25.698349] Modules linked in:
> > [   25.699144] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G                T 4.19.0-next-20181030+ #6
> > [   25.699739] Hardware name: linux,dummy-virt (DT)
> > [   25.700359] pstate: 404003c5 (nZcv DAIF +PAN -UAO)
> > [   25.700901] pc : check_flags+0x64/0x198
> > [   25.701381] lr : check_flags+0x64/0x198
>
> > [   25.710104] Call trace:
> > [   25.710553]  check_flags+0x64/0x198
> > [   25.711023]  lock_acquire+0x60/0x248
> > [   25.711477]  call_step_hook+0x5c/0x190
> > [   25.711937]  single_step_handler+0x48/0xa0
> > [   25.712399]  do_debug_exception+0x104/0x160
> > [   25.712846]  el1_dbg+0x18/0xa8
> > [   25.713252]  el1_irq+0xa8/0x1c0
> > [   25.713709]  kgdbts_break_test+0x0/0x40
> > [   25.714171]  kgdbts_run_tests+0x2b0/0x430
> > [   25.714637]  configure_kgdbts+0x7c/0xb0
> > [   25.715110]  init_kgdbts+0x70/0xac
> > [   25.715551]  do_one_initcall+0x1fc/0x490
> > [   25.716010]  do_initcall_level+0x458/0x49c
> > [   25.716462]  do_initcalls+0x60/0xa4
> > [   25.716892]  do_basic_setup+0x3c/0x68
> > [   25.717343]  kernel_init_freeable+0x170/0x2b8
> > [   25.717860]  kernel_init+0x20/0x130
> > [   25.718302]  ret_from_fork+0x10/0x18
> > [   25.718712] irq event stamp: 266621
> > [   25.719209] hardirqs last  enabled at (266621): [<ffffff80081e935c>] do_debug_exception+0x13c/0x160
> > [   25.719949] hardirqs last disabled at (266620): [<ffffff8008215a58>] kgdb_roundup_cpus+0x30/0x38
> > [   25.720675] softirqs last  enabled at (266616): [<ffffff80081e9f24>] __do_softirq+0x4e4/0x52c
> > [   25.721374] softirqs last disabled at (266609): [<ffffff8008279694>] irq_exit+0xbc/0x128
> > [   25.722050] ---[ end trace ecb2b85abf3c30a2 ]---
> > [   25.722537] possible reason: unannotated irqs-off.
> > [   25.722960] irq event stamp: 266621
> >
> > Rework code to drop the 'if (interrupts_enabled(regs))' before
> > trace_hardirqs_*() in function do_debug_exception().
> >
> > We don't know why current->hardirqs_enabled and interrupts_enabled(regs)
> > don't match.
>
> You took an IRQ from kgdbts_break_test(). This causes the CPU to mask
> interrupts, we tell trace_hardirqs_off() about this in the entry asm.
>
>  From arch/arm64/kernel/entry.S:
> | el1_irq:
> |???????kernel_entry 1
> |???????enable_da_f
> | #ifdef CONFIG_TRACE_IRQFLAGS
> |???????bl?????trace_hardirqs_off
> | #endif
> |
> |???????irq_handler
>
>
> Could you faddr2line 'el1_irq+0xa8/0x1c0'? I bet that is the
> 'enable_da_f' line which re-enables debug, just _before_ we update call
> trace_hardirqs_off.

I used objdump and found this:

ffffff800819f600 <el1_irq>:
ffffff800819f600:       a90007e0        stp     x0, x1, [sp]
...
ffffff800819f6a0:       a9105ff6        stp     x22, x23, [sp, #256]
ffffff800819f6a4:       d5034dff        msr     daifclr, #0xd
ffffff800819f6a8:       94082970        bl      ffffff80083a9c68
<trace_hardirqs_off>
ffffff800819f6ac:       d0008641        adrp    x1, ffffff8009269000
<cpu_ops+0x108>
ffffff800819f6b0:       f940e021        ldr     x1, [x1, #448]



>
> The problem is debug exceptions can jump in this gap and see an
> inconsistent trace_hardirqs_off/regs state.
>
>
> > diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> > index 7d9571f4ae3d..9afe5a7ba55b 100644
> > --- a/arch/arm64/mm/fault.c
> > +++ b/arch/arm64/mm/fault.c
> > @@ -819,11 +819,9 @@ asmlinkage int __exception do_debug_exception(unsigned long addr,
> >       int rv;
> >
> >       /*
> > -      * Tell lockdep we disabled irqs in entry.S. Do nothing if they were
> > -      * already disabled to preserve the last enabled/disabled addresses.
> > +      * Tell lockdep we disabled irqs in entry.S.
> >        */
> > -     if (interrupts_enabled(regs))
> > -             trace_hardirqs_off();
> > +     trace_hardirqs_off();
>
> Taking a debug-exception from irq-unmasked code will cause IRQs to be
> disabled. This code updates trace_hardirqs_off().
>
> But, taking a debug-exception from irq-masked code doesn't change
> anything. Making this trace_hardirqs_off() unconditional means you now
> overwrite the original location where irqs were masked.
>
>
> Would making sure debug exceptions can't see current->hardirqs_enabled
> and interrupts_enabled(regs) as having different states fix this problem?
>
> If so moving the 'enable_da_f' line in el1_irq below the #ifdef block
> should fix it.

reverting this RFC patch and did this patch that you suggested (see below) and
I couldn't see the DEBUG_LOCKS_WARN_ON.
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 039144ecbcb2..c509213b2afc 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -614,10 +614,10 @@ ENDPROC(el1_sync)
        .align  6
 el1_irq:
        kernel_entry 1
-       enable_da_f
 #ifdef CONFIG_TRACE_IRQFLAGS
        bl      trace_hardirqs_off
 #endif
+       enable_da_f

        irq_handler


Cheers,
Anders
