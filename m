From: tony@atomide.com (Tony Lindgren)
Date: Wed, 31 Oct 2012 17:44:07 -0700
Subject: [PATCH v3 3/9] pinctrl: single: support pinconf generic
In-Reply-To: <1351724661-29050-4-git-send-email-haojian.zhuang@gmail.com>
References: <1351724661-29050-1-git-send-email-haojian.zhuang@gmail.com>
 <1351724661-29050-4-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <20121101004406.GJ15766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> --- a/drivers/pinctrl/pinctrl-single.c
> +++ b/drivers/pinctrl/pinctrl-single.c
> @@ -20,6 +20,7 @@
>  #include <linux/of_device.h>
>  #include <linux/of_address.h>
>  
> +#include <linux/pinctrl/pinconf-generic.h>
>  #include <linux/pinctrl/pinctrl.h>
>  #include <linux/pinctrl/pinmux.h>
>  
> @@ -28,6 +29,9 @@
>  #define DRIVER_NAME			"pinctrl-single"
>  #define PCS_MUX_PINS_NAME		"pinctrl-single,pins"
>  #define PCS_MUX_BITS_NAME		"pinctrl-single,bits"
> +#define PCS_BIAS_NAME			"pinctrl-single,bias"
> +#define PCS_POWER_SOURCE_NAME		"pinctrl-single,power-source"
> +#define PCS_SCHMITT_NAME		"pinctrl-single,input-schmitt"
>  #define PCS_REG_NAME_LEN		((sizeof(unsigned long) * 2) + 1)
>  #define PCS_OFF_DISABLED		~0U
>  #define PCS_MAX_GPIO_VALUES		3

Here too you can remove the new defines.

>  static int pcs_parse_one_pinctrl_entry(struct pcs_device *pcs,
>  						struct device_node *np,
>  						struct pinctrl_map **map,
> +						unsigned num_configs,
>  						const char **pgnames)
>  {
...

Then I suggest you add a generic pinconf-generic property to
indicate the controller supports pinconf. At least for omaps,
only some register ranges support pinconf. And by adding
pinconf-generic, you can parse it once during the probe of
pinctrl-single.c, and set pcs->pinconf flag.

Then you can use here and avoid calling of_property_read_u32
for about 600 times unnecessarily for omap4:

if (pcs->pinconf) {

> +	if (!num_configs)
> +		return 0;
> +	config = devm_kzalloc(pcs->dev, sizeof(*config) * num_configs,
> +			      GFP_KERNEL);
> +	if (!config) {
> +		res = -ENOMEM;
> +		goto free_pingroup;
> +	}
> +	index = 0;
> +
> +	if (!of_property_read_u32(np, PCS_SCHMITT_NAME, &value))
> +		config[index++] =
> +			pinconf_to_config_packed(PIN_CONFIG_INPUT_SCHMITT,
> +						 value & 0xffff);
> +	if (!of_property_read_u32(np, PCS_BIAS_NAME, &value))
> +		config[index++] =
> +			pinconf_to_config_packed(PIN_CONFIG_BIAS_DISABLE,
> +						 value & 0xffff);
> +	if (!of_property_read_u32(np, PCS_POWER_SOURCE_NAME, &value))
> +		config[index++] =
> +			pinconf_to_config_packed(PIN_CONFIG_POWER_SOURCE,
> +						 value & 0xffff);

}

> +static int pcs_dt_check_maps(struct device_node *np, unsigned *num_maps,
> +			     unsigned *num_configs)
> +{
> +	unsigned size;
> +
> +	*num_maps = 0;
> +	*num_configs = 0;
> +	if (of_get_property(np, PCS_MUX_PINS_NAME, &size)
> +		|| of_get_property(np, PCS_MUX_BITS_NAME, &size))
> +		(*num_maps)++;
> +	if (of_get_property(np, PCS_SCHMITT_NAME, &size))
> +		(*num_configs)++;
> +	if (of_get_property(np, PCS_BIAS_NAME, &size))
> +		(*num_configs)++;
> +	if (of_get_property(np, PCS_POWER_SOURCE_NAME, &size))
> +		(*num_configs)++;
> +	if (*num_configs)
> +		(*num_maps)++;
> +	if (!(*num_maps))
> +		return -EINVAL;
> +	return 0;
> +}
> +
>  /**
>   * pcs_dt_node_to_map() - allocates and parses pinctrl maps
>   * @pctldev: pinctrl instance
> @@ -802,29 +1019,32 @@ static int pcs_dt_node_to_map(struct pinctrl_dev *pctldev,
>  {
>  	struct pcs_device *pcs;
>  	const char **pgnames;
> +	unsigned num_configs;
>  	int ret;
>  
>  	pcs = pinctrl_dev_get_drvdata(pctldev);

Here too:

if (pcs->pinconf) {
  
> -	*map = devm_kzalloc(pcs->dev, sizeof(**map), GFP_KERNEL);
> +	ret = pcs_dt_check_maps(np_config, num_maps, &num_configs);
> +	if (ret)
> +		return ret;
> +
> +	*map = devm_kzalloc(pcs->dev, sizeof(**map) * (*num_maps), GFP_KERNEL);
>  	if (!map)
>  		return -ENOMEM;

} else {
 
> -	*num_maps = 0;
> -

}

Regards,

Tony
