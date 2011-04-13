From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 13 Apr 2011 11:33:42 -0600
Subject: [PATCH] ARM: add DT support to the S3C SDI driver
In-Reply-To: <20110413172547.GA27819@dandreoli.com>
References: <20110413172547.GA27819@dandreoli.com>
Message-ID: <20110413173342.GE2254@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 13, 2011 at 07:25:47PM +0200, Domenico Andreoli wrote:
> From: Domenico Andreoli <cavokz@gmail.com>
> 
> This patch adds DeviceTree support to the S3C SDI driver.
> 
> It implements all the configurations of the platform driver except the
> set_power() callback and the ocr_avail mask.
> 
> Signed-off-by: Domenico Andreoli <cavokz@gmail.com>
> 
> ---
> 
> ocr_avail is a bit mask that could be easily ported to DT. If there
> is not any better (or readable) way to render it in DT, I will
> straightforwardly implement it.
> 
> set_power() instead deserves some more considerations. Current
> implementations boil down to gpio on/off settings, its DT implementation
> is again straightforward. Problem would arise if any board requires
> some naive implementation, would it require a different of_device_id
> with proper .data set?
> 
> cheers,
> Domenico

Looks pretty good do me.  One minor comment below, but I think I can
pick this one up into the devicetree/test branch.

g.

> 
> ---
>  drivers/mmc/host/s3cmci.c |   83 +++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 78 insertions(+), 5 deletions(-)
> 
> Index: b/drivers/mmc/host/s3cmci.c
> ===================================================================
> --- a/drivers/mmc/host/s3cmci.c
> +++ b/drivers/mmc/host/s3cmci.c
> @@ -14,6 +14,7 @@
>  #include <linux/module.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/clk.h>
> +#include <linux/slab.h>
>  #include <linux/mmc/host.h>
>  #include <linux/platform_device.h>
>  #include <linux/cpufreq.h>
> @@ -22,6 +23,8 @@
>  #include <linux/gpio.h>
>  #include <linux/irq.h>
>  #include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_gpio.h>
>  
>  #include <mach/dma.h>
>  
> @@ -1544,6 +1547,58 @@
>  
>  #endif /* CONFIG_DEBUG_FS */
>  
> +#ifdef CONFIG_OF
> +
> +enum of_s3cmci_flags {
> +	OF_S3CMCI_USE_DMA = 1,
> +};
> +
> +static struct s3c24xx_mci_pdata *s3cmci_of_init(struct device *dev)
> +{
> +	struct s3c24xx_mci_pdata *pdata;
> +	const __be32 *spec;
> +	enum of_gpio_flags gpio_flags;
> +	int gpio;
> +	u32 flags;
> +
> +	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
> +	if(!pdata) {
> +		dev_err(dev, "%s: failed to allocate pdata\n", dev->of_node->full_name);
> +		return NULL;
> +	}
> +
> +	gpio = of_get_gpio_flags(dev->of_node, 0, &gpio_flags);
> +	if (gpio < 0) {
> +		pdata->no_detect = 1;
> +	} else {
> +		pdata->gpio_detect = gpio;
> +		pdata->detect_invert = (gpio_flags & OF_GPIO_ACTIVE_LOW) == OF_GPIO_ACTIVE_LOW;
> +	}
> +
> +	gpio = of_get_gpio_flags(dev->of_node, 1, &gpio_flags);
> +	if (gpio < 0) {
> +		pdata->no_wprotect = 1;
> +	} else {
> +		pdata->gpio_wprotect = gpio;
> +		pdata->wprotect_invert = (gpio_flags & OF_GPIO_ACTIVE_LOW) == OF_GPIO_ACTIVE_LOW;
> +	}
> +
> +	spec = of_get_property(dev->of_node, "flags", 0);
> +	flags = spec ? be32_to_cpup(spec) : 0;
> +	pdata->use_dma = flags | OF_S3CMCI_USE_DMA;
> +
> +	return pdata;
> +}
> +
> +#else
> +
> +static struct s3c24xx_mci_pdata *s3cmci_of_init(struct device *dev)
> +{
> +	return NULL;
> +}
> +
> +#endif /* CONFIG_OF */
> +
>  static int __devinit s3cmci_probe(struct platform_device *pdev)
>  {
>  	struct s3cmci_host *host;
> @@ -1552,7 +1607,12 @@
>  	int is2440;
>  	int i;
>  
> -	is2440 = platform_get_device_id(pdev)->driver_data;
> +	if (platform_get_device_id(pdev))
> +		is2440 = platform_get_device_id(pdev)->driver_data;
> +	else if (pdev->dev.of_match)
> +		is2440 = (int) pdev->dev.of_match->data;
> +	else
> +		BUG();
>  
>  	mmc = mmc_alloc_host(sizeof(struct s3cmci_host), &pdev->dev);
>  	if (!mmc) {
> @@ -1577,11 +1637,11 @@
>  	host->pdev	= pdev;
>  	host->is2440	= is2440;
>  
> -	host->pdata = pdev->dev.platform_data;
> -	if (!host->pdata) {
> +	if (!pdev->dev.platform_data && pdev->dev.of_node)
> +		pdev->dev.platform_data = s3cmci_of_init(&pdev->dev);
> +	if (!pdev->dev.platform_data)
>  		pdev->dev.platform_data = &s3cmci_def_pdata;
> -		host->pdata = &s3cmci_def_pdata;
> -	}
> +	host->pdata = pdev->dev.platform_data;
>  
>  	spin_lock_init(&host->complete_lock);
>  	tasklet_init(&host->pio_tasklet, pio_tasklet, (unsigned long) host);
> @@ -1901,12 +1961,25 @@
>  #define s3cmci_pm_ops NULL
>  #endif /* CONFIG_PM */
>  
> +#ifdef CONFIG_OF
> +
> +static const struct of_device_id s3cmci_of_match[] = {
> +	{ .compatible = "samsung,s3c2410-sdi", .data = (void *) 0, },
> +	{ .compatible = "samsung,s3c2412-sdi", .data = (void *) 1, },
> +	{ .compatible = "samsung,s3c2440-sdi", .data = (void *) 1, },

A little ugly.  I'd rather see a real structure being passed, even if
it is almost empty.  However, I see that the existing driver is
already using this pattern, so I won't make a big deal about it.

> +	{},
> +};
> +
> +#else /* CONFIG_OF */
> +#define s3cmci_of_match  NULL
> +#endif /* CONFIG_OF */
>  
>  static struct platform_driver s3cmci_driver = {
>  	.driver	= {
>  		.name	= "s3c-sdi",
>  		.owner	= THIS_MODULE,
>  		.pm	= s3cmci_pm_ops,
> +		.of_match_table = s3cmci_of_match,
>  	},
>  	.id_table	= s3cmci_driver_ids,
>  	.probe		= s3cmci_probe,
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
