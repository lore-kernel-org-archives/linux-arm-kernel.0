From: ivan.khoronzhuk@ti.com (ivan.khoronzhuk)
Date: Mon, 18 Nov 2013 15:21:08 +0200
Subject: Fwd: [PATCH 3/8] watchdog: davinci: add GET_TIMELEFT option
 support
In-Reply-To: <5288284A.4020803@roeck-us.net>
References: <1383680783-12114-4-git-send-email-ivan.khoronzhuk@ti.com>
 <527A28AF.9040308@ti.com> <5288284A.4020803@roeck-us.net>
Message-ID: <528A1444.8020802@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/17/2013 04:22 AM, Guenter Roeck wrote:
> On 11/06/2013 03:31 AM, ivan.khoronzhuk wrote:
>> Currently, the davinci watchdog can be read while counting,
>> so we can add ability to report the remaining time before
>> the system will reboot.
>>
>> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
>> ---
>>   drivers/watchdog/davinci_wdt.c |   28 ++++++++++++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>
>> diff --git a/drivers/watchdog/davinci_wdt.c
>> b/drivers/watchdog/davinci_wdt.c
>> index 1fc2093..6cbf2e1 100644
>> --- a/drivers/watchdog/davinci_wdt.c
>> +++ b/drivers/watchdog/davinci_wdt.c
>> @@ -117,6 +117,33 @@ static int davinci_wdt_ping(struct
>> watchdog_device *wdd)
>>       return 0;
>>   }
>>
>> +static unsigned int davinci_wdt_get_timeleft(struct watchdog_device
>> *wdd)
>> +{
>> +    u64 timer_counter;
>> +    unsigned long freq;
>> +    u32 val;
>> +    struct davinci_wdt_device *davinci_wdt = watchdog_get_drvdata(wdd);
>> +
>> +    /* if timeout is occured then return 0 */
>
> is -> has ?
>

Yes

>> +    val = ioread32(davinci_wdt->base + WDTCR);
>> +    if (val & WDFLAG)
>> +        return 0;
>> +
>> +    freq = clk_get_rate(davinci_wdt->clk);
>> +
>> +    if (!freq) {
>> +        dev_err(wdd->dev, "clock freq is not set\n");
>> +        return 0;
>> +    }
>> +
> This error check doesn't make sense to me; elsewhere the clock rate is
> not validated.
> I would suggest to just return 0 here.
>

Agree

>> +    timer_counter = ioread32(davinci_wdt->base + TIM12);
>> +    timer_counter |= ((u64)ioread32(davinci_wdt->base + TIM34) << 32);
>> +
>> +    do_div(timer_counter, freq);
>> +
>> +    return wdd->timeout - timer_counter;
>> +}
>> +
>>   static const struct watchdog_info davinci_wdt_info = {
>>       .options = WDIOF_KEEPALIVEPING,
>>       .identity = "DaVinci Watchdog",
>> @@ -127,6 +154,7 @@ static const struct watchdog_ops davinci_wdt_ops = {
>>       .start        = davinci_wdt_start,
>>       .stop        = davinci_wdt_ping,
>>       .ping        = davinci_wdt_ping,
>> +    .get_timeleft    = davinci_wdt_get_timeleft,
>>   };
>>
>>   static int davinci_wdt_probe(struct platform_device *pdev)
>>
>


-- 
Regards,
Ivan Khoronzhuk
