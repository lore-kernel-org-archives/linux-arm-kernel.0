From: adrian.hunter@intel.com (Adrian Hunter)
Date: Thu, 21 Jul 2016 11:11:35 +0300
Subject: [PATCH V2 14/15] mmc: sdhci-esdhci-imx: re-initialize hw state
 after resume
In-Reply-To: <1468309584-3591-15-git-send-email-aisheng.dong@nxp.com>
References: <1468309584-3591-1-git-send-email-aisheng.dong@nxp.com>
 <1468309584-3591-15-git-send-email-aisheng.dong@nxp.com>
Message-ID: <579083B7.8060304@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/07/16 10:46, Dong Aisheng wrote:
> sdhci_esdhc_imx_hwinit() includes all basic hw intialization.
> Calling it after resume to re-initialize hw in case its state
> is already lost in low power mode.
> 
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>


Acked-by: Adrian Hunter <adrian.hunter@intel.com>


> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index c5adf4ba4066..e5b5d1c3eb01 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1297,12 +1297,9 @@ static int sdhci_esdhc_suspend(struct device *dev)
>  static int sdhci_esdhc_resume(struct device *dev)
>  {
>  	struct sdhci_host *host = dev_get_drvdata(dev);
> -	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> -	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
>  
> -	/* restore watermark setting in case it's lost in low power mode */
> -	if (esdhc_is_usdhc(imx_data))
> -		writel(ESDHC_WTMK_DEFAULT_VAL, host->ioaddr + ESDHC_WTMK_LVL);
> +	/* re-initialize hw state in case it's lost in low power mode */
> +	sdhci_esdhc_imx_hwinit(host);
>  
>  	return sdhci_pltfm_resume(dev);
>  }
> 
