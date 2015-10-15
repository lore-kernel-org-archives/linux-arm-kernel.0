From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 15 Oct 2015 13:19:49 +0900
Subject: [PATCH v4 2/2] arm64: Expand the stack trace feature to support
 IRQ stack
In-Reply-To: <C0BCEB8B-2939-45AF-ACB4-BBE369B67699@gmail.com>
References: <1444231692-32722-1-git-send-email-jungseoklee85@gmail.com>
 <1444231692-32722-3-git-send-email-jungseoklee85@gmail.com>
 <5617CE26.10604@arm.com> <561E009B.3070001@linaro.org>
 <EB44D363-ACBA-48DB-B4EA-EDE1B87B99C8@gmail.com>
 <C0BCEB8B-2939-45AF-ACB4-BBE369B67699@gmail.com>
Message-ID: <561F2965.3050204@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jungseok,

On 10/14/2015 09:55 PM, Jungseok Lee wrote:
> On Oct 14, 2015, at 9:24 PM, Jungseok Lee wrote:
>> On Oct 14, 2015, at 4:13 PM, AKASHI Takahiro wrote:
>>> On 10/09/2015 11:24 PM, James Morse wrote:
>>>> Hi Jungseok,
>>>>
>>>> On 07/10/15 16:28, Jungseok Lee wrote:
>>>>> Currently, a call trace drops a process stack walk when a separate IRQ
>>>>> stack is used. It makes a call trace information much less useful when
>>>>> a system gets paniked in interrupt context.
>>>>
>>>> panicked
>>>>
>>>>> This patch addresses the issue with the following schemes:
>>>>>
>>>>>   - Store aborted stack frame data
>>>>>   - Decide whether another stack walk is needed or not via current sp
>>>>>   - Loosen the frame pointer upper bound condition
>>>>
>>>> It may be worth merging this patch with its predecessor - anyone trying to
>>>> bisect a problem could land between these two patches, and spend time
>>>> debugging the truncated call traces.
>>>>
>>>>
>>>>> diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
>>>>> index 6ea82e8..e5904a1 100644
>>>>> --- a/arch/arm64/include/asm/irq.h
>>>>> +++ b/arch/arm64/include/asm/irq.h
>>>>> @@ -2,13 +2,25 @@
>>>>> #define __ASM_IRQ_H
>>>>>
>>>>> #include <linux/irqchip/arm-gic-acpi.h>
>>>>> +#include <asm/stacktrace.h>
>>>>>
>>>>> #include <asm-generic/irq.h>
>>>>>
>>>>> struct irq_stack {
>>>>> 	void *stack;
>>>>> +	struct stackframe frame;
>>>>> };
>>>>>
>>>>> +DECLARE_PER_CPU(struct irq_stack, irq_stacks);
>>>>
>>>> Good idea, storing this in the per-cpu data makes it immune to stack
>>>> corruption.
>>>
>>> Is this the only reason that you have a dummy stack frame in per-cpu data?
>>> By placing this frame in an interrupt stack, I think, we will be able to eliminate
>>> changes in dump_stace(). and
>>>
>>>>
>>>>> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
>>>>> index 407991b..5124649 100644
>>>>> --- a/arch/arm64/kernel/stacktrace.c
>>>>> +++ b/arch/arm64/kernel/stacktrace.c
>>>>> @@ -43,7 +43,27 @@ int notrace unwind_frame(struct stackframe *frame)
>>>>> 	low  = frame->sp;
>>>>> 	high = ALIGN(low, THREAD_SIZE);
>>>>>
>>>>> -	if (fp < low || fp > high - 0x18 || fp & 0xf)
>>>>> +	/*
>>>>> +	 * A frame pointer would reach an upper bound if a prologue of the
>>>>> +	 * first function of call trace looks as follows:
>>>>> +	 *
>>>>> +	 *	stp     x29, x30, [sp,#-16]!
>>>>> +	 *	mov     x29, sp
>>>>> +	 *
>>>>> +	 * Thus, the upper bound is (top of stack - 0x20) with consideration
>>>>
>>>> The terms 'top' and 'bottom' of the stack are confusing, your 'top' appears
>>>> to be the highest address, which is used first, making it the bottom of the
>>>> stack.
>>>>
>>>> I would try to use the terms low/est and high/est, in keeping with the
>>>> variable names in use here.
>>>>
>>>>
>>>>> +	 * of a 16-byte empty space in THREAD_START_SP.
>>>>> +	 *
>>>>> +	 * The value, 0x20, however, does not cover all cases as interrupts
>>>>> +	 * are handled using a separate stack. That is, a call trace can start
>>>>> +	 * from elx_irq exception vectors. The symbols could not be promoted
>>>>> +	 * to candidates for a stack trace under the restriction, 0x20.
>>>>> +	 *
>>>>> +	 * The scenario is handled without complexity as 1) considering
>>>>> +	 * (bottom of stack + THREAD_START_SP) as a dummy frame pointer, the
>>>>> +	 * content of which is 0, and 2) allowing the case, which changes
>>>>> +	 * the value to 0x10 from 0x20.
>>>>
>>>> Where has 0x20 come from? The old value was 0x18.
>>>>
>>>> My understanding is the highest part of the stack looks like this:
>>>> high        [ off-stack ]
>>>> high - 0x08 [ left free by THREAD_START_SP ]
>>>> high - 0x10 [ left free by THREAD_START_SP ]
>>>> high - 0x18 [#1 x30 ]
>>>> high - 0x20 [#1 x29 ]
>>>>
>>>> So the condition 'fp > high - 0x18' prevents returning either 'left free'
>>>> address, or off-stack-value as a frame. Changing it to 'fp > high - 0x10'
>>>> allows the first half of that reserved area to be a valid stack frame.
>>>>
>>>> This change is breaking perf using incantations [0] and [1]:
>>>>
>>>> Before, with just patch 1/2:
>>>>                   ---__do_softirq
>>>>                      |
>>>>                      |--92.95%-- __handle_domain_irq
>>>>                      |          __irqentry_text_start
>>>>                      |          el1_irq
>>>>                      |
>>>>
>>>> After, with both patches:
>>>>                  ---__do_softirq
>>>>                     |
>>>>                     |--83.83%-- __handle_domain_irq
>>>>                     |          __irqentry_text_start
>>>>                     |          el1_irq
>>>>                     |          |
>>>>                     |          |--99.39%-- 0x400008040d00000c
>>>>                     |           --0.61%-- [...]
>>>>                     |
>>>
>>> This also shows that walk_stackframe() doesn't walk through a process stack.
>>> Now I'm trying the following hack on top of Jungseok's patch.
>>> (It doesn't traverse from an irq stack to an process stack yet. I need modify
>>> unwind_frame().)
>>
>> I've got a difference between perf and dump_backtrace() as reviewing perf call
>> chain operation. Perf relies on walk_stackframe(), but dump_backtrace() does not.
>> That is, a symbol is printed out *before* unwind_frame() call in case of perf.
>> By contrast, dump_backtrace() records a symbol *after* unwind_frame(). I think
>> perf behavior is correct since frame.pc is retrieved from a valid stack frame.
>>
>> So, the following diff is a prerequisite. It looks reasonable to remove dump_mem()
>> call since frame.sp is calculated incorrectly now. If accepted, dump_backtrace()
>> could utilize walk_stackframe(), which simplifies the code.
>>
>> ----8<----
>> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
>> index f93aae5..e18be43 100644
>> --- a/arch/arm64/kernel/traps.c
>> +++ b/arch/arm64/kernel/traps.c
>> @@ -103,12 +103,15 @@ static void dump_mem(const char *lvl, const char *str, unsigned long bottom,
>>         set_fs(fs);
>> }
>>
>> -static void dump_backtrace_entry(unsigned long where, unsigned long stack)
>> +static void dump_backtrace_entry(unsigned long where)
>> {
>> +       /*
>> +        * PC has a physical address when MMU is disabled.
>> +        */
>> +       if (!kernel_text_address(where))
>> +               where = (unsigned long)phys_to_virt(where);
>> +
>>         print_ip_sym(where);
>> -       if (in_exception_text(where))
>> -               dump_mem("", "Exception stack", stack,
>> -                        stack + sizeof(struct pt_regs), false);
>> }
>>
>> static void dump_instr(const char *lvl, struct pt_regs *regs)
>> @@ -172,12 +175,17 @@ static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
>>         pr_emerg("Call trace:\n");
>>         while (1) {
>>                 unsigned long where = frame.pc;
>> +               unsigned long stack;
>>                 int ret;
>>
>> +               dump_backtrace_entry(where);
>>                 ret = unwind_frame(&frame);
>>                 if (ret < 0)
>>                         break;
>> -               dump_backtrace_entry(where, frame.sp);
>> +               stack = frame.sp;
>> +               if (in_exception_text(where))
>> +                       dump_mem("", "Exception stack", stack,
>> +                                stack + sizeof(struct pt_regs), false);
>>         }
>> }
>> ----8<----
>>
>>> Thanks,
>>> -Takahiro AKASHI
>>> ----8<----
>>> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
>>> index 650cc05..5fbd1ea 100644
>>> --- a/arch/arm64/kernel/entry.S
>>> +++ b/arch/arm64/kernel/entry.S
>>> @@ -185,14 +185,12 @@ alternative_endif
>>> 	mov	x23, sp
>>> 	and	x23, x23, #~(THREAD_SIZE - 1)
>>> 	cmp	x20, x23			// check irq re-enterance
>>> +	mov	x19, sp
>>> 	beq	1f
>>> -	str	x29, [x19, #IRQ_FRAME_FP]
>>> -	str	x21, [x19, #IRQ_FRAME_SP]
>>> -	str	x22, [x19, #IRQ_FRAME_PC]
>>> -	mov	x29, x24
>>> -1:	mov	x19, sp
>>> -	csel	x23, x19, x24, eq		// x24 = top of irq stack
>>> -	mov	sp, x23
>>> +	mov	sp, x24				// x24 = top of irq stack
>>> +	stp	x29, x22, [sp, #-32]!
>>> +	mov	x29, sp
>>> +1:
>>> 	.endm
>>>
>>> 	/*
>>
>> Is it possible to decide which stack is used without aborted SP information?
>
> We could know which stack is used via current SP, but how could we decide
> a variable 'low' in unwind_frame() when walking a process stack?

The following patch, replacing your [PATCH 2/2], seems to work nicely,
traversing from interrupt stack to process stack. I tried James' method as well
as "echo c > /proc/sysrq-trigger."

The only issue that I have now is that dump_backtrace() does not show
correct "pt_regs" data on process stack (actually it dumps interrupt stack):

CPU1: stopping
CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D         4.3.0-rc5+ #24
Hardware name: ARM Arm Versatile Express/Arm Versatile Express, BIOS 11:37:19 Jul 16 2015
Call trace:
[<ffffffc00008a7b0>] dump_backtrace+0x0/0x19c
[<ffffffc00008a968>] show_stack+0x1c/0x28
[<ffffffc0003936d0>] dump_stack+0x88/0xc8
[<ffffffc00008fdf8>] handle_IPI+0x258/0x268
[<ffffffc000082530>] gic_handle_irq+0x88/0xa4
Exception stack(0xffffffc87b1bffa0 to 0xffffffc87b1c00c0) <== HERE
ffa0: ffffffc87b18fe30 ffffffc87b1bc000 ffffffc87b18ff50 ffffffc000086ac8
ffc0: ffffffc87b18c000 afafafafafafafaf ffffffc87b18ff50 ffffffc000086ac8
ffe0: ffffffc87b18ff50 ffffffc87b18ff50 afafafafafafafaf afafafafafafafaf
0000: 0000000000000000 ffffffffffffffff ffffffc87b195c00 0000000200000002
0020: 0000000057ac6e9d afafafafafafafaf afafafafafafafaf afafafafafafafaf
0040: afafafafafafafaf afafafafafafafaf afafafafafafafaf afafafafafafafaf
0060: afafafafafafafaf afafafafafafafaf afafafafafafafaf afafafafafafafaf
0080: afafafafafafafaf afafafafafafafaf afafafafafafafaf afafafafafafafaf
00a0: afafafafafafafaf afafafafafafafaf afafafafafafafaf afafafafafafafaf
[<ffffffc0000855e0>] el1_irq+0xa0/0x114
[<ffffffc000086ac4>] arch_cpu_idle+0x14/0x20
[<ffffffc0000fc110>] default_idle_call+0x1c/0x34
[<ffffffc0000fc464>] cpu_startup_entry+0x2cc/0x30c
[<ffffffc00008f7c4>] secondary_start_kernel+0x120/0x148
[<ffffffc0000827a8>] secondary_startup+0x8/0x20

Thanks,
-Takahiro AKASHI

----8<----
 From 1aa8d4e533d44099f69ff761acfa3c1045a00796 Mon Sep 17 00:00:00 2001
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Date: Thu, 15 Oct 2015 09:04:10 +0900
Subject: [PATCH] arm64: revamp unwind_frame for interrupt stack

This patch allows unwind_frame() to traverse from interrupt stack
to process stack correctly by having a dummy stack frame for irq_handler
created at its prologue.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
  arch/arm64/kernel/entry.S      |   22 ++++++++++++++++++++--
  arch/arm64/kernel/stacktrace.c |   14 +++++++++++++-
  2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 6d4e8c5..25cabd9 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -185,8 +185,26 @@ alternative_endif
  	and	x23, x23, #~(THREAD_SIZE - 1)
  	cmp	x20, x23			// check irq re-enterance
  	mov	x19, sp
-	csel	x23, x19, x24, eq		// x24 = top of irq stack
-	mov	sp, x23
+	beq	1f
+	mov	sp, x24				// x24 = top of irq stack
+	stp	x29, x21, [sp, #-16]!		// for sanity check
+	stp	x29, x22, [sp, #-16]!		// dummy stack frame
+	mov	x29, sp
+1:
+	/*
+	 * Layout of interrupt stack after this macro is invoked:
+	 *
+	 *     |                |
+	 *-0x20+----------------+ <= dummy stack frame
+	 *     |      fp        |    : fp on process stack
+	 *-0x18+----------------+
+	 *     |      lr        |    : return address
+	 *-0x10+----------------+
+	 *     |    fp (copy)   |    : for sanity check
+	 * -0x8+----------------+
+	 *     |      sp        |    : sp on process stack
+	 *  0x0+----------------+
+	 */
  	.endm

  	/*
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 407991b..03611a1 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -43,12 +43,24 @@ int notrace unwind_frame(struct stackframe *frame)
  	low  = frame->sp;
  	high = ALIGN(low, THREAD_SIZE);

-	if (fp < low || fp > high - 0x18 || fp & 0xf)
+	if (fp < low || fp > high - 0x20 || fp & 0xf)
  		return -EINVAL;

  	frame->sp = fp + 0x10;
  	frame->fp = *(unsigned long *)(fp);
  	/*
+	 * check whether we are going to walk trough from interrupt stack
+	 * to process stack
+	 * If the previous frame is the initial (dummy) stack frame on
+	 * interrupt stack, frame->sp now points to just below the frame
+	 * (dummy frame + 0x10).
+	 * See entry.S
+	 */
+#define STACK_LOW(addr) round_down((addr), THREAD_SIZE)
+	if ((STACK_LOW(frame->sp) != STACK_LOW(frame->fp)) &&
+			(frame->fp == *(unsigned long *)frame->sp))
+		frame->sp = *((unsigned long *)(frame->sp + 8));
+	/*
  	 * -4 here because we care about the PC at time of bl,
  	 * not where the return will go.
  	 */
-- 
1.7.9.5
