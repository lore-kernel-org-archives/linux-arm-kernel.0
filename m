From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 15 Nov 2013 15:49:57 +0100
Subject: [PATCH 02/11] ARM: at91: switch 1arm to DT
In-Reply-To: <1384527006-9040-1-git-send-email-plagnioj@jcrosoft.com>
References: <20131115143855.GR28304@ns203013.ovh.net>
 <1384527006-9040-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1384527006-9040-2-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/Makefile            |  1 +
 arch/arm/boot/dts/at91-1arm.dts       | 70 +++++++++++++++++++++++++
 arch/arm/configs/at91rm9200_defconfig |  1 -
 arch/arm/mach-at91/Kconfig.non_dt     |  6 ---
 arch/arm/mach-at91/Makefile           |  1 -
 arch/arm/mach-at91/board-1arm.c       | 99 -----------------------------------
 6 files changed, 71 insertions(+), 107 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91-1arm.dts
 delete mode 100644 arch/arm/mach-at91/board-1arm.c

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 802720e..f1fb6d7 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -3,6 +3,7 @@ ifeq ($(CONFIG_OF),y)
 # Keep at91 dtb files sorted alphabetically for each SoC
 # rm9200
 dtb-$(CONFIG_ARCH_AT91) += at91rm9200ek.dtb
+dtb-$(CONFIG_ARCH_AT91) += at91-1arm.dtb
 dtb-$(CONFIG_ARCH_AT91) += mpa1600.dtb
 # sam9260
 dtb-$(CONFIG_ARCH_AT91) += animeo_ip.dtb
diff --git a/arch/arm/boot/dts/at91-1arm.dts b/arch/arm/boot/dts/at91-1arm.dts
new file mode 100644
index 0000000..39b0c56
--- /dev/null
+++ b/arch/arm/boot/dts/at91-1arm.dts
@@ -0,0 +1,70 @@
+/*
+ * at91-1arm.dts - Device Tree file for Ajeco 1ARM single board computer
+ *
+ * Copyright (C) 2013 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
+ *
+ * Licensed under GPLv2 only
+ */
+/dts-v1/;
+#include "at91rm9200_pqfp.dtsi"
+
+/ {
+	model = "Ajeco 1ARM single board computer";
+	compatible = "ajeco,1arm", "atmel,at91rm9200-pqfp", "atmel,at91rm9200";
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
+
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
+				atmel,vbus-gpio = <&pioC 2 0>;
+				atmel,pullup-gpio = <&pioC 3 0>;
+				status = "okay";
+			};
+		};
+
+		usb0: ohci at 00300000 {
+			num-ports = <1>;
+			status = "okay";
+		};
+	};
+};
diff --git a/arch/arm/configs/at91rm9200_defconfig b/arch/arm/configs/at91rm9200_defconfig
index 75502c4..d333250 100644
--- a/arch/arm/configs/at91rm9200_defconfig
+++ b/arch/arm/configs/at91rm9200_defconfig
@@ -17,7 +17,6 @@ CONFIG_MODULE_SRCVERSION_ALL=y
 # CONFIG_IOSCHED_CFQ is not set
 CONFIG_ARCH_AT91=y
 CONFIG_ARCH_AT91RM9200=y
-CONFIG_MACH_ONEARM=y
 CONFIG_MACH_AT91RM9200EK=y
 CONFIG_MACH_CSB337=y
 CONFIG_MACH_CSB637=y
diff --git a/arch/arm/mach-at91/Kconfig.non_dt b/arch/arm/mach-at91/Kconfig.non_dt
index ca900be..4dcf706 100644
--- a/arch/arm/mach-at91/Kconfig.non_dt
+++ b/arch/arm/mach-at91/Kconfig.non_dt
@@ -56,12 +56,6 @@ if ARCH_AT91RM9200
 
 comment "AT91RM9200 Board Type"
 
