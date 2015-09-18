From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 18 Sep 2015 09:54:57 +0200
Subject: [Patch V5] i2c: imx: implement bus recovery
In-Reply-To: <1441968155-10918-1-git-send-email-b54642@freescale.com>
References: <1441968155-10918-1-git-send-email-b54642@freescale.com>
Message-ID: <20150918075457.GT5327@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Sep 11, 2015 at 06:42:34PM +0800, Gao Pan wrote:
> V5:
>  -introduce a dedicated gpio state for bus recovery.
>  -assign adapter.bus_recovery_info after the two gpios were aquired successfully.

You also do this if the gpios were not acquired successfully.

> +	if (IS_ERR(i2c_imx->pinctrl_pins_default))
> +		dev_warn(&pdev->dev, "could not get default state\n");
> +	else {
> +		i2c_imx->pinctrl_pins_gpio = pinctrl_lookup_state(i2c_imx->pinctrl,
> +						I2C_PINCTRL_STATE_GPIO);
> +		if (IS_ERR(i2c_imx->pinctrl_pins_gpio))
> +			dev_warn(&pdev->dev, "could not get gpio state\n");

IMHO pinctrl_lookup_state returning an error is enough to not try a
recovery.

> +	}
> +
>  	/* Request IRQ */
>  	ret = devm_request_irq(&pdev->dev, irq, i2c_imx_isr, 0,
>  				pdev->name, i2c_imx);
> @@ -1057,6 +1146,24 @@ static int i2c_imx_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		goto rpm_disable;
>  
> +	/* Init recover pins */
> +	i2c_imx->pins.sda =
> +		devm_gpiod_get_optional(&pdev->dev, "sda-gpios", GPIOD_IN);
> +	i2c_imx->pins.scl =
> +		devm_gpiod_get_optional(&pdev->dev, "scl-gpios", GPIOD_IN);
> +
> +	if (IS_ERR(i2c_imx->pins.sda)) {
> +		ret = PTR_ERR(i2c_imx->pins.sda);
> +		goto clk_disable;
> +	}
> +
> +	if (IS_ERR(i2c_imx->pins.scl)) {
> +		ret = PTR_ERR(i2c_imx->pins.scl);
> +		goto clk_disable;
> +	}
> +

if (i2c_imx->pins.sda && i2c_imx->pins.scl)

> +	i2c_imx->adapter.bus_recovery_info = &i2c_imx_bus_recovery_info;
> +
>  	/* Set up clock divider */
>  	i2c_imx->bitrate = IMX_I2C_BIT_RATE;
>  	ret = of_property_read_u32(pdev->dev.of_node,

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
