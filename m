From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 14 Feb 2014 13:48:15 +0000
Subject: [PATCH 1/2] mfd: twl4030-madc: Add devicetree support.
In-Reply-To: <1392383861-14169-1-git-send-email-marek@goldelico.com>
References: <1392383861-14169-1-git-send-email-marek@goldelico.com>
Message-ID: <20140214134815.GD13293@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Signed-off-by: Marek Belisko <marek@goldelico.com>
> ---
>  .../devicetree/bindings/mfd/twl4030-madc.txt       | 18 +++++++++++++
>  drivers/mfd/twl4030-madc.c                         | 31
> ++++++++++++++++++++--

Please separate these into different patches.

>  2 files changed, 47 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/twl4030-madc.txt

<snip>

> +++ b/drivers/mfd/twl4030-madc.c
> @@ -695,6 +695,29 @@ static int twl4030_madc_set_power(struct twl4030_madc_data *madc, int on)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_OF

I believe we're heading for a more:

  if (IS_ENABLED(CONFIG_OF))

... approach. I won't enforce it, but please consider using it.

> +static struct twl4030_madc_platform_data *
> +	twl4030_madc_of_parse(struct platform_device *pdev)
> +{
> +	struct twl4030_madc_platform_data *pdata;
> +
> +	pdata = devm_kzalloc(&pdev->dev,
> +			sizeof(struct twl4030_madc_platform_data), GFP_KERNEL);

s/struct twl4030_madc_platform_data/*pdata/

> +	if (!pdata)
> +		return ERR_PTR(-ENOMEM);
> +
> +	pdata->irq_line = platform_get_irq(pdev, 0);

Why weren't 'resources' used in the original implementation?

> +	return pdata;
> +}
> +
> +static const struct of_device_id twl4030_madc_dt_match_table[] = {
> +	{ .compatible = "ti,twl4030-madc" },
> +	{},
> +};
> +
> +#endif
> +
>  /*
>   * Initialize MADC and request for threaded irq
>   */
> @@ -706,8 +729,11 @@ static int twl4030_madc_probe(struct platform_device *pdev)
>  	u8 regval;
>  
>  	if (!pdata) {
> -		dev_err(&pdev->dev, "platform_data not available\n");
> -		return -EINVAL;
> +		pdata = twl4030_madc_of_parse(pdev);
> +		if (!pdata) {

And if you received -ENOMEM?

> +			dev_err(&pdev->dev, "platform_data not available\n");
> +			return -EINVAL;
> +		}
>  	}
>  	madc = kzalloc(sizeof(*madc), GFP_KERNEL);
>  	if (!madc)
> @@ -807,6 +833,7 @@ static struct platform_driver twl4030_madc_driver = {
>  	.driver = {
>  		   .name = "twl4030_madc",
>  		   .owner = THIS_MODULE,
> +		   .of_match_table = of_match_ptr(twl4030_madc_dt_match_table),
>  		   },
>  };
>  

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