-config MACH_ONEARM
-	bool "Ajeco 1ARM Single Board Computer"
-	help
-	  Select this if you are using Ajeco's 1ARM Single Board Computer.
-	  <http://www.ajeco.fi/>
-
 config MACH_AT91RM9200EK
 	bool "Atmel AT91RM9200-EK Evaluation Kit"
 	select HAVE_AT91_DATAFLASH_CARD
diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index 3b0a953..5c5534c 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -33,7 +33,6 @@ obj-$(CONFIG_ARCH_AT91SAM9G45)	+= at91sam9g45_devices.o
 obj-$(CONFIG_ARCH_AT91X40)	+= at91x40.o at91x40_time.o
 
 # AT91RM9200 board-specific support
-obj-$(CONFIG_MACH_ONEARM)	+= board-1arm.o
 obj-$(CONFIG_MACH_AT91RM9200EK)	+= board-rm9200ek.o
 obj-$(CONFIG_MACH_CSB337)	+= board-csb337.o
 obj-$(CONFIG_MACH_CSB637)	+= board-csb637.o
diff --git a/arch/arm/mach-at91/board-1arm.c b/arch/arm/mach-at91/board-1arm.c
deleted file mode 100644
index 35ab632..0000000
--- a/arch/arm/mach-at91/board-1arm.c
+++ /dev/null
@@ -1,99 +0,0 @@
-/*
- * linux/arch/arm/mach-at91/board-1arm.c
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
-static void __init onearm_init_early(void)
-{
-	/* Set cpu type: PQFP */
-	at91rm9200_set_type(ARCH_REVISON_9200_PQFP);
-
-	/* Initialize processor: 18.432 MHz crystal */
-	at91_initialize(18432000);
-}
-
-static struct macb_platform_data __initdata onearm_eth_data = {
-	.phy_irq_pin	= AT91_PIN_PC4,
-	.is_rmii	= 1,
-};
-
-static struct at91_usbh_data __initdata onearm_usbh_data = {
-	.ports		= 1,
-	.vbus_pin	= {-EINVAL, -EINVAL},
-	.overcurrent_pin= {-EINVAL, -EINVAL},
-};
-
-static struct at91_udc_data __initdata onearm_udc_data = {
-	.vbus_pin	= AT91_PIN_PC2,
-	.pullup_pin	= AT91_PIN_PC3,
-};
-
-static void __init onearm_board_init(void)
-{
-	/* Serial */
-	/* DBGU on ttyS0. (Rx & Tx only) */
-	at91_register_uart(0, 0, 0);
-
-	/* USART0 on ttyS1 (Rx, Tx, CTS, RTS) */
-	at91_register_uart(AT91RM9200_ID_US0, 1, ATMEL_UART_CTS | ATMEL_UART_RTS);
-
-	/* USART1 on ttyS2 (Rx, Tx, CTS, RTS, DTR, DSR, DCD, RI) */
-	at91_register_uart(AT91RM9200_ID_US1, 2, ATMEL_UART_CTS | ATMEL_UART_RTS
-			   | ATMEL_UART_DTR | ATMEL_UART_DSR | ATMEL_UART_DCD
-			   | ATMEL_UART_RI);
-	at91_add_device_serial();
-	/* Ethernet */
-	at91_add_device_eth(&onearm_eth_data);
-	/* USB Host */
-	at91_add_device_usbh(&onearm_usbh_data);
-	/* USB Device */
-	at91_add_device_udc(&onearm_udc_data);
-}
-
-MACHINE_START(ONEARM, "Ajeco 1ARM single board computer")
-	/* Maintainer: Lennert Buytenhek <buytenh@wantstofly.org> */
-	.init_time	= at91rm9200_timer_init,
-	.map_io		= at91_map_io,
-	.handle_irq	= at91_aic_handle_irq,
-	.init_early	= onearm_init_early,
-	.init_irq	= at91_init_irq_default,
-	.init_machine	= onearm_board_init,
-MACHINE_END
-- 
1.8.4.rc3
