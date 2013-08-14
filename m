From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 14 Aug 2013 11:23:26 +0200
Subject: [PATCH v3 1/6] ARM/ARM64: arch_timer: add macros for bits in
 control register
In-Reply-To: <6071c584a32b1a5f80923818a477a719@www.loen.fr>
References: <1374492082-13686-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376414984-14182-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376414984-14182-2-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <520B44CF.6040403@linaro.org> <6071c584a32b1a5f80923818a477a719@www.loen.fr>
Message-ID: <520B4C8E.1010808@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/14/2013 11:03 AM, Marc Zyngier wrote:
> Hi Daniel,

[ ... ]

>>> --- a/arch/arm64/include/asm/arch_timer.h
>>> +++ b/arch/arm64/include/asm/arch_timer.h
>>> @@ -101,12 +101,16 @@ static inline void
>>> arch_counter_set_user_access(void)
>>>  {
>>>      u32 cntkctl;
>>>
>>> -    /* Disable user access to the timers and the physical counter. */
>>>      asm volatile("mrs    %0, cntkctl_el1" : "=r" (cntkctl));
>>> -    cntkctl &= ~((3 << 8) | (1 << 0));
>>>
>>> -    /* Enable user access to the virtual counter and frequency. */
>>> -    cntkctl |= (1 << 1);
>>> +    /* Disable user access to the timers and the physical counter. */
>>> +    cntkctl &= ~(ARCH_TIMER_USR_PT_ACCESS_EN
>>> +            | ARCH_TIMER_USR_VT_ACCESS_EN
>>> +            | ARCH_TIMER_USR_PCT_ACCESS_EN);
>>> +
>>> +    /* Enable user access to the virtual counter. */
>>> +    cntkctl |= ARCH_TIMER_USR_VCT_ACCESS_EN;
>>> +
>>>      asm volatile("msr    cntkctl_el1, %0" : : "r" (cntkctl));
>>>  }
>>
>> Before doing those changes, I suggest you kill include/asm/arch_timer.h
>> header file and move the functions directly in the arm_arch_timer.c as
>> they are only used by it.
> 
> How do you suggest to proceed? Having #ifdefs in arm_arch_timer.c to
> cope with the inline assembly functions present in both arm and arm64
> include files? Doesn't seem much of a progress to me...

I understand, this is arguable.

-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
