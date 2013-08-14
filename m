From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 14 Aug 2013 10:34:38 -0600
Subject: [PATCH] pinctrl: improve warning messages
In-Reply-To: <1376497533-32303-1-git-send-email-linus.walleij@linaro.org>
References: <1376497533-32303-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <520BB19E.8040901@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/14/2013 10:25 AM, Linus Walleij wrote:
> Print out the affected group name on activation of pin mux
> settings, and warn if you cannot free a pin that should have
> been part of a certain setting.

> diff --git a/drivers/pinctrl/pinmux.c b/drivers/pinctrl/pinmux.c

> @@ -411,9 +415,14 @@ int pinmux_enable_setting(struct pinctrl_setting const *setting)
>  	for (i = 0; i < num_pins; i++) {
>  		ret = pin_request(pctldev, pins[i], setting->dev_name, NULL);
>  		if (ret) {
> +			const char *gname;
> +
> +			gname = pctlops->get_group_name(pctldev,
> +						setting->data.mux.group);
>  			dev_err(pctldev->dev,
> -				"could not request pin %d on device %s\n",
> -				pins[i], pinctrl_dev_get_name(pctldev));
> +				"could not request pin %d from group %s on "
> +				"device %s\n",
> +				pins[i], gname, pinctrl_dev_get_name(pctldev));

I think it'd be useful to print the pin name rather than pin number here.

> @@ -486,6 +499,16 @@ void pinmux_disable_setting(struct pinctrl_setting const *setting)
>  			desc->mux_setting = NULL;
>  			/* And release the pin */
>  			pin_free(pctldev, pins[i], NULL);
> +		} else {
> +			const char *gname;
> +
> +			gname = pctlops->get_group_name(pctldev,
> +						setting->data.mux.group);
> +			dev_warn(pctldev->dev,
> +				 "not freeing pin %d as part of deactivating "
> +				 "group %s - it is already used for some other "
> +				 "setting",
> +				 pins[i], gname);
>  		}
>  	}

I think that will only happen if one of the pinmux_enabling_setting
prints already happened. Is it worth adding this one?
