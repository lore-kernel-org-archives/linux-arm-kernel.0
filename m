From: alex.g@adaptrum.com (Alexandru Gagniuc)
Date: Fri, 11 Aug 2017 09:04:54 -0700
Subject: [PATCH v2 1/5] reset: add reset-simple to unify socfpga, stm32,
 sunxi, and zx2967
In-Reply-To: <20170811130618.3676-2-p.zabel@pengutronix.de>
References: <20170811130618.3676-1-p.zabel@pengutronix.de>
 <20170811130618.3676-2-p.zabel@pengutronix.de>
Message-ID: <fc0d0480-947b-a731-627c-32c99bbc2586@adaptrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Phillip,

On 08/11/2017 06:06 AM, Philipp Zabel wrote:
[snip]

> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 52d5251660b9b..f7ba01a71daee 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -68,6 +68,16 @@ config RESET_PISTACHIO
>  	help
>  	  This enables the reset driver for ImgTec Pistachio SoCs.
>
> +config RESET_SIMPLE
> +	bool "Simple Reset Controller Driver" if COMPILE_TEST
> +	default ARCH_SUNXI

This seems like a list with the potential to grow unbounded. I think it 
would be better for the platforms to 'select RESET_SIMPLE' rather than 
trying to guess all users in one big kconfig line.

[snip]

> +
> +struct reset_simple_devdata {
> +	bool inverted;
> +};
> +
> +static const struct reset_simple_devdata reset_simple_inverted = {
> +	.inverted = true,

Hmm. I think it would be useful for new devices if there were have a way 
to specify this in devicetree.

> +};
> +
> +static const struct of_device_id reset_simple_dt_ids[] = {
> +	{ .compatible = "allwinner,sun6i-a31-clock-reset",
> +		.data = &reset_simple_inverted },
> +	{ /* sentinel */ },

Are plans to have a "simple-reset" compatible binding for new devices?

Alex

[snip]
