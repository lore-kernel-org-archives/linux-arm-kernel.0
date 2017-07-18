From: j-keerthy@ti.com (Keerthy)
Date: Tue, 18 Jul 2017 23:16:07 +0530
Subject: [PATCH 2/4] gpio: davinci: Handle the return value of
 davinci_gpio_irq_setup function
In-Reply-To: <fcf0b39c-2683-e88d-b619-8ff66707b099@ti.com>
References: <1500375436-9435-1-git-send-email-j-keerthy@ti.com>
 <1500375436-9435-3-git-send-email-j-keerthy@ti.com>
 <fcf0b39c-2683-e88d-b619-8ff66707b099@ti.com>
Message-ID: <f8f33c82-6f08-bd8c-ecbb-df1f1c719624@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 18 July 2017 10:24 PM, Suman Anna wrote:
> Hi Keerthy,
> 
> On 07/18/2017 05:57 AM, Keerthy wrote:
>> Currently davinci_gpio_irq_setup return value is ignored. Handle the
>> return value appropriately.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>  drivers/gpio/gpio-davinci.c | 18 +++++++++++++-----
>>  1 file changed, 13 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
>> index 2c88054..932f270 100644
>> --- a/drivers/gpio/gpio-davinci.c
>> +++ b/drivers/gpio/gpio-davinci.c
>> @@ -233,15 +233,23 @@ static int davinci_gpio_probe(struct platform_device *pdev)
>>  		chips->regs[bank] = gpio_base + offset_array[bank];
>>  
>>  	ret = devm_gpiochip_add_data(dev, &chips->chip, chips);
>> +	if (ret)
>> +		goto err;
>> +
>> +	platform_set_drvdata(pdev, chips);
>> +	ret = davinci_gpio_irq_setup(pdev);
>>  	if (ret) {
>> -		ctrl_num = 0;
>> -		bank_base = 0;
>> -		return ret;
>> +		platform_set_drvdata(pdev, NULL);
> 
> This is not needed, driver core will set this automatically if probe fails.

okay. I will remove this.

> 
>> +		goto err;
>>  	}
>>  
>> -	platform_set_drvdata(pdev, chips);
>> -	davinci_gpio_irq_setup(pdev);
>>  	return 0;
>> +
>> +err:
>> +	ctrl_num = 0;
>> +	bank_base = 0;
> 
> Same comments as on Patch 1.

Yup will fix this as i have done with Patch 1.

> 
> regards
> Suman
> 
