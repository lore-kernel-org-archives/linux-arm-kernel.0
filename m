From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 15 Nov 2013 15:49:58 +0100
Subject: [PATCH 03/11] ARM: at91: switch carmeva to DT
In-Reply-To: <1384527006-9040-1-git-send-email-plagnioj@jcrosoft.com>
References: <20131115143855.GR28304@ns203013.ovh.net>
 <1384527006-9040-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1384527006-9040-3-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/Makefile            |   1 +
 arch/arm/boot/dts/at91-carmeva.dts    | 150 ++++++++++++++++++++++++++++++
 arch/arm/configs/at91rm9200_defconfig |   1 -
 arch/arm/mach-at91/Kconfig.non_dt     |   6 --
 arch/arm/mach-at91/Makefile           |   1 -
 arch/arm/mach-at91/board-carmeva.c    | 166 ----------------------------------
 6 files changed, 151 insertions(+), 174 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91-carmeva.dts
 delete mode 100644 arch/arm/mach-at91/board-carmeva.c

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index f1fb6d7..5724a51 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -4,6 +4,7 @@ ifeq ($(CONFIG_OF),y)
 # rm9200
 dtb-$(CONFIG_ARCH_AT91) += at91rm9200ek.dtb
 dtb-$(CONFIG_ARCH_AT91) += at91-1arm.dtb
+dtb-$(CONFIG_ARCH_AT91) += at91-carmeva.dtb
 dtb-$(CONFIG_ARCH_AT91) += mpa1600.dtb
 # sam9260
 dtb-$(CONFIG_ARCH_AT91) += animeo_ip.dtb
