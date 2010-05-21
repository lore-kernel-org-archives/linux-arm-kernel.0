From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 21 May 2010 15:10:58 +0200
Subject: [PATCH 2/5] mxc_nand: fix PM
In-Reply-To: <1274440363-435-2-git-send-email-eric@eukrea.com>
References: <1274440363-435-1-git-send-email-eric@eukrea.com>
	<1274440363-435-2-git-send-email-eric@eukrea.com>
Message-ID: <20100521131058.GC27829@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 21, 2010 at 01:12:40PM +0200, Eric B?nard wrote:

A short description what was fixed and how it was fixed would be great.

> Signed-off-by: Eric B?nard <eric@eukrea.com>
> ---
>  drivers/mtd/nand/mxc_nand.c |   27 ++++++++++-----------------
>  1 files changed, 10 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
> index fb03aff..5e51d4d 100644
> --- a/drivers/mtd/nand/mxc_nand.c
> +++ b/drivers/mtd/nand/mxc_nand.c
> @@ -895,16 +895,13 @@ static int __devexit mxcnd_remove(struct platform_device *pdev)
>  #ifdef CONFIG_PM
>  static int mxcnd_suspend(struct platform_device *pdev, pm_message_t state)
>  {
> -	struct mtd_info *mtd = platform_get_drvdata(pdev);
> -	struct nand_chip *nand_chip = mtd->priv;
> -	struct mxc_nand_host *host = nand_chip->priv;
> +	struct mxc_nand_host *host = platform_get_drvdata(pdev);
>  	int ret = 0;
>  
>  	DEBUG(MTD_DEBUG_LEVEL0, "MXC_ND : NAND suspend\n");
> -	if (mtd) {
> -		ret = mtd->suspend(mtd);
> -		/* Disable the NFC clock */
> +	if (host->clk_act) {
>  		clk_disable(host->clk);
> +		host->clk_act = 0;
>  	}
>  
>  	return ret;
> @@ -912,31 +909,27 @@ static int mxcnd_suspend(struct platform_device *pdev, pm_message_t state)
>  
>  static int mxcnd_resume(struct platform_device *pdev)
>  {
> -	struct mtd_info *mtd = platform_get_drvdata(pdev);
> -	struct nand_chip *nand_chip = mtd->priv;
> -	struct mxc_nand_host *host = nand_chip->priv;
> +	struct mxc_nand_host *host = platform_get_drvdata(pdev);
>  	int ret = 0;
>  
>  	DEBUG(MTD_DEBUG_LEVEL0, "MXC_ND : NAND resume\n");
> -
> -	if (mtd) {
> -		/* Enable the NFC clock */
> +	if (!host->clk_act) {
>  		clk_enable(host->clk);
> -		mtd->resume(mtd);
> +		host->clk_act = 1;
>  	}
>  
>  	return ret;
>  }
>  
>  #else
> -# define mxcnd_suspend   NULL
> -# define mxcnd_resume    NULL
> -#endif				/* CONFIG_PM */
> +#define mxcnd_suspend	NULL
> +#define mxcnd_resume	NULL
> +#endif
>  
>  static struct platform_driver mxcnd_driver = {
>  	.driver = {
>  		   .name = DRIVER_NAME,
> -		   },
> +	},
>  	.remove = __devexit_p(mxcnd_remove),
>  	.suspend = mxcnd_suspend,
>  	.resume = mxcnd_resume,
> -- 
> 1.6.3.3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100521/49433094/attachment.sig>
