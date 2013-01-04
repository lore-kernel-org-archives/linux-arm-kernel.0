From: tony@atomide.com (Tony Lindgren)
Date: Thu, 3 Jan 2013 16:14:21 -0800
Subject: [PATCH v6 1/8] pinctrl: single: support generic pinconf
In-Reply-To: <1356083118-18857-2-git-send-email-haojian.zhuang@linaro.org>
References: <1356083118-18857-1-git-send-email-haojian.zhuang@linaro.org>
 <1356083118-18857-2-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <20130104001420.GN25633@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Haojian Zhuang <haojian.zhuang@linaro.org> [121221 01:48]:
> --- a/drivers/pinctrl/pinctrl-single.c
> +++ b/drivers/pinctrl/pinctrl-single.c
> @@ -60,6 +61,19 @@ struct pcs_func_vals {
>  };
>  
>  /**
> + * struct pcs_conf_vals - pinconf parameter, pinconf register offset
> + * and value/mask pair
> + * @param:	config parameter
> + * @val:	register value
> + * @mask:	mask of register value
> + */
> +struct pcs_conf_vals {
> +	enum pin_config_param param;
> +	unsigned val;
> +	unsigned mask;
> +};
> +
> +/**
>   * struct pcs_function - pinctrl function
>   * @name:	pinctrl function name
>   * @vals:	register and vals array
> @@ -74,6 +88,8 @@ struct pcs_function {
>  	unsigned nvals;
>  	const char **pgnames;
>  	int npgnames;
> +	struct pcs_conf_vals *conf;
> +	int nconfs;
>  	struct list_head node;
>  };

That's nice, that will work much better than the earlier solution :)
  
> @@ -448,25 +466,149 @@ static struct pinmux_ops pcs_pinmux_ops = {
>  static int pcs_pinconf_get(struct pinctrl_dev *pctldev,
>  				unsigned pin, unsigned long *config)
>  {
> +	struct pcs_device *pcs = pinctrl_dev_get_drvdata(pctldev);
> +	struct pin_desc *pdesc = pin_desc_get(pctldev, pin);
> +	struct pcs_function *func;
> +	const struct pinctrl_setting_mux *setting;
> +	unsigned fselector, offset = 0, data = 0, i, j;
> +
> +	/* If pin is not described in DTS & enabled, mux_setting is NULL. */
> +	setting = pdesc->mux_setting;
> +	if (!setting)
> +		return -ENOTSUPP;
> +	fselector = setting->func;
> +	func = radix_tree_lookup(&pcs->ftree, fselector);
> +	if (!func) {
> +		dev_err(pcs->dev, "%s could not find function%i\n",
> +			__func__, fselector);
> +		return -ENOTSUPP;
> +	}
> +
> +	for (i = 0; i < func->nconfs; i++) {
> +		if (pinconf_to_config_param(*config) != func->conf[i].param)
> +			continue;
> +		offset = pin * (pcs->width / BITS_PER_BYTE);
> +		data = pcs->read(pcs->base + offset);
> +		data &= func->conf[i].mask;
> +		switch (func->conf[i].param) {
> +		case PIN_CONFIG_BIAS_DISABLE:
> +		case PIN_CONFIG_BIAS_PULL_DOWN:
> +		case PIN_CONFIG_BIAS_PULL_UP:
> +		case PIN_CONFIG_INPUT_SCHMITT_DISABLE:
> +			if (data != func->conf[i].val)
> +				return -ENOTSUPP;
> +			*config = data;
> +			break;
> +		case PIN_CONFIG_INPUT_SCHMITT:
> +			/* either INPUT_SCHMITT or DISABLE */
> +			for (j = 0; j < func->nconfs; j++) {
> +				switch (func->conf[j].param) {
> +				case PIN_CONFIG_INPUT_SCHMITT_DISABLE:
> +					if (data == func->conf[j].val)
> +						return -ENOTSUPP;
> +					break;
> +				default:
> +					break;
> +				}
> +			}
> +			*config = data;
> +			break;

We should standardize on the binding format of <enableval disableval regmask>
and then all these can be handled the same way I think. And that makes the
binding more generic.

> +		default:
> +			*config = data;
> +			break;
> +		}
> +		return 0;
> +	}

Should we set *config = 0 here too?

>  	return -ENOTSUPP;
>  }

And we should probably just return the raw pinfonf register value
when PIN_CONFIG_END is passed. For write too, we should probably
just write the raw register value when PIN_CONFIG_END is passed
as there can be related pinconf settings that a client driver may
need to use. An example I have for that is a simple USB transceiver
that may provide multiple comparators to figure out the charger
state.
  
> +static int pcs_config_match(unsigned data, unsigned match)
> +{
> +	int ret = 0;
> +
> +	if (!match) {
> +		if (!data)
> +			ret = 1;
> +	} else {
> +		if ((data & match) == match)
> +			ret = 1;
> +	}
> +	return ret;
> +}

How about do the following here:

static int pcs_config_match(unsigned data, unsigned match)
{
	if (!match && !data)
		return 1;	/* typo? do we really return 1 here? */

	if ((data & match) == match)
		return 1;

	return 0;
}

Regards,

Tony
