From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 26 Sep 2017 15:12:56 +0200
Subject: [PATCH v2 06/10] pinctrl: axp209: add support for AXP813 GPIOs
In-Reply-To: <b950efcbb2f4d399812591cdf5dce11d0d35b42b.1506428208.git-series.quentin.schulz@free-electrons.com>
References: <cover.1c314f4154a6d27354625f03d0a5269eee55a9c5.1506428208.git-series.quentin.schulz@free-electrons.com>
 <b950efcbb2f4d399812591cdf5dce11d0d35b42b.1506428208.git-series.quentin.schulz@free-electrons.com>
Message-ID: <20170926131256.bqfzgqs2k63liqjj@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 26, 2017 at 12:17:16PM +0000, Quentin Schulz wrote:
> The AXP813 has only two GPIOs. GPIO0 can either be used as a GPIO, an
> LDO regulator or an ADC. GPIO1 can be used either as a GPIO or an LDO
> regulator.
> 
> Moreover, the status bit of the GPIOs when in input mode is not offset
> by 4 unlike the AXP209.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/pinctrl/pinctrl-axp209.txt | 13 ++-
>  drivers/pinctrl/pinctrl-axp209.c                             | 30 ++++++-
>  2 files changed, 39 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-axp209.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-axp209.txt
> index a5bfe87..a1d5dec 100644
> --- a/Documentation/devicetree/bindings/pinctrl/pinctrl-axp209.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-axp209.txt
> @@ -4,7 +4,9 @@ This driver follows the usual GPIO bindings found in
>  Documentation/devicetree/bindings/gpio/gpio.txt
>  
>  Required properties:
> -- compatible: Should be "x-powers,axp209-gpio"
> +- compatible: Should be one of:
> +	- "x-powers,axp209-gpio"
> +	- "x-powers,axp813-pctl"
>  - #gpio-cells: Should be two. The first cell is the pin number and the
>    second is the GPIO flags.
>  - gpio-controller: Marks the device node as a GPIO controller.
> @@ -49,8 +51,17 @@ Example:
>  GPIOs and their functions
>  -------------------------
>  
> +axp209
> +------
>  GPIO	|	Functions
>  ------------------------
>  GPIO0	|	gpio_in, gpio_out, ldo, adc
>  GPIO1	|	gpio_in, gpio_out, ldo, adc
>  GPIO2	|	gpio_in, gpio_out
> +
> +axp813
> +------
> +GPIO	|	Functions
> +------------------------
> +GPIO0	|	gpio_in, gpio_out, ldo, adc
> +GPIO1	|	gpio_in, gpio_out, ldo
> diff --git a/drivers/pinctrl/pinctrl-axp209.c b/drivers/pinctrl/pinctrl-axp209.c
> index 11f871e..500862b 100644
> --- a/drivers/pinctrl/pinctrl-axp209.c
> +++ b/drivers/pinctrl/pinctrl-axp209.c
> @@ -108,11 +108,28 @@ static const struct axp20x_desc_pin axp209_pins[] = {
>  		   AXP20X_FUNCTION(0x2, "gpio_in")),
>  };
>  
> +static const struct axp20x_desc_pin axp813_pins[] = {
> +	AXP20X_PIN(AXP20X_PINCTRL_PIN(0, "GPIO0", (void *)AXP20X_GPIO0_CTRL),
> +		   AXP20X_FUNCTION(0x0, "gpio_out"),
> +		   AXP20X_FUNCTION(0x2, "gpio_in"),
> +		   AXP20X_FUNCTION(0x3, "ldo"),
> +		   AXP20X_FUNCTION(0x4, "adc")),
> +	AXP20X_PIN(AXP20X_PINCTRL_PIN(1, "GPIO1", (void *)AXP20X_GPIO1_CTRL),
> +		   AXP20X_FUNCTION(0x0, "gpio_out"),
> +		   AXP20X_FUNCTION(0x2, "gpio_in"),
> +		   AXP20X_FUNCTION(0x3, "ldo")),
> +};
> +
>  static const struct axp20x_pinctrl_desc axp20x_pinctrl_data = {
>  	.pins	= axp209_pins,
>  	.npins	= ARRAY_SIZE(axp209_pins),
>  };
>  
> +static const struct axp20x_pinctrl_desc axp813_pinctrl_data = {
> +	.pins	= axp813_pins,
> +	.npins	= ARRAY_SIZE(axp813_pins),
> +};
> +
>  static int axp20x_gpio_input(struct gpio_chip *chip, unsigned offset)
>  {
>  	return pinctrl_gpio_direction_input(chip->base + offset);
> @@ -479,6 +496,7 @@ static int axp20x_pctl_probe(struct platform_device *pdev)
>  	struct axp20x_pctl *pctl;
>  	struct pinctrl_desc *pctrl_desc;
>  	struct pinctrl_pin_desc *pins;
> +	struct device_node *np = pdev->dev.of_node;
>  	int ret, i;
>  
>  	if (!of_device_is_available(pdev->dev.of_node))
> @@ -505,13 +523,18 @@ static int axp20x_pctl_probe(struct platform_device *pdev)
>  	pctl->chip.set			= axp20x_gpio_set;
>  	pctl->chip.direction_input	= axp20x_gpio_input;
>  	pctl->chip.direction_output	= axp20x_gpio_output;
> -	pctl->chip.ngpio		= 3;
>  
>  	pctl->regmap = axp20x->regmap;
>  
> -	pctl->desc = &axp20x_pinctrl_data;
> -	pctl->gpio_status_offset = 4;
> +	if (of_device_is_compatible(np, "x-powers,axp209-gpio")) {
> +		pctl->desc = &axp20x_pinctrl_data;
> +		pctl->gpio_status_offset = 4;
> +	} else {
> +		pctl->desc = &axp813_pinctrl_data;
> +		pctl->gpio_status_offset = 0;
> +	}
>  	pctl->dev = &pdev->dev;
> +	pctl->chip.ngpio = pctl->desc->npins;

This should be part of a structure that would be attached to the
compatible.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170926/0d2db9f0/attachment.sig>
