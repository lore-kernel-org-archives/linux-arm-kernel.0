From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Sun, 29 Nov 2015 01:04:50 +0900
Subject: [PATCH v7 3/3] arm64: Add do_softirq_own_stack() and enable
 irq_stacks
In-Reply-To: <20151127173810.GE25499@e104818-lin.cambridge.arm.com>
References: <1447698128-8490-1-git-send-email-james.morse@arm.com>
 <1447698128-8490-4-git-send-email-james.morse@arm.com>
 <8F6484A9-18B9-4A81-B58D-528D81BC196D@gmail.com>
 <20151127114715.GA25499@e104818-lin.cambridge.arm.com>
 <61333097-CD88-472C-8E59-A8FF0DBC1DC7@gmail.com>
 <20151127173810.GE25499@e104818-lin.cambridge.arm.com>
Message-ID: <F539DEEE-59AC-4084-8A0D-B259AB4B8633@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Nov 28, 2015, at 2:38 AM, Catalin Marinas wrote:
> On Sat, Nov 28, 2015 at 12:37:31AM +0900, Jungseok Lee wrote:
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 9ac16a4..a12f015 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -70,6 +70,7 @@ config ARM64
>> 	select HAVE_FUNCTION_GRAPH_TRACER
>> 	select HAVE_GENERIC_DMA_COHERENT
>> 	select HAVE_HW_BREAKPOINT if PERF_EVENTS
>> +	select HAVE_IRQ_EXIT_ON_IRQ_STACK
> 
> I'm not convinced about this. See below.
> 
>> 	select HAVE_MEMBLOCK
>> 	select HAVE_PATA_PLATFORM
>> 	select HAVE_PERF_EVENTS
>> diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
>> index 23eb450..d4cbae6 100644
>> --- a/arch/arm64/include/asm/irq.h
>> +++ b/arch/arm64/include/asm/irq.h
>> @@ -1,10 +1,26 @@
>> #ifndef __ASM_IRQ_H
>> #define __ASM_IRQ_H
>> 
>> +#define IRQ_STACK_SIZE		16384
> 
> 8K should be enough.

Agree.

>> +
>> +#ifndef __ASSEMBLY__
>> +
>> #include <asm-generic/irq.h>
>> 
>> +#define __ARCH_HAS_DO_SOFTIRQ
>> +
>> +struct irq_stack {
>> +	unsigned int count;
>> +	/*
>> +	 * The stack must be quad-word aligned according to '5.2.2 The stack'
>> +	 * of 'Procedure Call Standard for the ARM 64-bit Architecture'.
>> +	 */
>> +	char stack[IRQ_STACK_SIZE] __aligned(16);
>> +};
> 
> This looks fine.
> 
>> diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
>> index 25de8b2..f8b4df7 100644
>> --- a/arch/arm64/kernel/asm-offsets.c
>> +++ b/arch/arm64/kernel/asm-offsets.c
>> @@ -41,6 +41,8 @@ int main(void)
>>   BLANK();
>>   DEFINE(THREAD_CPU_CONTEXT,	offsetof(struct task_struct, thread.cpu_context));
>>   BLANK();
>> +  DEFINE(IRQ_STACK,		offsetof(struct irq_stack, stack));
>> +  BLANK();
>>   DEFINE(S_X0,			offsetof(struct pt_regs, regs[0]));
>>   DEFINE(S_X1,			offsetof(struct pt_regs, regs[1]));
>>   DEFINE(S_X2,			offsetof(struct pt_regs, regs[2]));
>> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
>> index fc87373..bc01102 100644
>> --- a/arch/arm64/kernel/entry.S
>> +++ b/arch/arm64/kernel/entry.S
>> @@ -27,9 +27,12 @@
>> #include <asm/cpufeature.h>
>> #include <asm/errno.h>
>> #include <asm/esr.h>
>> +#include <asm/irq.h>
>> #include <asm/thread_info.h>
>> #include <asm/unistd.h>
>> 
>> +#define IRQ_STACK_START_SP	(IRQ_STACK + IRQ_STACK_SIZE - 16)
>> +
>> /*
>>  * Context tracking subsystem.  Used to instrument transitions
>>  * between user and kernel mode.
>> @@ -175,6 +178,29 @@ alternative_endif
>> 	mrs	\rd, sp_el0
>> 	.endm
>> 
>> +	.macro	irq_stack_entry
>> +	adr_l	x19, irq_stacks
>> +	mrs	x20, tpidr_el1
>> +	add	x20, x19, x20
>> +	mov	x19, sp
>> +	ldr	w23, [x20]
>> +	cbnz	w23, 1f				// check irq re-entrance
>> +	mov	x24, #IRQ_STACK_START_SP
>> +	add	x24, x20, x24			// x24 = top of irq stack
>> +	mov	sp, x24
>> +1:	add	w23, w23, #1
>> +	str	w23, [x20]
>> +	.endm
>> +
>> +	/*
>> +	 * x19, x20, w23 are preserved between irq_stack_{entry|exit}.
>> +	 */
>> +	.macro	irq_stack_exit
>> +	sub	w23, w23, #1
>> +	str	w23, [x20]
>> +	mov	sp, x19
>> +	.endm
> 
> With your approach to select HAVE_IRQ_EXIT_ON_IRQ_STACK you need to
> always update the irq_count every time you enter or exit the IRQ. Since
> presumably softirqs are rarer than hardirqs, I suggest that you only
> increment/decrement irq_count via do_softirq_own_stack() and not select
> HAVE_IRQ_EXIT_ON_IRQ_STACK. The only downside is having to check whether
> SP is the IRQ stack (the irq_count) in this function before invoking
> __do_softirq() rather than calling __do_softirq() directly. But it
> doesn't look too bad.

