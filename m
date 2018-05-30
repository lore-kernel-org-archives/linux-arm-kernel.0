From: jonathanh@nvidia.com (Jon Hunter)
Date: Wed, 30 May 2018 17:08:33 +0100
Subject: [PATCH v2 7/9] PM / Domains: Split genpd_dev_pm_attach()
In-Reply-To: <20180529100421.31022-8-ulf.hansson@linaro.org>
References: <20180529100421.31022-1-ulf.hansson@linaro.org>
 <20180529100421.31022-8-ulf.hansson@linaro.org>
Message-ID: <67a50209-5049-4345-693a-5fd08afd6bb8@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 29/05/18 11:04, Ulf Hansson wrote:
> To extend genpd to deal with allowing multiple PM domains per device, some
> of the code in genpd_dev_pm_attach() can be re-used. Let's prepare for this
> by moving some of the code into a sub-function.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/domain.c | 60 ++++++++++++++++++++-----------------
>  1 file changed, 33 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 12a20f21974d..2af99bfcbe3c 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2221,38 +2221,15 @@ static void genpd_dev_pm_sync(struct device *dev)
>  	genpd_queue_power_off_work(pd);
>  }
>  
> -/**
> - * genpd_dev_pm_attach - Attach a device to its PM domain using DT.
> - * @dev: Device to attach.
> - *
> - * Parse device's OF node to find a PM domain specifier. If such is found,
> - * attaches the device to retrieved pm_domain ops.
> - *
> - * Returns 1 on successfully attached PM domain, 0 when the device don't need a
> - * PM domain or when multiple power-domains exists for it, else a negative error
> - * code. Note that if a power-domain exists for the device, but it cannot be
> - * found or turned on, then return -EPROBE_DEFER to ensure that the device is
> - * not probed and to re-try again later.
> - */
> -int genpd_dev_pm_attach(struct device *dev)
> +static int __genpd_dev_pm_attach(struct device *dev, struct device_node *np,
> +				 unsigned int index)
>  {
>  	struct of_phandle_args pd_args;
>  	struct generic_pm_domain *pd;
>  	int ret;
>  
> -	if (!dev->of_node)
> -		return 0;
> -
> -	/*
> -	 * Devices with multiple PM domains must be attached separately, as we
> -	 * can only attach one PM domain per device.
> -	 */
> -	if (of_count_phandle_with_args(dev->of_node, "power-domains",
> -				       "#power-domain-cells") != 1)
> -		return 0;
> -
> -	ret = of_parse_phandle_with_args(dev->of_node, "power-domains",
> -					"#power-domain-cells", 0, &pd_args);
> +	ret = of_parse_phandle_with_args(np, "power-domains",
> +				"#power-domain-cells", index, &pd_args);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -2290,6 +2267,35 @@ int genpd_dev_pm_attach(struct device *dev)
>  
>  	return ret ? -EPROBE_DEFER : 1;
>  }
> +
> +/**
> + * genpd_dev_pm_attach - Attach a device to its PM domain using DT.
> + * @dev: Device to attach.
> + *
> + * Parse device's OF node to find a PM domain specifier. If such is found,
> + * attaches the device to retrieved pm_domain ops.
> + *
> + * Returns 1 on successfully attached PM domain, 0 when the device don't need a
> + * PM domain or when multiple power-domains exists for it, else a negative error
> + * code. Note that if a power-domain exists for the device, but it cannot be
> + * found or turned on, then return -EPROBE_DEFER to ensure that the device is
> + * not probed and to re-try again later.
> + */
> +int genpd_dev_pm_attach(struct device *dev)
> +{
> +	if (!dev->of_node)
> +		return 0;
> +
> +	/*
> +	 * Devices with multiple PM domains must be attached separately, as we
> +	 * can only attach one PM domain per device.
> +	 */
> +	if (of_count_phandle_with_args(dev->of_node, "power-domains",
> +				       "#power-domain-cells") != 1)
> +		return 0;
> +
> +	return __genpd_dev_pm_attach(dev, dev->of_node, 0);
> +}
>  EXPORT_SYMBOL_GPL(genpd_dev_pm_attach);
>  
>  static const struct of_device_id idle_state_match[] = {

Acked-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
