From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri, 26 Jul 2013 22:05:43 +0100
Subject: [PATCH v11] reset: Add driver for gpio-controlled reset pins
In-Reply-To: <1374834384-8071-1-git-send-email-p.zabel@pengutronix.de>
References: <1374834384-8071-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <51F2E4A7.1040200@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/07/13 11:26, Philipp Zabel wrote:
> This driver implements a reset controller device that toggle a gpio
> connected to a reset pin of a peripheral IC. The delay between assertion
> and de-assertion of the reset signal can be configured via device tree.
>
> Signed-off-by: Philipp Zabel<p.zabel@pengutronix.de>
> Reviewed-by: Stephen Warren<swarren@nvidia.com>

[snip]

> +static struct of_device_id gpio_reset_dt_ids[] = {
> +	{ .compatible = "gpio-reset" },
> +	{ }
> +};

I think you need the following:
MODULE_DEVICE_TABLE(of, gpio_reset_dt_ids);

> +static struct platform_driver gpio_reset_driver = {
> +	.probe = gpio_reset_probe,
> +	.remove = gpio_reset_remove,
> +	.driver = {
> +		.name = "gpio-reset",
> +		.owner = THIS_MODULE,
> +		.of_match_table = of_match_ptr(gpio_reset_dt_ids),
> +	},
> +};
> +
> +module_platform_driver(gpio_reset_driver);
> +
> +MODULE_AUTHOR("Philipp Zabel<p.zabel@pengutronix.de>");
> +MODULE_DESCRIPTION("gpio reset controller");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:gpio-reset");
> +MODULE_DEVICE_TABLE(of, gpio_reset_dt_ids);


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
