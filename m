From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 14 May 2012 16:49:21 +0100
Subject: [PATCH 14/15] drivers/regulators: Enable the ab8500 for Device
 Tree
In-Reply-To: <20120507170832.GO17002@opensource.wolfsonmicro.com>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
 <1336155805-18554-15-git-send-email-lee.jones@linaro.org>
 <20120507170832.GO17002@opensource.wolfsonmicro.com>
Message-ID: <4FB12981.8050603@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Looking at this now.

>> +static __devinit int
>> +ab8500_regulator_of_probe(struct platform_device *pdev, struct device_node *np)
>> +{
>> +	struct regulator_init_data *ab8500_regulator;
>> +	struct device_node *child;
>> +	int err, value, i, id = 0;
>> +
>> +	/* Initialise regulator registers to platform specific values. */
>> +	for (i = 0; i<  ARRAY_SIZE(ab8500_reg_init); i++) {
>> +		err = of_property_read_u32(np, ab8500_reg_init[i].of_name,&value);
>> +		if (err<  0)
>> +			return err;
>> +
>> +		err = ab8500_regulator_init_registers(pdev, i, value);
>> +		if (err<  0)
>> +			return err;
>
> You should be using of_regulator_match() for this (I think it's supposed
> to do an equivalent job...) rather than open coding.

I've ripped this out completely and the code appears to continue be 
fully functional. Happy days! :)

>> +	/* Register each ab8500 regulator found in the Device Tree. */
>> +	for_each_child_of_node(np, child) {
>> +		ab8500_regulator = of_get_regulator_init_data(&pdev->dev, child);
>
> Definitely don't do this - you should unconditionally register all the
> regulators that physically exist, this allows users to inspect their
> state even if they aren't used.
>
> It's possible the original driver has this bug (I didn't check but

The original driver places each of the registers inside a structure 
within the driver itself and recursively registers them from there. The 
constraints are united with the correct element using #defines.

Can't we just assume that all of the regulators will be put into the 
Device Tree? As this is what I'll be doing.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
