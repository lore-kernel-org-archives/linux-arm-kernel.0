From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Wed, 14 Oct 2015 21:12:14 +0900
Subject: [PATCH v4 2/2] arm64: Expand the stack trace feature to support
 IRQ stack
In-Reply-To: <04D64B22-8EF5-400E-A7F0-1CD0AB48184D@gmail.com>
References: <1444231692-32722-1-git-send-email-jungseoklee85@gmail.com>
 <1444231692-32722-3-git-send-email-jungseoklee85@gmail.com>
 <5617CE26.10604@arm.com> <07A53E87-C562-48D1-86DF-A373EAAA73F9@gmail.com>
 <561BE111.7@arm.com> <3CAA206D-3A3A-49A9-BDAD-4206D6F9BAA8@gmail.com>
 <561CE454.7080201@arm.com> <04D64B22-8EF5-400E-A7F0-1CD0AB48184D@gmail.com>
Message-ID: <B6AB90B9-3AA9-413A-B357-137710E89C7C@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Oct 14, 2015, at 12:00 AM, Jungseok Lee wrote:
> On Oct 13, 2015, at 8:00 PM, James Morse wrote:
>> Hi Jungseok,
> 
> Hi James,
> 
>> On 12/10/15 23:13, Jungseok Lee wrote:
>>> On Oct 13, 2015, at 1:34 AM, James Morse wrote:
>>>> Having two kmem_caches for 16K stacks on a 64K page system may be wasteful
>>>> (especially for systems with few cpus)?
>>> 
>>> This would be a single concern. To address this issue, I drop the 'static'
>>> keyword in thread_info_cache. Please refer to the below hunk.
>> 
>> Its only a problem on systems with 64K pages, which don't have a multiple
>> of 4 cpus. I suspect if you turn on 64K pages, you have many cores with
>> plenty of memory?
> 
> Yes, the problem 'two kmem_caches' comes from only 64K page system.
> 
> I don't get the statement 'which don't have a multiple of 4 cpus'.
> Could you point out what I am missing?

You're talking about sl{a|u}b allocator behavior. If so, I got what you meant.

> Since I don't have platforms which have many cores and huge memory,
> I cannot play with this series on them.
> 
>>>> The alternative is to defining CONFIG_ARCH_THREAD_INFO_ALLOCATOR and
>>>> allocate all stack memory from arch code. (Largely copied code, prevents
>>>> irq stacks being a different size, and nothing uses that define today!)
>>>> 
>>>> 
>>>> Thoughts?
>>> 
>>> Almost same story I've been testing.
>>> 
>>> I'm aligned with yours Regarding CONFIG_ARCH_THREAD_INFO_ALLOCATOR.
>>> 
>>> Another approach I've tried is the following data structure, but it's not
>>> a good fit for this case due to __per_cpu_offset which is page-size aligned,
>>> not thread-size.
>>> 
>>> struct irq_stack {
>>> 	char stack[THREAD_SIZE];
>>> 	char *highest;
>>> } __aligned(THREAD_SIZE);
>>> 
>>> DEFINE_PER_CPU(struct irq_stack, irq_stacks);
>> 
>> Yes, x86 does this - but it increases the Image size by 16K, as that space
>> could have some initialisation values. This isn't a problem on x86 as
>> no-one uses the uncompressed image.
>> 
>> I would avoid this approach due to the bloat!
>> 
>>> 
>>> ----8<-----
>>> diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
>>> index 6ea82e8..d3619b3 100644
>>> --- a/arch/arm64/include/asm/irq.h
>>> +++ b/arch/arm64/include/asm/irq.h
>>> @@ -1,7 +1,9 @@
>>> #ifndef __ASM_IRQ_H
>>> #define __ASM_IRQ_H
>>> 
>>> +#include <linux/gfp.h>
>>> #include <linux/irqchip/arm-gic-acpi.h>
>>> +#include <linux/slab.h>
>>> 
>>> #include <asm-generic/irq.h>
>>> 
>>> @@ -9,6 +11,21 @@ struct irq_stack {
>>>       void *stack;
>>> };
>>> 
>>> +#if THREAD_SIZE >= PAGE_SIZE
>>> +static inline void *__alloc_irq_stack(void)
>>> +{
>>> +       return (void *)__get_free_pages(THREADINFO_GFP | __GFP_ZERO,
>>> +                                       THREAD_SIZE_ORDER);
>>> +}
>>> +#else
>>> +extern struct kmem_cache *thread_info_cache;
>> 
>> If this has been made a published symbol, it should go in a header file.
> 
> Sure.

I had the wrong impression that there is a room under include/linux/*.

IMO, this is architectural option whether arch relies on thread_info_cache or not.
In other words, it would be clear to put this extern under arch/*/include/asm/*.

Thoughts?

Best Regards
Jungseok Lee
