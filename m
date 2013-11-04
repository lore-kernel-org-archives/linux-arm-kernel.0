From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 4 Nov 2013 14:11:02 +0100
Subject: [PATCH v2 5/5] mmc: sdhci-esdhc-imx: add runtime pm support
In-Reply-To: <1383554309-29065-6-git-send-email-b29396@freescale.com>
References: <1383554309-29065-1-git-send-email-b29396@freescale.com>
 <1383554309-29065-6-git-send-email-b29396@freescale.com>
Message-ID: <CAPDyKFpWwCM5kFCHb=bi-X0rgf56fh8_JMSFrwobUVj=X5vS0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 November 2013 09:38, Dong Aisheng <b29396@freescale.com> wrote:
> The root clock will be disabled in runtime pm which can be used to save power.
>
> Signed-off-by: Dong Aisheng <b29396@freescale.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c |   49 +++++++++++++++++++++++++++++++++++-
>  1 files changed, 48 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index da8026b..6e64981 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -27,6 +27,7 @@
>  #include <linux/of_gpio.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/platform_data/mmc-esdhc-imx.h>
> +#include <linux/pm_runtime.h>
>  #include "sdhci-pltfm.h"
>  #include "sdhci-esdhc.h"
>
> @@ -1121,6 +1122,12 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>         if (err)
>                 goto disable_clk;
>
> +       pm_runtime_set_active(&pdev->dev);
> +       pm_runtime_enable(&pdev->dev);
> +       pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
> +       pm_runtime_use_autosuspend(&pdev->dev);
> +       pm_suspend_ignore_children(&pdev->dev, 1);
> +
>         return 0;
>
>  disable_clk:
> @@ -1141,6 +1148,9 @@ static int sdhci_esdhc_imx_remove(struct platform_device *pdev)
>
>         sdhci_remove_host(host, dead);
>
> +       pm_runtime_dont_use_autosuspend(&pdev->dev);
> +       pm_runtime_disable(&pdev->dev);
> +
>         clk_disable_unprepare(imx_data->clk_per);
>         clk_disable_unprepare(imx_data->clk_ipg);
>         clk_disable_unprepare(imx_data->clk_ahb);
> @@ -1150,12 +1160,49 @@ static int sdhci_esdhc_imx_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> +#ifdef CONFIG_PM_RUNTIME
> +static int sdhci_esdhc_runtime_suspend(struct device *dev)
> +{
> +       struct sdhci_host *host = dev_get_drvdata(dev);
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct pltfm_imx_data *imx_data = pltfm_host->priv;
> +       int ret;
> +
> +       ret = sdhci_runtime_suspend_host(host);
> +
> +       clk_disable_unprepare(imx_data->clk_per);
> +       clk_disable_unprepare(imx_data->clk_ipg);
> +       clk_disable_unprepare(imx_data->clk_ahb);
> +
> +       return ret;
> +}
> +
> +static int sdhci_esdhc_runtime_resume(struct device *dev)
> +{
> +       struct sdhci_host *host = dev_get_drvdata(dev);
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct pltfm_imx_data *imx_data = pltfm_host->priv;
> +
> +       clk_prepare_enable(imx_data->clk_per);
> +       clk_prepare_enable(imx_data->clk_ipg);
> +       clk_prepare_enable(imx_data->clk_ahb);
> +
> +       return sdhci_runtime_resume_host(host);
> +}
> +#endif
> +
> +static const struct dev_pm_ops sdhci_esdhc_pmops = {
> +       SET_SYSTEM_SLEEP_PM_OPS(sdhci_pltfm_suspend, sdhci_pltfm_resume)
> +       SET_RUNTIME_PM_OPS(sdhci_esdhc_runtime_suspend,
> +                               sdhci_esdhc_runtime_resume, NULL)
> +};
> +
>  static struct platform_driver sdhci_esdhc_imx_driver = {
>         .driver         = {
>                 .name   = "sdhci-esdhc-imx",
>                 .owner  = THIS_MODULE,
>                 .of_match_table = imx_esdhc_dt_ids,
> -               .pm     = SDHCI_PLTFM_PMOPS,
> +               .pm     = &sdhci_esdhc_pmops,
>         },
>         .id_table       = imx_esdhc_devtype,
>         .probe          = sdhci_esdhc_imx_probe,
> --
> 1.7.2.rc3
>
>
