From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat,  6 Sep 2014 08:34:41 +0400
Subject: [PATCH 2/4] ARM: i.MX: Remove i.MX1 Synertronixx SCB9328 board support
In-Reply-To: <1409978083-20047-1-git-send-email-shc_work@mail.ru>
References: <1409978083-20047-1-git-send-email-shc_work@mail.ru>
Message-ID: <1409978083-20047-2-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Synertronixx SCB9328 board is very similar to Armadeus APF9328,
so it can be easily reimplemented in DT way.
This patch removes support for non-DT support for this board.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-imx/Kconfig        |   7 --
 arch/arm/mach-imx/Makefile       |   1 -
 arch/arm/mach-imx/mach-scb9328.c | 143 ---------------------------------------
 3 files changed, 151 deletions(-)
 delete mode 100644 arch/arm/mach-imx/mach-scb9328.c

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 57f9382..41a5753 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -110,13 +110,6 @@ if ARCH_MULTI_V4T
 
 comment "MX1 platforms:"
 
-config MACH_SCB9328
-	bool "Synertronixx scb9328"
-	select IMX_HAVE_PLATFORM_IMX_UART
-	select SOC_IMX1
-	help
-	  Say Y here if you are using a Synertronixx scb9328 board
-
 config MACH_IMX1_DT
 	bool "Support i.MX1 platforms from device tree"
 	select SOC_IMX1
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 17aa956..6a9c897 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -41,7 +41,6 @@ obj-y += ssi-fiq-ksym.o
 endif
 
 # i.MX1 based machines
-obj-$(CONFIG_MACH_SCB9328) += mach-scb9328.o
 obj-$(CONFIG_MACH_IMX1_DT) += imx1-dt.o
 
 # i.MX21 based machines
diff --git a/arch/arm/mach-imx/mach-scb9328.c b/arch/arm/mach-imx/mach-scb9328.c
deleted file mode 100644
index 1f6bc3f..0000000
--- a/arch/arm/mach-imx/mach-scb9328.c
+++ /dev/null
@@ -1,143 +0,0 @@
-/*
- * linux/arch/arm/mach-mx1/mach-scb9328.c
- *
- * Copyright (c) 2004 Sascha Hauer <saschahauer@web.de>
- * Copyright (c) 2006-2008 Juergen Beisert <jbeisert@netscape.net>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- */
-
-#include <linux/platform_device.h>
-#include <linux/mtd/physmap.h>
-#include <linux/interrupt.h>
-#include <linux/dm9000.h>
-#include <linux/gpio.h>
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
-/*
- * This scb9328 has a 32MiB flash
- */
-static struct resource flash_resource = {
-	.start	= MX1_CS0_PHYS,
-	.end	= MX1_CS0_PHYS + (32 * 1024 * 1024) - 1,
-	.flags	= IORESOURCE_MEM,
-};
-
-static struct physmap_flash_data scb_flash_data = {
-	.width  = 2,
-};
-
-static struct platform_device scb_flash_device = {
-	.name		= "physmap-flash",
-	.id		= 0,
-	.dev = {
-		.platform_data = &scb_flash_data,
-	},
-	.resource = &flash_resource,
-	.num_resources = 1,
-};
-
-/*
- * scb9328 has a DM9000 network controller
- * connected to CS5, with 16 bit data path
- * and interrupt connected to GPIO 3
- */
-
-/*
- * internal datapath is fixed 16 bit
- */
-static struct dm9000_plat_data dm9000_platdata = {
-	.flags	= DM9000_PLATF_16BITONLY,
-};
-
-/*
- * the DM9000 drivers wants two defined address spaces
- * to gain access to address latch registers and the data path.
- */
-static struct resource dm9000x_resources[] = {
-	{
-		.name	= "address area",
-		.start	= MX1_CS5_PHYS,
-		.end	= MX1_CS5_PHYS + 1,
-		.flags	= IORESOURCE_MEM,	/* address access */
-	}, {
-		.name	= "data area",
-		.start	= MX1_CS5_PHYS + 4,
-		.end	= MX1_CS5_PHYS + 5,
-		.flags	= IORESOURCE_MEM,	/* data access */
-	}, {
-		/* irq number is run-time assigned */
-		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_LOWLEVEL,
-	},
-};
-
-static struct platform_device dm9000x_device = {
-	.name		= "dm9000",
-	.id		= 0,
-	.num_resources	= ARRAY_SIZE(dm9000x_resources),
-	.resource	= dm9000x_resources,
-	.dev		= {
-		.platform_data = &dm9000_platdata,
-	}
-};
-
-static const int mxc_uart1_pins[] = {
-	PC9_PF_UART1_CTS,
-	PC10_PF_UART1_RTS,
-	PC11_PF_UART1_TXD,
-	PC12_PF_UART1_RXD,
-};
-
-static const struct imxuart_platform_data uart_pdata __initconst = {
-	.flags = IMXUART_HAVE_RTSCTS,
-};
-
-static struct platform_device *devices[] __initdata = {
-	&scb_flash_device,
-	&dm9000x_device,
-};
-
-/*
- * scb9328_init - Init the CPU card itself
- */
-static void __init scb9328_init(void)
-{
-	imx1_soc_init();
-
-	mxc_gpio_setup_multiple_pins(mxc_uart1_pins,
-			ARRAY_SIZE(mxc_uart1_pins), "UART1");
-
-	imx1_add_imx_uart0(&uart_pdata);
-
-	printk(KERN_INFO"Scb9328: Adding devices\n");
-	dm9000x_resources[2].start = gpio_to_irq(IMX_GPIO_NR(3, 3));
-	dm9000x_resources[2].end = gpio_to_irq(IMX_GPIO_NR(3, 3));
-	platform_add_devices(devices, ARRAY_SIZE(devices));
-}
-
-static void __init scb9328_timer_init(void)
-{
-	mx1_clocks_init(32000);
-}
-
-MACHINE_START(SCB9328, "Synertronixx scb9328")
-	/* Sascha Hauer */
-	.atag_offset = 100,
-	.map_io = mx1_map_io,
-	.init_early = imx1_init_early,
-	.init_irq = mx1_init_irq,
-	.init_time	= scb9328_timer_init,
-	.init_machine = scb9328_init,
-	.restart	= mxc_restart,
-MACHINE_END
-- 
1.8.5.5
