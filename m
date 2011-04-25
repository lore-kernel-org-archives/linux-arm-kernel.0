From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 25 Apr 2011 20:31:14 +0200
Subject: [PATCH 04/14 v2] at91: merge board usb-a9260 and usb-a9263 together
In-Reply-To: <20110425180847.GA12904@game.jcrosoft.org>
References: <20110425180847.GA12904@game.jcrosoft.org>
Message-ID: <1303756284-26529-4-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nico Erfurth <ne@erfurth.eu>

as the are nearly the same

Signed-off-by: Nico Erfurth <ne@erfurth.eu>
Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Gr?gory Hermant <gregory.hermant@calao-systems.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
v2:
	update against new common init
	we must use it as we can detect the cpu type only after mapping
	the system controler

Best Regards,
J.
 arch/arm/mach-at91/Makefile                        |    4 +-
 arch/arm/mach-at91/board-usb-a9260.c               |  236 --------------------
 .../{board-usb-a9263.c => board-usb-a926x.c}       |   56 ++++-
 arch/arm/mach-at91/soc.c                           |   16 +-
 arch/arm/mach-at91/soc.h                           |    7 +-
 5 files changed, 65 insertions(+), 254 deletions(-)
 delete mode 100644 arch/arm/mach-at91/board-usb-a9260.c
 rename arch/arm/mach-at91/{board-usb-a9263.c => board-usb-a926x.c} (85%)

diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index eeb5287..9cac68d 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -42,7 +42,7 @@ obj-$(CONFIG_MACH_ECO920)	+= board-eco920.o
 obj-$(CONFIG_MACH_AT91SAM9260EK) += board-sam9260ek.o
 obj-$(CONFIG_MACH_CAM60)	+= board-cam60.o
 obj-$(CONFIG_MACH_SAM9_L9260)	+= board-sam9-l9260.o
-obj-$(CONFIG_MACH_USB_A9260)	+= board-usb-a9260.o
+obj-$(CONFIG_MACH_USB_A9260)	+= board-usb-a926x.o
 obj-$(CONFIG_MACH_QIL_A9260)	+= board-qil-a9260.o
 obj-$(CONFIG_MACH_AFEB9260)	+= board-afeb-9260v1.o
 obj-$(CONFIG_MACH_CPU9260)	+= board-cpu9krea.o
@@ -54,7 +54,7 @@ obj-$(CONFIG_MACH_AT91SAM9G10EK) += board-sam9261ek.o
 
 # AT91SAM9263 board-specific support
 obj-$(CONFIG_MACH_AT91SAM9263EK) += board-sam9263ek.o
-obj-$(CONFIG_MACH_USB_A9263)	+= board-usb-a9263.o
+obj-$(CONFIG_MACH_USB_A9263)	+= board-usb-a926x.o
 obj-$(CONFIG_MACH_NEOCORE926)	+= board-neocore926.o
 
 # AT91SAM9RL board-specific support
diff --git a/arch/arm/mach-at91/board-usb-a9260.c b/arch/arm/mach-at91/board-usb-a9260.c
deleted file mode 100644
index 7cc63c8..0000000
--- a/arch/arm/mach-at91/board-usb-a9260.c
+++ /dev/null
@@ -1,236 +0,0 @@
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
-static void __init ek_map_io(void)
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
-static void __init ek_init_irq(void)
-{
-	at91_init_interrupts(NULL);
-}
-
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
-	.boot_params	= AT91_SDRAM_BASE + 0x100,
-	.timer		= &at91sam926x_timer,
-	.map_io		= ek_map_io,
-	.init_irq	= ek_init_irq,
-	.init_machine	= ek_board_init,
-MACHINE_END
diff --git a/arch/arm/mach-at91/board-usb-a9263.c b/arch/arm/mach-at91/board-usb-a926x.c
similarity index 85%
rename from arch/arm/mach-at91/board-usb-a9263.c
rename to arch/arm/mach-at91/board-usb-a926x.c
index 1fac2fe..a1cb555 100644
--- a/arch/arm/mach-at91/board-usb-a9263.c
+++ b/arch/arm/mach-at91/board-usb-a926x.c
@@ -1,5 +1,5 @@
 /*
- * linux/arch/arm/mach-at91/board-usb-a9263.c
+ * linux/arch/arm/mach-at91/board-usb-a926x.c
  *
  *  Copyright (C) 2005 SAN People
  *  Copyright (C) 2007 Atmel Corporation.
@@ -80,6 +80,14 @@ static struct at91_udc_data __initdata ek_udc_data = {
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
@@ -94,6 +102,12 @@ static struct spi_board_info ek_spi_devices[] = {
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
@@ -102,12 +116,20 @@ static struct at91_eth_data __initdata ek_macb_data = {
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
@@ -158,6 +180,11 @@ static struct sam9_smc_config __initdata ek_nand_smc_config = {
 
 static void __init ek_add_device_nand(void)
 {
+	if (machine_is_usb_a9260()) {
+		ek_nand_data.rdy_pin	= AT91_PIN_PC13;
+		ek_nand_data.enable_pin	= AT91_PIN_PC14;
+	}
+
 	/* configure chip-select 3 (NAND) */
 	sam9_smc_configure(3, &ek_nand_smc_config);
 
