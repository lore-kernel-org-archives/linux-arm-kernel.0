From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 6 Apr 2011 10:01:21 +0200
Subject: [PATCH] Add Board Support for Siemens L0 Board
In-Reply-To: <20110404133309.GI2758@linutronix.de>
References: <20110404133309.GI2758@linutronix.de>
Message-ID: <20110406080121.GY13963@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 04, 2011 at 03:33:09PM +0200, Manuel Traut wrote:
> Add Board Support for Siemens L0 Board
> 
> Siemens L0 is a ARM9 AT91 SAM9263 SoC based board with NAND Flash.
> 
> Signed-off-by: Manuel Traut <manut@linutronix.de>
> 
> Index: linux-2.6.39-rc1/arch/arm/mach-at91/Kconfig
> ===================================================================
> --- linux-2.6.39-rc1.orig/arch/arm/mach-at91/Kconfig	2011-04-01 11:43:41.000000000 +0000
> +++ linux-2.6.39-rc1/arch/arm/mach-at91/Kconfig	2011-04-04 18:51:25.000000000 +0000
> @@ -306,6 +306,12 @@
>  	  Select this if you are using Atmel's AT91SAM9263-EK Evaluation Kit.
>  	  <http://www.atmel.com/dyn/products/tools_card.asp?tool_id=4057>
>  
> +config MACH_SIEMENS_L0
> +	bool "Siemens L0"
> +	select HAVE_NAND_ATMEL_BUSWIDTH_16
hmm, isn't that a stopper for a multi-machine kernel? I havn't checked
deeply, but the only thing HAVE_NAND_ATMEL_BUSWIDTH_16 does is allowing
to select CONFIG_MTD_NAND_ATMEL_BUSWIDTH_16. When looking at
arch/arm/mach-at91/board-at572d940hf_ek.c the latter looks like
something that should be possible to be different per board.
(Obviously that's not a comment that should stop your patch getting in,
but (maybe) a for the at91 maintainers to solve.)

