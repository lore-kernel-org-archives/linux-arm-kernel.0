From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 15 Nov 2013 15:49:59 +0100
Subject: [PATCH 04/11] ARM: at91: switch kafa board to DT
In-Reply-To: <1384527006-9040-1-git-send-email-plagnioj@jcrosoft.com>
References: <20131115143855.GR28304@ns203013.ovh.net>
 <1384527006-9040-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1384527006-9040-4-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/Makefile            |   1 +
 arch/arm/boot/dts/at91-kafa.dts       |  79 ++++++++++++++++++++++++
 arch/arm/configs/at91rm9200_defconfig |   1 -
 arch/arm/mach-at91/Kconfig.non_dt     |   5 --
 arch/arm/mach-at91/Makefile           |   1 -
 arch/arm/mach-at91/board-kafa.c       | 112 ----------------------------------
 6 files changed, 80 insertions(+), 119 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91-kafa.dts
 delete mode 100644 arch/arm/mach-at91/board-kafa.c

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 5724a51..de02fc7 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -5,6 +5,7 @@ ifeq ($(CONFIG_OF),y)
 dtb-$(CONFIG_ARCH_AT91) += at91rm9200ek.dtb
 dtb-$(CONFIG_ARCH_AT91) += at91-1arm.dtb
 dtb-$(CONFIG_ARCH_AT91) += at91-carmeva.dtb
+dtb-$(CONFIG_ARCH_AT91) += at91-kafa.dtb
 dtb-$(CONFIG_ARCH_AT91) += mpa1600.dtb
 # sam9260
 dtb-$(CONFIG_ARCH_AT91) += animeo_ip.dtb
