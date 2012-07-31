From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 31 Jul 2012 18:23:54 +0000
Subject: [PATCH v2 3/6] mv643xx.c: Add basic device tree support.
In-Reply-To: <1343749529-17571-4-git-send-email-ian.molton@codethink.co.uk>
References: <1343749529-17571-1-git-send-email-ian.molton@codethink.co.uk>
 <1343749529-17571-4-git-send-email-ian.molton@codethink.co.uk>
Message-ID: <201207311823.54857.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 31 July 2012, Ian Molton wrote:
> @@ -33,6 +34,10 @@ struct of_dev_auxdata kirkwood_auxdata_lookup[] __initdata = {
>  	OF_DEV_AUXDATA("marvell,orion-wdt", 0xf1020300, "orion_wdt", NULL),
>  	OF_DEV_AUXDATA("marvell,orion-sata", 0xf1080000, "sata_mv.0", NULL),
>  	OF_DEV_AUXDATA("marvell,orion-nand", 0xf4000000, "orion_nand", NULL),
> +	OF_DEV_AUXDATA("marvell,mv643xx", 0xf1072000, MV643XX_ETH_NAME ".0",
> +			NULL),
> +	OF_DEV_AUXDATA("marvell,mv643xx", 0xf1076000, MV643XX_ETH_NAME ".1",
> +			NULL),
>  	{},
>  };

Please don't do string concatenation like this, it just makes it harder to grep for the
strings.

> @@ -2654,15 +2677,22 @@ static int mv643xx_eth_shared_probe(struct platform_device *pdev)
>  	/*
>  	 * Check whether the error interrupt is hooked up.
>  	 */
> -	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> -	if (res != NULL) {
> +	if (pdev->dev.of_node) {
> +		irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
> +	} else {
> +		res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> +		if (res)
> +			irq = res->start;
> +	}
> +

Why is this necessary? In theory, the old code should be the same as the new one,
unless something goes wrong in the domain registration.

	Arnd
