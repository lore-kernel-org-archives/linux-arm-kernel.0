From: voice.shen@atmel.com (Bo Shen)
Date: Wed, 19 Sep 2012 09:15:08 +0800
Subject: [PATCH] i2c: i2c-gpio: fix issue when DT node greater than 1
In-Reply-To: <50588A8F.30203@wwwdotorg.org>
References: <1347958949-5598-1-git-send-email-voice.shen@atmel.com>
 <50588A8F.30203@wwwdotorg.org>
Message-ID: <50591C9C.2080809@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen Warren,

On 9/18/2012 22:51, Stephen Warren wrote:
> On 09/18/2012 03:02 AM, Bo Shen wrote:
>> When i2c-gpio node number is greater than 1, the second can not sucessfully
>> regiter
>>
>> Using alias method to get the pdev->id, or else the second device will use
>> the same id which will cause fail to register
>
> pdev->id shouldn't be used at all with device tree. Why does
> registration fail without this change?

I add the debug info, and it give the following error without this patch.

--<8----------------------------------
adap->name = i2c-gpio-1
i2c-gpio i2c.2: using pins 30 (SDA) and 31 (SCL)
adap->name = i2c-gpio-1
i2c-gpio: probe of i2c.3 failed with error -16
-->8----------------------------------

With this patch, it successfully registered.
--<8----------------------------------
adap->name = i2c-gpio0
i2c-gpio i2c.2: using pins 30 (SDA) and 31 (SCL)
adap->name = i2c-gpio1
i2c-gpio i2c.3: using pins 90 (SDA) and 91 (SCL)
-->8----------------------------------

>
>> diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
>> index e62d2d9..051fbb3 100644
>> --- a/drivers/i2c/busses/i2c-gpio.c
>> +++ b/drivers/i2c/busses/i2c-gpio.c
>> @@ -136,6 +136,7 @@ static int __devinit i2c_gpio_probe(struct platform_device *pdev)
>>   		ret = of_i2c_gpio_probe(pdev->dev.of_node, pdata);
>>   		if (ret)
>>   			return ret;
>> +		pdev->id = of_alias_get_id(pdev->dev.of_node, "i2c-gpio");
>>   	} else {
>>   		if (!pdev->dev.platform_data)
>>   			return -ENXIO;
>>
>
>
