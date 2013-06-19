From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 19 Jun 2013 18:15:40 +0400
Subject: [PATCH 2/6] mtd: atmel_nand: replace pmecc enable code with one
 function.
In-Reply-To: <1371622997-26303-3-git-send-email-josh.wu@atmel.com>
References: <1371622997-26303-1-git-send-email-josh.wu@atmel.com>
 <1371622997-26303-3-git-send-email-josh.wu@atmel.com>
Message-ID: <51C1BD0C.2040008@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 19-06-2013 10:23, Josh Wu wrote:

> Signed-off-by: Josh Wu <josh.wu@atmel.com>
> Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> ---
>   drivers/mtd/nand/atmel_nand.c |   40 +++++++++++++++++++++++++---------------
>   1 file changed, 25 insertions(+), 15 deletions(-)

> diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
> index d39f364..cb8362e 100644
> --- a/drivers/mtd/nand/atmel_nand.c
> +++ b/drivers/mtd/nand/atmel_nand.c
> @@ -754,6 +754,29 @@ normal_check:
>   	return total_err;
>   }
>
> +static void pmecc_enable(struct atmel_nand_host *host, int ecc_op)
> +{
> +	u32 val;

    Other functions have empty line after the declaration.

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

WBR, Sergei
