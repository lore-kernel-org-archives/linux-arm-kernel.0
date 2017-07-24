From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 24 Jul 2017 20:09:08 +0100
Subject: [PATCH 3/4] arm64: unwind: reference pt_regs via embedded stack
 frame
In-Reply-To: <CAKv+Gu-esyxJOjf74uXwCqt9bgNqRjS5p9nQ-TNafVyqps4O_Q@mail.gmail.com>
References: <20170724112623.26109-1-ard.biesheuvel@linaro.org>
 <20170724112623.26109-4-ard.biesheuvel@linaro.org>
 <20170724175446.GE9726@leverpostej>
 <CAKv+Gu-esyxJOjf74uXwCqt9bgNqRjS5p9nQ-TNafVyqps4O_Q@mail.gmail.com>
Message-ID: <CAKv+Gu_Xcdrn7rKc3F-e2QmUpjMUVhx-Qdrgn8NHZ1h2G+=YOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 July 2017 at 19:34, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 24 July 2017 at 18:54, Mark Rutland <mark.rutland@arm.com> wrote:
>> Hi Ard,
>>
>> This series looks good. I've tested the whole thing with perf top -g and
>> sysrq-L.
>>
>> In the process of reviewing this, I spotted some other (existing) bugs
>> in this area.
>>
>> On Mon, Jul 24, 2017 at 12:26:22PM +0100, Ard Biesheuvel wrote:
>>> @@ -203,20 +193,13 @@ void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
>>>               ret = unwind_frame(tsk, &frame);
>>>               if (ret < 0)
>>>                       break;
>>> -             stack = frame.sp;
>>>               if (in_exception_text(where)) {
>>> -                     /*
>>> -                      * If we switched to the irq_stack before calling this
>>> -                      * exception handler, then the pt_regs will be on the
>>> -                      * task stack. The easiest way to tell is if the large
>>> -                      * pt_regs would overlap with the end of the irq_stack.
>>> -                      */
>>> -                     if (stack < irq_stack_ptr &&
>>> -                         (stack + sizeof(struct pt_regs)) > irq_stack_ptr)
>>> -                             stack = IRQ_STACK_TO_TASK_STACK(irq_stack_ptr);
>>> +                     stack = frame.fp - offsetof(struct pt_regs, stackframe);
>>>
>>> -                     dump_mem("", "Exception stack", stack,
>>> -                              stack + sizeof(struct pt_regs));
>>> +                     if (on_task_stack(tsk, stack) ||
>>> +                         (tsk == current && !preemptible() && on_irq_stack(stack)))
>>> +                             dump_mem("", "Exception stack", stack,
>>> +                                      stack + sizeof(struct pt_regs));
>>
>> So here, we're using information from three records (where the last
>> might have been faked from the current FP + LR). We look at the previous
>> frame's LR value to determine whether the current frame's fp points to a
>> next frame that's associated with some regs:
>>
>>          +----+----------------+
>>          | fp | interrupted PC | /* embedded in pt_regs */
>>          +----+----------------+
>>            /\
>>            ||
>>          +----+----------------+
>> where => | fp | < entry PC >   |
>>          +----+----------------+
>>            /\
>>            ||
>>          +----+----------------+
>>          | fp | where          | /* "where" is in exception text */
>>          +----+----------------+
>>
>> Which (IIUC) has three problems, inherited from the existing approach.
>>
>> 1) Several C functions called from exception entry assembly are missing
>>    __exception annotations. e.g. bad_mode.
>>
>>    So we can miss exception regs in some cases.
>>
>> 2) Several functions may be called either from the exception entry
>>    assembly, or from other C code. e.g. do_undefinstr, and any cascaded
>>    irqchip handlers.
>>
>>    So we can spuriously decide part of the stack is a pt_regs.
>>
>> 3) The entry assembly can enable exceptions before calling C code, so if
>>    an exception is taken at the right time, these will eb in the
>>    backtrace without a surrounding frame in the exception text.
>>
>>    So we can miss exception regs in some cases (distinct from (1)).
>>
>> ... given that, I don't think we can rely on in_exception_text(). I
>> think we have to look at whether the current frame's PC/LR is in
>> .entry.text.
>>
>
> I guess that's an improvement, yes. At least we won't have false
> positives where a stack frame is misidentified as being on embedded in
> pt_regs. But it does rely on the bl instruction being used even in
> cases where we know we won't be returning, i.e., jumps to bad_mode,
> do_sp_pc_abort and do_undef_instr from .entry.text
>

I guess we could do something along the lines of

"""
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 45947b36f1ff..37f67c2080dc 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -60,6 +60,22 @@
 #endif
        .endm

+       .macro          b_e, target, b=b
+       .pushsection    ".rodata.entrycalls", "a", @progbits
+       .align          2
+       .long           6767f - .
+       .popsection
+6767:  \b              \target
+       .endm
+
+       .macro          bl_e, target
+       b_e             \target, bl
+       .endm
+
+       .macro          blr_e, target
+       b_e             \target, blr
+       .endm
+
 /*
  * Bad Abort numbers
  *-----------------
@@ -352,7 +368,7 @@ tsk .req    x28             // current thread_info
        ldr_l   x1, handle_arch_irq
        mov     x0, sp
        irq_stack_entry
-       blr     x1
+       blr_e   x1
        irq_stack_exit
        .endm

@@ -381,7 +397,7 @@ __bad_stack:
        mov     x0, sp

        /* Time to die */
-       bl      handle_bad_stack
+       bl_e    handle_bad_stack
        nop                             // ensure lr points somewhere sane
 ENDPROC(__bad_stack)
 #endif /* CONFIG_VMAP_STACK */
@@ -429,7 +445,7 @@ END(vectors)
        mov     x0, sp
        mov     x1, #\reason
        mrs     x2, esr_el1
-       b       bad_mode
+       b_e     bad_mode
        .endm

 el0_sync_invalid:
"""

etc to explicitly record the places where we call out of the entry
code with a pt_regs struct on the top of the stack.

Then, we can use

static bool is_entry_call(unsigned long pc)
{
    extern s32 __entrycalls_start[], __entrycalls_end[];
    s32 *p;

    for (p = __entrycalls_start; p < __entrycalls_end; p++)
        if ((unsigned long)p + *p == pc - 4)
            return true;
    return false;
}

to identify values of frame.pc that coincide with such calls.
