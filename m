From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Sat, 19 Sep 2015 17:20:41 +0900
Subject: [PATCH v2] arm64: Introduce IRQ stack
In-Reply-To: <55FC15CA.7040009@arm.com>
References: <1442155337-7020-1-git-send-email-jungseoklee85@gmail.com>
 <55FC15CA.7040009@arm.com>
Message-ID: <53179176-3FA2-4CA9-A28B-4DD08037DD3E@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sep 18, 2015, at 10:46 PM, James Morse wrote:
> Hi Jungseok Lee,

Hi James Morse,

> I gave this a go on a Juno board, while generating usb/network interrupts:
> 
> Tested-by: James Morse <james.morse@arm.com>

Thanks a lot!

> On 13/09/15 15:42, Jungseok Lee wrote:
>> Currently, kernel context and interrupts are handled using a single
>> kernel stack navigated by sp_el1. This forces many systems to use
>> 16KB stack, not 8KB one. Low memory platforms naturally suffer from
>> memory pressure accompanied by performance degradation.
>> 
>> This patch addresses the issue as introducing a separate percpu IRQ
>> stack to handle both hard and soft interrupts with two ground rules:
>> 
>>  - Utilize sp_el0 in EL1 context, which is not used currently
>>  - Do not complicate current_thread_info calculation
>> 
>> It is a core concept to trace struct thread_info using sp_el0 instead
>> of sp_el1. This approach helps arm64 align with other architectures
>> regarding object_is_on_stack() without additional complexity.
> 
> I think you are missing a 'mov <reg>, sp; msr sp_el0, <reg>' in
> kernel/sleep.S:cpu_resume():175. This code finds the saved stack pointer
> from 'sleep_save_sp', and is called when the cpu wakes up from suspend.

Make sense.

> It didn't show up in testing, because the wake-up is always under the idle
> task, which evidently doesn't call current_thread_info() after wake-up.

I've never seen any issues under suspend/resume scenario yet, but it is
logically reasonable to update sp_el0 in resume context.

