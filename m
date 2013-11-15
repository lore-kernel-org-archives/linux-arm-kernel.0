From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 15 Nov 2013 15:50:06 +0100
Subject: [PATCH 11/11] ARM: at91: switch Calao QIL-A9260 board to DT
In-Reply-To: <1384527006-9040-1-git-send-email-plagnioj@jcrosoft.com>
References: <20131115143855.GR28304@ns203013.ovh.net>
 <1384527006-9040-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1384527006-9040-11-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/Makefile                  |   1 +
 arch/arm/boot/dts/at91-qil_a9260.dts        | 185 +++++++++++++++++++
 arch/arm/configs/at91sam9260_9g20_defconfig |   1 -
 arch/arm/mach-at91/Kconfig.non_dt           |   6 -
 arch/arm/mach-at91/Makefile                 |   1 -
 arch/arm/mach-at91/board-qil-a9260.c        | 266 ----------------------------
 6 files changed, 186 insertions(+), 274 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91-qil_a9260.dts
 delete mode 100644 arch/arm/mach-at91/board-qil-a9260.c

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index d042c68..1de1ba2 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -15,6 +15,7 @@ dtb-$(CONFIG_ARCH_AT91) += at91-rsi-ews.dtb
 dtb-$(CONFIG_ARCH_AT91) += mpa1600.dtb
 # sam9260
 dtb-$(CONFIG_ARCH_AT91) += animeo_ip.dtb
+dtb-$(CONFIG_ARCH_AT91) += at91-qil_a9260.dtb
 dtb-$(CONFIG_ARCH_AT91) += aks-cdu.dtb
 dtb-$(CONFIG_ARCH_AT91) += ethernut5.dtb
 dtb-$(CONFIG_ARCH_AT91) += evk-pro3.dtb
diff --git a/arch/arm/boot/dts/at91-qil_a9260.dts b/arch/arm/boot/dts/at91-qil_a9260.dts
new file mode 100644
index 0000000..d3d52dd
--- /dev/null
+++ b/arch/arm/boot/dts/at91-qil_a9260.dts
@@ -0,0 +1,185 @@
+/*
+ * at91-qil_a9260.dts - Device Tree file for Caloa QIL A9260 board
+ *
+ * Copyright (C) 2011-2013 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
+ *
+ * Licensed under GPLv2.
+ */
+/dts-v1/;
+#include "at91sam9260.dtsi"
+/ {
+	model = "Calao QIL A9260";
+	compatible = "calao,qil-a9260", "atmel,at91sam9260", "atmel,at91sam9";
+
+	chosen {
+		bootargs = "mem=64M console=ttyS0,115200 root=/dev/mtdblock5 rw rootfstype=ubifs";
+	};
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
+			clock-frequency = <12000000>;
+		};
+	};
+
+	ahb {
+		apb {
+			shdwc at fffffd10 {
+				atmel,wakeup-counter = <10>;
+				atmel,wakeup-rtt-timer;
+			};
+
+			dbgu: serial at fffff200 {
+				status = "okay";
+			};
+
+			usart0: serial at fffb0000 {
+				pinctrl-0 =
+					<&pinctrl_usart0
+					 &pinctrl_usart0_rts
+					 &pinctrl_usart0_cts
+					 &pinctrl_usart0_dtr_dsr
+					 &pinctrl_usart0_dcd
+					 &pinctrl_usart0_ri>;
+				status = "okay";
+			};
+
+			usart1: serial at fffb4000 {
+				pinctrl-0 =
+					<&pinctrl_usart1
+					 &pinctrl_usart1_rts
+					 &pinctrl_usart1_cts>;
+				status = "okay";
+			};
+
+			usart2: serial at fffb8000 {
+				pinctrl-0 =
+					<&pinctrl_usart2
+					 &pinctrl_usart2_rts
+					 &pinctrl_usart2_cts>;
+				status = "okay";
+			};
+
+			macb0: ethernet at fffc4000 {
+				phy-mode = "rmii";
+				status = "okay";
+			};
+
+			usb1: gadget at fffa4000 {
+				atmel,vbus-gpio = <&pioC 5 GPIO_ACTIVE_HIGH>;
+				status = "okay";
+			};
+
+			spi0: spi at fffc8000 {
+				status = "okay";
+				cs-gpios = <&pioA 3 GPIO_ACTIVE_HIGH>;
+
+				m41t94 at 0 {
+					compatible = "st,m41t94";
+					reg = <0>;
+					spi-max-frequency = <1000000>;
+				};
+
+			};
+
+			mmc0: mmc at fffa8000 {
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
+		};
+
+		nand0: nand at 40000000 {
+			nand-bus-width = <8>;
+			nand-ecc-mode = "soft";
+			nand-on-flash-bbt;
+			status = "okay";
+
+			at91bootstrap at 0 {
+				label = "at91bootstrap";
+				reg = <0x0 0x20000>;
+			};
+
+			barebox at 20000 {
+				label = "barebox";
+				reg = <0x20000 0x40000>;
+			};
+
+			bareboxenv at 60000 {
+				label = "bareboxenv";
+				reg = <0x60000 0x20000>;
+			};
+
+			bareboxenv2 at 80000 {
+				label = "bareboxenv2";
+				reg = <0x80000 0x20000>;
+			};
+
+			oftree at 80000 {
+				label = "oftree";
+				reg = <0xa0000 0x20000>;
+			};
+
+			kernel at a0000 {
+				label = "kernel";
+				reg = <0xc0000 0x400000>;
+			};
+
+			rootfs at 4a0000 {
+				label = "rootfs";
+				reg = <0x4c0000 0x7800000>;
+			};
+
+			data at 7ca0000 {
+				label = "data";
+				reg = <0x7cc0000 0x8340000>;
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
+		user_led {
+			label = "user_led";
+			gpios = <&pioB 21 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		user_pb {
+			label = "user_pb";
+			gpios = <&pioB 10 GPIO_ACTIVE_LOW>;
+			linux,code = <28>;
+			gpio-key,wakeup;
+		};
+	};
+
+	i2c at 0 {
+		status = "okay";
+	};
+};
diff --git a/arch/arm/configs/at91sam9260_9g20_defconfig b/arch/arm/configs/at91sam9260_9g20_defconfig
index ab66867..64700c31 100644
--- a/arch/arm/configs/at91sam9260_9g20_defconfig
+++ b/arch/arm/configs/at91sam9260_9g20_defconfig
@@ -15,7 +15,6 @@ CONFIG_MACH_AT91SAM9260EK=y
 CONFIG_MACH_CAM60=y
 CONFIG_MACH_SAM9_L9260=y
 CONFIG_MACH_AFEB9260=y
-CONFIG_MACH_QIL_A9260=y
 CONFIG_MACH_CPU9260=y
 CONFIG_MACH_AT91SAM9G20EK=y
 CONFIG_MACH_AT91SAM9G20EK_2MMC=y
diff --git a/arch/arm/mach-at91/Kconfig.non_dt b/arch/arm/mach-at91/Kconfig.non_dt
index c193a13..d16075a 100644
--- a/arch/arm/mach-at91/Kconfig.non_dt
+++ b/arch/arm/mach-at91/Kconfig.non_dt
@@ -128,12 +128,6 @@ config MACH_AFEB9260
 	  <svn://194.85.238.22/home/users/george/svn/arm9eb>
 	  <http://groups.google.com/group/arm9fpga-evolution-board>
 
-config MACH_QIL_A9260
-	bool "CALAO QIL-A9260 board"
-	help
-	  Select this if you are using a Calao Systems QIL-A9260 Board.
-	  <http://www.calao-systems.com>
-
 config MACH_CPU9260
 	bool "Eukrea CPU9260 board"
 	help
diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index 8eda4b0..fb9ecd4 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -44,7 +44,6 @@ obj-$(CONFIG_MACH_ECO920)	+= board-eco920.o
 obj-$(CONFIG_MACH_AT91SAM9260EK) += board-sam9260ek.o
 obj-$(CONFIG_MACH_CAM60)	+= board-cam60.o
 obj-$(CONFIG_MACH_SAM9_L9260)	+= board-sam9-l9260.o
-obj-$(CONFIG_MACH_QIL_A9260)	+= board-qil-a9260.o
 obj-$(CONFIG_MACH_AFEB9260)	+= board-afeb-9260v1.o
 obj-$(CONFIG_MACH_CPU9260)	+= board-cpu9krea.o
 
diff --git a/arch/arm/mach-at91/board-qil-a9260.c b/arch/arm/mach-at91/board-qil-a9260.c
deleted file mode 100644
index aa3bc9b..0000000
--- a/arch/arm/mach-at91/board-qil-a9260.c
+++ /dev/null
@@ -1,266 +0,0 @@
-/*
- * linux/arch/arm/mach-at91/board-qil-a9260.c
- *
- *  Copyright (C) 2005 SAN People
- *  Copyright (C) 2006 Atmel
- *  Copyright (C) 2007 Calao-systems
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
-#include <linux/gpio_keys.h>
-#include <linux/input.h>
-#include <linux/clk.h>
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
-#include <mach/at91sam9_smc.h>
-
-#include "at91_aic.h"
-#include "at91_shdwc.h"
-#include "board.h"
-#include "sam9_smc.h"
-#include "generic.h"
-
-
-static void __init ek_init_early(void)
-{
-	/* Initialize processor: 12.000 MHz crystal */
-	at91_initialize(12000000);
-}
-
-/*
- * USB Host port
- */
-static struct at91_usbh_data __initdata ek_usbh_data = {
-	.ports		= 2,
-	.vbus_pin	= {-EINVAL, -EINVAL},
-	.overcurrent_pin= {-EINVAL, -EINVAL},
-};
-
-/*
- * USB Device port
- */
-static struct at91_udc_data __initdata ek_udc_data = {
-	.vbus_pin	= AT91_PIN_PC5,
-	.pullup_pin	= -EINVAL,		/* pull-up driven by UDC */
-};
-
-/*
- * SPI devices.
- */
-static struct spi_board_info ek_spi_devices[] = {
-#if defined(CONFIG_RTC_DRV_M41T94)
-	{	/* M41T94 RTC */
-		.modalias	= "m41t94",
-		.chip_select	= 0,
-		.max_speed_hz	= 1 * 1000 * 1000,
-		.bus_num	= 0,
-	}
-#endif
-};
-
-/*
- * MACB Ethernet device
- */
-static struct macb_platform_data __initdata ek_macb_data = {
-	.phy_irq_pin	= AT91_PIN_PA31,
-	.is_rmii	= 1,
-};
-
-/*
- * NAND flash
- */
-static struct mtd_partition __initdata ek_nand_partition[] = {
-	{
-		.name	= "Uboot & Kernel",
-		.offset	= 0,
-		.size	= SZ_16M,
-	},
-	{
-		.name	= "Root FS",
-		.offset	= MTDPART_OFS_NXTBLK,
-		.size	= 120 * SZ_1M,
-	},
-	{
-		.name	= "FS",
-		.offset	= MTDPART_OFS_NXTBLK,
-		.size	= 120 * SZ_1M,
-	},
-};
-
-static struct atmel_nand_data __initdata ek_nand_data = {
-	.ale		= 21,
-	.cle		= 22,
-	.det_pin	= -EINVAL,
-	.rdy_pin	= AT91_PIN_PC13,
-	.enable_pin	= AT91_PIN_PC14,
-	.ecc_mode	= NAND_ECC_SOFT,
-	.on_flash_bbt	= 1,
-	.parts		= ek_nand_partition,
-	.num_parts	= ARRAY_SIZE(ek_nand_partition),
-};
-
-static struct sam9_smc_config __initdata ek_nand_smc_config = {
-	.ncs_read_setup		= 0,
-	.nrd_setup		= 1,
-	.ncs_write_setup	= 0,
-	.nwe_setup		= 1,
-
-	.ncs_read_pulse		= 3,
-	.nrd_pulse		= 3,
-	.ncs_write_pulse	= 3,
-	.nwe_pulse		= 3,
-
-	.read_cycle		= 5,
-	.write_cycle		= 5,
-
-	.mode			= AT91_SMC_READMODE | AT91_SMC_WRITEMODE | AT91_SMC_EXNWMODE_DISABLE | AT91_SMC_DBW_8,
-	.tdf_cycles		= 2,
-};
-
-static void __init ek_add_device_nand(void)
-{
-	/* configure chip-select 3 (NAND) */
-	sam9_smc_configure(0, 3, &ek_nand_smc_config);
-
-	at91_add_device_nand(&ek_nand_data);
-}
-
-/*
- * MCI (SD/MMC)
- */
-static struct mci_platform_data __initdata ek_mci0_data = {
-	.slot[0] = {
-		.bus_width	= 4,
-		.detect_pin	= -EINVAL,
-		.wp_pin		= -EINVAL,
-	},
-};
-
-/*
- * GPIO Buttons
- */
-#if defined(CONFIG_KEYBOARD_GPIO) || defined(CONFIG_KEYBOARD_GPIO_MODULE)
-static struct gpio_keys_button ek_buttons[] = {
-	{	/* USER PUSH BUTTON */
-		.code		= KEY_ENTER,
-		.gpio		= AT91_PIN_PB10,
-		.active_low	= 1,
-		.desc		= "user_pb",
-		.wakeup		= 1,
-	}
-};
-
-static struct gpio_keys_platform_data ek_button_data = {
-	.buttons	= ek_buttons,
-	.nbuttons	= ARRAY_SIZE(ek_buttons),
-};
-
-static struct platform_device ek_button_device = {
-	.name		= "gpio-keys",
-	.id		= -1,
-	.num_resources	= 0,
-	.dev		= {
-		.platform_data	= &ek_button_data,
-	}
-};
-
-static void __init ek_add_device_buttons(void)
-{
-	at91_set_GPIO_periph(AT91_PIN_PB10, 1);	/* user push button, pull up enabled */
-	at91_set_deglitch(AT91_PIN_PB10, 1);
-
-	platform_device_register(&ek_button_device);
-}
-#else
-static void __init ek_add_device_buttons(void) {}
-#endif
-
-/*
- * LEDs
- */
-static struct gpio_led ek_leds[] = {
-	{	/* user_led (green) */
-		.name			= "user_led",
-		.gpio			= AT91_PIN_PB21,
-		.active_low		= 0,
-		.default_trigger	= "heartbeat",
-	}
-};
-
-static void __init ek_board_init(void)
-{
-	/* Serial */
-	/* DBGU on ttyS0. (Rx & Tx only) */
-	at91_register_uart(0, 0, 0);
-
-	/* USART0 on ttyS1. (Rx, Tx, CTS, RTS, DTR, DSR, DCD, RI) */
-	at91_register_uart(AT91SAM9260_ID_US0, 1, ATMEL_UART_CTS | ATMEL_UART_RTS
-			   | ATMEL_UART_DTR | ATMEL_UART_DSR | ATMEL_UART_DCD
-			   | ATMEL_UART_RI);
-
-	/* USART1 on ttyS2. (Rx, Tx, CTS, RTS) */
-	at91_register_uart(AT91SAM9260_ID_US1, 2, ATMEL_UART_CTS | ATMEL_UART_RTS);
-
-	/* USART2 on ttyS3. (Rx, Tx, CTS, RTS) */
-	at91_register_uart(AT91SAM9260_ID_US2, 3, ATMEL_UART_CTS | ATMEL_UART_RTS);
-	at91_add_device_serial();
-	/* USB Host */
-	at91_add_device_usbh(&ek_usbh_data);
-	/* USB Device */
-	at91_add_device_udc(&ek_udc_data);
-	/* SPI */
-	at91_add_device_spi(ek_spi_devices, ARRAY_SIZE(ek_spi_devices));
-	/* NAND */
-	ek_add_device_nand();
-	/* I2C */
-	at91_add_device_i2c(NULL, 0);
-	/* Ethernet */
-	at91_add_device_eth(&ek_macb_data);
-	/* MMC */
-	at91_add_device_mci(0, &ek_mci0_data);
-	/* Push Buttons */
-	ek_add_device_buttons();
-	/* LEDs */
-	at91_gpio_leds(ek_leds, ARRAY_SIZE(ek_leds));
-	/* shutdown controller, wakeup button (5 msec low) */
-	at91_shdwc_write(AT91_SHDW_MR, AT91_SHDW_CPTWK0_(10) | AT91_SHDW_WKMODE0_LOW
-				| AT91_SHDW_RTTWKEN);
-}
-
-MACHINE_START(QIL_A9260, "CALAO QIL_A9260")
-	/* Maintainer: calao-systems */
-	.init_time	= at91sam926x_pit_init,
-	.map_io		= at91_map_io,
-	.handle_irq	= at91_aic_handle_irq,
-	.init_early	= ek_init_early,
-	.init_irq	= at91_init_irq_default,
-	.init_machine	= ek_board_init,
-MACHINE_END
-- 
1.8.4.rc3
