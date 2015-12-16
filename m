From: patrice.chotard@st.com (Patrice Chotard)
Date: Wed, 16 Dec 2015 17:55:09 +0100
Subject: [PATCH v3 4/9] pinctrl: Add STM32 MCUs support
In-Reply-To: <1449822306-9035-5-git-send-email-mcoquelin.stm32@gmail.com>
References: <1449822306-9035-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1449822306-9035-5-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <5671976D.2050706@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime


On 12/11/2015 09:25 AM, Maxime Coquelin wrote:
> This patch adds pinctrl and GPIO support to STMicroelectronic's STM32
> family of MCUs.
>
> While it only supports STM32F429 for now, it has been designed to enable
> support of other MCUs of the family (e.g. STM32F746).
>
> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> ---
>   drivers/pinctrl/Kconfig                   |    1 +
>   drivers/pinctrl/Makefile                  |    1 +
>   drivers/pinctrl/stm32/Kconfig             |   16 +
>   drivers/pinctrl/stm32/Makefile            |    5 +
>   drivers/pinctrl/stm32/pinctrl-stm32.c     |  856 +++++++++++++++
>   drivers/pinctrl/stm32/pinctrl-stm32.h     |   43 +
>   drivers/pinctrl/stm32/pinctrl-stm32f429.c | 1598 +++++++++++++++++++++++++++++
>   7 files changed, 2520 insertions(+)
>   create mode 100644 drivers/pinctrl/stm32/Kconfig
>   create mode 100644 drivers/pinctrl/stm32/Makefile
>   create mode 100644 drivers/pinctrl/stm32/pinctrl-stm32.c
>   create mode 100644 drivers/pinctrl/stm32/pinctrl-stm32.h
>   create mode 100644 drivers/pinctrl/stm32/pinctrl-stm32f429.c
>

[...]

> +
> +static int stm32_pctrl_dt_subnode_to_map(struct pinctrl_dev *pctldev,
> +				      struct device_node *node,
> +				      struct pinctrl_map **map,
> +				      unsigned *reserved_maps,
> +				      unsigned *num_maps)
> +{
> +	struct stm32_pinctrl *pctl;
> +	struct stm32_pinctrl_group *grp;
> +	struct property *pins;
> +	u32 pinfunc, pin, func;
> +	unsigned long *configs;
> +	unsigned int num_configs;
> +	bool has_config = 0;
> +	unsigned reserve = 0;
> +	int num_pins, num_funcs, maps_per_pin, i, err;
> +
> +	pctl = pinctrl_dev_get_drvdata(pctldev);
> +
> +	pins = of_find_property(node, "pinmux", NULL);
> +	if (!pins) {
> +		dev_err(pctl->dev, "missing pins property in node %s .\n",
> +				node->name);
> +		return -EINVAL;
> +	}
> +
> +	err = pinconf_generic_parse_dt_config(node, pctldev, &configs,
> +		&num_configs);
> +	if (num_configs)
> +		has_config = 1;
> +
> +	num_pins = pins->length / sizeof(u32);
> +	num_funcs = num_pins;
> +	maps_per_pin = 0;
> +	if (num_funcs)
> +		maps_per_pin++;
> +	if (has_config && num_pins >= 1)
> +		maps_per_pin++;
> +
> +	if (!num_pins || !maps_per_pin)
> +		return -EINVAL;
> +
> +	reserve = num_pins * maps_per_pin;
> +
> +	err = pinctrl_utils_reserve_map(pctldev, map,
> +			reserved_maps, num_maps, reserve);
> +	if (err < 0)
> +		goto fail;
> +
> +	for (i = 0; i < num_pins; i++) {
> +		err = of_property_read_u32_index(node, "pinmux",
> +				i, &pinfunc);
> +		if (err)
> +			goto fail;

as a "goto fail" doesn't do more than a return, here do directly "return 
err;"

> +
> +		pin = STM32_GET_PIN_NO(pinfunc);
> +		func = STM32_GET_PIN_FUNC(pinfunc);
> +
> +		if (pin >= pctl->match_data->npins) {
> +			dev_err(pctl->dev, "invalid pin number.\n");
> +			err = -EINVAL;
> +			goto fail;

ditto, return -EINVAL

> +		}
> +
> +		if (!stm32_pctrl_is_function_valid(pctl, pin, func)) {
> +			dev_err(pctl->dev, "invalid function.\n");
> +			err = -EINVAL;
> +			goto fail;

ditto

> +		}
> +
> +		grp = stm32_pctrl_find_group_by_pin(pctl, pin);
> +		if (!grp) {
> +			dev_err(pctl->dev, "unable to match pin %d to group\n",
> +					pin);
> +			return -EINVAL;
> +		}
> +
> +		err = stm32_pctrl_dt_node_to_map_func(pctl, pin, func, grp, map,
> +				reserved_maps, num_maps);
> +		if (err < 0)
> +			goto fail;

ditto

> +
> +		if (has_config) {
> +			err = pinctrl_utils_add_map_configs(pctldev, map,
> +					reserved_maps, num_maps, grp->name,
> +					configs, num_configs,
> +					PIN_MAP_TYPE_CONFIGS_GROUP);
> +			if (err < 0)
> +				goto fail;

ditto

> +		}
> +	}
> +
> +	return 0;
> +
> +fail:
> +	return err;
> +}
> +

[...]

> +
> +static int stm32_pmx_set_mux(struct pinctrl_dev *pctldev,
> +			    unsigned function,
> +			    unsigned group)
> +{
> +	bool ret;
> +	const struct stm32_desc_function *desc;
> +	struct stm32_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
> +	struct stm32_pinctrl_group *g = pctl->groups + group;
> +	struct pinctrl_gpio_range *range;
> +	struct stm32_gpio_bank *bank;
> +	u32 mode, alt;
> +	int pin;
> +
> +	ret = stm32_pctrl_is_function_valid(pctl, g->pin, function);
> +	if (!ret) {
> +		dev_err(pctl->dev, "invalid function %d on group %d .\n",
> +				function, group);
> +		return -EINVAL;
> +	}
> +
> +	desc = stm32_pctrl_find_function_by_pin(pctl, g->pin, function);
> +	if (!desc)
> +		return -EINVAL;

stm32_pctrl_find_function_by_pin() is useless, desc is never used

stm32_pctrl_is_function_valid(), above, already checks that function exists for the requested pins

> +
> +	range = pinctrl_find_gpio_range_from_pin(pctldev, g->pin);
> +	bank = gpio_range_to_bank(range);
> +	pin = stm32_gpio_pin(g->pin);
> +
> +	mode = stm32_gpio_get_mode(function);
> +	alt = stm32_gpio_get_alt(function);
> +
> +	stm32_pmx_set_mode(bank, pin, mode, alt);
> +
> +	return 0;
> +}
> +
>
