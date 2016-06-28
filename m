From: a0393675@ti.com (Keerthy)
Date: Tue, 28 Jun 2016 12:29:58 +0530
Subject: [PATCH v3 06/10] gpio: tps65218: Remove the compatible
In-Reply-To: <20160628065235.GC6720@dell>
References: <1467093980-11458-1-git-send-email-j-keerthy@ti.com>
 <1467093980-11458-7-git-send-email-j-keerthy@ti.com>
 <20160628065235.GC6720@dell>
Message-ID: <5772206E.7020509@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 28 June 2016 12:22 PM, Lee Jones wrote:
> On Tue, 28 Jun 2016, Keerthy wrote:
>
>> Remove the individual compatible for the gpio module.
>> Introduce id_table and update the driver accordingly
>> to parse device tree nodes by just using the mfd compatible.
>
> Aren't there any OF calls in this driver?
>

There is one assignment.

ps65218_gpio->gpio_chip.of_node = pdev->dev.of_node;


> You can use the MFD API to pass through compatible strings in order to
> interrogate the DT in the normal way.  There isn't usually a reason to
> remove DT support just because you start using the MFD API.

Okay. I will do it the way i am doing for tps65218-pwrbutton.

Thanks for the review.

>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>   drivers/gpio/gpio-tps65218.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpio/gpio-tps65218.c b/drivers/gpio/gpio-tps65218.c
>> index 0f9d9bd..06fd61f 100644
>> --- a/drivers/gpio/gpio-tps65218.c
>> +++ b/drivers/gpio/gpio-tps65218.c
>> @@ -225,19 +225,19 @@ static int tps65218_gpio_remove(struct platform_device *pdev)
>>   	return 0;
>>   }
>>
>> -static const struct of_device_id tps65218_dt_match[] = {
>> -	{ .compatible = "ti,tps65218-gpio" },
>> -	{  }
>> +static const struct platform_device_id tps65218_gpio_id_table[] = {
>> +	{ "tps65218-gpio", },
>> +	{ /* sentinel */ }
>>   };
>> -MODULE_DEVICE_TABLE(of, tps65218_dt_match);
>> +MODULE_DEVICE_TABLE(platform, tps65218_gpio_id_table);
>>
>>   static struct platform_driver tps65218_gpio_driver = {
>>   	.driver = {
>>   		.name = "tps65218-gpio",
>> -		.of_match_table = of_match_ptr(tps65218_dt_match)
>>   	},
>>   	.probe = tps65218_gpio_probe,
>>   	.remove = tps65218_gpio_remove,
>> +	.id_table = tps65218_gpio_id_table,
>>   };
>>
>>   module_platform_driver(tps65218_gpio_driver);
>
