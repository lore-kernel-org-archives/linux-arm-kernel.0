From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 27 Nov 2015 15:09:14 +0000
Subject: [PATCH v7 3/3] arm64: Add do_softirq_own_stack() and enable
 irq_stacks
In-Reply-To: <1447698128-8490-4-git-send-email-james.morse@arm.com>
References: <1447698128-8490-1-git-send-email-james.morse@arm.com>
 <1447698128-8490-4-git-send-email-james.morse@arm.com>
Message-ID: <20151127150914.GC25499@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2015 at 06:22:07PM +0000, James Morse wrote:
>  DECLARE_PER_CPU(unsigned long, irq_stack_ptr);
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 1971da98dfad..45473838fe21 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -175,6 +175,34 @@ alternative_endif
>  	mrs	\rd, sp_el0
>  	.endm
>  
> +	.macro	irq_stack_entry
> +	mov	x19, sp			// preserve the original sp
> +	adr_l   x25, irq_count		// incremented by do_softirq_own_stack()
> +	mrs	x26, tpidr_el1
> +	add	x25, x25, x26
> +	ldr	w25, [x25]
> +	cbnz	w25, 1f			// recursive use?
> +
> +	/* switch to the irq stack */
> +	adr_l	x25, irq_stack_ptr
> +	add	x25, x25, x26
> +	ldr	x25, [x25]
> +	mov	sp, x25

Do we need a separate pointer for irq_stack? Could we not just use the
address of the irq_stack array directly since it's statically declared
already and just add IRQ_STACK_START_SP?

> +	/* Add a dummy stack frame */
> +	stp     x29, x22, [sp, #-16]!           // dummy stack frame
> +	mov	x29, sp
> +	stp     xzr, x19, [sp, #-16]!
> +1:
> +	.endm

Just a nitpick, use some high number for the label (e.g. 9998) or use a
named one, in case we ever get similar labels around the macro use.

> diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
> index da752bb18bfb..838541cf5e5d 100644
> --- a/arch/arm64/kernel/irq.c
> +++ b/arch/arm64/kernel/irq.c
> @@ -25,6 +25,7 @@
>  #include <linux/irq.h>
>  #include <linux/smp.h>
>  #include <linux/init.h>
> +#include <linux/interrupt.h>
>  #include <linux/irqchip.h>
>  #include <linux/seq_file.h>
>  
> @@ -34,6 +35,13 @@ unsigned long irq_err_count;
>  DEFINE_PER_CPU(unsigned long [IRQ_STACK_SIZE/sizeof(long)], irq_stack) __aligned(16);
>  DEFINE_PER_CPU(unsigned long, irq_stack_ptr);
>  
> +/*
> + * irq_count is used to detect recursive use of the irq_stack, it is lazily
> + * incremented very late, by do_softirq_own_stack(), which is called on the
> + * irq_stack, before re-enabling interrupts to process softirqs.
> + */
> +DEFINE_PER_CPU(unsigned int, irq_count);

We can keep irq_count in a union in the IRQ stack (at the other end of
the array), the code may be marginally shorter (you avoid another
adrp+adr+add vs an "and" with the IRQ_STACK_SIZE

Either that or, if we still need irq_stack_ptr, put both in the same
struct to avoid two adrp+adr+add for retrieving the address.

> +void do_softirq_own_stack(void)
> +{
> +	int cpu = smp_processor_id();
> +
> +	WARN_ON_ONCE(!irqs_disabled());
> +
> +	if (on_irq_stack(current_stack_pointer, cpu)) {
> +		per_cpu(irq_count, cpu)++;
> +		__do_softirq();
> +		per_cpu(irq_count, cpu)--;
> +	} else {
> +		__do_softirq();
> +	}
> +}

If we go for softirq always on the IRQ stack, we should move this to
assembly and reuse the irq_stack_entry/exit macros above.

-- 
Catalin
