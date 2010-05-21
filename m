From: LW@KARO-electronics.de (=?iso-8859-15?Q?Lothar_Wa=DFmann?=)
Date: Fri, 21 May 2010 13:41:12 +0200
Subject: [PATCH 2/5] mxc_nand: fix PM
In-Reply-To: <1274440363-435-2-git-send-email-eric@eukrea.com>
References: <1274440363-435-1-git-send-email-eric@eukrea.com>
	<1274440363-435-2-git-send-email-eric@eukrea.com>
Message-ID: <19446.29016.956006.230105@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

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
[...]
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
Since you are clearing host->clk_act during suspend, this will
unconditionally enable the clock no matter what state it had before
suspend (in case that's intended, the check for !host->clk_act is
useless, since it will always yield true).
I think it's more sensible to leave host->clk_act alone, and reenable
the clock only if host->clk_act is set, so that the clock is left in
the same state after resume in which it was before suspend.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
