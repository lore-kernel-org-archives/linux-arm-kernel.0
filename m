From: mike@compulab.co.il (Mike Rapoport)
Date: Wed, 10 Mar 2010 08:18:40 +0200
Subject: [PATCH] Voipac PXA270
In-Reply-To: <201003100247.27059.marek.vasut@gmail.com>
References: <201003100247.27059.marek.vasut@gmail.com>
Message-ID: <4B9739C0.2090805@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

Marek Vasut wrote:
> Hi
> 
> This patch adds basic support for the Voipac PXA270 SBC.
> The device consists of the following hardware:
> - PXA270 @ 520 MHz
> - 256MB RAM (sparsemem, 2*128MB regions)
> - 64MB NOR flash
> - 640x480 LCD
> - Ports: 2xUHC, 1xUDC, 1xPCMCIA, VGA, FFUART, 2xPS2, Speaker, MIC
> 
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>

The patch looks good to me. Some nitpicking though :)

> From c2c517d966726c570a3a4fa6d7df029df4bac481 Mon Sep 17 00:00:00 2001
> From: Marek <marek.vasut@gmail.com>
> Date: Tue, 9 Mar 2010 04:04:12 +0100
> Subject: [PATCH] Voipac PXA270
> 
> This patch adds basic support for the Voipac PXA270 SBC.
> The device consists of the following hardware:
> - PXA270 @ 520 MHz
> - 256MB RAM (sparsemem, 2*128MB regions)
> - 64MB NOR flash
> - 640x480 LCD
> - Ports: 2xUHC, 1xUDC, 1xPCMCIA, VGA, FFUART, 2xPS2, Speaker, MIC
> 
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> ---
>  arch/arm/mach-pxa/Kconfig                |    6 +
>  arch/arm/mach-pxa/Makefile               |    1 +
>  arch/arm/mach-pxa/include/mach/vpac270.h |   26 +++
>  arch/arm/mach-pxa/vpac270.c              |  306 ++++++++++++++++++++++++++++++
>  4 files changed, 339 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-pxa/include/mach/vpac270.h
>  create mode 100644 arch/arm/mach-pxa/vpac270.c
> 
> diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
> index bf852b0..dc871aa 100644
> --- a/arch/arm/mach-pxa/Kconfig
> +++ b/arch/arm/mach-pxa/Kconfig
> @@ -255,6 +255,12 @@ config MACH_COLIBRI320
>  	select PXA3xx
>  	select CPU_PXA320
>  
> +config MACH_VPAC270
> +	bool "Voipac PXA270"
> +	select PXA27x
> +	help
> +	  PXA270 based Single Board Computer.
> +
>  comment "End-user Products (sorted by vendor name)"
>  
>  config MACH_H4700
> diff --git a/arch/arm/mach-pxa/Makefile b/arch/arm/mach-pxa/Makefile
> index c53397e..042bc54 100644
> --- a/arch/arm/mach-pxa/Makefile
> +++ b/arch/arm/mach-pxa/Makefile
> @@ -62,6 +62,7 @@ obj-$(CONFIG_MACH_PCM990_BASEBOARD)	+= pcm990-baseboard.o
>  obj-$(CONFIG_MACH_COLIBRI)	+= colibri-pxa270.o
>  obj-$(CONFIG_MACH_COLIBRI300)	+= colibri-pxa3xx.o colibri-pxa300.o
>  obj-$(CONFIG_MACH_COLIBRI320)	+= colibri-pxa3xx.o colibri-pxa320.o
> +obj-$(CONFIG_MACH_VPAC270)	+= vpac270.o
>  
>  # End-user Products
>  obj-$(CONFIG_MACH_H4700)	+= hx4700.o
> diff --git a/arch/arm/mach-pxa/include/mach/vpac270.h b/arch/arm/mach-pxa/include/mach/vpac270.h
> new file mode 100644
> index 0000000..8f8eaed
> --- /dev/null
> +++ b/arch/arm/mach-pxa/include/mach/vpac270.h
> @@ -0,0 +1,26 @@
> +/*
> + * GPIOs and interrupts for Voipac PXA270
> + *
> + * Copyright (C) 2010
> + * Marek Vasut <marek.vasut@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#ifndef _INCLUDE_VPAC270_H_
> +#define _INCLUDE_VPAC270_H_
> +
> +#define	GPIO1_VPAC270_USER_BTN		1
> +
> +#define	GPIO15_VPAC270_LED_ORANGE	15
> +
> +#define	GPIO81_VPAC270_BKL_ON		81
> +#define	GPIO83_VPAC270_NL_ON		83
> +
> +#define	GPIO52_VPAC270_SD_READONLY	52
> +#define	GPIO53_VPAC270_SD_DETECT_N	53
> +
> +#endif

Do these defines really deserve dedicated .h file? Why cannot they live
in the arch/arm/mach-pxa/vpac270.c?

The same applies to additional defines in arch/arm/mach-pxa/include/mach/vpac270.h
in other patches in the series. The GPIO definitions can be moved to the *vpac270.c
thus reducing pollution in arch/arm/mach-pxa/include/mach.

> diff --git a/arch/arm/mach-pxa/vpac270.c b/arch/arm/mach-pxa/vpac270.c
> new file mode 100644
> index 0000000..c83abf6
> --- /dev/null
> +++ b/arch/arm/mach-pxa/vpac270.c
> @@ -0,0 +1,306 @@
> +/*
> + * Hardware definitions for Voipac PXA270
> + *
> + * Copyright (C) 2010
> + * Marek Vasut <marek.vasut@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#include <linux/platform_device.h>
> +#include <linux/delay.h>
> +#include <linux/irq.h>
> +#include <linux/gpio_keys.h>
> +#include <linux/input.h>
> +#include <linux/gpio.h>
> +#include <linux/sysdev.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/partitions.h>
> +#include <linux/mtd/physmap.h>
> +
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +
> +#include <mach/pxa27x.h>
> +#include <mach/vpac270.h>
> +#include <mach/mmc.h>
> +#include <mach/pxafb.h>
> +
> +#include "generic.h"
> +#include "devices.h"
> +
> +/******************************************************************************
> + * Pin configuration
> + ******************************************************************************/
> +static unsigned long vpac270_pin_config[] __initdata = {
> +	/* MMC */
> +	GPIO32_MMC_CLK,
> +	GPIO92_MMC_DAT_0,
> +	GPIO109_MMC_DAT_1,
> +	GPIO110_MMC_DAT_2,
> +	GPIO111_MMC_DAT_3,
> +	GPIO112_MMC_CMD,
> +	GPIO53_GPIO,	/* SD detect */
> +	GPIO52_GPIO,	/* SD r/o switch */
> +
> +	/* GPIO KEYS */
> +	GPIO1_GPIO,	/* USER BTN */
> +
> +	/* LEDs */
> +	GPIO15_GPIO,	/* orange led */
> +
> +	/* FFUART */
> +	GPIO34_FFUART_RXD,
> +	GPIO39_FFUART_TXD,
> +	GPIO27_FFUART_RTS,
> +	GPIO100_FFUART_CTS,
> +	GPIO33_FFUART_DSR,
> +	GPIO40_FFUART_DTR,
> +	GPIO10_FFUART_DCD,
> +	GPIO38_FFUART_RI,
> +
> +	/* LCD */
> +	GPIO58_LCD_LDD_0,
> +	GPIO59_LCD_LDD_1,
> +	GPIO60_LCD_LDD_2,
> +	GPIO61_LCD_LDD_3,
> +	GPIO62_LCD_LDD_4,
> +	GPIO63_LCD_LDD_5,
> +	GPIO64_LCD_LDD_6,
> +	GPIO65_LCD_LDD_7,
> +	GPIO66_LCD_LDD_8,
> +	GPIO67_LCD_LDD_9,
> +	GPIO68_LCD_LDD_10,
> +	GPIO69_LCD_LDD_11,
> +	GPIO70_LCD_LDD_12,
> +	GPIO71_LCD_LDD_13,
> +	GPIO72_LCD_LDD_14,
> +	GPIO73_LCD_LDD_15,
> +	GPIO86_LCD_LDD_16,
> +	GPIO87_LCD_LDD_17,
> +	GPIO74_LCD_FCLK,
> +	GPIO75_LCD_LCLK,
> +	GPIO76_LCD_PCLK,
> +	GPIO77_LCD_BIAS,
> +};
> +
> +/******************************************************************************
> + * NOR Flash
> + ******************************************************************************/
> +#if defined(CONFIG_MTD_PHYSMAP) || defined(CONFIG_MTD_PHYSMAP_MODULE)
> +static struct mtd_partition vpac270_partitions[] = {
> +	{
> +		.name		= "Flash",
> +		.offset		= 0x00000000,
> +		.size		= MTDPART_SIZ_FULL,
> +		.mask_flags	= 0

not necessary

> +	}
> +};
> +
> +static struct physmap_flash_data vpac270_flash_data[] = {
> +	{
> +		.width		= 2,	/* bankwidth in bytes */
> +		.parts		= vpac270_partitions,
> +		.nr_parts	= ARRAY_SIZE(vpac270_partitions)
> +	}
> +};
> +
> +static struct resource vpac270_flash_resource = {
> +	.start	= PXA_CS0_PHYS,
> +	.end	= PXA_CS0_PHYS + SZ_64M - 1,
> +	.flags	= IORESOURCE_MEM,
> +};
> +
> +static struct platform_device vpac270_flash = {
> +	.name		= "physmap-flash",
> +	.id		= 0,
> +	.resource	= &vpac270_flash_resource,
> +	.num_resources	= 1,
> +	.dev 		= {
> +		.platform_data = vpac270_flash_data,
> +	},
> +};
> +static void __init vpac270_nor_init(void)
> +{
> +	platform_device_register(&vpac270_flash);
> +}
> +#else
> +static inline void vpac270_nor_init(void) {}
> +#endif
> +
> +/******************************************************************************
> + * SD/MMC card controller
> + ******************************************************************************/
> +#if defined(CONFIG_MMC_PXA) || defined(CONFIG_MMC_PXA_MODULE)
> +static struct pxamci_platform_data vpac270_mci_platform_data = {
> +	.ocr_mask		= MMC_VDD_32_33 | MMC_VDD_33_34,
> +	.gpio_card_detect	= GPIO53_VPAC270_SD_DETECT_N,
> +	.gpio_card_ro		= GPIO52_VPAC270_SD_READONLY,
> +	.detect_delay		= 20,
> +};
> +
> +static void __init vpac270_mmc_init(void)
> +{
> +	pxa_set_mci_info(&vpac270_mci_platform_data);
> +}
> +#else
> +static inline void vpac270_mmc_init(void) {}
> +#endif
> +
> +/******************************************************************************
> + * GPIO keys
> + ******************************************************************************/
> +#if defined(CONFIG_KEYBOARD_GPIO) || defined(CONFIG_KEYBOARD_GPIO_MODULE)
> +static struct gpio_keys_button vpac270_pxa_buttons[] = {
> +	{KEY_POWER, GPIO1_VPAC270_USER_BTN, 0, "USER BTN"},
> +};
> +
> +static struct gpio_keys_platform_data vpac270_pxa_keys_data = {
> +	.buttons	= vpac270_pxa_buttons,
> +	.nbuttons	= ARRAY_SIZE(vpac270_pxa_buttons),
> +};
> +
> +static struct platform_device vpac270_pxa_keys = {
> +	.name	= "gpio-keys",
> +	.id	= -1,
> +	.dev	= {
> +		.platform_data = &vpac270_pxa_keys_data,
> +	},
> +};
> +
> +static void __init vpac270_keys_init(void)
> +{
> +	platform_device_register(&vpac270_pxa_keys);
> +}
> +#else
> +static inline void vpac270_keys_init(void) {}
> +#endif
> +
> +/******************************************************************************
> + * LED
> + ******************************************************************************/
> +#if defined(CONFIG_LEDS_GPIO) || defined(CONFIG_LEDS_GPIO_MODULE)
> +struct gpio_led vpac270_gpio_leds[] = {
> +{
> +	.name			= "vpac270:orange:user",
> +	.default_trigger	= "none",
> +	.gpio			= GPIO15_VPAC270_LED_ORANGE,
> +	.active_low		= 1,
> +}
> +};
> +
> +static struct gpio_led_platform_data vpac270_gpio_led_info = {
> +	.leds		= vpac270_gpio_leds,
> +	.num_leds	= ARRAY_SIZE(vpac270_gpio_leds),
> +};
> +
> +static struct platform_device vpac270_leds = {
> +	.name	= "leds-gpio",
> +	.id	= -1,
> +	.dev	= {
> +		.platform_data	= &vpac270_gpio_led_info,
> +	}
> +};
> +
> +static void __init vpac270_leds_init(void)
> +{
> +	platform_device_register(&vpac270_leds);
> +}
> +#else
> +static inline void vpac270_leds_init(void) {}
> +#endif
> +
> +/******************************************************************************
> + * Framebuffer
> + ******************************************************************************/
> +#if defined(CONFIG_FB_PXA) || defined(CONFIG_FB_PXA_MODULE)
> +static struct pxafb_mode_info vpac270_lcd_modes[] = {
> +{
> +	.pixclock	= 57692,
> +	.xres		= 640,
> +	.yres		= 480,
> +	.bpp		= 32,
> +	.depth		= 18,
> +
> +	.left_margin	= 144,
> +	.right_margin	= 32,
> +	.upper_margin	= 13,
> +	.lower_margin	= 30,
> +
> +	.hsync_len	= 32,
> +	.vsync_len	= 2,
> +
> +	.sync		= FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
> +},
> +};
> +
> +static struct pxafb_mach_info vpac270_lcd_screen = {
> +	.modes		= vpac270_lcd_modes,
> +	.num_modes	= ARRAY_SIZE(vpac270_lcd_modes),
> +	.lcd_conn	= LCD_COLOR_TFT_18BPP,
> +};
> +
> +static void vpac270_lcd_power(int on, struct fb_var_screeninfo *info)
> +{
> +	gpio_set_value(GPIO81_VPAC270_BKL_ON, on);
> +}
> +
> +static void __init vpac270_lcd_init(void)
> +{
> +	int ret;
> +
> +	ret = gpio_request(GPIO81_VPAC270_BKL_ON, "BKL-ON");
> +	if (ret) {
> +		pr_err("Requesting BKL-ON GPIO failed!\n");
> +		goto err;
> +	}
> +
> +	ret = gpio_direction_output(GPIO81_VPAC270_BKL_ON, 1);
> +	if (ret) {
> +		pr_err("Setting BKL-ON GPIO direction failed!\n");
> +		goto err2;
> +	}
> +
> +	vpac270_lcd_screen.pxafb_lcd_power = vpac270_lcd_power;
> +	set_pxa_fb_info(&vpac270_lcd_screen);
> +	return;
> +
> +err2:
> +	gpio_free(GPIO81_VPAC270_BKL_ON);
> +err:
> +	return;
> +}
> +#else
> +static inline void vpac270_lcd_init(void) {}
> +#endif
> +
> +/******************************************************************************
> + * Machine init
> + ******************************************************************************/
> +static void __init vpac270_init(void)
> +{
> +	pxa2xx_mfp_config(ARRAY_AND_SIZE(vpac270_pin_config));
> +
> +	pxa_set_ffuart_info(NULL);
> +	pxa_set_btuart_info(NULL);
> +	pxa_set_stuart_info(NULL);
> +
> +	vpac270_lcd_init();
> +	vpac270_mmc_init();
> +	vpac270_nor_init();
> +	vpac270_leds_init();
> +	vpac270_keys_init();
> +}
> +
> +MACHINE_START(VPAC270, "Voipac PXA270")
> +	.phys_io	= 0x40000000,
> +	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
> +	.boot_params	= 0xa0000100,
> +	.map_io		= pxa_map_io,
> +	.init_irq	= pxa27x_init_irq,
> +	.timer		= &pxa_timer,
> +	.init_machine	= vpac270_init
> +MACHINE_END
> -- 
> 1.7.0
> 

-- 
Sincerely yours,
Mike.
