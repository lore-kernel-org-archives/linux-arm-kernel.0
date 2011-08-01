From: holzmayr@rsi-elektrotechnik.de (Josef Holzmayr)
Date: Mon,  1 Aug 2011 09:09:59 +0200
Subject: [PATCH] Add support for RSIs EWS board (machine type 1609)
In-Reply-To: <1312182599-2134-1-git-send-email-holzmayr@rsi-elektrotechnik.de>
References: <1312182599-2134-1-git-send-email-holzmayr@rsi-elektrotechnik.de>
Message-ID: <1312182599-2134-2-git-send-email-holzmayr@rsi-elektrotechnik.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

---
 arch/arm/mach-at91/Kconfig         |    5 +
 arch/arm/mach-at91/Makefile        |    1 +
 arch/arm/mach-at91/board-rsi-ews.c |  252 ++++++++++++++++++++++++++++++++++++
 3 files changed, 258 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-at91/board-rsi-ews.c

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 2248467..1555c55 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -182,6 +182,11 @@ config MACH_ECO920
 	help
 	  Select this if you are using the eco920 board
 
+config MACH_RSI_EWS
+	bool "RSI Embedded Webserver"
+	depends on ARCH_AT91RM9200
+	help
+	  Select this if you are using RSIs EWS board.
 endif
 
 # ----------------------------------------------------------
diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index bf57e8b..ecd6479 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_MACH_ECBAT91)	+= board-ecbat91.o
 obj-$(CONFIG_MACH_YL9200)	+= board-yl-9200.o
 obj-$(CONFIG_MACH_CPUAT91)	+= board-cpuat91.o
 obj-$(CONFIG_MACH_ECO920)	+= board-eco920.o
+obj-$(CONFIG_MACH_RSI_EWS)	+= board-rsi-ews.o
 
 # AT91SAM9260 board-specific support
 obj-$(CONFIG_MACH_AT91SAM9260EK) += board-sam9260ek.o
