From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 May 2012 16:12:53 +0100
Subject: [PATCH 6.2/7] MMC: mmci: Enable Device Tree support for ux500
In-Reply-To: <4FA29E46.6040204@linaro.org>
References: <1334325909-5779-1-git-send-email-lee.jones@linaro.org>
 <1334325909-5779-7-git-send-email-lee.jones@linaro.org>
 <CACRpkdYyP=V=aXtDuo_W4oDxH0UkQKq1x1HKG_z=zWHoWng6JQ@mail.gmail.com>
 <4F8BE5B0.4000900@linaro.org> <20120425185747.GC24211@n2100.arm.linux.org.uk>
 <4FA29E46.6040204@linaro.org>
Message-ID: <20120503151253.GE897@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 03, 2012 at 04:03:34PM +0100, Lee Jones wrote:
> +#ifdef CONFIG_OF
> +static void mmci_dt_populate_generic_pdata(struct device_node *np,
> +					struct mmci_platform_data *pdata)
> +{
> +	int bus_width = 0;
> +
> +	of_property_read_u32(np, "wp-gpios", &pdata->gpio_wp);
> +	if (!pdata->gpio_wp)
> +		pdata->gpio_wp = -1;
> +
> +	of_property_read_u32(np, "cd-gpios", &pdata->gpio_cd);
> +	if (!pdata->gpio_cd)
> +		pdata->gpio_cd = -1;
> +
> +	if (of_get_property(np, "cd-inverted", NULL))
> +		pdata->cd_invert = true;
> +	else
> +		pdata->cd_invert = false;
> +
> +	of_property_read_u32(np, "max-frequency", &pdata->f_max);
> +	if (!pdata->f_max)
> +		pr_warn("%s has no 'max-frequency' property\n", np->full_name);
> +
> +	if (of_get_property(np, "mmc-cap-mmc-highspeed", NULL))
> +		pdata->capabilities |= MMC_CAP_MMC_HIGHSPEED;
> +	if (of_get_property(np, "mmc-cap-sd-highspeed", NULL))
> +		pdata->capabilities |= MMC_CAP_SD_HIGHSPEED;
> +
> +	of_property_read_u32(np, "bus-width", &bus_width);
> +	switch (bus_width) {
> +	case 0 :
> +		/* No bus-width supplied. */
> +		break;
> +	case 4 :
> +		pdata->capabilities |= MMC_CAP_4_BIT_DATA;
> +		break;
> +	case 8 :
> +		pdata->capabilities |= MMC_CAP_8_BIT_DATA;
> +		break;
> +	default :
> +		pr_warn("%s: Unsupported bus width\n", np->full_name);
> +	}
> +}
> +#endif
> +
>  static int __devinit mmci_probe(struct amba_device *dev,
>  	const struct amba_id *id)
>  {
>  	struct mmci_platform_data *plat = dev->dev.platform_data;
> +	struct device_node *np = dev->dev.of_node;
>  	struct variant_data *variant = id->data;
>  	struct mmci_host *host;
>  	struct mmc_host *mmc;
> -	int ret;
> +	int ret, freeplat = 0;
> +
> +	/* Must have platform data or Device Tree. */
> +	if (!plat && !np) {
> +		dev_err(&dev->dev, "No plat data or DT found\n");
> +		return -EINVAL;
> +	}
>  
> -	/* must have platform data */
>  	if (!plat) {
> -		ret = -EINVAL;
> -		goto out;
> +		plat = kzalloc(sizeof(*plat), GFP_KERNEL);

I think this will leak memory - consider what happens if the driver gets
bound and unbound from the same device a number of times.

How about using devm_kzalloc() instead, so that when probe fails or the
driver is unbound, the memory is automatically freed?  No need for that
freeplat variable either...

> +		if (!plat)
> +			return -ENOMEM;
> +		freeplat = 1;
>  	}
>  
> +	if (np)
> +		mmci_dt_populate_generic_pdata(np, plat);
> +
>  	ret = amba_request_regions(dev, DRIVER_NAME);
>  	if (ret)
>  		goto out;
> @@ -1448,6 +1505,9 @@ static int __devinit mmci_probe(struct amba_device *dev,
>   rel_regions:
>  	amba_release_regions(dev);
>   out:
> +	if (freeplat)
> +		kfree(plat);
> +
>  	return ret;
>  }
>  
> -- 
> 1.7.9.5
