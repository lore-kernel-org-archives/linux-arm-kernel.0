From: tony@atomide.com (Tony Lindgren)
Date: Thu, 1 Mar 2012 12:15:18 -0800
Subject: linux-next: manual merge of the arm-soc tree with the gpio tree
In-Reply-To: <201203011228.33983.arnd@arndb.de>
References: <20120301164001.77a063ceed2deaf37cf68e3c@canb.auug.org.au>
 <201203011228.33983.arnd@arndb.de>
Message-ID: <20120301201518.GB18901@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [120301 03:57]:
> On Thursday 01 March 2012, Stephen Rothwell wrote:
> > Today's linux-next merge of the arm-soc tree got conflicts in
> > arch/arm/mach-omap1/gpio16xx.c between commit ab985f0f7c2c ("gpio/omap:
> > cleanup omap_gpio_mod_init function") from the gpio tree and commit
> > 63325ff235de ("ARM: OMAP1: Move 16xx GPIO system clock to platform init
> > code") from the arm-soc tree.
> > 
> > OK, I can't decide which is correct here - the former adds this code
> > inside the loop (even though it seems to not depend on anything in the
> > loop) and the latter adds it before.  I have used the former (but am
> > happy to be corrected).  And both commits remove the code in
> > drivers/gpio/gpio-omap.c.
> 
> Right, having the code outside of the loop seems correct to me, too.
> 
> Grant, I would suggest that I resolve this by merging the the
> omap/gpio/runtime-pm-cleanup branch (f86bcc3) that is in your
> tree into the arm-soc tree as a dependency for the omap1 stuff,
> with the resolution below.

For gpio16xx.c the resolution is to use the version from ab985f0f7c2c,
so below looks good to me.

Regards,

Tony


> --- a/arch/arm/mach-omap1/gpio16xx.c
> +++ b/arch/arm/mach-omap1/gpio16xx.c
> @@@ -218,17 -225,34 +225,34 @@@ static int __init omap16xx_gpio_init(vo
>   	if (!cpu_is_omap16xx())
>   		return -EINVAL;
>   
>  +	/*
>  +	 * Enable system clock for GPIO module.
>  +	 * The CAM_CLK_CTRL *is* really the right place.
>  +	 */
>  +	omap_writel(omap_readl(ULPD_CAM_CLK_CTRL) | 0x04,
>  +					ULPD_CAM_CLK_CTRL);
>  +
> - 	for (i = 0; i < ARRAY_SIZE(omap16xx_gpio_dev); i++)
> - 		platform_device_register(omap16xx_gpio_dev[i]);
> + 	for (i = 0; i < ARRAY_SIZE(omap16xx_gpio_dev); i++) {
> + 		pdev = omap16xx_gpio_dev[i];
> + 		pdata = pdev->dev.platform_data;
> + 
> + 		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> + 		if (unlikely(!res)) {
> + 			dev_err(&pdev->dev, "Invalid mem resource.\n");
> + 			return -ENODEV;
> + 		}
>   
> - 	gpio_bank_count = ARRAY_SIZE(omap16xx_gpio_dev);
> + 		base = ioremap(res->start, resource_size(res));
> + 		if (unlikely(!base)) {
> + 			dev_err(&pdev->dev, "ioremap failed.\n");
> + 			return -ENOMEM;
> + 		}
> + 
> + 		__raw_writel(SYSCONFIG_WORD, base + OMAP1610_GPIO_SYSCONFIG);
> + 		iounmap(base);
> + 
>  -		/*
>  -		 * Enable system clock for GPIO module.
>  -		 * The CAM_CLK_CTRL *is* really the right place.
>  -		 */
>  -		omap_writel(omap_readl(ULPD_CAM_CLK_CTRL) | 0x04,
>  -					ULPD_CAM_CLK_CTRL);
>  -
> + 		platform_device_register(omap16xx_gpio_dev[i]);
> + 	}
>   
>   	return 0;
>   }
