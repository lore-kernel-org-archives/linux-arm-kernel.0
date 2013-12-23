From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 23 Dec 2013 22:06:15 +0800
Subject: [PATCH 2/2] mmc: sdhci-esdhc-imx: fix warning during module
 remove function
In-Reply-To: <1387796544-18209-2-git-send-email-b29396@freescale.com>
References: <1387796544-18209-1-git-send-email-b29396@freescale.com>
 <1387796544-18209-2-git-send-email-b29396@freescale.com>
Message-ID: <20131223140613.GL26070@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 23, 2013 at 07:02:24PM +0800, Dong Aisheng wrote:
> @@ -1160,8 +1160,6 @@ free_sdhci:
>  static int sdhci_esdhc_imx_remove(struct platform_device *pdev)
>  {
>  	struct sdhci_host *host = platform_get_drvdata(pdev);
> -	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> -	struct pltfm_imx_data *imx_data = pltfm_host->priv;
>  	int dead = (readl(host->ioaddr + SDHCI_INT_STATUS) == 0xffffffff);
>  
>  	sdhci_remove_host(host, dead);
> @@ -1169,10 +1167,6 @@ static int sdhci_esdhc_imx_remove(struct platform_device *pdev)
>  	pm_runtime_dont_use_autosuspend(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
>  
> -	clk_disable_unprepare(imx_data->clk_per);
> -	clk_disable_unprepare(imx_data->clk_ipg);
> -	clk_disable_unprepare(imx_data->clk_ahb);

It's obviously a bad change to me.  We should definitely have these
clk_disable_unprepare() calls in sdhci_esdhc_imx_remove() to match the
clk_prepare_enable() calls in sdhci_esdhc_imx_probe().  Otherwise, at
least for !CONFIG_PM_RUNTIME build, it's broken.

I'm looking at sdhci-pxav3 driver.  Why can it call
clk_disable_unprepare(pltfm_host->clk) in .remove() with runtime PM
support in there?  Is there anything about runtime PM not being done
correctly for our driver?

Shawn

> -
>  	sdhci_pltfm_free(pdev);
>  
>  	return 0;
> -- 
> 1.7.2.rc3
> 
> 
