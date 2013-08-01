From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu,  1 Aug 2013 10:45:34 +0200
Subject: [PATCH 5/9] ARM: kirkwood: remove LaCie boards that are supported
 through DT
In-Reply-To: <1375346738-21596-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1375346738-21596-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1375346738-21596-6-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "LaCie Internet Space v2 NAS Board", "LaCie Network Space Max v2
NAS Board" and "LaCie Network Space v2 NAS Board" boards are all
supported through the Device Tree.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-kirkwood/Kconfig             |  18 --
 arch/arm/mach-kirkwood/Makefile            |   3 -
 arch/arm/mach-kirkwood/netspace_v2-setup.c | 293 -----------------------------
 3 files changed, 314 deletions(-)
 delete mode 100644 arch/arm/mach-kirkwood/netspace_v2-setup.c

diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index 4f881b8..530d273 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -2,12 +2,6 @@ if ARCH_KIRKWOOD
 
 menu "Marvell Kirkwood Implementations"
 
-config MACH_INETSPACE_V2
-	bool "LaCie Internet Space v2 NAS Board"
-	help
-	  Say 'Y' here if you want your kernel to support the
-	  LaCie Internet Space v2 NAS.
-
 config MACH_MV88F6281GTW_GE
 	bool "Marvell 88F6281 GTW GE Board"
 	help
@@ -26,18 +20,6 @@ config MACH_NET5BIG_V2
 	  Say 'Y' here if you want your kernel to support the
 	  LaCie 5Big Network v2 NAS.
 
-config MACH_NETSPACE_MAX_V2
-	bool "LaCie Network Space Max v2 NAS Board"
-	help
-	  Say 'Y' here if you want your kernel to support the
-	  LaCie Network Space Max v2 NAS.
-
-config MACH_NETSPACE_V2
-	bool "LaCie Network Space v2 NAS Board"
-	help
-	  Say 'Y' here if you want your kernel to support the
-	  LaCie Network Space v2 NAS.
-
 config MACH_OPENRD
         bool
 
diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
index 9b25ec3..6c52299 100644
--- a/arch/arm/mach-kirkwood/Makefile
+++ b/arch/arm/mach-kirkwood/Makefile
@@ -1,11 +1,8 @@
 obj-y				+= common.o irq.o pcie.o mpp.o
 
-obj-$(CONFIG_MACH_INETSPACE_V2)		+= netspace_v2-setup.o lacie_v2-common.o
 obj-$(CONFIG_MACH_MV88F6281GTW_GE)	+= mv88f6281gtw_ge-setup.o
 obj-$(CONFIG_MACH_NET2BIG_V2)		+= netxbig_v2-setup.o lacie_v2-common.o
 obj-$(CONFIG_MACH_NET5BIG_V2)		+= netxbig_v2-setup.o lacie_v2-common.o
-obj-$(CONFIG_MACH_NETSPACE_MAX_V2)	+= netspace_v2-setup.o lacie_v2-common.o
-obj-$(CONFIG_MACH_NETSPACE_V2)		+= netspace_v2-setup.o lacie_v2-common.o
 obj-$(CONFIG_MACH_OPENRD)		+= openrd-setup.o
 obj-$(CONFIG_MACH_RD88F6192_NAS)	+= rd88f6192-nas-setup.o
 obj-$(CONFIG_MACH_RD88F6281)		+= rd88f6281-setup.o
