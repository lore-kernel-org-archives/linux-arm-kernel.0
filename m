From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 04 Sep 2012 16:16:59 +0400
Subject: [PATCH v5 1/4] mfd: add syscon driver based on regmap
In-Reply-To: <20120904113545.GD4657@jack.whiskey>
References: <1346728811-25788-1-git-send-email-b29396@freescale.com>
 <1346728811-25788-2-git-send-email-b29396@freescale.com>
 <20120904113545.GD4657@jack.whiskey>
Message-ID: <5045F13B.8060409@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 04-09-2012 15:35, Andi Shyti wrote:

>> +static int __devinit syscon_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;

> Do we really need this variable? Anyway you are using it only
> once in the dev_info.

    But Dong definitely could use it more than once, so it seems useful.

>> +	struct device_node *np = dev->of_node;
>> +	struct syscon *syscon;
>> +	struct resource res;
>> +	int ret;
>> +
>> +	if (!np)
>> +		return -ENOENT;
>> +
>> +	syscon = devm_kzalloc(&pdev->dev, sizeof(struct syscon),
>> +			    GFP_KERNEL);
>> +	if (!syscon)
>> +		return -ENOMEM;
>> +
>> +	syscon->base = of_iomap(np, 0);
>> +	if (!syscon->base)
>> +		return -EADDRNOTAVAIL;
>> +
>> +	ret = of_address_to_resource(np, 0, &res);
>> +	if (ret)
>> +		return ret;
>> +
>> +	syscon_regmap_config.max_register = res.end - res.start - 3;
>> +	syscon->regmap = devm_regmap_init_mmio(&pdev->dev, syscon->base,
>> +					&syscon_regmap_config);
>> +	if (IS_ERR(syscon->regmap)) {
>> +		dev_err(&pdev->dev, "regmap init failed\n");
>> +		return PTR_ERR(syscon->regmap);
>> +	}
>> +
>> +	syscon->dev = &pdev->dev;
>> +	platform_set_drvdata(pdev, syscon);
>> +
>> +	dev_info(dev, "syscon regmap start 0x%x end 0x%x registered\n",
>> +		res.start, res.end);
>> +
>> +	return 0;

> in case of error you are not freeing syscon.

    It's allocated using devm_kzalloc(), so is freed automaticelly upon probe 
error.

> Moreover, in my opinion, some dev_err more should not heart

    Hurt, you mean?

> Andi

WBR, Sergei
