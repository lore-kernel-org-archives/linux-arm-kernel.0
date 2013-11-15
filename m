From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 15 Nov 2013 15:50:01 +0100
Subject: [PATCH 06/11] ARM: at91: switch RSI EWS board to DT
In-Reply-To: <1384527006-9040-1-git-send-email-plagnioj@jcrosoft.com>
References: <20131115143855.GR28304@ns203013.ovh.net>
 <1384527006-9040-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1384527006-9040-6-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/Makefile         |   1 +
 arch/arm/boot/dts/at91-rsi-ews.dts | 175 ++++++++++++++++++++++++++++
 arch/arm/mach-at91/Kconfig.non_dt  |   6 -
 arch/arm/mach-at91/Makefile        |   1 -
 arch/arm/mach-at91/board-rsi-ews.c | 231 -------------------------------------
 5 files changed, 176 insertions(+), 238 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91-rsi-ews.dts
 delete mode 100644 arch/arm/mach-at91/board-rsi-ews.c

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index a66de6d..cdba9ce 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -7,6 +7,7 @@ dtb-$(CONFIG_ARCH_AT91) += at91-1arm.dtb
 dtb-$(CONFIG_ARCH_AT91) += at91-carmeva.dtb
 dtb-$(CONFIG_ARCH_AT91) += at91-flexibity.dtb
 dtb-$(CONFIG_ARCH_AT91) += at91-kafa.dtb
+dtb-$(CONFIG_ARCH_AT91) += at91-rsi-ews.dtb
 dtb-$(CONFIG_ARCH_AT91) += mpa1600.dtb
 # sam9260
 dtb-$(CONFIG_ARCH_AT91) += animeo_ip.dtb
