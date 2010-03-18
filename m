From: christian.glindkamp@taskit.de (Christian Glindkamp)
Date: Thu, 18 Mar 2010 12:40:15 +0100
Subject: [PATCH 1/2] AT91: taskit PortuxG20 and Stamp9G20 board support
In-Reply-To: <1268912416-4886-1-git-send-email-christian.glindkamp@taskit.de>
References: <1268912416-4886-1-git-send-email-christian.glindkamp@taskit.de>
Message-ID: <1268912416-4886-2-git-send-email-christian.glindkamp@taskit.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both boards share the same board file, as the PortuxG20 is basically an
SBC based on the Stamp9G20.

Signed-off-by: Christian Glindkamp <christian.glindkamp@taskit.de>
---
 arch/arm/mach-at91/Kconfig           |   15 ++
 arch/arm/mach-at91/Makefile          |    2 +
 arch/arm/mach-at91/board-stamp9g20.c |  315 ++++++++++++++++++++++++++++++++++
 3 files changed, 332 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-at91/board-stamp9g20.c

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 2db43a5..57dc9d8 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -360,6 +360,21 @@ config MACH_CPU9G20
 	  Select this if you are using a Eukrea Electromatique's
 	  CPU9G20 Board <http://www.eukrea.com/>
 
+config MACH_PORTUXG20
+	bool "taskit PortuxG20"
+	depends on ARCH_AT91SAM9G20
+	help
+	  Select this if you are using taskit's PortuxG20.
+	  <http://www.taskit.de/en/>
+
+config MACH_STAMP9G20
+	bool "taskit Stamp9G20 CPU module"
+	depends on ARCH_AT91SAM9G20
+	help
+	  Select this if you are using taskit's Stamp9G20 CPU module on its
+	  evaluation board.
+	  <http://www.taskit.de/en/>
+
 endif
 
 # ----------------------------------------------------------
diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index 027dd57..1df9ee1 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -63,6 +63,8 @@ obj-$(CONFIG_MACH_AT91SAM9RLEK)	+= board-sam9rlek.o
 obj-$(CONFIG_MACH_AT91SAM9G20EK) += board-sam9g20ek.o
 obj-$(CONFIG_MACH_AT91SAM9G20EK_2MMC) += board-sam9g20ek-2slot-mmc.o
 obj-$(CONFIG_MACH_CPU9G20)	+= board-cpu9krea.o
+obj-$(CONFIG_MACH_STAMP9G20)	+= board-stamp9g20.o
+obj-$(CONFIG_MACH_PORTUXG20)	+= board-stamp9g20.o
 
 # AT91SAM9G45 board-specific support
 obj-$(CONFIG_MACH_AT91SAM9G45EKES) += board-sam9m10g45ek.o
