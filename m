From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 11 Mar 2012 17:52:32 +0000
Subject: [PATCH 2/2] ARM: kirkwood: Convert orion-nand to fdt
In-Reply-To: <1331476406-9844-3-git-send-email-jm@lentin.co.uk>
References: <1331476406-9844-1-git-send-email-jm@lentin.co.uk>
 <1331476406-9844-3-git-send-email-jm@lentin.co.uk>
Message-ID: <201203111752.32497.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 11 March 2012, Jamie Lentin wrote:
> The DNS-320 and 325 have a NAND partitioned to store uboot, uimage and root
> filesystem. Store this information in devicetree.

All the important parts  look good to me, just two small details:

> -	board = pdev->dev.platform_data;
> +	if (pdev->dev.of_node) {
> +		board = kzalloc(sizeof(struct orion_nand_data), GFP_KERNEL);
> +		if (!board) {
> +			printk(KERN_ERR "orion_nand: failed to allocate board structure.\n");
> +			ret = -ENOMEM;
> +			goto no_res;
> +		}
> +		if (!of_property_read_u32(pdev->dev.of_node, "cle", &val))
> +			board->cle = (u8)val;
> +		if (!of_property_read_u32(pdev->dev.of_node, "ale", &val))
> +			board->ale = (u8)val;
> +		if (!of_property_read_u32(pdev->dev.of_node, "width", &val))
> +			board->width = (u8)val;
> +		if (!of_property_read_u32(pdev->dev.of_node,
> +						"chip-delay", &val))
> +			board->chip_delay = (u8)val;
> +	} else
> +		board = pdev->dev.platform_data;

If you use devm_kzalloc, the memory will get freed automatically during cleanup.
  
> +#ifdef CONFIG_OF
> +static struct of_device_id orion_nand_of_match_table[] = {
> +	{ .compatible = "mrvl,orion-nand", },
> +	{},
> +};
> +#else
> +#define orion_nand_of_match_table NULL
> +#endif
> +
>  static struct platform_driver orion_nand_driver = {
>  	.remove		= __devexit_p(orion_nand_remove),
>  	.driver		= {
>  		.name	= "orion_nand",
>  		.owner	= THIS_MODULE,
> +		.of_match_table = of_match_ptr(orion_nand_of_match_table),
>  	},
>  };

When you use of_match_ptr(), you can leave out the "#else\n#define orion_nand_of_match_table NULL".

	Arnd
