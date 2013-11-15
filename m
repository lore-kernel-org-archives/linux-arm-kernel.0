From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 15 Nov 2013 15:50:00 +0100
Subject: [PATCH 05/11] ARM: at91: switch flexibity to DT
In-Reply-To: <1384527006-9040-1-git-send-email-plagnioj@jcrosoft.com>
References: <20131115143855.GR28304@ns203013.ovh.net>
 <1384527006-9040-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1384527006-9040-5-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/Makefile                  |   1 +
 arch/arm/boot/dts/at91-flexibity.dts        | 144 ++++++++++++++++++++++++
 arch/arm/configs/at91sam9260_9g20_defconfig |   1 -
 arch/arm/mach-at91/Kconfig.non_dt           |   6 -
 arch/arm/mach-at91/Makefile                 |   1 -
 arch/arm/mach-at91/board-flexibity.c        | 168 ----------------------------
 6 files changed, 145 insertions(+), 176 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91-flexibity.dts
 delete mode 100644 arch/arm/mach-at91/board-flexibity.c

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index de02fc7..a66de6d 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -5,6 +5,7 @@ ifeq ($(CONFIG_OF),y)
 dtb-$(CONFIG_ARCH_AT91) += at91rm9200ek.dtb
 dtb-$(CONFIG_ARCH_AT91) += at91-1arm.dtb
 dtb-$(CONFIG_ARCH_AT91) += at91-carmeva.dtb
+dtb-$(CONFIG_ARCH_AT91) += at91-flexibity.dtb
 dtb-$(CONFIG_ARCH_AT91) += at91-kafa.dtb
 dtb-$(CONFIG_ARCH_AT91) += mpa1600.dtb
 # sam9260
diff --git a/arch/arm/boot/dts/at91-flexibity.dts b/arch/arm/boot/dts/at91-flexibity.dts
new file mode 100644
index 0000000..2eb9b51
--- /dev/null
+++ b/arch/arm/boot/dts/at91-flexibity.dts
@@ -0,0 +1,144 @@
+/*
+ * at91-flexibity.dts - Device Tree file for Flexibity Connect board
+ *
+ * Copyright (C) 2013 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
+ *
+ * Licensed under GPLv2 only
+ */
+/dts-v1/;
+#include "at91sam9260.dtsi"
+
+/ {
+	model = "Flexibity Connect board";
+	compatible = "flexibity,connect", "atmel,at91sam9260", "atmel,at91sam9";
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
+			usb1: gadget at fffa4000 {
+				atmel,vbus-gpio = <&pioC 5 GPIO_ACTIVE_HIGH>;
+				status = "okay";
+			};
+
+			mmc0: mmc at fffa8000 {
+				pinctrl-0 = <
+					&pinctrl_board_mmc0
+					&pinctrl_mmc0_clk
+					&pinctrl_mmc0_slot0_cmd_dat0
+					&pinctrl_mmc0_slot0_dat1_3>;
+				status = "okay";
+				slot at 0 {
+					reg = <0>;
+					bus-width = <4>;
+					cd-gpios = <&pioB 9 GPIO_ACTIVE_HIGH>;
+					wp-gpios = <&pioC 4 GPIO_ACTIVE_HIGH>;
+				};
+			};
+
+			pinctrl at fffff400 {
+				mmc0 {
+					pinctrl_board_mmc0: mmc0-board {
+						atmel,pins =
+							<AT91_PIOB 9 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH
+							 AT91_PIOC 4 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;
+					};
+				};
+			};
+
+			spi0: spi at fffc8000 {
+				status = "okay";
+				cs-gpios = <0>,
+					   <&pioC 11 GPIO_ACTIVE_HIGH>;
+				mtd_dataflash at 1 {
+					compatible = "atmel,at45", "atmel,dataflash";
+					spi-max-frequency = <15000000>;
+					reg = <1>;
+				};
+			};
+		};
+
+		usb0: ohci at 00500000 {
+			num-ports = <2>;
+			status = "okay";
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		usb1_green {
+			label = "usb1:green";
+			gpios = <&pioA 12 GPIO_ACTIVE_LOW>;
+			default-state = "on";
+		};
+
+		usb1_red {
+			label = "usb1:red";
+			gpios = <&pioA 13 GPIO_ACTIVE_LOW>;
+			default-state = "on";
+		};
+
+		usb2_green {
+			label = "usb2:green";
+			gpios = <&pioB 16 GPIO_ACTIVE_LOW>;
+			default-state = "on";
+		};
+
+		usb2_red {
+			label = "usb2:red";
+			gpios = <&pioB 27 GPIO_ACTIVE_LOW>;
+			default-state = "on";
+		};
+
+		usb3_green {
+			label = "usb3:green";
+			gpios = <&pioC 8 GPIO_ACTIVE_LOW>;
+			default-state = "on";
+		};
+
+		usb3_red {
+			label = "usb3:red";
+			gpios = <&pioC 6 13 GPIO_ACTIVE_LOW>;
+			default-state = "on";
+		};
+
+		usb4_green {
+			label = "usb4:green";
+			gpios = <&pioB 4 GPIO_ACTIVE_LOW>;
+			default-state = "on";
+		};
+
+		usb4_red {
+			label = "usb4:red";
+			gpios = <&pioB 5 GPIO_ACTIVE_LOW>;
+			default-state = "on";
+		};
+	};
+
+	i2c at 0 {
+		status = "okay";
+
+		rtc at 68 {
+			compatible = "dallas,ds1307";
+			reg = <0x68>;
+		};
+	};
+};
diff --git a/arch/arm/configs/at91sam9260_9g20_defconfig b/arch/arm/configs/at91sam9260_9g20_defconfig
index 69b6928..ab66867 100644
--- a/arch/arm/configs/at91sam9260_9g20_defconfig
+++ b/arch/arm/configs/at91sam9260_9g20_defconfig
@@ -17,7 +17,6 @@ CONFIG_MACH_SAM9_L9260=y
 CONFIG_MACH_AFEB9260=y
 CONFIG_MACH_QIL_A9260=y
 CONFIG_MACH_CPU9260=y
