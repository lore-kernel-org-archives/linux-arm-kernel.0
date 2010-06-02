From: richardcochran@gmail.com (Richard Cochran)
Date: Wed, 2 Jun 2010 11:57:33 +0200
Subject: [PATCH 3/3] ixp4xx: support the OMICRON MIC256 board
In-Reply-To: <cover.1275415521.git.richard.cochran@omicron.at>
References: <cover.1275415521.git.richard.cochran@omicron.at>
Message-ID: <0bd52b6a4a62ec98c9f4a87a556ed36e7279cd44.1275415521.git.richard.cochran@omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds board support for the MIC256, which is an IXP425 based
board by OMICRON electronics, GmbH.

Signed-off-by: Richard Cochran <richard.cochran@omicron.at>
---
 arch/arm/mach-ixp4xx/Kconfig                   |    7 +
 arch/arm/mach-ixp4xx/Makefile                  |    1 +
 arch/arm/mach-ixp4xx/include/mach/uncompress.h |    2 +-
 arch/arm/mach-ixp4xx/mic256-setup.c            |  220 ++++++++++++++++++++++++
 4 files changed, 229 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-ixp4xx/mic256-setup.c

diff --git a/arch/arm/mach-ixp4xx/Kconfig b/arch/arm/mach-ixp4xx/Kconfig
index 97cb601..a7312d2 100644
--- a/arch/arm/mach-ixp4xx/Kconfig
+++ b/arch/arm/mach-ixp4xx/Kconfig
@@ -23,6 +23,13 @@ config MACH_MICCPT
 	  board from OMICRON electronics GmbH. For more information on
 	  this platform, see http://www.omicron.at
 
+config MACH_MIC256
+	bool "Omicron MIC256"
+	help
+	  Say 'Y' here if you want your kernel to support the MIC256
+	  board from OMICRON electronics GmbH. For more information on
+	  this platform, see http://www.omicron.at
+
 config MACH_NSLU2
 	bool
 	prompt "Linksys NSLU2"
diff --git a/arch/arm/mach-ixp4xx/Makefile b/arch/arm/mach-ixp4xx/Makefile
index 8a7edc8..14870cd 100644
--- a/arch/arm/mach-ixp4xx/Makefile
+++ b/arch/arm/mach-ixp4xx/Makefile
@@ -23,6 +23,7 @@ obj-y	+= common.o
 obj-$(CONFIG_ARCH_IXDP4XX)	+= ixdp425-setup.o
 obj-$(CONFIG_MACH_DEVIXP)	+= devixp-setup.o
 obj-$(CONFIG_MACH_MICCPT)	+= miccpt-setup.o
+obj-$(CONFIG_MACH_MIC256)	+= mic256-setup.o
 obj-$(CONFIG_MACH_AVILA)	+= avila-setup.o
 obj-$(CONFIG_MACH_IXDPG425)	+= coyote-setup.o
 obj-$(CONFIG_ARCH_ADI_COYOTE)	+= coyote-setup.o
diff --git a/arch/arm/mach-ixp4xx/include/mach/uncompress.h b/arch/arm/mach-ixp4xx/include/mach/uncompress.h
index 1fa3c48..384a361 100644
--- a/arch/arm/mach-ixp4xx/include/mach/uncompress.h
+++ b/arch/arm/mach-ixp4xx/include/mach/uncompress.h
@@ -42,7 +42,7 @@ static __inline__ void __arch_decomp_setup(unsigned long arch_id)
 	 */
 	if (machine_is_adi_coyote() || machine_is_gtwx5715() ||
 	    machine_is_gateway7001() || machine_is_wg302v2() ||
-	    machine_is_devixp() || machine_is_miccpt())
+	    machine_is_devixp() || machine_is_miccpt() || machine_is_mic256())
 		uart_base = (volatile u32*) IXP4XX_UART2_BASE_PHYS;
 	else
 		uart_base = (volatile u32*) IXP4XX_UART1_BASE_PHYS;
