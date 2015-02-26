From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Thu, 26 Feb 2015 11:29:52 +0100
Subject: [PATCH v2 02/18] ARM: ARMv7M: Enlarge vector table to 256 entries
In-Reply-To: <CALszF6CB9YU7ashQ-y_zx58Mkf=sbrBfa2dAOdQm7FkmcuE7PA@mail.gmail.com>
References: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1424455277-29983-3-git-send-email-mcoquelin.stm32@gmail.com>
 <20150220194756.GS19388@pengutronix.de>
 <CALszF6CB9YU7ashQ-y_zx58Mkf=sbrBfa2dAOdQm7FkmcuE7PA@mail.gmail.com>
Message-ID: <CALszF6B6A=de_TK0e-iJHuW4MfD9xbd-yHZHaD-JmZXwZ9CW2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-02-23 11:33 GMT+01:00 Maxime Coquelin <mcoquelin.stm32@gmail.com>:
> 2015-02-20 20:47 GMT+01:00 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
>> On Fri, Feb 20, 2015 at 07:01:01PM +0100, Maxime Coquelin wrote:
>>> From Cortex-M reference manuals, the nvic supports up to 240 interrupts.
>>> So the number of entries in vectors table is up to 256.
>>>
>>> This patch adds a new config flag to specify the number of external interrupts.
>>> Some ifdeferies are added in order to respect the natural alignment without
>>> wasting too much space on smaller systems.
>>>
>>> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>>> ---
>>>  arch/arm/kernel/entry-v7m.S | 13 +++++++++----
>>>  arch/arm/mm/Kconfig         | 15 +++++++++++++++
>>>  2 files changed, 24 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/arm/kernel/entry-v7m.S b/arch/arm/kernel/entry-v7m.S
>>> index 8944f49..68cde36 100644
>>> --- a/arch/arm/kernel/entry-v7m.S
>>> +++ b/arch/arm/kernel/entry-v7m.S
>>> @@ -117,9 +117,14 @@ ENTRY(__switch_to)
>>>  ENDPROC(__switch_to)
>>>
>>>       .data
>>> -     .align  8
>>> +#if CONFIG_CPUV7M_NUM_IRQ <= 112
>> I would have called this CONFIG_CPU_V7M_NUM_IRQ to match the already
>> existing CPU_V7M symbol.
>
> That's better indeed.
> It will be changed in v3.
>
>>
>>> +     .align  9
>>> +#else
>>> +     .align  10
>>> +#endif
>>> +
>>
>> Other than that:
>> Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
>>
>> Who do you target to apply this series?
>
> I guess it should go through Russell's Patch Tracking System?

Sorry, I answered your question too quickly.
I meant this patch should go through Russell's Patch Tracking System.

For the other patches, I think it should be picked by their respective
maintainers.
Or I can create an immutable tag (on github or kernel.org?) that will
be merged by the different sub-systems?
What would you advise?

Thanks,
Maxime

>
> Thanks,
> Maxime
>>
>> Best regards
>> Uwe
>>
>> --
>> Pengutronix e.K.                           | Uwe Kleine-K?nig            |
>> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
