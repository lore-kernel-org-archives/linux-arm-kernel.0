From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Sun, 26 Sep 2010 05:02:29 -0400
Subject: [PATCH 1/4] mmc: sdhci-pltfm: Add structure for host-specific data
In-Reply-To: <1285072210-10207-2-git-send-email-w.sang@pengutronix.de>
References: <1285072210-10207-1-git-send-email-w.sang@pengutronix.de>
	<1285072210-10207-2-git-send-email-w.sang@pengutronix.de>
Message-ID: <AANLkTimcscR56u=-iT9v5V+Tsg2KNOqiuQ2DKojJ++6c@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 21, 2010 at 8:30 AM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> We need to carry some information per host, e.g. the clock. Add a
> structure for it and initialize it in the generic part.
>
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> ---
> ?drivers/mmc/host/sdhci-pltfm.c | ? ?7 +++++--
> ?drivers/mmc/host/sdhci-pltfm.h | ? ?5 +++++
> ?2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
> index e045e3c..bf522a1 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -55,6 +55,7 @@ static int __devinit sdhci_pltfm_probe(struct platform_device *pdev)
> ? ? ? ?struct sdhci_pltfm_data *pdata = pdev->dev.platform_data;
> ? ? ? ?const struct platform_device_id *platid = platform_get_device_id(pdev);
> ? ? ? ?struct sdhci_host *host;
> + ? ? ? struct sdhci_pltfm_host *pltfm_host;
> ? ? ? ?struct resource *iomem;
> ? ? ? ?int ret;
>
> @@ -72,15 +73,17 @@ static int __devinit sdhci_pltfm_probe(struct platform_device *pdev)
> ? ? ? ? ? ? ? ? ? ? ? ?"experience problems.\n");
>
> ? ? ? ?if (pdev->dev.parent)
> - ? ? ? ? ? ? ? host = sdhci_alloc_host(pdev->dev.parent, 0);
> + ? ? ? ? ? ? ? host = sdhci_alloc_host(pdev->dev.parent, sizeof(*pltfm_host));

Could you help clarify why pdev->dev.parent here, then
mmc_dev(host->mmc)  in child driver is platform, instead of specific
driver itself, is this the design.
> ? ? ? ?else
> - ? ? ? ? ? ? ? host = sdhci_alloc_host(&pdev->dev, 0);
> + ? ? ? ? ? ? ? host = sdhci_alloc_host(&pdev->dev, sizeof(*pltfm_host));
>

> ? ? ? ?if (IS_ERR(host)) {
> ? ? ? ? ? ? ? ?ret = PTR_ERR(host);
> ? ? ? ? ? ? ? ?goto err;
> ? ? ? ?}
>
> + ? ? ? pltfm_host = sdhci_priv(host);
> +
> ? ? ? ?host->hw_name = "platform";
> ? ? ? ?if (pdata && pdata->ops)
> ? ? ? ? ? ? ? ?host->ops = pdata->ops;
> diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
> index 900f329..c393289 100644
> --- a/drivers/mmc/host/sdhci-pltfm.h
> +++ b/drivers/mmc/host/sdhci-pltfm.h
> @@ -13,6 +13,11 @@
>
> ?#include <linux/sdhci-pltfm.h>
>
> +struct sdhci_pltfm_host {
> + ? ? ? struct clk *clk;
> + ? ? ? u32 scratchpad; /* to handle quirks across io-accessor calls */
> +};
> +
How about move private data to child driver, and one call back
function alloc_host, then child driver could alloc private data,
including clk.

> ?extern struct sdhci_pltfm_data sdhci_cns3xxx_pdata;
>
> ?#endif /* _DRIVERS_MMC_SDHCI_PLTFM_H */
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
