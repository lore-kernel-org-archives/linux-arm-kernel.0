From: manut@linutronix.de (Manuel Traut)
Date: Mon, 4 Apr 2011 15:36:03 +0200
Subject: [PATCH] Add Board Support for Siemens L1 Board
Message-ID: <20110404133603.GJ2758@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Board Support for Siemens L1 Board

Siemens L1 is a ARM9 AT91 SAM9263 SoC based board with NOR Flash.

Signed-off-by: Manuel Traut <manut@linutronix.de>

Index: linux-2.6.39-rc1/arch/arm/mach-at91/Kconfig
===================================================================
--- linux-2.6.39-rc1.orig/arch/arm/mach-at91/Kconfig	2011-04-04 19:01:36.000000000 +0000
+++ linux-2.6.39-rc1/arch/arm/mach-at91/Kconfig	2011-04-04 19:03:06.000000000 +0000
@@ -318,6 +318,13 @@
 	help
 	  Select this if you are using the Adeneo Neocore 926 board.
 
+config MACH_SIEMENS_L1
+	bool "Siemens L1"
+ 	select HAVE_AT91_DATAFLASH_CARD
+ 	select HAVE_NAND_ATMEL_BUSWIDTH_16
+ 	help
+	  Select this if you are using the Siemens L1 board.
+
 endif
 
 # ----------------------------------------------------------
Index: linux-2.6.39-rc1/arch/arm/mach-at91/Makefile
===================================================================
--- linux-2.6.39-rc1.orig/arch/arm/mach-at91/Makefile	2011-04-04 19:01:36.000000000 +0000
+++ linux-2.6.39-rc1/arch/arm/mach-at91/Makefile	2011-04-04 19:03:06.000000000 +0000
@@ -56,6 +56,7 @@
 obj-$(CONFIG_MACH_AT91SAM9263EK) += board-sam9263ek.o
 obj-$(CONFIG_MACH_USB_A9263)	+= board-usb-a9263.o
 obj-$(CONFIG_MACH_NEOCORE926)	+= board-neocore926.o
+obj-$(CONFIG_MACH_SIEMENS_L1)	+= board-siemens-l1.o
 
 # AT91SAM9RL board-specific support
 obj-$(CONFIG_MACH_AT91SAM9RLEK)	+= board-sam9rlek.o
Index: linux-2.6.39-rc1/arch/arm/mach-at91/board-siemens-l1.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.39-rc1/arch/arm/mach-at91/board-siemens-l1.c	2011-04-04 19:04:03.000000000 +0000
@@ -0,0 +1,166 @@
+/*
+ * linux/arch/arm/mach-at91/board-siemens-l1.c
+ * based on linux/arch/arm/mach-at91/board-sam9263ek.c
+ *
+ *  Copyright (C) 2005 SAN People
+ *  Copyright (C) 2007 Atmel Corporation.
+ *  Copyright (C) 2011 Linutronix GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/mtd/physmap.h>
+#include <linux/gpio_keys.h>
+#include <linux/input.h>
+
+#include <asm/setup.h>
+#include <asm/mach-types.h>
+#include <asm/irq.h>
+
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <asm/mach/irq.h>
+
+#include <mach/hardware.h>
+#include <mach/board.h>
+#include <mach/gpio.h>
+#include <mach/at91sam9_smc.h>
+#include <mach/at91_shdwc.h>
+
+#include "sam9_smc.h"
+#include "generic.h"
+
+
+static void __init l1_map_io(void)
+{
+	/* Initialize processor: 16.000 MHz crystal */
+	at91sam9263_initialize(16000000);
+
+	/* DBGU on ttyS0. (Rx & Tx only) */
+	at91_register_uart(0, 0, 0);
+
+	/* USART0 on ttyS1. (Rx, Tx, RTS, CTS) */
+	at91_register_uart(AT91SAM9263_ID_US0, 1,
+		ATMEL_UART_CTS | ATMEL_UART_RTS);
+
+	/* set serial console to ttyS0 (ie, DBGU) */
+	at91_set_serial_console(0);
+}
+
+static void __init l1_init_irq(void)
+{
+	at91sam9263_init_interrupts(NULL);
+}
+
+/*
+ * USB Host port
+ */
+static struct at91_usbh_data __initdata l1_usbh_data = {
+	.ports		= 2,
+	.vbus_pin	= { AT91_PIN_PE16, AT91_PIN_PE19 },
+};
+
+/*
+ * USB Device port
+ */
+static struct at91_udc_data __initdata l1_udc_data = {
+	.vbus_pin	= AT91_PIN_PE14,
+	.pullup_pin	= 0,		/* pull-up driven by UDC */
+};
+
+/*
+ * MACB Ethernet device
+ */
+static struct at91_eth_data __initdata l1_macb_data = {
+	.phy_irq_pin	= AT91_PIN_PE31,
+	.is_rmii	= 1,
+};
+
+/*
+ * NOR flash
+ */
+static struct mtd_partition siemensl1_nor_partitions[] = {
+	{
+		/* UBL (a few copies) plus U-Boot */
+		.name		= "bootloader",
+		.offset		= 0,
+		.size		= SZ_128K,
+		.mask_flags	= MTD_WRITEABLE, /* force read-only */
+	}, {
+		/* U-Boot environment 1 */
+		.name		= "ubi",
+		.offset		= MTDPART_OFS_NXTBLK,
+		.size		= MTDPART_SIZ_FULL,
+		.mask_flags	= 0,
+	},
+};
+
+static struct physmap_flash_data siemensl1_nor_data = {
+	.width		= 2,
+	.parts		= siemensl1_nor_partitions,
+	.nr_parts	= ARRAY_SIZE(siemensl1_nor_partitions),
+};
+
+#define NOR_BASE	AT91_CHIPSELECT_0
+#define NOR_SIZE	SZ_64M
+
+static struct resource nor_flash_resources[] = {
+	{
+		.start	= NOR_BASE,
+		.end	= NOR_BASE + NOR_SIZE - 1,
+		.flags	= IORESOURCE_MEM,
+	}
+};
+
+static struct platform_device siemensl1_nor_flash = {
+	.name		= "physmap-flash",
+	.id		= 0,
+	.dev		= {
+				.platform_data	= &siemensl1_nor_data,
+	},
+	.resource	= nor_flash_resources,
+	.num_resources	= ARRAY_SIZE(nor_flash_resources),
+};
+
+/*
+ *   Init Board
+ */
+static void __init l1_board_init(void)
+{
+	/* Serial */
+	at91_add_device_serial();
+	/* USB Host */
+	at91_add_device_usbh(&l1_usbh_data);
+	/* USB Device */
+	at91_add_device_udc(&l1_udc_data);
+	/* Ethernet */
+	at91_add_device_eth(&l1_macb_data);
+	/* NOR Flash */
+	platform_device_register(&siemensl1_nor_flash);
+}
+
+MACHINE_START(SIEMENS_L1, "Siemens L1")
+	/* Maintainer: Atmel */
+	.boot_params	= AT91_SDRAM_BASE + 0x100,
+	.timer		= &at91sam926x_timer,
+	.map_io		= l1_map_io,
+	.init_irq	= l1_init_irq,
+	.init_machine	= l1_board_init,
+MACHINE_END