diff --git a/arch/arm/boot/dts/at91-rsi-ews.dts b/arch/arm/boot/dts/at91-rsi-ews.dts
new file mode 100644
index 0000000..2ae5af8
--- /dev/null
+++ b/arch/arm/boot/dts/at91-rsi-ews.dts
@@ -0,0 +1,175 @@
+/*
+ * at91-rsi-ews.dts - Device Tree file for RSI EWS board
+ *
+ * Copyright (C) 2013 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
+ *
+ * Licensed under GPLv2 only
+ */
+/dts-v1/;
+#include "at91rm9200.dtsi"
+
+/ {
+	model = "RSI EWS board";
+	compatible = "rsi,ews", "atmel,at91rm9200";
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
+			usart3: serial at fffcc000 {
+				pinctrl-0 =
+						<&pinctrl_uart3
+						 &pinctrl_uart3_rts>;
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
+					wp-gpios = <&pioB 29 GPIO_ACTIVE_HIGH>;
+				};
+			};
+
+			pinctrl at fffff400 {
+				mmc0 {
+					pinctrl_board_mmc0: mmc0-board {
+						atmel,pins =
+							<AT91_PIOB 27 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH
+							 AT91_PIOC 29 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;
+					};
+				};
+			};
+
+			spi0: spi at fffe0000 {
+				status = "okay";
+				cs-gpios = <&pioA 3 GPIO_ACTIVE_HIGH>, <&pioA 4 GPIO_ACTIVE_HIGH>, <0>, <0>;
+				mtd_dataflash at 0 {
+					compatible = "atmel,at45", "atmel,dataflash";
+					spi-max-frequency = <15000000>;
+					reg = <0>;
+				};
+
+				mtd_dataflash at 1 {
+					compatible = "atmel,at45", "atmel,dataflash";
+					spi-max-frequency = <15000000>;
+					reg = <1>;
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
+			reg = <0x10000000 0x1000000>;
+			linux,mtd-name = "physmap-flash.0";
+			bank-width = <2>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			boot at 0 {
+				label = "boot";
+				reg = <0x00000 0x60000>;
+			};
+
+			kernel at 60000 {
+				label = "kernel";
+				reg = <0x60000 0x1a0000>;
+			};
+
+			root at 200000 {
+				label = "kernel";
+				reg = <0x200000 0x800000>;
+			};
+
+			kernelupd at A00000  {
+				label = "kernelupd";
+				reg = <0xA00000 0x180000>;
+			};
+
+			rootupd at B80000  {
+				label = "rootupd";
+				reg = <0xB80000 0x480000>;
+			};
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led0 {
+			label = "led0";
+			gpios = <&pioB 6 GPIO_ACTIVE_HIGH>;
+		};
+
+		led1 {
+			label = "led1";
+			gpios = <&pioB 7 GPIO_ACTIVE_HIGH>;
+		};
+
+		led2 {
+			label = "led2";
+			gpios = <&pioB 8 GPIO_ACTIVE_HIGH>;
+		};
+
+		led3 {
+			label = "led3";
+			gpios = <&pioB 9 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	i2c at 0 {
+		status = "okay";
+
+		ds1337 at 68 {
+			compatible = "dallas,ds1337";
+			reg = <0x68>;
+		};
+
+		24c01 at 50 {
+			compatible = "at24,24c01";
+			reg = <0x50>;
+		};
+	};
+};
diff --git a/arch/arm/mach-at91/Kconfig.non_dt b/arch/arm/mach-at91/Kconfig.non_dt
index 694e959..af27414 100644
--- a/arch/arm/mach-at91/Kconfig.non_dt
+++ b/arch/arm/mach-at91/Kconfig.non_dt
@@ -115,12 +115,6 @@ config MACH_ECO920
 	bool "eco920"
 	help
 	  Select this if you are using the eco920 board
-
-config MACH_RSI_EWS
-	bool "RSI Embedded Webserver"
-	depends on ARCH_AT91RM9200
-	help
-	  Select this if you are using RSIs EWS board.
 endif
 
 # ----------------------------------------------------------
diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index 70e2b22..d0b2518 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -43,7 +43,6 @@ obj-$(CONFIG_MACH_ECBAT91)	+= board-ecbat91.o
 obj-$(CONFIG_MACH_YL9200)	+= board-yl-9200.o
 obj-$(CONFIG_MACH_CPUAT91)	+= board-cpuat91.o
 obj-$(CONFIG_MACH_ECO920)	+= board-eco920.o
-obj-$(CONFIG_MACH_RSI_EWS)	+= board-rsi-ews.o
 
 # AT91SAM9260 board-specific support
 obj-$(CONFIG_MACH_AT91SAM9260EK) += board-sam9260ek.o
diff --git a/arch/arm/mach-at91/board-rsi-ews.c b/arch/arm/mach-at91/board-rsi-ews.c
deleted file mode 100644
index f6d7f19..0000000
--- a/arch/arm/mach-at91/board-rsi-ews.c
+++ /dev/null
@@ -1,231 +0,0 @@
-/*
- * board-rsi-ews.c
- *
- *  Copyright (C)
- *  2005 SAN People,
- *  2008-2011 R-S-I Elektrotechnik GmbH & Co. KG
- *
- * Licensed under GPLv2 or later.
- */
-
-#include <linux/types.h>
-#include <linux/init.h>
-#include <linux/mm.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/spi/spi.h>
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
-#include <linux/gpio.h>
-
-#include "at91_aic.h"
-#include "board.h"
-#include "generic.h"
-
-static void __init rsi_ews_init_early(void)
-{
-	/* Initialize processor: 18.432 MHz crystal */
-	at91_initialize(18432000);
-}
-
-/*
- * Ethernet
- */
-static struct macb_platform_data rsi_ews_eth_data __initdata = {
-	.phy_irq_pin	= AT91_PIN_PC4,
-	.is_rmii	= 1,
-};
-
-/*
- * USB Host
- */
-static struct at91_usbh_data rsi_ews_usbh_data __initdata = {
-	.ports		= 1,
-	.vbus_pin	= {-EINVAL, -EINVAL},
-	.overcurrent_pin= {-EINVAL, -EINVAL},
-};
-
-/*
- * SD/MC
- */
-static struct mci_platform_data __initdata rsi_ews_mci0_data = {
-	.slot[0] = {
-		.bus_width	= 4,
-		.detect_pin	= AT91_PIN_PB27,
-		.wp_pin		= AT91_PIN_PB29,
-	},
-};
-
-/*
- * I2C
- */
-static struct i2c_board_info rsi_ews_i2c_devices[] __initdata = {
-	{
-		I2C_BOARD_INFO("ds1337", 0x68),
-	},
-	{
-		I2C_BOARD_INFO("24c01", 0x50),
-	}
-};
-
-/*
- * LEDs
- */
-static struct gpio_led rsi_ews_leds[] = {
-	{
-		.name			= "led0",
-		.gpio			= AT91_PIN_PB6,
-		.active_low		= 0,
-	},
-	{
-		.name			= "led1",
-		.gpio			= AT91_PIN_PB7,
-		.active_low		= 0,
-	},
-	{
-		.name			= "led2",
-		.gpio			= AT91_PIN_PB8,
-		.active_low		= 0,
-	},
-	{
-		.name			= "led3",
-		.gpio			= AT91_PIN_PB9,
-		.active_low		= 0,
-	},
-};
-
-/*
- * DataFlash
- */
-static struct spi_board_info rsi_ews_spi_devices[] = {
-	{	/* DataFlash chip 1*/
-		.modalias	= "mtd_dataflash",
-		.chip_select	= 0,
-		.max_speed_hz	= 5 * 1000 * 1000,
-	},
-	{	/* DataFlash chip 2*/
-		.modalias	= "mtd_dataflash",
-		.chip_select	= 1,
-		.max_speed_hz	= 5 * 1000 * 1000,
-	},
-};
-
-/*
- * NOR flash
- */
-static struct mtd_partition rsiews_nor_partitions[] = {
-	{
-		.name		= "boot",
-		.offset		= 0,
-		.size		= 3 * SZ_128K,
-		.mask_flags	= MTD_WRITEABLE
-	},
-	{
-		.name		= "kernel",
-		.offset		= MTDPART_OFS_NXTBLK,
-		.size		= SZ_2M - (3 * SZ_128K)
-	},
-	{
-		.name		= "root",
-		.offset		= MTDPART_OFS_NXTBLK,
-		.size		= SZ_8M
-	},
-	{
-		.name		= "kernelupd",
-		.offset		= MTDPART_OFS_NXTBLK,
-		.size		= 3 * SZ_512K,
-		.mask_flags	= MTD_WRITEABLE
-	},
-	{
-		.name		= "rootupd",
-		.offset		= MTDPART_OFS_NXTBLK,
-		.size		= 9 * SZ_512K,
-		.mask_flags	= MTD_WRITEABLE
-	},
-};
-
-static struct physmap_flash_data rsiews_nor_data = {
-	.width		= 2,
-	.parts		= rsiews_nor_partitions,
-	.nr_parts	= ARRAY_SIZE(rsiews_nor_partitions),
-};
-
-#define NOR_BASE	AT91_CHIPSELECT_0
-#define NOR_SIZE	SZ_16M
-
-static struct resource nor_flash_resources[] = {
-	{
-		.start	= NOR_BASE,
-		.end	= NOR_BASE + NOR_SIZE - 1,
-		.flags	= IORESOURCE_MEM,
-	}
-};
-
-static struct platform_device rsiews_nor_flash = {
-	.name		= "physmap-flash",
-	.id		= 0,
-	.dev		= {
-				.platform_data	= &rsiews_nor_data,
-	},
-	.resource	= nor_flash_resources,
-	.num_resources	= ARRAY_SIZE(nor_flash_resources),
-};
-
-/*
- * Init Func
- */
-static void __init rsi_ews_board_init(void)
-{
-	/* Serial */
-	/* DBGU on ttyS0. (Rx & Tx only) */
-	/* This one is for debugging */
-	at91_register_uart(0, 0, 0);
-
-	/* USART1 on ttyS2. (Rx, Tx, CTS, RTS, DTR, DSR, DCD, RI) */
-	/* Dialin/-out modem interface */
-	at91_register_uart(AT91RM9200_ID_US1, 2, ATMEL_UART_CTS | ATMEL_UART_RTS
-			   | ATMEL_UART_DTR | ATMEL_UART_DSR | ATMEL_UART_DCD
-			   | ATMEL_UART_RI);
-
-	/* USART3 on ttyS4. (Rx, Tx, RTS) */
-	/* RS485 communication */
-	at91_register_uart(AT91RM9200_ID_US3, 4, ATMEL_UART_RTS);
-	at91_add_device_serial();
-	at91_set_gpio_output(AT91_PIN_PA21, 0);
-	/* Ethernet */
-	at91_add_device_eth(&rsi_ews_eth_data);
-	/* USB Host */
-	at91_add_device_usbh(&rsi_ews_usbh_data);
-	/* I2C */
-	at91_add_device_i2c(rsi_ews_i2c_devices,
-			ARRAY_SIZE(rsi_ews_i2c_devices));
-	/* SPI */
-	at91_add_device_spi(rsi_ews_spi_devices,
-			ARRAY_SIZE(rsi_ews_spi_devices));
-	/* MMC */
-	at91_add_device_mci(0, &rsi_ews_mci0_data);
-	/* NOR Flash */
-	platform_device_register(&rsiews_nor_flash);
-	/* LEDs */
-	at91_gpio_leds(rsi_ews_leds, ARRAY_SIZE(rsi_ews_leds));
-}
-
-MACHINE_START(RSI_EWS, "RSI EWS")
-	/* Maintainer: Josef Holzmayr <holzmayr@rsi-elektrotechnik.de> */
-	.init_time	= at91rm9200_timer_init,
-	.map_io		= at91_map_io,
-	.handle_irq	= at91_aic_handle_irq,
-	.init_early	= rsi_ews_init_early,
-	.init_irq	= at91_init_irq_default,
-	.init_machine	= rsi_ews_board_init,
-MACHINE_END
-- 
1.8.4.rc3
