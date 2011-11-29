From: rnayak@ti.com (Rajendra Nayak)
Date: Tue, 29 Nov 2011 13:53:31 +0530
Subject: [PATCH 1/5] mfd: mc13xxx: add device tree probe support
In-Reply-To: <1322487439-27254-2-git-send-email-shawn.guo@linaro.org>
References: <1322487439-27254-1-git-send-email-shawn.guo@linaro.org>
 <1322487439-27254-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <4ED49683.10609@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[]...
> +};
> +MODULE_DEVICE_TABLE(of, mc13xxx_dt_ids);
> +
>   static int mc13xxx_probe(struct spi_device *spi)
>   {
> +	struct device_node *np = spi->dev.of_node;
> +	const struct of_device_id *of_id;
> +	struct spi_driver *sdrv = to_spi_driver(spi->dev.driver);
>   	struct mc13xxx *mc13xxx;
>   	struct mc13xxx_platform_data *pdata = dev_get_platdata(&spi->dev);
>   	enum mc13xxx_id id;
>   	int ret;
>
> -	if (!pdata) {
> -		dev_err(&spi->dev, "invalid platform data\n");
> -		return -EINVAL;
> -	}
> +	of_id = of_match_device(mc13xxx_dt_ids,&spi->dev);
> +	if (of_id)
> +		sdrv->id_table =&mc13xxx_device_id[(enum mc13xxx_id) of_id->data];
>
>   	mc13xxx = kzalloc(sizeof(*mc13xxx), GFP_KERNEL);
>   	if (!mc13xxx)
> @@ -735,6 +787,15 @@ static int mc13xxx_probe(struct spi_device *spi)
>   	if (ret)
>   		goto err_mask;
>
> +	mc13xxx->irq_gpio = of_get_named_gpio(np, "mc13xxx-irq-gpios", 0);
> +	if (gpio_is_valid(mc13xxx->irq_gpio)) {
> +		ret = gpio_request_one(mc13xxx->irq_gpio, GPIOF_IN,
> +				       "mc13xxx-irq");
> +		if (ret)
> +			goto err_mask;
> +		spi->irq = gpio_to_irq(mc13xxx->irq_gpio);

This seems wrong, because its adding information about the irq actually
being a gpio within the driver (which was otherwise hidden by the board
files doing a gpio_to_irq()). What happens if on some device this is
actually hooked to an irq line instead of a gpio?
There should be a better way to do this using Device tree.
