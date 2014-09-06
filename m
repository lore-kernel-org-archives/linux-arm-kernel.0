From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat,  6 Sep 2014 08:34:40 +0400
Subject: [PATCH 1/4] ARM: i.MX: Remove i.MX1 Armadeus APF9328 board support
Message-ID: <1409978083-20047-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mach-apf9328.c can be replaced with devicetree equivalent: imx1-apf9328.dts,
so remove the board file.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-imx/Kconfig        |   8 ---
 arch/arm/mach-imx/Makefile       |   1 -
 arch/arm/mach-imx/mach-apf9328.c | 148 ---------------------------------------
 3 files changed, 157 deletions(-)
 delete mode 100644 arch/arm/mach-imx/mach-apf9328.c

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 3da9f71..57f9382 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -117,14 +117,6 @@ config MACH_SCB9328
 	help
 	  Say Y here if you are using a Synertronixx scb9328 board
 
-config MACH_APF9328
-	bool "APF9328"
-	select IMX_HAVE_PLATFORM_IMX_I2C
-	select IMX_HAVE_PLATFORM_IMX_UART
-	select SOC_IMX1
-	help
-	  Say Yes here if you are using the Armadeus APF9328 development board
-
 config MACH_IMX1_DT
 	bool "Support i.MX1 platforms from device tree"
 	select SOC_IMX1
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 88e5289..17aa956 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -42,7 +42,6 @@ endif
 
 # i.MX1 based machines
 obj-$(CONFIG_MACH_SCB9328) += mach-scb9328.o
-obj-$(CONFIG_MACH_APF9328) += mach-apf9328.o
 obj-$(CONFIG_MACH_IMX1_DT) += imx1-dt.o
 
 # i.MX21 based machines
diff --git a/arch/arm/mach-imx/mach-apf9328.c b/arch/arm/mach-imx/mach-apf9328.c
deleted file mode 100644
index ebbb5ab..0000000
--- a/arch/arm/mach-imx/mach-apf9328.c
+++ /dev/null
@@ -1,148 +0,0 @@
-/*
- * linux/arch/arm/mach-imx/mach-apf9328.c
- *
- * Copyright (c) 2005-2011 ARMadeus systems <support@armadeus.com>
- *
- * This work is based on mach-scb9328.c which is:
- * Copyright (c) 2004 Sascha Hauer <saschahauer@web.de>
- * Copyright (c) 2006-2008 Juergen Beisert <jbeisert@netscape.net>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- */
-
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/platform_device.h>
-#include <linux/mtd/physmap.h>
-#include <linux/dm9000.h>
-#include <linux/gpio.h>
-#include <linux/i2c.h>
-
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <asm/mach/time.h>
-
-#include "common.h"
-#include "devices-imx1.h"
-#include "hardware.h"
-#include "iomux-mx1.h"
-
-static const int apf9328_pins[] __initconst = {
-	/* UART1 */
-	PC9_PF_UART1_CTS,
-	PC10_PF_UART1_RTS,
-	PC11_PF_UART1_TXD,
-	PC12_PF_UART1_RXD,
-	/* UART2 */
-	PB28_PF_UART2_CTS,
-	PB29_PF_UART2_RTS,
-	PB30_PF_UART2_TXD,
-	PB31_PF_UART2_RXD,
-	/* I2C */
-	PA15_PF_I2C_SDA,
-	PA16_PF_I2C_SCL,
-};
-
-/*
- * The APF9328 can have up to 32MB NOR Flash
- */
-static struct resource flash_resource = {
-	.start	= MX1_CS0_PHYS,
-	.end	= MX1_CS0_PHYS + SZ_32M - 1,
-	.flags	= IORESOURCE_MEM,
-};
-
-static struct physmap_flash_data apf9328_flash_data = {
-	.width  = 2,
-};
-
-static struct platform_device apf9328_flash_device = {
-	.name		= "physmap-flash",
-	.id		= 0,
-	.dev = {
-		.platform_data = &apf9328_flash_data,
-	},
-	.resource = &flash_resource,
-	.num_resources = 1,
-};
-
-/*
- * APF9328 has a DM9000 Ethernet controller
- */
-static struct dm9000_plat_data dm9000_setup = {
-	.flags          = DM9000_PLATF_16BITONLY
-};
-
-static struct resource dm9000_resources[] = {
-	{
-		.start  = MX1_CS4_PHYS + 0x00C00000,
-		.end    = MX1_CS4_PHYS + 0x00C00001,
-		.flags  = IORESOURCE_MEM,
-	}, {
-		.start  = MX1_CS4_PHYS + 0x00C00002,
-		.end    = MX1_CS4_PHYS + 0x00C00003,
-		.flags  = IORESOURCE_MEM,
-	}, {
-		/* irq number is run-time assigned */
-		.flags  = IORESOURCE_IRQ | IORESOURCE_IRQ_LOWLEVEL,
-	},
-};
-
-static struct platform_device dm9000x_device = {
-	.name		= "dm9000",
-	.id		= 0,
-	.num_resources	= ARRAY_SIZE(dm9000_resources),
-	.resource	= dm9000_resources,
-	.dev		= {
-		.platform_data = &dm9000_setup,
-	}
-};
-
-static const struct imxuart_platform_data uart1_pdata __initconst = {
-	.flags = IMXUART_HAVE_RTSCTS,
-};
-
-static const struct imxi2c_platform_data apf9328_i2c_data __initconst = {
-	.bitrate = 100000,
-};
-
-static struct platform_device *devices[] __initdata = {
-	&apf9328_flash_device,
-	&dm9000x_device,
-};
-
-static void __init apf9328_init(void)
-{
-	imx1_soc_init();
-
-	mxc_gpio_setup_multiple_pins(apf9328_pins,
-			ARRAY_SIZE(apf9328_pins),
-			"APF9328");
-
-	imx1_add_imx_uart0(NULL);
-	imx1_add_imx_uart1(&uart1_pdata);
-
-	imx1_add_imx_i2c(&apf9328_i2c_data);
-
-	dm9000_resources[2].start = gpio_to_irq(IMX_GPIO_NR(2, 14));
-	dm9000_resources[2].end = gpio_to_irq(IMX_GPIO_NR(2, 14));
-	platform_add_devices(devices, ARRAY_SIZE(devices));
-}
-
-static void __init apf9328_timer_init(void)
-{
-	mx1_clocks_init(32768);
-}
-
-MACHINE_START(APF9328, "Armadeus APF9328")
-	/* Maintainer: Gwenhael Goavec-Merou, ARMadeus Systems */
-	.map_io       = mx1_map_io,
-	.init_early   = imx1_init_early,
-	.init_irq     = mx1_init_irq,
-	.init_time	= apf9328_timer_init,
-	.init_machine = apf9328_init,
-	.restart	= mxc_restart,
-MACHINE_END
-- 
1.8.5.5
