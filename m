From: mike@compulab.co.il (Mike Rapoport)
Date: Wed, 25 Nov 2009 17:26:41 +0200
Subject: [PATCH 09/17] ARM: pxa/raumfeld: add NAND partitions
In-Reply-To: <1259145751-3331-10-git-send-email-daniel@caiaq.de>
References: <1259145751-3331-1-git-send-email-daniel@caiaq.de>
	<1259145751-3331-10-git-send-email-daniel@caiaq.de>
Message-ID: <4B0D4CB1.4000608@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Daniel Mack wrote:
> Signed-off-by: Daniel Mack <daniel@caiaq.de>
> ---
>  arch/arm/mach-pxa/raumfeld.c |   36 ++++++++++++++++++++++++++++++++++++
>  1 files changed, 36 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
> index 5d85f98..66b9af1 100644
> --- a/arch/arm/mach-pxa/raumfeld.c
> +++ b/arch/arm/mach-pxa/raumfeld.c
> @@ -37,6 +37,7 @@
>  #include <mach/pxa3xx-regs.h>
>  #include <mach/mfp-pxa3xx.h>
>  #include <mach/mfp-pxa300.h>
> +#include <mach/pxa3xx_nand.h>
>  #include <mach/ohci.h>
>  
>  #include "generic.h"
> @@ -152,6 +153,40 @@ static void __init raumfeld_eth_init(void)
>  }
>  
>  /**
> + * NAND
> + */
> +static struct mtd_partition raumfeld_nand_partitions[] = {
> +	{
> +		.name		= "Bootloader",
> +		.offset		= 0,
> +		.size		= 0xa0000,
> +		.mask_flags	= MTD_WRITEABLE, /* force read-only */
> +	},
> +	{
> +		.name		= "BootloaderEnvironment",
> +		.offset		= 0xa0000,
> +		.size		= 0x20000,
> +	},
> +	{
> +		.name		= "BootloaderSplashScreen",
> +		.offset		= 0xc0000,
> +		.size		= 0x60000,
> +	},
> +	{
> +		.name		= "UBI",
> +		.offset		= 0x120000,
> +		.size		= MTDPART_SIZ_FULL,
> +	},
> +};
> +
> +static struct pxa3xx_nand_platform_data raumfeld_nand_info = {
> +	.enable_arbiter	= 1,
> +	.keep_config	= 1,
> +	.parts		= raumfeld_nand_partitions,
> +	.nr_parts	= ARRAY_SIZE(raumfeld_nand_partitions),
> +};
> +
> +/**
>   * USB (OHCI) support
>   */
>  static struct pxaohci_platform_data raumfeld_ohci_info = {
> @@ -355,6 +390,7 @@ static void __init raumfeld_common_init(void)
>  	pxa3xx_mfp_config(ARRAY_AND_SIZE(raumfeld_pin_config));
>  	pxa_set_ohci_info(&raumfeld_ohci_info);
>  	platform_add_devices(ARRAY_AND_SIZE(raumfeld_common_devices));
> +	pxa3xx_set_nand_info(&raumfeld_nand_info);

Wouldn't it be nicer to group all the pxa_set_* calls together?

>  }
>  
>  static void __init raumfeld_controller_init(void)

-- 
Sincerely yours,
Mike.
