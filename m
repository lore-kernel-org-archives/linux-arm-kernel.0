From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 16 May 2017 16:25:04 +0200
Subject: [PATCH 42/48] clocksource/drivers: Add a new driver for the Atmel
 ARM TC blocks
In-Reply-To: <20170516115916.ip3ea34bofg3jpuo@piout.net>
References: <1465596231-21766-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1465596231-21766-43-git-send-email-alexandre.belloni@free-electrons.com>
 <576D0645.2070805@linaro.org> <20170516115916.ip3ea34bofg3jpuo@piout.net>
Message-ID: <d2485b56-52fa-6532-76cb-222f0c139566@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/05/2017 13:59, Alexandre Belloni wrote:
> Hi Daniel,
> 
> Almost one year later, I'm back on that topic.
> 
> On 24/06/2016 at 12:07:01 +0200, Daniel Lezcano wrote:
>>> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
>>> index 47352d25c15e..ff7f4022c749 100644
>>> --- a/drivers/clocksource/Kconfig
>>> +++ b/drivers/clocksource/Kconfig
>>> @@ -258,6 +258,19 @@ config ATMEL_ST
>>>   	select CLKSRC_OF
>>>   	select MFD_SYSCON
>>>
>>> +config ATMEL_ARM_TCB_CLKSRC
>>> +	bool "TC Block Clocksource"
>>
>> The Kconfig options are set now with the COMPILE_TEST option in order to
>> increase the compilation test coverage.
>>
>> Please, add bool "TC Block Clocksource" if COMPILE_TEST, ...
>>
>>> +	select REGMAP_MMIO
>>> +	depends on GENERIC_CLOCKEVENTS
>>> +	depends on SOC_AT91RM9200 || SOC_AT91SAM9 || SOC_SAMA5
>>> +	default SOC_AT91RM9200 || SOC_AT91SAM9 || SOC_SAMA5
>>
>> ... remove these dependencies and let the SoC's Kconfig to select the timer
>> like the other timers are.
>>
> 
> The main issue with what you suggest is that it removes the possibility
> to not compile the driver. This may be interesting for people using the
> PIT as the clocksource/clockevent and the TCBs for something else.

Is it really a problem? We tend as much as possible to make silent
options in order to let the platform config to select the right clock.


>>> +static cycle_t tc_get_cycles(struct clocksource *cs)
>>> +{
>>> +	unsigned long	flags;
>>> +	u32		lower, upper, tmp;
>>> +
>>> +	raw_local_irq_save(flags);
>>> +	do {
>>> +		regmap_read(tc.regmap, ATMEL_TC_CV(1), &upper);
>>> +		regmap_read(tc.regmap, ATMEL_TC_CV(0), &lower);
>>> +		regmap_read(tc.regmap, ATMEL_TC_CV(1), &tmp);
>>> +	} while (upper != tmp);
>>> +
>>> +	raw_local_irq_restore(flags);
>>
>> Why is this lock needed ?
>>
> 
> I've taken that from the old driver, I'm not sure this is needed. Maybe
> to lower the chance to have upper != tmp.
> 
>>> +	return (upper << 16) | lower;
>>> +}
>>> +

I don't think this is needed.

>>> +static int tcb_clkevt_oneshot(struct clock_event_device *dev)
>>> +{
>>> +	int ret;
>>> +
>>> +	if (tc.irq_requested)
>>> +		return 0;
>>> +
>>> +	ret = request_irq(tc.irq, tc_clkevt_irq, IRQF_TIMER | IRQF_SHARED,
>>> +			  "tcb_clkevt", &tc);
>>> +	if (!ret)
>>> +		tc.irq_requested = true;
>>
>> The legacy driver checks clockevent_state_detached() and disables the clock.
>>
> 
> This feature is different from the legacy driver. Here, the driver is
> using a single TCB channel for both clocksource and clockevent while the
> legacy driver always uses at least two channels.
> 
>> Why is 'irq_requested' and request_irq/free_irq cleaner ?
>>
>> Isn't there a configuration with the TCB register to disable the clockevent
>> only ?
>>
> 
> I'll try something cleaner anyway.

Ok.


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
