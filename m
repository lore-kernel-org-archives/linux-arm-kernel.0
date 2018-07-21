From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Sat, 21 Jul 2018 08:23:32 +0200
Subject: [PATCH v4 01/35] mtd: rawnand: brcmnand: convert driver to
 nand_scan()
In-Reply-To: <20180720151527.16038-2-miquel.raynal@bootlin.com>
References: <20180720151527.16038-1-miquel.raynal@bootlin.com>
 <20180720151527.16038-2-miquel.raynal@bootlin.com>
Message-ID: <20180721082332.4c098adb@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 Jul 2018 17:14:53 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Two helpers have been added to the core to make ECC-related
> configuration between the detection phase and the final NAND scan. Use
> these hooks and convert the driver to just use nand_scan() instead of
> both nand_scan_ident() and nand_scan_tail().
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c | 47 +++++++++++++++++++-------------
>  1 file changed, 28 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> index 2e5efa0f9ea2..071f09af56dc 100644
> --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> @@ -2208,6 +2208,32 @@ static int brcmnand_setup_dev(struct brcmnand_host *host)
>  	return 0;
>  }
>  
> +static int brcmnand_attach_chip(struct nand_chip *chip)
> +{
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	struct brcmnand_host *host = nand_get_controller_data(chip);
> +	int ret;
> +
> +	if (chip->bbt_options & NAND_BBT_USE_FLASH)
> +		chip->bbt_options |= NAND_BBT_NO_OOB;
> +
> +	if (brcmnand_setup_dev(host))
> +		return -ENXIO;
> +
> +	chip->ecc.size = host->hwcfg.sector_size_1k ? 1024 : 512;
> +
> +	/* only use our internal HW threshold */
> +	mtd->bitflip_threshold = 1;
> +
> +	ret = brcmstb_choose_ecc_layout(host);
> +
> +	return ret;
> +}
> +
> +static const struct nand_controller_ops brcmnand_controller_ops = {
> +	.attach_chip = brcmnand_attach_chip,
> +};
> +
>  static int brcmnand_init_cs(struct brcmnand_host *host, struct device_node *dn)
>  {
>  	struct brcmnand_controller *ctrl = host->ctrl;
> @@ -2267,10 +2293,6 @@ static int brcmnand_init_cs(struct brcmnand_host *host, struct device_node *dn)
>  	nand_writereg(ctrl, cfg_offs,
>  		      nand_readreg(ctrl, cfg_offs) & ~CFG_BUS_WIDTH);
>  
> -	ret = nand_scan_ident(mtd, 1, NULL);
> -	if (ret)
> -		return ret;
> -
>  	chip->options |= NAND_NO_SUBPAGE_WRITE;
>  	/*
>  	 * Avoid (for instance) kmap()'d buffers from JFFS2, which we can't DMA
> @@ -2279,21 +2301,7 @@ static int brcmnand_init_cs(struct brcmnand_host *host, struct device_node *dn)
>  	 */
>  	chip->options |= NAND_USE_BOUNCE_BUFFER;
>  

Any reason for not moving the above chunk in brcmnand_attach_chip()?

Since ->attach_chip() is called between nand_scan_ident() and
nand_scan_tail() in nand_scan(), I'd recommend simply copying all the
code found between those 2 calls (applies to all drivers).

> -	if (chip->bbt_options & NAND_BBT_USE_FLASH)
> -		chip->bbt_options |= NAND_BBT_NO_OOB;
> -
> -	if (brcmnand_setup_dev(host))
> -		return -ENXIO;
> -
> -	chip->ecc.size = host->hwcfg.sector_size_1k ? 1024 : 512;
> -	/* only use our internal HW threshold */
> -	mtd->bitflip_threshold = 1;
> -
> -	ret = brcmstb_choose_ecc_layout(host);
> -	if (ret)
> -		return ret;
> -
> -	ret = nand_scan_tail(mtd);
> +	ret = nand_scan(mtd, 1);
>  	if (ret)
>  		return ret;
>  
> @@ -2434,6 +2442,7 @@ int brcmnand_probe(struct platform_device *pdev, struct brcmnand_soc *soc)
>  	init_completion(&ctrl->done);
>  	init_completion(&ctrl->dma_done);
>  	nand_controller_init(&ctrl->controller);
> +	ctrl->controller.ops = &brcmnand_controller_ops;
>  	INIT_LIST_HEAD(&ctrl->host_list);
>  
>  	/* NAND register range */
