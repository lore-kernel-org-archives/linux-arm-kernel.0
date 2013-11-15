From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 15 Nov 2013 15:50:04 +0100
Subject: [PATCH 09/11] ARM: at91: switch kb9202 board to DT
In-Reply-To: <1384527006-9040-1-git-send-email-plagnioj@jcrosoft.com>
References: <20131115143855.GR28304@ns203013.ovh.net>
 <1384527006-9040-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1384527006-9040-9-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/Makefile            |   1 +
 arch/arm/boot/dts/at91-kb9202.dts     | 135 +++++++++++++++++++++++++++++
 arch/arm/configs/at91rm9200_defconfig |   1 -
 arch/arm/mach-at91/Kconfig.non_dt     |   6 --
 arch/arm/mach-at91/Makefile           |   1 -
 arch/arm/mach-at91/board-kb9202.c     | 158 ----------------------------------
 6 files changed, 136 insertions(+), 166 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91-kb9202.dts
 delete mode 100644 arch/arm/mach-at91/board-kb9202.c

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index d37d226..bba996a 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -8,6 +8,7 @@ dtb-$(CONFIG_ARCH_AT91) += at91-carmeva.dtb
 dtb-$(CONFIG_ARCH_AT91) += at91-ecbat91.dtb
 dtb-$(CONFIG_ARCH_AT91) += at91-flexibity.dtb
 dtb-$(CONFIG_ARCH_AT91) += at91-kafa.dtb
+dtb-$(CONFIG_ARCH_AT91) += at91-kb9202.dtb
 dtb-$(CONFIG_ARCH_AT91) += at91-picotux-200.dtb
 dtb-$(CONFIG_ARCH_AT91) += at91-rsi-ews.dtb
 dtb-$(CONFIG_ARCH_AT91) += mpa1600.dtb
diff --git a/arch/arm/boot/dts/at91-kb9202.dts b/arch/arm/boot/dts/at91-kb9202.dts
new file mode 100644
index 0000000..8034c9e
--- /dev/null
+++ b/arch/arm/boot/dts/at91-kb9202.dts
@@ -0,0 +1,135 @@
+/*
+ * at91-kb9202.dtb - Device Tree file for RSI EWS board
+ *
+ * Copyright (C) 2013 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
+ *
+ * Licensed under GPLv2 only
+ */
+/dts-v1/;
+#include "at91rm9200_pqfp.dtsi"
+
+/ {
+	model = "KB920x";
+	compatible = "kwikbyte,kb920x", "atmel,at91rm9200-pqfp", "atmel,at91rm9200";
+
+	aliases {
+		serial0 = &dbgu;
+		serial1 = &usart0;
+		serial2 = &usart1;
+		serial3 = &usart3;
+		serial4 = &usart2;
+	};
+
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		main_clock: clock at 0 {
+			compatible = "atmel,osc", "fixed-clock";
+			clock-frequency = <10000000>;
+		};
+	};
+
+	ahb {
+		apb {
+			dbgu: serial at fffff200 {
+				status = "okay";
+			};
+
+			usart0: serial at fffc0000 {
+				status = "okay";
+			};
+
+			usart1: serial at fffc4000 {
+				status = "okay";
+			};
+
+			usart3: serial at fffcc000 {
+				pinctrl-0 =
+						<&pinctrl_uart3
+						 &pinctrl_uart3_cts
+						 &pinctrl_uart3_rts>;
+				status = "okay";
+			};
+
+			macb0: ethernet at fffbc000 {
+				phy-mode = "mii";
+				status = "okay";
+				/* phy irq on PB29 */
+				pinctrl-0 = <&pinctrl_macb_rmii &pinctrl_macb_rmii_mii>;
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
+					cd-gpios = <&pioB 2 GPIO_ACTIVE_HIGH>;
+				};
+			};
+
+			pinctrl at fffff400 {
+				mmc0 {
+					pinctrl_board_mmc0: mmc0-board {
+						atmel,pins =
+							<AT91_PIOB 2 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH>;
+					};
+				};
+			};
+
+			spi0: spi at fffe0000 {
+				status = "okay";
+			};
+
+			usb1: gadget at fffb0000 {
+				status = "okay";
+				atmel,vbus-gpio = <&pioB 24 GPIO_ACTIVE_HIGH>;
+				atmel,pullup-gpio = <&pioB 22 GPIO_ACTIVE_HIGH>;
+			};
+		};
+
+		usb0: ohci at 00300000 {
+			num-ports = <1>;
+			status = "okay";
+		};
+
+		nand0: nand at 40000000 {
+			status = "okay";
+			gpios = <&pioC 29 GPIO_ACTIVE_HIGH	/* rdy */
+				 &pioD 28 GPIO_ACTIVE_HIGH	/* nce */
+				 0		/* cd */
+			>;
+
+			nand_fs at 0 {
+				label = "nand_fs";
+				reg = <0x00000 0x10000000>;
+			};
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led0 {
+			label = "led0";
+			gpios = <&pioC 19 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		led1 {
+			label = "led1";
+			gpios = <&pioC 18 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "timer";
+		};
+	};
+
+	i2c at 0 {
+		status = "okay";
+	};
+};
diff --git a/arch/arm/configs/at91rm9200_defconfig b/arch/arm/configs/at91rm9200_defconfig
index 92979f2..e18adf8 100644
--- a/arch/arm/configs/at91rm9200_defconfig
+++ b/arch/arm/configs/at91rm9200_defconfig
@@ -21,7 +21,6 @@ CONFIG_MACH_AT91RM9200EK=y
 CONFIG_MACH_CSB337=y
 CONFIG_MACH_CSB637=y
 CONFIG_MACH_ATEB9200=y