@@ -216,6 +243,14 @@ static struct gpio_led ek_leds[] = {
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
@@ -224,11 +259,11 @@ static void __init ek_board_init(void)
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
@@ -236,7 +271,7 @@ static void __init ek_board_init(void)
 	/* Push Buttons */
 	ek_add_device_buttons();
 	/* LEDs */
-	at91_gpio_leds(ek_leds, ARRAY_SIZE(ek_leds));
+	ek_add_device_leds();
 	/* shutdown controller, wakeup button (5 msec low) */
 	at91_sys_write(AT91_SHDW_MR, AT91_SHDW_CPTWK0_(10) | AT91_SHDW_WKMODE0_LOW
 				| AT91_SHDW_RTTWKEN);
@@ -250,3 +285,12 @@ MACHINE_START(USB_A9263, "CALAO USB_A9263")
 	.init_irq	= ek_init_irq,
 	.init_machine	= ek_board_init,
 MACHINE_END
+
+MACHINE_START(USB_A9260, "CALAO USB_A9260")
+	/* Maintainer: calao-systems */
+	.boot_params	= AT91_SDRAM_BASE + 0x100,
+	.timer		= &at91sam926x_timer,
+	.map_io		= ek_map_io,
+	.init_irq	= ek_init_irq,
+	.init_machine	= ek_board_init,
+MACHINE_END
diff --git a/arch/arm/mach-at91/soc.c b/arch/arm/mach-at91/soc.c
index f0a1661..6cf7f99 100644
--- a/arch/arm/mach-at91/soc.c
+++ b/arch/arm/mach-at91/soc.c
@@ -44,7 +44,11 @@ void __init at91_initialize(unsigned long main_clock)
 	/* Map peripherals */
 	iotable_init(&at91_io_desc, 1);
 
-	if (cpu_is_at91rm9200())
+	if (cpu_is_at572d940hf())
+		current_soc = at572d940hf_soc;
+	else if (cpu_is_at91cap9())
+		current_soc = at91cap9_soc;
+	else if (cpu_is_at91rm9200())
 		current_soc = at91rm9200_soc;
 	else if (cpu_is_at91sam9260())
 		current_soc = at91sam9260_soc;
@@ -52,14 +56,12 @@ void __init at91_initialize(unsigned long main_clock)
 		current_soc = at91sam9261_soc;
 	else if (cpu_is_at91sam9263())
 		current_soc = at91sam9263_soc;
-	else if (cpu_is_at91sam9rl())
-		current_soc = at91sam9rl_soc;
 	else if (cpu_is_at91sam9g45())
 		current_soc = at91sam9g45_soc;
-	else if (cpu_is_at91cap9())
-		current_soc = at91cap9_soc;
-	else if (cpu_is_at572d940hf())
-		current_soc = at572d940hf_soc;
+	else if (cpu_is_at91sam9rl())
+		current_soc = at91sam9rl_soc;
+	else if (cpu_is_at91sam9x5())
+		current_soc = at91sam9x5_soc;
 	else
 		panic("Impossible to detect the CPU type");
 
diff --git a/arch/arm/mach-at91/soc.h b/arch/arm/mach-at91/soc.h
index 9aac491..a097032 100644
--- a/arch/arm/mach-at91/soc.h
+++ b/arch/arm/mach-at91/soc.h
@@ -13,11 +13,12 @@ struct at91_soc {
 	void (*init)(unsigned long main_clock);
 };
 
+extern struct at91_soc at572d940hf_soc;
+extern struct at91_soc at91cap9_soc;
 extern struct at91_soc at91rm9200_soc;
 extern struct at91_soc at91sam9260_soc;
 extern struct at91_soc at91sam9261_soc;
 extern struct at91_soc at91sam9263_soc;
-extern struct at91_soc at91sam9rl_soc;
 extern struct at91_soc at91sam9g45_soc;
-extern struct at91_soc at91cap9_soc;
-extern struct at91_soc at572d940hf_soc;
+extern struct at91_soc at91sam9rl_soc;
+extern struct at91_soc at91sam9x5_soc;
-- 
1.7.4.1
