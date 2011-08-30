From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 30 Aug 2011 18:25:52 +0200
Subject: [PATCH 1/2 v4] at91: merge board usb-a9260 and usb-a9263 together
In-Reply-To: <1314281314-28912-1-git-send-email-nicolas.ferre@atmel.com>
References: <1314281314-28912-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <1314721553-3283-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nico Erfurth <ne@erfurth.eu>

Merge boards together as they are barely the same.

Signed-off-by: Nico Erfurth <ne@erfurth.eu>
Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
[nicolas.ferre at atmel.com: updated to new machine_desc structure]
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Gregory Hermant <gregory.hermant@calao-systems.com>
---
v4:
fix for 9260
	.map_io		= at91_map_io

Best Regards,
J.
 arch/arm/mach-at91/Makefile                        |    4 +-
 arch/arm/mach-at91/board-usb-a9260.c               |  230 --------------------
 .../{board-usb-a9263.c => board-usb-a926x.c}       |   56 +++++-
 3 files changed, 52 insertions(+), 238 deletions(-)
 delete mode 100644 arch/arm/mach-at91/board-usb-a9260.c
 rename arch/arm/mach-at91/{board-usb-a9263.c => board-usb-a926x.c} (84%)

diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index bf57e8b..adcb9a0 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -41,7 +41,7 @@ obj-$(CONFIG_MACH_ECO920)	+= board-eco920.o
 obj-$(CONFIG_MACH_AT91SAM9260EK) += board-sam9260ek.o
 obj-$(CONFIG_MACH_CAM60)	+= board-cam60.o
 obj-$(CONFIG_MACH_SAM9_L9260)	+= board-sam9-l9260.o
-obj-$(CONFIG_MACH_USB_A9260)	+= board-usb-a9260.o
+obj-$(CONFIG_MACH_USB_A9260)	+= board-usb-a926x.o
 obj-$(CONFIG_MACH_QIL_A9260)	+= board-qil-a9260.o
 obj-$(CONFIG_MACH_AFEB9260)	+= board-afeb-9260v1.o
 obj-$(CONFIG_MACH_CPU9260)	+= board-cpu9krea.o
@@ -53,7 +53,7 @@ obj-$(CONFIG_MACH_AT91SAM9G10EK) += board-sam9261ek.o
 
 # AT91SAM9263 board-specific support
 obj-$(CONFIG_MACH_AT91SAM9263EK) += board-sam9263ek.o
-obj-$(CONFIG_MACH_USB_A9263)	+= board-usb-a9263.o
+obj-$(CONFIG_MACH_USB_A9263)	+= board-usb-a926x.o
 obj-$(CONFIG_MACH_NEOCORE926)	+= board-neocore926.o
 
 # AT91SAM9RL board-specific support
diff --git a/arch/arm/mach-at91/board-usb-a9260.c b/arch/arm/mach-at91/board-usb-a9260.c
deleted file mode 100644
index 8c4c1a0..0000000
--- a/arch/arm/mach-at91/board-usb-a9260.c
+++ /dev/null
@@ -1,230 +0,0 @@
-/*
- * linux/arch/arm/mach-at91/board-usb-a9260.c
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
-#include <mach/board.h>
-#include <mach/gpio.h>
-#include <mach/at91sam9_smc.h>
-#include <mach/at91_shdwc.h>
-
-#include "sam9_smc.h"
-#include "generic.h"
-
-
-static void __init ek_init_early(void)
-{
-	/* Initialize processor: 12.000 MHz crystal */
-	at91_initialize(12000000);
-
-	/* DBGU on ttyS0. (Rx & Tx only) */
-	at91_register_uart(0, 0, 0);
-
-	/* set serial console to ttyS0 (ie, DBGU) */
-	at91_set_serial_console(0);
-}
-
-/*
- * USB Host port
- */
-static struct at91_usbh_data __initdata ek_usbh_data = {
-	.ports		= 2,
-};
-
-/*
- * USB Device port
- */
-static struct at91_udc_data __initdata ek_udc_data = {
-	.vbus_pin	= AT91_PIN_PC5,
-	.pullup_pin	= 0,		/* pull-up driven by UDC */
-};
-
-/*
- * MACB Ethernet device
- */
-static struct at91_eth_data __initdata ek_macb_data = {
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
-	}
-};
-
-static struct mtd_partition * __init nand_partitions(int size, int *num_partitions)
-{
-	*num_partitions = ARRAY_SIZE(ek_nand_partition);
-	return ek_nand_partition;
-}
-
-static struct atmel_nand_data __initdata ek_nand_data = {
-	.ale		= 21,
-	.cle		= 22,
-//	.det_pin	= ... not connected
-	.rdy_pin	= AT91_PIN_PC13,
-	.enable_pin	= AT91_PIN_PC14,
-	.partition_info	= nand_partitions,
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
-	sam9_smc_configure(3, &ek_nand_smc_config);
-
-	at91_add_device_nand(&ek_nand_data);
-}
-
-/*
- * GPIO Buttons
- */
-
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
-	at91_add_device_serial();
-	/* USB Host */
-	at91_add_device_usbh(&ek_usbh_data);
-	/* USB Device */
-	at91_add_device_udc(&ek_udc_data);
-	/* NAND */
-	ek_add_device_nand();
-	/* I2C */
-	at91_add_device_i2c(NULL, 0);
-	/* Ethernet */
-	at91_add_device_eth(&ek_macb_data);
-	/* Push Buttons */
-	ek_add_device_buttons();
-	/* LEDs */
-	at91_gpio_leds(ek_leds, ARRAY_SIZE(ek_leds));
-	/* shutdown controller, wakeup button (5 msec low) */
-	at91_sys_write(AT91_SHDW_MR, AT91_SHDW_CPTWK0_(10) | AT91_SHDW_WKMODE0_LOW
-				| AT91_SHDW_RTTWKEN);
-}
-
-MACHINE_START(USB_A9260, "CALAO USB_A9260")
-	/* Maintainer: calao-systems */
-	.timer		= &at91sam926x_timer,
-	.map_io		= at91_map_io,
-	.init_early	= ek_init_early,
-	.init_irq	= at91_init_irq_default,
-	.init_machine	= ek_board_init,
-MACHINE_END
diff --git a/arch/arm/mach-at91/board-usb-a9263.c b/arch/arm/mach-at91/board-usb-a926x.c
similarity index 84%
rename from arch/arm/mach-at91/board-usb-a9263.c
rename to arch/arm/mach-at91/board-usb-a926x.c
index 25e7937..b9b9847 100644
--- a/arch/arm/mach-at91/board-usb-a9263.c
+++ b/arch/arm/mach-at91/board-usb-a926x.c
@@ -1,5 +1,5 @@
 /*
- * linux/arch/arm/mach-at91/board-usb-a9263.c
+ * linux/arch/arm/mach-at91/board-usb-a926x.c
  *
  *  Copyright (C) 2005 SAN People
  *  Copyright (C) 2007 Atmel Corporation.
@@ -74,6 +74,14 @@ static struct at91_udc_data __initdata ek_udc_data = {
 	.pullup_pin	= 0,		/* pull-up driven by UDC */
 };
 
