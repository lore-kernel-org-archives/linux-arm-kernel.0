From: ivan.khoronzhuk@ti.com (ivan.khoronzhuk)
Date: Mon, 18 Nov 2013 16:21:06 +0200
Subject: Fwd: [PATCH 4/8] watchdog: davinci: add GET_STATUS option support
In-Reply-To: <528828E7.6060404@roeck-us.net>
References: <1383680783-12114-5-git-send-email-ivan.khoronzhuk@ti.com>
 <527A28CE.2070802@ti.com> <528828E7.6060404@roeck-us.net>
Message-ID: <528A2252.7040605@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/17/2013 04:24 AM, Guenter Roeck wrote:
> On 11/06/2013 03:32 AM, ivan.khoronzhuk wrote:
>> When watchdog timer is expired we can know about it thought
> 
> thought -> through or with
> 

Ok

>> GET_STATUS ioctl option.
>>
>> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
>> ---
>>   drivers/watchdog/davinci_wdt.c |   13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/drivers/watchdog/davinci_wdt.c 
>> b/drivers/watchdog/davinci_wdt.c
>> index 6cbf2e1..a371b2d 100644
>> --- a/drivers/watchdog/davinci_wdt.c
>> +++ b/drivers/watchdog/davinci_wdt.c
>> @@ -144,6 +144,18 @@ static unsigned int 
>> davinci_wdt_get_timeleft(struct watchdog_device *wdd)
>>       return wdd->timeout - timer_counter;
>>   }
>>
>> +static unsigned int davinci_wdt_status(struct watchdog_device *wdd)
>> +{
>> +    u32 val;
>> +    struct davinci_wdt_device *davinci_wdt = watchdog_get_drvdata(wdd);
>> +
>> +    val = ioread32(davinci_wdt->base + WDTCR);
>> +    if (val & WDFLAG)
>> +        return WDIOF_CARDRESET;
>> +
>      "Card previously reset the CPU"
> 
> Is this really accurate / correct ?
> 
> My understanding is that the status is supposed to return the reason for 
> a previous reset/reboot,
> not the curent condition.
> 

Actually it is not so good correlate with the purpose, but I grasped
several examples like watchdog/pcwd.c; watchdog/w83977f_wdt.c;
watchdog/of_xilinx_wdt.c and saw that I can use it in meaning "the card initiated reset.
After the WDT is overflowed it sets WDFLAG, so I can use it.
It is more useful while debugging and if it is doubtful I can drop it.

>> +    return 0;
>> +}
>> +
>>   static const struct watchdog_info davinci_wdt_info = {
>>       .options = WDIOF_KEEPALIVEPING,
>>       .identity = "DaVinci Watchdog",
>> @@ -155,6 +167,7 @@ static const struct watchdog_ops davinci_wdt_ops = {
>>       .stop        = davinci_wdt_ping,
>>       .ping        = davinci_wdt_ping,
>>       .get_timeleft    = davinci_wdt_get_timeleft,
>> +    .status        = davinci_wdt_status,
>>   };
>>
>>   static int davinci_wdt_probe(struct platform_device *pdev)
>>
> 


-- 
Regards,
Ivan Khoronzhuk
