From: w.sang@pengutronix.de (Wolfram Sang)
Date: Sun, 19 Jun 2011 09:29:56 +0200
Subject: [V3 PATCH] mmc: Enable the ADMA on esdhc imx driver
In-Reply-To: <1308303678-9338-1-git-send-email-richard.zhu@linaro.org>
References: <1308303678-9338-1-git-send-email-richard.zhu@linaro.org>
Message-ID: <20110619072956.GE1632@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 17, 2011 at 05:41:18PM +0800, Richard Zhu wrote:
> Eanble the ADMA2 mode on freescale esdhc imx driver,
> tested on MX51 and MX53.
> 
> Only ADMA2 mode is enabled, MX25/35 can't support the ADMA2 mode.
> So this patch is only used for MX51/53.
> The ADMA2 mode supported or not can be distinguished by the
> bit20 of Capability Register(offset 0x40) and bit9-8 of HOST PROTOCOL
> Register(offset 0x28) in eSDHC module.

What cards have you tested this patch against?

> 
> Signed-off-by: Richard Zhu <richard.zhu@linaro.org>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c |   43 ++++++++++++++++++++++++++++++++++-
>  1 files changed, 41 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index a19967d..6760e08 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -31,6 +31,14 @@
>  #define SDHCI_VENDOR_SPEC		0xC0
>  #define  SDHCI_VENDOR_SPEC_SDIO_QUIRK	0x00000002
>  
> +/*
> + * There is INT DMA ERR mis-match between eSDHC and STD SDHC SPEC
> + * Bit25 is used in STD SPEC, and is reserved in fsl eSDHC design,
> + * but bit28 is used as the INT DMA ERR in fsl eSDHC design.
> + * Define this macro DMA error INT for fsl eSDHC
> + */
> +#define  SDHCI_INT_VENDOR_SPEC_DMA_ERR	0x10000000
> +
>  #define ESDHC_FLAG_GPIO_FOR_CD_WP	(1 << 0)
>  /*
>   * The CMDTYPE of the CMD register (offset 0xE) should be set to
> @@ -62,6 +70,7 @@ static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct pltfm_imx_data *imx_data = pltfm_host->priv;
> +	u32 dma_mode;
>  
>  	/* fake CARD_PRESENT flag on mx25/35 */
>  	u32 val = readl(host->ioaddr + reg);
> @@ -80,6 +89,28 @@ static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
>  			val |= SDHCI_CARD_PRESENT;
>  	}
>  
> +	if (unlikely(reg == SDHCI_CAPABILITIES)) {
> +		/* Only bit20 is used to indicate the ADMA capability of esdhc,
> +		 * but bit20 is messed up on some SOCs, make a double check
> +		 * on the DMA mode.
> +		 */
> +		dma_mode = readl(host->ioaddr + SDHCI_HOST_CONTROL) >> 5;
> +		dma_mode &= SDHCI_CTRL_DMA_MASK; 
> +
> +		if ((val & SDHCI_CAN_DO_ADMA1)
> +				&& (dma_mode > SDHCI_CTRL_ADMA1)) {
> +			val &= ~SDHCI_CAN_DO_ADMA1;
> +			val |= SDHCI_CAN_DO_ADMA2;
> +		}

The dma_mode in HOST_CONTROL set by sdhci.c depends on the setting in the
CAPABILITIES register, so I wonder how you can have ADMA1 in the CAPS and
dma_mode > ADMA1 in CTRL? Am I missing something?

I also do not understand why you want to set ADMA2 at all on mx25/35. Your
commit-msg says it cannot do ADMA2, so why enabling it? Or is just the caps
register broken?

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110619/b2710592/attachment.sig>
