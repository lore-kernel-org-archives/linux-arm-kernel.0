From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 24 Jul 2017 19:34:19 +0100
Subject: [PATCH 3/4] arm64: unwind: reference pt_regs via embedded stack
 frame
In-Reply-To: <20170724175446.GE9726@leverpostej>
References: <20170724112623.26109-1-ard.biesheuvel@linaro.org>
 <20170724112623.26109-4-ard.biesheuvel@linaro.org>
 <20170724175446.GE9726@leverpostej>
Message-ID: <CAKv+Gu-esyxJOjf74uXwCqt9bgNqRjS5p9nQ-TNafVyqps4O_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 July 2017 at 18:54, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi Ard,
>
> This series looks good. I've tested the whole thing with perf top -g and
> sysrq-L.
>
> In the process of reviewing this, I spotted some other (existing) bugs
> in this area.
>
> On Mon, Jul 24, 2017 at 12:26:22PM +0100, Ard Biesheuvel wrote:
>> @@ -203,20 +193,13 @@ void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
>>               ret = unwind_frame(tsk, &frame);
>>               if (ret < 0)
>>                       break;
>> -             stack = frame.sp;
>>               if (in_exception_text(where)) {
>> -                     /*
>> -                      * If we switched to the irq_stack before calling this
>> -                      * exception handler, then the pt_regs will be on the
>> -                      * task stack. The easiest way to tell is if the large
>> -                      * pt_regs would overlap with the end of the irq_stack.
>> -                      */
>> -                     if (stack < irq_stack_ptr &&
>> -                         (stack + sizeof(struct pt_regs)) > irq_stack_ptr)
>> -                             stack = IRQ_STACK_TO_TASK_STACK(irq_stack_ptr);
>> +                     stack = frame.fp - offsetof(struct pt_regs, stackframe);
>>
>> -                     dump_mem("", "Exception stack", stack,
>> -                              stack + sizeof(struct pt_regs));
>> +                     if (on_task_stack(tsk, stack) ||
>> +                         (tsk == current && !preemptible() && on_irq_stack(stack)))
>> +                             dump_mem("", "Exception stack", stack,
>> +                                      stack + sizeof(struct pt_regs));
>
> So here, we're using information from three records (where the last
> might have been faked from the current FP + LR). We look at the previous
> frame's LR value to determine whether the current frame's fp points to a
> next frame that's associated with some regs:
>
>          +----+----------------+
>          | fp | interrupted PC | /* embedded in pt_regs */
>          +----+----------------+
>            /\
>            ||
>          +----+----------------+
> where => | fp | < entry PC >   |
>          +----+----------------+
>            /\
>            ||
>          +----+----------------+
>          | fp | where          | /* "where" is in exception text */
>          +----+----------------+
>
> Which (IIUC) has three problems, inherited from the existing approach.
>
> 1) Several C functions called from exception entry assembly are missing
>    __exception annotations. e.g. bad_mode.
>
>    So we can miss exception regs in some cases.
>
> 2) Several functions may be called either from the exception entry
>    assembly, or from other C code. e.g. do_undefinstr, and any cascaded
>    irqchip handlers.
>
>    So we can spuriously decide part of the stack is a pt_regs.
>
> 3) The entry assembly can enable exceptions before calling C code, so if
>    an exception is taken at the right time, these will eb in the
>    backtrace without a surrounding frame in the exception text.
>
>    So we can miss exception regs in some cases (distinct from (1)).
>
> ... given that, I don't think we can rely on in_exception_text(). I
> think we have to look at whether the current frame's PC/LR is in
> .entry.text.
>

I guess that's an improvement, yes. At least we won't have false
positives where a stack frame is misidentified as being on embedded in
pt_regs. But it does rely on the bl instruction being used even in
cases where we know we won't be returning, i.e., jumps to bad_mode,
do_sp_pc_abort and do_undef_instr from .entry.text

> Fixup to that effect below, tested with sysrq-L and perf top -g. Note
> that cpu_switch_to and ret_from_fork have to be moved into .text to
> avoid false positives. I also killed 'where' since it's no longer
> necessary to remember the previous frame.
>
> There's another bug -- we always dump the exception regs, even when
> skipping frames. The sqsrq-L handler tries to skip frames, so you get
> the regs for irq_entry, but without an irq_entry backtrace, which is
> confusing. That's simple enough to fix up separately, I guess.
>

Patch looks good to me (modulo the comment above). Re skipping frames,
that's a trivial one-liner fix, but needed regardless.


