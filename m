From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Tue, 19 Nov 2013 18:17:32 +0200
Subject: [PATCH 1/6] watchdog: davinci: change driver to use WDT core
In-Reply-To: <528AF349.9070902@roeck-us.net>
References: <1384795139-19466-1-git-send-email-ivan.khoronzhuk@ti.com>
 <1384795139-19466-2-git-send-email-ivan.khoronzhuk@ti.com>
 <528AF349.9070902@roeck-us.net>
Message-ID: <528B8F1C.3090506@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/19/2013 07:12 AM, Guenter Roeck wrote:
> On 11/18/2013 09:18 AM, Ivan Khoronzhuk wrote:
>> To reduce code duplicate and increase code readability use WDT core
>> code to handle WDT interface.
>>
>> Remove io_lock as the WDT core uses mutex to lock each wdt device.
>> Remove wdt_state as the WDT core track state with its own variable.
>>
>> The watchdog_init_timeout() can read timeout value from timeout-sec
>> property if the passed value is out of bounds. The heartbeat is
>> initialized in next way. If heartbeat is not set thought module
>> parameter, try to read it's value from WDT node timeout-sec property.
>> If node has no one, use default value.
>>
>> The heartbeat is hold in wdd->timeout by WDT core, so use it in
>> order to set timeout period.
>>
>> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
>> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> ---
>>   drivers/watchdog/Kconfig       |    2 +
>>   drivers/watchdog/davinci_wdt.c |  152
>> ++++++++++------------------------------
>>   2 files changed, 39 insertions(+), 115 deletions(-)
>>
>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>> index d1d53f3..d7db13d 100644
>> --- a/drivers/watchdog/Kconfig
>> +++ b/drivers/watchdog/Kconfig
>> @@ -271,6 +271,8 @@ config IOP_WATCHDOG
>>   config DAVINCI_WATCHDOG
>>       tristate "DaVinci watchdog"
>>       depends on ARCH_DAVINCI
>> +    select WATCHDOG_CORE
>> +    select WATCHDOG_NOWAYOUT
>
> Is this mandatory, ie is it correct that the watchdog can not be stopped
> once started ?
>
> Assuming it is,

Yes, it is. Davinci WDT can't be stopped and once it's expired - it can 
be rearmed only after hardware reset.

>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>

Thanks a lot for your review.

Regards,
-grygorii
