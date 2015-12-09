From: james.morse@arm.com (James Morse)
Date: Wed, 09 Dec 2015 14:36:05 +0000
Subject: [PATCH v8 3/4] arm64: Add do_softirq_own_stack() and enable
 irq_stacks
In-Reply-To: <20151209134541.GH9303@arm.com>
References: <1449226948-14251-1-git-send-email-james.morse@arm.com>
 <1449226948-14251-4-git-send-email-james.morse@arm.com>
 <20151209134541.GH9303@arm.com>
Message-ID: <56683C55.7060305@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 09/12/15 13:45, Will Deacon wrote:
>> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
>> index fc87373d3f88..81cc5380977d 100644
>> --- a/arch/arm64/kernel/entry.S
>> +++ b/arch/arm64/kernel/entry.S
>> @@ -27,6 +27,7 @@
>>  #include <asm/cpufeature.h>
>>  #include <asm/errno.h>
>>  #include <asm/esr.h>
>> +#include <asm/irq.h>
>>  #include <asm/thread_info.h>
>>  #include <asm/unistd.h>
>>  
>> @@ -175,6 +176,42 @@ alternative_endif
>>  	mrs	\rd, sp_el0
>>  	.endm
>>  
>> +	.macro	irq_stack_entry, dummy_lr
>> +	mov	x19, sp			// preserve the original sp
>> +
>> +	adr_l	x25, irq_stack
>> +	mrs	x26, tpidr_el1
>> +	add	x25, x25, x26
> 
> Perhaps we could add a macro to assembler.h to correspond to __my_cpu_offset
> in percpu.h?

Is it worth going all the way and having a this_cpu_ptr() macro? I can't
think of any other use for reading tpidr_el1 from asm.


>> +
>> +	/*
>> +	 * Check the lowest address on irq_stack for the irq_count value,
>> +	 * incremented by do_softirq_own_stack if we have re-enabled irqs
>> +	 * while on the irq_stack.
>> +	 */
>> +	ldr	x26, [x25]
>> +	cbnz	x26, 9998f		// recursive use?
>> +
>> +	/* switch to the irq stack */
>> +	mov	x26, #IRQ_STACK_START_SP
>> +	add	x26, x25, x26
>> +	mov	sp, x26
>> +
>> +	/* Add a dummy stack frame */
>> +	stp     x29, \dummy_lr, [sp, #-16]!           // dummy stack frame
>> +	mov	x29, sp
>> +	stp     xzr, x19, [sp, #-16]!
> 
> Hmm. I'm not sure we necessarily want to push a frame when the interrupt
> was taken from userspace. The unwinder will either explode (which should
> be fixed separately) or truncate the walk anyway.

I think the exploding is due to insufficient sanity checks round the:
>???????if (frame->sp == irq_stack_ptr)
>??????????????frame->sp = IRQ_STACK_TO_TASK_STACK(irq_stack_ptr);

This is effectively allowing the maybe-bogus-fp value at the bottom of
the irq_stack to pass the bounds checking, without doing any checking of
the IRQ_STACK_TO_TASK_STACK(irq_stack_ptr) value.

An extra thing we can do here is check that both this new frame->sp and
frame->fp point into current->stack.


> If we changed this so that we only push a frame when taking an interrupt
> from EL1, could we then avoid pushing x19 as well and get the unwinder
> to walk back through the pushed fp like it usually would?

x19 is also struct pt_regs, which dump_backtrace() wants to print the
registers that were passed into gic_handle_irq(). I think this still
needs to be found at a known location on the stack.


> For the case where we've come from EL0, we want to zero fp.

That sounds better - I will see how it behaves.



Thanks!


James
