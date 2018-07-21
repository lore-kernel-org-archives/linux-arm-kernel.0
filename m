From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Sat, 21 Jul 2018 20:05:06 +0200
Subject: [PATCH v4 25/35] mtd: rawnand: vf610: convert driver to
 nand_scan()
In-Reply-To: <20180720151527.16038-26-miquel.raynal@bootlin.com>
References: <20180720151527.16038-1-miquel.raynal@bootlin.com>
 <20180720151527.16038-26-miquel.raynal@bootlin.com>
Message-ID: <20180721200506.069e948a@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 Jul 2018 17:15:17 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Two helpers have been added to the core to make ECC-related
> configuration between the detection phase and the final NAND scan. Use
> these hooks and convert the driver to just use nand_scan() instead of
> both nand_scan_ident() and nand_scan_tail().
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
>  drivers/mtd/nand/raw/vf610_nfc.c | 127 ++++++++++++++++++++-------------------
>  1 file changed, 66 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/vf610_nfc.c b/drivers/mtd/nand/raw/vf610_nfc.c
> index d5a22fc96878..6f6dcbf9095b 100644
> --- a/drivers/mtd/nand/raw/vf610_nfc.c
> +++ b/drivers/mtd/nand/raw/vf610_nfc.c
> @@ -747,6 +747,69 @@ static void vf610_nfc_init_controller(struct vf610_nfc *nfc)
>  	}
>  }
>  
> +static int vf610_nfc_attach_chip(struct nand_chip *chip)
> +{
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	struct vf610_nfc *nfc = mtd_to_nfc(mtd);
> +
> +	vf610_nfc_init_controller(nfc);
> +
> +	/* Bad block options. */
> +	if (chip->bbt_options & NAND_BBT_USE_FLASH)
> +		chip->bbt_options |= NAND_BBT_NO_OOB;
> +
> +	/* Single buffer only, max 256 OOB minus ECC status */
> +	if (mtd->writesize + mtd->oobsize > PAGE_2K + OOB_MAX - 8) {
> +		dev_err(nfc->dev, "Unsupported flash page size\n");
> +		return -ENXIO;
> +	}
> +
> +	if (chip->ecc.mode != NAND_ECC_HW)
> +		return 0;
> +
> +	if (mtd->writesize != PAGE_2K && mtd->oobsize < 64) {
> +		dev_err(nfc->dev, "Unsupported flash with hwecc\n");
> +		return -ENXIO;
> +	}
> +
> +	if (chip->ecc.size != mtd->writesize) {
> +		dev_err(nfc->dev, "Step size needs to be page size\n");
> +		return -ENXIO;
> +	}
> +
> +	/* Only 64 byte ECC layouts known */
> +	if (mtd->oobsize > 64)
> +		mtd->oobsize = 64;
> +
> +	/* Use default large page ECC layout defined in NAND core */
> +	mtd_set_ooblayout(mtd, &nand_ooblayout_lp_ops);
> +	if (chip->ecc.strength == 32) {
> +		nfc->ecc_mode = ECC_60_BYTE;
> +		chip->ecc.bytes = 60;
> +	} else if (chip->ecc.strength == 24) {
> +		nfc->ecc_mode = ECC_45_BYTE;
> +		chip->ecc.bytes = 45;
> +	} else {
> +		dev_err(nfc->dev, "Unsupported ECC strength\n");
> +		return -ENXIO;
> +	}
> +
> +	chip->ecc.read_page = vf610_nfc_read_page;
> +	chip->ecc.write_page = vf610_nfc_write_page;
> +	chip->ecc.read_page_raw = vf610_nfc_read_page_raw;
> +	chip->ecc.write_page_raw = vf610_nfc_write_page_raw;
> +	chip->ecc.read_oob = vf610_nfc_read_oob;
> +	chip->ecc.write_oob = vf610_nfc_write_oob;
> +
> +	chip->ecc.size = PAGE_2K;
> +
> +	return 0;
> +}
> +
> +static const struct nand_controller_ops vf610_nfc_controller_ops = {
> +	.attach_chip = vf610_nfc_attach_chip,
> +};
> +
>  static int vf610_nfc_probe(struct platform_device *pdev)
>  {
>  	struct vf610_nfc *nfc;
> @@ -827,67 +890,9 @@ static int vf610_nfc_probe(struct platform_device *pdev)
>  
>  	vf610_nfc_preinit_controller(nfc);
>  
> -	/* first scan to find the device and get the page size */
> -	err = nand_scan_ident(mtd, 1, NULL);
> -	if (err)
> -		goto err_disable_clk;
> -
> -	vf610_nfc_init_controller(nfc);
> -
> -	/* Bad block options. */
> -	if (chip->bbt_options & NAND_BBT_USE_FLASH)
> -		chip->bbt_options |= NAND_BBT_NO_OOB;
> -
> -	/* Single buffer only, max 256 OOB minus ECC status */
> -	if (mtd->writesize + mtd->oobsize > PAGE_2K + OOB_MAX - 8) {
> -		dev_err(nfc->dev, "Unsupported flash page size\n");
> -		err = -ENXIO;
> -		goto err_disable_clk;
> -	}
> -
> -	if (chip->ecc.mode == NAND_ECC_HW) {
> -		if (mtd->writesize != PAGE_2K && mtd->oobsize < 64) {
> -			dev_err(nfc->dev, "Unsupported flash with hwecc\n");
> -			err = -ENXIO;
> -			goto err_disable_clk;
> -		}
> -
> -		if (chip->ecc.size != mtd->writesize) {
> -			dev_err(nfc->dev, "Step size needs to be page size\n");
> -			err = -ENXIO;
> -			goto err_disable_clk;
> -		}
> -
> -		/* Only 64 byte ECC layouts known */
> -		if (mtd->oobsize > 64)
> -			mtd->oobsize = 64;
> -
> -		/* Use default large page ECC layout defined in NAND core */
> -		mtd_set_ooblayout(mtd, &nand_ooblayout_lp_ops);
> -		if (chip->ecc.strength == 32) {
> -			nfc->ecc_mode = ECC_60_BYTE;
> -			chip->ecc.bytes = 60;
> -		} else if (chip->ecc.strength == 24) {
> -			nfc->ecc_mode = ECC_45_BYTE;
> -			chip->ecc.bytes = 45;
> -		} else {
> -			dev_err(nfc->dev, "Unsupported ECC strength\n");
> -			err = -ENXIO;
> -			goto err_disable_clk;
> -		}
> -
> -		chip->ecc.read_page = vf610_nfc_read_page;
> -		chip->ecc.write_page = vf610_nfc_write_page;
> -		chip->ecc.read_page_raw = vf610_nfc_read_page_raw;
> -		chip->ecc.write_page_raw = vf610_nfc_write_page_raw;
> -		chip->ecc.read_oob = vf610_nfc_read_oob;
> -		chip->ecc.write_oob = vf610_nfc_write_oob;
> -
> -		chip->ecc.size = PAGE_2K;
> -	}
> -
> -	/* second phase scan */
> -	err = nand_scan_tail(mtd);
> +	/* Scan the NAND chip */
> +	chip->dummy_controller.ops = &vf610_nfc_controller_ops;
> +	err = nand_scan(mtd, 1);
>  	if (err)
>  		goto err_disable_clk;
>  
