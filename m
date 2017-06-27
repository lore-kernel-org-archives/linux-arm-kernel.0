From: stefan@agner.ch (Stefan Agner)
Date: Mon, 26 Jun 2017 20:53:45 -0700
Subject: [PATCH V4 6/7] pinctrl: imx: make imx_pmx_ops.gpio_set_direction
 platform specific callbacks
In-Reply-To: <1498046395-30001-7-git-send-email-aisheng.dong@nxp.com>
References: <1498046395-30001-1-git-send-email-aisheng.dong@nxp.com>
 <1498046395-30001-7-git-send-email-aisheng.dong@nxp.com>
Message-ID: <f1c34a026406b9e7c2a727ad8de54998@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-06-21 04:59, Dong Aisheng wrote:
> Various IMX platforms may have different imx_pmx_ops.gpio_set_direction
> implementations, so let's make it platform specific callbacks instead of
> the fixed common one.
> 
> Currently only VF610 platform implements it. No function level changes.

Adds an indirection, but I feel this is necessary since we have platform
differences how GPIO directions are handled...

So:

Acked-by: Stefan Agner <stefan@agner.ch>

--
Stefan

> 
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> 
> ---
> ChangeLog:
>  * new patch.
> ---
>  drivers/pinctrl/freescale/pinctrl-imx.c   | 48 +++----------------------------
>  drivers/pinctrl/freescale/pinctrl-imx.h   | 20 +++++++++++++
>  drivers/pinctrl/freescale/pinctrl-vf610.c | 25 ++++++++++++++++
>  3 files changed, 49 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c
> b/drivers/pinctrl/freescale/pinctrl-imx.c
> index 505fe79..ad23e39 100644
> --- a/drivers/pinctrl/freescale/pinctrl-imx.c
> +++ b/drivers/pinctrl/freescale/pinctrl-imx.c
> @@ -35,18 +35,6 @@
>  #define IMX_NO_PAD_CTL	0x80000000	/* no pin config need */
>  #define IMX_PAD_SION 0x40000000		/* set SION */
>  
> -/**
> - * @dev: a pointer back to containing device
> - * @base: the offset to the controller in virtual memory
> - */
> -struct imx_pinctrl {
> -	struct device *dev;
> -	struct pinctrl_dev *pctl;
> -	void __iomem *base;
> -	void __iomem *input_sel_base;
> -	struct imx_pinctrl_soc_info *info;
> -};
> -
>  static inline const struct group_desc *imx_pinctrl_find_group_by_name(
>  				struct pinctrl_dev *pctldev,
>  				const char *name)
> @@ -255,42 +243,11 @@ static int imx_pmx_set(struct pinctrl_dev
> *pctldev, unsigned selector,
>  	return 0;
>  }
>  
> -static int imx_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
> -	   struct pinctrl_gpio_range *range, unsigned offset, bool input)
> -{
> -	struct imx_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
> -	struct imx_pinctrl_soc_info *info = ipctl->info;
> -	const struct imx_pin_reg *pin_reg;
> -	u32 reg;
> -
> -	/*
> -	 * Only Vybrid has the input/output buffer enable flags (IBE/OBE)
> -	 * They are part of the shared mux/conf register.
> -	 */
> -	if (!(info->flags & SHARE_MUX_CONF_REG))
> -		return 0;
> -
> -	pin_reg = &info->pin_regs[offset];
> -	if (pin_reg->mux_reg == -1)
> -		return -EINVAL;
> -
> -	/* IBE always enabled allows us to read the value "on the wire" */
> -	reg = readl(ipctl->base + pin_reg->mux_reg);
> -	if (input)
> -		reg &= ~0x2;
> -	else
> -		reg |= 0x2;
> -	writel(reg, ipctl->base + pin_reg->mux_reg);
> -
> -	return 0;
> -}
> -
> -static const struct pinmux_ops imx_pmx_ops = {
> +struct pinmux_ops imx_pmx_ops = {
>  	.get_functions_count = pinmux_generic_get_function_count,
>  	.get_function_name = pinmux_generic_get_function_name,
>  	.get_function_groups = pinmux_generic_get_function_groups,
>  	.set_mux = imx_pmx_set,
> -	.gpio_set_direction = imx_pmx_gpio_set_direction,
>  };
>  
>  /* decode generic config into raw register values */
> @@ -793,6 +750,9 @@ int imx_pinctrl_probe(struct platform_device *pdev,
>  	imx_pinctrl_desc->custom_params = info->custom_params;
>  	imx_pinctrl_desc->num_custom_params = info->num_custom_params;
>  
> +	/* platform specific callback */
> +	imx_pmx_ops.gpio_set_direction = info->gpio_set_direction;
> +
>  	mutex_init(&info->mutex);
>  
>  	ipctl->info = info;
> diff --git a/drivers/pinctrl/freescale/pinctrl-imx.h
> b/drivers/pinctrl/freescale/pinctrl-imx.h
> index 880bba7..5aa22b5 100644
> --- a/drivers/pinctrl/freescale/pinctrl-imx.h
> +++ b/drivers/pinctrl/freescale/pinctrl-imx.h
> @@ -16,9 +16,12 @@
>  #define __DRIVERS_PINCTRL_IMX_H
>  
>  #include <linux/pinctrl/pinconf-generic.h>
> +#include <linux/pinctrl/pinmux.h>
>  
>  struct platform_device;
>  
> +extern struct pinmux_ops imx_pmx_ops;
> +
>  /**
>   * struct imx_pin - describes a single i.MX pin
>   * @pin: the pin_id of this pin
> @@ -76,6 +79,23 @@ struct imx_pinctrl_soc_info {
>  	unsigned int num_decodes;
>  	void (*fixup)(unsigned long *configs, unsigned int num_configs,
>  		      u32 *raw_config);
> +
> +	int (*gpio_set_direction)(struct pinctrl_dev *pctldev,
> +				  struct pinctrl_gpio_range *range,
> +				  unsigned offset,
> +				  bool input);
> +};
> +
> +/**
> + * @dev: a pointer back to containing device
> + * @base: the offset to the controller in virtual memory
> + */
> +struct imx_pinctrl {
> +	struct device *dev;
> +	struct pinctrl_dev *pctl;
> +	void __iomem *base;
> +	void __iomem *input_sel_base;
> +	struct imx_pinctrl_soc_info *info;
>  };
>  
>  #define IMX_CFG_PARAMS_DECODE(p, m, o) \
> diff --git a/drivers/pinctrl/freescale/pinctrl-vf610.c
> b/drivers/pinctrl/freescale/pinctrl-vf610.c
> index 3bd8556..ac18bb6 100644
> --- a/drivers/pinctrl/freescale/pinctrl-vf610.c
> +++ b/drivers/pinctrl/freescale/pinctrl-vf610.c
> @@ -295,10 +295,35 @@ static const struct pinctrl_pin_desc
> vf610_pinctrl_pads[] = {
>  	IMX_PINCTRL_PIN(VF610_PAD_PTA7),
>  };
>  
> +static int vf610_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
> +					struct pinctrl_gpio_range *range,
> +					unsigned offset, bool input)
> +{
> +	struct imx_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
> +	struct imx_pinctrl_soc_info *info = ipctl->info;
> +	const struct imx_pin_reg *pin_reg;
> +	u32 reg;
> +
> +	pin_reg = &info->pin_regs[offset];
> +	if (pin_reg->mux_reg == -1)
> +		return -EINVAL;
> +
> +	/* IBE always enabled allows us to read the value "on the wire" */
> +	reg = readl(ipctl->base + pin_reg->mux_reg);
> +	if (input)
> +		reg &= ~0x2;
> +	else
> +		reg |= 0x2;
> +	writel(reg, ipctl->base + pin_reg->mux_reg);
> +
> +	return 0;
> +}
> +
>  static struct imx_pinctrl_soc_info vf610_pinctrl_info = {
>  	.pins = vf610_pinctrl_pads,
>  	.npins = ARRAY_SIZE(vf610_pinctrl_pads),
>  	.flags = SHARE_MUX_CONF_REG | ZERO_OFFSET_VALID,
> +	.gpio_set_direction = vf610_pmx_gpio_set_direction,
>  	.mux_mask = 0x700000,
>  	.mux_shift = 20,
>  };
