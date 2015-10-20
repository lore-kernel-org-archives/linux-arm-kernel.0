From: james.morse@arm.com (James Morse)
Date: Tue, 20 Oct 2015 11:05:44 +0100
Subject: [PATCH v5] arm64: Introduce IRQ stack
In-Reply-To: <1445092053-12319-1-git-send-email-jungseoklee85@gmail.com>
References: <1445092053-12319-1-git-send-email-jungseoklee85@gmail.com>
Message-ID: <562611F8.2000309@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jungseok,

On 17/10/15 15:27, Jungseok Lee wrote:
> Currently, kernel context and interrupts are handled using a single
> kernel stack navigated by sp_el1. This forces a system to use 16KB
> stack, not 8KB one. This restriction makes low memory platforms
> suffer from memory pressure accompanied by performance degradation.
> 
> This patch addresses the issue as introducing a separate percpu IRQ
> stack to handle both hard and soft interrupts with two ground rules:
> 
>   - Utilize sp_el0 in EL1 context, which is not used currently
>   - Do not complicate current_thread_info calculation
> 
> It is a core concept to directly retrieve struct thread_info from
> sp_el0. This approach helps to prevent text section size from being
> increased largely as removing masking operation using THREAD_SIZE
> in tons of places.

I was worried we could end up in schedule() while on the irq stack. This
can't happen, just to save anyone else the trip down the rabbit-hole:

Q> If TIF_NEED_RESCHED is set, and we have multiple calls to el1_irq() on
the same stack - will the most-recent one to exit call el1_preempt() ->
preempt_schedule_irq()?

A> No, because the code to check if TIF_NEED_RESCHED is set, also checks
preempt_count is zero, and __do_softirq() increases by softirq_offset (via
__local_bh_disable_ip()) before re-enabling interrupts, so there is no
'gap' in recursive use of the irq_stack where preempt_count can be zero.


> ---
> I've used Cc', not Tested-by tag, from James, since there is a gap
> between v4 and v5.

Re-tested, with both 4K and 64K pages.
Tested-By: James Morse <james.morse@arm.com>

I also need to test this on top of Akashi Takahiros's series - in isolation
this patch only lets perf/dump_stack() unwind as far as el1_irq(). (It
would be good to note that dependency in this comments/changelog section -
so that they get merged in the right order!)


> 
> Changes since v4:
> - Supported 64KB page system
> - Introduced IRQ_STACK_* macro, per Catalin 
> - Rebased on top of for-next/core
> 
> Changes since v3:
> - Expanded stack trace to support IRQ stack
> - Added more comments
> 
> Changes since v2:
> - Optmised current_thread_info function as removing masking operation
>   and volatile keyword, per James and Catalin
> - Reworked irq re-enterance check logic using top-bit comparison of
>   stacks, per James
> - Added sp_el0 update in cpu_resume, per James
> - Selected HAVE_IRQ_EXIT_ON_IRQ_STACK to expose this feature explicitly
> - Added a Tested-by tag from James
> - Added comments on sp_el0 as a helper messeage
> 
> Changes since v1:
> - Rebased on top of v4.3-rc1
> - Removed Kconfig about IRQ stack, per James
> - Used PERCPU for IRQ stack, per James
> - Tried to allocate IRQ stack when CPU is about to start up, per James
> - Moved sp_el0 update into kernel_entry macro, per James
> - Dropped S_SP removal patch, per Mark and James
> 
>  arch/arm64/Kconfig                   |  1 +
>  arch/arm64/include/asm/irq.h         | 27 ++++++++++
>  arch/arm64/include/asm/thread_info.h | 10 +++-
>  arch/arm64/kernel/entry.S            | 42 ++++++++++++++--
>  arch/arm64/kernel/head.S             |  5 ++
>  arch/arm64/kernel/irq.c              | 24 +++++++++
>  arch/arm64/kernel/sleep.S            |  3 ++
>  arch/arm64/kernel/smp.c              | 13 ++++-
>  8 files changed, 116 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
> index 0916929..2755b2f 100644
> --- a/arch/arm64/include/asm/irq.h
> +++ b/arch/arm64/include/asm/irq.h
> @@ -1,14 +1,40 @@
>  #ifndef __ASM_IRQ_H
>  #define __ASM_IRQ_H
>  
> +#ifndef CONFIG_ARM64_64K_PAGES
> +#define IRQ_STACK_SIZE_ORDER	2
> +#endif
> +
> +#define IRQ_STACK_SIZE		16384
> +#define IRQ_STACK_START_SP	(IRQ_STACK_SIZE - 16)

