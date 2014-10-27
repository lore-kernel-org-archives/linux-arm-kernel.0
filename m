From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 27 Oct 2014 14:38:28 +0100
Subject: [PATCH RESEND 01/12] mmc: sdhci-pxav2: Drop unused struct
 sdhci_pxa
In-Reply-To: <1413883364-681-2-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1413883364-681-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1413883364-681-2-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <CAPDyKFovdmiD8V3sPjk7_+01wiTwZcaxvjLjvvvS3OhnBZFA0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 October 2014 11:22, Sebastian Hesselbarth
<sebastian.hesselbarth@gmail.com> wrote:
> struct sdhci_pxa is private data of PXA SDHCI driver, but not used in
> sdhci-pxav2 at all. Drop unused references to struct sdhci_pxa.
>
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Thanks! Applied for next!

Kind regards
Uffe

> ---
> Cc: Chris Ball <chris@printf.net>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: "Antoine T?nart" <antoine.tenart@free-electrons.com>
> Cc: linux-mmc at vger.kernel.org
> Cc: devicetree at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  drivers/mmc/host/sdhci-pxav2.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
> index b4c23e983baf..f98008b5ea77 100644
> --- a/drivers/mmc/host/sdhci-pxav2.c
> +++ b/drivers/mmc/host/sdhci-pxav2.c
> @@ -167,23 +167,17 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
>         struct sdhci_pxa_platdata *pdata = pdev->dev.platform_data;
>         struct device *dev = &pdev->dev;
>         struct sdhci_host *host = NULL;
> -       struct sdhci_pxa *pxa = NULL;
>         const struct of_device_id *match;
>
>         int ret;
>         struct clk *clk;
>
> -       pxa = kzalloc(sizeof(struct sdhci_pxa), GFP_KERNEL);
> -       if (!pxa)
> -               return -ENOMEM;
> -
>         host = sdhci_pltfm_init(pdev, NULL, 0);
> -       if (IS_ERR(host)) {
> -               kfree(pxa);
> +       if (IS_ERR(host))
>                 return PTR_ERR(host);
> -       }
> +
>         pltfm_host = sdhci_priv(host);
> -       pltfm_host->priv = pxa;
> +       pltfm_host->priv = NULL;
>
>         clk = clk_get(dev, "PXA-SDHCLK");
>         if (IS_ERR(clk)) {
> @@ -238,7 +232,6 @@ err_add_host:
>         clk_put(clk);
>  err_clk_get:
>         sdhci_pltfm_free(pdev);
> -       kfree(pxa);
>         return ret;
>  }
>
> @@ -246,14 +239,12 @@ static int sdhci_pxav2_remove(struct platform_device *pdev)
>  {
>         struct sdhci_host *host = platform_get_drvdata(pdev);
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> -       struct sdhci_pxa *pxa = pltfm_host->priv;
>
>         sdhci_remove_host(host, 1);
>
>         clk_disable_unprepare(pltfm_host->clk);
>         clk_put(pltfm_host->clk);
>         sdhci_pltfm_free(pdev);
> -       kfree(pxa);
>
>         return 0;
>  }
> --
> 2.1.1
>
