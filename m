From: j-keerthy@ti.com (Keerthy)
Date: Tue, 18 Jul 2017 23:15:18 +0530
Subject: [PATCH 1/4] gpio: davinci: Use devm_gpiochip_add_data in place of
 gpiochip_add_data
In-Reply-To: <0aa79585-c88e-e5b7-c260-6e9ceee6d776@ti.com>
References: <1500375436-9435-1-git-send-email-j-keerthy@ti.com>
 <1500375436-9435-2-git-send-email-j-keerthy@ti.com>
 <0aa79585-c88e-e5b7-c260-6e9ceee6d776@ti.com>
Message-ID: <bd21705e-cf64-572e-ef21-42b9c7f41f1b@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 18 July 2017 10:20 PM, Suman Anna wrote:
> Hi Keerthy,
> 
> On 07/18/2017 05:57 AM, Keerthy wrote:
>> Use the devm version of gpiochip_add_data and pass on the
>> return value. Reset the static variables to 0 before returning.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>  drivers/gpio/gpio-davinci.c | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
>> index 65cb359..2c88054 100644
>> --- a/drivers/gpio/gpio-davinci.c
>> +++ b/drivers/gpio/gpio-davinci.c
>> @@ -166,7 +166,7 @@ static int davinci_gpio_get(struct gpio_chip *chip, unsigned offset)
>>  static int davinci_gpio_probe(struct platform_device *pdev)
>>  {
>>  	static int ctrl_num, bank_base;
>> -	int gpio, bank;
>> +	int gpio, bank, ret = 0;
>>  	unsigned ngpio, nbank;
>>  	struct davinci_gpio_controller *chips;
>>  	struct davinci_gpio_platform_data *pdata;
>> @@ -232,7 +232,13 @@ static int davinci_gpio_probe(struct platform_device *pdev)
>>  	for (gpio = 0, bank = 0; gpio < ngpio; gpio += 32, bank++)
>>  		chips->regs[bank] = gpio_base + offset_array[bank];
>>  
>> -	gpiochip_add_data(&chips->chip, chips);
>> +	ret = devm_gpiochip_add_data(dev, &chips->chip, chips);
>> +	if (ret) {
>> +		ctrl_num = 0;
>> +		bank_base = 0;
> 
> Hmm, this doesn't look right to me. These variables are defined as
> static, and you are resetting them unconditionally. This should be an
> issue when you have multiple devices and one of them fails.

Agreed. With multiple instances this can reset the successful count also.

Upon failure in any iteration, the following should take care of those
static variables:

/* Revert the static variable increments */
        ctrl_num--;
        bank_base -= ngpio;

Thanks for the quick review!

Reagrds,
Keerthy

> 
> regards
> Suman
> 
>> +		return ret;
>> +	}
>> +
>>  	platform_set_drvdata(pdev, chips);
>>  	davinci_gpio_irq_setup(pdev);
>>  	return 0;
>>
> 
