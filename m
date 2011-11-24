From: myungjoo.ham@gmail.com (MyungJoo Ham)
Date: Thu, 24 Nov 2011 11:12:26 +0900
Subject: [GIT PULL] Samsung fixes for v3.2
In-Reply-To: <201111232115.18048.arnd@arndb.de>
References: <03e501cca837$d893e320$89bba960$%kim@samsung.com>
 <201111232115.18048.arnd@arndb.de>
Message-ID: <CAJ0PZbQCkTw31cmM0rt8do6u8zQmAokRK_YkQV1eeLZs20UOHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 24, 2011 at 6:15 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 21 November 2011, Kukjin Kim wrote:
>> Please pull samsung-fixes for v3.2 from:
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
>> samsung-fixes
>>
>> This includes fix of inclusion header.
>> If any problems, please let me know.
>>
>
> Pulled, thanks!
>
> On Monday 21 November 2011, Kyungmin Park wrote:
>> Don't you fix the mct compiler error if LOCAL_TIMERS are not defined?
>>
>> arch/arm/mach-exynos/mct.c: In function 'exynos4_timer_resources':
>> arch/arm/mach-exynos/mct.c:451: error: 'exynos4_mct_tick_isr'
>> undeclared (first use in this function)
>> arch/arm/mach-exynos/mct.c:451: error: (Each undeclared identifier is
>> reported only once
>> arch/arm/mach-exynos/mct.c:451: error: for each function it appears in.)
>> make[1]: *** [arch/arm/mach-exynos/mct.o] Error 1
>
> Has a patch been posted for this?
>
> ? ? ? ?Arnd

There was a discussion about this and a patch seemed to be ready
although I don't know where:

---[quoting: "Re: [PATCH 1/2] ARM: EXYNOS4: convert MCT to percpu
interrupt API" from linux-arm-kernel at lists.infradead.org]---

On 10/11/11 23:33, MyungJoo Ham wrote:
> On Thu, Nov 10, 2011 at 6:43 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> On 10/11/11 02:40, MyungJoo Ham wrote:
>>> On Thu, Nov 3, 2011 at 2:30 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>>> MCT recently gained per cpu interrupts, and missed the fact that
>>>> ARM has moved to a genirq based implementation.
>>>>
>>>> This patch converts the driver to the new API.
>>>>
>>>> Boot tested on Origen.
>>>>
>>>> Cc: Kukjin Kim <kgene.kim@samsung.com>
>>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>>
>>> There is one concern regarding the CONFIG_LOCAL_TIMER.
>>>
>>> []
>>>>  #endif /* CONFIG_LOCAL_TIMERS */
>>>>
>>>>  static void __init exynos4_timer_resources(void)
>>>> @@ -438,6 +442,16 @@ static void __init exynos4_timer_resources(void)
>>>>        mct_clk = clk_get(NULL, "xtal");
>>>>
>>>>        clk_rate = clk_get_rate(mct_clk);
>>>> +
>>>> +       if (mct_int_type == MCT_INT_PPI) {
>>>> +               int err;
>>>> +
>>>> +               err = request_percpu_irq(IRQ_MCT_LOCALTIMER,
>>>> +                                        exynos4_mct_tick_isr, "MCT",
>>>> +                                        &percpu_mct_tick);
>>>> +               WARN(err, "MCT: can't request IRQ %d (%d)\n",
>>>> +                    IRQ_MCT_LOCALTIMER, err);
>>>> +       }
>>>>  }
>>>>
>>>
>>> You've added exynos4_mct_tick_isr, which is defined in
>>> CONFIG_LOCAL_TIMER section, in the place that is compiled without
>>> CONFIG_LOCAL_TIMER.
>>> I guess we are going to stop supporting LOCAL_TIMER in Exynos later
>>> and this could be a problem with it.
>>
>> Yup, this is a problem. It probably means we need to #ifdef that chink
>> as well. I'm not sure I get your remark about not supporting LOCAL_TIMER
>> though. Are you planning to move away from the LOCAL_TIMER infrastructure?
>
> Yes, we may need to #ifdef that block.
> And yes, for the Exynos series, I'll need to double check; however, I
> think we are planning to move away from the LOCAL_TIMER for MCT.


I have patches for this already.

- Hide quoted text -

       M.
--
Jazz is not dead. It just smells funny...



-- 
MyungJoo Ham, Ph.D.
Mobile Software Platform Lab, DMC Business, Samsung Electronics
