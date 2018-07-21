From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Sat, 21 Jul 2018 08:50:25 +0200
Subject: [PATCH v4 05/35] mtd: rawnand: fsl_elbc: convert driver to
 nand_scan()
In-Reply-To: <20180720151527.16038-6-miquel.raynal@bootlin.com>
References: <20180720151527.16038-1-miquel.raynal@bootlin.com>
 <20180720151527.16038-6-miquel.raynal@bootlin.com>
Message-ID: <20180721085025.27439bcb@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 Jul 2018 17:14:57 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Two helpers have been added to the core to make ECC-related
> configuration between the detection phase and the final NAND scan. Use
> these hooks and convert the driver to just use nand_scan() instead of
> both nand_scan_ident() and nand_scan_tail().
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/mtd/nand/raw/fsl_elbc_nand.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/fsl_elbc_nand.c b/drivers/mtd/nand/raw/fsl_elbc_nand.c
> index 0aa54a949653..44893e49b386 100644
> --- a/drivers/mtd/nand/raw/fsl_elbc_nand.c
> +++ b/drivers/mtd/nand/raw/fsl_elbc_nand.c
> @@ -637,9 +637,9 @@ static int fsl_elbc_wait(struct mtd_info *mtd, struct nand_chip *chip)
>  	return (elbc_fcm_ctrl->mdr & 0xff) | NAND_STATUS_WP;
>  }
>  
> -static int fsl_elbc_chip_init_tail(struct mtd_info *mtd)
> +static int fsl_elbc_attach_chip(struct nand_chip *chip)
>  {
> -	struct nand_chip *chip = mtd_to_nand(mtd);
> +	struct mtd_info *mtd = nand_to_mtd(chip);
>  	struct fsl_elbc_mtd *priv = nand_get_controller_data(chip);
>  	struct fsl_lbc_ctrl *ctrl = priv->ctrl;
>  	struct fsl_lbc_regs __iomem *lbc = ctrl->regs;
> @@ -706,6 +706,10 @@ static int fsl_elbc_chip_init_tail(struct mtd_info *mtd)

Looks like fsl_elbc_chip_init_tail() was returning -1 here [1]. Please
change that for a -ENOTSUPP. With that fixed:

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

>  	return 0;
>  }
>  
> +static const struct nand_controller_ops fsl_elbc_controller_ops = {
> +	.attach_chip = fsl_elbc_attach_chip,
> +};
> +
>  static int fsl_elbc_read_page(struct mtd_info *mtd, struct nand_chip *chip,
>  			      uint8_t *buf, int oob_required, int page)
>  {
> @@ -910,15 +914,8 @@ static int fsl_elbc_nand_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err;
>  
> -	ret = nand_scan_ident(mtd, 1, NULL);
> -	if (ret)
> -		goto err;
> -
> -	ret = fsl_elbc_chip_init_tail(mtd);
> -	if (ret)
> -		goto err;
> -
> -	ret = nand_scan_tail(mtd);
> +	priv->chip.controller->ops = &fsl_elbc_controller_ops;
> +	ret = nand_scan(mtd, 1);
>  	if (ret)
>  		goto err;
>  

[1]https://elixir.bootlin.com/linux/v4.18-rc5/source/drivers/mtd/nand/raw/fsl_elbc_nand.c#L699
