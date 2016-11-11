From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 11 Nov 2016 09:36:27 +0100
Subject: [PATCH v2 2/3] pinctrl: sunxi: Add support for fetching pinconf
 settings from hardware
In-Reply-To: <20161111024455.16883-3-wens@csie.org>
References: <20161111024455.16883-1-wens@csie.org>
 <20161111024455.16883-3-wens@csie.org>
Message-ID: <20161111083627.yooctcxqs4ow7sn3@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 11, 2016 at 10:44:54AM +0800, Chen-Yu Tsai wrote:
> The sunxi pinctrl driver only caches whatever pinconf setting was last
> set on a given pingroup. This is not particularly helpful, nor is it
> correct.
> 
> Fix this by actually reading the hardware registers and returning
> the correct results or error codes. Also filter out unsupported
> pinconf settings. Since this driver has a peculiar setup of 1 pin
> per group, we can support both pin and pingroup pinconf setting
> read back with the same code. The sunxi_pconf_reg helper and code
> structure is inspired by pinctrl-msm.
> 
> With this done we can also claim to support generic pinconf, by
> setting .is_generic = true in pinconf_ops.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/pinctrl/sunxi/pinctrl-sunxi.c | 84 +++++++++++++++++++++++++++++++++--
>  1 file changed, 81 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> index e04edda8629d..3e9f7c675d36 100644
> --- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> +++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> @@ -438,15 +438,91 @@ static const struct pinctrl_ops sunxi_pctrl_ops = {
>  	.get_group_pins		= sunxi_pctrl_get_group_pins,
>  };
>  
> +static int sunxi_pconf_reg(unsigned pin, enum pin_config_param param,
> +			   u32 *offset, u32 *shift, u32 *mask)
> +{
> +	switch (param) {
> +	case PIN_CONFIG_DRIVE_STRENGTH:
> +		*offset = sunxi_dlevel_reg(pin);
> +		*shift = sunxi_dlevel_offset(pin);
> +		*mask = DLEVEL_PINS_MASK;
> +		break;
> +
> +	case PIN_CONFIG_BIAS_PULL_UP:
> +	case PIN_CONFIG_BIAS_PULL_DOWN:
> +	case PIN_CONFIG_BIAS_DISABLE:
> +		*offset = sunxi_pull_reg(pin);
> +		*shift = sunxi_pull_offset(pin);
> +		*mask = PULL_PINS_MASK;
> +		break;
> +
> +	default:
> +		return -ENOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +static int sunxi_pconf_get(struct pinctrl_dev *pctldev, unsigned pin,
> +			   unsigned long *config)
> +{
> +	struct sunxi_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
> +	enum pin_config_param param = pinconf_to_config_param(*config);
> +	u32 offset, shift, mask, val;
> +	u16 arg;
> +	int ret;
> +
> +	pin -= pctl->desc->pin_base;
> +
> +	ret = sunxi_pconf_reg(pin, param, &offset, &shift, &mask);
> +	if (ret < 0)
> +		return ret;
> +
> +	val = (readl(pctl->membase + offset) >> shift) & mask;
> +
> +	switch (pinconf_to_config_param(*config)) {
> +	case PIN_CONFIG_DRIVE_STRENGTH:
> +		arg = (val + 1) * 10;
> +		break;
> +
> +	case PIN_CONFIG_BIAS_PULL_UP:
> +		if (val != SUN4I_PINCTRL_PULL_UP)
> +			return -EINVAL;
> +		arg = 1; /* hardware is weak pull-up */
> +		break;
> +
> +	case PIN_CONFIG_BIAS_PULL_DOWN:
> +		if (val != SUN4I_PINCTRL_PULL_DOWN)
> +			return -EINVAL;
> +		arg = 1; /* hardware is weak pull-down */
> +		break;
> +
> +	case PIN_CONFIG_BIAS_DISABLE:
> +		if (val != SUN4I_PINCTRL_NO_PULL)
> +			return -EINVAL;
> +		arg = 0;
> +		break;
> +
> +	default:
> +		/* sunxi_pconf_reg should catch anything unsupported */
> +		WARN_ON(1);
> +		return -ENOTSUPP;
> +	}
> +
> +	*config = pinconf_to_config_packed(param, arg);
> +
> +	return 0;
> +}
> +
>  static int sunxi_pconf_group_get(struct pinctrl_dev *pctldev,
>  				 unsigned group,
>  				 unsigned long *config)
>  {
>  	struct sunxi_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
> +	struct sunxi_pinctrl_group *g = &pctl->groups[group];
>  
> -	*config = pctl->groups[group].config;

Do we still need this variable? Looking at the code, it doesn't look
that way, and we can remove the caching in the _group_set function and
the variable itslef in the sunxi_pincttrl_group structure.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161111/c66f592a/attachment-0001.sig>
