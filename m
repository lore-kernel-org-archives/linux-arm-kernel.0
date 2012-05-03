From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 May 2012 17:30:08 +0100
Subject: [PATCH 6.2/7] MMC: mmci: Enable Device Tree support for ux500
In-Reply-To: <4FA2A4A8.9010208@linaro.org>
References: <1334325909-5779-1-git-send-email-lee.jones@linaro.org>
 <1334325909-5779-7-git-send-email-lee.jones@linaro.org>
 <CACRpkdYyP=V=aXtDuo_W4oDxH0UkQKq1x1HKG_z=zWHoWng6JQ@mail.gmail.com>
 <4F8BE5B0.4000900@linaro.org> <20120425185747.GC24211@n2100.arm.linux.org.uk>
 <4FA29E46.6040204@linaro.org> <20120503151253.GE897@n2100.arm.linux.org.uk>
 <4FA2A4A8.9010208@linaro.org>
Message-ID: <20120503163008.GF897@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 03, 2012 at 04:30:48PM +0100, Lee Jones wrote:
> From: Lee Jones <lee.jones@linaro.org>
> Date: Mon, 16 Apr 2012 10:18:43 +0100
> Subject: [PATCH 01/19] MMC: mmci: Enable Device Tree support for ux500
>  variants
> 
> Provide a means to collect attributes specific to ST-Ericsson's
> ux500 variant series. This patch registers itself as the AMBA
> driver to be called during the probe process. Once all
> attributes and ux500 specifics are are collected the normal
> mmci core probe is called.
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

This looks fine now, thanks.

> ---
>  drivers/mmc/host/mmci.c |   62 ++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 59 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 032b847..c2bd5ea 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -15,6 +15,7 @@
>  #include <linux/device.h>
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
> +#include <linux/slab.h>
>  #include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/highmem.h>
> @@ -1196,21 +1197,76 @@ static const struct mmc_host_ops mmci_ops = {
>  	.get_cd		= mmci_get_cd,
>  };
>  
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
>  	int ret;
>  
> -	/* must have platform data */
> +	/* Must have platform data or Device Tree. */
> +	if (!plat && !np) {
> +		dev_err(&dev->dev, "No plat data or DT found\n");
> +		return -EINVAL;
> +	}
> +
>  	if (!plat) {
> -		ret = -EINVAL;
> -		goto out;
> +		plat = devm_kzalloc(&dev->dev, sizeof(*plat), GFP_KERNEL);
> +		if (!plat)
> +			return -ENOMEM;
>  	}
>  
> +	if (np)
> +		mmci_dt_populate_generic_pdata(np, plat);
> +
>  	ret = amba_request_regions(dev, DRIVER_NAME);
>  	if (ret)
>  		goto out;
> -- 
> 1.7.9.5