diff --git a/arch/arm/mach-at91/board-stamp9g20.c b/arch/arm/mach-at91/board-stamp9g20.c
new file mode 100644
index 0000000..1b94c1e
--- /dev/null
+++ b/arch/arm/mach-at91/board-stamp9g20.c
@@ -0,0 +1,315 @@
+/*
+ *  Copyright (C) 2010 Christian Glindkamp <christian.glindkamp@taskit.de>
+ *                     taskit GmbH
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
+#include <linux/mm.h>
+#include <linux/platform_device.h>
+#include <linux/w1-gpio.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+
+#include <mach/board.h>
+#include <mach/gpio.h>
+#include <mach/at91sam9_smc.h>
+
+#include "sam9_smc.h"
+#include "generic.h"
+
+
+static void __init portuxg20_map_io(void)
+{
+	/* Initialize processor: 18.432 MHz crystal */
+	at91sam9260_initialize(18432000);
+
+	/* DGBU on ttyS0. (Rx & Tx only) */
+	at91_register_uart(0, 0, 0);
+
+	/* USART0 on ttyS1. (Rx, Tx, CTS, RTS, DTR, DSR, DCD, RI) */
+	at91_register_uart(AT91SAM9260_ID_US0, 1, ATMEL_UART_CTS | ATMEL_UART_RTS
+						| ATMEL_UART_DTR | ATMEL_UART_DSR
+						| ATMEL_UART_DCD | ATMEL_UART_RI);
+
+	/* USART1 on ttyS2. (Rx, Tx, CTS, RTS) */
+	at91_register_uart(AT91SAM9260_ID_US1, 2, ATMEL_UART_CTS | ATMEL_UART_RTS);
+
+	/* USART2 on ttyS3. (Rx, Tx, CTS, RTS) */
+	at91_register_uart(AT91SAM9260_ID_US2, 3, ATMEL_UART_CTS | ATMEL_UART_RTS);
+
+	/* USART4 on ttyS5. (Rx, Tx only) */
+	at91_register_uart(AT91SAM9260_ID_US4, 5, 0);
+
+	/* USART5 on ttyS6. (Rx, Tx only) */
+	at91_register_uart(AT91SAM9260_ID_US5, 6, 0);
+
+	/* set serial console to ttyS0 (ie, DBGU) */
+	at91_set_serial_console(0);
+}
+
+static void __init stamp9g20_map_io(void)
+{
+	/* Initialize processor: 18.432 MHz crystal */
+	at91sam9260_initialize(18432000);
+
+	/* DGBU on ttyS0. (Rx & Tx only) */
+	at91_register_uart(0, 0, 0);
+
+	/* USART0 on ttyS1. (Rx, Tx, CTS, RTS, DTR, DSR, DCD, RI) */
+	at91_register_uart(AT91SAM9260_ID_US0, 1, ATMEL_UART_CTS | ATMEL_UART_RTS
+						| ATMEL_UART_DTR | ATMEL_UART_DSR
+						| ATMEL_UART_DCD | ATMEL_UART_RI);
+
+	/* set serial console to ttyS0 (ie, DBGU) */
+	at91_set_serial_console(0);
+}
+
+static void __init init_irq(void)
+{
+	at91sam9260_init_interrupts(NULL);
+}
+
+
+/*
+ * NAND flash
+ */
+static struct atmel_nand_data __initdata nand_data = {
+	.ale		= 21,
+	.cle		= 22,
+	.rdy_pin	= AT91_PIN_PC13,
+	.enable_pin	= AT91_PIN_PC14,
+	.bus_width_16	= 0,
+};
+
+static struct sam9_smc_config __initdata nand_smc_config = {
+	.ncs_read_setup		= 0,
+	.nrd_setup		= 2,
+	.ncs_write_setup	= 0,
+	.nwe_setup		= 2,
+
+	.ncs_read_pulse		= 4,
+	.nrd_pulse		= 4,
+	.ncs_write_pulse	= 4,
+	.nwe_pulse		= 4,
+
+	.read_cycle		= 7,
+	.write_cycle		= 7,
+
+	.mode			= AT91_SMC_READMODE | AT91_SMC_WRITEMODE | AT91_SMC_EXNWMODE_DISABLE | AT91_SMC_DBW_8,
+	.tdf_cycles		= 3,
+};
+
+static void __init add_device_nand(void)
+{
+	/* configure chip-select 3 (NAND) */
+	sam9_smc_configure(3, &nand_smc_config);
+
+	at91_add_device_nand(&nand_data);
+}
+
+
+/*
+ * MCI (SD/MMC)
+ * det_pin, wp_pin and vcc_pin are not connected
+ */
+#if defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
+static struct mci_platform_data __initdata mmc_data = {
+	.slot[0] = {
+		.bus_width	= 4,
+	},
+};
+#else
+static struct at91_mmc_data __initdata mmc_data = {
+	.slot_b		= 0,
+	.wire4		= 1,
+};
+#endif
+
+
+/*
+ * USB Host port
+ */
+static struct at91_usbh_data __initdata usbh_data = {
+	.ports		= 2,
+};
+
+
+/*
+ * USB Device port
+ */
+static struct at91_udc_data __initdata portuxg20_udc_data = {
+	.vbus_pin	= AT91_PIN_PC7,
+	.pullup_pin	= 0,		/* pull-up driven by UDC */
+};
+
+static struct at91_udc_data __initdata stamp9g20_udc_data = {
+	.vbus_pin	= AT91_PIN_PA22,
+	.pullup_pin	= 0,		/* pull-up driven by UDC */
+};
+
+
+/*
+ * MACB Ethernet device
+ */
+static struct at91_eth_data __initdata macb_data = {
+	.phy_irq_pin	= AT91_PIN_PA28,
+	.is_rmii	= 1,
+};
+
+
+/*
+ * LEDs
+ */
+static struct gpio_led portuxg20_leds[] = {
+	{
+		.name			= "LED2",
+		.gpio			= AT91_PIN_PC5,
+		.default_trigger	= "none",
+	}, {
+		.name			= "LED3",
+		.gpio			= AT91_PIN_PC4,
+		.default_trigger	= "none",
+	}, {
+		.name			= "LED4",
+		.gpio			= AT91_PIN_PC10,
+		.default_trigger	= "heartbeat",
+	}
+};
+
+static struct gpio_led stamp9g20_leds[] = {
+	{
+		.name			= "D8",
+		.gpio			= AT91_PIN_PB18,
+		.active_low		= 1,
+		.default_trigger	= "none",
+	}, {
+		.name			= "D9",
+		.gpio			= AT91_PIN_PB19,
+		.active_low		= 1,
+		.default_trigger	= "none",
+	}, {
+		.name			= "D10",
+		.gpio			= AT91_PIN_PB20,
+		.active_low		= 1,
+		.default_trigger	= "heartbeat",
+	}
+};
+
+
+/*
+ * SPI devices
+ */
+static struct spi_board_info portuxg20_spi_devices[] = {
+	{
+		.modalias	= "spidev",
+		.chip_select	= 0,
+		.max_speed_hz	= 1 * 1000 * 1000,
+		.bus_num	= 0,
+	}, {
+		.modalias	= "spidev",
+		.chip_select	= 0,
+		.max_speed_hz	= 1 * 1000 * 1000,
+		.bus_num	= 1,
+	},
+};
+
+
+/*
+ * Dallas 1-Wire
+ */
+static struct w1_gpio_platform_data w1_gpio_pdata = {
+	.pin		= AT91_PIN_PA29,
+	.is_open_drain	= 1,
+};
+
+static struct platform_device w1_device = {
+	.name			= "w1-gpio",
+	.id			= -1,
+	.dev.platform_data	= &w1_gpio_pdata,
+};
+
+void add_w1(void)
+{
+	at91_set_GPIO_periph(w1_gpio_pdata.pin, 1);
+	at91_set_multi_drive(w1_gpio_pdata.pin, 1);
+	platform_device_register(&w1_device);
+}
+
+
+static void __init generic_board_init(void)
+{
+	/* Serial */
+	at91_add_device_serial();
+	/* NAND */
+	add_device_nand();
+	/* MMC */
+#if defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
+	at91_add_device_mci(0, &mmc_data);
+#else
+	at91_add_device_mmc(0, &mmc_data);
+#endif
+	/* USB Host */
+	at91_add_device_usbh(&usbh_data);
+	/* Ethernet */
+	at91_add_device_eth(&macb_data);
+	/* I2C */
+	at91_add_device_i2c(NULL, 0);
+	/* W1 */
+	add_w1();
+}
+
+static void __init portuxg20_board_init(void)
+{
+	generic_board_init();
+	/* SPI */
+	at91_add_device_spi(portuxg20_spi_devices, ARRAY_SIZE(portuxg20_spi_devices));
+	/* USB Device */
+	at91_add_device_udc(&portuxg20_udc_data);
+	/* LEDs */
+	at91_gpio_leds(portuxg20_leds, ARRAY_SIZE(portuxg20_leds));
+}
+
+static void __init stamp9g20_board_init(void)
+{
+	generic_board_init();
+	/* USB Device */
+	at91_add_device_udc(&stamp9g20_udc_data);
+	/* LEDs */
+	at91_gpio_leds(stamp9g20_leds, ARRAY_SIZE(stamp9g20_leds));
+}
+
+MACHINE_START(PORTUXG20, "taskit PortuxG20")
+	/* Maintainer: taskit GmbH */
+	.phys_io	= AT91_BASE_SYS,
+	.io_pg_offst	= (AT91_VA_BASE_SYS >> 18) & 0xfffc,
+	.boot_params	= AT91_SDRAM_BASE + 0x100,
+	.timer		= &at91sam926x_timer,
+	.map_io		= portuxg20_map_io,
+	.init_irq	= init_irq,
+	.init_machine	= portuxg20_board_init,
+MACHINE_END
+
+MACHINE_START(STAMP9G20, "taskit Stamp9G20")
+	/* Maintainer: taskit GmbH */
+	.phys_io	= AT91_BASE_SYS,
+	.io_pg_offst	= (AT91_VA_BASE_SYS >> 18) & 0xfffc,
+	.boot_params	= AT91_SDRAM_BASE + 0x100,
+	.timer		= &at91sam926x_timer,
+	.map_io		= stamp9g20_map_io,
+	.init_irq	= init_irq,
+	.init_machine	= stamp9g20_board_init,
+MACHINE_END
-- 
1.6.4.4
