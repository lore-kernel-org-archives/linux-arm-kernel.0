From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 31 Jul 2014 16:16:17 +0300
Subject: [PATCH 2/2] clk: initial clock driver for TWL6030
In-Reply-To: <53DA2F53.8010405@kpanic.de>
References: <1406728949-7560-1-git-send-email-sassmann@kpanic.de>
 <1406728949-7560-3-git-send-email-sassmann@kpanic.de>
 <20140730175033.GA17528@sirena.org.uk> <53DA12BF.1060008@kpanic.de>
 <53DA284D.6030404@ti.com> <53DA2F53.8010405@kpanic.de>
Message-ID: <53DA41A1.5010900@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

<snip>

>>> +static int of_twl6030_clk32kg_probe(struct platform_device *pdev)
>>> +{
>>> +	struct device_node *node = pdev->dev.of_node;
>>> +	struct clk *clk;
>>> +
>>> +	if (!node)
>>> +		return -ENODEV;
>>> +
>>> +	clk = devm_clk_get(&pdev->dev, "clk32kg");
>>> +	if (IS_ERR(clk))
>>> +		return PTR_ERR(clk);
>>> +
>>> +	return clk_prepare(clk);
>>
>> This is plain wrong as pointed out earlier. The driver that uses the
>> clock must enable it.
>
> Understood. I'll change it to clk_prepare_enable().

Nono, remove it completely from here. The clock driver should not enable 
itself by default. The clock itself has some sort of customer somewhere 
(like am33xx-wifi driver), which should request for the clock and enable 
it only when needed.

-Tero
