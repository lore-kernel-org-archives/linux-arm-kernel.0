From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Fri, 11 Sep 2015 08:30:02 +0900
Subject: [PATCH] arm64: kernel: Use a separate stack for irq interrupts.
In-Reply-To: <55F076D6.60906@arm.com>
References: <55EDA040.90208@arm.com>
 <1441636584-23174-1-git-send-email-james.morse@arm.com>
 <2409A0E9-376A-4B49-8C5F-73084843096F@gmail.com> <55EF1136.6050102@arm.com>
 <9FF0599A-395F-43EC-A2C2-0206CE0B30C2@gmail.com> <55F076D6.60906@arm.com>
Message-ID: <841CDE07-190F-45EE-AD27-73EBFB84E33D@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sep 10, 2015, at 3:13 AM, James Morse wrote:
> On 09/09/15 14:22, Jungseok Lee wrote:
>> On Sep 9, 2015, at 1:47 AM, James Morse wrote:
>>> On 08/09/15 15:54, Jungseok Lee wrote:
>>>> On Sep 7, 2015, at 11:36 PM, James Morse wrote:
>>>>> diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
>>>>> index 463fa2e7e34c..10b57a006da8 100644
>>>>> --- a/arch/arm64/kernel/irq.c
>>>>> +++ b/arch/arm64/kernel/irq.c
>>>>> @@ -26,11 +26,14 @@
>>>>> #include <linux/smp.h>
>>>>> #include <linux/init.h>
>>>>> #include <linux/irqchip.h>
>>>>> +#include <linux/percpu.h>
>>>>> #include <linux/seq_file.h>
>>>>> #include <linux/ratelimit.h>
>>>>> 
>>>>> unsigned long irq_err_count;
>>>>> 
>>>>> +DEFINE_PER_CPU(unsigned long, irq_sp) = 0;
>>>>> +
>>>>> int arch_show_interrupts(struct seq_file *p, int prec)
>>>>> {
>>>>> #ifdef CONFIG_SMP
>>>>> @@ -55,6 +58,10 @@ void __init init_IRQ(void)
>>>>> 	irqchip_init();
>>>>> 	if (!handle_arch_irq)
>>>>> 		panic("No interrupt controller found.");
>>>>> +
>>>>> +	/* Allocate an irq stack for the boot cpu */
>>>>> +	if (alloc_irq_stack(smp_processor_id()))
>>>>> +		panic("Failed to allocate irq stack for boot cpu.");
>>>>> }
>>>>> 
>>>>> #ifdef CONFIG_HOTPLUG_CPU
>>>>> @@ -117,3 +124,48 @@ void migrate_irqs(void)
>>>>> 	local_irq_restore(flags);
>>>>> }
>>>>> #endif /* CONFIG_HOTPLUG_CPU */
>>>>> +
>>>>> +/* Allocate an irq_stack for a cpu that is about to be brought up. */
>>>>> +int alloc_irq_stack(unsigned int cpu)
>>>>> +{
>>>>> +	struct page *irq_stack_page;
>>>>> +	union thread_union *irq_stack;
>>>>> +
>>>>> +	/* reuse stack allocated previously */
>>>>> +	if (per_cpu(irq_sp, cpu))
>>>>> +		return 0;
>>>> 
>>>> I'd like to avoid even this simple check since CPU hotplug could be heavily
>>>> used for power management.
>>> 
>>> I don't think its a problem:
>>> __cpu_up() contains a call to wait_for_completion_timeout() (which could
>>> eventually end up in the scheduler), so I don't think it could ever be on a
>>> 'really hot' path.
>>> 
>>> For really frequent hotplug-like power management, cpu_suspend() makes use
>>> of firmware support to power-off cores - from what I can see it doesn't use
>>> __cpu_up().
>> 
>> In case of some platforms, CPU hotplug is triggered via sysfs for power management
>> based on user data. What is advantage of putting stack allocation into this path?
> 
> It will only happen for CPUs that are brought up.
> 
> 
>> IRQ stack allocation is an critical one-shot operation. So, there would be no issue
>> to give this work to a booting core. 
> 
> I agree, but:
> 
> From include/linux/cpumask.h:
>> *  If HOTPLUG is enabled, then cpu_possible_mask is forced to have
>> *  all NR_CPUS bits set, otherwise it is just the set of CPUs that
>> *  ACPI reports present at boot.
> 
> (This doesn't seem to happen with DT - but might with ACPI.)
> 
> NR_CPUs could be much bigger than the number of cpus the system ever has.
> Allocating a stack for every possible cpu would waste memory. It is better
> to do it just-in-time, when we know the memory will be used.

Frankly I've not considered that kind of system, but this feature should be
supported smoothly for that system. I will move the allocation logic in v2.

> This already happens for the per-cpu idle task, (please check I traced
> these through correctly!)
> _cpu_up()
>  idle_thread_get()
>    init_idle()
>      fork_idle()
>        copy_process()
>          dup_task_struct()
>            alloc_task_struct_node()
>            alloc_thread_info_node()
>            arch_dup_task_struct()
> 
> So plenty of memory-allocation occurs during _cpu_up(), idle_init() checks
> whether the idle task has already been created.

Got it.

Thanks for the feedbacks.

Best Regards
Jungseok Lee
