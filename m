From: rnayak@ti.com (Rajendra Nayak)
Date: Tue, 17 Apr 2012 15:41:51 +0530
Subject: [PATCH] mmc: omap_hsmmc: Fix check for mmc dt node
In-Reply-To: <1334656449-12142-1-git-send-email-jaswinder.singh@linaro.org>
References: <1334656449-12142-1-git-send-email-jaswinder.singh@linaro.org>
Message-ID: <4F8D41E7.2050701@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 April 2012 03:24 PM, Jassi Brar wrote:
> Proper check should be if the hsmmc driver got its platform_data
> via devicetree, and not if the devicetree is populated for the
> platform.

This one is already fixed here..
http://www.spinics.net/lists/linux-omap/msg67879.html

>
> Signed-off-by: Jassi Brar<jaswinder.singh@linaro.org>
> ---
>
> The patch is more than a nit-pick because upstream doesn't yet have dt
> nodes for mmc on OMAP while the driver wrongly assumes it does.
> Which isn't a problem until you use some low-end sdhc card
> (Transcend 8GB Class-4 in my experience) which fails to re-initialize,
> OCR[30] set, if the first attempt fails due to delay at certain times
> during the probe (for ex, simply enable CONFIG_REGULATOR_DUMMY).
> Apparently such cards need proper 0v->1.8v power cycle to recover
> (another Class-10 card does recover after ~10 attempts by the host).
>
> While this simple patch gets us through the problem, it also tells
> that adding mmc dt nodes without PBIAS setup callbacks in place
> (without which we can't switch off the regulator or do 1.8v ->  3.3v
> switch) is probably not a safe option.
>
>   drivers/mmc/host/omap_hsmmc.c |    6 ++++--
>   1 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index c628b95..b5ca4593 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -138,6 +138,7 @@ struct omap_hsmmc_next {
>
>   struct omap_hsmmc_host {
>   	struct	device		*dev;
> +	struct	of_device_id	*of_dev;
>   	struct	mmc_host	*mmc;
>   	struct	mmc_request	*mrq;
>   	struct	mmc_command	*cmd;
> @@ -249,7 +250,7 @@ static int omap_hsmmc_set_power(struct device *dev, int slot, int power_on,
>   	 * the pbias cell programming support is still missing when
>   	 * booting with Device tree
>   	 */
> -	if (of_have_populated_dt()&&  !vdd)
> +	if (host->of_dev&&  !vdd)
>   		return 0;
>
>   	if (mmc_slot(host).before_set_reg)
> @@ -1550,7 +1551,7 @@ static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>   			 * can't be allowed when booting with device
>   			 * tree.
>   			 */
> -			(!of_have_populated_dt())) {
> +			!host->of_dev) {
>   				/*
>   				 * The mmc_select_voltage fn of the core does
>   				 * not seem to set the power_mode to
> @@ -1837,6 +1838,7 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
>   	host		= mmc_priv(mmc);
>   	host->mmc	= mmc;
>   	host->pdata	= pdata;
> +	host->of_dev	= match;
>   	host->dev	=&pdev->dev;
>   	host->use_dma	= 1;
>   	host->dev->dma_mask =&pdata->dma_mask;
