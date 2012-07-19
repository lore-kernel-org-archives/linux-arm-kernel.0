From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Jul 2012 08:15:40 +0000
Subject: [RFC PATCHv5] arm: socfpga: Add initial support for Altera's
 SOCFPGA HW
In-Reply-To: <1342649238-1044-1-git-send-email-dinguyen@altera.com>
References: <1342649238-1044-1-git-send-email-dinguyen@altera.com>
Message-ID: <201207190815.40871.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 July 2012, dinguyen at altera.com wrote:
> @@ -49,7 +49,9 @@ static int __devinit stmmac_probe_config_dt(struct platform_device *pdev,
>          * are provided. All other properties should be added
>          * once needed on other platforms.
>          */
> -       if (of_device_is_compatible(np, "st,spear600-gmac")) {
> +       if (of_device_is_compatible(np, "st,spear600-gmac") ||
> +               of_device_is_compatible(np, "snps,dwmac-3.70a") ||
> +               of_device_is_compatible(np, "snps,dwmac")) {
>                 plat->has_gmac = 1;
>                 plat->pmt = 1;
>         }

My guess from looking at the driver is that the "pmt" flag is not
set on all versions, but is on 3.50 or higher, so I would make it

       if (of_device_is_compatible(np, "st,spear600-gmac") ||
           of_device_is_compatible(np, "snps,dwmac-3.70a"))
		plat->pmt = 1;

I'm also guessing that the availability of the gmac is not a property
of the dwmac version but of the way the dwmac macro is used, so that
should probably be instead

       if (of_device_is_compatible(np, "st,spear600-gmac") ||
           of_device_is_compatible(np, "altr,socfpga-stmmac"))
		plat->has_gmac = 1;

For a device that just claims compatibility with "snps,dwmac" but
no specific version, it probably makes more sense to assume that
those features are not available.

Rather than checking the version here, we can also add an empty property
"snps,gmac" or similar to show the presence of the gmac in the device
tree.

The other alternative that I've brought up with Deepak and Vipul from ST
is to add a template for each version of the dwmac so you don't have
to check the specific compatible string separately for each property.

> @@ -250,7 +252,9 @@ static const struct dev_pm_ops stmmac_pltfr_pm_ops;
>  #endif /* CONFIG_PM */
>  
>  static const struct of_device_id stmmac_dt_ids[] = {
> -       { .compatible = "st,spear600-gmac", },
> +       { .compatible = "st,spear600-gmac"},
> +       { .compatible = "snps,dwmac-3.70a"},
> +       { .compatible = "snps,dwmac"},
>         { /* sentinel */ }
>  };

Yes, this looks good.

	Arnd
