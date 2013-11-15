From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 15 Nov 2013 15:50:05 +0100
Subject: [PATCH 10/11] ARM: at91: switch csb637 board to DT
In-Reply-To: <1384527006-9040-1-git-send-email-plagnioj@jcrosoft.com>
References: <20131115143855.GR28304@ns203013.ovh.net>
 <1384527006-9040-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1384527006-9040-10-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/Makefile            |   1 +
 arch/arm/boot/dts/at91-csb637.dts     |  83 ++++++++++++++++++++
 arch/arm/configs/at91rm9200_defconfig |   1 -
 arch/arm/mach-at91/Kconfig.non_dt     |   6 --
 arch/arm/mach-at91/Makefile           |   1 -
 arch/arm/mach-at91/board-csb637.c     | 141 ----------------------------------
 6 files changed, 84 insertions(+), 149 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91-csb637.dts
 delete mode 100644 arch/arm/mach-at91/board-csb637.c

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index bba996a..d042c68 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -5,6 +5,7 @@ ifeq ($(CONFIG_OF),y)
 dtb-$(CONFIG_ARCH_AT91) += at91rm9200ek.dtb
 dtb-$(CONFIG_ARCH_AT91) += at91-1arm.dtb
 dtb-$(CONFIG_ARCH_AT91) += at91-carmeva.dtb
+dtb-$(CONFIG_ARCH_AT91) += at91-csb637.dtb
 dtb-$(CONFIG_ARCH_AT91) += at91-ecbat91.dtb
 dtb-$(CONFIG_ARCH_AT91) += at91-flexibity.dtb
 dtb-$(CONFIG_ARCH_AT91) += at91-kafa.dtb
