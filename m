From: michael.williamson@criticallink.com (Michael Williamson)
Date: Tue, 07 Feb 2012 11:45:33 -0500
Subject: [PATCH v3 3/3] arm:davinci: move NAND and NOR devices as aemif
 MFD slaves
In-Reply-To: <1328627513-30134-4-git-send-email-prakash.pm@ti.com>
References: <1328627513-30134-1-git-send-email-prakash.pm@ti.com>
 <1328627513-30134-4-git-send-email-prakash.pm@ti.com>
Message-ID: <4F31552D.9060505@criticallink.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Prakash,

On 2/7/2012 10:11 AM, Manjunathappa, Prakash wrote:

> NAND and NOR device are made as aemif device slaves, hence all DaVinci
> board NAND/NOR device registration achieved via aemif MFD driver.
>
> Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
> ---
> Since v2:
> Make changes for all DaVinci boards in single patch.



[...]

> diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
> index 672d820..bb29b7a 100644
> --- a/arch/arm/mach-davinci/board-mityomapl138.c
> +++ b/arch/arm/mach-davinci/board-mityomapl138.c
> @@ -19,6 +19,7 @@
>  #include <linux/etherdevice.h>
>  #include <linux/spi/spi.h>
>  #include <linux/spi/flash.h>
> +#include <linux/mfd/davinci_aemif.h>
>  
>  #include <asm/io.h>
>  #include <asm/mach-types.h>
> @@ -414,18 +415,35 @@ static struct resource mityomapl138_nandflash_resource[] = {
>  	},
>  };
>  
> -static struct platform_device mityomapl138_nandflash_device = {
> -	.name		= "davinci_nand",
> -	.id		= 1,
> -	.dev		= {
> -		.platform_data	= &mityomapl138_nandflash_data,
> +static struct platform_device mityomapl138_emif_devices[] __initdata = {
> +	{
> +		.name		= "davinci_nand",
> +		.id		= 0,



Pretty sure this still needs to be a 1.  The nand is on chip select 3,
EMA_CS3, which I believe is the same as the da850 EVM.

-Mike
