From: josh.wu@atmel.com (Josh Wu)
Date: Mon, 9 Jun 2014 18:30:38 +0800
Subject: [PATCH] mtd: atmel_nand: make ecc parameters same as definition
In-Reply-To: <1402041728-12056-1-git-send-email-voice.shen@atmel.com>
References: <1402041728-12056-1-git-send-email-voice.shen@atmel.com>
Message-ID: <53958CCE.5080307@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Bo

Thanks for the patch.

On 6/6/2014 4:02 PM, Bo Shen wrote:
> If the ecc parameter is not the same as definition, when the
> mtd core check these parameters, it will give the unexpected
> result.
Could you be more specific to tell what kind of result will happened?

Best Regards,
Josh Wu

>
> Signed-off-by: Bo Shen <voice.shen@atmel.com>
> ---
>   drivers/mtd/nand/atmel_nand.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
> index 4ce181a..4f5348f 100644
> --- a/drivers/mtd/nand/atmel_nand.c
> +++ b/drivers/mtd/nand/atmel_nand.c
> @@ -861,12 +861,11 @@ static int pmecc_correction(struct mtd_info *mtd, u32 pmecc_stat, uint8_t *buf,
>   {
>   	struct nand_chip *nand_chip = mtd->priv;
>   	struct atmel_nand_host *host = nand_chip->priv;
> -	int i, err_nbr, eccbytes;
> +	int i, err_nbr;
>   	uint8_t *buf_pos;
>   	int total_err = 0;
>   
> -	eccbytes = nand_chip->ecc.bytes;
> -	for (i = 0; i < eccbytes; i++)
> +	for (i = 0; i < nand_chip->ecc.total; i++)
>   		if (ecc[i] != 0xff)
>   			goto normal_check;
>   	/* Erased page, return OK */
> @@ -928,7 +927,7 @@ static int atmel_nand_pmecc_read_page(struct mtd_info *mtd,
>   	struct nand_chip *chip, uint8_t *buf, int oob_required, int page)
>   {
>   	struct atmel_nand_host *host = chip->priv;
> -	int eccsize = chip->ecc.size;
> +	int eccsize = chip->ecc.size * chip->ecc.steps;
>   	uint8_t *oob = chip->oob_poi;
>   	uint32_t *eccpos = chip->ecc.layout->eccpos;
>   	uint32_t stat;
> @@ -1169,8 +1168,7 @@ static int atmel_pmecc_nand_init_params(struct platform_device *pdev,
>   		goto err;
>   	}
>   
> -	/* ECC is calculated for the whole page (1 step) */
> -	nand_chip->ecc.size = mtd->writesize;
> +	nand_chip->ecc.size = sector_size;
>   
>   	/* set ECC page size and oob layout */
>   	switch (mtd->writesize) {
> @@ -1185,18 +1183,20 @@ static int atmel_pmecc_nand_init_params(struct platform_device *pdev,
>   		host->pmecc_index_of = host->pmecc_rom_base +
>   			host->pmecc_lookup_table_offset;
>   
> -		nand_chip->ecc.steps = 1;
> +		nand_chip->ecc.steps = host->pmecc_sector_number;
>   		nand_chip->ecc.strength = cap;
> -		nand_chip->ecc.bytes = host->pmecc_bytes_per_sector *
> +		nand_chip->ecc.bytes = host->pmecc_bytes_per_sector;
> +		nand_chip->ecc.total = host->pmecc_bytes_per_sector *
>   				       host->pmecc_sector_number;
> -		if (nand_chip->ecc.bytes > mtd->oobsize - 2) {
> +		if (nand_chip->ecc.total > mtd->oobsize - 2) {
>   			dev_err(host->dev, "No room for ECC bytes\n");
>   			err_no = -EINVAL;
>   			goto err;
>   		}
>   		pmecc_config_ecc_layout(&atmel_pmecc_oobinfo,
>   					mtd->oobsize,
> -					nand_chip->ecc.bytes);
> +					nand_chip->ecc.total);
> +
>   		nand_chip->ecc.layout = &atmel_pmecc_oobinfo;
>   		break;
>   	case 512:
