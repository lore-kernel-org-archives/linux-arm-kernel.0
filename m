From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 25 Jan 2016 12:37:38 +0000
Subject: [PATCH V2 3/4] mfd: mediatek: add support for different Slave
 types
In-Reply-To: <1453716887-38442-4-git-send-email-blogic@openwrt.org>
References: <1453716887-38442-1-git-send-email-blogic@openwrt.org>
 <1453716887-38442-4-git-send-email-blogic@openwrt.org>
Message-ID: <20160125123738.GF3368@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 25 Jan 2016, John Crispin wrote:

> Signed-off-by: John Crispin <blogic@openwrt.org>
> ---
>  drivers/mfd/mt6397-core.c |   38 +++++++++++++++++++++++++++++++-------
>  1 file changed, 31 insertions(+), 7 deletions(-)

For my own reference:
  Acked-by: Lee Jones <lee.jones@linaro.org>
 
> diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
> index 75ad0fe..51e194b 100644
> --- a/drivers/mfd/mt6397-core.c
> +++ b/drivers/mfd/mt6397-core.c
> @@ -24,6 +24,9 @@
>  #define MT6397_RTC_BASE		0xe000
>  #define MT6397_RTC_SIZE		0x3e
>  
> +#define MT6391_CID_CODE		0x91
> +#define MT6397_CID_CODE		0x97
> +
>  static const struct resource mt6397_rtc_resources[] = {
>  	{
>  		.start = MT6397_RTC_BASE,
> @@ -232,6 +235,7 @@ static SIMPLE_DEV_PM_OPS(mt6397_pm_ops, mt6397_irq_suspend,
>  static int mt6397_probe(struct platform_device *pdev)
>  {
>  	int ret;
> +	unsigned int id;
>  	struct mt6397_chip *mt6397;
>  
>  	mt6397 = devm_kzalloc(&pdev->dev, sizeof(*mt6397), GFP_KERNEL);
> @@ -239,10 +243,6 @@ static int mt6397_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	mt6397->dev = &pdev->dev;
> -	mt6397->int_con[0] = MT6397_INT_CON0;
> -	mt6397->int_con[1] = MT6397_INT_CON1;
> -	mt6397->int_status[0] = MT6397_INT_STATUS0;
> -	mt6397->int_status[1] = MT6397_INT_STATUS1;
>  
>  	/*
>  	 * mt6397 MFD is child device of soc pmic wrapper.
> @@ -254,6 +254,29 @@ static int mt6397_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, mt6397);
>  
> +	ret = regmap_read(mt6397->regmap, MT6397_CID, &id);
> +	if (ret) {
> +		dev_err(mt6397->dev, "Failed to read chip id: %d\n", ret);
> +		goto fail_irq;
> +	}
> +
> +	switch (id & 0xff) {
> +	case MT6397_CID_CODE:
> +	case MT6391_CID_CODE:
> +		mt6397->int_con[0] = MT6397_INT_CON0;
> +		mt6397->int_con[1] = MT6397_INT_CON1;
> +		mt6397->int_status[0] = MT6397_INT_STATUS0;
> +		mt6397->int_status[1] = MT6397_INT_STATUS1;
> +		ret = mfd_add_devices(&pdev->dev, -1, mt6397_devs,
> +				ARRAY_SIZE(mt6397_devs), NULL, 0, NULL);
> +		break;
> +
> +	default:
> +		dev_err(&pdev->dev, "unsupported chip: %d\n", id);
> +		ret = -ENODEV;
> +		break;
> +	}
> +
>  	mt6397->irq = platform_get_irq(pdev, 0);
>  	if (mt6397->irq > 0) {
>  		ret = mt6397_irq_init(mt6397);
> @@ -261,10 +284,11 @@ static int mt6397_probe(struct platform_device *pdev)
>  			return ret;
>  	}
>  
> -	ret = mfd_add_devices(&pdev->dev, -1, mt6397_devs,
> -			ARRAY_SIZE(mt6397_devs), NULL, 0, NULL);
> -	if (ret)
> +fail_irq:
> +	if (ret) {
> +		irq_domain_remove(mt6397->irq_domain);
>  		dev_err(&pdev->dev, "failed to add child devices: %d\n", ret);
> +	}
>  
>  	return ret;
>  }

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
