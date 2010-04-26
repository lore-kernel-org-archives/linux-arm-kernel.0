From: daniel@caiaq.de (Daniel Mack)
Date: Mon, 26 Apr 2010 23:05:24 +0200
Subject: [PATCH] pxa/vpac270: add ide support
In-Reply-To: <1272311167-576-1-git-send-email-marek.vasut@gmail.com>
References: <1272311167-576-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <20100426210524.GY30801@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 26, 2010 at 09:46:07PM +0200, Marek Vasut wrote:
> This patch adds support for the on-board IDE channel. I tested this with a CDROM
> connected over 2.5-3.5 IDE reduction with external power supplied to the CDROM.
> This was not tested with the Voipac 270-HDD-000 (official Voipac HDD module),
> but I expect no problems.
> 
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> ---
>  arch/arm/mach-pxa/Kconfig                |    1 +
>  arch/arm/mach-pxa/include/mach/vpac270.h |    2 +
>  arch/arm/mach-pxa/vpac270.c              |   50 ++++++++++++++++++++++++++++++
>  3 files changed, 53 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
> index 12e16b9..5db128c 100644
> --- a/arch/arm/mach-pxa/Kconfig
> +++ b/arch/arm/mach-pxa/Kconfig
> @@ -258,6 +258,7 @@ config MACH_COLIBRI320
>  config MACH_VPAC270
>  	bool "Voipac PXA270"
>  	select PXA27x
> +	select HAVE_PATA_PLATFORM
>  	help
>  	  PXA270 based Single Board Computer.
>  
> diff --git a/arch/arm/mach-pxa/include/mach/vpac270.h b/arch/arm/mach-pxa/include/mach/vpac270.h
> index b90b380..0d82c47 100644
> --- a/arch/arm/mach-pxa/include/mach/vpac270.h
> +++ b/arch/arm/mach-pxa/include/mach/vpac270.h
> @@ -35,4 +35,6 @@
>  
>  #define	GPIO114_VPAC270_ETH_IRQ		114
>  
> +#define	GPIO36_VPAC270_IDE_IRQ		36
> +
>  #endif
> diff --git a/arch/arm/mach-pxa/vpac270.c b/arch/arm/mach-pxa/vpac270.c
> index 0a9647b..6575b8f 100644
> --- a/arch/arm/mach-pxa/vpac270.c
> +++ b/arch/arm/mach-pxa/vpac270.c
> @@ -23,6 +23,7 @@
>  #include <linux/mtd/physmap.h>
>  #include <linux/dm9000.h>
>  #include <linux/ucb1400.h>
> +#include <linux/ata_platform.h>
>  
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
> @@ -138,6 +139,10 @@ static unsigned long vpac270_pin_config[] __initdata = {
>  	/* I2C */
>  	GPIO117_I2C_SCL,
>  	GPIO118_I2C_SDA,
> +
> +	/* IDE */
> +	GPIO36_GPIO,	/* IDE IRQ */
> +	GPIO80_DREQ_1,
>  };
>  
>  /******************************************************************************
> @@ -487,6 +492,50 @@ static inline void vpac270_lcd_init(void) {}
>  #endif
>  
>  /******************************************************************************
> + * PATA IDE
> + ******************************************************************************/
> +#if defined(CONFIG_PATA_PLATFORM) || defined(CONFIG_PATA_PLATFORM_MODULE)
> +static struct pata_platform_info vpac270_pata_pdata = {
> +	.ioport_shift	= 1,
> +	.irq_flags	= IRQF_TRIGGER_RISING,
> +};
> +
> +static struct resource vpac270_ide_resources[] = {
> +	[0] = {	/* I/O Base address */
> +	       .start	= PXA_CS3_PHYS + 0x120,
> +	       .end	= PXA_CS3_PHYS + 0x13f,
> +	       .flags	= IORESOURCE_MEM
> +	},
> +	[1] = {	/* CTL Base address */
> +	       .start	= PXA_CS3_PHYS + 0x15c,
> +	       .end	= PXA_CS3_PHYS + 0x15f,
> +	       .flags	= IORESOURCE_MEM
> +	},
> +	[2] = {	/* IDE IRQ pin */
> +	       .start	= gpio_to_irq(GPIO36_VPAC270_IDE_IRQ),
> +	       .end	= gpio_to_irq(GPIO36_VPAC270_IDE_IRQ),
> +	       .flags	= IORESOURCE_IRQ
> +	}

I think you can rely on the compiler's ability to count the array
members for you :)

Daniel

> +};
> +
> +static struct platform_device vpac270_ide_device = {
> +	.name		= "pata_platform",
> +	.num_resources	= ARRAY_SIZE(vpac270_ide_resources),
> +	.resource	= vpac270_ide_resources,
> +	.dev		= {
> +		.platform_data	= &vpac270_pata_pdata,
> +	}
> +};
> +
> +static void __init vpac270_ide_init(void)
> +{
> +	platform_device_register(&vpac270_ide_device);
> +}
> +#else
> +static inline void vpac270_ide_init(void) {}
> +#endif
> +
> +/******************************************************************************
>   * Machine init
>   ******************************************************************************/
>  static void __init vpac270_init(void)
> @@ -507,6 +556,7 @@ static void __init vpac270_init(void)
>  	vpac270_eth_init();
>  	vpac270_ts_init();
>  	vpac270_rtc_init();
> +	vpac270_ide_init();
>  }
>  
>  MACHINE_START(VPAC270, "Voipac PXA270")
> -- 
> 1.7.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
