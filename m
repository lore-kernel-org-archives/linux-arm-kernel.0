From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Tue, 8 Sep 2015 00:48:42 +0900
Subject: [PATCH] arm64: kernel: Use a separate stack for irq interrupts.
In-Reply-To: <1441636584-23174-1-git-send-email-james.morse@arm.com>
References: <55EDA040.90208@arm.com>
 <1441636584-23174-1-git-send-email-james.morse@arm.com>
Message-ID: <400272B6-0733-456F-95C9-9C72C597CEB5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sep 7, 2015, at 11:36 PM, James Morse wrote:

Hi James,

> Having to handle interrupts on top of an existing kernel stack means the
> kernel stack must be large enough to accomodate both the maximum kernel
> usage, and the maximum irq handler usage. Switching to a different stack
> when processing irqs allows us to make the stack size smaller.
> 
> Maximum kernel stack usage (running ltp and generating usb+ethernet
> interrupts) was 7256 bytes. With this patch, the same workload gives
> a maximum stack usage of 5816 bytes.

I'd like to know how to measure the max stack depth.
AFAIK, a stack tracer on ftrace does not work well. Did you dump a stack
region and find or track down an untouched region? 

I will leave comments after reading and playing with this change carefully.

Best Regards
Jungseok Lee

> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> arch/arm64/include/asm/irq.h         | 12 +++++++++
> arch/arm64/include/asm/thread_info.h |  8 ++++--
> arch/arm64/kernel/entry.S            | 33 ++++++++++++++++++++---
> arch/arm64/kernel/irq.c              | 52 ++++++++++++++++++++++++++++++++++++
> arch/arm64/kernel/smp.c              |  4 +++
> arch/arm64/kernel/stacktrace.c       |  4 ++-
> 6 files changed, 107 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
> index bbb251b14746..050d4196c736 100644
> --- a/arch/arm64/include/asm/irq.h
> +++ b/arch/arm64/include/asm/irq.h
> @@ -2,14 +2,20 @@
> #define __ASM_IRQ_H
> 
> #include <linux/irqchip/arm-gic-acpi.h>
> +#include <linux/percpu.h>
> 
> #include <asm-generic/irq.h>
> +#include <asm/thread_info.h>
> +
> +DECLARE_PER_CPU(unsigned long, irq_sp);
> 
> struct pt_regs;
> 
> extern void migrate_irqs(void);
> extern void set_handle_irq(void (*handle_irq)(struct pt_regs *));
> 
> +extern int alloc_irq_stack(unsigned int cpu);
> +
> static inline void acpi_irq_init(void)
> {
> 	/*
> @@ -21,4 +27,10 @@ static inline void acpi_irq_init(void)
> }
> #define acpi_irq_init acpi_irq_init
> 
> +static inline bool is_irq_stack(unsigned long sp)
> +{
> +	struct thread_info *ti = get_thread_info(sp);
> +	return (get_thread_info(per_cpu(irq_sp, ti->cpu)) == ti);
> +}
> +
> #endif
> diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
> index dcd06d18a42a..b906254fc400 100644
> --- a/arch/arm64/include/asm/thread_info.h
> +++ b/arch/arm64/include/asm/thread_info.h
> @@ -69,12 +69,16 @@ register unsigned long current_stack_pointer asm ("sp");
> /*
>  * how to get the thread information struct from C
>  */
> +static inline struct thread_info *get_thread_info(unsigned long sp)
> +{
> +	return (struct thread_info *)(sp & ~(THREAD_SIZE - 1));
> +}
> +
> static inline struct thread_info *current_thread_info(void) __attribute_const__;
> 
> static inline struct thread_info *current_thread_info(void)
> {
> -	return (struct thread_info *)
> -		(current_stack_pointer & ~(THREAD_SIZE - 1));
> +	return get_thread_info(current_stack_pointer);
> }
> 
> #define thread_saved_pc(tsk)	\
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index e16351819fed..d42371f3f5a1 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -190,10 +190,37 @@ tsk	.req	x28		// current thread_info
>  * Interrupt handling.
>  */
> 	.macro	irq_handler
> -	adrp	x1, handle_arch_irq
> -	ldr	x1, [x1, #:lo12:handle_arch_irq]
> -	mov	x0, sp
> +	mrs	x21, tpidr_el1
> +	adr_l	x20, irq_sp
> +	add	x20, x20, x21
> +
> +	ldr	x21, [x20]
> +	mov	x20, sp
> +
> +	mov	x0, x21
> +	mov	x1, x20
> +	bl	irq_copy_thread_info
> +
> +	/* test for recursive use of irq_sp */
> +	cbz	w0, 1f
> +	mrs	x30, elr_el1
> +	mov	sp, x21
> +
> +	/*
> +	 * Create a fake stack frame to bump unwind_frame() onto the original
> +	 * stack. This relies on x29 not being clobbered by kernel_entry().
> +	 */
> +	push	x29, x30
> +
> +1:	ldr_l	x1, handle_arch_irq
> +	mov     x0, x20
> 	blr	x1
> +
> +	mov	x0, x20
> +	mov	x1, x21
> +	bl	irq_copy_thread_info
> +	mov	sp, x20
> +
> 	.endm
> 
> 	.text
> diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
> index 463fa2e7e34c..10b57a006da8 100644
> --- a/arch/arm64/kernel/irq.c
> +++ b/arch/arm64/kernel/irq.c
> @@ -26,11 +26,14 @@
> #include <linux/smp.h>
> #include <linux/init.h>
> #include <linux/irqchip.h>
> +#include <linux/percpu.h>
> #include <linux/seq_file.h>
> #include <linux/ratelimit.h>
> 
> unsigned long irq_err_count;
> 
> +DEFINE_PER_CPU(unsigned long, irq_sp) = 0;
> +
> int arch_show_interrupts(struct seq_file *p, int prec)
> {
> #ifdef CONFIG_SMP
> @@ -55,6 +58,10 @@ void __init init_IRQ(void)
> 	irqchip_init();
> 	if (!handle_arch_irq)
> 		panic("No interrupt controller found.");
> +
> +	/* Allocate an irq stack for the boot cpu */
> +	if (alloc_irq_stack(smp_processor_id()))
> +		panic("Failed to allocate irq stack for boot cpu.");
> }
> 
> #ifdef CONFIG_HOTPLUG_CPU
> @@ -117,3 +124,48 @@ void migrate_irqs(void)
> 	local_irq_restore(flags);
> }
> #endif /* CONFIG_HOTPLUG_CPU */
> +
> +/* Allocate an irq_stack for a cpu that is about to be brought up. */
> +int alloc_irq_stack(unsigned int cpu)
> +{
> +	struct page *irq_stack_page;
> +	union thread_union *irq_stack;
> +
> +	/* reuse stack allocated previously */
> +	if (per_cpu(irq_sp, cpu))
> +		return 0;
> +
> +	irq_stack_page = alloc_kmem_pages(THREADINFO_GFP, THREAD_SIZE_ORDER);
> +	if (!irq_stack_page) {
> +		pr_crit("CPU%u: failed to allocate irq stack for cpu %u\n",
> +			smp_processor_id(), cpu);
> +		return -ENOMEM;
> +	}
> +	irq_stack = page_address(irq_stack_page);
> +
> +	per_cpu(irq_sp, cpu) = (unsigned long)irq_stack->stack
> +			       + THREAD_START_SP;
> +
> +	return 0;
> +}
> +
> +/*
> + * Copy struct thread_info between two stacks, and update current->stack.
> + * This is used when moving to the irq exception stack.
> + * Changing current->stack is necessary so that non-arch thread_info writers
> + * don't use the new thread_info->task->stack to find the old thread_info when
> + * setting flags like TIF_NEED_RESCHED...
> + */
> +asmlinkage int irq_copy_thread_info(unsigned long dst_sp, unsigned long src_sp)
> +{
> +	struct thread_info *src = get_thread_info(src_sp);
> +	struct thread_info *dst = get_thread_info(dst_sp);
> +
> +	if (dst == src)
> +		return 0;
> +
> +	*dst = *src;
> +	current->stack = dst;
> +
> +	return 1;
> +}
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 50fb4696654e..5283dc5629e4 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -89,6 +89,10 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
> {
> 	int ret;
> 
> +	ret = alloc_irq_stack(cpu);
> +	if (ret)
> +		return ret;
> +
> 	/*
> 	 * We need to tell the secondary core where to find its stack and the
> 	 * page tables.
> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
> index 407991bf79f5..3d6d5b45aa4b 100644
> --- a/arch/arm64/kernel/stacktrace.c
> +++ b/arch/arm64/kernel/stacktrace.c
> @@ -20,6 +20,7 @@
> #include <linux/sched.h>
> #include <linux/stacktrace.h>
> 
> +#include <asm/irq.h>
> #include <asm/stacktrace.h>
> 
> /*
> @@ -43,7 +44,8 @@ int notrace unwind_frame(struct stackframe *frame)
> 	low  = frame->sp;
> 	high = ALIGN(low, THREAD_SIZE);
> 
> -	if (fp < low || fp > high - 0x18 || fp & 0xf)
> +	if ((fp < low || fp > high - 0x18 || fp & 0xf) &&
> +	    !is_irq_stack(frame->sp))
> 		return -EINVAL;
> 
> 	frame->sp = fp + 0x10;
> -- 
> 2.1.4
> 
