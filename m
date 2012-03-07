From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 07 Mar 2012 15:40:18 -0700
Subject: [PATCH 3/4] pinctrl: support pinconfig on the U300
In-Reply-To: <1331071533-24789-1-git-send-email-linus.walleij@stericsson.com>
References: <1331071533-24789-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <4F57E3D2.40405@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/06/2012 03:05 PM, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This adds pin configuration support for the U300 driver pair,
> we can now read out the biasing and drive mode in debugfs and
> configure it using the new configuration API.

> +int u300_pin_config_set(struct pinctrl_dev *pctldev,
> +			unsigned pin,
> +			unsigned long config)
> +{
> +	struct pinctrl_gpio_range *range = u300_match_gpio_range(pin);
> +	int ret;
> +
> +	if (!range)
> +		return -EINVAL;
> +
> +	/* Note: none of these configurations take any argument */
> +	ret = u300_gpio_config_set(range->gc,
> +				   (pin - range->pin_base + range->base),
> +				   to_config_param(config));

I'm a little confused here; the documentation for most of the
PIN_CONFIG_* parameters that this function is passed does explicitly
document that there is an associated argument value. For example,
IN_CONFIG_BIAS_PULL_UP is coupled with the pull up resistance in Ohms.
Shouldn't this code extract the argument and validate that it's a
supported value for the HW?
