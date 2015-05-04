From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 04 May 2015 20:46:13 +0200
Subject: [PATCH 1/2] stmac: add dwmac glue for NXP 18xx/43xx family
In-Reply-To: <1430691251-28119-1-git-send-email-manabian@gmail.com>
References: <3200125.o3jqXuyPfG@wuerfel>
 <1430691251-28119-1-git-send-email-manabian@gmail.com>
Message-ID: <90049936.xgdXKqK565@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 04 May 2015 00:14:11 Joachim Eastwood wrote:
=> >It should be fairly straightforward to split the probe function
> >into two and export a function that takes a device and a stmmac_of_data
> >pointer as arguments, and declare a module_platform_driver in your
> >code.
> 
> How about something like the patch below. All it does is to play a
> little trick with the of_match_device in the dt config function and
> export the probe/remove/pm stuff for the driver.
> 
> The dwmac-lpc18xx would then become something like this:
> 
> static const struct stmmac_of_data lpc18xx_dwmac_data = {
> 	.has_gmac = 1,
> 	.setup = lpc18xx_dwmac_setup,
> 	.init = lpc18xx_dwmac_init,
> };
> 
> static const struct of_device_id lpc18xx_dwmac_match[] = {
> 	{ .compatible = "nxp,lpc1850-dwmac", .data = &lpc18xx_dwmac_data },
> 	{ }
> };
> MODULE_DEVICE_TABLE(of, lpc18xx_dwmac_match);
> 
> static struct platform_driver lpc18xx_dwmac_driver = {
> 	.probe  = stmmac_pltfr_probe,
> 	.remove = stmmac_pltfr_remove,
> 	.driver = {
> 		.name           = "lpc18xx-dwmac",
> 		.pm             = &stmmac_pltfr_pm_ops,
> 		.of_match_table = lpc18xx_dwmac_match,
> 	},
> };
> module_platform_driver(lpc18xx_dwmac_driver);
> 
> All though this seem to work, stmmac_platform.c could benefit from
> some refactoring. But this patch and then fixing the other DT users
> could be a first step.

Sounds good, yes.

> -	device = of_match_device(stmmac_dt_ids, &pdev->dev);
> +	device = of_match_device(dev->driver->of_match_table, dev);
>  	if (!device)
>  		return -ENODEV;

Ah, that is a nice trick to avoid passing the various match tables
from a lot of duplicated probe functions.

I wonder if we could generalize that for use by any driver and
introduce a common helper

void *of_platform_match_data(struct device *dev)
{
	struct of_device_id *id;

	if (!dev || !dev->of_node)
		return NULL;

	id = of_match_device(dev->driver->of_match_table, dev);
	if (!id)
		return NULL;

	return id->data;
}
EXPORT_SYMBOL_GPL(of_platform_match_data);

I think that could save a few lines from many drivers, and it had not
occurred to me that we can take this shortcut.

The rest of your patch also looks great to me.

	Arnd
