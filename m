From: lars@metafoo.de (Lars-Peter Clausen)
Date: Tue, 28 Sep 2010 12:10:53 +0200
Subject: [PATCH 4/7] pwm: Align existing pwm drivers with pwm-core driver
In-Reply-To: <F45880696056844FA6A73F415B568C69532DC2FB98@EXDCVYMBSTM006.EQ1STM.local>
References: <1285659648-21409-1-git-send-email-arun.murthy@stericsson.com>
	<1285659648-21409-5-git-send-email-arun.murthy@stericsson.com>
	<4CA1AE21.8070306@metafoo.de>
	<F45880696056844FA6A73F415B568C69532DC2FB98@EXDCVYMBSTM006.EQ1STM.local>
Message-ID: <4CA1BF2D.2070609@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arun MURTHY wrote:
>>> mips-jz4740: pwm: Align with new pwm core driver
>>>
>>> PWM core driver has been added and has been enabled only for ARM
>>> platform. The same can be utilised for mips also.
>>> Please align with the pwm core driver(drivers/pwm-core.c).
>>
>> Is there any reason for artificially limiting it to ARM?
> 
> No not at all, right now I have aligned all existing pwm drivers in ARM to make use of the pwm core driver.
> But faced difficulty in aligning the mips-jz4740 pwm driver, without having much knowledge about the device/data sheet.
> Hence I have let it to the maintainer of that driver to align and thereafter this limitation will be removed.
> Have also comments the same as TODO in the driver.
> 

Ok, I'll take care of adjusting the jz4740 pwm driver once the pwm-core is in proper
shape.
But I still think it would be better to have a config symbol which would be selected
by SoC code and on which PWM_CORE would depend. Then it would be possible for SoC
implementation to device whether it wants to provide it's own PWM API implementation
or use pwm-core.

>>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>>> index 5d10106..a88640c 100644
>>> --- a/drivers/pwm/Kconfig
>>> +++ b/drivers/pwm/Kconfig
>>> @@ -4,6 +4,7 @@
>>>
>>>  menuconfig PWM_DEVICES
>>>  	bool "PWM devices"
>>> +	depends on ARM
>>>  	default y
>>>  	---help---
>>>  	  Say Y here to get to see options for device drivers from
>> various
>>> diff --git a/drivers/pwm/pwm-core.c b/drivers/pwm/pwm-core.c
>>> index b84027a..3a0d426 100644
>>
>>
>> Why can't these changes be in the initial patch which adds pwm-core?
>>
> Since by default this driver is enabled, and if there is some other pwm driver enabled, both happen to export the same function(pwm_enable/pwm_disable,..) After applying the first patch build may fail.
> 
I would understand that if you were just moving code around, but the pwm_device
struct looks completly different now.


> Thanks and Regards,
> Arun R Murthy
> -------------
> 
