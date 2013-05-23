From: b32955@freescale.com (Huang Shijie)
Date: Thu, 23 May 2013 17:35:42 +0800
Subject: [PATCH V2 1/6] drivers: bus: add a new driver for WEIM
In-Reply-To: <20130523092344.GF32299@pengutronix.de>
References: <1369296978-7669-1-git-send-email-b32955@freescale.com>
 <1369296978-7669-2-git-send-email-b32955@freescale.com>
 <20130523092344.GF32299@pengutronix.de>
Message-ID: <519DE2EE.1050006@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?05?23? 17:23, Sascha Hauer ??:
> On Thu, May 23, 2013 at 04:16:13PM +0800, Huang Shijie wrote:
>> +			<cs-number>  0<physical address of mapping>  <size>
>> +
>> +Timing property for child nodes. It is mandatory, not optional.
>> +
>> + - fsl,weim-cs-timing:	The timing array, contains 6 timing values for the
>> +			child node. We can get the CS index from the child
>> +			node's "reg" property.
> This should be more detailed, something like:
>
> This contains the values for the registers EIM_CSnGCR1, EIM_CSnGCR2,
> EIM_CSnRCR1, EIM_CSnRCR2, EIM_CSnWCR1, EIM_CSnWCR2 in this order.
>


do you mean i should add some new properties, such as
"fsl,eim_csnrcr1", "fsl,eim_csnrcr2" ...
>> +static int weim_parse_dt(struct platform_device *pdev)
>> +{
>> +	struct device_node *child;
>> +	int ret;
>> +
>> +	for_each_child_of_node(pdev->dev.of_node, child) {
>> +		if (!child->name)
>> +			continue;
>> +
>> +		ret = weim_timing_setup(pdev, child);
>> +		if (ret)
>> +			goto parse_fail;
>> +
>> +		if (!of_platform_device_create(child, NULL,&pdev->dev)) {
>> +			ret = -EINVAL;
>> +			goto parse_fail;
>> +		}
> I would print some warning here for the failures in this loop, but I
> don't think it's necessary to bail out. No need to make all WEIM devices
> fail if one has an erroneous device node.
>
ok.
>> +
>> +	/* get the resource */
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	weim->base = devm_ioremap_resource(&pdev->dev, res);
>> +	if (IS_ERR(weim->base)) {
>> +		ret = PTR_ERR(weim->base);
>> +		goto weim_err;
>> +	}
>> +
>> +	/* get the clock */
>> +	weim->clk = devm_clk_get(&pdev->dev, NULL);
>> +	if (IS_ERR(weim->clk))
>> +		goto weim_err;
>> +
>> +	clk_prepare_enable(weim->clk);
>> +
>> +	/* parse the device node */
>> +	ret = weim_parse_dt(pdev);
>> +	if (ret) {
>> +		clk_disable_unprepare(weim->clk);
>> +		goto weim_err;
>> +	}
>> +
>> +	dev_info(&pdev->dev, "WEIM driver registered.\n");
>> +	return 0;
>> +
>> +weim_err:
>> +	return ret;
>> +}
>> +
>> +static int weim_remove(struct platform_device *pdev)
>> +{
>> +	struct imx_weim *weim = platform_get_drvdata(pdev);
>> +
>> +	clk_disable_unprepare(weim->clk);
> Once again: Is this clock needed for the child devices? If yes, you
> can't disable it here and leave the child devices registered.
>
again. yes. we need this clock.


thanks
Huang Shijie
