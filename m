From: tim.schendekehl@egnite.de (Tim Schendekehl)
Date: Mon, 05 Mar 2012 11:34:58 +0100
Subject: [PATCH] ARM: at91: Ethernut 5 board support
Message-ID: <4F5496D2.8090702@egnite.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the Ethernut 5 open hardware design, based
on Atmel's AT91SAM9XE512 SoC.

Signed-off-by: Tim Schendekehl <tim.schendekehl@egnite.de>
---
 arch/arm/mach-at91/Kconfig           |    7 +
 arch/arm/mach-at91/Makefile          |    1 +
 arch/arm/mach-at91/board-ethernut5.c |  280 ++++++++++++++++++++++++++++++++++
 3 files changed, 288 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-at91/board-ethernut5.c

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 71feb00..88ee70a 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -239,6 +239,13 @@ config MACH_CAM60
 	  Select this if you are using KwikByte's KB9260 (CAM60) board based on the Atmel AT91SAM9260.
 	  <http://www.kwikbyte.com/KB9260.html>
 
+config MACH_ETHERNUT5
+	bool "Ethernut 5 board"
+	select HAVE_AT91_DATAFLASH_CARD
+	help
+	  Select this if you are using an Ethernut 5 board
+	  <http://www.ethernut.de/en/hardware/enut5/>
+
 config MACH_SAM9_L9260
 	bool "Olimex SAM9-L9260 board"
 	select HAVE_AT91_DATAFLASH_CARD
diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index 705e1fb..e8ef87d 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -43,6 +43,7 @@ obj-$(CONFIG_MACH_RSI_EWS)	+= board-rsi-ews.o
 # AT91SAM9260 board-specific support
 obj-$(CONFIG_MACH_AT91SAM9260EK) += board-sam9260ek.o
 obj-$(CONFIG_MACH_CAM60)	+= board-cam60.o
+obj-$(CONFIG_MACH_ETHERNUT5)	+= board-ethernut5.o
 obj-$(CONFIG_MACH_SAM9_L9260)	+= board-sam9-l9260.o
 obj-$(CONFIG_MACH_USB_A9260)	+= board-usb-a926x.o
 obj-$(CONFIG_MACH_QIL_A9260)	+= board-qil-a9260.o