diff --git a/arch/arm/boot/dts/at91-csb637.dts b/arch/arm/boot/dts/at91-csb637.dts
new file mode 100644
index 0000000..35031337
--- /dev/null
+++ b/arch/arm/boot/dts/at91-csb637.dts
@@ -0,0 +1,83 @@
+/*
+ * at91-csb637.dts - Device Tree file for Cogent CSB637 board
+ *
+ * Copyright (C) 2013 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
+ *
+ * Licensed under GPLv2 only
+ */
+/dts-v1/;
+#include "at91rm9200.dtsi"
+
+/ {
+	model = "Cogent CSB637 board";
+	compatible = "cogent,csb637", "atmel,at91rm9200";
+
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		main_clock: clock at 0 {
+			compatible = "atmel,osc", "fixed-clock";
+			clock-frequency = <3686400>;
+		};
+	};
+
+	ahb {
+		apb {
+			dbgu: serial at fffff200 {
+				status = "okay";
+			};
+
+			macb0: ethernet at fffbc000 {
+				phy-mode = "mii";
+				status = "okay";
+				/* phy irq on PC0 */
+				pinctrl-0 = <&pinctrl_macb_rmii &pinctrl_macb_rmii_mii>;
+			};
+
+			spi0: spi at fffe0000 {
+				status = "okay";
+			};
+
+			usb1: gadget at fffb0000 {
+				status = "okay";
+				atmel,vbus-gpio = <&pioB 28 GPIO_ACTIVE_HIGH>;
+				atmel,pullup-gpio = <&pioB 1 GPIO_ACTIVE_HIGH>;
+			};
+		};
+
+		usb0: ohci at 00300000 {
+			num-ports = <2>;
+			status = "okay";
+		};
+
+		nor_flash at 10000000 {
+			compatible = "cfi-flash";
+			reg = <0x10000000 0x1000000>;
+			linux,mtd-name = "physmap-flash.0";
+			bank-width = <2>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			boot at 0 {
+				label = "uMON flash";
+				reg = <0x00000 0x1000000>;
+			};
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		d1 {
+			label = "d1";
+			gpios = <&pioB 2 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	i2c at 0 {
+		status = "okay";
+	};
+};
diff --git a/arch/arm/configs/at91rm9200_defconfig b/arch/arm/configs/at91rm9200_defconfig
index e18adf8..6c555c1 100644
--- a/arch/arm/configs/at91rm9200_defconfig
+++ b/arch/arm/configs/at91rm9200_defconfig
@@ -19,7 +19,6 @@ CONFIG_ARCH_AT91=y
 CONFIG_ARCH_AT91RM9200=y
 CONFIG_MACH_AT91RM9200EK=y
 CONFIG_MACH_CSB337=y
-CONFIG_MACH_CSB637=y
 CONFIG_MACH_ATEB9200=y
 CONFIG_MACH_YL9200=y
 CONFIG_MACH_CPUAT91=y
diff --git a/arch/arm/mach-at91/Kconfig.non_dt b/arch/arm/mach-at91/Kconfig.non_dt
index 1d421f8..c193a13 100644
--- a/arch/arm/mach-at91/Kconfig.non_dt
+++ b/arch/arm/mach-at91/Kconfig.non_dt
@@ -69,12 +69,6 @@ config MACH_CSB337
 	  Select this if you are using Cogent's CSB337 board.
 	  <http://www.cogcomp.com/csb_csb337.htm>
 
-config MACH_CSB637
-	bool "Cogent CSB637"
-	help
-	  Select this if you are using Cogent's CSB637 board.
-	  <http://www.cogcomp.com/csb_csb637.htm>
-
 config MACH_ATEB9200
 	bool "Embest ATEB9200"
 	help
diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index 5e80783..8eda4b0 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -35,7 +35,6 @@ obj-$(CONFIG_ARCH_AT91X40)	+= at91x40.o at91x40_time.o
 # AT91RM9200 board-specific support
 obj-$(CONFIG_MACH_AT91RM9200EK)	+= board-rm9200ek.o
 obj-$(CONFIG_MACH_CSB337)	+= board-csb337.o
-obj-$(CONFIG_MACH_CSB637)	+= board-csb637.o
 obj-$(CONFIG_MACH_ATEB9200)	+= board-eb9200.o
 obj-$(CONFIG_MACH_YL9200)	+= board-yl-9200.o
 obj-$(CONFIG_MACH_CPUAT91)	+= board-cpuat91.o
diff --git a/arch/arm/mach-at91/board-csb637.c b/arch/arm/mach-at91/board-csb637.c
deleted file mode 100644
index fdf1106..0000000
--- a/arch/arm/mach-at91/board-csb637.c
+++ /dev/null
@@ -1,141 +0,0 @@
-/*
- * linux/arch/arm/mach-at91/board-csb637.c
- *
- *  Copyright (C) 2005 SAN People
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
-#include <linux/init.h>
-#include <linux/gpio.h>
-#include <linux/mm.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/mtd/physmap.h>
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
-static void __init csb637_init_early(void)
-{
-	/* Initialize processor: 3.6864 MHz crystal */
-	at91_initialize(3686400);
-}
-
-static struct macb_platform_data __initdata csb637_eth_data = {
-	.phy_irq_pin	= AT91_PIN_PC0,
-	.is_rmii	= 0,
-};
-
-static struct at91_usbh_data __initdata csb637_usbh_data = {
-	.ports		= 2,
-	.vbus_pin	= {-EINVAL, -EINVAL},
-	.overcurrent_pin= {-EINVAL, -EINVAL},
-};
-
-static struct at91_udc_data __initdata csb637_udc_data = {
-	.vbus_pin     = AT91_PIN_PB28,
-	.pullup_pin   = AT91_PIN_PB1,
-};
-
-#define CSB_FLASH_BASE	AT91_CHIPSELECT_0
-#define CSB_FLASH_SIZE	SZ_16M
-
-static struct mtd_partition csb_flash_partitions[] = {
-	{
-		.name		= "uMON flash",
-		.offset		= 0,
-		.size		= MTDPART_SIZ_FULL,
-		.mask_flags	= MTD_WRITEABLE,	/* read only */
-	}
-};
-
-static struct physmap_flash_data csb_flash_data = {
-	.width		= 2,
-	.parts		= csb_flash_partitions,
-	.nr_parts	= ARRAY_SIZE(csb_flash_partitions),
-};
-
-static struct resource csb_flash_resources[] = {
-	{
-		.start	= CSB_FLASH_BASE,
-		.end	= CSB_FLASH_BASE + CSB_FLASH_SIZE - 1,
-		.flags	= IORESOURCE_MEM,
-	}
-};
-
-static struct platform_device csb_flash = {
-	.name		= "physmap-flash",
-	.id		= 0,
-	.dev		= {
-				.platform_data = &csb_flash_data,
-			},
-	.resource	= csb_flash_resources,
-	.num_resources	= ARRAY_SIZE(csb_flash_resources),
-};
-
-static struct gpio_led csb_leds[] = {
-	{	/* "d1", red */
-		.name			= "d1",
-		.gpio			= AT91_PIN_PB2,
-		.active_low		= 1,
-		.default_trigger	= "heartbeat",
-	},
-};
-
-static void __init csb637_board_init(void)
-{
-	/* LED(s) */
-	at91_gpio_leds(csb_leds, ARRAY_SIZE(csb_leds));
-	/* Serial */
-	/* DBGU on ttyS0. (Rx & Tx only) */
-	at91_register_uart(0, 0, 0);
-	at91_add_device_serial();
-	/* Ethernet */
-	at91_add_device_eth(&csb637_eth_data);
-	/* USB Host */
-	at91_add_device_usbh(&csb637_usbh_data);
-	/* USB Device */
-	at91_add_device_udc(&csb637_udc_data);
-	/* I2C */
-	at91_add_device_i2c(NULL, 0);
-	/* SPI */
-	at91_add_device_spi(NULL, 0);
-	/* NOR flash */
-	platform_device_register(&csb_flash);
-}
-
-MACHINE_START(CSB637, "Cogent CSB637")
-	/* Maintainer: Bill Gatliff */
-	.init_time	= at91rm9200_timer_init,
-	.map_io		= at91_map_io,
-	.handle_irq	= at91_aic_handle_irq,
-	.init_early	= csb637_init_early,
-	.init_irq	= at91_init_irq_default,
-	.init_machine	= csb637_board_init,
-MACHINE_END
-- 
1.8.4.rc3
