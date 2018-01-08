From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 8 Jan 2018 08:23:02 +0100
Subject: [PATCH v2 3/6] clocksource/drivers: atmel-pit: allow unselecting
 ATMEL_PIT
In-Reply-To: <20180107184455.GG5545@piout.net>
References: <20180105143006.5369-1-alexandre.belloni@free-electrons.com>
 <20180105143006.5369-4-alexandre.belloni@free-electrons.com>
 <64398ab7-fbc6-0313-ccc6-51ff02d087e6@linaro.org>
 <20180107184455.GG5545@piout.net>
Message-ID: <b8c0c142-2a69-648b-1389-a4467a26211b@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/01/2018 19:44, Alexandre Belloni wrote:
> On 07/01/2018 at 19:07:13 +0100, Daniel Lezcano wrote:
>> On 05/01/2018 15:30, Alexandre Belloni wrote:
>>> With the new TCB clocksource driver, atmel platforms are now able to boot
>>> without the PIT driver. Allow unselecting it.
>>>
>>> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>>> ---
>>>  drivers/clocksource/Kconfig | 9 ++++++++-
>>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
>>> index 5609572e0236..55ccfa0ba63b 100644
>>> --- a/drivers/clocksource/Kconfig
>>> +++ b/drivers/clocksource/Kconfig
>>> @@ -381,7 +381,14 @@ config ARMV7M_SYSTICK
>>>  
>>>  config ATMEL_PIT
>>>  	select TIMER_OF if OF
>>> -	def_bool SOC_AT91SAM9 || SOC_SAMA5
>>> +	bool "Atmel Periodic Interval Timer (PIT)"
>>> +	depends on SOC_AT91SAM9 || SOC_SAMA5
>>> +	default SOC_AT91SAM9 || SOC_SAMA5
>>> +	help
>>> +	  Select this to get a clocksource based on the Atmel Periodic Interval
>>> +	  Timer. It has a relatively low resolution and the TC Block clocksource
>>> +	  should be preferred.
>>> +	  It also provides a clock event device.
>>
>> Please conform to the format:
>>
>> config ATMEL_PIT
>> 	bool "Atmel Periodic Interval Timer (PIT)" if COMPILE_TEST
>> 	select ...
>> 	help
>> 	    bla bla
>>
>> and select ATMEL_PIT from the platform's Kconfig.
>>
> 
> Well, the goal is actually to allow people to unselect it so we don't
> want the platform to select it.

Why do you need people to unselect it?

The goal of the Kconfig here is to be silent except in the case the
COMPILE_TEST option is set for cross-compilation test coverage.

We are migrating all these options to this format. Please make it silent.


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
