From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 15 Nov 2013 15:50:03 +0100
Subject: [PATCH 08/11] ARM: at91: switch ecbat91 board to DT
In-Reply-To: <1384527006-9040-1-git-send-email-plagnioj@jcrosoft.com>
References: <20131115143855.GR28304@ns203013.ovh.net>
 <1384527006-9040-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1384527006-9040-8-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/Makefile            |   1 +
 arch/arm/boot/dts/at91-ecbat91.dts    | 135 ++++++++++++++++++++++++
 arch/arm/configs/at91rm9200_defconfig |   1 -
 arch/arm/mach-at91/Kconfig.non_dt     |   7 --
 arch/arm/mach-at91/Makefile           |   1 -
 arch/arm/mach-at91/board-ecbat91.c    | 190 ----------------------------------
 6 files changed, 136 insertions(+), 199 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91-ecbat91.dts
 delete mode 100644 arch/arm/mach-at91/board-ecbat91.c

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index ade7686..d37d226 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -5,6 +5,7 @@ ifeq ($(CONFIG_OF),y)
 dtb-$(CONFIG_ARCH_AT91) += at91rm9200ek.dtb
 dtb-$(CONFIG_ARCH_AT91) += at91-1arm.dtb
 dtb-$(CONFIG_ARCH_AT91) += at91-carmeva.dtb
+dtb-$(CONFIG_ARCH_AT91) += at91-ecbat91.dtb
 dtb-$(CONFIG_ARCH_AT91) += at91-flexibity.dtb
 dtb-$(CONFIG_ARCH_AT91) += at91-kafa.dtb
 dtb-$(CONFIG_ARCH_AT91) += at91-picotux-200.dtb
