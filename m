From: pma@sysgo.com (Pavel Machek)
Date: Thu, 16 Jun 2011 13:51:33 +0200
Subject: [PATCH V2] mmc: Enable the ADMA on esdhc imx driver
In-Reply-To: <20110615082223.GA28798@atrey.karlin.mff.cuni.cz>
References: <20110615082223.GA28798@atrey.karlin.mff.cuni.cz>
Message-ID: <20110616115133.GC31375@pma.sysgo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> Eanble the ADMA2 mode on freescale esdhc imx driver,
> tested on MX51 and MX53.
> 
> Only ADMA2 mode is enabled, MX25/35 can't support the ADMA2 mode.
> So this patch is only used for MX51/53.
> The ADMA2 mode supported or not can be distinguished by the
> Capability Register(offset 0x40) of eSDHC module.
> Up to now, only MX51/MX53 set the ADMA2 supported bit(Bit20) in the
> Capability Register.

I tried it on mx25 (3-stack), and it unfortunately breaks things:

...
mmc0: unrecognised SCR structure version 12
mmc0: error -22 whilst initialising SD card
...

It may be interfering with my changs, but... 

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
> @@ -80,6 +88,20 @@ static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
>  			val |= SDHCI_CARD_PRESENT;
>  	}
>  
> +	if (unlikely(reg == SDHCI_CAPABILITIES)) {
> +		if (val & SDHCI_CAN_DO_ADMA1) {
> +			val &= ~SDHCI_CAN_DO_ADMA1;
> +			val |= SDHCI_CAN_DO_ADMA2;
> +		}
> +	}
> +
> +	if (unlikely(reg == SDHCI_INT_STATUS)) {
> +		if (val & SDHCI_INT_VENDOR_SPEC_DMA_ERR) {
> +			val &= ~SDHCI_INT_VENDOR_SPEC_DMA_ERR;
> +			val |= SDHCI_INT_ADMA_ERROR;
> +		}
> +	}
> +
>  	return val;
>  }
>

Unfortunately register differences are common. Is there better
approach than patching it in low level functions like this?

> @@ -322,9 +351,10 @@ static void esdhc_pltfm_exit(struct sdhci_host *host)
>  }
>  
>  struct sdhci_pltfm_data sdhci_esdhc_imx_pdata = {
> -	.quirks = ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_BROKEN_ADMA
> +	.quirks = ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_NO_HISPD_BIT
> +			| SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC
> +			| SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC
>  			| SDHCI_QUIRK_BROKEN_CARD_DETECTION,

If I re-add "SDHCI_QUIRK_BROKEN_ADMA", it starts working.

								Pavel
