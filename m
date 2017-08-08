From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 8 Aug 2017 12:38:40 +0200
Subject: [PATCH] mmc: wmt-sdmmc: Handle return value of clk_prepare_enable
In-Reply-To: <0d9fccf8e14a639274115cc43a97804ef059d8b1.1502171094.git.arvind.yadav.cs@gmail.com>
References: <0d9fccf8e14a639274115cc43a97804ef059d8b1.1502171094.git.arvind.yadav.cs@gmail.com>
Message-ID: <CAPDyKFrwMO6QFz0dau4UZZa6p_NqKZGBR0Wzc=ZCGQ1r12RuFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 August 2017 at 07:46, Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:
> clk_prepare_enable() can fail here and we must check its return value.
>
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/wmt-sdmmc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
> index 21ebba8..e64f930 100644
> --- a/drivers/mmc/host/wmt-sdmmc.c
> +++ b/drivers/mmc/host/wmt-sdmmc.c
> @@ -856,7 +856,9 @@ static int wmt_mci_probe(struct platform_device *pdev)
>                 goto fail5;
>         }
>
> -       clk_prepare_enable(priv->clk_sdmmc);
> +       ret = clk_prepare_enable(priv->clk_sdmmc);
> +       if (ret)
> +               goto fail6;
>
>         /* configure the controller to a known 'ready' state */
>         wmt_reset_hardware(mmc);
> @@ -866,6 +868,8 @@ static int wmt_mci_probe(struct platform_device *pdev)
>         dev_info(&pdev->dev, "WMT SDHC Controller initialized\n");
>
>         return 0;
> +fail6:
> +       clk_put(priv->clk_sdmmc);
>  fail5:
>         free_irq(dma_irq, priv);
>  fail4:
> --
> 1.9.1
>
