From: daniel@caiaq.de (Daniel Mack)
Date: Tue, 11 May 2010 10:52:16 +0200
Subject: [PATCH 2/4] pxa/colibri270: Add MMC support
In-Reply-To: <1273544818-22305-2-git-send-email-marek.vasut@gmail.com>
References: <1273544818-22305-1-git-send-email-marek.vasut@gmail.com>
	<1273544818-22305-2-git-send-email-marek.vasut@gmail.com>
Message-ID: <20100511085216.GR30801@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 11, 2010 at 04:26:56AM +0200, Marek Vasut wrote:
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>

The rest of this set also looks ok to me.

For the future, we should think about having a modularized aproach for
these modules just like some mx31 boards have. We would need to split
resources on the module from such on the baseboard, so peope can easily
add support for a custom base board without touching the module code.


Daniel


> ---
>  arch/arm/mach-pxa/colibri-pxa270.c       |   31 ++++++++++++++++++++++++++++++
>  arch/arm/mach-pxa/include/mach/colibri.h |    1 +
>  2 files changed, 32 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/colibri-pxa270.c b/arch/arm/mach-pxa/colibri-pxa270.c
> index 4519e89..5490c5f 100644
> --- a/arch/arm/mach-pxa/colibri-pxa270.c
> +++ b/arch/arm/mach-pxa/colibri-pxa270.c
> @@ -33,6 +33,7 @@
>  
>  #include <mach/pxa27x.h>
>  #include <mach/colibri.h>
> +#include <mach/mmc.h>
>  
>  #include "generic.h"
>  #include "devices.h"
> @@ -44,6 +45,15 @@ static mfp_cfg_t colibri_pxa270_pin_config[] __initdata = {
>  	/* Ethernet */
>  	GPIO78_nCS_2,	/* Ethernet CS */
>  	GPIO114_GPIO,	/* Ethernet IRQ */
> +
> +	/* MMC */
> +	GPIO32_MMC_CLK,
> +	GPIO92_MMC_DAT_0,
> +	GPIO109_MMC_DAT_1,
> +	GPIO110_MMC_DAT_2,
> +	GPIO111_MMC_DAT_3,
> +	GPIO112_MMC_CMD,
> +	GPIO0_GPIO,	/* SD detect */
>  };
>  
>  /******************************************************************************
> @@ -138,6 +148,26 @@ static void __init colibri_pxa270_eth_init(void)
>  static inline void colibri_pxa270_eth_init(void) {}
>  #endif
>  
> +/******************************************************************************
> + * SD/MMC card controller
> + ******************************************************************************/
> +#if defined(CONFIG_MMC_PXA) || defined(CONFIG_MMC_PXA_MODULE)
> +static struct pxamci_platform_data colibri_pxa270_mci_platform_data = {
> +	.ocr_mask		= MMC_VDD_32_33 | MMC_VDD_33_34,
> +	.gpio_power		= -1,
> +	.gpio_card_detect	= GPIO0_COLIBRI_PXA270_SD_DETECT,
> +	.gpio_card_ro		= -1,
> +	.detect_delay_ms	= 200,
> +};
> +
> +static void __init colibri_pxa270_mmc_init(void)
> +{
> +	pxa_set_mci_info(&colibri_pxa270_mci_platform_data);
> +}
> +#else
> +static inline void colibri_pxa270_mmc_init(void) {}
> +#endif
> +
>  static void __init colibri_pxa270_init(void)
>  {
>  	pxa2xx_mfp_config(ARRAY_AND_SIZE(colibri_pxa270_pin_config));
> @@ -147,6 +177,7 @@ static void __init colibri_pxa270_init(void)
>  
>  	colibri_pxa270_nor_init();
>  	colibri_pxa270_eth_init();
> +	colibri_pxa270_mmc_init();
>  }
>  
>  MACHINE_START(COLIBRI, "Toradex Colibri PXA270")
> diff --git a/arch/arm/mach-pxa/include/mach/colibri.h b/arch/arm/mach-pxa/include/mach/colibri.h
> index 0b24a20..08bee63 100644
> --- a/arch/arm/mach-pxa/include/mach/colibri.h
> +++ b/arch/arm/mach-pxa/include/mach/colibri.h
> @@ -34,6 +34,7 @@ static inline void colibri_pxa3xx_init_nand(void) {}
>  
>  /* GPIO definitions for Colibri PXA270 */
>  #define GPIO114_COLIBRI_PXA270_ETH_IRQ	114
> +#define GPIO0_COLIBRI_PXA270_SD_DETECT	0
>  
>  #endif /* _COLIBRI_H_ */
>  
> -- 
> 1.7.0
> 
