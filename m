From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 10 Jun 2013 11:29:30 +0200
Subject: [PATCH] cpuidle: fix ARCH_NEEDS_CPU_IDLE_COUPLED dependency
 warning
In-Reply-To: <CAMbhsRQkiz2Wtsfi6rFcw0vXZM5uFbeuJD+3f4+R+637LCAS5A@mail.gmail.com>
References: <1370626856-2876-1-git-send-email-daniel.lezcano@linaro.org>
 <51B21D65.3040604@ti.com> <201306072121.58719.arnd@arndb.de>
 <CAMbhsRQkiz2Wtsfi6rFcw0vXZM5uFbeuJD+3f4+R+637LCAS5A@mail.gmail.com>
Message-ID: <51B59C7A.1050401@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/10/2013 02:38 AM, Colin Cross wrote:
> On Fri, Jun 7, 2013 at 9:21 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> On Friday 07 June 2013, Santosh Shilimkar wrote:
>>>> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
>>>> index f49cd51..831e89e 100644
>>>> --- a/arch/arm/mach-omap2/Kconfig
>>>> +++ b/arch/arm/mach-omap2/Kconfig
>>>> @@ -83,7 +83,7 @@ config ARCH_OMAP4
>>>>       depends on ARCH_OMAP2PLUS
>>>>       depends on ARCH_MULTI_V7
>>>>       select ARCH_HAS_OPP
>>>> -     select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP
>>>> +     select ARCH_NEEDS_CPU_IDLE_COUPLED if (SMP && CPU_IDLE)
>>>
>>> I remember Colin mentioning about above dependency is taken care
>>> already in design [1]
>>
>> It's a matter of how it gets represented in Kconfig. Right now
>> the ARCH_NEEDS_CPU_IDLE_COUPLED symbol has a dependency on CPU_IDLE,
>> so we cannot select it if CPU_IDLE is not set (or get a build time
>> warning).
>>
>> I originally suggested removing the dependency, but Daniel preferred
>> to leave it there as an explicit dependency so it is required to
>> do this change instead.
> 
> ARCH_NEEDS_CPU_IDLE_COUPLED should never have been moved inside "if
> CPU_IDLE".  It was designed to be outside the CPU_IDLE dependency so
> archs could select it without having to know about its dependencies.
> Just move it back outside if CPU_IDLE in drivers/cpuidle/Kconfig and
> you won't have to mess with every arch that uses it.  If CPU_IDLE=n
> none if it will get compiled, so there is no need for the extra
> dependency.

I don't really like implicit dependencies and IMO showing them in the
Kconfig makes the life easier for someone who wants to understand what
gets compiled or not when reading the code. Even if that means to modify
a couple of Kconfig.

It is a preference and thus I don't have a strong opinion on that, so if
nobody is against I will resend a patch moving this option out of the
CPU_IDLE dep.

Thanks
  -- Daniel

-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

  * English - detected
  * English
  * French

  * English
  * French

 <javascript:void(0);>
