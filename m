From: cyril@ti.com (Cyril Chemparathy)
Date: Tue, 11 Sep 2012 13:28:37 -0400
Subject: [PATCH] ARM: avoid undef on ARCH_HAS_READ_CURRENT_TIMER
In-Reply-To: <20120911172018.GG32234@mudshark.cambridge.arm.com>
References: <1347380341-28145-1-git-send-email-cyril@ti.com>
 <20120911162522.GE32234@mudshark.cambridge.arm.com> <504F6DFB.5030208@ti.com>
 <20120911172018.GG32234@mudshark.cambridge.arm.com>
Message-ID: <504F74C5.2020805@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/11/2012 1:20 PM, Will Deacon wrote:
> On Tue, Sep 11, 2012 at 05:59:39PM +0100, Cyril Chemparathy wrote:
>> On 9/11/2012 12:25 PM, Will Deacon wrote:
>>> On Tue, Sep 11, 2012 at 05:19:00PM +0100, Cyril Chemparathy wrote:
>>>> With the inclusion of asm-generic/timex.h, the ARM arch timer implementation
>>>> breaks on build.  This is because asm/arch_timer.h now defines
>>>> ARCH_HAS_READ_CURRENT_TIMER, only to have this macro undefined by the
>>>> subsequent inclusion of asm-generic/timex.h.
>>>>
>>>> This patch fixes the problem in asm/timex.h by including asm-generic/timex.h
>>>> early, and by defining get_cycles even earlier.
>>>>
>>>> This patch has been tested against linux-next-20120910, both with and without
>>>> arch timer support.
>>>
>>> Is this still a problem with 7530/1 ("delay: add registration mechanism for
>>> delay timer sources") applied?
>>>
>>> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7530/1
>>>
>>
>> Excellent.
>>
>> This conflicts with linux-next-20120910, and needs an added include of
>> <asm/delay.h> in timex.h.  With that in place, it works for me.
>
> Like below?
>
> If that's the fix, then I may as well respin 7530/1 given that it hasn't yet
> been merged.
>
> Will
>
> --->8
>
> diff --cc arch/arm/include/asm/timex.h
> index 5e71172,9acc135..0000000
> --- a/arch/arm/include/asm/timex.h
> +++ b/arch/arm/include/asm/timex.h
> @@@ -12,13 -12,9 +12,11 @@@
>    #ifndef _ASMARM_TIMEX_H
>    #define _ASMARM_TIMEX_H
>
> - #include <asm/arch_timer.h>
>    #include <mach/timex.h>
>
> - #ifdef ARCH_HAS_READ_CURRENT_TIMER
>   -typedef unsigned long cycles_t;
>    #define get_cycles()  ({ cycles_t c; read_current_timer(&c) ? 0 : c; })
> - #endif
>
>   +#include <asm-generic/timex.h>
> ++#include <asm/delay.h>
>   +
>    #endif
>

Perfect.

I can re-verify with the respun 7530/1 if you'd like.

-- 
Thanks
- Cyril