-CONFIG_MACH_KB9200=y
 CONFIG_MACH_YL9200=y
 CONFIG_MACH_CPUAT91=y
 CONFIG_MACH_ECO920=y
diff --git a/arch/arm/mach-at91/Kconfig.non_dt b/arch/arm/mach-at91/Kconfig.non_dt
index d60487a..1d421f8 100644
--- a/arch/arm/mach-at91/Kconfig.non_dt
+++ b/arch/arm/mach-at91/Kconfig.non_dt
@@ -81,12 +81,6 @@ config MACH_ATEB9200
 	  Select this if you are using Embest's ATEB9200 board.
 	  <http://www.embedinfo.com/english/product/ATEB9200.asp>
 
-config MACH_KB9200
-	bool "KwikByte KB920x"
-	help
-	  Select this if you are using KwikByte's KB920x board.
-	  <http://www.kwikbyte.com/KB9202.html>
-
 config MACH_YL9200
 	bool "ucDragon YL-9200"
 	help
diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index 983254a..5e80783 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -36,7 +36,6 @@ obj-$(CONFIG_ARCH_AT91X40)	+= at91x40.o at91x40_time.o
 obj-$(CONFIG_MACH_AT91RM9200EK)	+= board-rm9200ek.o
 obj-$(CONFIG_MACH_CSB337)	+= board-csb337.o
 obj-$(CONFIG_MACH_CSB637)	+= board-csb637.o
-obj-$(CONFIG_MACH_KB9200)	+= board-kb9202.o
 obj-$(CONFIG_MACH_ATEB9200)	+= board-eb9200.o
 obj-$(CONFIG_MACH_YL9200)	+= board-yl-9200.o
 obj-$(CONFIG_MACH_CPUAT91)	+= board-cpuat91.o
