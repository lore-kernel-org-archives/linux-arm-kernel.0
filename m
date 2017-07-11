From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 11 Jul 2017 16:42:50 +0200
Subject: [PATCH] mmc: host: sdhci-st: Handle return value of
 clk_prepare_enable
In-Reply-To: <afbe2d9d649bc78992a72eda7124c093b3055047.1497957783.git.arvind.yadav.cs@gmail.com>
References: <afbe2d9d649bc78992a72eda7124c093b3055047.1497957783.git.arvind.yadav.cs@gmail.com>
Message-ID: <CAPDyKFrxSeZZPWWT7Oo-0XC8iTmyqu_Z4VPhvieVEPBDrhr98Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 June 2017 at 13:57, Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:
> clk_prepare_enable() can fail here and we must check its return value.
>
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-st.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-st.c b/drivers/mmc/host/sdhci-st.c
> index 68c36c9f..198b4ca 100644
> --- a/drivers/mmc/host/sdhci-st.c
> +++ b/drivers/mmc/host/sdhci-st.c
> @@ -394,8 +394,17 @@ static int sdhci_st_probe(struct platform_device *pdev)
>                 goto err_of;
>         }
>
> -       clk_prepare_enable(clk);
> -       clk_prepare_enable(icnclk);
> +       ret = clk_prepare_enable(clk);
> +       if (ret) {
> +               dev_err(&pdev->dev, "Failed to prepare clock\n");
> +               goto err_of;
> +       }
> +
> +       ret = clk_prepare_enable(icnclk);
> +       if (ret) {
> +               dev_err(&pdev->dev, "Failed to prepare icn clock\n");
> +               goto err_icnclk;
> +       }
>
>         /* Configure the FlashSS Top registers for setting eMMC TX/RX delay */
>         res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> @@ -429,6 +438,7 @@ static int sdhci_st_probe(struct platform_device *pdev)
>
>  err_out:
>         clk_disable_unprepare(icnclk);
> +err_icnclk:
>         clk_disable_unprepare(clk);
>  err_of:
>         sdhci_pltfm_free(pdev);
> @@ -487,9 +497,17 @@ static int sdhci_st_resume(struct device *dev)
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct st_mmc_platform_data *pdata = sdhci_pltfm_priv(pltfm_host);
>         struct device_node *np = dev->of_node;
> +       int ret;
> +
> +       ret = clk_prepare_enable(pltfm_host->clk);
> +       if (ret)
> +               return ret;
>
> -       clk_prepare_enable(pltfm_host->clk);
> -       clk_prepare_enable(pdata->icnclk);
> +       ret = clk_prepare_enable(pdata->icnclk);
> +       if (ret) {
> +               clk_disable_unprepare(pltfm_host->clk);
> +               return ret;
> +       }
>
>         if (pdata->rstc)
>                 reset_control_deassert(pdata->rstc);
> --
> 1.9.1
>
