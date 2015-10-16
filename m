From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Fri, 16 Oct 2015 22:01:20 +0900
Subject: [PATCH v4 2/2] arm64: Expand the stack trace feature to support
 IRQ stack
In-Reply-To: <561FCD59.1090600@arm.com>
References: <1444231692-32722-1-git-send-email-jungseoklee85@gmail.com>
 <1444231692-32722-3-git-send-email-jungseoklee85@gmail.com>
 <5617CE26.10604@arm.com> <07A53E87-C562-48D1-86DF-A373EAAA73F9@gmail.com>
 <561BE111.7@arm.com> <3CAA206D-3A3A-49A9-BDAD-4206D6F9BAA8@gmail.com>
 <561CE454.7080201@arm.com> <04D64B22-8EF5-400E-A7F0-1CD0AB48184D@gmail.com>
 <B6AB90B9-3AA9-413A-B357-137710E89C7C@gmail.com> <561FCD59.1090600@arm.com>
Message-ID: <6E0DDC4D-9A97-4EAE-868C-B1271F02D3E0@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Oct 16, 2015, at 12:59 AM, James Morse wrote:

Hi James,

> On 14/10/15 13:12, Jungseok Lee wrote:
>> On Oct 14, 2015, at 12:00 AM, Jungseok Lee wrote:
>>> On Oct 13, 2015, at 8:00 PM, James Morse wrote:
>>>> On 12/10/15 23:13, Jungseok Lee wrote:
>>>>> On Oct 13, 2015, at 1:34 AM, James Morse wrote:
>>>>>> Having two kmem_caches for 16K stacks on a 64K page system may be wasteful
>>>>>> (especially for systems with few cpus)?
>>>>> 
>>>>> This would be a single concern. To address this issue, I drop the 'static'
>>>>> keyword in thread_info_cache. Please refer to the below hunk.
>>>> 
>>>> Its only a problem on systems with 64K pages, which don't have a multiple
>>>> of 4 cpus. I suspect if you turn on 64K pages, you have many cores with
>>>> plenty of memory?
>>> 
>>> Yes, the problem 'two kmem_caches' comes from only 64K page system.
>>> 
>>> I don't get the statement 'which don't have a multiple of 4 cpus'.
>>> Could you point out what I am missing?
>> 
>> You're talking about sl{a|u}b allocator behavior. If so, I got what you meant.
> 
> Yes,
> With Nx4 cpus, the (currently) 16K irq stacks take up Nx64K - a nice
> multiple of pages, so no wasted memory.
> 
> 
>>>> If this has been made a published symbol, it should go in a header file.
>>> 
>>> Sure.
>> 
>> I had the wrong impression that there is a room under include/linux/*.
> 
> Yes, I see there isn't anywhere obvious to put it...
> 
> 
>> IMO, this is architectural option whether arch relies on thread_info_cache or not.
>> In other words, it would be clear to put this extern under arch/*/include/asm/*.
> 
> Its up to the arch whether or not to define
> CONFIG_ARCH_THREAD_INFO_ALLOCATOR. In the case where it hasn't defined it,
> and THREAD_SIZE >= PAGE_SIZE, your change is exposing thread_info_cache on
> all architectures, so it ought go in a header file accessible to all
> architectures.
> 
> Something like this, (only build-tested!):
> =========%<=========
> --- a/include/linux/thread_info.h
> +++ b/include/linux/thread_info.h
> @@ -10,6 +10,8 @@
> #include <linux/types.h>
> #include <linux/bug.h>
> 
> +#include <asm/page.h>
> +

As reviewing arch codes, it seems not to cover all architecture..

> struct timespec;
> struct compat_timespec;
> 
> @@ -145,6 +147,12 @@ static inline bool test_and_clear_restore_sigmask(void)
> #error "no set_restore_sigmask() provided and default one won't work"
> #endif
> 
> +#ifndef CONFIG_ARCH_THREAD_INFO_ALLOCATOR
> +#if THREAD_SIZE >= PAGE_SIZE
> +extern struct kmem_cache *thread_info_cache;
> +#endif /* THREAD_SIZE >= PAGE_SIZE */
> +#endif /* CONFIG_ARCH_THREAD_INFO_ALLOCATOR */
> +
> #endif /* __KERNEL__ */
> 
> #endif /* _LINUX_THREAD_INFO_H */
> =========%<=========
> Quite ugly!
> 
> My concern is there could be push-back from the maintainer of
> kernel/fork.c, saying "define CONFIG_ARCH_THREAD_INFO_ALLOCATOR if the
> generic code isn't what you need", and push-back from the arm64 maintainers
> about copy-pasting that chunk into arch/arm64.... both of which are fair,
> hence my initial version created a second kmem_cache.

Same concern. I believe now is the time to get feedbacks from maintainers.
It will help us to decide the next step.

I will do re-spin soon!

Best Regards
Jungseok Lee
