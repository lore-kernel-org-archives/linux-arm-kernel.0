From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Mon, 5 May 2014 21:53:08 +0300
Subject: [PATCH v2 2/5] Power: reset: add bindings for keystone reset
 driver
In-Reply-To: <534D1719.40701@ti.com>
References: <1397497283-16391-1-git-send-email-ivan.khoronzhuk@ti.com>
 <1397497283-16391-3-git-send-email-ivan.khoronzhuk@ti.com>
 <6937937.4J6iI7VpBO@wuerfel> <534D1719.40701@ti.com>
Message-ID: <5367DE14.8000907@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 04/15/2014 02:25 PM, Ivan Khoronzhuk wrote:
>
> On 04/14/2014 09:44 PM, Arnd Bergmann wrote:
>> On Monday 14 April 2014 20:41:20 Ivan Khoronzhuk wrote:
>>> +Optional properties:
>>> +
>>> +- ti,soft-reset:       Boolean option indicating soft reset.
>>> +                       By default hard reset is used.
>>> +
>>> +- ti,wdt_list:         WDT list that can cause SoC reset.
>>> +                       The list in format: <0>, <2>;
>>> +                       Begins from 0 to 3, as keystone can contain up
>>> +                       to 4 SoC reset watchdogs.
>>>
>> This looks like your binding just describes a subset of the
>> watchdog timer registers. If so, don't do a standalone reset
>
> The registers are not a subset of watchdog hardware it's SoC specific 
> future
> controlled by SoC specific registers (bootregs and PLL regs).
>
> For watchog IP setup, the Keystone uses the watchdog driver common 
> with other
> SoCs -- davinci_watchdog that is not depend on other SoC settings like 
> this driver does.
>
> The Keystone SoCs have separate registers to tune Keystone2 reset 
> functionality
> by configuring Reset multiplexer &  PLL. And it tunes not only 
> watchdog usage.
> The keystone SoC can be rebooted in several ways. By external reset 
> pin, by soft and
> by watchdogs. This driver allows software reset or reset by one of the 
> watchdogs
> (and other settings) independently on watchdog driver settings. This 
> is job of reset driver.
>
>> It's
>> driver, but instead do a watchdog driver that can also be
>> used for reset, and have a binding that properly describes
>> the watchdog hardware.
>>
>> It is bad to have overlapping register ranges between logical
>
> WDT doesn't overlap with this driver.
>
>> devices, and it's also generally wrong to describe devices that
>> are not actually there: The hardware contains a watchdog, not
>> a system-reset device, so you should not make one up because
>> it seems easier given the Linux driver model.
>>
>>     Arnd 

Hi Arnd,

Could I do smth additional to make bindings explanation more clear?
Or this is enough?

I can write like the following:
Optional properties:

- ti,soft-reset:       Boolean option indicating soft reset.
                        By default hard reset is used.

- ti,wdt_list:         WDT list that can cause SoC reset. This is not
                         related to WDT driver, it's just needed to enable
                         a SoC related reset that is triggered by one of 
watchdogs.
                        The list in format: <0>, <2>;
                        Begins from 0 to 3, as keystone can contain up
                        to 4 SoC reset watchdogs. Can be in random order.

That is OK?

-- 
Regards,
Ivan Khoronzhuk
