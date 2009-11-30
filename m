From: derkling@gmail.com (Patrick Bellasi)
Date: Mon, 30 Nov 2009 10:48:05 +0100
Subject: [PATCH 2/3] [AT91] Add support for the Daricom C3-Ax03 board
In-Reply-To: <1259574486-13391-2-git-send-email-derkling@gmail.com>
References: <20091129234917.GB18841@game.jcrosoft.org>
	<1259574486-13391-1-git-send-email-derkling@gmail.com>
	<1259574486-13391-2-git-send-email-derkling@gmail.com>
Message-ID: <1259574486-13391-3-git-send-email-derkling@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add initial support for the Daricom C3-Ax03 board.

Signed-off-by: Patrick Bellasi <derkling@gmail.com
---
 arch/arm/mach-at91/Kconfig        |    6 +
 arch/arm/mach-at91/Makefile       |    1 +
 arch/arm/mach-at91/board-c3ax03.c |  364 +++++++++++++++++++++++++++++++++++++
 3 files changed, 371 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-at91/board-c3ax03.c

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 2fd8843..7cfc4e6 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -231,6 +231,12 @@ config MACH_CPU9260
 	  Select this if you are using a Eukrea Electromatique's
 	  CPU9260 Board <http://www.eukrea.com/>
 
+config MACH_C3AX03
+	bool "Daricom C3-Ax03 board"
+	help
+	  Select this if you are using the Daricom C3-Ax03 Ex Telemetry Device.
+	  <http://www.daricom.it>
+
 endif
 
 # ----------------------------------------------------------
diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index ada440a..4f74746 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_MACH_USB_A9260)	+= board-usb-a9260.o
 obj-$(CONFIG_MACH_QIL_A9260)	+= board-qil-a9260.o
 obj-$(CONFIG_MACH_AFEB9260)	+= board-afeb-9260v1.o
 obj-$(CONFIG_MACH_CPU9260)	+= board-cpu9krea.o
+obj-$(CONFIG_MACH_C3AX03)	+= board-c3ax03.o
 
 # AT91SAM9261 board-specific support
 obj-$(CONFIG_MACH_AT91SAM9261EK) += board-sam9261ek.o
