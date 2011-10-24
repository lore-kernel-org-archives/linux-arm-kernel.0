From: robherring2@gmail.com (Rob Herring)
Date: Mon, 24 Oct 2011 10:40:02 -0500
Subject: [PATCH v2] gpio: pl061: add DT binding support
In-Reply-To: <4E7BBFF5.5090001@gmail.com>
References: <1312397661-3328-1-git-send-email-robherring2@gmail.com>
	<1313011906-24161-1-git-send-email-robherring2@gmail.com>
	<4E7BBFF5.5090001@gmail.com>
Message-ID: <4EA586D2.8000100@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grant,

On 09/22/2011 06:08 PM, Rob Herring wrote:
> Grant,
> 
> On 08/10/2011 04:31 PM, Rob Herring wrote:
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> This adds devicetree binding support to the ARM pl061 driver removing the
>> platform_data dependency. When DT binding is used, the gpio numbering is
>> assigned dynamically. For now, interrupts are not supported with DT until
>> irqdomains learn dynamic irq assignment.
>>
>> Rather than add another case of -1, updating the driver to use NO_IRQ.
>>
>> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
>> Cc: Grant Likely <grant.likely@secretlab.ca>
>> ---
> 
> Ping. Any comments on this?
> 

Ping. Can you apply this for 3.2.

Rob

> Rob
>>
>> v2:
>> - Add other -1 to NO_IRQ conversions
>> - Drop DT irq support for now
>>
>>  drivers/gpio/gpio-pl061.c  |   31 +++++++++++++++++++++----------
>>  include/linux/amba/pl061.h |    3 +--
>>  2 files changed, 22 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/gpio/gpio-pl061.c b/drivers/gpio/gpio-pl061.c
>> index 2c5a18f..093c90b 100644
>> --- a/drivers/gpio/gpio-pl061.c
>> +++ b/drivers/gpio/gpio-pl061.c
>> @@ -118,7 +118,7 @@ static int pl061_to_irq(struct gpio_chip *gc, unsigned offset)
>>  {
>>  	struct pl061_gpio *chip = container_of(gc, struct pl061_gpio, gc);
>>  
>> -	if (chip->irq_base == (unsigned) -1)
>> +	if (chip->irq_base == NO_IRQ)
>>  		return -EINVAL;
>>  
>>  	return chip->irq_base + offset;
>> @@ -246,6 +246,18 @@ static int pl061_probe(struct amba_device *dev, const struct amba_id *id)
>>  	if (chip == NULL)
>>  		return -ENOMEM;
>>  
>> +	pdata = dev->dev.platform_data;
>> +	if (pdata) {
>> +		chip->gc.base = pdata->gpio_base;
>> +		chip->irq_base = pdata->irq_base;
>> +	} else if (dev->dev.of_node) {
>> +		chip->gc.base = -1;
>> +		chip->irq_base = NO_IRQ;
>> +	} else {
>> +		ret = -ENODEV;
>> +		goto free_mem;
>> +	}
>> +
>>  	if (!request_mem_region(dev->res.start,
>>  				resource_size(&dev->res), "pl061")) {
>>  		ret = -EBUSY;
>> @@ -267,14 +279,11 @@ static int pl061_probe(struct amba_device *dev, const struct amba_id *id)
>>  	chip->gc.get = pl061_get_value;
>>  	chip->gc.set = pl061_set_value;
>>  	chip->gc.to_irq = pl061_to_irq;
>> -	chip->gc.base = pdata->gpio_base;
>>  	chip->gc.ngpio = PL061_GPIO_NR;
>>  	chip->gc.label = dev_name(&dev->dev);
>>  	chip->gc.dev = &dev->dev;
>>  	chip->gc.owner = THIS_MODULE;
>>  
>> -	chip->irq_base = pdata->irq_base;
>> -
>>  	ret = gpiochip_add(&chip->gc);
>>  	if (ret)
>>  		goto iounmap;
>> @@ -283,7 +292,7 @@ static int pl061_probe(struct amba_device *dev, const struct amba_id *id)
>>  	 * irq_chip support
>>  	 */
>>  
>> -	if (chip->irq_base == (unsigned) -1)
>> +	if (chip->irq_base == NO_IRQ)
>>  		return 0;
>>  
>>  	writeb(0, chip->base + GPIOIE); /* disable irqs */
>> @@ -307,11 +316,13 @@ static int pl061_probe(struct amba_device *dev, const struct amba_id *id)
>>  	list_add(&chip->list, chip_list);
>>  
>>  	for (i = 0; i < PL061_GPIO_NR; i++) {
>> -		if (pdata->directions & (1 << i))
>> -			pl061_direction_output(&chip->gc, i,
>> -					pdata->values & (1 << i));
>> -		else
>> -			pl061_direction_input(&chip->gc, i);
>> +		if (pdata) {
>> +			if (pdata->directions & (1 << i))
>> +				pl061_direction_output(&chip->gc, i,
>> +						pdata->values & (1 << i));
>> +			else
>> +				pl061_direction_input(&chip->gc, i);
>> +		}
>>  
>>  		irq_set_chip_and_handler(i + chip->irq_base, &pl061_irqchip,
>>  					 handle_simple_irq);
>> diff --git a/include/linux/amba/pl061.h b/include/linux/amba/pl061.h
>> index 5ddd9ad..2412af9 100644
>> --- a/include/linux/amba/pl061.h
>> +++ b/include/linux/amba/pl061.h
>> @@ -7,8 +7,7 @@ struct pl061_platform_data {
>>  	unsigned	gpio_base;
>>  
>>  	/* number of the first IRQ.
>> -	 * If the IRQ functionality in not desired this must be set to
>> -	 * (unsigned) -1.
>> +	 * If the IRQ functionality in not desired this must be set to NO_IRQ.
>>  	 */
>>  	unsigned	irq_base;
>>  
> 
