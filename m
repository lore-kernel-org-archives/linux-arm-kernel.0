From: tony@atomide.com (Tony Lindgren)
Date: Fri, 16 Nov 2012 16:43:13 -0800
Subject: [PATCH v5 05/10] pinctrl: single: support pinconf generic
In-Reply-To: <1352968600-15345-6-git-send-email-haojian.zhuang@gmail.com>
References: <1352968600-15345-1-git-send-email-haojian.zhuang@gmail.com>
 <1352968600-15345-6-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <20121117004313.GN6801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

>  static int pcs_pinconf_get(struct pinctrl_dev *pctldev,
>  				unsigned pin, unsigned long *config)
>  {
> -	return -ENOTSUPP;
> +	struct pcs_device *pcs = pinctrl_dev_get_drvdata(pctldev);
> +	enum pin_config_param config_param = pinconf_to_config_param(*config);
> +	union pcs_pinconf_argument_t arg;
> +	u32 offset;
> +	unsigned data;
> +	int ret;
> +
> +	if (!pcs->conf.nconfs)
> +		return -ENOTSUPP;
> +
> +	ret = pcs_pinconf_get_config(pctldev, pin, config_param);
> +	if (ret < 0)
> +		return ret;
> +
> +	offset = pin * (pcs->width / BITS_PER_BYTE);
> +	data = pcs->read(pcs->base + offset);
> +
> +	arg.data = pinconf_to_config_argument(ret);
> +	data = (data >> arg.bits.shift) & arg.bits.mask;

Shouldn't you just return data here?

	*config = data;

	return 0;

> +	arg.bits.value = data;
> +	*config = pinconf_to_config_packed(config_param, arg.data);
> +	return 0;

Instead of these? Or how else is the consumer driver supposed
to use the value?

>  }
>  
>  static int pcs_pinconf_set(struct pinctrl_dev *pctldev,
>  				unsigned pin, unsigned long config)
>  {
> -	return -ENOTSUPP;
> +	struct pcs_device *pcs = pinctrl_dev_get_drvdata(pctldev);
> +	enum pin_config_param config_param = pinconf_to_config_param(config);
> +	union pcs_pinconf_argument_t arg;
> +	u32 offset;
> +	unsigned data;
> +	int ret;
> +
> +	if (!pcs->conf.nconfs)
> +		return -ENOTSUPP;
> +
> +	ret = pcs_pinconf_get_config(pctldev, pin, config_param);
> +	if (ret < 0)
> +		return ret;
> +
> +	offset = pin * (pcs->width / BITS_PER_BYTE);
> +	data = pcs->read(pcs->base + offset);
> +
> +	arg.data = pinconf_to_config_argument(config);
> +	data = (data >> arg.bits.shift) & arg.bits.mask;
> +	arg.bits.value = data;
> +	data = pinconf_to_config_packed(config_param, arg.data);
> +	pcs->write(data, pcs->base + offset);
> +	return 0;
>  }

I need to look at this more to understand how this actually relates
to what gets written to the register with my test case :)
  
> @@ -765,12 +958,82 @@ static int pcs_parse_one_pinctrl_entry(struct pcs_device *pcs,
>  	if (res < 0)
>  		goto free_function;
>  
> -	(*map)->type = PIN_MAP_TYPE_MUX_GROUP;
> -	(*map)->data.mux.group = np->name;
> -	(*map)->data.mux.function = np->name;
> +	m->type = PIN_MAP_TYPE_MUX_GROUP;
> +	m->data.mux.group = np->name;
> +	m->data.mux.function = np->name;
> +
> +	if (!nconfs)
> +		return 0;
> +
> +	conf = devm_kzalloc(pcs->dev, sizeof(*conf) * nconfs, GFP_KERNEL);
> +	if (!conf) {
> +		res = -ENOMEM;
> +		goto free_pingroup;
> +	}
> +	i = 0;
> +	if (!of_property_read_u32_array(np, "pinctrl-single,bias",
> +					value, 5)) {
> +		/* array: bias value, mask, disable, pull down, pull up */
> +		data = value[0] & value[1];
> +		arg.bits.shift = ffs(value[1]) - 1;
> +		arg.bits.mask = value[1] >> arg.bits.shift;
> +		if (pcs_config_match(data, value[2])) {
> +			arg.bits.value = value[2] >> arg.bits.shift;
> +			conf[i++] = PIN_CONF_PACKED(PIN_CONFIG_BIAS_DISABLE,
> +						    arg.data);
> +		}
> +		if (pcs_config_match(data, value[3])) {
> +			arg.bits.value = value[3] >> arg.bits.shift;
> +			conf[i++] = PIN_CONF_PACKED(PIN_CONFIG_BIAS_PULL_DOWN,
> +						    arg.data);
> +		}
> +		if (pcs_config_match(data, value[4])) {
> +			arg.bits.value = value[4] >> arg.bits.shift;
> +			conf[i++] = PIN_CONF_PACKED(PIN_CONFIG_BIAS_PULL_UP,
> +						    arg.data);
> +		}
> +	}

Doesn't this mean you only get one of the above working? What happens
if you initially need to set BIAS_DISABLE, but then the consumer driver
wants to set BIAS_PULL_DOWN or something?

Maybe we need separate pinctrl-single,bias-disable, pinctrl-single,bias-pull-down
and pinctrl-single,bias-pull-up?

> +	if (!of_property_read_u32_array(np, "pinctrl-single,power-source",
> +					value, 2)) {
> +		/* array: power source value, mask */
> +		data = value[0] & value[1];
> +		arg.bits.shift = ffs(value[1]) - 1;
> +		arg.bits.mask = value[1] >> arg.bits.shift;
> +		arg.bits.value = data >> arg.bits.shift;
> +		conf[i++] = PIN_CONF_PACKED(PIN_CONFIG_POWER_SOURCE, arg.data);
> +	}
> +	if (!of_property_read_u32_array(np, "pinctrl-single,input-schmitt",
> +					value, 3)) {
> +		/* array: input schmitt value, mask, disable */
> +		data = value[0] & value[1];
> +		arg.bits.shift = ffs(value[1]) - 1;
> +		arg.bits.mask = value[1] >> arg.bits.shift;
> +		if (pcs_config_match(data, value[2])) {
> +			arg.bits.value = value[2] >> arg.bits.shift;
> +			conf[i++] = PIN_CONF_PACKED(PIN_CONFIG_INPUT_SCHMITT_DISABLE,
> +						    arg.data);
> +		} else {
> +			arg.bits.value = data >> arg.bits.shift;
> +			conf[i++] = PIN_CONF_PACKED(PIN_CONFIG_INPUT_SCHMITT,
> +						    arg.data);
> +		}
> +	}

And I think this has a similar problem? What if the consumer driver wants
to set INPUT_SCHMITT with pin_config_set() and the initial value is
SCHMITT_DISABLE? Doesn't the consumer driver get -ENOTSUPP in that case?

I'll look at this more early next week and try to get my testcase working
with it.

Regards,

Tony
