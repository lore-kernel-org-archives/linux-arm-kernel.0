From: tony@atomide.com (Tony Lindgren)
Date: Thu, 8 Nov 2012 14:55:48 -0800
Subject: [PATCH v4 3/9] pinctrl: single: support pinconf generic
In-Reply-To: <1352301582-12244-4-git-send-email-haojian.zhuang@gmail.com>
References: <1352301582-12244-1-git-send-email-haojian.zhuang@gmail.com>
 <1352301582-12244-4-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <20121108225547.GL6801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Noticed few more things while playing with this.

* Haojian Zhuang <haojian.zhuang@gmail.com> [121107 07:21]:
> --- a/drivers/pinctrl/pinctrl-single.c
> +++ b/drivers/pinctrl/pinctrl-single.c
>  static int pcs_pinconf_get(struct pinctrl_dev *pctldev,
>  				unsigned pin, unsigned long *config)
>  {
> +	struct pcs_device *pcs = pinctrl_dev_get_drvdata(pctldev);
> +	enum pin_config_param param = pinconf_to_config_param(*config);
> +	unsigned data;
> +	u32 offset;

	I suggest adding:

	int res = -ENOTSUPP;

> +
> +	offset = pin * (pcs->width / BITS_PER_BYTE);
> +	data = pcs->read(pcs->base + offset);
> +
> +	switch (param) {
> +	case PIN_CONFIG_POWER_SOURCE:
> +		if (pcs->psmask == PCS_OFF_DISABLED
> +			|| pcs->psshift == PCS_OFF_DISABLED)
> +			return -ENOTSUPP;
> +		data &= pcs->psmask;
> +		data = data >> pcs->psshift;
> +		*config = data;
> +		return 0;
> +		break;

	then you can do:

		res = 0;
		break;

	instead of the return 0 and break.

> +	case PIN_CONFIG_BIAS_DISABLE:
> +		if (pcs->bmask == PCS_OFF_DISABLED
> +			|| pcs->bshift == PCS_OFF_DISABLED
> +			|| pcs->bdis == PCS_OFF_DISABLED)
> +			return -ENOTSUPP;
> +		data &= pcs->bmask;
> +		*config = 0;
> +		if (data == pcs->bdis)
> +			return 0;
> +		else
> +			return -EINVAL;
> +		break;
> +	case PIN_CONFIG_BIAS_PULL_UP:
> +		if (pcs->bmask == PCS_OFF_DISABLED
> +			|| pcs->bshift == PCS_OFF_DISABLED
> +			|| pcs->bpullup == PCS_OFF_DISABLED)
> +			return -ENOTSUPP;
> +		data &= pcs->bmask;
> +		*config = 0;
> +		if (data == pcs->bpullup)
> +			return 0;
> +		else
> +			return -EINVAL;
> +		break;
> +	case PIN_CONFIG_BIAS_PULL_DOWN:
> +		if (pcs->bmask == PCS_OFF_DISABLED
> +			|| pcs->bshift == PCS_OFF_DISABLED
> +			|| pcs->bpulldown == PCS_OFF_DISABLED)
> +			return -ENOTSUPP;
> +		data &= pcs->bmask;
> +		*config = 0;
> +		if (data == pcs->bpulldown)
> +			return 0;
> +		else
> +			return -EINVAL;
> +		break;
> +	default:
> +		break;
> +	}
>  	return -ENOTSUPP;

	return res;

>  }


Did you forget to add the input schmitt handling to pcs_pinconf_get()
above?
  
>  static int pcs_pinconf_set(struct pinctrl_dev *pctldev,
>  				unsigned pin, unsigned long config)
>  {
> -	return -ENOTSUPP;
> +	struct pcs_device *pcs = pinctrl_dev_get_drvdata(pctldev);
> +	enum pin_config_param config_param = pinconf_to_config_param(config);
> +	unsigned ret, mask = ~0UL;
> +	u32 offset, data;
> +
> +	switch (config_param) {
> +	case PIN_CONFIG_POWER_SOURCE:
> +		if (pcs->psmask == PCS_OFF_DISABLED
> +			|| pcs->psshift == PCS_OFF_DISABLED)
> +			return 0;
> +		mask = pcs->psmask;
> +		data = (pinconf_to_config_argument(config) << pcs->psshift)
> +			& pcs->psmask;
> +		break;
> +	case PIN_CONFIG_BIAS_DISABLE:
> +		if (pcs->bmask == PCS_OFF_DISABLED
> +			|| pcs->bshift == PCS_OFF_DISABLED)
> +			return 0;
> +		mask = pcs->bmask;
> +		data = (pinconf_to_config_argument(config) << pcs->bshift)
> +			& pcs->bmask;
> +		break;
> +	default:
> +		return 0;

Here we should probably return -ENOTSUPP instead for the unhandled
ones?

> +	}
> +	offset = pin * (pcs->width / BITS_PER_BYTE);
> +	ret = pcs->read(pcs->base + offset) & ~mask;
> +	pcs->write(ret | data, pcs->base + offset);
> +	return 0;
>  }

Then looks like pcs_pinconf_set() is also missing handling for few
of the things configured in the probe?

Regards,

Tony