> +	help
> +	  Select this if you are using the Siemens L0 board.
> +
>  config MACH_USB_A9263
>  	bool "CALAO USB-A9263"
>  	help
> Index: linux-2.6.39-rc1/arch/arm/mach-at91/Makefile
> ===================================================================
> --- linux-2.6.39-rc1.orig/arch/arm/mach-at91/Makefile	2011-04-01 11:43:41.000000000 +0000
> +++ linux-2.6.39-rc1/arch/arm/mach-at91/Makefile	2011-04-04 18:51:25.000000000 +0000
> @@ -54,6 +54,7 @@
>  
>  # AT91SAM9263 board-specific support
>  obj-$(CONFIG_MACH_AT91SAM9263EK) += board-sam9263ek.o
> +obj-$(CONFIG_MACH_SIEMENS_L0)	+= board-siemens-l0.o
>  obj-$(CONFIG_MACH_USB_A9263)	+= board-usb-a9263.o
>  obj-$(CONFIG_MACH_NEOCORE926)	+= board-neocore926.o
>  
> Index: linux-2.6.39-rc1/arch/arm/mach-at91/board-siemens-l0.c
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.39-rc1/arch/arm/mach-at91/board-siemens-l0.c	2011-04-04 18:52:48.000000000 +0000
> @@ -0,0 +1,189 @@
> +/*
> + * linux/arch/arm/mach-at91/board-siemens-l0.c
> + * based on linux/arch/arm/mach-at91/board-sam9263ek.c
> + *
> + *  Copyright (C) 2005 SAN People
> + *  Copyright (C) 2007 Atmel Corporation.
> + *  Copyright (C) 2011 Linutronix GmbH
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
This address isn't valid any more. I suggest to just skip the whole
paragraph as this should be already handled good enough by the toplevel
copyright file.

> + */
> +
> +#include <linux/types.h>
> +#include <linux/init.h>
> +#include <linux/mm.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/mtd/physmap.h>
> +#include <linux/gpio_keys.h>
> +
> +#include <asm/setup.h>
> +#include <asm/mach-types.h>
> +#include <asm/irq.h>
> +
> +#include <asm/mach/arch.h>
> +#include <asm/mach/map.h>
> +#include <asm/mach/irq.h>
> +
> +#include <mach/hardware.h>
> +#include <mach/board.h>
> +#include <mach/gpio.h>
> +#include <mach/at91sam9_smc.h>
> +#include <mach/at91_shdwc.h>
> +
> +#include "sam9_smc.h"
> +#include "generic.h"
> +
> +static void __init l0_map_io(void)
> +{
> +	/* Initialize processor: 16.000 MHz crystal */
> +	at91sam9263_initialize(16000000);
> +
> +	/* DBGU on ttyS0. (Rx & Tx only) */
> +	at91_register_uart(0, 0, 0);
> +
> +	/* USART0 on ttyS1. (Rx, Tx, RTS, CTS) */
> +	at91_register_uart(AT91SAM9263_ID_US0, 1,
> +		ATMEL_UART_CTS | ATMEL_UART_RTS);
> +
> +	/* set serial console to ttyS0 (ie, DBGU) */
> +	at91_set_serial_console(0);
> +}
> +
> +static void __init l0_init_irq(void)
> +{
> +	at91sam9263_init_interrupts(NULL);
> +}
> +
> +/*
> + * USB Host port
> + */
> +static struct at91_usbh_data __initdata l0_usbh_data = {
> +	.ports		= 2,
> +	.vbus_pin	= { AT91_PIN_PE2, AT91_PIN_PE5 },
> +};
> +
> +/*
> + * USB Device port
> + */
> +static struct at91_udc_data __initdata l0_udc_data = {
> +	.vbus_pin	= AT91_PIN_PE1,
> +	.pullup_pin	= 0,		/* pull-up driven by UDC */
> +};
> +
> +/*
> + * MCI (SD/MMC)
> + */
> +static struct at91_mmc_data __initdata l0_mmc_data = {
> +	.slot_b		= 0,
> +	.wire4		= 1,
> +	.det_pin	= AT91_PIN_PA16,
> +	.wp_pin		= AT91_PIN_PE0,
> +/*	.vcc_pin	= ... not connected */
> +};
> +
> +/*
> + * MACB Ethernet device
> + */
> +static struct at91_eth_data __initdata l0_macb_data = {
> +	.phy_irq_pin	= AT91_PIN_PE31,
> +	.is_rmii	= 1,
> +};
> +
> +/*
> + * CAN
> + */
> +static void sam9263l0_transceiver_switch(int on)
> +{
> +	if (on) {
> +		at91_set_gpio_output(AT91_PIN_PA18, 1); /* CANRXEN */
> +		at91_set_gpio_output(AT91_PIN_PA19, 0); /* CANRS */
> +	} else {
> +		at91_set_gpio_output(AT91_PIN_PA18, 0); /* CANRXEN */
> +		at91_set_gpio_output(AT91_PIN_PA19, 1); /* CANRS */
> +	}
> +}
> +
> +static struct at91_can_data l0_can_data = {
> +	.transceiver_switch = sam9263l0_transceiver_switch,
> +};
> +
> +/*
> + * Nand flash
> + */
> +static struct mtd_partition __initdata l0_nand_partition[] = {
> +	{
> +		.name   = "bootloader",
> +		.offset = 0,
> +		.size   = SZ_256K,
> +	},
> +	{
> +		.name   = "ubi",
> +		.offset = MTDPART_OFS_NXTBLK,
> +		.size   = MTDPART_SIZ_FULL,
> +	},
> +};
> +
> +static struct mtd_partition * __init nand_partitions(int size,
> +	int *num_partitions)
> +{
> +	*num_partitions = ARRAY_SIZE(l0_nand_partition);
> +	return l0_nand_partition;
> +}
> +
> +static struct atmel_nand_data __initdata l0_nand_data = {
> +	.ale		= 21,
> +	.cle		= 22,
> +/*	.det_pin	= ... not connected */
> +	.rdy_pin	= AT91_PIN_PA22,
> +	.enable_pin	= AT91_PIN_PD15,
> +	.partition_info	= nand_partitions,
> +	.bus_width_16	= 1,
> +};
> +
> +static void __init l0_add_device_nand(void)
> +{
> +	at91_add_device_nand(&l0_nand_data);
> +}
> +
> +/*
> + *   Init Board
> + */
> +static void __init l0_board_init(void)
> +{
> +	/* Serial */
> +	at91_add_device_serial();
> +	/* USB Host */
> +	at91_add_device_usbh(&l0_usbh_data);
> +	/* USB Device */
> +	at91_add_device_udc(&l0_udc_data);
> +	/* MMC */
> +	at91_add_device_mmc(1, &l0_mmc_data);
> +	/* Ethernet */
> +	at91_add_device_eth(&l0_macb_data);
> +	/* NAND */
> +	l0_add_device_nand();
> +	/* CAN */
> +	at91_add_device_can(&l0_can_data);
> +}
> +
> +MACHINE_START(SIEMENS_L0, "Siemens L0")
> +	/* Maintainer: Atmel */
> +	.boot_params	= AT91_SDRAM_BASE + 0x100,
Do you really need this? With a recent bootloader it's not necessary.

> +	.timer		= &at91sam926x_timer,
> +	.map_io		= l0_map_io,
> +	.init_irq	= l0_init_irq,
> +	.init_machine	= l0_board_init,
Regarding http://article.gmane.org/gmane.linux.ports.arm.omap/50721
this isn't in the right order.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