diff --git a/arch/arm/mach-at91/board-kb9202.c b/arch/arm/mach-at91/board-kb9202.c
deleted file mode 100644
index 0c519d9..0000000
--- a/arch/arm/mach-at91/board-kb9202.c
+++ /dev/null
@@ -1,158 +0,0 @@
-/*
- * linux/arch/arm/mach-at91/board-kb9202.c
- *
- *  Copyright (c) 2005 kb_admin
- *  		       KwikByte, Inc.
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
-#include <mach/hardware.h>
-#include <asm/setup.h>
-#include <asm/mach-types.h>
-#include <asm/irq.h>
-
-#include <asm/mach/arch.h>
-#include <asm/mach/map.h>
-#include <asm/mach/irq.h>
-
-#include <mach/cpu.h>
-#include <mach/at91rm9200_mc.h>
-#include <mach/at91_ramc.h>
-
-#include "at91_aic.h"
-#include "board.h"
-#include "generic.h"
-
-
-static void __init kb9202_init_early(void)
-{
-	/* Set cpu type: PQFP */
-	at91rm9200_set_type(ARCH_REVISON_9200_PQFP);
-
-	/* Initialize processor: 10 MHz crystal */
-	at91_initialize(10000000);
-}
-
-static struct macb_platform_data __initdata kb9202_eth_data = {
-	.phy_irq_pin	= AT91_PIN_PB29,
-	.is_rmii	= 0,
-};
-
-static struct at91_usbh_data __initdata kb9202_usbh_data = {
-	.ports		= 1,
-	.vbus_pin	= {-EINVAL, -EINVAL},
-	.overcurrent_pin= {-EINVAL, -EINVAL},
-};
-
-static struct at91_udc_data __initdata kb9202_udc_data = {
-	.vbus_pin	= AT91_PIN_PB24,
-	.pullup_pin	= AT91_PIN_PB22,
-};
-
-static struct mci_platform_data __initdata kb9202_mci0_data = {
-	.slot[0] = {
-		.bus_width	= 4,
-		.detect_pin	= AT91_PIN_PB2,
-		.wp_pin		= -EINVAL,
-	},
-};
-
-static struct mtd_partition __initdata kb9202_nand_partition[] = {
-	{
-		.name	= "nand_fs",
-		.offset	= 0,
-		.size	= MTDPART_SIZ_FULL,
-	},
-};
-
-static struct atmel_nand_data __initdata kb9202_nand_data = {
-	.ale		= 22,
-	.cle		= 21,
-	.det_pin	= -EINVAL,
-	.rdy_pin	= AT91_PIN_PC29,
-	.enable_pin	= AT91_PIN_PC28,
-	.ecc_mode	= NAND_ECC_SOFT,
-	.parts		= kb9202_nand_partition,
-	.num_parts	= ARRAY_SIZE(kb9202_nand_partition),
-};
-
-/*
- * LEDs
- */
-static struct gpio_led kb9202_leds[] = {
-	{	/* D1 */
-		.name			= "led1",
-		.gpio			= AT91_PIN_PC19,
-		.active_low		= 1,
-		.default_trigger	= "heartbeat",
-	},
-	{	/* D2 */
-		.name			= "led2",
-		.gpio			= AT91_PIN_PC18,
-		.active_low		= 1,
-		.default_trigger	= "timer",
-	}
-};
-
-static void __init kb9202_board_init(void)
-{
-	/* Serial */
-	/* DBGU on ttyS0. (Rx & Tx only) */
-	at91_register_uart(0, 0, 0);
-
-	/* USART0 on ttyS1 (Rx & Tx only) */
-	at91_register_uart(AT91RM9200_ID_US0, 1, 0);
-
-	/* USART1 on ttyS2 (Rx & Tx only) - IRDA (optional) */
-	at91_register_uart(AT91RM9200_ID_US1, 2, 0);
-
-	/* USART3 on ttyS3 (Rx, Tx, CTS, RTS) - RS485 (optional) */
-	at91_register_uart(AT91RM9200_ID_US3, 3, ATMEL_UART_CTS | ATMEL_UART_RTS);
-	at91_add_device_serial();
-	/* Ethernet */
-	at91_add_device_eth(&kb9202_eth_data);
-	/* USB Host */
-	at91_add_device_usbh(&kb9202_usbh_data);
-	/* USB Device */
-	at91_add_device_udc(&kb9202_udc_data);
-	/* MMC */
-	at91_add_device_mci(0, &kb9202_mci0_data);
-	/* I2C */
-	at91_add_device_i2c(NULL, 0);
-	/* SPI */
-	at91_add_device_spi(NULL, 0);
-	/* NAND */
-	at91_add_device_nand(&kb9202_nand_data);
-	/* LEDs */
-	at91_gpio_leds(kb9202_leds, ARRAY_SIZE(kb9202_leds));
-}
-
-MACHINE_START(KB9200, "KB920x")
-	/* Maintainer: KwikByte, Inc. */
-	.init_time	= at91rm9200_timer_init,
-	.map_io		= at91_map_io,
-	.handle_irq	= at91_aic_handle_irq,
-	.init_early	= kb9202_init_early,
-	.init_irq	= at91_init_irq_default,
-	.init_machine	= kb9202_board_init,
-MACHINE_END
-- 
1.8.4.rc3
