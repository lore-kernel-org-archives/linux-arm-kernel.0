From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 15 Dec 2017 10:17:43 +0100
Subject: [PATCH 3/6 v3] mmc: sdhci-acpi: Handle return value of
 platform_get_irq
In-Reply-To: <ecd11732b6a29aee23a1be94616755e575b0d438.1511066652.git.arvind.yadav.cs@gmail.com>
References: <c1c27676e9f141ace1254b40807bf2dc03f072c6.1511066652.git.arvind.yadav.cs@gmail.com>
 <ecd11732b6a29aee23a1be94616755e575b0d438.1511066652.git.arvind.yadav.cs@gmail.com>
Message-ID: <CAPDyKFp0ODcukUs1-qYA-7OqYNbUHeEAbUMEGveOsjWs6wW8AA@mail.gmail.com>
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
>  drivers/mmc/host/sdhci-acpi.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index b988997..0d9965b 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -566,6 +566,10 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>         host->hw_name   = "ACPI";
>         host->ops       = &sdhci_acpi_ops_dflt;
>         host->irq       = platform_get_irq(pdev, 0);
> +       if (host->irq <= 0) {
> +               err = -EINVAL;
> +               goto err_free;
> +       }
>
>         host->ioaddr = devm_ioremap_nocache(dev, iomem->start,
>                                             resource_size(iomem));
> --
> 2.7.4
>
