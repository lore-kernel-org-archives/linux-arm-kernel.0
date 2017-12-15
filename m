From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 15 Dec 2017 10:17:57 +0100
Subject: [PATCH 4/6 v3] mmc: sdhci-spear: Handle return value of
 platform_get_irq
In-Reply-To: <23382b551ade00543aadc588aa74b0648958b907.1511066652.git.arvind.yadav.cs@gmail.com>
References: <c1c27676e9f141ace1254b40807bf2dc03f072c6.1511066652.git.arvind.yadav.cs@gmail.com>
 <23382b551ade00543aadc588aa74b0648958b907.1511066652.git.arvind.yadav.cs@gmail.com>
Message-ID: <CAPDyKFrGUniA53p=mDtLwSGXZKK-fihnJn_wcPuZkDAzWLTh_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 November 2017 at 05:52, Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:
> platform_get_irq() can fail here and we must check its return value.
>
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
> changes in v2 :
>               Add failure case '<= 0' instead of '< 0'. IRQ0 is not valid.
> changes in v3 :
>               return -EINVAL instead of host->irq.
>
>  drivers/mmc/host/sdhci-spear.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
> index 8c0f884..e04485e 100644
> --- a/drivers/mmc/host/sdhci-spear.c
> +++ b/drivers/mmc/host/sdhci-spear.c
> @@ -82,6 +82,10 @@ static int sdhci_probe(struct platform_device *pdev)
>         host->hw_name = "sdhci";
>         host->ops = &sdhci_pltfm_ops;
>         host->irq = platform_get_irq(pdev, 0);
> +       if (host->irq <= 0) {
> +               ret = -EINVAL;
> +               goto err_host;
> +       }
>         host->quirks = SDHCI_QUIRK_BROKEN_ADMA;
>
>         sdhci = sdhci_priv(host);
> --
> 2.7.4
>