-CONFIG_MACH_FLEXIBITY=y
 CONFIG_MACH_AT91SAM9G20EK=y
 CONFIG_MACH_AT91SAM9G20EK_2MMC=y
 CONFIG_MACH_CPU9G20=y
diff --git a/arch/arm/mach-at91/Kconfig.non_dt b/arch/arm/mach-at91/Kconfig.non_dt
index cfef1de..694e959 100644
--- a/arch/arm/mach-at91/Kconfig.non_dt
+++ b/arch/arm/mach-at91/Kconfig.non_dt
@@ -171,12 +171,6 @@ config MACH_CPU9260
 	  Select this if you are using a Eukrea Electromatique's
 	  CPU9260 Board <http://www.eukrea.com/>
 
-config MACH_FLEXIBITY
-	bool "Flexibity Connect board"
-	help
-	  Select this if you are using Flexibity Connect board
-	  <http://www.flexibity.com>
-
 comment "AT91SAM9G20 Board Type"
 
 config MACH_AT91SAM9G20EK
diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index 61c19d7..70e2b22 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -52,7 +52,6 @@ obj-$(CONFIG_MACH_SAM9_L9260)	+= board-sam9-l9260.o
 obj-$(CONFIG_MACH_QIL_A9260)	+= board-qil-a9260.o
 obj-$(CONFIG_MACH_AFEB9260)	+= board-afeb-9260v1.o
 obj-$(CONFIG_MACH_CPU9260)	+= board-cpu9krea.o
-obj-$(CONFIG_MACH_FLEXIBITY)	+= board-flexibity.o
 
 # AT91SAM9261 board-specific support
 obj-$(CONFIG_MACH_AT91SAM9261EK) += board-sam9261ek.o
