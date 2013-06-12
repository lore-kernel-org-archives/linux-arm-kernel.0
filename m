From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 12 Jun 2013 13:57:48 +0200
Subject: [PATCH 2/6] mtd: atmel_nand: replace pmecc enable code with
 one function.
In-Reply-To: <1370860014-1770-3-git-send-email-josh.wu@atmel.com>
References: <1370860014-1770-1-git-send-email-josh.wu@atmel.com>
 <1370860014-1770-3-git-send-email-josh.wu@atmel.com>
Message-ID: <20130612115748.GQ23653@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18:26 Mon 10 Jun     , Josh Wu wrote:
> Signed-off-by: Josh Wu <josh.wu@atmel.com>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
> ---
>  drivers/mtd/nand/atmel_nand.c |   40 +++++++++++++++++++++++++---------------
>  1 file changed, 25 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
> index c7a4016..7236415 100644
> --- a/drivers/mtd/nand/atmel_nand.c
> +++ b/drivers/mtd/nand/atmel_nand.c
> @@ -754,6 +754,29 @@ normal_check:
>  	return total_err;
>  }
>  
> +static void pmecc_enable(struct atmel_nand_host *host, int ecc_op)
> +{
> +	u32 val;
> +	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_RST);
> +	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_DISABLE);
> +	val = pmecc_readl_relaxed(host->ecc, CFG);
> +
> +	if (ecc_op != NAND_ECC_READ && ecc_op != NAND_ECC_WRITE) {
> +		dev_err(host->dev, "atmel_nand: wrong pmecc operation type!");
> +		return;
> +	}
> +
> +	if (ecc_op == NAND_ECC_READ)
> +		pmecc_writel(host->ecc, CFG, (val & ~PMECC_CFG_WRITE_OP)
> +			| PMECC_CFG_AUTO_ENABLE);
> +	else
> +		pmecc_writel(host->ecc, CFG, (val | PMECC_CFG_WRITE_OP)
> +			& ~PMECC_CFG_AUTO_ENABLE);
> +
> +	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_ENABLE);
> +	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_DATA);
> +}
> +
>  static int atmel_nand_pmecc_read_page(struct mtd_info *mtd,
>  	struct nand_chip *chip, uint8_t *buf, int oob_required, int page)
>  {
> @@ -765,13 +788,7 @@ static int atmel_nand_pmecc_read_page(struct mtd_info *mtd,
>  	unsigned long end_time;
>  	int bitflips = 0;
>  
> -	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_RST);
> -	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_DISABLE);
> -	pmecc_writel(host->ecc, CFG, (pmecc_readl_relaxed(host->ecc, CFG)
> -		& ~PMECC_CFG_WRITE_OP) | PMECC_CFG_AUTO_ENABLE);
> -
> -	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_ENABLE);
> -	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_DATA);
> +	pmecc_enable(host, NAND_ECC_READ);
>  
>  	chip->read_buf(mtd, buf, eccsize);
>  	chip->read_buf(mtd, oob, mtd->oobsize);
> @@ -804,14 +821,7 @@ static int atmel_nand_pmecc_write_page(struct mtd_info *mtd,
>  	int i, j;
>  	unsigned long end_time;
>  
> -	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_RST);
> -	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_DISABLE);
> -
> -	pmecc_writel(host->ecc, CFG, (pmecc_readl_relaxed(host->ecc, CFG) |
> -		PMECC_CFG_WRITE_OP) & ~PMECC_CFG_AUTO_ENABLE);
> -
> -	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_ENABLE);
> -	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_DATA);
> +	pmecc_enable(host, NAND_ECC_WRITE);
>  
>  	chip->write_buf(mtd, (u8 *)buf, mtd->writesize);
>  
> -- 
> 1.7.9.5
> 
