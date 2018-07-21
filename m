From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Sat, 21 Jul 2018 19:21:01 +0200
Subject: [PATCH v4 16/35] mtd: rawnand: nandsim: convert driver to
 nand_scan()
In-Reply-To: <20180720151527.16038-17-miquel.raynal@bootlin.com>
References: <20180720151527.16038-1-miquel.raynal@bootlin.com>
 <20180720151527.16038-17-miquel.raynal@bootlin.com>
Message-ID: <20180721192101.0e0d1860@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 Jul 2018 17:15:08 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Two helpers have been added to the core to make ECC-related
> configuration between the detection phase and the final NAND scan. Use
> these hooks and convert the driver to just use nand_scan() instead of
> both nand_scan_ident() and nand_scan_tail().
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
>  drivers/mtd/nand/raw/nandsim.c | 82 +++++++++++++++++++++++-------------------
>  1 file changed, 45 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/nandsim.c b/drivers/mtd/nand/raw/nandsim.c
> index 8a3b36cfe5ea..71ac034aee9c 100644
> --- a/drivers/mtd/nand/raw/nandsim.c
> +++ b/drivers/mtd/nand/raw/nandsim.c
> @@ -2192,6 +2192,48 @@ static void ns_nand_read_buf(struct mtd_info *mtd, u_char *buf, int len)
>  	return;
>  }
>  
> +static int ns_attach_chip(struct nand_chip *chip)
> +{
> +	unsigned int eccsteps, eccbytes;
> +
> +	if (!bch)
> +		return 0;
> +
> +	if (!mtd_nand_has_bch()) {
> +		NS_ERR("BCH ECC support is disabled\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Use 512-byte ecc blocks */
> +	eccsteps = nsmtd->writesize / 512;
> +	eccbytes = ((bch * 13) + 7) / 8;
> +
> +	/* Do not bother supporting small page devices */
> +	if (nsmtd->oobsize < 64 || !eccsteps) {
> +		NS_ERR("BCH not available on small page devices\n");
> +		return -EINVAL;
> +	}
> +
> +	if (((eccbytes * eccsteps) + 2) > nsmtd->oobsize) {
> +		NS_ERR("Invalid BCH value %u\n", bch);
> +		return -EINVAL;
> +	}
> +
> +	chip->ecc.mode = NAND_ECC_SOFT;
> +	chip->ecc.algo = NAND_ECC_BCH;
> +	chip->ecc.size = 512;
> +	chip->ecc.strength = bch;
> +	chip->ecc.bytes = eccbytes;
> +
> +	NS_INFO("Using %u-bit/%u bytes BCH ECC\n", bch, chip->ecc.size);
> +
> +	return 0;
> +}
> +
> +static const struct nand_controller_ops ns_controller_ops = {
> +	.attach_chip = ns_attach_chip,
> +};
> +
>  /*
>   * Module initialization function
>   */
> @@ -2276,44 +2318,10 @@ static int __init ns_init_module(void)
>  	if ((retval = parse_gravepages()) != 0)
>  		goto error;
>  
> -	retval = nand_scan_ident(nsmtd, 1, NULL);
> +	chip->dummy_controller.ops = &ns_controller_ops;
> +	retval = nand_scan(nsmtd, 1);
>  	if (retval) {
> -		NS_ERR("cannot scan NAND Simulator device\n");
> -		goto error;
> -	}
> -
> -	if (bch) {
> -		unsigned int eccsteps, eccbytes;
> -		if (!mtd_nand_has_bch()) {
> -			NS_ERR("BCH ECC support is disabled\n");
> -			retval = -EINVAL;
> -			goto error;
> -		}
> -		/* use 512-byte ecc blocks */
> -		eccsteps = nsmtd->writesize/512;
> -		eccbytes = (bch*13+7)/8;
> -		/* do not bother supporting small page devices */
> -		if ((nsmtd->oobsize < 64) || !eccsteps) {
> -			NS_ERR("bch not available on small page devices\n");
> -			retval = -EINVAL;
> -			goto error;
> -		}
> -		if ((eccbytes*eccsteps+2) > nsmtd->oobsize) {
> -			NS_ERR("invalid bch value %u\n", bch);
> -			retval = -EINVAL;
> -			goto error;
> -		}
> -		chip->ecc.mode = NAND_ECC_SOFT;
> -		chip->ecc.algo = NAND_ECC_BCH;
> -		chip->ecc.size = 512;
> -		chip->ecc.strength = bch;
> -		chip->ecc.bytes = eccbytes;
> -		NS_INFO("using %u-bit/%u bytes BCH ECC\n", bch, chip->ecc.size);
> -	}
> -
> -	retval = nand_scan_tail(nsmtd);
> -	if (retval) {
> -		NS_ERR("can't register NAND Simulator\n");
> +		NS_ERR("Could not scan NAND Simulator device\n");
>  		goto error;
>  	}
>  
