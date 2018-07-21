From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Sat, 21 Jul 2018 17:26:35 +0200
Subject: [PATCH v4 11/35] mtd: rawnand: lpc32xx_mlc: convert driver to
 nand_scan()
In-Reply-To: <20180720151527.16038-12-miquel.raynal@bootlin.com>
References: <20180720151527.16038-1-miquel.raynal@bootlin.com>
 <20180720151527.16038-12-miquel.raynal@bootlin.com>
Message-ID: <20180721172635.716e68f4@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 Jul 2018 17:15:03 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Two helpers have been added to the core to make ECC-related
> configuration between the detection phase and the final NAND scan. Use
> these hooks and convert the driver to just use nand_scan() instead of
> both nand_scan_ident() and nand_scan_tail().
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/mtd/nand/raw/lpc32xx_mlc.c | 109 ++++++++++++++++++++-----------------
>  1 file changed, 59 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/lpc32xx_mlc.c b/drivers/mtd/nand/raw/lpc32xx_mlc.c
> index 052d123a8304..6f73136fa863 100644
> --- a/drivers/mtd/nand/raw/lpc32xx_mlc.c
> +++ b/drivers/mtd/nand/raw/lpc32xx_mlc.c
> @@ -184,6 +184,7 @@ static struct nand_bbt_descr lpc32xx_nand_bbt_mirror = {
>  };
>  
>  struct lpc32xx_nand_host {
> +	struct platform_device	*pdev;
>  	struct nand_chip	nand_chip;
>  	struct lpc32xx_mlc_platform_data *pdata;
>  	struct clk		*clk;
> @@ -653,6 +654,58 @@ static struct lpc32xx_nand_cfg_mlc *lpc32xx_parse_dt(struct device *dev)
>  	return ncfg;
>  }
>  
> +static int lpc32xx_nand_attach_chip(struct nand_chip *chip)
> +{
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	struct lpc32xx_nand_host *host = nand_get_controller_data(chip);
> +	struct device *dev = &host->pdev->dev;
> +
> +	host->dma_buf = devm_kzalloc(dev, mtd->writesize, GFP_KERNEL);
> +	if (!host->dma_buf)
> +		return -ENOMEM;
> +
> +	host->dummy_buf = devm_kzalloc(dev, mtd->writesize, GFP_KERNEL);
> +	if (!host->dummy_buf)
> +		return -ENOMEM;
> +
> +	chip->ecc.mode = NAND_ECC_HW;
> +	chip->ecc.size = 512;
> +	mtd_set_ooblayout(mtd, &lpc32xx_ooblayout_ops);
> +	host->mlcsubpages = mtd->writesize / 512;
> +
> +	/* initially clear interrupt status */
> +	readb(MLC_IRQ_SR(host->io_base));
> +
> +	init_completion(&host->comp_nand);
> +	init_completion(&host->comp_controller);
> +
> +	host->irq = platform_get_irq(host->pdev, 0);
> +	if (host->irq < 0) {
> +		dev_err(dev, "failed to get platform irq\n");
> +		return -EINVAL;
> +	}
> +
> +	if (request_irq(host->irq, (irq_handler_t)&lpc3xxx_nand_irq,
> +			IRQF_TRIGGER_HIGH, DRV_NAME, host)) {
> +		dev_err(dev, "Error requesting NAND IRQ\n");
> +		return -ENXIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static void lpc32xx_nand_detach_chip(struct nand_chip *chip)
> +{
> +	struct lpc32xx_nand_host *host = nand_get_controller_data(chip);
> +
> +	free_irq(host->irq, host);

Now you call 2 times free_irq() in the ->remove() path.

> +}
> +
> +static const struct nand_controller_ops lpc32xx_nand_controller_ops = {
> +	.attach_chip = lpc32xx_nand_attach_chip,
> +	.detach_chip = lpc32xx_nand_detach_chip,
> +};
> +
>  /*
>   * Probe for NAND controller
>   */
> @@ -669,6 +722,8 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
>  	if (!host)
>  		return -ENOMEM;
>  
> +	host->pdev = pdev;
> +
>  	rc = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	host->io_base = devm_ioremap_resource(&pdev->dev, rc);
>  	if (IS_ERR(host->io_base))
> @@ -749,58 +804,14 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
>  	}
>  
>  	/*
> -	 * Scan to find existance of the device and
> -	 * Get the type of NAND device SMALL block or LARGE block
> +	 * Scan to find existence of the device and get the type of NAND device:
> +	 * SMALL block or LARGE block.
>  	 */
> -	res = nand_scan_ident(mtd, 1, NULL);
> +	nand_chip->dummy_controller.ops = &lpc32xx_nand_controller_ops;
> +	res = nand_scan(mtd, 1);
>  	if (res)
>  		goto release_dma_chan;
>  
> -	host->dma_buf = devm_kzalloc(&pdev->dev, mtd->writesize, GFP_KERNEL);
> -	if (!host->dma_buf) {
> -		res = -ENOMEM;
> -		goto release_dma_chan;
> -	}
> -
> -	host->dummy_buf = devm_kzalloc(&pdev->dev, mtd->writesize, GFP_KERNEL);
> -	if (!host->dummy_buf) {
> -		res = -ENOMEM;
> -		goto release_dma_chan;
> -	}
> -
> -	nand_chip->ecc.mode = NAND_ECC_HW;
> -	nand_chip->ecc.size = 512;
> -	mtd_set_ooblayout(mtd, &lpc32xx_ooblayout_ops);
> -	host->mlcsubpages = mtd->writesize / 512;
> -

Starting here...

> -	/* initially clear interrupt status */
> -	readb(MLC_IRQ_SR(host->io_base));
> -
> -	init_completion(&host->comp_nand);
> -	init_completion(&host->comp_controller);
> -
> -	host->irq = platform_get_irq(pdev, 0);
> -	if (host->irq < 0) {
> -		dev_err(&pdev->dev, "failed to get platform irq\n");
> -		res = -EINVAL;
> -		goto release_dma_chan;
> -	}
> -
> -	if (request_irq(host->irq, (irq_handler_t)&lpc3xxx_nand_irq,
> -			IRQF_TRIGGER_HIGH, DRV_NAME, host)) {
> -		dev_err(&pdev->dev, "Error requesting NAND IRQ\n");
> -		res = -ENXIO;
> -		goto release_dma_chan;
> -	}

till there: maybe we should just move this block before nand_scan().
Registering an IRQ handler is not really something you should do in
->attach_chip() IMO.

> -
> -	/*
> -	 * Fills out all the uninitialized function pointers with the defaults
> -	 * And scans for a bad block table if appropriate.
> -	 */
> -	res = nand_scan_tail(mtd);
> -	if (res)
> -		goto free_irq;
> -
>  	mtd->name = DRV_NAME;
>  
>  	res = mtd_device_register(mtd, host->ncfg->parts,
> @@ -812,8 +823,6 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
>  
>  cleanup_nand:
>  	nand_cleanup(nand_chip);
> -free_irq:
> -	free_irq(host->irq, host);
>  release_dma_chan:
>  	if (use_dma)
>  		dma_release_channel(host->dma_chan);
