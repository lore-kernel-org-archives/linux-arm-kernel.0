From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 4 Apr 2012 08:48:38 +0000
Subject: [PATCH v2] gpio: Device tree support for LPC32xx
In-Reply-To: <1333497518-25838-1-git-send-email-stigge@antcom.de>
References: <1333497518-25838-1-git-send-email-stigge@antcom.de>
Message-ID: <201204040848.39376.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 03 April 2012, Roland Stigge wrote:
> This patch adds device tree support for gpio-lpc32xx.c
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Just one more comment:

> +#ifdef CONFIG_OF
> +static struct of_device_id lpc32xx_gpio_of_match[] __devinitdata = {
> +	{ .compatible = "nxp,lpc32xx-gpio", },
> +	{ },
> +};
> +#endif
> +
> +static struct platform_driver lpc32xx_gpio_driver = {
> +	.driver		= {
> +		.name	= "lpc32xx-gpio",
> +		.owner	= THIS_MODULE,
> +		.of_match_table = lpc32xx_gpio_of_match,
> +	},
> +	.probe		= lpc32xx_gpio_probe,
> +};

The #ifdef above is not helpful, it will cause a build error in the
of_match_table= assignment. Since the plan for this driver is to
be devicetree-only, it would be appropriate to just remove the
#ifdef, but adding of_match_ptr() is ok too.

	Arnd
