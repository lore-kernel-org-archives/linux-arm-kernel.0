From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 18 May 2012 08:37:16 +0100
Subject: [PATCH 3/7] drivers/gpio: gpio-nomadik: Apply Device Tree bindings
In-Reply-To: <20120517213342.41A773E0621@localhost>
References: <1334325909-5779-1-git-send-email-lee.jones@linaro.org>
 <1334325909-5779-4-git-send-email-lee.jones@linaro.org>
 <20120517213342.41A773E0621@localhost>
Message-ID: <4FB5FC2C.8090903@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/05/12 22:33, Grant Likely wrote:
> On Fri, 13 Apr 2012 15:05:05 +0100, Lee Jones<lee.jones@linaro.org>  wrote:
>> Signed-off-by: Lee Jones<lee.jones@linaro.org>
>
> Looks pretty good to me.  A few comments below, but otherwise you can
> add my:
>
> Acked-by: Grant Likely<grant.likely@secretlab.ca>
>
> Does this need to be merged via the arm-soc tree?

It's already been merged.

>> +	if (np) {
>> +		pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
>
> devm_kzalloc()

Yep, I can do that. I'll submit a follow-up patch.

>> +		if (!pdata)
>> +			return -ENOMEM;
>> +
>> +		if (of_get_property(np, "supports-sleepmode", NULL))
>> +			pdata->supports_sleepmode = true;
>
> I believe these properties were going to be updated to add an
> "stericsson," prefix.

Yes, I made that change. Odd that it didn't make it.

I'll make the change.

>> +
>> +		if (of_property_read_u32(np, "gpio-bank",&dev->id)) {
>> +			dev_err(&dev->dev, "gpio-bank property not found\n");
>> +			ret = -EINVAL;
>> +			goto out_dt;
>> +		}
>> +
>> +		pdata->first_gpio = dev->id * NMK_GPIO_PER_CHIP;
>> +		pdata->num_gpio   = NMK_GPIO_PER_CHIP;
>> +	}
>>
>>   	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
>>   	if (!res) {
>> @@ -1117,6 +1138,7 @@ static int __devinit nmk_gpio_probe(struct platform_device *dev)
>>   		ret = -ENOMEM;
>>   		goto out_clk;
>>   	}
>> +
>
> Nit: unrelated whitespace change.

Okay, but it looks better now though, so I'll leave it if that's okay?

>>   	/*
>>   	 * The virt address in nmk_chip->addr is in the nomadik register space,
>>   	 * so we can simply convert the resource address, without remapping
>> @@ -1139,6 +1161,8 @@ static int __devinit nmk_gpio_probe(struct platform_device *dev)
>>   	chip->dev =&dev->dev;
>>   	chip->owner = THIS_MODULE;
>>
>> +	chip->of_node = np;
>> +
>>   	ret = gpiochip_add(&nmk_chip->chip);
>>   	if (ret)
>>   		goto out_free;
>> @@ -1146,12 +1170,13 @@ static int __devinit nmk_gpio_probe(struct platform_device *dev)
>>   	BUG_ON(nmk_chip->bank>= ARRAY_SIZE(nmk_gpio_chips));
>>
>>   	nmk_gpio_chips[nmk_chip->bank] = nmk_chip;
>> +
>>   	platform_set_drvdata(dev, nmk_chip);
>>
>>   	nmk_gpio_init_irq(nmk_chip);
>>
>> -	dev_info(&dev->dev, "at address %p\n",
>> -		 nmk_chip->addr);
>> +	dev_info(&dev->dev, "at address %p\n", nmk_chip->addr);
>> +
>
> Nit: unrelated change

As above.

>>   	return 0;
>>
>>   out_free:
>> @@ -1164,13 +1189,23 @@ out_release:
>>   out:
>>   	dev_err(&dev->dev, "Failure %i for GPIO %i-%i\n", ret,
>>   		  pdata->first_gpio, pdata->first_gpio+31);
>> +out_dt:
>> +	if (np)
>> +		kfree(pdata);
>> +
>>   	return ret;
>>   }
>>
>> +static const struct of_device_id nmk_gpio_match[] = {
>> +	{ .compatible = "st,nomadik-gpio", },
>> +	{}
>> +};
>> +
>>   static struct platform_driver nmk_gpio_driver = {
>>   	.driver = {
>>   		.owner = THIS_MODULE,
>>   		.name = "gpio",
>> +		.of_match_table = nmk_gpio_match,
>>   	},
>>   	.probe = nmk_gpio_probe,
>>   };
>> --
>> 1.7.9.1
>>
>


-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
