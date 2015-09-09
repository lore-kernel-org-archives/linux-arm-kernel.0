From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Wed, 9 Sep 2015 22:22:23 +0900
Subject: [PATCH] arm64: kernel: Use a separate stack for irq interrupts.
In-Reply-To: <55EF1136.6050102@arm.com>
References: <55EDA040.90208@arm.com>
 <1441636584-23174-1-git-send-email-james.morse@arm.com>
 <2409A0E9-376A-4B49-8C5F-73084843096F@gmail.com> <55EF1136.6050102@arm.com>
Message-ID: <9FF0599A-395F-43EC-A2C2-0206CE0B30C2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sep 9, 2015, at 1:47 AM, James Morse wrote:
> On 08/09/15 15:54, Jungseok Lee wrote:
>> On Sep 7, 2015, at 11:36 PM, James Morse wrote:
>> 
>> Hi James,
>> 
>>> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
>>> index e16351819fed..d42371f3f5a1 100644
>>> --- a/arch/arm64/kernel/entry.S
>>> +++ b/arch/arm64/kernel/entry.S
>>> @@ -190,10 +190,37 @@ tsk	.req	x28		// current thread_info
>>> * Interrupt handling.
>>> */
>>> 	.macro	irq_handler
>>> -	adrp	x1, handle_arch_irq
>>> -	ldr	x1, [x1, #:lo12:handle_arch_irq]
>>> -	mov	x0, sp
>>> +	mrs	x21, tpidr_el1
>>> +	adr_l	x20, irq_sp
>>> +	add	x20, x20, x21
>>> +
>>> +	ldr	x21, [x20]
>>> +	mov	x20, sp
>>> +
>>> +	mov	x0, x21
>>> +	mov	x1, x20
>>> +	bl	irq_copy_thread_info
>>> +
>>> +	/* test for recursive use of irq_sp */
>>> +	cbz	w0, 1f
>>> +	mrs	x30, elr_el1
>>> +	mov	sp, x21
>>> +
>>> +	/*
>>> +	 * Create a fake stack frame to bump unwind_frame() onto the original
>>> +	 * stack. This relies on x29 not being clobbered by kernel_entry().
>>> +	 */
>>> +	push	x29, x30
>> 
>> It is the most challenging item to handle a frame pointer in this context.
>> 
>> As I mentioned previously, a stack tracer on ftrace is not supported yet.
>> How about decoupling "IRQ Stack feature" from "Stack Tracer Fix"?
> 
> Yes - I discovered today this was more complicated than I thought. I will
> need to do some more reading.
> 
> 
>>> +
>>> +1:	ldr_l	x1, handle_arch_irq
>>> +	mov     x0, x20
>>> 	blr	x1
>>> +
>>> +	mov	x0, x20
>>> +	mov	x1, x21
>>> +	bl	irq_copy_thread_info
>>> +	mov	sp, x20
>>> +
>>> 	.endm
>>> 
>>> 	.text
>>> diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
>>> index 463fa2e7e34c..10b57a006da8 100644
>>> --- a/arch/arm64/kernel/irq.c
>>> +++ b/arch/arm64/kernel/irq.c
>>> @@ -26,11 +26,14 @@
>>> #include <linux/smp.h>
>>> #include <linux/init.h>
>>> #include <linux/irqchip.h>
>>> +#include <linux/percpu.h>
>>> #include <linux/seq_file.h>
>>> #include <linux/ratelimit.h>
>>> 
>>> unsigned long irq_err_count;
>>> 
>>> +DEFINE_PER_CPU(unsigned long, irq_sp) = 0;
>>> +
>>> int arch_show_interrupts(struct seq_file *p, int prec)
>>> {
>>> #ifdef CONFIG_SMP
>>> @@ -55,6 +58,10 @@ void __init init_IRQ(void)
>>> 	irqchip_init();
>>> 	if (!handle_arch_irq)
>>> 		panic("No interrupt controller found.");
>>> +
>>> +	/* Allocate an irq stack for the boot cpu */
>>> +	if (alloc_irq_stack(smp_processor_id()))
>>> +		panic("Failed to allocate irq stack for boot cpu.");
>>> }
>>> 
>>> #ifdef CONFIG_HOTPLUG_CPU
>>> @@ -117,3 +124,48 @@ void migrate_irqs(void)
>>> 	local_irq_restore(flags);
>>> }
>>> #endif /* CONFIG_HOTPLUG_CPU */
>>> +
>>> +/* Allocate an irq_stack for a cpu that is about to be brought up. */
>>> +int alloc_irq_stack(unsigned int cpu)
>>> +{
>>> +	struct page *irq_stack_page;
>>> +	union thread_union *irq_stack;
>>> +
>>> +	/* reuse stack allocated previously */
>>> +	if (per_cpu(irq_sp, cpu))
>>> +		return 0;
>> 
>> I'd like to avoid even this simple check since CPU hotplug could be heavily
>> used for power management.
> 
> I don't think its a problem:
> __cpu_up() contains a call to wait_for_completion_timeout() (which could
> eventually end up in the scheduler), so I don't think it could ever be on a
> 'really hot' path.
> 
> For really frequent hotplug-like power management, cpu_suspend() makes use
> of firmware support to power-off cores - from what I can see it doesn't use
> __cpu_up().

In case of some platforms, CPU hotplug is triggered via sysfs for power management
based on user data. What is advantage of putting stack allocation into this path?

IRQ stack allocation is an critical one-shot operation. So, there would be no issue
to give this work to a booting core. 

>>> +
>>> +	irq_stack_page = alloc_kmem_pages(THREADINFO_GFP, THREAD_SIZE_ORDER);
>>> +	if (!irq_stack_page) {
>>> +		pr_crit("CPU%u: failed to allocate irq stack for cpu %u\n",
>>> +			smp_processor_id(), cpu);
>>> +		return -ENOMEM;
>>> +	}
>>> +	irq_stack = page_address(irq_stack_page);

I forgot leaving a comment here. How about using __get_free_pages? It returns an
address instead of page. 

>>> +
>>> +	per_cpu(irq_sp, cpu) = (unsigned long)irq_stack->stack
>>> +			       + THREAD_START_SP;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +/*
>>> + * Copy struct thread_info between two stacks, and update current->stack.
>>> + * This is used when moving to the irq exception stack.
>>> + * Changing current->stack is necessary so that non-arch thread_info writers
>>> + * don't use the new thread_info->task->stack to find the old thread_info when
>>> + * setting flags like TIF_NEED_RESCHED...
>>> + */
>>> +asmlinkage int irq_copy_thread_info(unsigned long dst_sp, unsigned long src_sp)
>>> +{
>>> +	struct thread_info *src = get_thread_info(src_sp);
>>> +	struct thread_info *dst = get_thread_info(dst_sp);
>>> +
>>> +	if (dst == src)
>>> +		return 0;
>>> +
>>> +	*dst = *src;
>>> +	current->stack = dst;
>>> +
>>> +	return 1;
>>> +}
>> 
>> Although this is 32-byte memcpy, sizeof(struct thread_info), this function is called
>> twice to handle a single interrupt. Isn's it too expensive?
>> 
>> This is a major difference between my approach and this patch. I think we should get
>> some feedbacks on struct thread_info information management for v2 preparation.
> 
> Agreed.
> 
> The other difference, as Akashi Takahiro pointed out, is the behaviour of
> object_is_on_stack(). What should this return for an object on an irq stack?

0 should be returned in that case to align with x86 behavior according to check_stack()
context and the commit, 81520a1b0649d0.

Best Regards
Jungseok Lee
