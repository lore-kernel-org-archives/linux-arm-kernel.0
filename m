From: balajitk@ti.com (T Krishnamoorthy, Balaji)
Date: Tue, 17 Apr 2012 15:41:44 +0530
Subject: [PATCH] mmc: omap_hsmmc: Fix check for mmc dt node
In-Reply-To: <1334656449-12142-1-git-send-email-jaswinder.singh@linaro.org>
References: <1334656449-12142-1-git-send-email-jaswinder.singh@linaro.org>
Message-ID: <CANrkHUa9yNye7b12=VEFPsMg7JdQnE6BvE_7sW+1PfgyWFH+mw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 17, 2012 at 3:24 PM, Jassi Brar <jaswinder.singh@linaro.org> wrote:
> Proper check should be if the hsmmc driver got its platform_data
> via devicetree, and not if the devicetree is populated for the
> platform.
>
> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>

Hi,
Similar patch by Rajendra is in mmc-next

http://git.kernel.org/?p=linux/kernel/git/cjb/mmc.git;a=commit;h=3d9bc09d825f72ef119a94615e0de6baea86981f

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

Is this issue seen while booting with device tree or non device tree ?

> While this simple patch gets us through the problem, it also tells
> that adding mmc dt nodes without PBIAS setup callbacks in place
> (without which we can't switch off the regulator or do 1.8v -> 3.3v
> switch) is probably not a safe option.
>
> ?drivers/mmc/host/omap_hsmmc.c | ? ?6 ++++--
> ?1 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index c628b95..b5ca4593 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -138,6 +138,7 @@ struct omap_hsmmc_next {
>
> ?struct omap_hsmmc_host {
> ? ? ? ?struct ?device ? ? ? ? ?*dev;
> + ? ? ? struct ?of_device_id ? ?*of_dev;
> ? ? ? ?struct ?mmc_host ? ? ? ?*mmc;
> ? ? ? ?struct ?mmc_request ? ? *mrq;
> ? ? ? ?struct ?mmc_command ? ? *cmd;
> @@ -249,7 +250,7 @@ static int omap_hsmmc_set_power(struct device *dev, int slot, int power_on,
> ? ? ? ? * the pbias cell programming support is still missing when
> ? ? ? ? * booting with Device tree
> ? ? ? ? */
> - ? ? ? if (of_have_populated_dt() && !vdd)
> + ? ? ? if (host->of_dev && !vdd)
> ? ? ? ? ? ? ? ?return 0;
>
> ? ? ? ?if (mmc_slot(host).before_set_reg)
> @@ -1550,7 +1551,7 @@ static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> ? ? ? ? ? ? ? ? ? ? ? ? * can't be allowed when booting with device
> ? ? ? ? ? ? ? ? ? ? ? ? * tree.
> ? ? ? ? ? ? ? ? ? ? ? ? */
> - ? ? ? ? ? ? ? ? ? ? ? (!of_have_populated_dt())) {
> + ? ? ? ? ? ? ? ? ? ? ? !host->of_dev) {
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?/*
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? * The mmc_select_voltage fn of the core does
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? * not seem to set the power_mode to
> @@ -1837,6 +1838,7 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
> ? ? ? ?host ? ? ? ? ? ?= mmc_priv(mmc);
> ? ? ? ?host->mmc ? ? ? = mmc;
> ? ? ? ?host->pdata ? ? = pdata;
> + ? ? ? host->of_dev ? ?= match;
> ? ? ? ?host->dev ? ? ? = &pdev->dev;
> ? ? ? ?host->use_dma ? = 1;
> ? ? ? ?host->dev->dma_mask = &pdata->dma_mask;
> --
> 1.7.4.1
>
