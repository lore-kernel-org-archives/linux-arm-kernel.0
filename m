From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed, 14 Oct 2015 16:13:31 +0900
Subject: [PATCH v4 2/2] arm64: Expand the stack trace feature to support
 IRQ stack
In-Reply-To: <5617CE26.10604@arm.com>
References: <1444231692-32722-1-git-send-email-jungseoklee85@gmail.com>
 <1444231692-32722-3-git-send-email-jungseoklee85@gmail.com>
 <5617CE26.10604@arm.com>
Message-ID: <561E009B.3070001@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/09/2015 11:24 PM, James Morse wrote:
> Hi Jungseok,
>
> On 07/10/15 16:28, Jungseok Lee wrote:
>> Currently, a call trace drops a process stack walk when a separate IRQ
>> stack is used. It makes a call trace information much less useful when
>> a system gets paniked in interrupt context.
>
> panicked
>
>> This patch addresses the issue with the following schemes:
>>
>>    - Store aborted stack frame data
>>    - Decide whether another stack walk is needed or not via current sp
>>    - Loosen the frame pointer upper bound condition
>
> It may be worth merging this patch with its predecessor - anyone trying to
> bisect a problem could land between these two patches, and spend time
> debugging the truncated call traces.
>
>
>> diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
>> index 6ea82e8..e5904a1 100644
>> --- a/arch/arm64/include/asm/irq.h
>> +++ b/arch/arm64/include/asm/irq.h
>> @@ -2,13 +2,25 @@
>>   #define __ASM_IRQ_H
>>
>>   #include <linux/irqchip/arm-gic-acpi.h>
>> +#include <asm/stacktrace.h>
>>
>>   #include <asm-generic/irq.h>
>>
>>   struct irq_stack {
>>   	void *stack;
>> +	struct stackframe frame;
>>   };
>>
>> +DECLARE_PER_CPU(struct irq_stack, irq_stacks);
>
> Good idea, storing this in the per-cpu data makes it immune to stack
> corruption.

Is this the only reason that you have a dummy stack frame in per-cpu data?
By placing this frame in an interrupt stack, I think, we will be able to eliminate
changes in dump_stace(). and

>
>> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
>> index 407991b..5124649 100644
>> --- a/arch/arm64/kernel/stacktrace.c
>> +++ b/arch/arm64/kernel/stacktrace.c
>> @@ -43,7 +43,27 @@ int notrace unwind_frame(struct stackframe *frame)
>>   	low  = frame->sp;
>>   	high = ALIGN(low, THREAD_SIZE);
>>
>> -	if (fp < low || fp > high - 0x18 || fp & 0xf)
>> +	/*
>> +	 * A frame pointer would reach an upper bound if a prologue of the
>> +	 * first function of call trace looks as follows:
>> +	 *
>> +	 *	stp     x29, x30, [sp,#-16]!
>> +	 *	mov     x29, sp
>> +	 *
>> +	 * Thus, the upper bound is (top of stack - 0x20) with consideration
>
> The terms 'top' and 'bottom' of the stack are confusing, your 'top' appears
> to be the highest address, which is used first, making it the bottom of the
> stack.
>
> I would try to use the terms low/est and high/est, in keeping with the
> variable names in use here.
>
>
>> +	 * of a 16-byte empty space in THREAD_START_SP.
>> +	 *
>> +	 * The value, 0x20, however, does not cover all cases as interrupts
>> +	 * are handled using a separate stack. That is, a call trace can start
>> +	 * from elx_irq exception vectors. The symbols could not be promoted
>> +	 * to candidates for a stack trace under the restriction, 0x20.
>> +	 *
>> +	 * The scenario is handled without complexity as 1) considering
>> +	 * (bottom of stack + THREAD_START_SP) as a dummy frame pointer, the
>> +	 * content of which is 0, and 2) allowing the case, which changes
>> +	 * the value to 0x10 from 0x20.
>
> Where has 0x20 come from? The old value was 0x18.
>
> My understanding is the highest part of the stack looks like this:
> high        [ off-stack ]
> high - 0x08 [ left free by THREAD_START_SP ]
> high - 0x10 [ left free by THREAD_START_SP ]
> high - 0x18 [#1 x30 ]
> high - 0x20 [#1 x29 ]
>
> So the condition 'fp > high - 0x18' prevents returning either 'left free'
> address, or off-stack-value as a frame. Changing it to 'fp > high - 0x10'
> allows the first half of that reserved area to be a valid stack frame.
>
> This change is breaking perf using incantations [0] and [1]:
>
> Before, with just patch 1/2:
>                    ---__do_softirq
>                       |
>                       |--92.95%-- __handle_domain_irq
>                       |          __irqentry_text_start
>                       |          el1_irq
>                       |
>
> After, with both patches:
>                   ---__do_softirq
>                      |
>                      |--83.83%-- __handle_domain_irq
>                      |          __irqentry_text_start
>                      |          el1_irq
>                      |          |
>                      |          |--99.39%-- 0x400008040d00000c
>                      |           --0.61%-- [...]
>                      |

This also shows that walk_stackframe() doesn't walk through a process stack.
Now I'm trying the following hack on top of Jungseok's patch.
(It doesn't traverse from an irq stack to an process stack yet. I need modify
unwind_frame().)

Thanks,
-Takahiro AKASHI
----8<----
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 650cc05..5fbd1ea 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -185,14 +185,12 @@ alternative_endif
  	mov	x23, sp
  	and	x23, x23, #~(THREAD_SIZE - 1)
  	cmp	x20, x23			// check irq re-enterance
+	mov	x19, sp
  	beq	1f
-	str	x29, [x19, #IRQ_FRAME_FP]
-	str	x21, [x19, #IRQ_FRAME_SP]
-	str	x22, [x19, #IRQ_FRAME_PC]
-	mov	x29, x24
-1:	mov	x19, sp
-	csel	x23, x19, x24, eq		// x24 = top of irq stack
-	mov	sp, x23
+	mov	sp, x24				// x24 = top of irq stack
+	stp	x29, x22, [sp, #-32]!
+	mov	x29, sp
+1:
  	.endm

  	/*
