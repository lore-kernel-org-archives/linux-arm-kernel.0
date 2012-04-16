From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 16 Apr 2012 18:47:35 +0200
Subject: [PATCH v2 3/3] AT91: Add machine files for AT91SAM9N12 SoC
In-Reply-To: <1334569167-7064-4-git-send-email-hong.xu@atmel.com>
References: <1334569167-7064-1-git-send-email-hong.xu@atmel.com>
 <1334569167-7064-4-git-send-email-hong.xu@atmel.com>
Message-ID: <4F8C4D27.4090204@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/16/2012 11:39 AM, Hong Xu :
> Signed-off-by: Hong Xu <hong.xu@atmel.com>
> ---
> Changes since v1,
> * Added DT entry in Makefile.boot
> * Removed board compatibility string (AT91 will use a generic name)
> 
>  arch/arm/mach-at91/Kconfig       |    9 ++
>  arch/arm/mach-at91/Makefile      |    1 +
>  arch/arm/mach-at91/Makefile.boot |    2 +
>  arch/arm/mach-at91/at91sam9n12.c |  275 ++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-at91/clock.c       |   15 ++-
>  arch/arm/mach-at91/setup.c       |    6 +
>  6 files changed, 303 insertions(+), 5 deletions(-)
>  create mode 100644 arch/arm/mach-at91/at91sam9n12.c
> 
> diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
> index 45db05d..8fc8fb4 100644
> --- a/arch/arm/mach-at91/Kconfig
> +++ b/arch/arm/mach-at91/Kconfig
> @@ -105,6 +105,15 @@ config ARCH_AT91SAM9X5
>  	select HAVE_NET_MACB
>  	select HAVE_AT91_DBGU0
>  
> +config ARCH_AT91SAM9N12
> +	bool "AT91SAM9N12 SoC"
> +	select CPU_ARM926T
> +	select GENERIC_CLOCKEVENTS
> +	select HAVE_FB_ATMEL
> +	select HAVE_AT91_DBGU0
> +	help
> +	  Select this if you are using Atmel's AT91SAM9N12 SoC.
> +
>  config ARCH_AT91X40
>  	bool "AT91x40"
>  	select ARCH_USES_GETTIMEOFFSET
> diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
> index 8512e53..7ab5f5f 100644
> --- a/arch/arm/mach-at91/Makefile
> +++ b/arch/arm/mach-at91/Makefile
> @@ -21,6 +21,7 @@ obj-$(CONFIG_ARCH_AT91SAM9RL)	+= at91sam9rl.o at91sam926x_time.o at91sam9rl_devi
>  obj-$(CONFIG_ARCH_AT91SAM9G20)	+= at91sam9260.o at91sam926x_time.o at91sam9260_devices.o sam9_smc.o
>  obj-$(CONFIG_ARCH_AT91SAM9G45)	+= at91sam9g45.o at91sam926x_time.o at91sam9g45_devices.o sam9_smc.o
>  obj-$(CONFIG_ARCH_AT91SAM9X5)	+= at91sam9x5.o at91sam926x_time.o sam9_smc.o
> +obj-$(CONFIG_ARCH_AT91SAM9N12)	+= at91sam9n12.o at91sam926x_time.o sam9_smc.o
>  obj-$(CONFIG_ARCH_AT91X40)	+= at91x40.o at91x40_time.o
>  
>  # AT91RM9200 board-specific support
> diff --git a/arch/arm/mach-at91/Makefile.boot b/arch/arm/mach-at91/Makefile.boot
> index 0da66ca..29b6cfe 100644
> --- a/arch/arm/mach-at91/Makefile.boot
> +++ b/arch/arm/mach-at91/Makefile.boot
> @@ -20,3 +20,5 @@ dtb-$(CONFIG_MACH_AT91SAM_DT) += usb_a9g20.dtb
>  dtb-$(CONFIG_MACH_AT91SAM_DT) += at91sam9m10g45ek.dtb
>  # sam9x5
>  dtb-$(CONFIG_MACH_AT91SAM_DT) += at91sam9g25ek.dtb
> +# sam9n12
> +dtb-$(CONFIG_MACH_AT91SAM_DT) += at91sam9n12ek.dtb
> diff --git a/arch/arm/mach-at91/at91sam9n12.c b/arch/arm/mach-at91/at91sam9n12.c
> new file mode 100644
> index 0000000..5187b95
> --- /dev/null
> +++ b/arch/arm/mach-at91/at91sam9n12.c
> @@ -0,0 +1,275 @@
> +/*
> + * SoC specific setup code for the AT91SAM9N12
> + *
> + * Copyright (C) 2012 Atmel Corporation.
> + *
> + * Licensed under GPLv2 or later.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/dma-mapping.h>
> +
> +#include <asm/irq.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach/map.h>
> +#include <mach/at91sam9n12.h>
> +#include <mach/at91_pmc.h>
> +#include <mach/cpu.h>
> +#include <mach/board.h>
> +
> +#include "soc.h"
> +#include "generic.h"
> +#include "clock.h"
> +#include "sam9_smc.h"
> +
> +/* --------------------------------------------------------------------
> + *  Clocks
> + * -------------------------------------------------------------------- */
> +
> +/*
> + * The peripheral clocks.
> + */
> +static struct clk pioAB_clk = {
> +	.name		= "pioAB_clk",
> +	.pmc_mask	= 1 << AT91SAM9N12_ID_PIOAB,
> +	.type		= CLK_TYPE_PERIPHERAL,
> +};
> +static struct clk pioCD_clk = {
> +	.name		= "pioCD_clk",
> +	.pmc_mask	= 1 << AT91SAM9N12_ID_PIOCD,
> +	.type		= CLK_TYPE_PERIPHERAL,
> +};
> +static struct clk usart0_clk = {
> +	.name		= "usart0_clk",
> +	.pmc_mask	= 1 << AT91SAM9N12_ID_USART0,
> +	.type		= CLK_TYPE_PERIPHERAL,
> +};
> +static struct clk usart1_clk = {
> +	.name		= "usart1_clk",
> +	.pmc_mask	= 1 << AT91SAM9N12_ID_USART1,
> +	.type		= CLK_TYPE_PERIPHERAL,
> +};
> +static struct clk usart2_clk = {
> +	.name		= "usart2_clk",
> +	.pmc_mask	= 1 << AT91SAM9N12_ID_USART2,
> +	.type		= CLK_TYPE_PERIPHERAL,
> +};
> +static struct clk usart3_clk = {
> +	.name		= "usart3_clk",
> +	.pmc_mask	= 1 << AT91SAM9N12_ID_USART3,
> +	.type		= CLK_TYPE_PERIPHERAL,
> +};
> +static struct clk twi0_clk = {
> +	.name		= "twi0_clk",
> +	.pmc_mask	= 1 << AT91SAM9N12_ID_TWI0,
> +	.type		= CLK_TYPE_PERIPHERAL,
> +};
> +static struct clk twi1_clk = {
> +	.name		= "twi1_clk",
> +	.pmc_mask	= 1 << AT91SAM9N12_ID_TWI1,
> +	.type		= CLK_TYPE_PERIPHERAL,
> +};
> +static struct clk mmc_clk = {
> +	.name		= "mci_clk",
> +	.pmc_mask	= 1 << AT91SAM9N12_ID_MCI,
> +	.type		= CLK_TYPE_PERIPHERAL,
> +};
> +static struct clk spi0_clk = {
> +	.name		= "spi0_clk",
> +	.pmc_mask	= 1 << AT91SAM9N12_ID_SPI0,
> +	.type		= CLK_TYPE_PERIPHERAL,
> +};
> +static struct clk spi1_clk = {
> +	.name		= "spi1_clk",
> +	.pmc_mask	= 1 << AT91SAM9N12_ID_SPI1,
> +	.type		= CLK_TYPE_PERIPHERAL,
> +};
> +static struct clk uart0_clk = {
> +	.name		= "uart0_clk",
> +	.pmc_mask	= 1 << AT91SAM9N12_ID_UART0,
> +	.type		= CLK_TYPE_PERIPHERAL,
> +};
> +static struct clk uart1_clk = {
> +	.name		= "uart1_clk",
> +	.pmc_mask	= 1 << AT91SAM9N12_ID_UART1,
> +	.type		= CLK_TYPE_PERIPHERAL,
> +};
> +static struct clk tcb_clk = {
> +	.name		= "tcb_clk",
> +	.pmc_mask	= 1 << AT91SAM9N12_ID_TCB,
> +	.type		= CLK_TYPE_PERIPHERAL,
> +};
> +static struct clk pwm_clk = {
> +	.name		= "pwm_clk",
> +	.pmc_mask	= 1 << AT91SAM9N12_ID_PWM,
> +	.type		= CLK_TYPE_PERIPHERAL,
> +};
> +static struct clk adc_clk = {
> +	.name		= "adc_clk",
> +	.pmc_mask	= 1 << AT91SAM9N12_ID_ADC,
> +	.type	= CLK_TYPE_PERIPHERAL,
> +};
> +static struct clk dma_clk = {
> +	.name		= "dma_clk",
> +	.pmc_mask	= 1 << AT91SAM9N12_ID_DMA,
> +	.type	= CLK_TYPE_PERIPHERAL,
> +};
> +static struct clk uhp_clk = {
> +	.name		= "uhp",
> +	.pmc_mask	= 1 << AT91SAM9N12_ID_UHP,
> +	.type		= CLK_TYPE_PERIPHERAL,
> +};
> +static struct clk udp_clk = {
> +	.name		= "udp_clk",
> +	.pmc_mask	= 1 << AT91SAM9N12_ID_UDP,
> +	.type		= CLK_TYPE_PERIPHERAL,
> +};
> +static struct clk lcdc_clk = {
> +	.name		= "lcdc_clk",
> +	.pmc_mask	= 1 << AT91SAM9N12_ID_LCDC,
> +	.type		= CLK_TYPE_PERIPHERAL,
> +};
> +static struct clk ssc_clk = {
> +	.name		= "ssc_clk",
> +	.pmc_mask	= 1 << AT91SAM9N12_ID_SSC,
> +	.type		= CLK_TYPE_PERIPHERAL,
> +};
> +
> +static struct clk *periph_clocks[] __initdata = {
> +	&pioAB_clk,
> +	&pioCD_clk,
> +	&usart0_clk,
> +	&usart1_clk,
> +	&usart2_clk,
> +	&usart3_clk,
> +	&twi0_clk,
> +	&twi1_clk,
> +	&mmc_clk,
> +	&spi0_clk,
> +	&spi1_clk,
> +	&lcdc_clk,
> +	&uart0_clk,
> +	&uart1_clk,
> +	&tcb_clk,
> +	&pwm_clk,
> +	&adc_clk,
> +	&dma_clk,
> +	&uhp_clk,
> +	&udp_clk,
> +	&ssc_clk,
> +};
> +
> +static struct clk_lookup periph_clocks_lookups[] = {
> +	/* lookup table for DT entries */
> +	CLKDEV_CON_DEV_ID("usart", "fffff200.serial", &mck),
> +	CLKDEV_CON_DEV_ID("usart", "f801c000.serial", &usart0_clk),
> +	CLKDEV_CON_DEV_ID("usart", "f8020000.serial", &usart1_clk),
> +	CLKDEV_CON_DEV_ID("usart", "f8024000.serial", &usart2_clk),
> +	CLKDEV_CON_DEV_ID("usart", "f8028000.serial", &usart3_clk),
> +	CLKDEV_CON_DEV_ID("t0_clk", "f8008000.timer", &tcb_clk),
> +	CLKDEV_CON_DEV_ID("t0_clk", "f800c000.timer", &tcb_clk),
> +	CLKDEV_CON_DEV_ID("dma_clk", "ffffec00.dma-controller", &dma_clk),
> +	CLKDEV_CON_ID("pioA", &pioAB_clk),
> +	CLKDEV_CON_ID("pioB", &pioAB_clk),
> +	CLKDEV_CON_ID("pioC", &pioCD_clk),
> +	CLKDEV_CON_ID("pioD", &pioCD_clk),
> +	/* additional fake clock for macb_hclk */
> +	CLKDEV_CON_DEV_ID("hclk", "500000.ohci", &uhp_clk),
> +	CLKDEV_CON_DEV_ID("ohci_clk", "500000.ohci", &uhp_clk),
> +};
> +
> +/*
> + * The two programmable clocks.
> + * You must configure pin multiplexing to bring these signals out.
> + */
> +static struct clk pck0 = {
> +	.name		= "pck0",
> +	.pmc_mask	= AT91_PMC_PCK0,
> +	.type		= CLK_TYPE_PROGRAMMABLE,
> +	.id		= 0,
> +};
> +static struct clk pck1 = {
> +	.name		= "pck1",
> +	.pmc_mask	= AT91_PMC_PCK1,
> +	.type		= CLK_TYPE_PROGRAMMABLE,
> +	.id		= 1,
> +};
> +
> +static void __init at91sam9n12_register_clocks(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(periph_clocks); i++)
> +		clk_register(periph_clocks[i]);
> +	clk_register(&pck0);
> +	clk_register(&pck1);
> +
> +	clkdev_add_table(periph_clocks_lookups,
> +			 ARRAY_SIZE(periph_clocks_lookups));
> +
> +}
> +
> +/* --------------------------------------------------------------------
> + *  AT91SAM9N12 processor initialization
> + * -------------------------------------------------------------------- */
> +
> +static void __init at91sam9n12_map_io(void)
> +{
> +	at91_init_sram(0, AT91SAM9N12_SRAM_BASE, AT91SAM9N12_SRAM_SIZE);
> +}
> +
> +void __init at91sam9n12_initialize(void)
> +{
> +	at91_extern_irq = (1 << AT91SAM9N12_ID_IRQ0);
> +
> +	/* Register GPIO subsystem (using DT) */
> +	at91_gpio_init(NULL, 0);
> +}
> +
> +/* --------------------------------------------------------------------
> + *  Interrupt initialization
> + * -------------------------------------------------------------------- */
> +/*
> + * The default interrupt priority levels (0 = lowest, 7 = highest).
> + */
> +static unsigned int at91sam9n12_default_irq_priority[NR_AIC_IRQS] __initdata = {
> +	7,	/* 00: Advanced Interrupt Controller (FIQ) */
> +	7,	/* 01: System Peripherals */
> +	1,	/* 02: Parallel IO Controller A and B */
> +	1,	/* 03: Parallel IO Controller C and D */
> +	4,	/* 04: FUSE Controller */
> +	5,	/* 05: USART 0 */
> +	5,	/* 06: USART 1 */
> +	5,	/* 07: USART 2 */
> +	5,	/* 08: USART 3 */
> +	6,	/* 09: Two-Wire Interface 0 */
> +	6,	/* 10: Two-Wire Interface 1 */
> +	0,	/* 11: Reserved */
> +	0,	/* 12: Multimedia Card Interface */
> +	5,	/* 13: Serial Peripheral Interface 0 */
> +	5,	/* 14: Serial Peripheral Interface 1 */
> +	5,	/* 15: UART 0 */
> +	5,	/* 16: UART 1 */
> +	0,	/* 17: Timer Counter 0, 1, 2, 3, 4 and 5 */
> +	0,	/* 18: Pulse Width Modulation Controller */
> +	0,	/* 19: ADC Controller */
> +	0,	/* 20: DMA Controller */
> +	0,	/* 21: Reserved */
> +	2,	/* 22: USB Host High Speed port */
> +	2,	/* 23: USB Device High speed port */
> +	3,	/* 24: Reserved */
> +	3,	/* 25: LDC Controller or Image Sensor Interface */
> +	0,	/* 26: Reserved */
> +	3,	/* 27: Reserved */
> +	4,	/* 28: Synchronous Serial Controller */
> +	4,	/* 29: Reserved */
> +	4,	/* 30: TRNG */
> +	0,	/* 31: Advanced Interrupt Controller (IRQ0) */
> +};

