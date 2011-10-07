From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 7 Oct 2011 16:28:53 -0600
Subject: [PATCH 5/5] omap: hsmmc: use platform_driver_register
In-Reply-To: <1317962127-29003-6-git-send-email-manjugk@ti.com>
References: <1317962127-29003-1-git-send-email-manjugk@ti.com>
	<1317962127-29003-6-git-send-email-manjugk@ti.com>
Message-ID: <CACxGe6uTqCNSTECgFu51-Zu0YY2iy0mkjrrtfAJBC0zzQKTPpQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 6, 2011 at 11:05 PM, G, Manjunath Kondaiah <manjugk@ti.com> wrote:
>
> Existing omap hsmmc driver uses "platform_driver_probe" in init
> function. Change it to use "platform_driver_register" in order to
> use deferral probe mechanism.
>
> Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> Reported-by: Grant Likely <grant.likely@secretlab.ca>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> Cc: linux-omap at vger.kernel.org
> Cc: linux-mmc at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Greg Kroah-Hartman <greg@kroah.com>
> Cc: Dilan Lee <dilee@nvidia.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Manjunath GKondaiah <manjunath.gkondaiah@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
>
> ?drivers/mmc/host/omap_hsmmc.c | ? ?7 ++++---
> ?1 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 21e4a79..8dd2e7c 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1862,7 +1862,7 @@ static void omap_hsmmc_debugfs(struct mmc_host *mmc)
>
> ?#endif
>
> -static int __init omap_hsmmc_probe(struct platform_device *pdev)
> +static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
> ?{
> ? ? ? ?struct omap_mmc_platform_data *pdata = pdev->dev.platform_data;
> ? ? ? ?struct mmc_host *mmc;
> @@ -2077,6 +2077,7 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
> ? ? ? ?pm_runtime_mark_last_busy(host->dev);
> ? ? ? ?pm_runtime_put_autosuspend(host->dev);
>
> + ? ? ? dev_dbg(mmc_dev(host->mmc), "Probe success...\n");
> ? ? ? ?return 0;
>
> ?err_slot_name:
> @@ -2270,6 +2271,7 @@ static struct dev_pm_ops omap_hsmmc_dev_pm_ops = {
> ?};
>
> ?static struct platform_driver omap_hsmmc_driver = {
> + ? ? ? .probe ? ? ? ? ?= omap_hsmmc_probe,
> ? ? ? ?.remove ? ? ? ? = omap_hsmmc_remove,
> ? ? ? ?.driver ? ? ? ? = {
> ? ? ? ? ? ? ? ?.name = DRIVER_NAME,
> @@ -2280,8 +2282,7 @@ static struct platform_driver omap_hsmmc_driver = {
>
> ?static int __init omap_hsmmc_init(void)
> ?{
> - ? ? ? /* Register the MMC driver */
> - ? ? ? return platform_driver_probe(&omap_hsmmc_driver, omap_hsmmc_probe);
> + ? ? ? return platform_driver_register(&omap_hsmmc_driver);
> ?}
>
> ?static void __exit omap_hsmmc_cleanup(void)
> --
> 1.7.4.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at ?http://www.tux.org/lkml/
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
