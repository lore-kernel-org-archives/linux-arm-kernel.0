From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Sat, 21 Jul 2018 19:50:30 +0200
Subject: [PATCH v4 21/35] mtd: rawnand: sunxi: convert driver to
 nand_scan()
In-Reply-To: <20180720151527.16038-22-miquel.raynal@bootlin.com>
References: <20180720151527.16038-1-miquel.raynal@bootlin.com>
 <20180720151527.16038-22-miquel.raynal@bootlin.com>
Message-ID: <20180721195030.62264dd9@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 Jul 2018 17:15:13 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Two helpers have been added to the core to make ECC-related
> configuration between the detection phase and the final NAND scan. Use
> these hooks and convert the driver to just use nand_scan() instead of
> both nand_scan_ident() and nand_scan_tail().
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
>  drivers/mtd/nand/raw/sunxi_nand.c | 43 +++++++++++++++++----------------------
>  1 file changed, 19 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
> index 07f3ff9a28f2..a4d23381003d 100644
> --- a/drivers/mtd/nand/raw/sunxi_nand.c
> +++ b/drivers/mtd/nand/raw/sunxi_nand.c
> @@ -1816,12 +1816,21 @@ static void sunxi_nand_ecc_cleanup(struct nand_ecc_ctrl *ecc)
>  	}
>  }
>  
> -static int sunxi_nand_ecc_init(struct mtd_info *mtd, struct nand_ecc_ctrl *ecc,
> -			       struct device_node *np)
> +static int sunxi_nand_attach_chip(struct nand_chip *nand)
>  {
> -	struct nand_chip *nand = mtd_to_nand(mtd);
> +	struct mtd_info *mtd = nand_to_mtd(nand);
> +	struct nand_ecc_ctrl *ecc = &nand->ecc;
> +	struct device_node *np = nand_get_flash_node(nand);
>  	int ret;
>  
> +	if (nand->bbt_options & NAND_BBT_USE_FLASH)
> +		nand->bbt_options |= NAND_BBT_NO_OOB;
> +
> +	if (nand->options & NAND_NEED_SCRAMBLING)
> +		nand->options |= NAND_NO_SUBPAGE_WRITE;
> +
> +	nand->options |= NAND_SUBPAGE_READ;
> +
>  	if (!ecc->size) {
>  		ecc->size = nand->ecc_step_ds;
>  		ecc->strength = nand->ecc_strength_ds;
> @@ -1846,6 +1855,10 @@ static int sunxi_nand_ecc_init(struct mtd_info *mtd, struct nand_ecc_ctrl *ecc,
>  	return 0;
>  }
>  
> +static const struct nand_controller_ops sunxi_nand_controller_ops = {
> +	.attach_chip = sunxi_nand_attach_chip,
> +};
> +
>  static int sunxi_nand_chip_init(struct device *dev, struct sunxi_nfc *nfc,
>  				struct device_node *np)
>  {
> @@ -1911,6 +1924,8 @@ static int sunxi_nand_chip_init(struct device *dev, struct sunxi_nfc *nfc,
>  	/* Default tR value specified in the ONFI spec (chapter 4.15.1) */
>  	nand->chip_delay = 200;
>  	nand->controller = &nfc->controller;
> +	nand->controller->ops = &sunxi_nand_controller_ops;
> +
>  	/*
>  	 * Set the ECC mode to the default value in case nothing is specified
>  	 * in the DT.
> @@ -1927,30 +1942,10 @@ static int sunxi_nand_chip_init(struct device *dev, struct sunxi_nfc *nfc,
>  	mtd = nand_to_mtd(nand);
>  	mtd->dev.parent = dev;
>  
> -	ret = nand_scan_ident(mtd, nsels, NULL);
> +	ret = nand_scan(mtd, nsels);
>  	if (ret)
>  		return ret;
>  
> -	if (nand->bbt_options & NAND_BBT_USE_FLASH)
> -		nand->bbt_options |= NAND_BBT_NO_OOB;
> -
> -	if (nand->options & NAND_NEED_SCRAMBLING)
> -		nand->options |= NAND_NO_SUBPAGE_WRITE;
> -
> -	nand->options |= NAND_SUBPAGE_READ;
> -
> -	ret = sunxi_nand_ecc_init(mtd, &nand->ecc, np);
> -	if (ret) {
> -		dev_err(dev, "ECC init failed: %d\n", ret);
> -		return ret;
> -	}
> -
> -	ret = nand_scan_tail(mtd);
> -	if (ret) {
> -		dev_err(dev, "nand_scan_tail failed: %d\n", ret);
> -		return ret;
> -	}
> -
>  	ret = mtd_device_register(mtd, NULL, 0);
>  	if (ret) {
>  		dev_err(dev, "failed to register mtd device: %d\n", ret);
