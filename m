From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Wed, 21 Oct 2015 23:56:13 +0900
Subject: [PATCH v5] arm64: Introduce IRQ stack
In-Reply-To: <56266606.1080909@arm.com>
References: <1445092053-12319-1-git-send-email-jungseoklee85@gmail.com>
 <562611F8.2000309@arm.com> <FF5479FA-9D0C-4E17-874F-2F390F2885EB@gmail.com>
 <56266606.1080909@arm.com>
Message-ID: <C846BEE1-8E5C-4F66-B506-9C457CDDD31E@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Oct 21, 2015, at 1:04 AM, James Morse wrote:
> On 20/10/15 16:05, Jungseok Lee wrote:
>> On Oct 20, 2015, at 7:05 PM, James Morse wrote:
>>> On 17/10/15 15:27, Jungseok Lee wrote:
>>>> diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
>>>> index 9f17ec0..13fe8f4 100644
>>>> --- a/arch/arm64/kernel/irq.c
>>>> +++ b/arch/arm64/kernel/irq.c
>>>> @@ -30,6 +30,8 @@
>>>> 
>>>> unsigned long irq_err_count;
>>>> 
>>>> +DEFINE_PER_CPU(void *, irq_stacks);
>>>> +
>>>> int arch_show_interrupts(struct seq_file *p, int prec)
>>>> {
>>>> 	show_ipi_list(p, prec);
>>>> @@ -47,9 +49,31 @@ void __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
>>>> 	handle_arch_irq = handle_irq;
>>>> }
>>>> 
>>>> +static char boot_irq_stack[IRQ_STACK_SIZE] __aligned(IRQ_STACK_SIZE);
>>> 
>>> Is kmalloc() not available this early? Regardless:
>>> As Catalin is happy with the Image size increase [0], this could become
>>> something like:
>>>> DEFINE_PER_CPU(union thread_union, irq_stack);
>>> Which will remove the need to __alloc_irq_stack()s.
>> 
>> We cannot rely on static allocation using percpu in case of 4KB page system.
>> Since ARM64 utilizes generic setup_per_cpu_areas(), tpidr_el1 is PAGE_SIZE
>> aligned. That is, IRQ stack is allocated with PAGE_SIZE alignment for secondary
>> cores. However, the top-bit method works well under the assumption that IRQ
>> stack is IRQ_STACK_SIZE aligned. It leads to IRQ re-entrance check failure.
> 
> Yikes! That is nasty... well caught!
> 
> Now I understand why you had the per-cpu version #ifdef'd in your example
> hunk earlier!
> 
> Do we need the irq stack to be aligned like this? It was originally for the
> old implementation of current_thread_info(), which this patch changes.

Not necessarily, but the alignment restriction helps us to simplify IRQ
re-entrance check and linkage between a process stack and IRQ one.

> If its just the re-entrance check that needs the alignment, maybe the
> irq_count approach is better (but count late not early), and drop the
> alignment requirement on interrupt stacks. We know re-entrant irqs will
> keep sp_el0, so the new current_thread_info() still works.

Hmm.. I cannot image how simple this logic is without implementation detail.
We should consider the number of memory access such as pointer read under
count based approach. In this context, I guess a static allocation is better
than dynamic one.

Best Regards
Jungseok Lee

> I think Catalin's comment is to count like x86 (64 bit version) does in
> arch/x86/entry/entry_64.S:do_softirq_own_stack, and treat this as a
> re-entrance flag in entry.S.
> 
> task stacks still need to be aligned, as when user space is interrupted, we
> have a kernel stack, and no idea where its struct task_struct is, unless we
> know it was originally THREAD_SIZE aligned.
> 
> 
> 
> James