diff --git a/arch/arm/boot/dts/at91-carmeva.dts b/arch/arm/boot/dts/at91-carmeva.dts
new file mode 100644
index 0000000..bbf8f31
--- /dev/null
+++ b/arch/arm/boot/dts/at91-carmeva.dts
@@ -0,0 +1,150 @@
+/*
+ * at91-carmeva.dts - Device Tree file for Conitec Datasystems Carmeva board
+ *
+ * Copyright (C) 2013 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
+ *
+ * Licensed under GPLv2 only
+ */
+/dts-v1/;
+#include "at91rm9200.dtsi"
+
+/ {
+	model = "Conitec Datasystems Carmeva board";
+	compatible = "conitec,carmeva", "atmel,at91rm9200";
+
+	memory {
+		reg = <0x20000000 0x4000000>;
+	};
+
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		main_clock: clock at 0 {
+			compatible = "atmel,osc", "fixed-clock";
+			clock-frequency = <20000000>;
+		};
+	};
+
+	ahb {
+		apb {
+			dbgu: serial at fffff200 {
+				status = "okay";
+			};
+
+			usart1: serial at fffc4000 {
+				pinctrl-0 =
+						<&pinctrl_uart1
+						 &pinctrl_uart1_rts
+						 &pinctrl_uart1_cts
+						 &pinctrl_uart1_dtr_dsr
+						 &pinctrl_uart1_dcd
+						 &pinctrl_uart1_ri>;
+				status = "okay";
+			};
+
+			macb0: ethernet at fffbc000 {
+				phy-mode = "rmii";
+				/* phy irq PC4 */
+				status = "okay";
+			};
+
+			usb1: gadget at fffb0000 {
+				atmel,vbus-gpio = <&pioD 12 GPIO_ACTIVE_HIGH>;
+				atmel,pullup-gpio = <&pioD 9 GPIO_ACTIVE_HIGH>;
+				status = "okay";
+			};
+
+			mmc0: mmc at fffb4000 {
+				pinctrl-0 = <
+					&pinctrl_board_mmc0
+					&pinctrl_mmc0_clk
+					&pinctrl_mmc0_slot0_cmd_dat0
+					&pinctrl_mmc0_slot0_dat1_3>;
+				status = "okay";
+				slot at 0 {
+					reg = <0>;
+					bus-width = <4>;
+					cd-gpios = <&pioB 10 GPIO_ACTIVE_HIGH>;
+					wp-gpios = <&pioC 14 GPIO_ACTIVE_HIGH>;
+				};
+			};
+
+			pinctrl at fffff400 {
+				mmc0 {
+					pinctrl_board_mmc0: mmc0-board {
+						atmel,pins =
+							<AT91_PIOB 10 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH
+							 AT91_PIOC 14 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;
+					};
+				};
+			};
+
+			spi0: spi at fffe0000 {
+				status = "okay";
+				cs-gpios = <&pioA 3 GPIO_ACTIVE_HIGH>,
+					   <&pioA 4 GPIO_ACTIVE_HIGH>,
+					   <&pioA 5 GPIO_ACTIVE_HIGH>,
+					   <&pioA 6 GPIO_ACTIVE_HIGH>;
+				mtd_dataflash at 0 {
+					compatible = "atmel,at45", "atmel,dataflash";
+					spi-max-frequency = <10000000>;
+					reg = <0>;
+				};
+
+				spidev at 1 {
+					compatible = "spidev";
+					spi-max-frequency = <250000>;
+					reg = <1>;
+				};
+
+				spidev at 2 {
+					compatible = "spidev";
+					spi-max-frequency = <1000000>;
+					reg = <2>;
+				};
+
+				spidev at 3 {
+					compatible = "spidev";
+					spi-max-frequency = <10000000>;
+					reg = <3>;
+				};
+			};
+		};
+
+		usb0: ohci at 00300000 {
+			num-ports = <2>;
+			status = "okay";
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led9 {
+			label = "led9";
+			gpios = <&pioA 21 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		led10 {
+			label = "led10";
+			gpios = <&pioA 25 GPIO_ACTIVE_LOW>;
+		};
+
+		led11 {
+			label = "led11";
+			gpios = <&pioA 26 GPIO_ACTIVE_LOW>;
+		};
+
+		led12 {
+			label = "led12";
+			gpios = <&pioA 18 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	i2c at 0 {
+		status = "okay";
+	};
+};
diff --git a/arch/arm/configs/at91rm9200_defconfig b/arch/arm/configs/at91rm9200_defconfig
index d333250..3b76a63 100644
--- a/arch/arm/configs/at91rm9200_defconfig
+++ b/arch/arm/configs/at91rm9200_defconfig
@@ -20,7 +20,6 @@ CONFIG_ARCH_AT91RM9200=y
 CONFIG_MACH_AT91RM9200EK=y
 CONFIG_MACH_CSB337=y
 CONFIG_MACH_CSB637=y
-CONFIG_MACH_CARMEVA=y
 CONFIG_MACH_ATEB9200=y
 CONFIG_MACH_KB9200=y
 CONFIG_MACH_PICOTUX2XX=y
diff --git a/arch/arm/mach-at91/Kconfig.non_dt b/arch/arm/mach-at91/Kconfig.non_dt
index 4dcf706..867c547 100644
--- a/arch/arm/mach-at91/Kconfig.non_dt
+++ b/arch/arm/mach-at91/Kconfig.non_dt
@@ -75,12 +75,6 @@ config MACH_CSB637
 	  Select this if you are using Cogent's CSB637 board.
 	  <http://www.cogcomp.com/csb_csb637.htm>
 
-config MACH_CARMEVA
-	bool "Conitec ARM&EVA"
-	help
-	  Select this if you are using Conitec's AT91RM9200-MCU-Module.
-	  <http://www.conitec.net/english/linuxboard.php>
-
 config MACH_ATEB9200
 	bool "Embest ATEB9200"
 	help
diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index 5c5534c..dc2308b 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -36,7 +36,6 @@ obj-$(CONFIG_ARCH_AT91X40)	+= at91x40.o at91x40_time.o
 obj-$(CONFIG_MACH_AT91RM9200EK)	+= board-rm9200ek.o
 obj-$(CONFIG_MACH_CSB337)	+= board-csb337.o
 obj-$(CONFIG_MACH_CSB637)	+= board-csb637.o
-obj-$(CONFIG_MACH_CARMEVA)	+= board-carmeva.o
 obj-$(CONFIG_MACH_KB9200)	+= board-kb9202.o
 obj-$(CONFIG_MACH_ATEB9200)	+= board-eb9200.o
 obj-$(CONFIG_MACH_KAFA)		+= board-kafa.o
diff --git a/arch/arm/mach-at91/board-carmeva.c b/arch/arm/mach-at91/board-carmeva.c
deleted file mode 100644
index 9298305..0000000
--- a/arch/arm/mach-at91/board-carmeva.c
+++ /dev/null
@@ -1,166 +0,0 @@
-/*
- * linux/arch/arm/mach-at91/board-carmeva.c
- *
- *  Copyright (c) 2005 Peer Georgi
- *  		       Conitec Datasystems
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-#include <linux/types.h>
-#include <linux/gpio.h>
-#include <linux/init.h>
-#include <linux/mm.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-
-#include <asm/setup.h>
-#include <asm/mach-types.h>
-#include <asm/irq.h>
-
-#include <asm/mach/arch.h>
-#include <asm/mach/map.h>
-#include <asm/mach/irq.h>
-
-#include <mach/hardware.h>
-
-#include "at91_aic.h"
-#include "board.h"
-#include "generic.h"
-
-
-static void __init carmeva_init_early(void)
-{
-	/* Initialize processor: 20.000 MHz crystal */
-	at91_initialize(20000000);
-}
-
-static struct macb_platform_data __initdata carmeva_eth_data = {
-	.phy_irq_pin	= AT91_PIN_PC4,
-	.is_rmii	= 1,
-};
-
-static struct at91_usbh_data __initdata carmeva_usbh_data = {
-	.ports		= 2,
-	.vbus_pin	= {-EINVAL, -EINVAL},
-	.overcurrent_pin= {-EINVAL, -EINVAL},
-};
-
-static struct at91_udc_data __initdata carmeva_udc_data = {
-	.vbus_pin	= AT91_PIN_PD12,
-	.pullup_pin	= AT91_PIN_PD9,
-};
-
-/* FIXME: user dependent */
-// static struct at91_cf_data __initdata carmeva_cf_data = {
-//	.det_pin	= AT91_PIN_PB0,
-//	.rst_pin	= AT91_PIN_PC5,
-	// .irq_pin	= -EINVAL,
-	// .vcc_pin	= -EINVAL,
-// };
-
-static struct mci_platform_data __initdata carmeva_mci0_data = {
-	.slot[0] = {
-		.bus_width	= 4,
-		.detect_pin	= AT91_PIN_PB10,
-		.wp_pin		= AT91_PIN_PC14,
-	},
-};
-
-static struct spi_board_info carmeva_spi_devices[] = {
-	{ /* DataFlash chip */
-		.modalias = "mtd_dataflash",
-		.chip_select  = 0,
-		.max_speed_hz = 10 * 1000 * 1000,
-	},
-	{ /* User accessible spi - cs1 (250KHz) */
-		.modalias = "spi-cs1",
-		.chip_select  = 1,
-		.max_speed_hz = 250 *  1000,
-	},
-	{ /* User accessible spi - cs2 (1MHz) */
-		.modalias = "spi-cs2",
-		.chip_select  = 2,
-		.max_speed_hz = 1 * 1000 *  1000,
-	},
-	{ /* User accessible spi - cs3 (10MHz) */
-		.modalias = "spi-cs3",
-		.chip_select  = 3,
-		.max_speed_hz = 10 * 1000 *  1000,
-	},
-};
-
-static struct gpio_led carmeva_leds[] = {
-	{ /* "user led 1", LED9 */
-		.name			= "led9",
-		.gpio			= AT91_PIN_PA21,
-		.active_low		= 1,
-		.default_trigger	= "heartbeat",
-	},
-	{ /* "user led 2", LED10 */
-		.name			= "led10",
-		.gpio			= AT91_PIN_PA25,
-		.active_low		= 1,
-	},
-	{ /* "user led 3", LED11 */
-		.name			= "led11",
-		.gpio			= AT91_PIN_PA26,
-		.active_low		= 1,
-	},
-	{ /* "user led 4", LED12 */
-		.name			= "led12",
-		.gpio			= AT91_PIN_PA18,
-		.active_low		= 1,
-	}
-};
-
-static void __init carmeva_board_init(void)
-{
-	/* Serial */
-	/* DBGU on ttyS0. (Rx & Tx only) */
-	at91_register_uart(0, 0, 0);
-
-	/* USART1 on ttyS1. (Rx, Tx, CTS, RTS, DTR, DSR, DCD, RI) */
-	at91_register_uart(AT91RM9200_ID_US1, 1, ATMEL_UART_CTS | ATMEL_UART_RTS
-			   | ATMEL_UART_DTR | ATMEL_UART_DSR | ATMEL_UART_DCD
-			   | ATMEL_UART_RI);
-	at91_add_device_serial();
-	/* Ethernet */
-	at91_add_device_eth(&carmeva_eth_data);
-	/* USB Host */
-	at91_add_device_usbh(&carmeva_usbh_data);
-	/* USB Device */
-	at91_add_device_udc(&carmeva_udc_data);
-	/* I2C */
-	at91_add_device_i2c(NULL, 0);
-	/* SPI */
-	at91_add_device_spi(carmeva_spi_devices, ARRAY_SIZE(carmeva_spi_devices));
-	/* Compact Flash */
-//	at91_add_device_cf(&carmeva_cf_data);
-	/* MMC */
-	at91_add_device_mci(0, &carmeva_mci0_data);
-	/* LEDs */
-	at91_gpio_leds(carmeva_leds, ARRAY_SIZE(carmeva_leds));
-}
-
-MACHINE_START(CARMEVA, "Carmeva")
-	/* Maintainer: Conitec Datasystems */
-	.init_time	= at91rm9200_timer_init,
-	.map_io		= at91_map_io,
-	.handle_irq	= at91_aic_handle_irq,
-	.init_early	= carmeva_init_early,
-	.init_irq	= at91_init_irq_default,
-	.init_machine	= carmeva_board_init,
-MACHINE_END
-- 
1.8.4.rc3