> ---->8----
> diff --git a/arch/arm64/include/asm/traps.h b/arch/arm64/include/asm/traps.h
> index 02e9035..4136168 100644
> --- a/arch/arm64/include/asm/traps.h
> +++ b/arch/arm64/include/asm/traps.h
> @@ -60,4 +60,9 @@ static inline int in_exception_text(unsigned long ptr)
>         return in ? : __in_irqentry_text(ptr);
>  }
>
> +static inline int in_entry_text(unsigned long ptr)
> +{
> +       return ptr >= (unsigned long)&__entry_text_start &&
> +              ptr < (unsigned long)&__entry_text_end;
> +}
>  #endif
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 32f3b24..3d25ec5 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -707,38 +707,6 @@ el0_irq_naked:
>  ENDPROC(el0_irq)
>
>  /*
> - * Register switch for AArch64. The callee-saved registers need to be saved
> - * and restored. On entry:
> - *   x0 = previous task_struct (must be preserved across the switch)
> - *   x1 = next task_struct
> - * Previous and next are guaranteed not to be the same.
> - *
> - */
> -ENTRY(cpu_switch_to)
> -       mov     x10, #THREAD_CPU_CONTEXT
> -       add     x8, x0, x10
> -       mov     x9, sp
> -       stp     x19, x20, [x8], #16             // store callee-saved registers
> -       stp     x21, x22, [x8], #16
> -       stp     x23, x24, [x8], #16
> -       stp     x25, x26, [x8], #16
> -       stp     x27, x28, [x8], #16
> -       stp     x29, x9, [x8], #16
> -       str     lr, [x8]
> -       add     x8, x1, x10
> -       ldp     x19, x20, [x8], #16             // restore callee-saved registers
> -       ldp     x21, x22, [x8], #16
> -       ldp     x23, x24, [x8], #16
> -       ldp     x25, x26, [x8], #16
> -       ldp     x27, x28, [x8], #16
> -       ldp     x29, x9, [x8], #16
> -       ldr     lr, [x8]
> -       mov     sp, x9
> -       msr     sp_el0, x1
> -       ret
> -ENDPROC(cpu_switch_to)
> -
> -/*
>   * This is the fast syscall return path.  We do as little as possible here,
>   * and this includes saving x0 back into the kernel stack.
>   */
> @@ -781,18 +749,6 @@ finish_ret_to_user:
>  ENDPROC(ret_to_user)
>
>  /*
> - * This is how we return from a fork.
> - */
> -ENTRY(ret_from_fork)
> -       bl      schedule_tail
> -       cbz     x19, 1f                         // not a kernel thread
> -       mov     x0, x20
> -       blr     x19
> -1:     get_thread_info tsk
> -       b       ret_to_user
> -ENDPROC(ret_from_fork)
> -
> -/*
>   * SVC handler.
>   */
>         .align  6
> @@ -865,3 +821,47 @@ ENTRY(sys_rt_sigreturn_wrapper)
>         mov     x0, sp
>         b       sys_rt_sigreturn
>  ENDPROC(sys_rt_sigreturn_wrapper)
> +
> +/*
> + * Register switch for AArch64. The callee-saved registers need to be saved
> + * and restored. On entry:
> + *   x0 = previous task_struct (must be preserved across the switch)
> + *   x1 = next task_struct
> + * Previous and next are guaranteed not to be the same.
> + *
> + */
> +ENTRY(cpu_switch_to)
> +       mov     x10, #THREAD_CPU_CONTEXT
> +       add     x8, x0, x10
> +       mov     x9, sp
> +       stp     x19, x20, [x8], #16             // store callee-saved registers
> +       stp     x21, x22, [x8], #16
> +       stp     x23, x24, [x8], #16
> +       stp     x25, x26, [x8], #16
> +       stp     x27, x28, [x8], #16
> +       stp     x29, x9, [x8], #16
> +       str     lr, [x8]
> +       add     x8, x1, x10
> +       ldp     x19, x20, [x8], #16             // restore callee-saved registers
> +       ldp     x21, x22, [x8], #16
> +       ldp     x23, x24, [x8], #16
> +       ldp     x25, x26, [x8], #16
> +       ldp     x27, x28, [x8], #16
> +       ldp     x29, x9, [x8], #16
> +       ldr     lr, [x8]
> +       mov     sp, x9
> +       msr     sp_el0, x1
> +       ret
> +ENDPROC(cpu_switch_to)
> +
> +/*
> + * This is how we return from a fork.
> + */
> +ENTRY(ret_from_fork)
> +       bl      schedule_tail
> +       cbz     x19, 1f                         // not a kernel thread
> +       mov     x0, x20
> +       blr     x19
> +1:     get_thread_info tsk
> +       b       ret_to_user
> +ENDPROC(ret_from_fork)
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index 9ba060b..63cbfb0 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -170,13 +170,12 @@ void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
>         skip = !!regs;
>         printk("Call trace:\n");
>         while (1) {
> -               unsigned long where = frame.pc;
>                 unsigned long stack;
>                 int ret;
>
>                 /* skip until specified stack frame */
>                 if (!skip) {
> -                       dump_backtrace_entry(where);
> +                       dump_backtrace_entry(frame.pc);
>                 } else if (frame.fp == regs->regs[29]) {
>                         skip = 0;
>                         /*
> @@ -191,7 +190,7 @@ void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
>                 ret = unwind_frame(tsk, &frame);
>                 if (ret < 0)
>                         break;
> -               if (in_exception_text(where)) {
> +               if (in_entry_text(frame.pc)) {
>                         stack = frame.fp - offsetof(struct pt_regs, stackframe);
>
>                         if (on_task_stack(tsk, stack) ||
