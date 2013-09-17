From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 17 Sep 2013 12:29:19 -0700
Subject: [PATCH v2] mtd: atmel_nand: use the common function to get ecc
 info
In-Reply-To: <1379066537-29505-1-git-send-email-josh.wu@atmel.com>
References: <1379066537-29505-1-git-send-email-josh.wu@atmel.com>
Message-ID: <20130917192919.GO4550@ld-irv-0074.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Josh,

On Fri, Sep 13, 2013 at 06:02:17PM +0800, Josh Wu wrote:
> Atmel nand will check ONFI ecc information when config the PMECC parameters.
> Since commit: 10c86babfb
>   (mtd: get the ECC info from the parameter page for ONFI nand)
> 
> introduced the ecc_strength_ds & ecc_step_ds and initialized them during
> ONFI detecting.
> So we can use them directly and remove our own get_onfi_ecc_param function.
> 
> Signed-off-by: Josh Wu <josh.wu@atmel.com>
> ---
> v1 --> v2:
>   1. updated the refered commit id as it is changed when merged in mainline.
>   2. refined the commit message
> 
>  drivers/mtd/nand/atmel_nand.c |   36 ++++--------------------------------
>  1 file changed, 4 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
> index 060feea..6502247 100644
> --- a/drivers/mtd/nand/atmel_nand.c
> +++ b/drivers/mtd/nand/atmel_nand.c
> @@ -1062,30 +1062,6 @@ static void atmel_pmecc_core_init(struct mtd_info *mtd)
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
>   * Get ecc requirement from ONFI parameters ecc requirement.
>   * If pmecc-cap, pmecc-sector-size in DTS are not specified, this function
>   * will set them according to ONFI ecc requirement. Otherwise, use the
> @@ -1096,19 +1072,15 @@ static int pmecc_choose_ecc(struct atmel_nand_host *host,
>  		int *cap, int *sector_size)
>  {
>  	/* Get ECC requirement from ONFI parameters */
> -	*cap = *sector_size = 0;
>  	if (host->nand_chip.onfi_version) {
> -		if (!get_onfi_ecc_param(&host->nand_chip, cap, sector_size))
> -			dev_info(host->dev, "ONFI params, minimum required ECC: %d bits in %d bytes\n",
> +		*cap = host->nand_chip.ecc_strength_ds;
> +		*sector_size = host->nand_chip.ecc_step_ds;

The nand_chip.ecc_{strength,step}_ds values are no longer specific to
ONFI; they may be included in the full-ID table as well. So this might
be better written as:

	if (host->nand_chip.ecc_strength_ds) {
		*cap = host->nand_chip.ecc_strength_ds;
		*sector_size = host->nand_chip.ecc_step_ds;
		// ...
	}

> +		dev_info(host->dev, "ONFI params, minimum required ECC: %d bits in %d bytes\n",
>  				*cap, *sector_size);
> -		else
> -			dev_info(host->dev, "NAND chip ECC reqirement is in Extended ONFI parameter, we don't support yet.\n");
>  	} else {
> -		dev_info(host->dev, "NAND chip is not ONFI compliant, assume ecc_bits is 2 in 512 bytes");
> -	}
> -	if (*cap == 0 && *sector_size == 0) {
>  		*cap = 2;
>  		*sector_size = 512;
> +		dev_info(host->dev, "NAND chip is not ONFI compliant, assume ecc_bits is 2 in 512 bytes");

You would also want to change this message to longer be about ONFI.
Maybe "cannot detect minimum ECC requirements; assuming 2-bit correction
per 512 bytes"?

>  	}
>  
>  	/* If dts file doesn't specify then use the one in ONFI parameters */

Brian
