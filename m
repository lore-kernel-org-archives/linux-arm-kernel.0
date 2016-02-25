From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 25 Feb 2016 15:46:50 +0100
Subject: [PATCH 01/50] pinctrl: Add devm_ apis for pinctrl_{register,
 unregister}
In-Reply-To: <1456319775-3216-2-git-send-email-ldewangan@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
 <1456319775-3216-2-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456411610.3268.13.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laxman,

Am Mittwoch, den 24.02.2016, 18:45 +0530 schrieb Laxman Dewangan:
> Add device managed APIs devm_pinctrl_register() and
> devm_pinctrl_unregister() for the APIs pinctrl_register()
> and pinctrl_unregister().
> 
> This helps in reducing code in error path and sometimes
> removal of .remove callback for driver unbind.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> ---
>  drivers/pinctrl/core.c          | 69 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/pinctrl/pinctrl.h |  6 ++++
>  2 files changed, 75 insertions(+)
> 
> diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
> index 2686a44..ea4a7e6 100644
> --- a/drivers/pinctrl/core.c
> +++ b/drivers/pinctrl/core.c
> @@ -1861,6 +1861,75 @@ void pinctrl_unregister(struct pinctrl_dev *pctldev)
>  }
>  EXPORT_SYMBOL_GPL(pinctrl_unregister);
>  
> +static void devm_pinctrl_dev_release(struct device *dev, void *res)
> +{
> +	struct pinctrl_dev *pctldev = *(struct pinctrl_dev **)res;
> +
> +	pinctrl_unregister(pctldev);
> +}
> +
> +static int devm_pinctrl_dev_match(struct device *dev, void *res, void *data)
> +{
> +	struct pctldev **r = res;
> +
> +	if (!r || !*r) {
> +		WARN_ON(!r || !*r);
> +		return 0;
> +	}


This could be simplified to

	if (WARN_ON(!r || !*r))
		return 0;

> +
> +	return *r == data;
> +}
> +
> +/**
> + * devm_pinctrl_register() - Resource manager pinctrl_register()

Should that be "Resource managed" ?

> + * @dev: parent device for this pin controller
> + * @pctldesc: descriptor for this pin controller
> + * @driver_data: private pin controller data for this pin controller
> + *
> + * Returns an error pointer if pincontrol register failed. Otherwise
> + * it returns valid pinctrl handle.
> + *
> + * The pinctrl device will be automatically released when the device is unbound.
> + */
> +struct pinctrl_dev *devm_pinctrl_register(struct device *dev,
> +					  struct pinctrl_desc *pctldesc,
> +					  void *driver_data)
> +{
> +	struct pinctrl_dev **ptr, *pctldev;
> +
> +	ptr = devres_alloc(devm_pinctrl_dev_release, sizeof(*ptr), GFP_KERNEL);
> +	if (!ptr)
> +		return ERR_PTR(-ENOMEM);
> +
> +	pctldev = pinctrl_register(pctldesc, dev, driver_data);
> +	if (IS_ERR(pctldev)) {
> +		devres_free(ptr);
> +		return pctldev;
> +	}
> +
> +	*ptr = pctldev;
> +	devres_add(dev, ptr);
> +
> +	return pctldev;
> +}
> +EXPORT_SYMBOL_GPL(devm_pinctrl_register);
> +
> +/**
> + * devm_pinctrl_unregister() - Resource manager of pinctrl_unregister()

Should that be "Resource managed version of" ?

> + * @dev: device for which which resource was allocated
> + * @pctldev: the pinctrl device to unregister.
> + */
> +void devm_pinctrl_unregister(struct device *dev, struct pinctrl_dev *pctldev)
> +{
> +	int ret;
> +
> +	ret = devres_release(dev, devm_pinctrl_dev_release,
> +			     devm_pinctrl_dev_match, pctldev);
> +	if (!ret)
> +		WARN_ON(ret);
> +}
> +EXPORT_SYMBOL_GPL(devm_pinctrl_unregister);
> +
>  static int __init pinctrl_init(void)
>  {
>  	pr_info("initialized pinctrl subsystem\n");
> diff --git a/include/linux/pinctrl/pinctrl.h b/include/linux/pinctrl/pinctrl.h
> index 9ba59fc..a42e57d 100644
> --- a/include/linux/pinctrl/pinctrl.h
> +++ b/include/linux/pinctrl/pinctrl.h
> @@ -144,6 +144,12 @@ struct pinctrl_desc {
>  extern struct pinctrl_dev *pinctrl_register(struct pinctrl_desc *pctldesc,
>  				struct device *dev, void *driver_data);
>  extern void pinctrl_unregister(struct pinctrl_dev *pctldev);
> +extern struct pinctrl_dev *devm_pinctrl_register(struct device *dev,
> +				struct pinctrl_desc *pctldesc,
> +				void *driver_data);
> +extern void devm_pinctrl_unregister(struct device *dev,
> +				struct pinctrl_dev *pctldev);
> +
>  extern bool pin_is_valid(struct pinctrl_dev *pctldev, int pin);
>  extern void pinctrl_add_gpio_range(struct pinctrl_dev *pctldev,
>  				struct pinctrl_gpio_range *range);

With those addressed,
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
