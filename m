From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Sun, 6 Nov 2016 19:27:43 +0100
Subject: [PATCH 13/22] mtd: nand: lpc32xx: return error code of
 nand_scan_ident/tail() on error
In-Reply-To: <1478256190-7452-14-git-send-email-yamada.masahiro@socionext.com>
References: <1478256190-7452-1-git-send-email-yamada.masahiro@socionext.com>
 <1478256190-7452-14-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20161106192743.00e401ec@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri,  4 Nov 2016 19:43:01 +0900
Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> The nand_scan_ident/tail() returns an appropriate error value when
> it fails.  Use it instead of the fixed error code -ENXIO.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  drivers/mtd/nand/lpc32xx_mlc.c | 10 ++++------
>  drivers/mtd/nand/lpc32xx_slc.c |  9 +++------
>  2 files changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/mtd/nand/lpc32xx_mlc.c b/drivers/mtd/nand/lpc32xx_mlc.c
> index 8523881..5553a5d 100644
> --- a/drivers/mtd/nand/lpc32xx_mlc.c
> +++ b/drivers/mtd/nand/lpc32xx_mlc.c
> @@ -747,10 +747,9 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
>  	 * Scan to find existance of the device and
>  	 * Get the type of NAND device SMALL block or LARGE block
>  	 */
> -	if (nand_scan_ident(mtd, 1, NULL)) {
> -		res = -ENXIO;
> +	res = nand_scan_ident(mtd, 1, NULL);
> +	if (res)
>  		goto err_exit3;
> -	}
>  
>  	host->dma_buf = devm_kzalloc(&pdev->dev, mtd->writesize, GFP_KERNEL);
>  	if (!host->dma_buf) {
> @@ -793,10 +792,9 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
>  	 * Fills out all the uninitialized function pointers with the defaults
>  	 * And scans for a bad block table if appropriate.
>  	 */
> -	if (nand_scan_tail(mtd)) {
> -		res = -ENXIO;
> +	res = nand_scan_tail(mtd);
> +	if (res)
>  		goto err_exit4;
> -	}
>  
>  	mtd->name = DRV_NAME;
>  
> diff --git a/drivers/mtd/nand/lpc32xx_slc.c b/drivers/mtd/nand/lpc32xx_slc.c
> index 8d3edc3..f1094e5 100644
> --- a/drivers/mtd/nand/lpc32xx_slc.c
> +++ b/drivers/mtd/nand/lpc32xx_slc.c
> @@ -894,10 +894,9 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
>  	}
>  
>  	/* Find NAND device */
> -	if (nand_scan_ident(mtd, 1, NULL)) {
> -		res = -ENXIO;
> +	res = nand_scan_ident(mtd, 1, NULL);
> +	if (res)
>  		goto err_exit3;
> -	}
>  
>  	/* OOB and ECC CPU and DMA work areas */
>  	host->ecc_buf = (uint32_t *)(host->data_buf + LPC32XX_DMA_DATA_SIZE);
> @@ -929,10 +928,8 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
>  	/*
>  	 * Fills out all the uninitialized function pointers with the defaults
>  	 */
> -	if (nand_scan_tail(mtd)) {
> -		res = -ENXIO;
> +	res = nand_scan_tail(mtd);

You miss

	if (res)

here.

No need to resend, I'll fix it when applying the patches.

>  		goto err_exit3;
> -	}
>  
>  	mtd->name = "nxp_lpc3220_slc";
>  	res = mtd_device_register(mtd, host->ncfg->parts,
