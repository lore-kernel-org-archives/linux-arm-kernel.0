From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 26 Sep 2017 15:00:09 +0200
Subject: [PATCH v2 02/10] pinctrl: axp209: add pinctrl features
In-Reply-To: <6b89df1bf07dac2ab295fca5fdf0e55179c47ed6.1506428208.git-series.quentin.schulz@free-electrons.com>
References: <cover.1c314f4154a6d27354625f03d0a5269eee55a9c5.1506428208.git-series.quentin.schulz@free-electrons.com>
 <6b89df1bf07dac2ab295fca5fdf0e55179c47ed6.1506428208.git-series.quentin.schulz@free-electrons.com>
Message-ID: <20170926130009.r5isgrjvkwmm44nn@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 26, 2017 at 12:17:12PM +0000, Quentin Schulz wrote:
> +static const struct axp20x_desc_pin axp209_pins[] = {
> +	AXP20X_PIN(AXP20X_PINCTRL_PIN(0, "GPIO0"),
> +		   AXP20X_FUNCTION(0x0, "gpio_out"),
> +		   AXP20X_FUNCTION(0x2, "gpio_in"),
> +		   AXP20X_FUNCTION(0x3, "ldo"),
> +		   AXP20X_FUNCTION(0x4, "adc")),
> +	AXP20X_PIN(AXP20X_PINCTRL_PIN(1, "GPIO1"),
> +		   AXP20X_FUNCTION(0x0, "gpio_out"),
> +		   AXP20X_FUNCTION(0x2, "gpio_in"),
> +		   AXP20X_FUNCTION(0x3, "ldo"),
> +		   AXP20X_FUNCTION(0x4, "adc")),
> +	AXP20X_PIN(AXP20X_PINCTRL_PIN(2, "GPIO2"),
> +		   AXP20X_FUNCTION(0x0, "gpio_out"),
> +		   AXP20X_FUNCTION(0x2, "gpio_in")),
> +};

If all the functions are the same, and at the same offset, can't we
just hardcode it, instead of having (and duplicate) all the logic
below?

> +	pctrl_desc = devm_kzalloc(&pdev->dev, sizeof(*pctrl_desc), GFP_KERNEL);
> +	if (!pctrl_desc)
> +		return -ENOMEM;
> +
> +	pctrl_desc->name = dev_name(&pdev->dev);
> +	pctrl_desc->owner = THIS_MODULE;
> +	pctrl_desc->pins = pins;
> +	pctrl_desc->npins = gpio->desc->npins;
> +	pctrl_desc->pctlops = &axp20x_pctrl_ops;
> +	pctrl_desc->pmxops = &axp20x_pmx_ops;

The strict flag needs to be set too in order to avoid concurrent uses
of GPIO and other functions.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170926/ebf6bcf8/attachment.sig>