Aha!!

I clearly understand why irq_count update in do_softirq_own_stack() is
a good approach. It would be really great to add the clause, "Since
presumably softirqs are rarer than hardirqs", to this commit message.
It explains why irq_count is updated in do_softirq_own_stack(), not elX_irq
context. IOW, I believe that it is a critical background on the design.

Now, I vote in favor of not selecting HAVE_IRQ_EXIT_ON_IRQ_STACK and this
lazy irq_count update.

>> @@ -190,10 +216,11 @@ tsk	.req	x28		// current thread_info
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
>> @@ -741,3 +768,25 @@ ENTRY(sys_rt_sigreturn_wrapper)
>> 	mov	x0, sp
>> 	b	sys_rt_sigreturn
>> ENDPROC(sys_rt_sigreturn_wrapper)
>> +
>> +/*
>> + * Softirq is handled on IRQ stack.
>> + */
>> +ENTRY(do_softirq_own_stack)
>> +	stp	x29, lr, [sp, #-96]!
>> +	stp	x19, x20, [sp, #16]
>> +	stp	x21, x22, [sp, #32]
>> +	stp	x23, x24, [sp, #48]
>> +	stp	x25, x26, [sp, #64]
>> +	stp	x27, x28, [sp, #80]
>> +	irq_stack_entry
>> +	bl	__do_softirq
>> +	irq_stack_exit
>> +	ldp	x19, x20, [sp, #16]
>> +	ldp	x21, x22, [sp, #32]
>> +	ldp	x23, x24, [sp, #48]
>> +	ldp	x25, x26, [sp, #64]
>> +	ldp	x27, x28, [sp, #80]
>> +	ldp	x29, lr, [sp], #96
>> +	ret
>> +ENDPROC(do_softirq_own_stack)
> 
> Since irq_stack_entry/exit shouldn't increment irq_count as I mentioned
> above, you can hand-code the stack switching (or maybe parametrise the
> irq_stack_* macros) to only use caller-saved registers and avoid too
> many stp/ldp, probably just one for fp/lr.

Agree. This part should be reworked under the lazy update approach.

Best Regards
Jungseok Lee