diff --git a/arch/arm/mach-at91/board-ethernut5.c b/arch/arm/mach-at91/board-ethernut5.c
new file mode 100644
index 0000000..d1e01b1
--- /dev/null
+++ b/arch/arm/mach-at91/board-ethernut5.c
@@ -0,0 +1,280 @@
+/*
+ * linux/arch/arm/mach-at91/board-ethernut5.c
+ *
+ *  Copyright (C) 2008 Ole Reinhardt <ole.reinhardt@thermotemp.de>
+ *  Copyright (C) 2012 egnite GmbH <info@egnite.de>
+ *
+ * linux/arch/arm/mach-at91/board-sam9260ek.c
+ *  Copyright (C) 2005 SAN People
+ *  Copyright (C) 2006 Atmel
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
+#include <linux/spi/flash.h>
+#include <linux/clk.h>
+#include <linux/i2c-gpio.h>
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
+static void __init ethernut5_init_early(void)
+{
+	/* Initialize processor: 18.432 MHz crystal */
+	at91_initialize(18432000);
+	/* DBGU on ttyS0. (Rx & Tx only) */
+	at91_register_uart(0, 0, 0);
+	/* USART0 on ttyS1. (Rx, Tx, CTS, RTS, DTR, DSR, DCD, RI) */
+	at91_register_uart(AT91SAM9260_ID_US0, 1, ATMEL_UART_CTS
+			   | ATMEL_UART_RTS | ATMEL_UART_DTR | ATMEL_UART_DSR
+			   | ATMEL_UART_DCD | ATMEL_UART_RI);
+	/* USART1 on ttyS2. (Rx, Tx, RTS, CTS) */
+	at91_register_uart(AT91SAM9260_ID_US1, 2, ATMEL_UART_CTS
+			   | ATMEL_UART_RTS);
+	/* set serial console to ttyS0 (ie, DBGU) */
+	at91_set_serial_console(0);
+}
+
+/*
+ * USB host port
+ */
+static struct at91_usbh_data __initdata ethernut5_usbh_data = {
+	.ports		= 2,
+	.vbus_pin	= {-EINVAL, -EINVAL},
+};
+
+/*
+ * USB device port
+ */
+static struct at91_udc_data __initdata ethernut5_udc_data = {
+	.vbus_pin	= AT91_PIN_PC5,
+	.pullup_pin	= -EINVAL,		/* pull-up driven by UDC */
+};
+
+/*
+ * SPI flash
+ */
+static struct mtd_partition ethernut5_spi_dataflash_partitions[] = {
+	{
+		.name	= "user",
+		.size	= 0x021000,
+		.offset	= 0x000000,
+	},
+	{
+		.name	= "setup",
+		.size	= 0x021000,
+		.offset	= 0x021000,
+	},
+	{
+		.name	= "uboot",
+		.size	= 0x084000,
+		.offset	= 0x042000,
+	},
+	{
+		.name	= "kernel",
+		.size	= 0x0C6000,
+		.offset	= 0x294000,
+	},
+	{
+		.name	= "nutos",
+		.size	= 0x35A000,
+		.offset	= 0x084000,
+	},
+	{
+		.name	= "env",
+		.size	= 0x3DE000,
+		.offset	= 0x021000,
+	}
+};
+
+static struct flash_platform_data ethernut5_spi_dataflash_data = {
+	.name = "mtd_dataflash",
+	.parts = ethernut5_spi_dataflash_partitions,
+	.nr_parts = ARRAY_SIZE(ethernut5_spi_dataflash_partitions),
+	.type = "mtd_dataflash",
+};
+
+static struct spi_board_info ethernut5_spi_devices[] = {
+	{
+		.modalias	= "mtd_dataflash",
+		.chip_select	= 0,
+		.max_speed_hz	= 15 * 1000 * 1000,
+		.bus_num	= 0,
+		.platform_data	= &ethernut5_spi_dataflash_data,
+	},
+};
+
+/*
+ * NAND flash
+ */
+static struct sam9_smc_config __initdata ethernut5_nand_smc_config = {
+	.ncs_read_setup		= 0,
+	.nrd_setup		= 1,
+	.ncs_write_setup	= 0,
+	.nwe_setup		= 1,
+
+	.ncs_read_pulse		= 3,
+	.nrd_pulse		= 3,
+	.ncs_write_pulse	= 3,
+	.nwe_pulse		= 3,
+
+	.read_cycle		= 5,
+	.write_cycle		= 5,
+
+	.mode			= AT91_SMC_READMODE | AT91_SMC_WRITEMODE |
+					AT91_SMC_EXNWMODE_DISABLE,
+	.tdf_cycles		= 1,
+};
+
+static struct mtd_partition __initdata ethernut5_nand_partition[] = {
+	{
+		.name	= "root",
+		.offset	= 0,
+		.size	= 0x08000000,
+	},
+	{
+		.name	= "data",
+		.offset	= 0x08000000,
+		.size	= MTDPART_SIZ_FULL,
+	}
+};
+
+static struct atmel_nand_data __initdata ethernut5_nand_data = {
+	.ale		= 21,
+	.cle		= 22,
+	.det_pin	= -EINVAL,
+	.rdy_pin	= -EINVAL,
+	.enable_pin	= AT91_PIN_PC14,
+	.parts = ethernut5_nand_partition,
+	.num_parts	= ARRAY_SIZE(ethernut5_nand_partition),
+	.bus_width_16	= 0,
+};
+
+static void __init ethernut5_add_device_nand(void)
+{
+	ethernut5_nand_smc_config.mode |= AT91_SMC_DBW_8;
+	sam9_smc_configure(0, 3, &ethernut5_nand_smc_config);
+	at91_add_device_nand(&ethernut5_nand_data);
+}
+
+/*
+ * MACB Ethernet device
+ */
+static struct macb_platform_data __initdata ethernut5_macb_data = {
+	.phy_irq_pin	= AT91_PIN_PA7,
+	.is_rmii	= 1,
+};
+
+/*
+ * MCI (SD/MMC)
+ */
+static struct at91_mmc_data __initdata ethernut5_mmc_data = {
+	.slot_b		= 0,
+	.wire4		= 1,
+	.det_pin	= AT91_PIN_PC8,
+	.wp_pin		= AT91_PIN_PC9,
+	.vcc_pin	= -EINVAL,
+};
+
+/*
+ * I2C devices
+ */
+static struct i2c_board_info __initdata ethernut5_i2c_devices[] = {
+	{
+		I2C_BOARD_INFO("pcf8563", 0x51),
+	},
+	{
+		I2C_BOARD_INFO("pmmc", 0x22),
+	}
+};
+
+static struct i2c_gpio_platform_data ethernut5_i2c_pdata = {
+	.sda_pin		= AT91_PIN_PA23,
+	.sda_is_open_drain	= 1,
+	.scl_pin		= AT91_PIN_PA24,
+	.scl_is_open_drain	= 1,
+	.udelay			= 10,
+};
+
+static struct platform_device ethernut5_twi_device = {
+	.name			= "i2c-gpio",
+	.id			= -1,
+	.dev.platform_data	= &ethernut5_i2c_pdata,
+};
+
+static void __init ethernut5_add_device_i2c(struct i2c_board_info *devices,
+						int nr_devices)
+{
+	at91_set_GPIO_periph(AT91_PIN_PA23, 1);
+	at91_set_multi_drive(AT91_PIN_PA23, 1);
+
+	at91_set_GPIO_periph(AT91_PIN_PA24, 1);
+	at91_set_multi_drive(AT91_PIN_PA24, 1);
+
+	i2c_register_board_info(0, devices, nr_devices);
+	platform_device_register(&ethernut5_twi_device);
+}
+
+static void __init ethernut5_board_init(void)
+{
+	/* I2C needed for power management of other devices */
+	ethernut5_add_device_i2c(ethernut5_i2c_devices,
+				ARRAY_SIZE(ethernut5_i2c_devices));
+	/* Serial */
+	at91_add_device_serial();
+	/* USB Host */
+	at91_add_device_usbh(&ethernut5_usbh_data);
+	/* USB Device */
+	at91_add_device_udc(&ethernut5_udc_data);
+	/* SPI */
+	at91_add_device_spi(ethernut5_spi_devices,
+				ARRAY_SIZE(ethernut5_spi_devices));
+	/* NAND */
+	ethernut5_add_device_nand();
+	/* Ethernet */
+	at91_add_device_eth(&ethernut5_macb_data);
+	/* MMC */
+	at91_add_device_mmc(0, &ethernut5_mmc_data);
+}
+
+MACHINE_START(ETHERNUT5, "Ethernut 5")
+	/* Maintainer: egnite GmbH <info@egnite.de> */
+	.atag_offset = 0x100,
+	.timer		= &at91sam926x_timer,
+	.init_early	= ethernut5_init_early,
+	.init_machine	= ethernut5_board_init,
+	.map_io		= at91_map_io,
+	.init_irq	= at91_init_irq_default,
+MACHINE_END
-- 
1.7.1
