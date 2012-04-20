From: richard.zhao@freescale.com (Richard Zhao)
Date: Fri, 20 Apr 2012 10:06:12 +0800
Subject: [PATCH 09/40] mmc sdhc i.MX: do not depend on grouped clocks
In-Reply-To: <1334065553-7565-10-git-send-email-s.hauer@pengutronix.de>
References: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
 <1334065553-7565-10-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20120420020611.GC26682@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 10, 2012 at 03:45:22PM +0200, Sascha Hauer wrote:
> the current i.MX clock support groups together unrelated clocks
> to a single clock which is then used by the driver. This can't
> be accomplished with the generic clock framework so we instead
> request the individual clocks in the driver. For i.MX there are
> generally three different clocks:
> 
> ipg: bus clock (needed to access registers)
> ahb: dma relevant clock, sometimes referred to as hclk in the datasheet
> per: bit clock, pixel clock
> 
> This patch changes the driver to request the individual clocks.
> Currently all clk_get will get the same clock until the SoCs
> are converted to the generic clock framework
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c |   42 ++++++++++++++++++++++++++----------
>  1 file changed, 31 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 6193a0d..938095a 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -69,6 +69,9 @@ struct pltfm_imx_data {
>  	u32 scratchpad;
>  	enum imx_esdhc_type devtype;
>  	struct esdhc_platform_data boarddata;
> +	struct clk *clk_ipg;
> +	struct clk *clk_ahb;
> +	struct clk *clk_per;
>  };
>  
>  static struct platform_device_id imx_esdhc_devtype[] = {
> @@ -437,7 +440,6 @@ static int __devinit sdhci_esdhc_imx_probe(struct platform_device *pdev)
>  	struct sdhci_pltfm_host *pltfm_host;
>  	struct sdhci_host *host;
>  	struct esdhc_platform_data *boarddata;
> -	struct clk *clk;
>  	int err;
>  	struct pltfm_imx_data *imx_data;
>  
> @@ -458,14 +460,29 @@ static int __devinit sdhci_esdhc_imx_probe(struct platform_device *pdev)
>  	imx_data->devtype = pdev->id_entry->driver_data;
>  	pltfm_host->priv = imx_data;
>  
> -	clk = clk_get(mmc_dev(host->mmc), NULL);
> -	if (IS_ERR(clk)) {
> -		dev_err(mmc_dev(host->mmc), "clk err\n");
> -		err = PTR_ERR(clk);
> +	imx_data->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
> +	if (IS_ERR(imx_data->clk_ipg)) {
> +		err = PTR_ERR(imx_data->clk_ipg);
>  		goto err_clk_get;
>  	}
> -	clk_prepare_enable(clk);
> -	pltfm_host->clk = clk;
> +
> +	imx_data->clk_ahb = devm_clk_get(&pdev->dev, "ahb");
> +	if (IS_ERR(imx_data->clk_ahb)) {
> +		err = PTR_ERR(imx_data->clk_ahb);
> +		goto err_clk_get;
> +	}
> +
> +	imx_data->clk_per = devm_clk_get(&pdev->dev, "per");
> +	if (IS_ERR(imx_data->clk_per)) {
> +		err = PTR_ERR(imx_data->clk_per);
> +		goto err_clk_get;
> +	}
> +
> +	pltfm_host->clk = imx_data->clk_per;
> +
> +	clk_prepare_enable(imx_data->clk_per);
> +	clk_prepare_enable(imx_data->clk_ipg);
> +	clk_prepare_enable(imx_data->clk_ahb);
>  
>  	if (!is_imx25_esdhc(imx_data))
>  		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
> @@ -559,8 +576,9 @@ no_card_detect_irq:
>  		gpio_free(boarddata->wp_gpio);
>  no_card_detect_pin:
>  no_board_data:
> -	clk_disable_unprepare(pltfm_host->clk);
> -	clk_put(pltfm_host->clk);
> +	clk_disable_unprepare(imx_data->clk_per);
> +	clk_disable_unprepare(imx_data->clk_ipg);
> +	clk_disable_unprepare(imx_data->clk_ahb);
You forgot to clk_put them.
>  err_clk_get:
>  	kfree(imx_data);
>  err_imx_data:
> @@ -586,8 +604,10 @@ static int __devexit sdhci_esdhc_imx_remove(struct platform_device *pdev)
>  		gpio_free(boarddata->cd_gpio);
>  	}
>  
> -	clk_disable_unprepare(pltfm_host->clk);
> -	clk_put(pltfm_host->clk);
> +	clk_disable_unprepare(imx_data->clk_per);
> +	clk_disable_unprepare(imx_data->clk_ipg);
> +	clk_disable_unprepare(imx_data->clk_ahb);
ditto

Thanks
Richard
> +
>  	kfree(imx_data);
>  
>  	sdhci_pltfm_free(pdev);
> -- 
> 1.7.9.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