diff --git a/arch/arm/mach-at91/board-flexibity.c b/arch/arm/mach-at91/board-flexibity.c
deleted file mode 100644
index 737c085..0000000
--- a/arch/arm/mach-at91/board-flexibity.c
+++ /dev/null
@@ -1,168 +0,0 @@
-/*
- * linux/arch/arm/mach-at91/board-flexibity.c
- *
- *  Copyright (C) 2010-2011 Flexibity
- *  Copyright (C) 2005 SAN People
- *  Copyright (C) 2006 Atmel
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
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/spi/spi.h>
-#include <linux/input.h>
-#include <linux/gpio.h>
-
-#include <asm/mach-types.h>
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
-static void __init flexibity_init_early(void)
-{
-	/* Initialize processor: 18.432 MHz crystal */
-	at91_initialize(18432000);
-}
-
-/* USB Host port */
-static struct at91_usbh_data __initdata flexibity_usbh_data = {
-	.ports		= 2,
-	.vbus_pin	= {-EINVAL, -EINVAL},
-	.overcurrent_pin= {-EINVAL, -EINVAL},
-};
-
-/* USB Device port */
-static struct at91_udc_data __initdata flexibity_udc_data = {
-	.vbus_pin	= AT91_PIN_PC5,
-	.pullup_pin	= -EINVAL,		/* pull-up driven by UDC */
-};
-
-/* I2C devices */
-static struct i2c_board_info __initdata flexibity_i2c_devices[] = {
-	{
-		I2C_BOARD_INFO("ds1307", 0x68),
-	},
-};
-
-/* SPI devices */
-static struct spi_board_info flexibity_spi_devices[] = {
-	{	/* DataFlash chip */
-		.modalias	= "mtd_dataflash",
-		.chip_select	= 1,
-		.max_speed_hz	= 15 * 1000 * 1000,
-		.bus_num	= 0,
-	},
-};
-
-/* MCI (SD/MMC) */
-static struct mci_platform_data __initdata flexibity_mci0_data = {
-	.slot[0] = {
-		.bus_width	= 4,
-		.detect_pin	= AT91_PIN_PC9,
-		.wp_pin		= AT91_PIN_PC4,
-	},
-};
-
-/* LEDs */
-static struct gpio_led flexibity_leds[] = {
-	{
-		.name			= "usb1:green",
-		.gpio			= AT91_PIN_PA12,
-		.active_low		= 1,
-		.default_trigger	= "default-on",
-	},
-	{
-		.name			= "usb1:red",
-		.gpio			= AT91_PIN_PA13,
-		.active_low		= 1,
-		.default_trigger	= "default-on",
-	},
-	{
-		.name			= "usb2:green",
-		.gpio			= AT91_PIN_PB26,
-		.active_low		= 1,
-		.default_trigger	= "default-on",
-	},
-	{
-		.name			= "usb2:red",
-		.gpio			= AT91_PIN_PB27,
-		.active_low		= 1,
-		.default_trigger	= "default-on",
-	},
-	{
-		.name			= "usb3:green",
-		.gpio			= AT91_PIN_PC8,
-		.active_low		= 1,
-		.default_trigger	= "default-on",
-	},
-	{
-		.name			= "usb3:red",
-		.gpio			= AT91_PIN_PC6,
-		.active_low		= 1,
-		.default_trigger	= "default-on",
-	},
-	{
-		.name			= "usb4:green",
-		.gpio			= AT91_PIN_PB4,
-		.active_low		= 1,
-		.default_trigger	= "default-on",
-	},
-	{
-		.name			= "usb4:red",
-		.gpio			= AT91_PIN_PB5,
-		.active_low		= 1,
-		.default_trigger	= "default-on",
-	}
-};
-
-static void __init flexibity_board_init(void)
-{
-	/* Serial */
-	/* DBGU on ttyS0. (Rx & Tx only) */
-	at91_register_uart(0, 0, 0);
-	at91_add_device_serial();
-	/* USB Host */
-	at91_add_device_usbh(&flexibity_usbh_data);
-	/* USB Device */
-	at91_add_device_udc(&flexibity_udc_data);
-	/* I2C */
-	at91_add_device_i2c(flexibity_i2c_devices,
-		ARRAY_SIZE(flexibity_i2c_devices));
-	/* SPI */
-	at91_add_device_spi(flexibity_spi_devices,
-		ARRAY_SIZE(flexibity_spi_devices));
-	/* MMC */
-	at91_add_device_mci(0, &flexibity_mci0_data);
-	/* LEDs */
-	at91_gpio_leds(flexibity_leds, ARRAY_SIZE(flexibity_leds));
-}
-
-MACHINE_START(FLEXIBITY, "Flexibity Connect")
-	/* Maintainer: Maxim Osipov */
-	.init_time	= at91sam926x_pit_init,
-	.map_io		= at91_map_io,
-	.handle_irq	= at91_aic_handle_irq,
-	.init_early	= flexibity_init_early,
-	.init_irq	= at91_init_irq_default,
-	.init_machine	= flexibity_board_init,
-MACHINE_END
-- 
1.8.4.rc3
