From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 28 Aug 2013 01:14:11 +0200
Subject: [PATCH v4] pinctrl: Pass all configs to driver on pin_config_set()
In-Reply-To: <1377628332-12303-1-git-send-email-syin@broadcom.com>
References: <1377134300-25480-1-git-send-email-syin@broadcom.com>
 <1377628332-12303-1-git-send-email-syin@broadcom.com>
Message-ID: <12648377.rRBG7cWhRe@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 27 August 2013 11:32:12 Sherman Yin wrote:
> When setting pin configuration in the pinctrl framework, pin_config_set() or
> pin_config_group_set() is called in a loop to set one configuration at a
> time for the specified pin or group.
> 
> This patch 1) removes the loop and 2) changes the API to pass the whole pin
> config array to the driver.  It is now up to the driver to loop through the
> configs.  This allows the driver to potentially combine configs and reduce
> the number of writes to pin config registers.
> 
> All c files changed have been build-tested to verify the change compiles and
> that the corresponding .o is successfully generated.
> 
> Signed-off-by: Sherman Yin <syin@broadcom.com>
> Reviewed-by: Christian Daudt <csd@broadcom.com>
> Reviewed-by: Matt Porter <matt.porter@linaro.org>
> 
>   drivers/pinctrl/pinconf.c             |   42 ++++----
>   drivers/pinctrl/pinctrl-tegra.c       |   69 ++++++------
>   include/linux/pinctrl/pinconf.h       |    6 +-
> Reviewed-by: Stephen Warren <swarren@nvidia.com>
> 
>   On Tegra (Tegra114 Dalmore board, on top of next-20130816),
> Tested-by: Stephen Warren <swarren@nvidia.com>

For drivers/pinctrl/sh-pfc/pinctrl.c,

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> Please refer to the discussion with Linus W. "[PATCH] ARM: Adds pin config
> API to set all configs in one function" here:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-May/166567.html
> 
> All c files changed have been build-tested to verify the change compiles and
> that the corresponding .o are successfully generated.
> 
> [v2]	rebased on LinusW's linux-pinctrl.git "devel" branch.  Fixed and
> build-tested pinctrl-sunxi.c
> [v3]	rebased on linux-pinctrl.git:devel as of 2013.08.25. Applied API
> change to new driver pinctrl-palmas.c. Re build-tested all files.
> [v4]	Changed int to unsigned int in sh-pfc/pinctrl.c
> ---
>  drivers/pinctrl/mvebu/pinctrl-mvebu.c |   26 +++--
>  drivers/pinctrl/pinconf.c             |   42 ++++----
>  drivers/pinctrl/pinctrl-abx500.c      |  187 ++++++++++++++++--------------
>  drivers/pinctrl/pinctrl-at91.c        |   48 +++++----
>  drivers/pinctrl/pinctrl-bcm2835.c     |   43 ++++----
>  drivers/pinctrl/pinctrl-exynos5440.c  |  113 +++++++++++---------
>  drivers/pinctrl/pinctrl-falcon.c      |   63 ++++++-----
>  drivers/pinctrl/pinctrl-imx.c         |   28 ++---
>  drivers/pinctrl/pinctrl-mxs.c         |   91 ++++++++--------
>  drivers/pinctrl/pinctrl-nomadik.c     |  125 ++++++++++++----------
>  drivers/pinctrl/pinctrl-palmas.c      |  134 ++++++++++++-----------
>  drivers/pinctrl/pinctrl-rockchip.c    |   57 ++++++----
>  drivers/pinctrl/pinctrl-samsung.c     |   17 ++-
>  drivers/pinctrl/pinctrl-single.c      |   33 ++++--
>  drivers/pinctrl/pinctrl-st.c          |   11 +-
>  drivers/pinctrl/pinctrl-sunxi.c       |   77 +++++++-------
>  drivers/pinctrl/pinctrl-tegra.c       |   69 ++++++------
>  drivers/pinctrl/pinctrl-tz1090-pdc.c  |  135 ++++++++++++++----------
>  drivers/pinctrl/pinctrl-tz1090.c      |  140 +++++++++++++-----------
>  drivers/pinctrl/pinctrl-u300.c        |   18 ++--
>  drivers/pinctrl/pinctrl-xway.c        |  119 +++++++++++++--------
>  drivers/pinctrl/sh-pfc/pinctrl.c      |   42 ++++----
>  drivers/pinctrl/vt8500/pinctrl-wmt.c  |   54 +++++-----
>  include/linux/pinctrl/pinconf.h       |    6 +-
>  24 files changed, 952 insertions(+), 726 deletions(-)

