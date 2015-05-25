From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 25 May 2015 14:44:28 +0800
Subject: [PATCH v4 1/6] rtc: arm: imx: snvs: change use syscon to access
 register
In-Reply-To: <1432305399-30571-2-git-send-email-Frank.Li@freescale.com>
References: <1432305399-30571-1-git-send-email-Frank.Li@freescale.com>
 <1432305399-30571-2-git-send-email-Frank.Li@freescale.com>
Message-ID: <20150525064427.GG3264@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 22, 2015 at 10:36:34PM +0800, Frank.Li at freescale.com wrote:
>  static int snvs_rtc_probe(struct platform_device *pdev)
>  {
>  	struct snvs_rtc_data *data;
>  	struct resource *res;
>  	int ret;
> +	struct device_node *snvs_np;
> +	void __iomem *mmio;
>  
>  	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
>  	if (!data)
>  		return -ENOMEM;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	data->ioaddr = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(data->ioaddr))
> -		return PTR_ERR(data->ioaddr);
> +	snvs_np = of_get_parent(pdev->dev.of_node);
> +	if (!snvs_np)
> +		return -ENODEV;
> +
> +	if (of_device_is_compatible(snvs_np, "syscon")) {
> +		data->regmap = syscon_node_to_regmap(snvs_np);
> +		data->offset = 0x34;

As I commented on dts patch, we should probably follow syscon-poweroff
to have 'regmap' and 'offset' properties.

Shawn

> +	} else {
> +		pr_warn("snvs rtc: you use old dts file, please update it\n");
> +		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +
> +		mmio = devm_ioremap_resource(&pdev->dev, res);
> +		if (IS_ERR(mmio))
> +			return PTR_ERR(mmio);
> +
> +		data->regmap = devm_regmap_init_mmio(&pdev->dev, mmio, &snvs_rtc_config);
> +	}
> +
> +	of_node_put(snvs_np);
> +
> +	if (!data->regmap) {
> +		pr_err("Can't snvs syscon\n");
> +		return -ENODEV;
> +	}
>  
>  	data->irq = platform_get_irq(pdev, 0);
>  	if (data->irq < 0)
> @@ -276,13 +282,11 @@ static int snvs_rtc_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, data);
>  
> -	spin_lock_init(&data->lock);
> -
>  	/* Initialize glitch detect */
> -	writel(SNVS_LPPGDR_INIT, data->ioaddr + SNVS_LPPGDR);
> +	regmap_write(data->regmap, data->offset + SNVS_LPPGDR, SNVS_LPPGDR_INIT);
>  
>  	/* Clear interrupt status */
> -	writel(0xffffffff, data->ioaddr + SNVS_LPSR);
> +	regmap_write(data->regmap, data->offset + SNVS_LPSR, 0xffffffff);
>  
>  	/* Enable RTC */
>  	snvs_rtc_enable(data, true);
> -- 
> 1.9.1
> 
