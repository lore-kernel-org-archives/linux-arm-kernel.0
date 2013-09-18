From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 18 Sep 2013 14:42:25 -0700
Subject: [PATCH v3] mtd: atmel_nand: use minimum ecc requirements of
 nand: ecc_{strength,step}_ds
In-Reply-To: <1379483928-18253-1-git-send-email-josh.wu@atmel.com>
References: <1379483928-18253-1-git-send-email-josh.wu@atmel.com>
Message-ID: <20130918214225.GP4550@ld-irv-0074.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 18, 2013 at 01:58:48PM +0800, Josh Wu wrote:
> Since ecc_{strength,step}_ds is introduced in nand_chip structure for
> minimum ecc requirements. So we can use them directly and remove our
> own get_onfi_ecc_param function.
> 
> Signed-off-by: Josh Wu <josh.wu@atmel.com>
> ---
> v2 --> v3:
>   1. since ecc_{strength,step}_ds is non ONFI specific remove the check code:
>         'if (host->nand_chip.onfi_version)'
>      use 'if (host->nand_chip.ecc_strength_ds)' instead.
>   2. refined the commit message and change the comment since now we are not
>      ONFI specific.
> 
> v1 --> v2:
>   1. updated the refered commit id as it is changed when merged in mainline.
>   2. refined the commit message
> 
>  drivers/mtd/nand/atmel_nand.c |   46 ++++++++---------------------------------
>  1 file changed, 9 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
> index 5a5d457..46e8794 100644
> --- a/drivers/mtd/nand/atmel_nand.c
> +++ b/drivers/mtd/nand/atmel_nand.c
> @@ -1062,56 +1062,28 @@ static void atmel_pmecc_core_init(struct mtd_info *mtd)
>  }
>  
>  /*
> - * Get ECC requirement in ONFI parameters, returns -1 if ONFI
> - * parameters is not supported.
> - * return 0 if success to get the ECC requirement.
> - */
> -static int get_onfi_ecc_param(struct nand_chip *chip,
> -		int *ecc_bits, int *sector_size)
> -{
> -	*ecc_bits = *sector_size = 0;
> -
> -	if (chip->onfi_params.ecc_bits == 0xff)
> -		/* TODO: the sector_size and ecc_bits need to be find in
> -		 * extended ecc parameter, currently we don't support it.
> -		 */
> -		return -1;
> -
> -	*ecc_bits = chip->onfi_params.ecc_bits;
> -
> -	/* The default sector size (ecc codeword size) is 512 */
> -	*sector_size = 512;
> -
> -	return 0;
> -}
> -
> -/*
> - * Get ecc requirement from ONFI parameters ecc requirement.
> + * Get minimum ecc requirements from NAND.
>   * If pmecc-cap, pmecc-sector-size in DTS are not specified, this function
> - * will set them according to ONFI ecc requirement. Otherwise, use the
> + * will set them according to minimum ecc requirement. Otherwise, use the
>   * value in DTS file.
>   * return 0 if success. otherwise return error code.
>   */
>  static int pmecc_choose_ecc(struct atmel_nand_host *host,
>  		int *cap, int *sector_size)
>  {
> -	/* Get ECC requirement from ONFI parameters */
> -	*cap = *sector_size = 0;
> -	if (host->nand_chip.onfi_version) {
> -		if (!get_onfi_ecc_param(&host->nand_chip, cap, sector_size))
> -			dev_info(host->dev, "ONFI params, minimum required ECC: %d bits in %d bytes\n",
> +	/* Get minimum ECC requirements */
> +	if (host->nand_chip.ecc_strength_ds) {
> +		*cap = host->nand_chip.ecc_strength_ds;
> +		*sector_size = host->nand_chip.ecc_step_ds;
> +		dev_info(host->dev, "minimum ECC requirements: %d bits in %d bytes\n",
>  				*cap, *sector_size);
> -		else
> -			dev_info(host->dev, "NAND chip ECC reqirement is in Extended ONFI parameter, we don't support yet.\n");
>  	} else {
> -		dev_info(host->dev, "NAND chip is not ONFI compliant, assume ecc_bits is 2 in 512 bytes");
> -	}
> -	if (*cap == 0 && *sector_size == 0) {
>  		*cap = 2;
>  		*sector_size = 512;
> +		dev_info(host->dev, "cannot detect minimum ECC requirements, assume 2-bit correction per 512 bytes");

Missing '\n' at the end of the string.

>  	}
>  
> -	/* If dts file doesn't specify then use the one in ONFI parameters */
> +	/* If dts file doesn't specify then use the NAND's minimum ecc parameters */

This code is not interested in a "dts file", it is interested in the
device tree.

>  	if (host->pmecc_corr_cap == 0) {
>  		/* use the most fitable ecc bits (the near bigger one ) */
>  		if (*cap <= 2)

I'll just apply the appended diff, to address these small comments and
to shorten the messages a little (they are a bit verbose and are over 80
characters). It's still not under 80, but it's more reasonable.

Let me know if you have any objections, or else I'll push this to
l2-mtd.git.

Thanks,
Brian

diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index 46e8794..ef9c9f5 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -1075,15 +1075,15 @@ static int pmecc_choose_ecc(struct atmel_nand_host *host,
 	if (host->nand_chip.ecc_strength_ds) {
 		*cap = host->nand_chip.ecc_strength_ds;
 		*sector_size = host->nand_chip.ecc_step_ds;
-		dev_info(host->dev, "minimum ECC requirements: %d bits in %d bytes\n",
+		dev_info(host->dev, "minimum ECC: %d bits in %d bytes\n",
 				*cap, *sector_size);
 	} else {
 		*cap = 2;
 		*sector_size = 512;
-		dev_info(host->dev, "cannot detect minimum ECC requirements, assume 2-bit correction per 512 bytes");
+		dev_info(host->dev, "can't detect min. ECC, assume 2 bits in 512 bytes\n");
 	}
 
-	/* If dts file doesn't specify then use the NAND's minimum ecc parameters */
+	/* If device tree doesn't specify, use NAND's minimum ECC parameters */
 	if (host->pmecc_corr_cap == 0) {
 		/* use the most fitable ecc bits (the near bigger one ) */
 		if (*cap <= 2)
