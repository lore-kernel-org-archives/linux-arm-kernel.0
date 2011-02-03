From: grinberg@compulab.co.il (Igor Grinberg)
Date: Thu, 03 Feb 2011 18:29:03 +0200
Subject: [PATCH v3 1/2] ads7846: fix gpio free without requesting
In-Reply-To: <20110203154705.GE6508@pengutronix.de>
References: <1296746486-12168-1-git-send-email-sourav.poddar@ti.com>
	<20110203154705.GE6508@pengutronix.de>
Message-ID: <4D4AD7CF.7040103@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 02/03/11 17:47, Wolfram Sang wrote:

> On Thu, Feb 03, 2011 at 08:51:26PM +0530, Sourav Poddar wrote:
>> gpio_pendown in ads7846_probe is not getting initalized (defaulted to 0)
>> resulting in gpio_free being called without a gpio_request. This
>> results in the following backtrace in bootup (at least on an OMAP3430 SDP).
> I wonder if it makes sense to merge both patches under the name of "fix
> gpio-handling" or similar. Not sure, though...

I'd rather not do that, because this patch fixes the request/free problem
and the second is changing the functionality (e.g. configures the gpio as input)

>> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
>> index 14ea54b..ce5baee 100644
>> --- a/drivers/input/touchscreen/ads7846.c
>> +++ b/drivers/input/touchscreen/ads7846.c
>> @@ -952,6 +952,7 @@ static int __devinit ads7846_setup_pendown(struct spi_device *spi, struct ads784
>>  
>>  	if (pdata->get_pendown_state) {
>>  		ts->get_pendown_state = pdata->get_pendown_state;
>> +		ts->gpio_pendown = -EINVAL;
>>  		return 0;
>>  	}
> Will probably work, but maybe it is better to reorganize the code to
> just have one success-exit-point. That would be mean adding an else
> branch to this if-block.

This is something that can be done, though I fear the code readability
will suffer. Is it worth?

>>  
>> @@ -1353,7 +1354,7 @@ static int __devinit ads7846_probe(struct spi_device *spi)
>>   err_put_regulator:
>>  	regulator_put(ts->reg);
>>   err_free_gpio:
>> -	if (ts->gpio_pendown != -1)
>> +	if (gpio_is_valid(ts->gpio_pendown))
> You could do the same in the remove-path.

You mean, _should_... ;)
Otherwise, the patch is not complete.

-- 
Regards,
Igor.
