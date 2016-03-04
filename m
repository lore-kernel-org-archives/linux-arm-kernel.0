From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 3 Mar 2016 21:23:40 -0800
Subject: [PATCH v1] watchdog: sama5d4_wdt: Reset delay on start
In-Reply-To: <56D8E649.8030500@atmel.com>
References: <1457000979-15717-1-git-send-email-romain.izard.pro@gmail.com>
 <56D8E649.8030500@atmel.com>
Message-ID: <56D91BDC.1030604@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/03/2016 05:35 PM, Yang, Wenyou wrote:
> Hi Romain,
>
> On 2016/3/3 18:29, Romain Izard wrote:
>> If the internal counter is not refreshed when the watchdog is started
>> for the first time, the watchdog will trigger very rapidly. For example,
>> opening /dev/watchdog without writing in it will immediately trigger a
>> reboot, instead of waiting for the delay to expire.
>>
>> To avoid this problem, reload the timer on opening the watchdog device.
>>
>> Command: "while sleep 5; do echo 1; done > /dev/watchdog"
>> Before: system reset
>> After: the watchdog runs correctly
> I didn't reproduce your issue on my side,
>
> run the your commands as follows, it works fine,  the system reset doesn't happen.

Different chip revision ? Different chip type ? Different chip initialization by ROMMON ?

Can we get exact chip revisions and types for both cases (working and not working),
and (if it might be relevant) a dump of all associated chip registers ?

Thanks,
Guenter

> ---8<----
> #!/bin/sh
>
> while [ 1 ]
> do
>          sleep 5;
>          echo 1 > /dev/watchdog
> done
> --->8----
>
> I also check the WDT_MR register before and after enabling watchdog, the WDV and WDD fields are correct.
>
> Can you check it again? thank you.
>
>>
>> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
>> ---
>>   drivers/watchdog/sama5d4_wdt.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wdt.c
>> index a49634cdc1cc..e162fe140ae1 100644
>> --- a/drivers/watchdog/sama5d4_wdt.c
>> +++ b/drivers/watchdog/sama5d4_wdt.c
>> @@ -15,6 +15,7 @@
>>   #include <linux/platform_device.h>
>>   #include <linux/reboot.h>
>>   #include <linux/watchdog.h>
>> +#include <linux/delay.h>
>>   #include "at91sam9_wdt.h"
>> @@ -58,6 +59,8 @@ static int sama5d4_wdt_start(struct watchdog_device *wdd)
>>       reg = wdt_read(wdt, AT91_WDT_MR);
>>       reg &= ~AT91_WDT_WDDIS;
>>       wdt_write(wdt, AT91_WDT_MR, reg);
>> +    udelay(125); /* > 4 cycles at 32,768 Hz */
>> +    wdt_write(wdt, AT91_WDT_CR, AT91_WDT_KEY | AT91_WDT_WDRSTT);
>>       return 0;
>>   }
>
> Best Regards,
> Wenyou Yang
>
