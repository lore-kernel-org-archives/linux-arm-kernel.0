From: richardcochran@gmail.com (Richard Cochran)
Date: Wed, 2 Jun 2010 11:56:40 +0200
Subject: [PATCH 1/3] ixp4xx: support the OMICRON DEVIXP board
In-Reply-To: <cover.1275415521.git.richard.cochran@omicron.at>
References: <cover.1275415521.git.richard.cochran@omicron.at>
Message-ID: <82c0bd9b2deb7cde837f73b7e366e4889ef47160.1275415521.git.richard.cochran@omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds board support for the DEVIXP, which is an IXP425 based
development board by OMICRON electronics, GmbH.

Signed-off-by: Richard Cochran <richard.cochran@omicron.at>
---
 arch/arm/mach-ixp4xx/Kconfig                   |    7 +
 arch/arm/mach-ixp4xx/Makefile                  |    1 +
 arch/arm/mach-ixp4xx/devixp-setup.c            |  225 ++++++++++++++++++++++++
 arch/arm/mach-ixp4xx/include/mach/uncompress.h |    3 +-
 4 files changed, 235 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-ixp4xx/devixp-setup.c

diff --git a/arch/arm/mach-ixp4xx/Kconfig b/arch/arm/mach-ixp4xx/Kconfig
index 9e5070d..18f3609 100644
--- a/arch/arm/mach-ixp4xx/Kconfig
+++ b/arch/arm/mach-ixp4xx/Kconfig
@@ -8,6 +8,13 @@ menu "Intel IXP4xx Implementation Options"
 
 comment "IXP4xx Platforms"
 
+config MACH_DEVIXP
+	bool "Omicron DEVIXP"
+	help
+	  Say 'Y' here if you want your kernel to support the DEVIXP
+	  board from OMICRON electronics GmbH. For more information on
+	  this platform, see http://www.omicron.at
+
 config MACH_NSLU2
 	bool
 	prompt "Linksys NSLU2"
diff --git a/arch/arm/mach-ixp4xx/Makefile b/arch/arm/mach-ixp4xx/Makefile
index 47d1f60..44eb184 100644
--- a/arch/arm/mach-ixp4xx/Makefile
+++ b/arch/arm/mach-ixp4xx/Makefile
@@ -20,6 +20,7 @@ obj-pci-$(CONFIG_MACH_FSG)		+= fsg-pci.o
 obj-y	+= common.o
 
 obj-$(CONFIG_ARCH_IXDP4XX)	+= ixdp425-setup.o
+obj-$(CONFIG_MACH_DEVIXP)	+= devixp-setup.o
 obj-$(CONFIG_MACH_AVILA)	+= avila-setup.o
 obj-$(CONFIG_MACH_IXDPG425)	+= coyote-setup.o
 obj-$(CONFIG_ARCH_ADI_COYOTE)	+= coyote-setup.o