diff --git a/arch/arm/mach-at91/board-rsi-ews.c b/arch/arm/mach-at91/board-rsi-ews.c
new file mode 100644
index 0000000..509a691
--- /dev/null
+++ b/arch/arm/mach-at91/board-rsi-ews.c
@@ -0,0 +1,252 @@
+/*
+ * linux/arch/arm/mach-at91/board-rsi_ews.c
+ *
+ *  Copyright (C)
+ *  2005 SAN People,
+ *  2008-2011 R-S-I Elektrotechnik GmbH & Co. KG
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
+#include <linux/spi/spi.h>
+#include <linux/mtd/physmap.h>
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
+
+#include <linux/gpio.h>
+
+#include "generic.h"
+
+
+static void __init rsi_ews_init_early(void)
+{
+	/* Initialize processor: 18.432 MHz crystal */
+	at91rm9200_initialize(18432000);
+
+	/* Setup the LEDs */
+	at91_init_leds(AT91_PIN_PB6, AT91_PIN_PB9);
+
+	/* DBGU on ttyS0. (Rx & Tx only) */
+	/* This one is for debugging */
+	at91_register_uart(0, 0, 0);
+
+	/* USART1 on ttyS2. (Rx, Tx, CTS, RTS, DTR, DSR, DCD, RI) */
+	/* Dialin/-out modem interface */
+	at91_register_uart(AT91RM9200_ID_US1, 2, ATMEL_UART_CTS | ATMEL_UART_RTS
+			   | ATMEL_UART_DTR | ATMEL_UART_DSR | ATMEL_UART_DCD
+			   | ATMEL_UART_RI);
+
+	/* USART3 on ttyS4. (Rx, Tx, RTS) */
+	/* RS485 communication */
+	at91_register_uart(AT91RM9200_ID_US3, 4, ATMEL_UART_RTS);
+
+	/* set serial console to ttyS0 (ie, DBGU) */
+	at91_set_serial_console(0);
+}
+
+static void __init rsi_ews_init_irq(void)
+{
+	at91rm9200_init_interrupts(NULL);
+}
+
+/*
+ * Ethernet
+ */
+static struct at91_eth_data __initdata rsi_ews_eth_data = {
+	.phy_irq_pin	= AT91_PIN_PC4,
+	.is_rmii	= 1,
+};
+
+/*
+ * USB Host
+ */
+static struct at91_usbh_data __initdata rsi_ews_usbh_data = {
+	.ports		= 1,
+};
+
+/*
+ * SD/MC
+ */
+static struct at91_mmc_data __initdata rsi_ews_mmc_data = {
+	.slot_b		= 0,
+	.wire4		= 1,
+	.det_pin	= AT91_PIN_PB27,
+	.wp_pin		= AT91_PIN_PB29,
+};
+
+/*
+ * I2C
+ */
+static struct i2c_board_info __initdata rsi_ews_i2c_devices[] = {
+	{
+		I2C_BOARD_INFO("ds1337", 0x68),
+		.type	= "ds1337",
+	},
+	{
+		I2C_BOARD_INFO("24c01", 0x50),
+		.type	= "24c01",
+	}
+};
+
+/*
+ * LEDs
+ */
+static struct gpio_led rsi_ews_leds[] = {
+	{
+		.name			= "led0",
+		.gpio			= AT91_PIN_PB6,
+		.active_low		= 0,
+	},
+	{
+		.name			= "led1",
+		.gpio			= AT91_PIN_PB7,
+		.active_low		= 0,
+	},
+	{
+		.name			= "led2",
+		.gpio			= AT91_PIN_PB8,
+		.active_low		= 0,
+	},
+	{
+		.name			= "led3",
+		.gpio			= AT91_PIN_PB9,
+		.active_low		= 0,
+	},
+};
+
+/*
+ * DataFlash
+ */
+static struct spi_board_info rsi_ews_spi_devices[] = {
+	{	/* DataFlash chip 1*/
+		.modalias	= "mtd_dataflash",
+		.chip_select	= 0,
+		.max_speed_hz	= 5 * 1000 * 1000,
+	},
+	{	/* DataFlash chip 2*/
+		.modalias	= "mtd_dataflash",
+		.chip_select	= 1,
+		.max_speed_hz	= 5 * 1000 * 1000,
+	},
+};
+
+/*
+ * NOR flash
+ */
+static struct mtd_partition rsiews_nor_partitions[] = {
+	{
+		.name		= "boot",
+		.offset		= 0,
+		.size		= 3 * SZ_128K,
+		.mask_flags	= MTD_WRITEABLE
+	},
+	{
+		.name		= "kernel",
+		.offset		= MTDPART_OFS_NXTBLK,
+		.size		= SZ_2M - (3 * SZ_128K)
+	},
+	{
+		.name		= "root",
+		.offset		= MTDPART_OFS_NXTBLK,
+		.size		= SZ_8M
+	},
+	{
+		.name		= "kernelupd",
+		.offset		= MTDPART_OFS_NXTBLK,
+		.size		= 3 * SZ_512K,
+		.mask_flags	= MTD_WRITEABLE
+	},
+	{
+		.name		= "rootupd",
+		.offset		= MTDPART_OFS_NXTBLK,
+		.size		= 9 * SZ_512K,
+		.mask_flags	= MTD_WRITEABLE
+	},
+};
+
+static struct physmap_flash_data rsiews_nor_data = {
+	.width		= 2,
+	.parts		= rsiews_nor_partitions,
+	.nr_parts	= ARRAY_SIZE(rsiews_nor_partitions),
+};
+
+#define NOR_BASE	AT91_CHIPSELECT_0
+#define NOR_SIZE	SZ_16M
+
+static struct resource nor_flash_resources[] = {
+	{
+		.start	= NOR_BASE,
+		.end	= NOR_BASE + NOR_SIZE - 1,
+		.flags	= IORESOURCE_MEM,
+	}
+};
+
+static struct platform_device rsiews_nor_flash = {
+	.name		= "physmap-flash",
+	.id		= 0,
+	.dev		= {
+				.platform_data	= &rsiews_nor_data,
+	},
+	.resource	= nor_flash_resources,
+	.num_resources	= ARRAY_SIZE(nor_flash_resources),
+};
+
+/*
+ * Init Func
+ */
+static void __init rsi_ews_board_init(void)
+{
+	/* Serial */
+	at91_add_device_serial();
+	at91_set_gpio_output(AT91_PIN_PA21, 0);
+	/* Ethernet */
+	at91_add_device_eth(&rsi_ews_eth_data);
+	/* USB Host */
+	at91_add_device_usbh(&rsi_ews_usbh_data);
+	/* I2C */
+	at91_add_device_i2c(rsi_ews_i2c_devices, ARRAY_SIZE(rsi_ews_i2c_devices));
+	/* SPI */
+	at91_add_device_spi(rsi_ews_spi_devices, ARRAY_SIZE(rsi_ews_spi_devices));
+	/* MMC */
+	at91_add_device_mmc(0, &rsi_ews_mmc_data);
+	/* NOR Flash */
+	platform_device_register(&rsiews_nor_flash);
+	/* LEDs */
+	at91_gpio_leds(rsi_ews_leds, ARRAY_SIZE(rsi_ews_leds));
+}
+
+MACHINE_START(RSI_EWS, "RSI EWS")
+	/* Maintainer: Josef Holzmayr <holzmayr@rsi-elektrotechnik.de> */
+	.timer		= &at91rm9200_timer,
+	.map_io		= at91rm9200_map_io,
+	.init_early	= rsi_ews_init_early,
+	.init_irq	= rsi_ews_init_irq,
+	.init_machine	= rsi_ews_board_init,
+MACHINE_END
+
-- 
1.7.4.1



Amtsgericht Ingolstadt - GmbH: HRB 191328 - KG: HRA 170363
Gesch?ftsf?hrer: Dr.-Ing. Michael Sorg, Dipl.-Ing. Franz Sorg
USt-IdNr.: DE 128592548
