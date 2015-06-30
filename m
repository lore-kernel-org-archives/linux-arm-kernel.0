From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Tue, 30 Jun 2015 13:16:27 +0530
Subject: Use of pinctrl-single for external device over I2C
In-Reply-To: <558B95CA.9070105@linaro.org>
References: <55893B2C.1070800@linaro.org> <558A9CC7.6070409@linaro.org>
 <20150624133349.GI4156@atomide.com> <558AE478.2080802@linaro.org>
 <20150625043838.GK4156@atomide.com> <558B95CA.9070105@linaro.org>
Message-ID: <55924953.80802@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Thursday 25 June 2015 11:16 AM, Vaibhav Hiremath wrote:
>
>
> On Thursday 25 June 2015 10:08 AM, Tony Lindgren wrote:
>> * Vaibhav Hiremath <vaibhav.hiremath@linaro.org> [150624 10:12]:
>>>
>>> I do not like this, as this is not HW feature, so DT may not be right
>>> approach.
>>>
>>> So I will dig more from either runtime or Compile time option to use
>>> regmap_ Vs raw read/writes.
>>
>> Can't you just check if the pinctrl node has compatible = "syscon"
>> property?
>>
>> A compile time option won't work for sure. I don't know what you
>> would check at runtime as you do not know what the bus is behind
>> syscon.
>>
>
> Although, I haven't gone through syscon, but not sure whether syscon
> would be useful.
>
> As you rightly stated, we need to know the bus behind regmap.
>

Trying to understand what is the right way of doing pinctrl of external
device on board,

I feel it would not be good idea to pollute pinctrl-single driver, and 
also I am still not able to figure out how can I have access to bus
behind regmap.


How about having separate driver (generic for all I2C), say pinctrl-
i2c.c, which is i2c_client driver and would support pinctrl and pinmux
on I2C client device.


The current usecase which I have is pretty simple in nature,

88PM860 has few GPIO pins which can be configured to different
functionality, based on board design.
In most of the cases they are one/init/boot time settings.

GPIO_0:
=======
   000 = GPIO input mode
   001 = GPIO output mode
   010 = SLEEPOUTN mirror mode
   011 = Buck4 FPWM enable
   100 = 32 Khz output buffer mode
   101 = PMICINTN output mode
   110 = HW_RESET1 mode
   111 = HW_RESET2 mode


Thanks,
Vaibhav