diff --git a/arch/arm/boot/dts/at91-ecbat91.dts b/arch/arm/boot/dts/at91-ecbat91.dts
new file mode 100644
index 0000000..d9c1b6c
--- /dev/null
+++ b/arch/arm/boot/dts/at91-ecbat91.dts
@@ -0,0 +1,135 @@
+/*
+ * at91-ecbat91.dts - Device Tree file for ecbat91 board
+ *
+ * Copyright (C) 2013 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
+ *
+ * Licensed under GPLv2 only
+ */
+/dts-v1/;
+#include "at91rm9200_pqfp.dtsi"
+
+/ {
+	model = "emQbit's ECB_AT91";
+	compatible = "emqbit,ecb-at91", "atmel,at91rm9200-pqfp", "atmel,at91rm9200";
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
+				status = "okay";
+			};
+
+			macb0: ethernet at fffbc000 {
+				phy-mode = "mii";
+				status = "okay";
+				/* phy irq on PC4 */
+				pinctrl-0 = <&pinctrl_macb_rmii &pinctrl_macb_rmii_mii>;
+			};
+
+			mmc0: mmc at fffb4000 {
+				pinctrl-0 = <
+					&pinctrl_mmc0_clk
+					&pinctrl_mmc0_slot0_cmd_dat0
+					&pinctrl_mmc0_slot0_dat1_3>;
+				status = "okay";
+				slot at 0 {
+					reg = <0>;
+					bus-width = <4>;
+				};
+			};
+
+			spi0: spi at fffe0000 {
+				status = "okay";
+				cs-gpios =
+					<&pioA 3 GPIO_ACTIVE_HIGH>,
+					<&pioA 4 GPIO_ACTIVE_HIGH>,
+					<&pioA 5 GPIO_ACTIVE_HIGH>,
+					<&pioA 6 GPIO_ACTIVE_HIGH>;
+
+				mtd_dataflash at 0 {
+					compatible = "atmel,at45", "atmel,dataflash";
+					spi-max-frequency = <10000000>;
+					reg = <0>;
+					#address-cells = <1>;
+					#size-cells = <1>;
+
+					darrell_loader at 0 {
+						label = "Darrell-loade";
+						reg = <0x00000 0x3180>;
+					};
+
+					uboot at 3180 {
+						label = "U-boot";
+						reg = <0x3180 0x1C5C0>;
+					};
+
+					ubootenv at 1F740 {
+						label = "UBoot-env";
+						reg = <0x1F740 0x2100>;
+					};
+
+					kernel at 21840  {
+						label = "Kernel";
+						reg = <0x21840 0x18B7C0>;
+					};
+
+					filesystem at 1ad000  {
+						label = "Filesystem";
+						reg = <0x1ad000 0x53000>;
+					};
+				};
+
+				spidev at 1 {
+					compatible = "spidev";
+					spi-max-frequency = <2500000>;
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
+			gpios = <&pioC 7 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	i2c at 0 {
+		status = "okay";
+	};
+};
diff --git a/arch/arm/configs/at91rm9200_defconfig b/arch/arm/configs/at91rm9200_defconfig
index cbd5bf1..92979f2 100644
--- a/arch/arm/configs/at91rm9200_defconfig
+++ b/arch/arm/configs/at91rm9200_defconfig
@@ -22,7 +22,6 @@ CONFIG_MACH_CSB337=y
 CONFIG_MACH_CSB637=y
 CONFIG_MACH_ATEB9200=y
 CONFIG_MACH_KB9200=y
-CONFIG_MACH_ECBAT91=y
 CONFIG_MACH_YL9200=y
 CONFIG_MACH_CPUAT91=y
 CONFIG_MACH_ECO920=y
diff --git a/arch/arm/mach-at91/Kconfig.non_dt b/arch/arm/mach-at91/Kconfig.non_dt
index 254166b..d60487a 100644
--- a/arch/arm/mach-at91/Kconfig.non_dt
+++ b/arch/arm/mach-at91/Kconfig.non_dt
@@ -87,13 +87,6 @@ config MACH_KB9200
 	  Select this if you are using KwikByte's KB920x board.
 	  <http://www.kwikbyte.com/KB9202.html>
 
-config MACH_ECBAT91
-	bool "emQbit ECB_AT91 SBC"
-	select HAVE_AT91_DATAFLASH_CARD
-	help
-	  Select this if you are using emQbit's ECB_AT91 board.
-	  <http://wiki.emqbit.com/free-ecb-at91>
-
 config MACH_YL9200
 	bool "ucDragon YL-9200"
 	help
diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index 6d08a51..983254a 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -38,7 +38,6 @@ obj-$(CONFIG_MACH_CSB337)	+= board-csb337.o
 obj-$(CONFIG_MACH_CSB637)	+= board-csb637.o
 obj-$(CONFIG_MACH_KB9200)	+= board-kb9202.o
 obj-$(CONFIG_MACH_ATEB9200)	+= board-eb9200.o
-obj-$(CONFIG_MACH_ECBAT91)	+= board-ecbat91.o
 obj-$(CONFIG_MACH_YL9200)	+= board-yl-9200.o
 obj-$(CONFIG_MACH_CPUAT91)	+= board-cpuat91.o
 obj-$(CONFIG_MACH_ECO920)	+= board-eco920.o
diff --git a/arch/arm/mach-at91/board-ecbat91.c b/arch/arm/mach-at91/board-ecbat91.c
deleted file mode 100644
index b2fcd71..0000000
--- a/arch/arm/mach-at91/board-ecbat91.c
+++ /dev/null
@@ -1,190 +0,0 @@
-/*
- * linux/arch/arm/mach-at91rm9200/board-ecbat91.c
- * Copyright (C) 2007 emQbit.com.
- *
- * We started from board-dk.c, which is Copyright (C) 2005 SAN People.
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
-#include <linux/spi/flash.h>
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
-static void __init ecb_at91init_early(void)
-{
-	/* Set cpu type: PQFP */
-	at91rm9200_set_type(ARCH_REVISON_9200_PQFP);
-
-	/* Initialize processor: 18.432 MHz crystal */
-	at91_initialize(18432000);
-}
-
-static struct macb_platform_data __initdata ecb_at91eth_data = {
-	.phy_irq_pin	= AT91_PIN_PC4,
-	.is_rmii	= 0,
-};
-
-static struct at91_usbh_data __initdata ecb_at91usbh_data = {
-	.ports		= 1,
-	.vbus_pin	= {-EINVAL, -EINVAL},
-	.overcurrent_pin= {-EINVAL, -EINVAL},
-};
-
-static struct mci_platform_data __initdata ecbat91_mci0_data = {
-	.slot[0] = {
-		.bus_width	= 4,
-		.detect_pin	= -EINVAL,
-		.wp_pin		= -EINVAL,
-	},
-};
-
-
-#if defined(CONFIG_MTD_DATAFLASH)
-static struct mtd_partition __initdata my_flash0_partitions[] =
-{
-	{	/* 0x8400 */
-		.name	= "Darrell-loader",
-		.offset	= 0,
-		.size	= 12 * 1056,
-	},
-	{
-		.name	= "U-boot",
-		.offset	= MTDPART_OFS_NXTBLK,
-		.size	= 110 * 1056,
-	},
-	{	/* 1336 (167 blocks) pages * 1056 bytes = 0x158700 bytes */
-		.name	= "UBoot-env",
-		.offset	= MTDPART_OFS_NXTBLK,
-		.size	= 8 * 1056,
-	},
-	{	/* 1336 (167 blocks) pages * 1056 bytes = 0x158700 bytes */
-		.name	= "Kernel",
-		.offset	= MTDPART_OFS_NXTBLK,
-		.size	= 1534 * 1056,
-	},
-	{	/* 190200 - jffs2 root filesystem */
-		.name	= "Filesystem",
-		.offset	= MTDPART_OFS_NXTBLK,
-		.size	= MTDPART_SIZ_FULL,	/* 26 sectors */
-	}
-};
-
-static struct flash_platform_data __initdata my_flash0_platform = {
-	.name		= "Removable flash card",
-	.parts		= my_flash0_partitions,
-	.nr_parts	= ARRAY_SIZE(my_flash0_partitions)
-};
-
-#endif
-
-static struct spi_board_info __initdata ecb_at91spi_devices[] = {
-	{	/* DataFlash chip */
-		.modalias	= "mtd_dataflash",
-		.chip_select	= 0,
-		.max_speed_hz	= 10 * 1000 * 1000,
-		.bus_num	= 0,
-#if defined(CONFIG_MTD_DATAFLASH)
-		.platform_data	= &my_flash0_platform,
-#endif
-	},
-	{	/* User accessible spi - cs1 (250KHz) */
-		.modalias	= "spi-cs1",
-		.chip_select	= 1,
-		.max_speed_hz	= 250 * 1000,
-	},
-	{	/* User accessible spi - cs2 (1MHz) */
-		.modalias	= "spi-cs2",
-		.chip_select	= 2,
-		.max_speed_hz	= 1 * 1000 * 1000,
-	},
-	{	/* User accessible spi - cs3 (10MHz) */
-		.modalias	= "spi-cs3",
-		.chip_select	= 3,
-		.max_speed_hz	= 10 * 1000 * 1000,
-	},
-};
-
-/*
- * LEDs
- */
-static struct gpio_led ecb_leds[] = {
-	{	/* D1 */
-		.name			= "led1",
-		.gpio			= AT91_PIN_PC7,
-		.active_low		= 1,
-		.default_trigger	= "heartbeat",
-	}
-};
-
-static void __init ecb_at91board_init(void)
-{
-	/* Serial */
-	/* DBGU on ttyS0. (Rx & Tx only) */
-	at91_register_uart(0, 0, 0);
-
-	/* USART0 on ttyS1. (Rx & Tx only) */
-	at91_register_uart(AT91RM9200_ID_US0, 1, 0);
-	at91_add_device_serial();
-
-	/* Ethernet */
-	at91_add_device_eth(&ecb_at91eth_data);
-
-	/* USB Host */
-	at91_add_device_usbh(&ecb_at91usbh_data);
-
-	/* I2C */
-	at91_add_device_i2c(NULL, 0);
-
-	/* MMC */
-	at91_add_device_mci(0, &ecbat91_mci0_data);
-
-	/* SPI */
-	at91_add_device_spi(ecb_at91spi_devices, ARRAY_SIZE(ecb_at91spi_devices));
-
-	/* LEDs */
-	at91_gpio_leds(ecb_leds, ARRAY_SIZE(ecb_leds));
-}
-
-MACHINE_START(ECBAT91, "emQbit's ECB_AT91")
-	/* Maintainer: emQbit.com */
-	.init_time	= at91rm9200_timer_init,
-	.map_io		= at91_map_io,
-	.handle_irq	= at91_aic_handle_irq,
-	.init_early	= ecb_at91init_early,
-	.init_irq	= at91_init_irq_default,
-	.init_machine	= ecb_at91board_init,
-MACHINE_END
-- 
1.8.4.rc3
