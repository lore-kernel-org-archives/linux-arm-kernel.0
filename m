From: steve.capper@linaro.org (Steve Capper)
Date: Thu, 15 Oct 2015 16:36:49 +0100
Subject: [PATCHv3 10/11] arm64: Add 16K page size support
In-Reply-To: <561FBCC9.2000106@arm.com>
References: <1444821634-1689-1-git-send-email-suzuki.poulose@arm.com>
 <1444821634-1689-11-git-send-email-suzuki.poulose@arm.com>
 <20151015140646.GJ8825@leverpostej> <561FBCC9.2000106@arm.com>
Message-ID: <CAPvkgC3c3yGYMsMZrZWwKq5CEyTDEJzr=8Pf3RGnwFR-nW07_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 October 2015 at 15:48, Suzuki K. Poulose <Suzuki.Poulose@arm.com> wrote:
> On 15/10/15 15:06, Mark Rutland wrote:
>>
>> Hi,
>>
>
> I have fixed all the nits locally. Thanks for pointing them out.
>
>>>   config FORCE_MAX_ZONEORDER
>>>         int
>>>         default "14" if (ARM64_64K_PAGES && TRANSPARENT_HUGEPAGE)
>>> +       default "12" if (ARM64_16K_PAGES && TRANSPARENT_HUGEPAGE)
>>>         default "11"
>>
>>
>> I'm a little lost here. How are these numbers derived?
>>
>
> I struggled to find the right value for 16K. Thanks to Steve Capper
> for the following explanation. I will add it as a comment.
>
> All allocations from the buddy allocator have to have compound order
> strictly less than MAX_ORDER. i.e, the maximum allocation size is
> (MAX_ORDER - 1) PAGES. To align with the transparent huge page size,
> we get :
>
>  (MAX_ORDER - 1) + PAGE_SHIFT = PMD_SHIFT
>
> Which gives us:
>
> MAX_ORDER = PAGE_SHIFT - 3 + PAGE_SHIFT - PAGE_SHIFT + 1
>           = PAGE_SHIFT - 2
>
> That raises an interesting question about the selection of the value
> for 4K. Shouldn't that be 10 instead of 11 ?
>
> Steve ?

Hi,
My understanding is that 11 is a "good minimum" value for the page
allocator with 4KB pages.
(There are references to it being 10 in 2.4 kernels but raised to 11
on 2.6 kernels?)

We need to raise the minimum when we have a 16KB or 64KB PAGE_SIZE to
be able allocate a 32MB or 512MB Transparent HugePages.

Cheers,
--
Steve

>
>>> -#ifdef CONFIG_ARM64_64K_PAGES
>>> +#if    defined(CONFIG_ARM64_64K_PAGES)
>>>   #define NR_FIX_BTMAPS         4
>>> +#elif  defined (CONFIG_ARM64_16K_PAGES)
>>> +#define NR_FIX_BTMAPS          16
>>>   #else
>>>   #define NR_FIX_BTMAPS         64
>>>   #endif
>>
>>
>> We could include <linux/sizes.h> and simplify this to:
>>
>> #define NR_FIX_BTMAPS (SZ_256K / PAGE_SIZE)
>>
>> Which works for me locally.
>
>
> Nice cleanup. I will pick that as a separate patch in the series.
>
>>
>>> diff --git a/arch/arm64/include/asm/thread_info.h
>>> b/arch/arm64/include/asm/thread_info.h
>>> index 5eac6a2..90c7ff2 100644
>>> --- a/arch/arm64/include/asm/thread_info.h
>>> +++ b/arch/arm64/include/asm/thread_info.h
>>> @@ -25,6 +25,8 @@
>>>
>>>   #ifdef CONFIG_ARM64_4K_PAGES
>>>   #define THREAD_SIZE_ORDER     2
>>> +#elif defined(CONFIG_ARM64_16K_PAGES)
>>> +#define THREAD_SIZE_ORDER      0
>>>   #endif
>>>   #define THREAD_SIZE           16384
>>
>>
>> The above looks correct.
>>
>> As an open/general question, why do both THREAD_SIZE_ORDER and
>> THREAD_SIZE exist? One really should be defined in terms of the other.
>
>
> I think its mainly for choosing the mechanism for stack allocation. If it
> is a multiple of a page, you allocate a page. If not, uses a kmem_cache.
>
>
>>>   #define id_aa64mmfr0_tgran_shift      ID_AA64MMFR0_TGRAN4_SHIFT
>>>   #define id_aa64mmfr0_tgran_on         ID_AA64MMFR0_TGRAN4_ON
>>
>>
>> I assume you'll s/ON/SUPPORTED/ per comments in another thread.
>>
>
> Yes
>
> Thanks
> Suzuki
>
