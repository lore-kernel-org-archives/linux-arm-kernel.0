From: adrian.hunter@intel.com (Adrian Hunter)
Date: Fri, 19 May 2017 09:25:45 +0300
Subject: [PATCH] mmc: sdhci-iproc: suppress spurious interrupt with
 Multiblock read
In-Reply-To: <1495126660-25044-1-git-send-email-srinath.mannam@broadcom.com>
References: <1495126660-25044-1-git-send-email-srinath.mannam@broadcom.com>
Message-ID: <58554ec9-1544-318a-e912-3c5f6ee40e90@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/05/17 19:57, Srinath Mannam wrote:
> The stingray SDHCI hardware supports ACMD12 and automatically
> issues after multi block transfer completed.
> 
> If ACMD12 in SDHCI is disabled, spurious tx done interrupts are seen
> on multi block read command with below error message:
> 
> Got data interrupt 0x00000002 even though no data
> operation was in progress.
> 
> This patch uses SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12 to enable
> ACM12 support in SDHCI hardware and suppress spurious interrupt.
> 
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> 
> diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
> index 3275d49..61666d2 100644
> --- a/drivers/mmc/host/sdhci-iproc.c
> +++ b/drivers/mmc/host/sdhci-iproc.c
> @@ -187,7 +187,8 @@ static const struct sdhci_iproc_data iproc_cygnus_data = {
>  };
>  
>  static const struct sdhci_pltfm_data sdhci_iproc_pltfm_data = {
> -	.quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK,
> +	.quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
> +		  SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
>  	.quirks2 = SDHCI_QUIRK2_ACMD23_BROKEN,
>  	.ops = &sdhci_iproc_ops,
>  };
> 