+void ek_add_device_udc(void)
+{
+	if (machine_is_usb_a9260())
+		ek_udc_data.vbus_pin = AT91_PIN_PC5;
+
+	at91_add_device_udc(&ek_udc_data);
+}
+
 /*
  * SPI devices.
  */
@@ -88,6 +96,12 @@ static struct spi_board_info ek_spi_devices[] = {
 #endif
 };
 
+void ek_add_device_spi(void)
+{
+	if (machine_is_usb_a9263())
+		at91_add_device_spi(ek_spi_devices, ARRAY_SIZE(ek_spi_devices));
+}
+
 /*
  * MACB Ethernet device
  */
@@ -96,12 +110,20 @@ static struct at91_eth_data __initdata ek_macb_data = {
 	.is_rmii	= 1,
 };
 
+void ek_add_device_eth(void)
+{
+	if (machine_is_usb_a9260())
+		ek_macb_data.phy_irq_pin = AT91_PIN_PA31;
+
+	at91_add_device_eth(&ek_macb_data);
+}
+
 /*
  * NAND flash
  */
 static struct mtd_partition __initdata ek_nand_partition[] = {
 	{
-		.name	= "Linux Kernel",
+		.name	= "Uboot & Kernel",
 		.offset	= 0,
 		.size	= SZ_16M,
 	},
@@ -152,6 +174,11 @@ static struct sam9_smc_config __initdata ek_nand_smc_config = {
 
 static void __init ek_add_device_nand(void)
 {
+	if (machine_is_usb_a9260()) {
+		ek_nand_data.rdy_pin	= AT91_PIN_PC13;
+		ek_nand_data.enable_pin	= AT91_PIN_PC14;
+	}
+
 	/* configure chip-select 3 (NAND) */
 	sam9_smc_configure(3, &ek_nand_smc_config);
 
@@ -210,6 +237,14 @@ static struct gpio_led ek_leds[] = {
 	}
 };
 
+void ek_add_device_leds(void)
+{
+	if (machine_is_usb_a9260())
+		ek_leds[0].active_low = 0;
+
+	at91_gpio_leds(ek_leds, ARRAY_SIZE(ek_leds));
+}
+
 
 static void __init ek_board_init(void)
 {
@@ -218,11 +253,11 @@ static void __init ek_board_init(void)
 	/* USB Host */
 	at91_add_device_usbh(&ek_usbh_data);
 	/* USB Device */
-	at91_add_device_udc(&ek_udc_data);
+	ek_add_device_udc();
 	/* SPI */
-	at91_add_device_spi(ek_spi_devices, ARRAY_SIZE(ek_spi_devices));
+	ek_add_device_spi();
 	/* Ethernet */
-	at91_add_device_eth(&ek_macb_data);
+	ek_add_device_eth();
 	/* NAND */
 	ek_add_device_nand();
 	/* I2C */
@@ -230,7 +265,7 @@ static void __init ek_board_init(void)
 	/* Push Buttons */
 	ek_add_device_buttons();
 	/* LEDs */
-	at91_gpio_leds(ek_leds, ARRAY_SIZE(ek_leds));
+	ek_add_device_leds();
 	/* shutdown controller, wakeup button (5 msec low) */
 	at91_sys_write(AT91_SHDW_MR, AT91_SHDW_CPTWK0_(10) | AT91_SHDW_WKMODE0_LOW
 				| AT91_SHDW_RTTWKEN);
@@ -244,3 +279,12 @@ MACHINE_START(USB_A9263, "CALAO USB_A9263")
 	.init_irq	= at91_init_irq_default,
 	.init_machine	= ek_board_init,
 MACHINE_END
+
+MACHINE_START(USB_A9260, "CALAO USB_A9260")
+	/* Maintainer: calao-systems */
+	.timer		= &at91sam926x_timer,
+	.map_io		= at91_map_io,
+	.init_early	= ek_init_early,
+	.init_irq	= at91_init_irq_default,
+	.init_machine	= ek_board_init,
+MACHINE_END
-- 
1.7.5.4
