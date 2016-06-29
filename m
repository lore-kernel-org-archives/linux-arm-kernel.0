From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 29 Jun 2016 18:10:55 +0200
Subject: [PATCH 3/6] Clocksource: add nuc970 clocksource driver
In-Reply-To: <4184925.Jh1dkPbmzX@wuerfel>
References: <1466851042-22239-1-git-send-email-vw@iommu.org>
 <1466851042-22239-4-git-send-email-vw@iommu.org> <4184925.Jh1dkPbmzX@wuerfel>
Message-ID: <5773F30F.3020201@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/29/2016 05:25 PM, Arnd Bergmann wrote:
> On Saturday, June 25, 2016 6:37:19 PM CEST Wan Zongshun wrote:
>> This patch is to add nuc970 clocksource driver support.
>>
>> Signed-off-by: Wan Zongshun <mcuos.com@gmail.com>
>> ---
>>   .../mach-w90x900/include/mach/nuc970-regs-timer.h  |  44 +++++
>>   drivers/clocksource/Kconfig                        |   8 +
>>   drivers/clocksource/Makefile                       |   1 +
>>   drivers/clocksource/timer-nuc900.c                 | 207 +++++++++++++++++++++
>>   4 files changed, 260 insertions(+)
>>   create mode 100644 arch/arm/mach-w90x900/include/mach/nuc970-regs-timer.h
>>   create mode 100644 drivers/clocksource/timer-nuc900.c
>>
>> diff --git a/arch/arm/mach-w90x900/include/mach/nuc970-regs-timer.h b/arch/arm/mach-w90x900/include/mach/nuc970-regs-timer.h
>> new file mode 100644
>> index 0000000..43d7e8b
>> --- /dev/null
>> +++ b/arch/arm/mach-w90x900/include/mach/nuc970-regs-timer.h
>
> Please move the contents of the header file into the driver. We try to not
> have any new mach/*.h headers.
>
>> +
>> +static unsigned int timer0_load;
>> +static void __iomem *tmr_base;
>> +
>> +static int nuc970_clockevent_set_oneshot(struct clock_event_device *evt)
>> +{
>> +	unsigned int val;
>> +
>> +	val = __raw_readl(tmr_base + REG_TMR_TCSR0);
>> +	val &= ~(0x03 << 27);
>> +
>> +	val |= (ONESHOT | COUNTEN | INTEN | PRESCALE);
>> +
>> +	__raw_writel(val, tmr_base + REG_TMR_TCSR0);
>> +	return 0;
>> +}
>> +
>
> writel() instead of __raw_writel()

Wan Zongshun,

FYI : https://lkml.org/lkml/2015/12/18/422

Not sure it does a noticeable difference on arm926.

Thanks Arnd for the clarification.

   -- Daniel


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