diff --git a/arch/arm/mach-at91/board-c3ax03.c b/arch/arm/mach-at91/board-c3ax03.c
new file mode 100644
index 0000000..b172233
--- /dev/null
+++ b/arch/arm/mach-at91/board-c3ax03.c
@@ -0,0 +1,364 @@
+/*
+ * linux/arch/arm/mach-at91/board-c3ax03.c
+ *
+ * Adapted from various board files in arch/arm/mach-at91
+ *
+ *  Copyright (C) 2009-2010 Patrick Bellasi (derkling at gmail.com)
+ *  Copyright (C) 2009-2010 Daricom srl (www.daricom.it)
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
+#include <linux/input.h>
+#include <linux/gpio_keys.h>
+#include <linux/i2c.h>
+#include <linux/i2c/pca953x.h>
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
+
+#include "sam9_smc.h"
+#include "generic.h"
+
+static void __init c3ax03_map_io(void)
+{
+	/* Initialize processor: 18.432 MHz crystal */
+	at91sam9260_initialize(18432000);
+
+	/* DGBU on ttyS0. (Rx & Tx only) */
+	at91_register_uart(0, 0, 0);
+
+	/* USART0 on ttyS1. (Rx, Tx, CTS, RTS, DTR, DSR, DCD, RI) */
+	at91_register_uart(AT91SAM9260_ID_US0, 1, ATMEL_UART_CTS |
+			ATMEL_UART_RTS | ATMEL_UART_DTR | ATMEL_UART_DSR |
+			ATMEL_UART_DCD | ATMEL_UART_RI);
+
+	/* USART1 on ttyS2. (Rx, Tx, CTS, RTS, DTR, DSR, DCD, RI) */
+	at91_register_uart(AT91SAM9260_ID_US1, 2, ATMEL_UART_CTS |
+			ATMEL_UART_RTS | ATMEL_UART_DTR | ATMEL_UART_DSR |
+			ATMEL_UART_DCD | ATMEL_UART_RI);
+
+	/* USART2 on ttyS3. (Rx & Tx only) */
+	at91_register_uart(AT91SAM9260_ID_US2, 3, 0);
+
+	/* USART3 on ttyS4. (Rx, Tx, RTS, CTS) */
+	at91_register_uart(AT91SAM9260_ID_US3, 4, ATMEL_UART_CTS |
+			ATMEL_UART_RTS);
+
+	/* set serial console to ttyS0 (ie, DBGU) */
+	at91_set_serial_console(0);
+}
+
+static void __init c3ax03_init_irq(void)
+{
+	at91sam9260_init_interrupts(NULL);
+}
+
+/*
+ * USB Host port
+ */
+static struct at91_usbh_data __initdata c3ax03_usbh_data = {
+	.ports		= 1, 		/* PQFP version of AT91SAM9260 */
+};
+
+/*
+ * USB Device port
+ */
+static struct at91_udc_data __initdata c3ax03_udc_data = {
+	.vbus_pin	= AT91_PIN_PC5,
+	.pullup_pin	= 1,		/* using external pull-up */
+};
+
+/*
+* I2C
+*/
+static struct pca953x_platform_data c3ax03_gpio_ext_pdata_0 = {
+	.gpio_base = 0, /* PCA9555 */
+};
+
+static struct i2c_board_info __initdata c3ax03_i2c_devices[] = {
+    {	/* PCA9555: 16-bit I2C-bus and SMBus I/O port with interrupt */
+	I2C_BOARD_INFO("pca9555", 0x27),
+	.platform_data = &c3ax03_gpio_ext_pdata_0,
+    },
+};
+
+/*
+ * NAND devices
+ */
+static struct mtd_partition __initdata c3ax03_nand_partitions[] = {
+	{	/* 16 KB */
+		.name	= "AT91Bootstrap",
+		.offset	= 0,
+		.size	= 16 * 1024,
+	},
+	{	/* 16 KB, offset 0x4000 */
+		.name	= "UBoot-env",
+		.offset	= MTDPART_OFS_NXTBLK,
+		.size	= 16 * 1024,
+	},
+	{
+		/* 224 KB, offset 0x8000 */
+		.name	= "UBoot",
+		.offset	= MTDPART_OFS_NXTBLK,
+		.size	= 224 * 1024,
+	},
+	{	/*  2048 KB, offset 0x40000 */
+		.name	= "Kernel",
+		.offset	= MTDPART_OFS_NXTBLK,
+		.size	= 2048 * 1024,
+	},
+	{	/* Up to flash size (default 32MB), offset 0x240000 */
+		.name	= "Filesystem",
+		.offset	= MTDPART_OFS_NXTBLK,
+		.size	= MTDPART_SIZ_FULL,
+	}
+};
+
+static struct mtd_partition * __init c3ax03_nand_partinfo(int size, int
+		*num_partitions)
+{
+	*num_partitions = ARRAY_SIZE(c3ax03_nand_partitions);
+	return c3ax03_nand_partitions;
+}
+
+static struct atmel_nand_data __initdata c3ax03_nand_data = {
+	.ale		= 21,
+	.cle		= 22,
+	.rdy_pin	= AT91_PIN_PC13,
+	.enable_pin	= AT91_PIN_PC14,
+	.partition_info	= c3ax03_nand_partinfo,
+	.bus_width_16	= 0,
+};
+
+static struct sam9_smc_config __initdata c3ax03_nand_smc_config = {
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
+		AT91_SMC_EXNWMODE_DISABLE | AT91_SMC_DBW_8,
+
+	.tdf_cycles		= 2,
+};
+
+static void __init c3ax03_add_device_nand(void)
+{
+
+	/* configure chip-select 3 (PC14) */
+	sam9_smc_configure(3, &c3ax03_nand_smc_config);
+
+	at91_add_device_nand(&c3ax03_nand_data);
+}
+
+
+/*
+ * MACB Ethernet device
+ */
+static struct at91_eth_data __initdata c3ax03_macb_data = {
+	.phy_irq_pin	= AT91_PIN_PA7,
+	.is_rmii	= 0,
+	.use_twi_pins	= 0,
+};
+
+
+/*
+ * MCI (SD/MMC)
+ */
+static struct at91_mmc_data __initdata c3ax03_mmc_data = {
+	.slot_b		= 1,
+	.wire4		= 1,
+};
+
+/*
+ * LEDs
+ */
+static struct gpio_led c3ax03_leds[] = {
+	{	/* "bottom" led, green, userled1 to be defined */
+		.name			= "led:cpu",
+		.gpio			= AT91_PIN_PB18,
+		.active_low		= 1,
+		.default_trigger	= "none",
+	},
+	{	/* "power" led, yellow */
+		.name			= "led:heartbeat",
+		.gpio			= AT91_PIN_PB19,
+		.default_trigger	= "heartbeat",
+	}
+};
+
+/*
+ * GPIOs
+ */
+static struct gpio_keys_button c3ax03_buttons[] = {
+	{
+		.gpio           = AT91_PIN_PC0, 	/*PA9*/
+		.code           = 0x00,
+		.desc           = "Battery Power",
+		.active_low     = 1,
+		.wakeup         = 0,
+	},
+	{
+		.gpio           = AT91_PIN_PC13, 	/*PB13*/
+		.code           = 0x01,
+		.desc           = "OdoCanGps Intr",
+		.active_low     = 1,
+		.wakeup         = 1,
+	},
+	{
+		.gpio           = AT91_PIN_PC15, 	/*PC15*/
+		.code           = 0x02,
+		.desc           = "Digital Intr",
+		.active_low     = 1,
+		.wakeup         = 1,
+	}
+};
+
+static struct gpio_keys_platform_data c3ax03_button_data = {
+	.buttons        = c3ax03_buttons,
+	.nbuttons       = ARRAY_SIZE(c3ax03_buttons),
+};
+
+static struct platform_device c3ax03_button_device = {
+	.name           = "gpio-keys",
+	.id             = -1,
+	.num_resources  = 0,
+	.dev            = {
+		.platform_data  = &c3ax03_button_data,
+	}
+};
+
+static void __init c3ax03_add_device_buttons(void)
+{
+	at91_set_gpio_input(AT91_PIN_PC0, 1);
+	at91_set_deglitch(AT91_PIN_PC0, 1);
+
+	at91_set_gpio_input(AT91_PIN_PC13, 1);
+	at91_set_deglitch(AT91_PIN_PC13, 1);
+
+	at91_set_gpio_input(AT91_PIN_PC15, 1);
+	at91_set_deglitch(AT91_PIN_PC15, 1);
+
+	platform_device_register(&c3ax03_button_device);
+
+};
+
+static void __init c3ax03_init_gpio(void)
+{
+
+	/* USART2 (ttyS3) Multiplexer */
+	gpio_request(AT91_PIN_PB16, "ttyS3_mux0");
+	gpio_request(AT91_PIN_PB17, "ttyS3_mux1");
+	gpio_direction_output(AT91_PIN_PB16, 0);
+	gpio_direction_output(AT91_PIN_PB17, 0);
+	gpio_export(AT91_PIN_PB16, false);
+	gpio_export(AT91_PIN_PB17, false);
+
+	/* ODO-CAN-GPS Reset (Active Low) */
+	gpio_request(AT91_PIN_PB3, "ocg_rst"); /*PB12*/
+	gpio_direction_output(AT91_PIN_PB3, 1);
+	gpio_export(AT91_PIN_PB3, true);
+
+	/* GSM GPIO - User availabled GPIO */
+	gpio_request(AT91_PIN_PC26, "gsm_gpio"); /*PB29*/
+	at91_set_gpio_input(AT91_PIN_PC26, 0);
+	gpio_export(AT91_PIN_PC26, true);
+	/* GSM Reset (Active Low) */
+	gpio_request(AT91_PIN_PC27, "gsm_rst"); /*PB30*/
+	at91_set_gpio_input(AT91_PIN_PC27, 0);
+	gpio_export(AT91_PIN_PC27, true);
+	/* GSM Power (Active Low) */
+	gpio_request(AT91_PIN_PC28, "gsm_pwr"); /*PB31*/
+	at91_set_gpio_input(AT91_PIN_PC28, 0);
+	gpio_export(AT91_PIN_PC28, true);
+
+	/* ADC Multiplexer (Channels 0-14, Default Channel 15 (null input)) */
+	gpio_request(AT91_PIN_PC22, "admux0"); /*PC6*/
+	gpio_request(AT91_PIN_PC23, "admux1"); /*PC7*/
+	gpio_request(AT91_PIN_PC24, "admux2"); /*PC8*/
+	gpio_request(AT91_PIN_PC25, "admux3"); /*PC9*/
+	gpio_direction_output(AT91_PIN_PC22, 1);
+	gpio_direction_output(AT91_PIN_PC23, 1);
+	gpio_direction_output(AT91_PIN_PC24, 1);
+	gpio_direction_output(AT91_PIN_PC25, 1);
+	gpio_export(AT91_PIN_PC22, false);
+	gpio_export(AT91_PIN_PC23, false);
+	gpio_export(AT91_PIN_PC24, false);
+	gpio_export(AT91_PIN_PC25, false);
+
+}
+
+static void __init c3ax03_board_init(void)
+{
+	/* Serial */
+	at91_add_device_serial();
+	/* USB Host */
+	at91_add_device_usbh(&c3ax03_usbh_data);
+	/* USB Device */
+	at91_add_device_udc(&c3ax03_udc_data);
+	/* I2C */
+	at91_add_device_i2c(c3ax03_i2c_devices,
+			ARRAY_SIZE(c3ax03_i2c_devices));
+	/* NAND FLash*/
+	c3ax03_add_device_nand();
+	/* Ethernet */
+	at91_add_device_eth(&c3ax03_macb_data);
+	/* MMC */
+	at91_add_device_mmc(0, &c3ax03_mmc_data);
+	/* LEDs */
+	at91_gpio_leds(c3ax03_leds, ARRAY_SIZE(c3ax03_leds));
+	/* Interrupts */
+	c3ax03_add_device_buttons();
+	/* GPIOs */
+	c3ax03_init_gpio();
+}
+
+MACHINE_START(C3AX03, "Daricom C3-Ax03")
+	/* Maintainer: Patrick Bellasi */
+	.phys_io	= AT91_BASE_SYS,
+	.io_pg_offst	= (AT91_VA_BASE_SYS >> 18) & 0xfffc,
+	.boot_params	= AT91_SDRAM_BASE + 0x100,
+	.timer		= &at91sam926x_timer,
+	.map_io		= c3ax03_map_io,
+	.init_irq	= c3ax03_init_irq,
+	.init_machine	= c3ax03_board_init,
+MACHINE_END
-- 
1.6.3.3
