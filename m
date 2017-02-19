From: linux@roeck-us.net (Guenter Roeck)
Date: Sun, 19 Feb 2017 08:57:35 -0800
Subject: [PATCH v2 2/3] watchdog: sama5d4: Fix setting timeout when
 watchdog is disabled
In-Reply-To: <20170217151625.hv2vn5imx2kyeftt@piout.net>
References: <20170216193053.5546-1-alexandre.belloni@free-electrons.com>
 <20170216193053.5546-2-alexandre.belloni@free-electrons.com>
 <968ef53e-c3c4-5322-020a-8382ce367931@roeck-us.net>
 <20170217151625.hv2vn5imx2kyeftt@piout.net>
Message-ID: <c9f336fd-8761-7999-4ac0-cf68eb6c8ba1@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/17/2017 07:16 AM, Alexandre Belloni wrote:
> On 17/02/2017 at 06:40:33 -0800, Guenter Roeck wrote:
>> On 02/16/2017 11:30 AM, Alexandre Belloni wrote:
>>> The datasheet states: "When setting the WDDIS bit, and while it is set, the
>>> fields WDV and WDD must not be modified."
>>>
>>> Ensure WDDIS is not set when changing the timeout and set it afterwards if
>>> the watchdog was disabled.
>>>
>>> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>>> ---
>>> Changes in v2:
>>>  - new patch
>>>  drivers/watchdog/sama5d4_wdt.c | 9 ++++++++-
>>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wdt.c
>>> index 2c6f5a70ae67..2a60251806d2 100644
>>> --- a/drivers/watchdog/sama5d4_wdt.c
>>> +++ b/drivers/watchdog/sama5d4_wdt.c
>>> @@ -90,11 +90,18 @@ static int sama5d4_wdt_set_timeout(struct watchdog_device *wdd,
>>>  	u32 reg;
>>>
>>>  	reg = wdt_read(wdt, AT91_WDT_MR);
>>> +
>>> +	if (reg & AT91_WDT_WDDIS)
>>> +		wdt_write(wdt, AT91_WDT_MR, reg & ~AT91_WDT_WDDIS);
>>> +
>>>  	reg &= ~AT91_WDT_WDV;
>>>  	reg &= ~AT91_WDT_WDD;
>>>  	reg |= AT91_WDT_SET_WDV(value);
>>>  	reg |= AT91_WDT_SET_WDD(value);
>>> -	wdt_write(wdt, AT91_WDT_MR, reg);
>>> +	wdt_write(wdt, AT91_WDT_MR, reg & ~AT91_WDT_WDDIS);
>>> +
>>> +	if (reg & AT91_WDT_WDDIS)
>>> +		wdt_write(wdt, AT91_WDT_MR, reg);
>>>
>> That means if the watchdog is running, the timeout would not be updated.
>> It should be updated no matter if it is running or not.
>>
>
> No, it is enabling the watchdog, then changing WDV and WDD and finally
> disabling the watchdog if necessary. So, WDV and WDD are always changed.
>
You are correct. Sorry for the noise.

Seems odd that the watchdog must be _running_ to change the timeout.
Usually, if there is a restriction, it is the opposite. I hope this
doesn't cause race conditions, where the watchdog fires immediately
after being enabled due to a low timeout.

Guenter
