From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 15 Nov 2013 15:50:02 +0100
Subject: [PATCH 07/11] ARM: at91: switch Picotux 200 board to DT
In-Reply-To: <1384527006-9040-1-git-send-email-plagnioj@jcrosoft.com>
References: <20131115143855.GR28304@ns203013.ovh.net>
 <1384527006-9040-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1384527006-9040-7-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/Makefile             |   1 +
 arch/arm/boot/dts/at91-picotux-200.dts |  93 ++++++++++++++++++++++++
 arch/arm/configs/at91rm9200_defconfig  |   1 -
 arch/arm/mach-at91/Kconfig.non_dt      |   6 --
 arch/arm/mach-at91/Makefile            |   1 -
 arch/arm/mach-at91/board-picotux200.c  | 128 ---------------------------------
 6 files changed, 94 insertions(+), 136 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91-picotux-200.dts
 delete mode 100644 arch/arm/mach-at91/board-picotux200.c

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index cdba9ce..ade7686 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -7,6 +7,7 @@ dtb-$(CONFIG_ARCH_AT91) += at91-1arm.dtb
 dtb-$(CONFIG_ARCH_AT91) += at91-carmeva.dtb
 dtb-$(CONFIG_ARCH_AT91) += at91-flexibity.dtb
 dtb-$(CONFIG_ARCH_AT91) += at91-kafa.dtb
+dtb-$(CONFIG_ARCH_AT91) += at91-picotux-200.dtb
 dtb-$(CONFIG_ARCH_AT91) += at91-rsi-ews.dtb
 dtb-$(CONFIG_ARCH_AT91) += mpa1600.dtb
 # sam9260
diff --git a/arch/arm/boot/dts/at91-picotux-200.dts b/arch/arm/boot/dts/at91-picotux-200.dts
new file mode 100644
index 0000000..84345b1
--- /dev/null
+++ b/arch/arm/boot/dts/at91-picotux-200.dts
@@ -0,0 +1,93 @@
+/*
+ * at91-picotux-200.dts - Device Tree file for Picotux 200 board
+ *
+ * Copyright (C) 2013 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
+ *
+ * Licensed under GPLv2 only
+ */
+/dts-v1/;
+#include "at91rm9200.dtsi"
+
+/ {
+	model = "Picotux 200 board";
+	compatible = "keg,picotux-200", "atmel,at91rm9200";
+
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		main_clock: clock at 0 {
+			compatible = "atmel,osc", "fixed-clock";
+			clock-frequency = <18432000>;
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
+				status = "okay";
+				/* phy irq on PC4 */
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
+					cd-gpios = <&pioB 27 GPIO_ACTIVE_HIGH>;
+					wp-gpios = <&pioA 17 GPIO_ACTIVE_HIGH>;
+				};
+			};
+
+			pinctrl at fffff400 {
+				mmc0 {
+					pinctrl_board_mmc0: mmc0-board {
+						atmel,pins =
+							<AT91_PIOB 27 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH
+							 AT91_PIOA 17 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;
+					};
+				};
+			};
+		};
+
+		usb0: ohci at 00300000 {
+			num-ports = <1>;
+			status = "okay";
+		};
+
+		nor_flash at 10000000 {
+			compatible = "cfi-flash";
+			reg = <0x10000000 0x400000>;
+			linux,mtd-name = "physmap-flash.0";
+			bank-width = <2>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+	};
+
+	i2c at 0 {
+		status = "okay";
+	};
+};
diff --git a/arch/arm/configs/at91rm9200_defconfig b/arch/arm/configs/at91rm9200_defconfig
index f9a2f5f..cbd5bf1 100644
--- a/arch/arm/configs/at91rm9200_defconfig
+++ b/arch/arm/configs/at91rm9200_defconfig
@@ -22,7 +22,6 @@ CONFIG_MACH_CSB337=y
 CONFIG_MACH_CSB637=y
 CONFIG_MACH_ATEB9200=y
 CONFIG_MACH_KB9200=y
-CONFIG_MACH_PICOTUX2XX=y
 CONFIG_MACH_ECBAT91=y
 CONFIG_MACH_YL9200=y
 CONFIG_MACH_CPUAT91=y
diff --git a/arch/arm/mach-at91/Kconfig.non_dt b/arch/arm/mach-at91/Kconfig.non_dt
index af27414..254166b 100644
--- a/arch/arm/mach-at91/Kconfig.non_dt
+++ b/arch/arm/mach-at91/Kconfig.non_dt
@@ -87,12 +87,6 @@ config MACH_KB9200
 	  Select this if you are using KwikByte's KB920x board.
 	  <http://www.kwikbyte.com/KB9202.html>
 
-config MACH_PICOTUX2XX
-	bool "picotux 200"
-	help
-	  Select this if you are using a picotux 200.
-	  <http://www.picotux.com/>
-
 config MACH_ECBAT91
 	bool "emQbit ECB_AT91 SBC"
 	select HAVE_AT91_DATAFLASH_CARD
diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index d0b2518..6d08a51 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -38,7 +38,6 @@ obj-$(CONFIG_MACH_CSB337)	+= board-csb337.o
 obj-$(CONFIG_MACH_CSB637)	+= board-csb637.o
 obj-$(CONFIG_MACH_KB9200)	+= board-kb9202.o
 obj-$(CONFIG_MACH_ATEB9200)	+= board-eb9200.o
-obj-$(CONFIG_MACH_PICOTUX2XX)	+= board-picotux200.o
 obj-$(CONFIG_MACH_ECBAT91)	+= board-ecbat91.o
 obj-$(CONFIG_MACH_YL9200)	+= board-yl-9200.o
 obj-$(CONFIG_MACH_CPUAT91)	+= board-cpuat91.o
diff --git a/arch/arm/mach-at91/board-picotux200.c b/arch/arm/mach-at91/board-picotux200.c
deleted file mode 100644
index ab2b2ec..0000000
--- a/arch/arm/mach-at91/board-picotux200.c
+++ /dev/null
@@ -1,128 +0,0 @@
-/*
- * linux/arch/arm/mach-at91/board-picotux200.c
- *
- *  Copyright (C) 2005 SAN People
- *  Copyright (C) 2007 Kleinhenz Elektronik GmbH
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
-#include <linux/spi/spi.h>
-#include <linux/mtd/physmap.h>
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
-#include <mach/at91rm9200_mc.h>
-#include <mach/at91_ramc.h>
-
-#include "at91_aic.h"
-#include "board.h"
-#include "generic.h"
-
-
-static void __init picotux200_init_early(void)
-{
-	/* Initialize processor: 18.432 MHz crystal */
-	at91_initialize(18432000);
-}
-
-static struct macb_platform_data __initdata picotux200_eth_data = {
-	.phy_irq_pin	= AT91_PIN_PC4,
-	.is_rmii	= 1,
-};
-
-static struct at91_usbh_data __initdata picotux200_usbh_data = {
-	.ports		= 1,
-	.vbus_pin	= {-EINVAL, -EINVAL},
-	.overcurrent_pin= {-EINVAL, -EINVAL},
-};
-
-static struct mci_platform_data __initdata picotux200_mci0_data = {
-	.slot[0] = {
-		.bus_width	= 4,
-		.detect_pin	= AT91_PIN_PB27,
-		.wp_pin		= AT91_PIN_PA17,
-	},
-};
-
-#define PICOTUX200_FLASH_BASE	AT91_CHIPSELECT_0
-#define PICOTUX200_FLASH_SIZE	SZ_4M
-
-static struct physmap_flash_data picotux200_flash_data = {
-	.width	= 2,
-};
-
-static struct resource picotux200_flash_resource = {
-	.start		= PICOTUX200_FLASH_BASE,
-	.end		= PICOTUX200_FLASH_BASE + PICOTUX200_FLASH_SIZE - 1,
-	.flags		= IORESOURCE_MEM,
-};
-
-static struct platform_device picotux200_flash = {
-	.name		= "physmap-flash",
-	.id		= 0,
-	.dev		= {
-				.platform_data	= &picotux200_flash_data,
-			},
-	.resource	= &picotux200_flash_resource,
-	.num_resources	= 1,
-};
-
-static void __init picotux200_board_init(void)
-{
-	/* Serial */
-	/* DBGU on ttyS0. (Rx & Tx only) */
-	at91_register_uart(0, 0, 0);
-
-	/* USART1 on ttyS1. (Rx, Tx, CTS, RTS, DTR, DSR, DCD, RI) */
-	at91_register_uart(AT91RM9200_ID_US1, 1, ATMEL_UART_CTS | ATMEL_UART_RTS
-			  | ATMEL_UART_DTR | ATMEL_UART_DSR | ATMEL_UART_DCD
-			  | ATMEL_UART_RI);
-	at91_add_device_serial();
-	/* Ethernet */
-	at91_add_device_eth(&picotux200_eth_data);
-	/* USB Host */
-	at91_add_device_usbh(&picotux200_usbh_data);
-	/* I2C */
-	at91_add_device_i2c(NULL, 0);
-	/* MMC */
-	at91_set_gpio_output(AT91_PIN_PB22, 1);	/* this MMC card slot can optionally use SPI signaling (CS3). */
-	at91_add_device_mci(0, &picotux200_mci0_data);
-	/* NOR Flash */
-	platform_device_register(&picotux200_flash);
-}
-
-MACHINE_START(PICOTUX2XX, "picotux 200")
-	/* Maintainer: Kleinhenz Elektronik GmbH */
-	.init_time	= at91rm9200_timer_init,
-	.map_io		= at91_map_io,
-	.handle_irq	= at91_aic_handle_irq,
-	.init_early	= picotux200_init_early,
-	.init_irq	= at91_init_irq_default,
-	.init_machine	= picotux200_board_init,
-MACHINE_END
-- 
1.8.4.rc3