If the plan is to have the irq stack the same size, it would be good to use
one definition in the other - just to make it obvious. e.g.
#define IRQ_STACK_SIZE	THREAD_SIZE

Are these used in assembly code? If not, they could go after the ifndef
__ASSEMBLY__.


> +
> +#ifndef __ASSEMBLY__
> +
> +#include <linux/gfp.h>
>  #include <linux/irqchip/arm-gic-acpi.h>
> +#include <linux/slab.h>
>  
>  #include <asm-generic/irq.h>
>  
> +#if IRQ_STACK_SIZE >= PAGE_SIZE
> +static inline void *__alloc_irq_stack(void)
> +{
> +       return (void *)__get_free_pages(THREADINFO_GFP | __GFP_ZERO,
> +                                       IRQ_STACK_SIZE_ORDER);

Need to include linux/thread_info.h for THREADINFO_GFP, and linux/gfp.h for
__GFP_ZERO, although, depending on CONFIG_DEBUG_STACK_USAGE THREADINFO_GFP
includes __GFP_ZERO....


> +}
> +#else
> +static inline void *__alloc_irq_stack(void)
> +{
> +       return kmalloc(IRQ_STACK_SIZE, THREADINFO_GFP | __GFP_ZERO);
> +}
> +#endif
> +

Why are these in the header file? They are only used in kernel/irq.c...


>  struct pt_regs;
>  
>  extern void set_handle_irq(void (*handle_irq)(struct pt_regs *));
>  
> +extern int alloc_irq_stack(unsigned int cpu);
> +
>  static inline void acpi_irq_init(void)
>  {
>  	/*
> @@ -21,3 +47,4 @@ static inline void acpi_irq_init(void)
>  #define acpi_irq_init acpi_irq_init
>  
>  #endif
> +#endif

[SNIP]

> diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
> index 9f17ec0..13fe8f4 100644
> --- a/arch/arm64/kernel/irq.c
> +++ b/arch/arm64/kernel/irq.c
> @@ -30,6 +30,8 @@
>  
>  unsigned long irq_err_count;
>  
> +DEFINE_PER_CPU(void *, irq_stacks);
> +
>  int arch_show_interrupts(struct seq_file *p, int prec)
>  {
>  	show_ipi_list(p, prec);
> @@ -47,9 +49,31 @@ void __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
>  	handle_arch_irq = handle_irq;
>  }
>  
> +static char boot_irq_stack[IRQ_STACK_SIZE] __aligned(IRQ_STACK_SIZE);

Is kmalloc() not available this early? Regardless:
As Catalin is happy with the Image size increase [0], this could become
something like:
> DEFINE_PER_CPU(union thread_union, irq_stack);
Which will remove the need to __alloc_irq_stack()s.

(It looks like the size-increase is lost in the size-reduction due to
smaller code in current_thread_info()! The old version I wrote didn't have
this, so it stuck-out a lot more.)


> +
>  void __init init_IRQ(void)
>  {
> +	unsigned int cpu = smp_processor_id();
> +
> +	per_cpu(irq_stacks, cpu) = boot_irq_stack + IRQ_STACK_START_SP;
> +
>  	irqchip_init();
>  	if (!handle_arch_irq)
>  		panic("No interrupt controller found.");
>  }
> +
> +int alloc_irq_stack(unsigned int cpu)
> +{
> +	void *stack;
> +
> +	if (per_cpu(irq_stacks, cpu))
> +		return 0;
> +
> +	stack = __alloc_irq_stack();
> +	if (!stack)
> +		return -ENOMEM;
> +
> +	per_cpu(irq_stacks, cpu) = stack + IRQ_STACK_START_SP;
> +
> +	return 0;
> +}



Thanks!


James


[0] https://lkml.org/lkml/2015/10/16/634