diff --git a/arch/arm/mach-ixp4xx/devixp-setup.c b/arch/arm/mach-ixp4xx/devixp-setup.c
new file mode 100644
index 0000000..3dc686c
--- /dev/null
+++ b/arch/arm/mach-ixp4xx/devixp-setup.c
@@ -0,0 +1,225 @@
+/*
+ * arch/arm/mach-ixp4xx/devixp-setup.c
+ *
+ * devixp board-setup
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
+static struct resource devixp_flash_resources[2] = {
+	[0] = {
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct mtd_partition devixp_partitions[] = {
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
+static struct flash_platform_data devixp_flash_data[2] = {
+	{
+		.map_name	= "cfi_probe",
+		.parts		= devixp_partitions,
+		.nr_parts	= ARRAY_SIZE(devixp_partitions),
+	}, {
+		.map_name	= "cfi_probe",
+		.parts		= NULL,
+		.nr_parts	= 0,
+	}
+};
+
+static struct platform_device devixp_flash_device[2] = {
+	{
+		.name		= "IXP4XX-Flash",
+		.id		= 0,
+		.dev = {
+			.platform_data = &devixp_flash_data[0],
+		},
+		.resource = &devixp_flash_resources[0],
+		.num_resources = 1,
+	},
+	{
+		.name		= "IXP4XX-Flash",
+		.id		= 1,
+		.dev = {
+			.platform_data = &devixp_flash_data[1],
+		},
+		.resource = &devixp_flash_resources[1],
+		.num_resources = 1,
+	},
+};
+
+
+/* Swap UART's - DEVIXP board has the console on UART2. The following
+ * configuration is used:
+ *      ttyS0 .. UART2
+ *      ttyS1 .. UART1
+ * This way standard images can be used with the kernel that expect
+ * the console on ttyS0.
+ */
+static struct resource devixp_uart_resources[] = {
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
+static struct plat_serial8250_port devixp_uart_data[] = {
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
+static struct platform_device devixp_uart = {
+	.name			= "serial8250",
+	.id			= PLAT8250_DEV_PLATFORM,
+	.dev.platform_data	= devixp_uart_data,
+	.num_resources		= 2,
+	.resource		= devixp_uart_resources,
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
+
+static struct platform_device *devixp_devices[] __initdata = {
+	&devixp_flash_device[0],
+	&ixdp425_eth[0],
+	&ixdp425_eth[1],
+};
+
+
+static void __init devixp_init(void)
+{
+	ixp4xx_sys_init();
+
+	/* 16MiB Boot Flash */
+	devixp_flash_resources[0].start = IXP4XX_EXP_BUS_BASE(0);
+	devixp_flash_resources[0].end =
+		IXP4XX_EXP_BUS_BASE(0) + ixp4xx_exp_bus_size - 1;
+
+	/* 32 MiB Data Flash */
+	devixp_flash_resources[1].start = IXP4XX_EXP_BUS_BASE(2);
+	devixp_flash_resources[1].end =
+		IXP4XX_EXP_BUS_BASE(2) + 2 * ixp4xx_exp_bus_size - 1;
+
+	/* Have this first in order to see debug messages, and so that
+	 * it does *not* get removed if platform_add_devices fails!
+	 */
+	(void)platform_device_register(&devixp_uart);
+
+	platform_add_devices(devixp_devices, ARRAY_SIZE(devixp_devices));
+}
+
+
+MACHINE_START(DEVIXP, "Omicron DEVIXP")
+	.phys_io	= IXP4XX_PERIPHERAL_BASE_PHYS,
+	.io_pg_offst	= ((IXP4XX_PERIPHERAL_BASE_VIRT) >> 18) & 0xFFFC,
+	.boot_params    = 0x100,
+	.map_io		= ixp4xx_map_io,
+	.init_irq	= ixp4xx_init_irq,
+	.timer          = &ixp4xx_timer,
+	.init_machine	= devixp_init,
+MACHINE_END
diff --git a/arch/arm/mach-ixp4xx/include/mach/uncompress.h b/arch/arm/mach-ixp4xx/include/mach/uncompress.h
index 2db0078..e06eb05 100644
--- a/arch/arm/mach-ixp4xx/include/mach/uncompress.h
+++ b/arch/arm/mach-ixp4xx/include/mach/uncompress.h
@@ -41,7 +41,8 @@ static __inline__ void __arch_decomp_setup(unsigned long arch_id)
 	 * Some boards are using UART2 as console
 	 */
 	if (machine_is_adi_coyote() || machine_is_gtwx5715() ||
-			 machine_is_gateway7001() || machine_is_wg302v2())
+	    machine_is_gateway7001() || machine_is_wg302v2() ||
+	    machine_is_devixp())
 		uart_base = (volatile u32*) IXP4XX_UART2_BASE_PHYS;
 	else
 		uart_base = (volatile u32*) IXP4XX_UART1_BASE_PHYS;
-- 
1.6.3.3