[snip]

> diff --git a/drivers/pinctrl/sh-pfc/pinctrl.c
> b/drivers/pinctrl/sh-pfc/pinctrl.c index 8649ec3..e758af9 100644
> --- a/drivers/pinctrl/sh-pfc/pinctrl.c
> +++ b/drivers/pinctrl/sh-pfc/pinctrl.c
> @@ -529,38 +529,44 @@ static int sh_pfc_pinconf_get(struct pinctrl_dev
> *pctldev, unsigned _pin, }
> 
>  static int sh_pfc_pinconf_set(struct pinctrl_dev *pctldev, unsigned _pin,
> -			      unsigned long config)
> +			      unsigned long *configs, unsigned num_configs)
>  {
>  	struct sh_pfc_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
>  	struct sh_pfc *pfc = pmx->pfc;
> -	enum pin_config_param param = pinconf_to_config_param(config);
> +	enum pin_config_param param;
>  	unsigned long flags;
> +	unsigned int i;
> 
> -	if (!sh_pfc_pinconf_validate(pfc, _pin, param))
> -		return -ENOTSUPP;
> +	for (i = 0; i < num_configs; i++) {
> +		param = pinconf_to_config_param(configs[i]);
> 
> -	switch (param) {
> -	case PIN_CONFIG_BIAS_PULL_UP:
> -	case PIN_CONFIG_BIAS_PULL_DOWN:
> -	case PIN_CONFIG_BIAS_DISABLE:
> -		if (!pfc->info->ops || !pfc->info->ops->set_bias)
> +		if (!sh_pfc_pinconf_validate(pfc, _pin, param))
>  			return -ENOTSUPP;
> 
> -		spin_lock_irqsave(&pfc->lock, flags);
> -		pfc->info->ops->set_bias(pfc, _pin, param);
> -		spin_unlock_irqrestore(&pfc->lock, flags);
> +		switch (param) {
> +		case PIN_CONFIG_BIAS_PULL_UP:
> +		case PIN_CONFIG_BIAS_PULL_DOWN:
> +		case PIN_CONFIG_BIAS_DISABLE:
> +			if (!pfc->info->ops || !pfc->info->ops->set_bias)
> +				return -ENOTSUPP;
> 
> -		break;
> +			spin_lock_irqsave(&pfc->lock, flags);
> +			pfc->info->ops->set_bias(pfc, _pin, param);
> +			spin_unlock_irqrestore(&pfc->lock, flags);
> 
> -	default:
> -		return -ENOTSUPP;
> -	}
> +			break;
> +
> +		default:
> +			return -ENOTSUPP;
> +		}
> +	} /* for each config */
> 
>  	return 0;
>  }
> 
>  static int sh_pfc_pinconf_group_set(struct pinctrl_dev *pctldev, unsigned
> group, -				    unsigned long config)
> +				    unsigned long *configs,
> +				    unsigned num_configs)
>  {
>  	struct sh_pfc_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
>  	const unsigned int *pins;
> @@ -571,7 +577,7 @@ static int sh_pfc_pinconf_group_set(struct pinctrl_dev
> *pctldev, unsigned group, num_pins = pmx->pfc->info->groups[group].nr_pins;
> 
>  	for (i = 0; i < num_pins; ++i)
> -		sh_pfc_pinconf_set(pctldev, pins[i], config);
> +		sh_pfc_pinconf_set(pctldev, pins[i], configs, num_configs);
> 
>  	return 0;
>  }

-- 
Regards,

Laurent Pinchart