You can remove this table: we will have to give default IRQ priority
using the DT: WIP...
DT only AIC is not taking this into account.

> +
> +struct at91_init_soc __initdata at91sam9n12_soc = {
> +	.map_io = at91sam9n12_map_io,
> +	.default_irq_priority = at91sam9n12_default_irq_priority,

So, here you can remove the .default_irq_priority line.


> +	.register_clocks = at91sam9n12_register_clocks,
> +	.init = at91sam9n12_initialize,
> +};
> diff --git a/arch/arm/mach-at91/clock.c b/arch/arm/mach-at91/clock.c
> index a0f4d74..46130da 100644
> --- a/arch/arm/mach-at91/clock.c
> +++ b/arch/arm/mach-at91/clock.c
> @@ -57,13 +57,15 @@ void __iomem *at91_pmc_base;
>  
>  #define cpu_has_800M_plla()	(  cpu_is_at91sam9g20() \
>  				|| cpu_is_at91sam9g45() \
> -				|| cpu_is_at91sam9x5())
> +				|| cpu_is_at91sam9x5() \
> +				|| cpu_is_at91sam9n12())
>  
>  #define cpu_has_300M_plla()	(cpu_is_at91sam9g10())
>  
>  #define cpu_has_pllb()		(!(cpu_is_at91sam9rl() \
>  				|| cpu_is_at91sam9g45() \
> -				|| cpu_is_at91sam9x5()))
> +				|| cpu_is_at91sam9x5() \
> +				|| cpu_is_at91sam9n12()))
>  
>  #define cpu_has_upll()		(cpu_is_at91sam9g45() \
>  				|| cpu_is_at91sam9x5())
> @@ -77,12 +79,15 @@ void __iomem *at91_pmc_base;
>  				|| cpu_is_at91sam9x5()))
>  
>  #define cpu_has_plladiv2()	(cpu_is_at91sam9g45() \
> -				|| cpu_is_at91sam9x5())
> +				|| cpu_is_at91sam9x5() \
> +				|| cpu_is_at91sam9n12())
>  
>  #define cpu_has_mdiv3()		(cpu_is_at91sam9g45() \
> -				|| cpu_is_at91sam9x5())
> +				|| cpu_is_at91sam9x5() \
> +				|| cpu_is_at91sam9n12())
>  
> -#define cpu_has_alt_prescaler()	(cpu_is_at91sam9x5())
> +#define cpu_has_alt_prescaler()	(cpu_is_at91sam9x5() \
> +				|| cpu_is_at91sam9n12())
>  
>  static LIST_HEAD(clocks);
>  static DEFINE_SPINLOCK(clk_lock);
> diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
> index 97cc04d..34c9c27 100644
> --- a/arch/arm/mach-at91/setup.c
> +++ b/arch/arm/mach-at91/setup.c
> @@ -142,6 +142,11 @@ static void __init soc_detect(u32 dbgu_base)
>  		at91_soc_initdata.type = AT91_SOC_SAM9X5;
>  		at91_boot_soc = at91sam9x5_soc;
>  		break;
> +
> +	case ARCH_ID_AT91SAM9N12:
> +		at91_soc_initdata.type = AT91_SOC_SAM9N12;
> +		at91_boot_soc = at91sam9n12_soc;
> +		break;
>  	}
>  
>  	/* at91sam9g10 */
> @@ -209,6 +214,7 @@ static const char *soc_name[] = {
>  	[AT91_SOC_SAM9G45]	= "at91sam9g45",
>  	[AT91_SOC_SAM9RL]	= "at91sam9rl",
>  	[AT91_SOC_SAM9X5]	= "at91sam9x5",
> +	[AT91_SOC_SAM9N12]	= "at91sam9n12",
>  	[AT91_SOC_NONE]		= "Unknown"
>  };
>  


-- 
Nicolas Ferre
