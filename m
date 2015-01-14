From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 15 Jan 2015 08:57:00 +0900
Subject: [RESEND PATCH v3] clocksource: exynos_mct: Add the support for
 Exynos 64bit SoC
In-Reply-To: <54B692FB.7030703@linaro.org>
References: <1421213603-5020-1-git-send-email-cw00.choi@samsung.com>
 <54B69072.4080607@kernel.org> <54B692FB.7030703@linaro.org>
Message-ID: <54B7024C.4020407@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

On 01/15/2015 01:02 AM, Daniel Lezcano wrote:
> On 01/14/2015 04:51 PM, Kukjin Kim wrote:
>> On 01/14/15 14:33, Chanwoo Choi wrote:
>>
>> Hi,
>>
>> + Doug, Olof
>>
>>> This patch adds the support for Exynos 64bit SoC. The delay_timer is only used
>>> for Exynos 32bit SoC.
>>>
>> Yes, the Exynos MCT(Multi-Core Timer) is 64bit timer and it is available
>> on 64bit exynos SoC such as exynos7. But basically ARMv8 architecture is
>> including ARM ARCH timer (ARM Generic Timer) and exynos7 also has
>> implemented it and additionally its access is faster than using memory
>> mapped register called SFR for MCT...so Doug submitted patch to use MCT
>> on 32bit exynos SoCs before.

I know arch_timer. As you comment, ARCH timer would be used for system timer for ARMv8.
But, Exynos5433/Exynos7 (ARMv8) include MCT (Multi-Core Timer) IP. I checked it on
Exynos5433/EXynos7 User-manaual and tested it.

I think that exynos_mct.c should support the Exynos 64-bit SoC
because Exynos5433/Exynos7 include already MCT (Multi-Core Timer) IP.

Also, I have a problem to verify ARCH timer on Exynos SoC. Exynos User-manual never includes
the detailed information about for ARCH timer(e.g, clock for ARCH timer). I knew that
I can get the document of ARCH timer for ARM official site but I think it is insufficient
to implement ARCH timer on Exynos SoC. 

Best Regards,
Chanwoo Choi

>>
>> I know using MCT on 64bit exynos is usefulness for Power Management and
>> I need to talk to relevant guys in office again. If anything, I'll let
>> you know.
> 
> I will wait for your answer before digging more the patch.
> 
> Thanks
>   -- Daniel
> 
>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Kukjin Kim <kgene.kim@samsung.com>
>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>>> ---
>>> This patch set is tested on 64-bit Exynos SoC. I send only this patch from
>>> following patchst[1].
>>> [1] https://lkml.org/lkml/2014/12/2/134
>>>
>>> Changes from v2:
>>> - None
>>> Changes from v1:
>>> - Use CONFIG_ARM instead of CONFIG_ARM64
>>>
>>>   drivers/clocksource/Kconfig      | 1 -
>>>   drivers/clocksource/exynos_mct.c | 4 ++++
>>>   2 files changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
>>> index fc01ec2..be38119 100644
>>> --- a/drivers/clocksource/Kconfig
>>> +++ b/drivers/clocksource/Kconfig
>>> @@ -135,7 +135,6 @@ config CLKSRC_METAG_GENERIC
>>>
>>>   config CLKSRC_EXYNOS_MCT
>>>       def_bool y if ARCH_EXYNOS
>>> -    depends on !ARM64
>>>       help
>>>         Support for Multi Core Timer controller on Exynos SoCs.
>>>
>>> diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
>>> index 9403061..b840ea1 100644
>>> --- a/drivers/clocksource/exynos_mct.c
>>> +++ b/drivers/clocksource/exynos_mct.c
>>> @@ -223,6 +223,7 @@ static u64 notrace exynos4_read_sched_clock(void)
>>>       return exynos4_read_count_32();
>>>   }
>>>
>>> +#if defined(CONFIG_ARM)
>>>   static struct delay_timer exynos4_delay_timer;
>>>
>>>   static cycles_t exynos4_read_current_timer(void)
>>> @@ -231,14 +232,17 @@ static cycles_t exynos4_read_current_timer(void)
>>>                "cycles_t needs to move to 32-bit for ARM64 usage");
>>>       return exynos4_read_count_32();
>>>   }
>>> +#endif
>>>
>>>   static void __init exynos4_clocksource_init(void)
>>>   {
>>>       exynos4_mct_frc_start();
>>>
>>> +#if defined(CONFIG_ARM)
>>>       exynos4_delay_timer.read_current_timer = &exynos4_read_current_timer;
>>>       exynos4_delay_timer.freq = clk_rate;
>>>       register_current_timer_delay(&exynos4_delay_timer);
>>> +#endif
>>>
>>>       if (clocksource_register_hz(&mct_frc, clk_rate))
>>>           panic("%s: can't register clocksource\n", mct_frc.name);
> 
> 