diff --git a/arch/arm/boot/dts/at91-kafa.dts b/arch/arm/boot/dts/at91-kafa.dts
new file mode 100644
index 0000000..0ad458f
--- /dev/null
+++ b/arch/arm/boot/dts/at91-kafa.dts
@@ -0,0 +1,79 @@
+/*
+ * at91-kafa.dts - Device Tree file for Sperry-Sun KAFA boar
+ *
+ * Copyright (C) 2013 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
+ *
+ * Licensed under GPLv2 only
+ */
+/dts-v1/;
+#include "at91rm9200_pqfp.dtsi"
+
+/ {
+	model = "Sperry-Sun KAFA board";
+	compatible = "sperry,kafa", "atmel,at91rm9200-pqfp", "atmel,at91rm9200";
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
+			usart0: serial at fffc0000 {
+				pinctrl-0 =
+						<&pinctrl_uart0
+						 &pinctrl_uart0_rts
+						 &pinctrl_uart0_cts>;
+				status = "okay";
+			};
+
+			macb0: ethernet at fffbc000 {
+				phy-mode = "rmii";
+				status = "okay";
+			};
+
+			usb1: gadget at fffb0000 {
+				atmel,vbus-gpio = <&pioB 6 GPIO_ACTIVE_HIGH>;
+				atmel,pullup-gpio = <&pioB 7 GPIO_ACTIVE_HIGH>;
+				status = "okay";
+			};
+
+			spi0: spi at fffe0000 {
+				status = "okay";
+			};
+		};
+
+		usb0: ohci at 00300000 {
+			num-ports = <1>;
+			status = "okay";
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led1 {
+			label = "led1";
+			gpios = <&pioB 4 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	i2c at 0 {
+		status = "okay";
+	};
+};
diff --git a/arch/arm/configs/at91rm9200_defconfig b/arch/arm/configs/at91rm9200_defconfig
index 3b76a63..f9a2f5f 100644
--- a/arch/arm/configs/at91rm9200_defconfig
+++ b/arch/arm/configs/at91rm9200_defconfig
@@ -23,7 +23,6 @@ CONFIG_MACH_CSB637=y
 CONFIG_MACH_ATEB9200=y
 CONFIG_MACH_KB9200=y
 CONFIG_MACH_PICOTUX2XX=y
-CONFIG_MACH_KAFA=y
 CONFIG_MACH_ECBAT91=y
 CONFIG_MACH_YL9200=y
 CONFIG_MACH_CPUAT91=y
diff --git a/arch/arm/mach-at91/Kconfig.non_dt b/arch/arm/mach-at91/Kconfig.non_dt
index 867c547..cfef1de 100644
--- a/arch/arm/mach-at91/Kconfig.non_dt
+++ b/arch/arm/mach-at91/Kconfig.non_dt
@@ -93,11 +93,6 @@ config MACH_PICOTUX2XX
 	  Select this if you are using a picotux 200.
 	  <http://www.picotux.com/>
 
-config MACH_KAFA
-	bool "Sperry-Sun KAFA board"
-	help
-	  Select this if you are using Sperry-Sun's KAFA board.
-
 config MACH_ECBAT91
 	bool "emQbit ECB_AT91 SBC"
 	select HAVE_AT91_DATAFLASH_CARD
diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index dc2308b..61c19d7 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -38,7 +38,6 @@ obj-$(CONFIG_MACH_CSB337)	+= board-csb337.o
 obj-$(CONFIG_MACH_CSB637)	+= board-csb637.o
 obj-$(CONFIG_MACH_KB9200)	+= board-kb9202.o
 obj-$(CONFIG_MACH_ATEB9200)	+= board-eb9200.o
-obj-$(CONFIG_MACH_KAFA)		+= board-kafa.o
 obj-$(CONFIG_MACH_PICOTUX2XX)	+= board-picotux200.o
 obj-$(CONFIG_MACH_ECBAT91)	+= board-ecbat91.o
 obj-$(CONFIG_MACH_YL9200)	+= board-yl-9200.o
diff --git a/arch/arm/mach-at91/board-kafa.c b/arch/arm/mach-at91/board-kafa.c
deleted file mode 100644
index 88e2f5d..0000000
--- a/arch/arm/mach-at91/board-kafa.c
+++ /dev/null
@@ -1,112 +0,0 @@
-/*
- * linux/arch/arm/mach-at91/board-kafa.c
- *
- *  Copyright (C) 2006 Sperry-Sun
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
-
-#include "at91_aic.h"
-#include "board.h"
-#include "generic.h"
-
-
-static void __init kafa_init_early(void)
-{
-	/* Set cpu type: PQFP */
-	at91rm9200_set_type(ARCH_REVISON_9200_PQFP);
-
-	/* Initialize processor: 18.432 MHz crystal */
-	at91_initialize(18432000);
-}
-
-static struct macb_platform_data __initdata kafa_eth_data = {
-	.phy_irq_pin	= AT91_PIN_PC4,
-	.is_rmii	= 0,
-};
-
-static struct at91_usbh_data __initdata kafa_usbh_data = {
-	.ports		= 1,
-	.vbus_pin	= {-EINVAL, -EINVAL},
-	.overcurrent_pin= {-EINVAL, -EINVAL},
-};
-
-static struct at91_udc_data __initdata kafa_udc_data = {
-	.vbus_pin	= AT91_PIN_PB6,
-	.pullup_pin	= AT91_PIN_PB7,
-};
-
-/*
- * LEDs
- */
-static struct gpio_led kafa_leds[] = {
-	{	/* D1 */
-		.name			= "led1",
-		.gpio			= AT91_PIN_PB4,
-		.active_low		= 1,
-		.default_trigger	= "heartbeat",
-	},
-};
-
-static void __init kafa_board_init(void)
-{
-	/* Serial */
-	/* DBGU on ttyS0. (Rx & Tx only) */
-	at91_register_uart(0, 0, 0);
-
-	/* USART0 on ttyS1 (Rx, Tx, CTS, RTS) */
-	at91_register_uart(AT91RM9200_ID_US0, 1, ATMEL_UART_CTS | ATMEL_UART_RTS);
-	at91_add_device_serial();
-	/* Ethernet */
-	at91_add_device_eth(&kafa_eth_data);
-	/* USB Host */
-	at91_add_device_usbh(&kafa_usbh_data);
-	/* USB Device */
-	at91_add_device_udc(&kafa_udc_data);
-	/* I2C */
-	at91_add_device_i2c(NULL, 0);
-	/* SPI */
-	at91_add_device_spi(NULL, 0);
-	/* LEDs */
-	at91_gpio_leds(kafa_leds, ARRAY_SIZE(kafa_leds));
-}
-
-MACHINE_START(KAFA, "Sperry-Sun KAFA")
-	/* Maintainer: Sergei Sharonov */
-	.init_time	= at91rm9200_timer_init,
-	.map_io		= at91_map_io,
-	.handle_irq	= at91_aic_handle_irq,
-	.init_early	= kafa_init_early,
-	.init_irq	= at91_init_irq_default,
-	.init_machine	= kafa_board_init,
-MACHINE_END
-- 
1.8.4.rc3
