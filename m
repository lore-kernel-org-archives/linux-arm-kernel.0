From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Sat, 21 Jul 2018 19:54:38 +0200
Subject: [PATCH v4 24/35] mtd: rawnand: txx9ndfmc: convert driver to
 nand_scan()
In-Reply-To: <20180720151527.16038-25-miquel.raynal@bootlin.com>
References: <20180720151527.16038-1-miquel.raynal@bootlin.com>
 <20180720151527.16038-25-miquel.raynal@bootlin.com>
Message-ID: <20180721195438.03e092b1@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 Jul 2018 17:15:16 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Two helpers have been added to the core to make ECC-related
> configuration between the detection phase and the final NAND scan. Use
> these hooks and convert the driver to just use nand_scan() instead of
> both nand_scan_ident() and nand_scan_tail().
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
>  drivers/mtd/nand/raw/txx9ndfmc.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/txx9ndfmc.c b/drivers/mtd/nand/raw/txx9ndfmc.c
> index 9019022774f7..0134beb1136d 100644
> --- a/drivers/mtd/nand/raw/txx9ndfmc.c
> +++ b/drivers/mtd/nand/raw/txx9ndfmc.c
> @@ -254,23 +254,23 @@ static void txx9ndfmc_initialize(struct platform_device *dev)
>  #define TXX9NDFMC_NS_TO_CYC(gbusclk, ns) \
>  	DIV_ROUND_UP((ns) * DIV_ROUND_UP(gbusclk, 1000), 1000000)
>  
> -static int txx9ndfmc_nand_scan(struct mtd_info *mtd)
> +static int txx9ndfmc_attach_chip(struct nand_chip *chip)
>  {
> -	struct nand_chip *chip = mtd_to_nand(mtd);
> -	int ret;
> +	struct mtd_info *mtd = nand_to_mtd(chip);
>  
> -	ret = nand_scan_ident(mtd, 1, NULL);
> -	if (!ret) {
> -		if (mtd->writesize >= 512) {
> -			/* Hardware ECC 6 byte ECC per 512 Byte data */
> -			chip->ecc.size = 512;
> -			chip->ecc.bytes = 6;
> -		}
> -		ret = nand_scan_tail(mtd);
> +	if (mtd->writesize >= 512) {
> +		/* Hardware ECC 6 byte ECC per 512 Byte data */
> +		chip->ecc.size = 512;
> +		chip->ecc.bytes = 6;
>  	}
> -	return ret;
> +
> +	return 0;
>  }
>  
> +static const struct nand_controller_ops txx9ndfmc_controller_ops = {
> +	.attach_chip = txx9ndfmc_attach_chip,
> +};
> +
>  static int __init txx9ndfmc_probe(struct platform_device *dev)
>  {
>  	struct txx9ndfmc_platform_data *plat = dev_get_platdata(&dev->dev);
> @@ -304,6 +304,7 @@ static int __init txx9ndfmc_probe(struct platform_device *dev)
>  		 (gbusclk + 500000) / 1000000, hold, spw);
>  
>  	nand_controller_init(&drvdata->controller);
> +	drvdata->controller.ops = &txx9ndfmc_controller_ops;
>  
>  	platform_set_drvdata(dev, drvdata);
>  	txx9ndfmc_initialize(dev);
> @@ -332,7 +333,7 @@ static int __init txx9ndfmc_probe(struct platform_device *dev)
>  		chip->ecc.correct = txx9ndfmc_correct_data;
>  		chip->ecc.hwctl = txx9ndfmc_enable_hwecc;
>  		chip->ecc.mode = NAND_ECC_HW;
> -		/* txx9ndfmc_nand_scan will overwrite ecc.size and ecc.bytes */
> +		/* nand_scan() will overwrite ecc.size and ecc.bytes */
>  		chip->ecc.size = 256;
>  		chip->ecc.bytes = 3;
>  		chip->ecc.strength = 1;
> @@ -359,7 +360,7 @@ static int __init txx9ndfmc_probe(struct platform_device *dev)
>  		if (plat->wide_mask & (1 << i))
>  			chip->options |= NAND_BUSWIDTH_16;
>  
> -		if (txx9ndfmc_nand_scan(mtd)) {
> +		if (nand_scan(mtd, 1)) {
>  			kfree(txx9_priv->mtdname);
>  			kfree(txx9_priv);
>  			continue;
