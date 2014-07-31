From: sassmann@kpanic.de (Stefan Assmann)
Date: Thu, 31 Jul 2014 13:58:11 +0200
Subject: [PATCH 2/2] clk: initial clock driver for TWL6030
In-Reply-To: <53DA284D.6030404@ti.com>
References: <1406728949-7560-1-git-send-email-sassmann@kpanic.de>
 <1406728949-7560-3-git-send-email-sassmann@kpanic.de>
 <20140730175033.GA17528@sirena.org.uk> <53DA12BF.1060008@kpanic.de>
 <53DA284D.6030404@ti.com>
Message-ID: <53DA2F53.8010405@kpanic.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31.07.2014 13:28, Tero Kristo wrote:

[...]

>> diff --git a/drivers/clk/ti/clk-6030.c b/drivers/clk/ti/clk-6030.c
>> new file mode 100644
>> index 0000000..61d1834
>> --- /dev/null
>> +++ b/drivers/clk/ti/clk-6030.c
> 
> Please change the filename to something like clk-twl6030.c. clk-\d+ 
> filenames basically denote a SoC under TI clock driver structure.

Ok.

> 
>> @@ -0,0 +1,133 @@
>> +/*
>> + * drivers/clk/ti/clk-6030.c
> 
> Replace this with some sort of short description instead, see other 
> files under drivers/clk/ti. Having an absolute filename here doesn't 
> really provide anything.

Ok.

> 
>> + *
>> + *  Copyright (C) 2014 Stefan Assmann <sassmann@kpanic.de>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * Clock driver for TI twl6030.
>> + */
> 
> A basic comment about this driver, how about trying to make it more 
> generic, as in making it an i2c-clock driver? I guess there are other 
> external chips/boards outside twl6030 family that would be interested in 
> using it.

I'll look into that.

[...]

>> +static int of_twl6030_clk32kg_probe(struct platform_device *pdev)
>> +{
>> +	struct device_node *node = pdev->dev.of_node;
>> +	struct clk *clk;
>> +
>> +	if (!node)
>> +		return -ENODEV;
>> +
>> +	clk = devm_clk_get(&pdev->dev, "clk32kg");
>> +	if (IS_ERR(clk))
>> +		return PTR_ERR(clk);
>> +
>> +	return clk_prepare(clk);
> 
> This is plain wrong as pointed out earlier. The driver that uses the 
> clock must enable it.

Understood. I'll change it to clk_prepare_enable().

[...]

>> diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
>> index db11b4f..440fe4e 100644
>> --- a/drivers/mfd/twl-core.c
>> +++ b/drivers/mfd/twl-core.c
>> @@ -34,6 +34,7 @@
>>   #include <linux/platform_device.h>
>>   #include <linux/regmap.h>
>>   #include <linux/clk.h>
>> +#include <linux/clk-provider.h>
>>   #include <linux/err.h>
>>   #include <linux/device.h>
>>   #include <linux/of.h>
>> @@ -1012,6 +1013,8 @@ static void clocks_init(struct device *dev,
>>   	u32 rate;
>>   	u8 ctrl = HFCLK_FREQ_26_MHZ;
>>
>> +	of_clk_init(NULL);
>> +
> 
> Don't do this please, this is horrible. of_clk_init or alternatives 
> should be called from board/SoC specific context, otherwise you end up 
> calling the init functions multiple times. If you are facing an issue 
> that TI boards do not initialize external clocks properly currently, 
> this is because TI clock driver does its init hierarchically and does 
> not parse the whole DT for clock nodes. I have an experimental patch 
> available I can post for you to try out which provides external clock 
> support on TI boards if you like.

If you could provide that patch that'll be great.

Thanks for the comments Tero.

  Stefan