diff --git a/arch/arm/mach-ixp4xx/mic256-setup.c b/arch/arm/mach-ixp4xx/mic256-setup.c
new file mode 100644
index 0000000..1e27578
--- /dev/null
+++ b/arch/arm/mach-ixp4xx/mic256-setup.c
@@ -0,0 +1,220 @@
+/*
+ * arch/arm/mach-ixp4xx/mic256-setup.c
+ *
+ * mic256 board-setup
+ *
+ * based nslu2-setup.c, ixdp425-setup.c:
+ *      Copyright (C) 2003-2004 MontaVista Software, Inc.
+ *
+ * Author: Richard Cochran <richard.cochran AT omicron.at>
+ *      Copyright (C) 2009 OMICRON electronics GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/i2c.h>
+#include <linux/serial.h>
+#include <linux/serial_8250.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#ifdef CONFIG_LEDS_CLASS
+#include <linux/leds.h>
+#endif
+
+#include <asm/setup.h>
+#include <asm/memory.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/flash.h>
+
+static struct resource mic256_flash_resources[1] = {
+	{
+		.flags	= IORESOURCE_MEM,
+	}
+};
+
+static struct mtd_partition mic256_partitions[] = {
+	{
+		.name =		"Recovery Bootloader",
+		.size =		0x00020000,
+		.offset =	0,
+	}, {
+		.name =		"Calibration Data",
+		.size =		0x00020000,
+		.offset =	0x00020000,
+	}, {
+		.name =		"Recovery FPGA",
+		.size =		0x00020000,
+		.offset =	0x00040000,
+	}, {
+		.name =		"Release Bootloader",
+		.size =		0x00020000,
+		.offset =	0x00060000,
+	}, {
+		.name =		"Release FPGA",
+		.size =		0x00020000,
+		.offset =	0x00080000,
+	}, {
+		.name =		"Kernel",
+		.size =		0x00160000,
+		.offset =	0x000a0000,
+	}, {
+		.name =		"Filesystem",
+		.size =		0x00C00000,
+		.offset =	0x00200000
+	}, {
+		.name =		"Persistent Storage",
+		.size =		0x00200000,
+		.offset =	0x00E00000
+	}
+};
+
+static struct flash_platform_data mic256_flash_data[1] = {
+	{
+		.map_name	= "cfi_probe",
+		.parts		= mic256_partitions,
+		.nr_parts	= ARRAY_SIZE(mic256_partitions),
+	}
+};
+
+static struct platform_device mic256_flash_device[1] = {
+	{
+		.name		= "IXP4XX-Flash",
+		.id		= 0,
+		.dev = {
+			.platform_data = &mic256_flash_data[0],
+		},
+		.resource = &mic256_flash_resources[0],
+		.num_resources = 1,
+	}
+};
+
+/* Swap UART's - MIC256 board has the console on UART2. The following
+ * configuration is used:
+ *      ttyS0 .. UART2
+ *      ttyS1 .. UART1
+ * This way standard images can be used with the kernel that expect
+ * the console on ttyS0.
+ */
+static struct resource mic256_uart_resources[] = {
+	{
+		.start		= IXP4XX_UART2_BASE_PHYS,
+		.end		= IXP4XX_UART2_BASE_PHYS + 0x0fff,
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.start		= IXP4XX_UART1_BASE_PHYS,
+		.end		= IXP4XX_UART1_BASE_PHYS + 0x0fff,
+		.flags		= IORESOURCE_MEM,
+	},
+};
+
+static struct plat_serial8250_port mic256_uart_data[] = {
+	{
+		.mapbase	= IXP4XX_UART2_BASE_PHYS,
+		.membase	= (char *)IXP4XX_UART2_BASE_VIRT + REG_OFFSET,
+		.irq		= IRQ_IXP4XX_UART2,
+		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
+		.iotype		= UPIO_MEM,
+		.regshift	= 2,
+		.uartclk	= IXP4XX_UART_XTAL,
+	},
+	{
+		.mapbase	= IXP4XX_UART1_BASE_PHYS,
+		.membase	= (char *)IXP4XX_UART1_BASE_VIRT + REG_OFFSET,
+		.irq		= IRQ_IXP4XX_UART1,
+		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
+		.iotype		= UPIO_MEM,
+		.regshift	= 2,
+		.uartclk	= IXP4XX_UART_XTAL,
+	},
+	{ }
+};
+
+static struct platform_device mic256_uart = {
+	.name			= "serial8250",
+	.id			= PLAT8250_DEV_PLATFORM,
+	.dev.platform_data	= mic256_uart_data,
+	.num_resources		= 2,
+	.resource		= mic256_uart_resources,
+};
+
+static struct gpio_led mic256_led_pins[] = {
+	{
+		.name		= "LED-A",
+		.gpio		= 7,
+	},
+};
+
+static struct gpio_led_platform_data mic256_led_data = {
+	.num_leds		= ARRAY_SIZE(mic256_led_pins),
+	.leds			= mic256_led_pins,
+};
+
+static struct platform_device mic256_leds = {
+	.name			= "leds-gpio",
+	.id			= -1,
+	.dev.platform_data	= &mic256_led_data,
+};
+
+/* Built-in 10/100 Ethernet MAC interfaces */
+static struct eth_plat_info ixdp425_plat_eth[] = {
+	{
+		.phy		= 0,
+		.rxq		= 3,
+		.txreadyq	= 20,
+	}, {
+		.phy		= 1,
+		.rxq		= 4,
+		.txreadyq	= 21,
+	}
+};
+
+static struct platform_device ixdp425_eth[] = {
+	{
+		.name			= "ixp4xx_eth",
+		.id			= IXP4XX_ETH_NPEB,
+		.dev.platform_data	= ixdp425_plat_eth,
+	}, {
+		.name			= "ixp4xx_eth",
+		.id			= IXP4XX_ETH_NPEC,
+		.dev.platform_data	= ixdp425_plat_eth + 1,
+	}
+};
+
+static struct platform_device *mic256_devices[] __initdata = {
+	&mic256_flash_device[0],
+	&mic256_leds,
+	&ixdp425_eth[0],
+	&ixdp425_eth[1],
+};
+
+static void __init mic256_init(void)
+{
+	ixp4xx_sys_init();
+
+	/* 16MiB Boot Flash */
+	mic256_flash_resources[0].start = IXP4XX_EXP_BUS_BASE(0);
+	mic256_flash_resources[0].end =
+		IXP4XX_EXP_BUS_BASE(0) + ixp4xx_exp_bus_size - 1;
+
+	/* Have this first in order to see debug messages, and so that
+	 * it does *not* get removed if platform_add_devices fails!
+	 */
+	(void)platform_device_register(&mic256_uart);
+
+	platform_add_devices(mic256_devices, ARRAY_SIZE(mic256_devices));
+}
+
+MACHINE_START(MIC256, "Omicron MIC256")
+	.phys_io	= IXP4XX_PERIPHERAL_BASE_PHYS,
+	.io_pg_offst	= ((IXP4XX_PERIPHERAL_BASE_VIRT) >> 18) & 0xFFFC,
+	.boot_params    = 0x100,
+	.map_io		= ixp4xx_map_io,
+	.init_irq	= ixp4xx_init_irq,
+	.timer          = &ixp4xx_timer,
+	.init_machine	= mic256_init,
+MACHINE_END
-- 
1.6.3.3
