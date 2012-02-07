From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 07 Feb 2012 11:30:35 +0100
Subject: [PATCH 5/6 V2] atmel/nand: add DT support
In-Reply-To: <1328524512-18159-2-git-send-email-plagnioj@jcrosoft.com>
References: <1327727444-23908-1-git-send-email-plagnioj@jcrosoft.com>
 <1328524512-18159-2-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <4F30FD4B.4050501@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/06/2012 11:35 AM, Jean-Christophe PLAGNIOL-VILLARD :
> use a local copy of board informatin and fill with DT data
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: devicetree-discuss at lists.ozlabs.org
> Cc: linux-mtd at lists.infradead.org

[..]

> +static int __devinit atmel_of_init_port(struct atmel_nand_host *host,
> +					 struct device_node *np)

Maybe you will need to protect this function in case of !DT builds: I
suspect that some of the of_xxxxx() calls are not provided if !CONFIG_OF.

> +{
> +	u32 val;
> +	int ecc_mode;
> +	struct atmel_nand_data *board = &host->board;
> +	enum of_gpio_flags flags;
> +
> +	if (of_property_read_u32(np, "atmel,nand-addr-offset", &val) == 0) {
> +		if (val >= 32) {
> +			dev_err(host->dev, "invalid addr-offset %u\n", val);
> +			return -EINVAL;
> +		}
> +		board->ale = val;
> +	}
> +
> +	if (of_property_read_u32(np, "atmel,nand-cmd-offset", &val) == 0) {
> +		if (val >= 32) {
> +			dev_err(host->dev, "invalid cmd-offset %u\n", val);
> +			return -EINVAL;
> +		}
> +		board->cle = val;
> +	}
> +
> +	ecc_mode = of_get_nand_ecc_mode(np);
> +
> +	board->ecc_mode = ecc_mode < 0 ? NAND_ECC_SOFT : ecc_mode;
> +
> +	board->on_flash_bbt = of_get_nand_on_flash_bbt(np);
> +
> +	if (of_get_nand_bus_width(np) == 16)
> +		board->bus_width_16 = 1;
> +
> +	board->rdy_pin = of_get_gpio_flags(np, 0, &flags);
> +	board->rdy_pin_active_low = (flags == OF_GPIO_ACTIVE_LOW);
> +
> +	board->enable_pin = of_get_gpio(np, 1);
> +	board->det_pin = of_get_gpio(np, 2);
> +
> +	return 0;
> +}
> +
>  /*
>   * Probe for the NAND device.
>   */
> @@ -479,6 +525,7 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
>  	struct nand_chip *nand_chip;
>  	struct resource *regs;
>  	struct resource *mem;
> +	struct mtd_part_parser_data ppdata = {};
>  	int res;
>  
>  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> @@ -505,8 +552,15 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
>  
>  	mtd = &host->mtd;
>  	nand_chip = &host->nand_chip;
> -	host->board = pdev->dev.platform_data;
>  	host->dev = &pdev->dev;
> +	if (pdev->dev.of_node) {
> +		res = atmel_of_init_port(host, pdev->dev.of_node);

Called here: must compile with !CONFIG_OF

> +		if (res)
> +			goto err_nand_ioremap;
> +	} else {
> +		memcpy(&host->board, pdev->dev.platform_data,
> +		       sizeof(struct atmel_nand_data));
> +	}
>  
>  	nand_chip->priv = host;		/* link the private data structures */
>  	mtd->priv = nand_chip;

Best regards,
-- 
Nicolas Ferre
