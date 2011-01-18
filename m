From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 18 Jan 2011 19:56:57 +0100
Subject: [PATCH] Board support Pcontrol_G20, hardware revision 2
In-Reply-To: <201101171843.07148.pgsellmann@portner-elektronik.at>
References: <201101171843.07148.pgsellmann@portner-elektronik.at>
Message-ID: <20110118185657.GV14798@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18:43 Mon 17 Jan     , Peter Gsellmann wrote:
>  Backplane timings adjusted
>  Addition of specific platform devices and resources
>  Leds renamed
>  Minor bugfixes
I'd prefer to split the patch for bisect
> 
> this patch should not influence any other hardware
> 
> Signed-off-by: Peter Gsellmann <pgsellmann@portner-elektronik.at>
> ---
>  arch/arm/mach-at91/board-pcontrol-g20.c |  141 ++++++++++++++++++++++++++-----
>  1 files changed, 119 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/board-pcontrol-g20.c b/arch/arm/mach-at91/board-pcontrol-g20.c
> index feb6578..42798af 100644
> --- a/arch/arm/mach-at91/board-pcontrol-g20.c
> +++ b/arch/arm/mach-at91/board-pcontrol-g20.c
> @@ -26,6 +26,10 @@
>  #include <linux/gpio.h>
>  #include <linux/w1-gpio.h>
> 
> +#include <linux/input.h>
> +#include <linux/uio_driver.h>
> +#include <linux/mtd/plat-ram.h>
> +
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
> 
> @@ -60,19 +64,22 @@ static void __init init_irq(void)
>  }
> 
> 
> -static struct sam9_smc_config __initdata pcontrol_smc_config[2] = { {
> -	.ncs_read_setup		= 16,
> -	.nrd_setup		= 18,
> -	.ncs_write_setup	= 16,
> -	.nwe_setup		= 18,
> +/*
> + * Bus timings; unit = 7.57ns
> + */
> +static struct sam9_smc_config __initdata pcontrol_smc_config[] = { {
> +	.ncs_read_setup		= 0,
> +	.nrd_setup		= 8,
> +	.ncs_write_setup	= 0,
> +	.nwe_setup		= 8,
> 
>  	.ncs_read_pulse		= 63,
> -	.nrd_pulse		= 55,
> +	.nrd_pulse		= 45,
>  	.ncs_write_pulse	= 63,
> -	.nwe_pulse		= 55,
> +	.nwe_pulse		= 45,
> 
> -	.read_cycle		= 127,
> -	.write_cycle		= 127,
> +	.read_cycle		= 100,
> +	.write_cycle		= 100,
> 
>  	.mode			= AT91_SMC_READMODE | AT91_SMC_WRITEMODE
>  			| AT91_SMC_EXNWMODE_DISABLE | AT91_SMC_BAT_SELECT
> @@ -100,15 +107,105 @@ static struct sam9_smc_config __initdata pcontrol_smc_config[2] = { {
>  	.tdf_cycles		= 1,
>  } };
> 
> +
> +static struct resource pcontrol_resources[] = {
> +	{
> +		.start	= AT91_CHIPSELECT_4,
> +		.end	= AT91_CHIPSELECT_4 + SZ_256M - 1,
> +		.flags	= IORESOURCE_MEM,
> +	}, {
> +		.start	= AT91_CHIPSELECT_7,
> +		.end	= AT91_CHIPSELECT_7 + SZ_256M - 1,
> +		.flags	= IORESOURCE_MEM,
> +	}, {
> +		.start	= AT91_CHIPSELECT_4,
> +		.end	= AT91_CHIPSELECT_4 + 0x800 - 1,
> +		.name   = "bus51",
> +		.flags	= IORESOURCE_MEM,
> +	}, {
> +		.start	= AT91_CHIPSELECT_4 + 0x800,
> +		.end	= AT91_CHIPSELECT_4 + 0x900 - 1,
> +		.name   = "lcd40x16bw",
> +		.flags	= IORESOURCE_MEM,
> +	}, {
> +		.start	= AT91_CHIPSELECT_4 + 0x900,
> +		.end	= AT91_CHIPSELECT_4 + 0xa00 - 1,
> +		.name   = "kbd6x3+5",
> +		.flags	= IORESOURCE_MEM,
> +	}, {
> +		.start	= AT91_CHIPSELECT_7,
> +		.end	= AT91_CHIPSELECT_7 + SZ_512K - 1,
> +		.name   = "ferroram",
> +		.flags	= IORESOURCE_MEM,
> +	}
export the same memory twice as ressource :(
> +};
> +
Best Regards,
J.
