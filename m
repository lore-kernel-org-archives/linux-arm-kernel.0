From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 15 Mar 2011 17:59:12 +0000
Subject: [PATCH v2 1/1] Add core support for QQ2440.
In-Reply-To: <20110314132312.GB11441@dandreoli.com>
References: <20110314131837.540942890@gmail.com>
	<20110314132312.GB11441@dandreoli.com>
Message-ID: <20110315175912.GA27050@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Domenico,

A couple of pedantic points, but otherwise looks nice to me.

On Mon, Mar 14, 2011 at 01:23:12PM +0000, Domenico Andreoli wrote:
> From: Domenico Andreoli <cavokz@gmail.com>
> 
> QQ2440 is a ARM based development board. It is commonly found together
> with LCD displays but mine was not so I am not able to support it yet.
> Network support is added by another patch.
> 
> This patch applies cleanly to 2.6.38-rc8.
> 
> Signed-off-by: Domenico Andreoli <cavokz@gmail.com>
> 
> ---
[...]
> Index: arm-2.6.git/arch/arm/mach-s3c2440/mach-qq2440.c
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ arm-2.6.git/arch/arm/mach-s3c2440/mach-qq2440.c	2011-03-12 20:56:43.000000000 +0000
> @@ -0,0 +1,372 @@
> +/* linux/arch/arm/mach-s3c2440/mach-qq2440.c
> + *
> + * Copyright (c) 2011 Domenico Andreoli <cavokz@gmail.com>
> + *
> + * Based on mach-mini2440.c by Michel Pollet <buserror@gmail.com>,
> + *                             Ramax Lo <ramaxlo@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <linux/interrupt.h>
> +#include <linux/list.h>
> +#include <linux/timer.h>
> +#include <linux/init.h>
> +#include <linux/gpio.h>
> +#include <linux/input.h>
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/serial_core.h>
> +#include <linux/i2c/at24.h>
> +#include <linux/platform_device.h>
> +#include <linux/gpio_keys.h>
> +#include <linux/i2c.h>
> +#include <linux/mmc/host.h>
> +
> +#include <asm/mach/arch.h>
> +#include <asm/mach/map.h>
> +
> +#include <mach/hardware.h>
> +#include <asm/mach-types.h>
> +
> +#include <plat/regs-serial.h>
> +#include <mach/regs-gpio.h>
> +#include <mach/leds-gpio.h>
> +#include <mach/regs-mem.h>
> +#include <mach/irqs.h>
> +#include <mach/qq2440.h>
> +#include <plat/nand.h>
> +#include <plat/iic.h>
> +#include <plat/mci.h>
> +#include <plat/udc.h>
> +
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/nand.h>
> +#include <linux/mtd/nand_ecc.h>
> +#include <linux/mtd/partitions.h>
> +
> +#include <plat/gpio-cfg.h>
> +#include <plat/clock.h>
> +#include <plat/devs.h>
> +#include <plat/cpu.h>
> +
> +#include <sound/s3c24xx_uda134x.h>
> +
> +static struct map_desc qq2440_iodesc[] __initdata = {
> +	{
> +		.virtual  = QQ2440_CS8900_VIRT_BASE,
> +		.pfn      = __phys_to_pfn(QQ2440_CS8900_PA),
> +		.length   = QQ2440_CS8900_SZ,
> +		.type     = MT_DEVICE
> +	}
> +};
> +
> +#define UCON   S3C2410_UCON_DEFAULT
> +#define ULCON  (S3C2410_LCON_CS8 | S3C2410_LCON_PNONE | S3C2410_LCON_STOPB)
> +#define UFCON  (S3C2410_UFCON_RXTRIG8 | S3C2410_UFCON_FIFOMODE)
> +
> +static struct s3c2410_uartcfg qq2440_uartcfgs[] __initdata = {
> +	[0] = {
> +		.hwport   = 0,
> +		.flags    = 0,
> +		.ucon     = UCON,
> +		.ulcon    = ULCON,
> +		.ufcon    = UFCON,
> +	},
> +	[1] = {
> +		.hwport   = 1,
> +		.flags    = 0,
> +		.ucon     = UCON,
> +		.ulcon    = ULCON,
> +		.ufcon    = UFCON,
> +	},
> +	[2] = {
> +		.hwport   = 2,
> +		.flags    = 0,
> +		.ucon     = UCON,
> +		.ulcon    = ULCON,
> +		.ufcon    = UFCON,
> +	},
> +};
> +
> +/* UDC */
> +
> +static void qq2440_udc_pullup(enum s3c2410_udc_cmd_e cmd)
> +{
> +	pr_debug("udc: pullup(%d)\n", cmd);
> +
> +	switch (cmd) {
> +	case S3C2410_UDC_P_ENABLE:
> +		gpio_set_value(S3C2410_GPG(12), 1);
> +		break;
> +	case S3C2410_UDC_P_DISABLE:
> +		gpio_set_value(S3C2410_GPG(12), 0);
> +		break;
> +	case S3C2410_UDC_P_RESET:
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
> +static struct s3c2410_udc_mach_info qq2440_udc_cfg __initdata = {
> +	.udc_command = qq2440_udc_pullup,
> +};
> +
> +/* MMC/SD  */
> +
> +static struct s3c24xx_mci_pdata qq2440_mmc_cfg __initdata = {
> +	.gpio_detect    = S3C2410_GPG(8),
> +	.gpio_wprotect  = S3C2410_GPH(8),
> +	.set_power      = NULL,

The NULL initializer isn't explicitly needed as this is static data, 
though it doesn't hurt.

> +	.ocr_avail      = MMC_VDD_32_33 | MMC_VDD_33_34,
> +};
> +
> +/* NAND */
> +
> +static struct mtd_partition qq2440_default_nand_part[] __initdata = {
> +	[0] = {
> +		.name   = "vivi",
> +		.size   = SZ_128K,
> +		.offset = 0,
> +	},
> +	[1] = {
> +		.name   = "eboot",
> +		.size   = SZ_128K,
> +		.offset = MTDPART_OFS_APPEND,
> +	},
> +	[2] = {
> +		.name   = "param",
> +		.size   = SZ_64K,
> +		.offset = MTDPART_OFS_APPEND,
> +	},
> +	[3] = {
> +		.name   = "kernel",
> +		.size   = SZ_2M,
> +		.offset = MTDPART_OFS_APPEND,
> +	},
> +	[4] = {
> +		.name   = "root",
> +		.size   = 0x03dac000,
> +		.offset = MTDPART_OFS_APPEND,
> +	},
> +};
> +
> +static struct s3c2410_nand_set qq2440_nand_sets[] __initdata = {
> +	[0] = {
> +		.name           = "nand",
> +		.nr_chips       = 1,
> +		.nr_partitions  = ARRAY_SIZE(qq2440_default_nand_part),
> +		.partitions     = qq2440_default_nand_part,
> +	},
> +};
> +
> +static struct s3c2410_platform_nand qq2440_nand_info __initdata = {
> +	.tacls             = 0,
> +	.twrph0            = 25,
> +	.twrph1            = 15,
> +	.nr_sets           = ARRAY_SIZE(qq2440_nand_sets),
> +	.sets              = qq2440_nand_sets,
> +	.ignore_unset_ecc  = 1,
> +};
> +
> +/* KEYS */
> +
> +static struct gpio_keys_button qq2440_buttons[] = {
> +	{
> +		.gpio        = S3C2410_GPG(11), /* K1 */
> +		.code        = KEY_F1,
> +		.desc        = "Button 1",
> +		.active_low  = 1,
> +	}, {
> +		.gpio        = S3C2410_GPG(3),  /* K2 */
> +		.code        = KEY_F2,
> +		.desc        = "Button 2",
> +		.active_low  = 1,
> +	}, {
> +		.gpio        = S3C2410_GPF(2),  /* K3 */
> +		.code        = KEY_F3,
> +		.desc        = "Button 3",
> +		.active_low  = 1,
> +	}, {
> +		.gpio        = S3C2410_GPF(0),  /* K4 */
> +		.code        = KEY_F4,
> +		.desc        = "Button 4",
> +		.active_low  = 1,
> +	},
> +};
> +
> +static struct gpio_keys_platform_data qq2440_button_data = {
> +	.buttons   = qq2440_buttons,
> +	.nbuttons  = ARRAY_SIZE(qq2440_buttons),
> +};
> +
> +static struct platform_device qq2440_button_device = {
> +	.name  = "gpio-keys",
> +	.id    = -1,
> +	.dev   = {
> +		.platform_data = &qq2440_button_data,
> +	}
> +};
> +
> +/* LEDS */
> +
> +static struct s3c24xx_led_platdata qq2440_led1_pdata = {
> +	.name         = "led1",
> +	.gpio         = S3C2410_GPB(5),
> +	.flags        = S3C24XX_LEDF_ACTLOW | S3C24XX_LEDF_TRISTATE,
> +	.def_trigger  = "heartbeat",
> +};
> +
> +static struct s3c24xx_led_platdata qq2440_led2_pdata = {
> +	.name         = "led2",
> +	.gpio         = S3C2410_GPB(6),
> +	.flags        = S3C24XX_LEDF_ACTLOW | S3C24XX_LEDF_TRISTATE,
> +	.def_trigger  = "nand-disk",
> +};
> +
> +static struct s3c24xx_led_platdata qq2440_led3_pdata = {
> +	.name         = "led3",
> +	.gpio         = S3C2410_GPB(7),
> +	.flags        = S3C24XX_LEDF_ACTLOW | S3C24XX_LEDF_TRISTATE,
> +	.def_trigger  = "mmc0",
> +};
> +
> +static struct s3c24xx_led_platdata qq2440_led4_pdata = {
> +	.name         = "led4",
> +	.gpio         = S3C2410_GPB(8),
> +	.flags        = S3C24XX_LEDF_ACTLOW | S3C24XX_LEDF_TRISTATE,
> +	.def_trigger  = "",
> +};
> +
> +static struct platform_device qq2440_led1 = {
> +	.name  = "s3c24xx_led",
> +	.id    = 1,
> +	.dev   = {
> +		.platform_data = &qq2440_led1_pdata,
> +	},
> +};
> +
> +static struct platform_device qq2440_led2 = {
> +	.name  = "s3c24xx_led",
> +	.id    = 2,
> +	.dev   = {
> +		.platform_data = &qq2440_led2_pdata,
> +	},
> +};
> +
> +static struct platform_device qq2440_led3 = {
> +	.name  = "s3c24xx_led",
> +	.id    = 3,
> +	.dev   = {
> +		.platform_data = &qq2440_led3_pdata,
> +	},
> +};
> +
> +static struct platform_device qq2440_led4 = {
> +	.name  = "s3c24xx_led",
> +	.id    = 4,
> +	.dev   = {
> +		.platform_data = &qq2440_led4_pdata,
> +	},
> +};
> +
> +/* AUDIO */
> +
> +static struct s3c24xx_uda134x_platform_data qq2440_audio_pins = {
> +	.l3_clk   = S3C2410_GPB(4),
> +	.l3_mode  = S3C2410_GPB(2),
> +	.l3_data  = S3C2410_GPB(3),
> +	.model    = UDA134X_UDA1341
> +};
> +
> +static struct platform_device qq2440_audio = {
> +	.name  = "s3c24xx_uda134x",
> +	.id    = 0,
> +	.dev   = {
> +		.platform_data = &qq2440_audio_pins,
> +	},
> +};
> +
> +/* I2C */
> +
> +static struct at24_platform_data at24c08 = {
> +	.byte_len   = SZ_8K / 8,
> +	.page_size  = 16,
> +};
> +
> +static struct i2c_board_info qq2440_i2c_devs[] __initdata = {
> +	{
> +		I2C_BOARD_INFO("24c08", 0x50),
> +		.platform_data = &at24c08,
> +	},
> +};
> +
> +static struct platform_device *qq2440_devices[] __initdata = {
> +	&s3c_device_ohci,
> +	&s3c_device_wdt,
> +	&s3c_device_i2c0,
> +	&s3c_device_rtc,
> +	&s3c_device_usbgadget,
> +	&qq2440_led1,
> +	&qq2440_led2,
> +	&qq2440_led3,
> +	&qq2440_led4,
> +	&qq2440_button_device,
> +	&s3c_device_nand,
> +	&s3c_device_sdi,
> +	&s3c_device_iis,
> +	&qq2440_audio,
> +};
> +
> +static void __init qq2440_map_io(void)
> +{
> +	s3c24xx_init_io(qq2440_iodesc, ARRAY_SIZE(qq2440_iodesc));
> +	s3c24xx_init_clocks(12000000);
> +	s3c24xx_init_uarts(qq2440_uartcfgs, ARRAY_SIZE(qq2440_uartcfgs));
> +}
> +
> +#define QQ2440_CS8900_BANKCON  (S3C2410_BANKCON_Tacp6  | S3C2410_BANKCON_Tcah4 | S3C2410_BANKCON_Tcoh1 | \
> +                                S3C2410_BANKCON_Tacc14 | S3C2410_BANKCON_Tcos4)
> +
> +static void __init qq2440_init(void)
> +{
> +	int i;
> +
> +	/* Ethernet */
> +	__raw_writel(__raw_readl(S3C2410_BWSCON) | S3C2410_BWSCON_WS3 | S3C2410_BWSCON_ST3, S3C2410_BWSCON);
> +	__raw_writel(QQ2440_CS8900_BANKCON, S3C2410_BANKCON3);
> +	set_irq_type(QQ2440_CS8900_IRQ, IRQ_TYPE_EDGE_RISING);
> +
> +	/* mark the key as input, without pullups (there is one on the board) */
> +	for (i = 0; i < ARRAY_SIZE(qq2440_buttons); i++) {
> +		s3c_gpio_setpull(qq2440_buttons[i].gpio, S3C_GPIO_PULL_UP);
> +		s3c_gpio_cfgpin(qq2440_buttons[i].gpio, S3C2410_GPIO_INPUT);
> +	}
> +
> +	/* Make sure the D+ pullup pin is output */
> +	if (!WARN_ON(gpio_request(S3C2410_GPG(12), "udc pup"))) {
> +		gpio_direction_output(S3C2410_GPG(12), 0);

gpio_request_one(S3C2410_GPG(12), GPIOF_OUT_INIT_LOW, "udc pup") will do 
the request and direction setting in one call and handle error checking 
(freeing if the direction/value can't be set).

Jamie
