From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Wed, 24 Feb 2016 10:21:16 -0800
Subject: [PATCH 01/50] pinctrl: Add devm_ apis for pinctrl_{register,
 unregister}
In-Reply-To: <1456319775-3216-2-git-send-email-ldewangan@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
 <1456319775-3216-2-git-send-email-ldewangan@nvidia.com>
Message-ID: <20160224182116.GP21240@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 24 Feb 05:15 PST 2016, Laxman Dewangan wrote:

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
[..]
> +static int devm_pinctrl_dev_match(struct device *dev, void *res, void *data)
> +{
> +	struct pctldev **r = res;
> +
> +	if (!r || !*r) {
> +		WARN_ON(!r || !*r);
> +		return 0;
> +	}

The idiomatic way is to wrap your condition in the WARN_ON; i.e. 

if (WARN_ON(!r || !*r))
	return 0;

> +
> +	return *r == data;
> +}
> +
[..]
> +
> +/**
> + * devm_pinctrl_unregister() - Resource manager of pinctrl_unregister()
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

ret is unlikely to be non-zero in a code path only taken when ret is
zero.

Do either:

WARN_ON(devres_release(...));

rc = devres_release(..);
WARN_ON(rc);

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

Apart from these style issues you have my ack.

Regards,
Bjorn
