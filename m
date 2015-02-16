From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Mon, 16 Feb 2015 13:21:01 +0100
Subject: [PATCH 03/14] clocksource: Add ARM System timer driver
In-Reply-To: <54E12F39.6030509@suse.de>
References: <1423763164-5606-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1423763164-5606-4-git-send-email-mcoquelin.stm32@gmail.com>
 <54E12F39.6030509@suse.de>
Message-ID: <CALszF6DySx-j8hrXoSRC7uo7BcFQXgOu0SJD1q3NHKoD-NxhKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-02-16 0:43 GMT+01:00 Andreas F?rber <afaerber@suse.de>:
> Am 12.02.2015 um 18:45 schrieb Maxime Coquelin:
>> This patch adds clocksource support for ARMv7-M's System timer,
>> also known as SysTick.
>>
>> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>> ---
>>  .../devicetree/bindings/arm/system_timer.txt       | 15 +++++
>>  drivers/clocksource/Kconfig                        |  7 ++
>>  drivers/clocksource/Makefile                       |  1 +
>>  drivers/clocksource/arm_system_timer.c             | 74 ++++++++++++++++++++++
>>  4 files changed, 97 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/arm/system_timer.txt
>>  create mode 100644 drivers/clocksource/arm_system_timer.c
>>
>> diff --git a/Documentation/devicetree/bindings/arm/system_timer.txt b/Documentation/devicetree/bindings/arm/system_timer.txt
>> new file mode 100644
>> index 0000000..35268b7
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/system_timer.txt
>> @@ -0,0 +1,15 @@
>> +* ARM System Timer
>> +
>> +ARMv7-M includes a system timer, known as SysTick. Current driver only
>> +implements the clocksource feature.
>> +
>> +Required properties:
>> +- compatible : Should be "arm,armv7m-systick"
>> +- reg             : The address range of the timer
>> +- clocks     : The input clock of the timer
>> +
>> +systick: system-timer {
>> +     compatible = "arm,armv7m-systick";
>> +     reg = <0xe000e010 0x10>;
>> +     clocks = <&clk_systick>;
>> +};
>
> Binding documentation is supposed to go into its own patch:
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/submitting-patches.txt
Ok, will change this in the v2.

>
...
>
> I've used a SysTick based implementation on my stm32 branch myself, but
> looking at efm32 I got the impression that it would be better to use one
> of the 32-bit TIM2/TIM5 as clocksource and the other as clockevents?
>
> Still this implementation will be handy to have, also for other targets.

My view is that we should use as much generic parts of the Cortex-M as possible.
Moreover, doing, that, we can keep one more IP instance under reset
with associated clock gated,
and so maybe reduce the power consumption a little (I haven't done any
measurements)

Do you see a case where it could be better to use the STM32 timers?


Thanks,
Maxime
>
> Regards,
> Andreas
>
> --
> SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
> GF: Felix Imend?rffer, Jane Smithard, Jennifer Guild, Dilip Upmanyu,
> Graham Norton; HRB 21284 (AG N?rnberg)
