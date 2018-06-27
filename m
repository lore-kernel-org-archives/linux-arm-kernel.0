From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 27 Jun 2018 15:41:24 +0530
Subject: [PATCH v2 06/13] ARM: davinci: omapl138-hawk: add aemif & nand
 support
In-Reply-To: <20180626092537.6737-7-brgl@bgdev.pl>
References: <20180626092537.6737-1-brgl@bgdev.pl>
 <20180626092537.6737-7-brgl@bgdev.pl>
Message-ID: <11b55553-435b-c363-9194-aebf47302198@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 June 2018 02:55 PM, Bartosz Golaszewski wrote:
>  arch/arm/mach-davinci/board-omapl138-hawk.c | 132 ++++++++++++++++++++
>  1 file changed, 132 insertions(+)
> 
> diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
> index 466e87b24e9a..8d8e3165a45c 100644
> --- a/arch/arm/mach-davinci/board-omapl138-hawk.c
> +++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
> @@ -16,6 +16,11 @@
>  #include <linux/gpio.h>
>  #include <linux/gpio/machine.h>
>  #include <linux/platform_data/gpio-davinci.h>
> +#include <linux/platform_data/ti-aemif.h>
> +#include <linux/mtd/rawnand.h>
> +#include <linux/mtd/partitions.h>

can you keep this (roughly) sorted by moving these above?

> +#include <linux/platform_data/mtd-davinci.h>
> +#include <linux/platform_data/mtd-davinci-aemif.h>
>  #include <linux/regulator/machine.h>
>  
>  #include <asm/mach-types.h>
> @@ -166,6 +171,129 @@ static __init void omapl138_hawk_mmc_init(void)
>  	gpiod_remove_lookup_table(&mmc_gpios_table);
>  }
>  

> +static struct platform_device omapl138_hawk_aemif_devices[] = {
> +	{
> +		.name		= "davinci_nand",
> +		.id		= 1,

This can be -1 now since you got "mtd: rawnand: davinci: stop using
pdev->id as chipselect" merged.

We cannot change for older platforms, but this is fresh support.

> +		.dev		= {
> +			.platform_data	= &omapl138_hawk_nandflash_data,
> +		},
> +		.resource	= omapl138_hawk_nandflash_resource,
> +		.num_resources	= ARRAY_SIZE(omapl138_hawk_nandflash_resource),
> +	}
> +};

Thanks,
Sekhar
