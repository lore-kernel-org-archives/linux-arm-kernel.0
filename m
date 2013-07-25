From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 25 Jul 2013 11:22:47 -0700
Subject: [PATCH 4/6] ARM: locks: prefetch the destination word for write
 prior to strex
In-Reply-To: <20130725180518.GM12827@mudshark.cambridge.arm.com>
References: <1374579389-32704-1-git-send-email-will.deacon@arm.com>
 <1374579389-32704-5-git-send-email-will.deacon@arm.com>
 <alpine.LFD.2.03.1307231609170.15022@syhkavp.arg>
 <20130724111841.GD11072@mudshark.cambridge.arm.com>
 <51F160EA.6030800@codeaurora.org> <51F1626C.3050008@codeaurora.org>
 <20130725174555.GK12827@mudshark.cambridge.arm.com>
 <51F166A0.7030203@codeaurora.org>
 <20130725180518.GM12827@mudshark.cambridge.arm.com>
Message-ID: <51F16CF7.5080604@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/25/13 11:05, Will Deacon wrote:
> On Thu, Jul 25, 2013 at 06:55:44PM +0100, Stephen Boyd wrote:
>> On 07/25/13 10:45, Will Deacon wrote:
>>> On Thu, Jul 25, 2013 at 06:37:48PM +0100, Stephen Boyd wrote:
>>>> On 07/25/13 10:31, Stephen Boyd wrote:
>>>>> Maybe I'm wrong, but can't you just remove the casts and leave the
>>>>> function as static inline? const void * is pretty much telling the
>>>>> compiler to turn off type checking.
>>>>>
>>>> Oh joy. Why is rwlock's lock member marked volatile?
>>> Yeah, that was the problematic guy. However, I had to fix that anyway in
>>> this patch because otherwise the definition for prefetchw when
>>> !ARCH_HAS_PREFETCHW (which expands to __builtin_prefetch(x,1)) will explode.
>>>
>>> So, given that I've fixed the rwlocks, I think I could put prefetch and
>>> prefetchw back to static inline functions. What do you reckon?
>> It would be good to match the builtin function's signature so that we
>> don't explode in the future on ARCH_HAS_PREFETCHW configs.
> Ok, so that's basically just undoing the macroisation on top of v2 (fixup
> below).
>
> Will

Looks good to me. Thanks.

>
> --->8
>
> diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/processor.h
> index dde7ecc..dac9429 100644
> --- a/arch/arm/include/asm/processor.h
> +++ b/arch/arm/include/asm/processor.h
> @@ -109,25 +109,25 @@ unsigned long get_wchan(struct task_struct *p);
>  #if __LINUX_ARM_ARCH__ >= 5
>  
>  #define ARCH_HAS_PREFETCH
> -#define prefetch(p)                                                    \
> -({                                                                     \
> -       __asm__ __volatile__(                                           \
> -               "pld\t%a0"                                              \
> -               :: "p" (p));                                            \
> -})
> +static inline void prefetch(const void *ptr)
> +{
> +       __asm__ __volatile__(
> +               "pld\t%a0"
> +               :: "p" (ptr));
> +}
>  
>  #if __LINUX_ARM_ARCH__ >= 7 && defined(CONFIG_SMP)
>  #define ARCH_HAS_PREFETCHW
> -#define prefetchw(p)                                                   \
> -({                                                                     \
> -       __asm__ __volatile__(                                           \
> -               ".arch_extension        mp\n"                           \
> -               __ALT_SMP_ASM(                                          \
> -                       WASM(pldw)              "\t%a0",                \
> -                       WASM(pld)               "\t%a0"                 \
> -               )                                                       \
> -               :: "p" (p));                                            \
> -})
> +static inline void prefetchw(const void *ptr)
> +{
> +       __asm__ __volatile__(
> +               ".arch_extension        mp\n"
> +               __ALT_SMP_ASM(
> +                       WASM(pldw)              "\t%a0",
> +                       WASM(pld)               "\t%a0"
> +               )
> +               :: "p" (ptr));
> +}
>  #endif
>  #endif
>


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