diff --git a/arch/arm/mach-kirkwood/netspace_v2-setup.c b/arch/arm/mach-kirkwood/netspace_v2-setup.c
deleted file mode 100644
index 3b70661..0000000
--- a/arch/arm/mach-kirkwood/netspace_v2-setup.c
+++ /dev/null
@@ -1,293 +0,0 @@
-/*
- * arch/arm/mach-kirkwood/netspace_v2-setup.c
- *
- * LaCie Network Space v2 board setup
- *
- * Copyright (C) 2009 Simon Guinot <sguinot@lacie.com>
- * Copyright (C) 2009 Beno??t Canet <benoit.canet@gmail.com>
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
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/ata_platform.h>
-#include <linux/mv643xx_eth.h>
-#include <linux/input.h>
-#include <linux/gpio.h>
-#include <linux/gpio_keys.h>
-#include <linux/leds.h>
-#include <linux/gpio-fan.h>
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <mach/kirkwood.h>
-#include <linux/platform_data/leds-kirkwood-ns2.h>
-#include "common.h"
-#include "mpp.h"
-#include "lacie_v2-common.h"
-
-/*****************************************************************************
- * Ethernet
- ****************************************************************************/
-
-static struct mv643xx_eth_platform_data netspace_v2_ge00_data = {
-	.phy_addr	= MV643XX_ETH_PHY_ADDR(8),
-};
-
-/*****************************************************************************
- * SATA
- ****************************************************************************/
-
-static struct mv_sata_platform_data netspace_v2_sata_data = {
-	.n_ports	= 2,
-};
-
-/*****************************************************************************
- * GPIO keys
- ****************************************************************************/
-
-#define NETSPACE_V2_PUSH_BUTTON		32
-
-static struct gpio_keys_button netspace_v2_buttons[] = {
-	[0] = {
-		.code		= KEY_POWER,
-		.gpio		= NETSPACE_V2_PUSH_BUTTON,
-		.desc		= "Power push button",
-		.active_low	= 0,
-	},
-};
-
-static struct gpio_keys_platform_data netspace_v2_button_data = {
-	.buttons	= netspace_v2_buttons,
-	.nbuttons	= ARRAY_SIZE(netspace_v2_buttons),
-};
-
-static struct platform_device netspace_v2_gpio_buttons = {
-	.name		= "gpio-keys",
-	.id		= -1,
-	.dev		= {
-		.platform_data	= &netspace_v2_button_data,
-	},
-};
-
-/*****************************************************************************
- * GPIO LEDs
- ****************************************************************************/
-
-#define NETSPACE_V2_GPIO_RED_LED	12
-
-static struct gpio_led netspace_v2_gpio_led_pins[] = {
-	{
-		.name	= "ns_v2:red:fail",
-		.gpio	= NETSPACE_V2_GPIO_RED_LED,
-	},
-};
-
-static struct gpio_led_platform_data netspace_v2_gpio_leds_data = {
-	.num_leds	= ARRAY_SIZE(netspace_v2_gpio_led_pins),
-	.leds		= netspace_v2_gpio_led_pins,
-};
-
-static struct platform_device netspace_v2_gpio_leds = {
-	.name		= "leds-gpio",
-	.id		= -1,
-	.dev		= {
-		.platform_data	= &netspace_v2_gpio_leds_data,
-	},
-};
-
-/*****************************************************************************
- * Dual-GPIO CPLD LEDs
- ****************************************************************************/
-
-#define NETSPACE_V2_GPIO_BLUE_LED_SLOW	29
-#define NETSPACE_V2_GPIO_BLUE_LED_CMD	30
-
-static struct ns2_led netspace_v2_led_pins[] = {
-	{
-		.name	= "ns_v2:blue:sata",
-		.cmd	= NETSPACE_V2_GPIO_BLUE_LED_CMD,
-		.slow	= NETSPACE_V2_GPIO_BLUE_LED_SLOW,
-	},
-};
-
-static struct ns2_led_platform_data netspace_v2_leds_data = {
-	.num_leds	= ARRAY_SIZE(netspace_v2_led_pins),
-	.leds		= netspace_v2_led_pins,
-};
-
-static struct platform_device netspace_v2_leds = {
-	.name		= "leds-ns2",
-	.id		= -1,
-	.dev		= {
-		.platform_data	= &netspace_v2_leds_data,
-	},
-};
-
-/*****************************************************************************
- * GPIO fan
- ****************************************************************************/
-
-/* Designed for fan 40x40x16: ADDA AD0412LB-D50 6000rpm at 12v */
-static struct gpio_fan_speed netspace_max_v2_fan_speed[] = {
-	{    0,  0 },
-	{ 1500,	15 },
-	{ 1700,	14 },
-	{ 1800,	13 },
-	{ 2100,	12 },
-	{ 3100,	11 },
-	{ 3300,	10 },
-	{ 4300,	 9 },
-	{ 5500,	 8 },
-};
-
-static unsigned netspace_max_v2_fan_ctrl[] = { 22, 7, 33, 23 };
-
-static struct gpio_fan_alarm netspace_max_v2_fan_alarm = {
-	.gpio		= 25,
-	.active_low	= 1,
-};
-
-static struct gpio_fan_platform_data netspace_max_v2_fan_data = {
-	.num_ctrl	= ARRAY_SIZE(netspace_max_v2_fan_ctrl),
-	.ctrl		= netspace_max_v2_fan_ctrl,
-	.alarm		= &netspace_max_v2_fan_alarm,
-	.num_speed	= ARRAY_SIZE(netspace_max_v2_fan_speed),
-	.speed		= netspace_max_v2_fan_speed,
-};
-
-static struct platform_device netspace_max_v2_gpio_fan = {
-	.name	= "gpio-fan",
-	.id	= -1,
-	.dev	= {
-		.platform_data	= &netspace_max_v2_fan_data,
-	},
-};
-
-/*****************************************************************************
- * General Setup
- ****************************************************************************/
-
-static unsigned int netspace_v2_mpp_config[] __initdata = {
-	MPP0_SPI_SCn,
-	MPP1_SPI_MOSI,
-	MPP2_SPI_SCK,
-	MPP3_SPI_MISO,
-	MPP4_NF_IO6,
-	MPP5_NF_IO7,
-	MPP6_SYSRST_OUTn,
-	MPP7_GPO,		/* Fan speed (bit 1) */
-	MPP8_TW0_SDA,
-	MPP9_TW0_SCK,
-	MPP10_UART0_TXD,
-	MPP11_UART0_RXD,
-	MPP12_GPO,		/* Red led */
-	MPP14_GPIO,		/* USB fuse */
-	MPP16_GPIO,		/* SATA 0 power */
-	MPP17_GPIO,		/* SATA 1 power */
-	MPP18_NF_IO0,
-	MPP19_NF_IO1,
-	MPP20_SATA1_ACTn,
-	MPP21_SATA0_ACTn,
-	MPP22_GPIO,		/* Fan speed (bit 0) */
-	MPP23_GPIO,		/* Fan power */
-	MPP24_GPIO,		/* USB mode select */
-	MPP25_GPIO,		/* Fan rotation fail */
-	MPP26_GPIO,		/* USB device vbus */
-	MPP28_GPIO,		/* USB enable host vbus */
-	MPP29_GPIO,		/* Blue led (slow register) */
-	MPP30_GPIO,		/* Blue led (command register) */
-	MPP31_GPIO,		/* Board power off */
-	MPP32_GPIO,		/* Power button (0 = Released, 1 = Pushed) */
-	MPP33_GPO,		/* Fan speed (bit 2) */
-	0
-};
-
-#define NETSPACE_V2_GPIO_POWER_OFF	31
-
-static void netspace_v2_power_off(void)
-{
-	gpio_set_value(NETSPACE_V2_GPIO_POWER_OFF, 1);
-}
-
-static void __init netspace_v2_init(void)
-{
-	/*
-	 * Basic setup. Needs to be called early.
-	 */
-	kirkwood_init();
-	kirkwood_mpp_conf(netspace_v2_mpp_config);
-
-	if (machine_is_netspace_max_v2())
-		lacie_v2_hdd_power_init(2);
-	else
-		lacie_v2_hdd_power_init(1);
-
-	kirkwood_ehci_init();
-	kirkwood_ge00_init(&netspace_v2_ge00_data);
-	kirkwood_sata_init(&netspace_v2_sata_data);
-	kirkwood_uart0_init();
-	lacie_v2_register_flash();
-	lacie_v2_register_i2c_devices();
-
-	platform_device_register(&netspace_v2_leds);
-	platform_device_register(&netspace_v2_gpio_leds);
-	platform_device_register(&netspace_v2_gpio_buttons);
-	if (machine_is_netspace_max_v2())
-		platform_device_register(&netspace_max_v2_gpio_fan);
-
-	if (gpio_request(NETSPACE_V2_GPIO_POWER_OFF, "power-off") == 0 &&
-	    gpio_direction_output(NETSPACE_V2_GPIO_POWER_OFF, 0) == 0)
-		pm_power_off = netspace_v2_power_off;
-	else
-		pr_err("netspace_v2: failed to configure power-off GPIO\n");
-}
-
-#ifdef CONFIG_MACH_NETSPACE_V2
-MACHINE_START(NETSPACE_V2, "LaCie Network Space v2")
-	.atag_offset	= 0x100,
-	.init_machine	= netspace_v2_init,
-	.map_io		= kirkwood_map_io,
-	.init_early	= kirkwood_init_early,
-	.init_irq	= kirkwood_init_irq,
-	.init_time	= kirkwood_timer_init,
-	.restart	= kirkwood_restart,
-MACHINE_END
-#endif
-
-#ifdef CONFIG_MACH_INETSPACE_V2
-MACHINE_START(INETSPACE_V2, "LaCie Internet Space v2")
-	.atag_offset	= 0x100,
-	.init_machine	= netspace_v2_init,
-	.map_io		= kirkwood_map_io,
-	.init_early	= kirkwood_init_early,
-	.init_irq	= kirkwood_init_irq,
-	.init_time	= kirkwood_timer_init,
-	.restart	= kirkwood_restart,
-MACHINE_END
-#endif
-
-#ifdef CONFIG_MACH_NETSPACE_MAX_V2
-MACHINE_START(NETSPACE_MAX_V2, "LaCie Network Space Max v2")
-	.atag_offset	= 0x100,
-	.init_machine	= netspace_v2_init,
-	.map_io		= kirkwood_map_io,
-	.init_early	= kirkwood_init_early,
-	.init_irq	= kirkwood_init_irq,
-	.init_time	= kirkwood_timer_init,
-	.restart	= kirkwood_restart,
-MACHINE_END
-#endif
-- 
1.8.1.2
