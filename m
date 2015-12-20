From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Sun, 20 Dec 2015 20:07:46 +0900
Subject: [PATCH v8 9/4] arm64: remove irq_count and do_softirq_own_stack()
In-Reply-To: <1450454507-8907-1-git-send-email-james.morse@arm.com>
References: <1449226948-14251-1-git-send-email-james.morse@arm.com>
 <1450454507-8907-1-git-send-email-james.morse@arm.com>
Message-ID: <68E0E2C7-A4C2-45C2-95C5-842FA807F918@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Dec 19, 2015, at 1:01 AM, James Morse wrote:

Hi James,

> sysrq_handle_reboot() re-enables interrupts while on the irq stack. The
> irq_stack implementation wrongly assumed this would only ever happen
> via the softirq path, allowing it to update irq_count late, in
> do_softirq_own_stack().
> 
> This means if an irq occurs in sysrq_handle_reboot(), during
> emergency_restart() the stack will be corrupted, as irq_count wasn't
> updated.
> 
> Lose the optimisation, and instead of moving the adding/subtracting of
> irq_count into irq_stack_entry/irq_stack_exit, remove it, and compare
> sp_el0 (struct task_info) with sp & ~(THREAD_SIZE - 1). This tells us if

Nit: s/task_info/thread_info

> we are on a task stack, if so, we can safely switch to the irq stack.
> Finally, remove do_softirq_own_stack(), we don't need it anymore.
> 
> Reported-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> arch/arm64/include/asm/irq.h |  2 --
> arch/arm64/kernel/entry.S    | 17 +++++++++--------
> arch/arm64/kernel/irq.c      | 38 +-------------------------------------
> 3 files changed, 10 insertions(+), 47 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
> index 3bece4379bd9..b77197d941fc 100644
> --- a/arch/arm64/include/asm/irq.h
> +++ b/arch/arm64/include/asm/irq.h
> @@ -11,8 +11,6 @@
> #include <asm-generic/irq.h>
> #include <asm/thread_info.h>
> 
> -#define __ARCH_HAS_DO_SOFTIRQ
> -
> struct pt_regs;
> 
> DECLARE_PER_CPU(unsigned long [IRQ_STACK_SIZE/sizeof(long)], irq_stack);
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 0667fb7d8bb1..6745a9041f99 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -181,19 +181,20 @@ alternative_endif
> 	.macro	irq_stack_entry
> 	mov	x19, sp			// preserve the original sp
> 
> -	this_cpu_ptr irq_stack, x25, x26
> -
> 	/*
> -	 * Check the lowest address on irq_stack for the irq_count value,
> -	 * incremented by do_softirq_own_stack if we have re-enabled irqs
> -	 * while on the irq_stack.
> +	 * Compare sp and sp_el0, if the top ~(THREAD_SIZE - 1) bits match,
> +	 * we are on a task stack, and should switch to the irq stack.
> 	 */
> -	ldr	x26, [x25]
> -	cbnz	x26, 9998f		// recursive use?
> +	mrs	x26, sp_el0		// already masked

Nit: How about using 'get_thread_info x26'?

> +	and	x25, x19, #~(THREAD_SIZE - 1)
> +	cmp	x25, x26
> +	b.ne	9998f
> 
> -	/* switch to the irq stack */
> +	this_cpu_ptr irq_stack, x25, x26
> 	mov	x26, #IRQ_STACK_START_SP
> 	add	x26, x25, x26
> +
> +	/* switch to the irq stack */
> 	mov	sp, x26
> 
> 	/*
> diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
> index ff7ebb710e51..2386b26c0712 100644
> --- a/arch/arm64/kernel/irq.c
> +++ b/arch/arm64/kernel/irq.c
> @@ -25,24 +25,14 @@
> #include <linux/irq.h>
> #include <linux/smp.h>
> #include <linux/init.h>
> -#include <linux/interrupt.h>
> #include <linux/irqchip.h>
> #include <linux/seq_file.h>
> 
> unsigned long irq_err_count;
> 
> -/*
> - * irq stack only needs to be 16 byte aligned - not IRQ_STACK_SIZE aligned.
> - * irq_stack[0] is used as irq_count, a non-zero value indicates the stack
> - * is in use, and el?_irq() shouldn't switch to it. This is used to detect
> - * recursive use of the irq_stack, it is lazily updated by
> - * do_softirq_own_stack(), which is called on the irq_stack, before
> - * re-enabling interrupts to process softirqs.
> - */
> +/* irq stack only needs to be 16 byte aligned - not IRQ_STACK_SIZE aligned. */
> DEFINE_PER_CPU(unsigned long [IRQ_STACK_SIZE/sizeof(long)], irq_stack) __aligned(16);
> 
> -#define IRQ_COUNT()	(*per_cpu(irq_stack, smp_processor_id()))
> -
> int arch_show_interrupts(struct seq_file *p, int prec)
> {
> 	show_ipi_list(p, prec);
> @@ -66,29 +56,3 @@ void __init init_IRQ(void)
> 	if (!handle_arch_irq)
> 		panic("No interrupt controller found.");
> }
> -
> -/*
> - * do_softirq_own_stack() is called from irq_exit() before __do_softirq()
> - * re-enables interrupts, at which point we may re-enter el?_irq(). We
> - * increase irq_count here so that el1_irq() knows that it is already on the
> - * irq stack.
> - *
> - * Called with interrupts disabled, so we don't worry about moving cpu, or
> - * being interrupted while modifying irq_count.
> - *
> - * This function doesn't actually switch stack.
> - */
> -void do_softirq_own_stack(void)
> -{
> -	int cpu = smp_processor_id();
> -
> -	WARN_ON_ONCE(!irqs_disabled());
> -
> -	if (on_irq_stack(current_stack_pointer, cpu)) {
> -		IRQ_COUNT()++;
> -		__do_softirq();
> -		IRQ_COUNT()--;
> -	} else {
> -		__do_softirq();
> -	}
> -}

The approach, removal of the counter, looks good to me from a high level point
of view although I have not played with this change seriously yet.

If I spot something strange, I will report it.

Best Regards
Jungseok Lee
