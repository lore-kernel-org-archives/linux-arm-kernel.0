From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Sun, 31 May 2015 13:06:46 +0530
Subject: [PATCH 11/12] i2c:pxa: Use devm_ variants in probe function
In-Reply-To: <878uc6xdsd.fsf@belgarion.home>
References: <1432818224-17070-1-git-send-email-vaibhav.hiremath@linaro.org>	<1432818224-17070-12-git-send-email-vaibhav.hiremath@linaro.org>
 <878uc6xdsd.fsf@belgarion.home>
Message-ID: <556ABA0E.7050205@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Saturday 30 May 2015 09:23 PM, Robert Jarzmik wrote:
> Vaibhav Hiremath <vaibhav.hiremath@linaro.org> writes:
>
>> @@ -1270,10 +1270,17 @@ static int i2c_pxa_probe(struct platform_device *dev)
>>   	struct resource *res = NULL;
>>   	int ret, irq;
>>
>> -	i2c = kzalloc(sizeof(struct pxa_i2c), GFP_KERNEL);
>> +	i2c = devm_kzalloc(&dev->dev, sizeof(struct pxa_i2c), GFP_KERNEL);
>>   	if (!i2c) {
>> -		ret = -ENOMEM;
>> -		goto emalloc;
>> +		dev_err(&dev->dev, "memory allocation failed\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
>> +	irq = platform_get_irq(dev, 0);
>> +	if (res == NULL || irq < 0) {
>> +		dev_err(&dev->dev, "no mem/irq resource\n");
>> +		return -ENODEV;
> I'd like to have the error code here, as in other part of the driver.
> Ie. I'd want :
>      dev_err(&dev->dev, "no mem/irq resource: %d\n", irq);
>
> Moreover, return -ENODEV if res == NULL, but return irq if irq < 0 (think of
> -EPROBE_DEFER).
>

Good point.

I will change it in next version.


>> +	i2c->reg_base = devm_ioremap_resource(&dev->dev, res);
>>   	if (!i2c->reg_base) {
> if (IS_ERR(i2c->reg_base)) instead.
>
>> -		ret = -EIO;
>> -		goto eremap;
>> +		dev_err(&dev->dev, "failed to map resource\n");
>> +		return -EIO;
> Ditto, ie. include PTR_ERR(i2c->reg_base) in the dev_err(), and return
> PTR_ERR(i2c->reg_base);
>

Ok.

>> @@ -1361,11 +1356,13 @@ static int i2c_pxa_probe(struct platform_device *dev)
>>   		i2c->adap.algo = &i2c_pxa_pio_algorithm;
>>   	} else {
>>   		i2c->adap.algo = &i2c_pxa_algorithm;
>> -		ret = request_irq(irq, i2c_pxa_handler,
>> +		ret = devm_request_irq(&dev->dev, irq, i2c_pxa_handler,
>>   				IRQF_SHARED | IRQF_NO_SUSPEND,
>>   				dev_name(&dev->dev), i2c);
>> -		if (ret)
>> +		if (ret) {
>> +			dev_err(&dev->dev, "failed to request irq\n");
> Ditto for the dev_err() and error code reporting.
>
>> @@ -1380,8 +1377,8 @@ static int i2c_pxa_probe(struct platform_device *dev)
>>
>>   	ret = i2c_add_numbered_adapter(&i2c->adap);
>>   	if (ret < 0) {
>> -		printk(KERN_INFO "I2C: Failed to add bus\n");
>> -		goto eadapt;
>> +		dev_err(&dev->dev, "failed to add bus\n");
> Ditto.
>
>> @@ -1411,26 +1408,15 @@ static int i2c_pxa_probe(struct platform_device *dev)
>>   		}
>>   	}
>>   #ifdef CONFIG_I2C_PXA_SLAVE
>> -	printk(KERN_INFO "I2C: %s: PXA I2C adapter, slave address %d\n",
>> +	pr_info("I2C: %s: PXA I2C adapter, slave address %d\n",
>>   	       dev_name(&i2c->adap.dev), i2c->slave_addr);
> dev_info() maybe ?
>
>>   #else
>> -	printk(KERN_INFO "I2C: %s: PXA I2C adapter\n",
>> -	       dev_name(&i2c->adap.dev));
>> +	pr_info("I2C: %s: PXA I2C adapter\n", dev_name(&i2c->adap.dev));
> Ditto.
>

Agreed to all your comments.
I will change the code in next version.

Thanks,
Vaibhav
