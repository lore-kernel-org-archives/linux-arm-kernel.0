From: linux@roeck-us.net (Guenter Roeck)
Date: Fri, 16 Mar 2018 18:56:27 -0700
Subject: [PATCH v3 1/7] watchdog: sama5d4: make use of timeout-secs
 provided in devicetree
In-Reply-To: <20180316133703.GA31029@gmail.com>
References: <20180211200847.25000-1-marcus.folkesson@gmail.com>
 <20180316133703.GA31029@gmail.com>
Message-ID: <f3d913af-a396-ccdf-105f-c4e64397cbff@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/16/2018 06:37 AM, Marcus Folkesson wrote:
> Hi,
> 
> Am I supposed to do something more to make this patchset picked up?
> 

Did you check linux-next ?

Guenter

> Thanks,
> Marcus Folkesson
> 
> On Sun, Feb 11, 2018 at 09:08:41PM +0100, Marcus Folkesson wrote:
>> watchdog_init_timeout() will allways pick timeout_param since it
>> defaults to a valid timeout.
>>
>> Following best practice described in
>> Documentation/watchdog/watchdog-kernel-api.txt to make use of
>> the parameter logic.
>>
>> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
>> ---
>>
>> Notes:
>>      v3:
>>      	- Use wdd->timeout instead of wdt_timeout when print out
>>      	  timout in probe function.
>>
>>   drivers/watchdog/sama5d4_wdt.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wdt.c
>> index 0ae947c3d7bc..255169916dbb 100644
>> --- a/drivers/watchdog/sama5d4_wdt.c
>> +++ b/drivers/watchdog/sama5d4_wdt.c
>> @@ -33,7 +33,7 @@ struct sama5d4_wdt {
>>   	unsigned long		last_ping;
>>   };
>>   
>> -static int wdt_timeout = WDT_DEFAULT_TIMEOUT;
>> +static int wdt_timeout;
>>   static bool nowayout = WATCHDOG_NOWAYOUT;
>>   
>>   module_param(wdt_timeout, int, 0);
>> @@ -212,7 +212,7 @@ static int sama5d4_wdt_probe(struct platform_device *pdev)
>>   		return -ENOMEM;
>>   
>>   	wdd = &wdt->wdd;
>> -	wdd->timeout = wdt_timeout;
>> +	wdd->timeout = WDT_DEFAULT_TIMEOUT;
>>   	wdd->info = &sama5d4_wdt_info;
>>   	wdd->ops = &sama5d4_wdt_ops;
>>   	wdd->min_timeout = MIN_WDT_TIMEOUT;
>> @@ -273,7 +273,7 @@ static int sama5d4_wdt_probe(struct platform_device *pdev)
>>   	platform_set_drvdata(pdev, wdt);
>>   
>>   	dev_info(&pdev->dev, "initialized (timeout = %d sec, nowayout = %d)\n",
>> -		 wdt_timeout, nowayout);
>> +		 wdd->timeout, nowayout);
>>   
>>   	return 0;
>>   }
>> -- 
>> 2.15.1
>>