> 
>> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
>> index 4306c93..c156540 100644
>> --- a/arch/arm64/kernel/entry.S
>> +++ b/arch/arm64/kernel/entry.S
>> @@ -88,7 +88,7 @@
>> 
>> 	.if	\el == 0
>> 	mrs	x21, sp_el0
>> -	get_thread_info tsk			// Ensure MDSCR_EL1.SS is clear,
>> +	get_thread_info \el, tsk		// Ensure MDSCR_EL1.SS is clear,
>> 	ldr	x19, [tsk, #TI_FLAGS]		// since we can unmask debug
>> 	disable_step_tsk x19, x20		// exceptions when scheduling.
>> 	.else
>> @@ -105,6 +105,8 @@
>> 	.if	\el == 0
>> 	mvn	x21, xzr
>> 	str	x21, [sp, #S_SYSCALLNO]
>> +	mov	x25, sp
>> +	msr	sp_el0, x25
>> 	.endif
>> 
>> 	/*
>> @@ -163,9 +165,45 @@ alternative_endif
>> 	eret					// return to kernel
>> 	.endm
>> 
>> -	.macro	get_thread_info, rd
>> +	.macro	get_thread_info, el, rd
>> +	.if	\el == 0
> 
> Why does \el matter here?
> If \el==0, we interrupted an el0 thread, and set sp_el0 in kernel_entry()
> to the el1 stack.
> If \el==1, we interrupted an el1 thread, didn't overwrite its sp_el0, so
> sp_el0 & ~(THREAD_SIZE-1) will give us the struct thread_info of the
> interrupted task.
> 
> So either way, sp_el0 is correct?

You're right.

For the next version, I've written this macro with a single line as directly
accessing thread_info via sp_el0.

> 
>> 	mov	\rd, sp
>> -	and	\rd, \rd, #~(THREAD_SIZE - 1)	// top of stack
>> +	.else
>> +	mrs	\rd, sp_el0
>> +	.endif
>> +	and	\rd, \rd, #~(THREAD_SIZE - 1)	// bottom of thread stack
>> +	.endm
>> +
>> +	.macro	get_irq_stack
>> +	adr_l	x21, irq_stacks
>> +	mrs	x22, tpidr_el1
>> +	add	x21, x21, x22
>> +	.endm
>> +
>> +	.macro	irq_stack_entry
>> +	get_irq_stack
>> +	ldr	w23, [x21, #IRQ_COUNT]
>> +	cbnz	w23, 1f				// check irq recursion
>> +	mov	x23, sp
>> +	str	x23, [x21, #IRQ_THREAD_SP]
>> +	ldr	x23, [x21, #IRQ_STACK]
>> +	mov	sp, x23
>> +	mov	x23, xzr
>> +1:	add	w23, w23, #1
>> +	str	w23, [x21, #IRQ_COUNT]
> 
> A (largely untested) example for the 'compare the high-order bits' way of
> doing this:
> 
> 	.macro	irq_stack_entry
> 	get_irq_stack
> 	ldr	x22, [x21, #IRQ_STACK]
> 	and	x23, x22, #~(THREAD_SIZE -1)
> 	mov	x24, sp
> 	and	x24, x24, #~(THREAD_SIZE -1)
> 	cmp	x23, x24	// irq_recursion?
> 	mov	x24, sp
> 	csel	x23, x24, x22, eq
> 	mov	sp, x23
> 	.endm
> 
> 	/* preserve x24 between irq_stack_entry/irq_stack_exit */
> 
> 	.macro	irq_stack_exit
> 	mov	sp, x24
> 	.endm
> 
> This would let you remove IRQ_COUNT and IRQ_THREAD_SP, and avoid the two
> stores and a conditional-branch in irq_stack_entry/irq_stack_exit.
> 
> Thoughts?

Great idea. Thanks to this change, about 20 lines can be removed.
It works well on my board till now.

> 
>> +	.endm
>> +
>> +	.macro	irq_stack_exit
>> +	get_irq_stack
>> +	ldr	w23, [x21, #IRQ_COUNT]
>> +	sub	w23, w23, #1
>> +	cbnz	w23, 1f				// check irq recursion
>> +	mov	x23, sp
>> +	str	x23, [x21, #IRQ_STACK]
>> +	ldr	x23, [x21, #IRQ_THREAD_SP]
>> +	mov	sp, x23
>> +	mov	x23, xzr
>> +1:	str	w23, [x21, #IRQ_COUNT]
>> 	.endm
>> 
>> /*
>> @@ -183,10 +221,11 @@ tsk	.req	x28		// current thread_info
>>  * Interrupt handling.
>>  */
>> 	.macro	irq_handler
>> -	adrp	x1, handle_arch_irq
>> -	ldr	x1, [x1, #:lo12:handle_arch_irq]
>> +	ldr_l	x1, handle_arch_irq
>> 	mov	x0, sp
>> +	irq_stack_entry
>> 	blr	x1
>> +	irq_stack_exit
>> 	.endm
>> 
>> 	.text
>> @@ -361,7 +400,7 @@ el1_irq:
>> 	irq_handler
>> 
>> #ifdef CONFIG_PREEMPT
>> -	get_thread_info tsk
>> +	get_thread_info 1, tsk
>> 	ldr	w24, [tsk, #TI_PREEMPT]		// get preempt count
>> 	cbnz	w24, 1f				// preempt count != 0
>> 	ldr	x0, [tsk, #TI_FLAGS]		// get flags
>> @@ -597,6 +636,7 @@ ENTRY(cpu_switch_to)
>> 	ldp	x29, x9, [x8], #16
>> 	ldr	lr, [x8]
>> 	mov	sp, x9
>> +	msr	sp_el0, x9
>> 	ret
>> ENDPROC(cpu_switch_to)
>> 
>> @@ -655,7 +695,7 @@ ENTRY(ret_from_fork)
>> 	cbz	x19, 1f				// not a kernel thread
>> 	mov	x0, x20
>> 	blr	x19
>> -1:	get_thread_info tsk
>> +1:	get_thread_info 1, tsk
>> 	b	ret_to_user
>> ENDPROC(ret_from_fork)
>> 
>> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
>> index a055be6..cb13290 100644
>> --- a/arch/arm64/kernel/head.S
>> +++ b/arch/arm64/kernel/head.S
>> @@ -441,6 +441,8 @@ __mmap_switched:
>> 	b	1b
>> 2:
>> 	adr_l	sp, initial_sp, x4
>> +	mov	x4, sp
> 
> There should probably a comment explaining why sp_el0 is being set (for the
> changes outside entry.S). Something like:
> 
> 	msr	sp_el0, x4		// stash struct thread_info

Agreed. I will add comments on sp_el0 across some relevant changes.

Thanks for comments!

Best Regards
Jungseok Lee
