From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Thu, 26 Jul 2018 23:45:03 +0530
Subject: [PATCH 2/5] pinctrl: actions: define pad control configurtion to
 SoC specific
In-Reply-To: <20180722163601.28346-3-sravanhome@gmail.com>
References: <20180722163601.28346-1-sravanhome@gmail.com>
 <20180722163601.28346-3-sravanhome@gmail.com>
Message-ID: <20180726181503.GE5220@Mani-XPS-13-9360>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Jul 22, 2018 at 06:35:58PM +0200, Saravanan Sekar wrote:
> pad control for s900 and s700 are differs in number of
> pull control configuraions
> s900 has 4 pull controls - high impedence, pull up, pull down, repeater
> s700, s500 has 2 pull controls - pull up and pull down
> 

You should clearly mention what the commit is actually doing.

> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
>  drivers/pinctrl/actions/pinctrl-owl.c  | 64 ++++---------------------
>  drivers/pinctrl/actions/pinctrl-owl.h  | 13 +++--
>  drivers/pinctrl/actions/pinctrl-s900.c | 66 +++++++++++++++++++++++++-
>  3 files changed, 79 insertions(+), 64 deletions(-)
> 
> diff --git a/drivers/pinctrl/actions/pinctrl-owl.c b/drivers/pinctrl/actions/pinctrl-owl.c
> index b5c880b50bb3..f72da7aae4ff 100644
> --- a/drivers/pinctrl/actions/pinctrl-owl.c
> +++ b/drivers/pinctrl/actions/pinctrl-owl.c
> @@ -242,60 +242,6 @@ static int owl_pad_pinconf_reg(const struct owl_padinfo *info,
>  	return 0;
>  }
>  
> -static int owl_pad_pinconf_arg2val(const struct owl_padinfo *info,
> -				unsigned int param,
> -				u32 *arg)
> -{
> -	switch (param) {
> -	case PIN_CONFIG_BIAS_BUS_HOLD:
> -		*arg = OWL_PINCONF_PULL_HOLD;
> -		break;
> -	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
> -		*arg = OWL_PINCONF_PULL_HIZ;
> -		break;
> -	case PIN_CONFIG_BIAS_PULL_DOWN:
> -		*arg = OWL_PINCONF_PULL_DOWN;
> -		break;
> -	case PIN_CONFIG_BIAS_PULL_UP:
> -		*arg = OWL_PINCONF_PULL_UP;
> -		break;
> -	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
> -		*arg = (*arg >= 1 ? 1 : 0);
> -		break;
> -	default:
> -		return -ENOTSUPP;
> -	}
> -
> -	return 0;
> -}
> -
> -static int owl_pad_pinconf_val2arg(const struct owl_padinfo *padinfo,
> -				unsigned int param,
> -				u32 *arg)
> -{
> -	switch (param) {
> -	case PIN_CONFIG_BIAS_BUS_HOLD:
> -		*arg = *arg == OWL_PINCONF_PULL_HOLD;
> -		break;
> -	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
> -		*arg = *arg == OWL_PINCONF_PULL_HIZ;
> -		break;
> -	case PIN_CONFIG_BIAS_PULL_DOWN:
> -		*arg = *arg == OWL_PINCONF_PULL_DOWN;
> -		break;
> -	case PIN_CONFIG_BIAS_PULL_UP:
> -		*arg = *arg == OWL_PINCONF_PULL_UP;
> -		break;
> -	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
> -		*arg = *arg == 1;
> -		break;
> -	default:
> -		return -ENOTSUPP;
> -	}
> -
> -	return 0;
> -}
> -
>  static int owl_pin_config_get(struct pinctrl_dev *pctrldev,
>  				unsigned int pin,
>  				unsigned long *config)
> @@ -314,7 +260,10 @@ static int owl_pin_config_get(struct pinctrl_dev *pctrldev,
>  
>  	arg = owl_read_field(pctrl, reg, bit, width);
>  
> -	ret = owl_pad_pinconf_val2arg(info, param, &arg);
> +	if (!pctrl->soc->padctl_val2arg)
> +		return -ENOTSUPP;
> +
> +	ret = pctrl->soc->padctl_val2arg(info, param, &arg);
>  	if (ret)
>  		return ret;
>  
> @@ -345,7 +294,10 @@ static int owl_pin_config_set(struct pinctrl_dev *pctrldev,
>  		if (ret)
>  			return ret;
>  
> -		ret = owl_pad_pinconf_arg2val(info, param, &arg);
> +		if (!pctrl->soc->padctl_arg2val)
> +			return -ENOTSUPP;
> +
> +		ret = pctrl->soc->padctl_arg2val(info, param, &arg);
>  		if (ret)
>  			return ret;
>  
> diff --git a/drivers/pinctrl/actions/pinctrl-owl.h b/drivers/pinctrl/actions/pinctrl-owl.h
> index 42635366e68f..669591c5400e 100644
> --- a/drivers/pinctrl/actions/pinctrl-owl.h
> +++ b/drivers/pinctrl/actions/pinctrl-owl.h
> @@ -139,13 +139,6 @@
>  		.st = &name##_st_conf,			\
>  	}
>  
> -enum owl_pinconf_pull {
> -	OWL_PINCONF_PULL_HIZ,
> -	OWL_PINCONF_PULL_DOWN,
> -	OWL_PINCONF_PULL_UP,
> -	OWL_PINCONF_PULL_HOLD,
> -};
> -

Why can't this be left here itself?

>  enum owl_pinconf_drv {
>  	OWL_PINCONF_DRV_2MA,
>  	OWL_PINCONF_DRV_4MA,
> @@ -278,6 +271,12 @@ struct owl_pinctrl_soc_data {
>  	unsigned int ngpios;
>  	const struct owl_gpio_port *ports;
>  	unsigned int nports;
> +	int (*padctl_val2arg)(const struct owl_padinfo *padinfo,
> +				unsigned int param,
> +				u32 *arg);
> +	int (*padctl_arg2val)(const struct owl_padinfo *info,
> +				unsigned int param,
> +				u32 *arg);
>  };
>  
>  int owl_pinctrl_probe(struct platform_device *pdev,
> diff --git a/drivers/pinctrl/actions/pinctrl-s900.c b/drivers/pinctrl/actions/pinctrl-s900.c
> index baa2f4847418..dc7bdc1f5cde 100644
> --- a/drivers/pinctrl/actions/pinctrl-s900.c
> +++ b/drivers/pinctrl/actions/pinctrl-s900.c
> @@ -13,6 +13,7 @@
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/pinctrl/pinctrl.h>
> +#include <linux/pinctrl/pinconf-generic.h>
>  #include "pinctrl-owl.h"
>  
>  /* Pinctrl registers offset */
> @@ -1717,6 +1718,67 @@ static const struct owl_gpio_port s900_gpio_ports[] = {
>  	OWL_GPIO_PORT(F, 0x00F0, 8, 0x0, 0x4, 0x8)
>  };
>  
> +enum owl_pinconf_pull {
> +	OWL_PINCONF_PULL_HIZ,
> +	OWL_PINCONF_PULL_DOWN,
> +	OWL_PINCONF_PULL_UP,
> +	OWL_PINCONF_PULL_HOLD,
> +};
> +
> +static int owl_pad_pinconf_s900_arg2val(const struct owl_padinfo *info,
> +				unsigned int param,
> +				u32 *arg)

How about s900_pad_pinconf_arg2val?

> +{
> +	switch (param) {
> +	case PIN_CONFIG_BIAS_BUS_HOLD:
> +		*arg = OWL_PINCONF_PULL_HOLD;
> +		break;
> +	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
> +		*arg = OWL_PINCONF_PULL_HIZ;
> +		break;
> +	case PIN_CONFIG_BIAS_PULL_DOWN:
> +		*arg = OWL_PINCONF_PULL_DOWN;
> +		break;
> +	case PIN_CONFIG_BIAS_PULL_UP:
> +		*arg = OWL_PINCONF_PULL_UP;
> +		break;
> +	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
> +		*arg = (*arg >= 1 ? 1 : 0);
> +		break;
> +	default:
> +		return -ENOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +static int owl_pad_pinconf_s900_val2arg(const struct owl_padinfo *padinfo,
> +				unsigned int param,
> +				u32 *arg)

How about s900_pad_pinconf_val2arg?

Thanks,
Mani

> +{
> +	switch (param) {
> +	case PIN_CONFIG_BIAS_BUS_HOLD:
> +		*arg = *arg == OWL_PINCONF_PULL_HOLD;
> +		break;
> +	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
> +		*arg = *arg == OWL_PINCONF_PULL_HIZ;
> +		break;
> +	case PIN_CONFIG_BIAS_PULL_DOWN:
> +		*arg = *arg == OWL_PINCONF_PULL_DOWN;
> +		break;
> +	case PIN_CONFIG_BIAS_PULL_UP:
> +		*arg = *arg == OWL_PINCONF_PULL_UP;
> +		break;
> +	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
> +		*arg = *arg == 1;
> +		break;
> +	default:
> +		return -ENOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
>  static struct owl_pinctrl_soc_data s900_pinctrl_data = {
>  	.padinfo = s900_padinfo,
>  	.pins = (const struct pinctrl_pin_desc *)s900_pads,
> @@ -1727,7 +1789,9 @@ static struct owl_pinctrl_soc_data s900_pinctrl_data = {
>  	.ngroups = ARRAY_SIZE(s900_groups),
>  	.ngpios = NUM_GPIOS,
>  	.ports = s900_gpio_ports,
> -	.nports = ARRAY_SIZE(s900_gpio_ports)
> +	.nports = ARRAY_SIZE(s900_gpio_ports),
> +	.padctl_arg2val = owl_pad_pinconf_s900_arg2val,
> +	.padctl_val2arg = owl_pad_pinconf_s900_val2arg,
>  };
>  
>  static int s900_pinctrl_probe(struct platform_device *pdev)
> -- 
> 2.18.0
> 
