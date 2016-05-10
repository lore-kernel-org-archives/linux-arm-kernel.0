From: adrian.hunter@intel.com (Adrian Hunter)
Date: Tue, 10 May 2016 16:10:38 +0300
Subject: [PATCH 23/23] mmc: sdhci-esdhc-imx: clear tuning bits during
 hwinit
In-Reply-To: <1460741387-23815-24-git-send-email-aisheng.dong@nxp.com>
References: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
 <1460741387-23815-24-git-send-email-aisheng.dong@nxp.com>
Message-ID: <5731DDCE.7020102@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/04/16 20:29, Dong Aisheng wrote:
> The tuning bits like FBCLK_SEL, SMP_CLK_SEL and DLY_CELL which affects
> timing may have already been set by ROM if booting from SD3.0 mode like
> SDR104. Let's clear it first during hw initialization before do the
> new card enumeration.
> 
> For system resume case, it's safe to clear them too since the following
> card re-initialization in mmc_xx_init_card() will do retuning and set
> correct value again.
> 
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 98aa6b5..6a699d1 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1018,6 +1018,11 @@ static void sdhci_esdhc_imx_hwinit(struct sdhci_host *host)
>  			}
>  			writel(tmp, host->ioaddr + ESDHC_TUNING_CTRL);
>  		}
> +
> +		/* clear tuning bits in case ROM has set it already */
> +		writel(0x0, host->ioaddr + ESDHC_MIX_CTRL);
> +		writel(0x0, host->ioaddr + SDHCI_ACMD12_ERR);
> +		writel(0x0, host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
>  	}
>  }
>  
> 
