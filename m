From: ore@pengutronix.de (Oleksij Rempel)
Date: Tue, 26 Sep 2017 07:17:32 +0200
Subject: [PATCH v3 1/2] watchdog: dw_wdt: add stop watchdog operation
In-Reply-To: <20170925161643.GA32601@roeck-us.net>
References: <20170925052531.1692-1-o.rempel@pengutronix.de>
 <20170925161643.GA32601@roeck-us.net>
Message-ID: <2203f151-99c8-6c58-8766-70813fafe64d@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 25.09.2017 18:16, Guenter Roeck wrote:
> On Mon, Sep 25, 2017 at 07:25:30AM +0200, Oleksij Rempel wrote:
>> From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
>>
>> The only way of stopping the watchdog is by resetting it.
>> Add the watchdog op for stopping the device and reset if
>> a reset line is provided.
>>
>> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
>> Cc: Wim Van Sebroeck <wim@iguana.be>
>> Cc: Guenter Roeck <linux@roeck-us.net>
>> Cc: linux-watchdog at vger.kernel.org
>> ---
>>
>> changes v3:
>>   - don't return error if rst is not present and set WDOG_HW_RUNNING bit
>>     to notify watchdog core.
>>
>> changes v2:
>>   - test if dw_wdt->rst is NULL instead of IS_ERR
>>
>>   drivers/watchdog/dw_wdt.c | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
>> index 36be987ff9ef..6cc56b18ee52 100644
>> --- a/drivers/watchdog/dw_wdt.c
>> +++ b/drivers/watchdog/dw_wdt.c
>> @@ -135,6 +135,21 @@ static int dw_wdt_start(struct watchdog_device *wdd)
>>   	return 0;
>>   }
>>   
>> +static int dw_wdt_stop(struct watchdog_device *wdd)
>> +{
>> +	struct dw_wdt *dw_wdt = to_dw_wdt(wdd);
>> +
>> +	if (!dw_wdt->rst) {
>> +		set_bit(WDOG_HW_RUNNING, &wdd->status);
> 
> Setting WDOG_HW_RUNNING should be dropped from dw_wdt_start().

you mean, this patch is OK, and i need to provide one more which is 
removing WDOG_HW_RUNNING from dw_wdt_start(). Correct?

Regards,
Oleksij
