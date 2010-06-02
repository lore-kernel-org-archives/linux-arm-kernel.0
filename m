From: richardcochran@gmail.com (Richard Cochran)
Date: Wed, 2 Jun 2010 11:57:12 +0200
Subject: [PATCH 2/3] ixp4xx: support the OMICRON MICCPT board
In-Reply-To: <cover.1275415521.git.richard.cochran@omicron.at>
References: <cover.1275415521.git.richard.cochran@omicron.at>
Message-ID: <3a6e8b8456e4edb8d520f93f028bc476ca65b9f0.1275415521.git.richard.cochran@omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds board support for the MICCPT, which is an IXP425 based
board with PCI support, by OMICRON electronics, GmbH.

Signed-off-by: Richard Cochran <richard.cochran@omicron.at>
---
 arch/arm/mach-ixp4xx/Kconfig                   |    8 +
 arch/arm/mach-ixp4xx/Makefile                  |    2 +
 arch/arm/mach-ixp4xx/include/mach/uncompress.h |    2 +-
 arch/arm/mach-ixp4xx/miccpt-pci.c              |   78 +++++++++
 arch/arm/mach-ixp4xx/miccpt-setup.c            |  221 ++++++++++++++++++++++++
 5 files changed, 310 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-ixp4xx/miccpt-pci.c
 create mode 100644 arch/arm/mach-ixp4xx/miccpt-setup.c

diff --git a/arch/arm/mach-ixp4xx/Kconfig b/arch/arm/mach-ixp4xx/Kconfig
index 18f3609..97cb601 100644
--- a/arch/arm/mach-ixp4xx/Kconfig
+++ b/arch/arm/mach-ixp4xx/Kconfig
@@ -15,6 +15,14 @@ config MACH_DEVIXP
 	  board from OMICRON electronics GmbH. For more information on
 	  this platform, see http://www.omicron.at
 
+config MACH_MICCPT
+	bool "Omicron MICCPT"
+	select PCI
+	help
+	  Say 'Y' here if you want your kernel to support the MICCPT
+	  board from OMICRON electronics GmbH. For more information on
+	  this platform, see http://www.omicron.at
+
 config MACH_NSLU2
 	bool
 	prompt "Linksys NSLU2"
diff --git a/arch/arm/mach-ixp4xx/Makefile b/arch/arm/mach-ixp4xx/Makefile
index 44eb184..8a7edc8 100644
--- a/arch/arm/mach-ixp4xx/Makefile
+++ b/arch/arm/mach-ixp4xx/Makefile
@@ -11,6 +11,7 @@ obj-pci-$(CONFIG_MACH_IXDPG425)		+= ixdpg425-pci.o
 obj-pci-$(CONFIG_ARCH_ADI_COYOTE)	+= coyote-pci.o
 obj-pci-$(CONFIG_MACH_GTWX5715)		+= gtwx5715-pci.o
 obj-pci-$(CONFIG_MACH_NSLU2)		+= nslu2-pci.o
+obj-pci-$(CONFIG_MACH_MICCPT)		+= miccpt-pci.o
 obj-pci-$(CONFIG_MACH_NAS100D)		+= nas100d-pci.o
 obj-pci-$(CONFIG_MACH_DSMG600)		+= dsmg600-pci.o
 obj-pci-$(CONFIG_MACH_GATEWAY7001)	+= gateway7001-pci.o
@@ -21,6 +22,7 @@ obj-y	+= common.o
 
 obj-$(CONFIG_ARCH_IXDP4XX)	+= ixdp425-setup.o
 obj-$(CONFIG_MACH_DEVIXP)	+= devixp-setup.o
+obj-$(CONFIG_MACH_MICCPT)	+= miccpt-setup.o
 obj-$(CONFIG_MACH_AVILA)	+= avila-setup.o
 obj-$(CONFIG_MACH_IXDPG425)	+= coyote-setup.o
 obj-$(CONFIG_ARCH_ADI_COYOTE)	+= coyote-setup.o
diff --git a/arch/arm/mach-ixp4xx/include/mach/uncompress.h b/arch/arm/mach-ixp4xx/include/mach/uncompress.h
index e06eb05..1fa3c48 100644
--- a/arch/arm/mach-ixp4xx/include/mach/uncompress.h
+++ b/arch/arm/mach-ixp4xx/include/mach/uncompress.h
@@ -42,7 +42,7 @@ static __inline__ void __arch_decomp_setup(unsigned long arch_id)
 	 */
 	if (machine_is_adi_coyote() || machine_is_gtwx5715() ||
 	    machine_is_gateway7001() || machine_is_wg302v2() ||
-	    machine_is_devixp())
+	    machine_is_devixp() || machine_is_miccpt())
 		uart_base = (volatile u32*) IXP4XX_UART2_BASE_PHYS;
 	else
 		uart_base = (volatile u32*) IXP4XX_UART1_BASE_PHYS;
diff --git a/arch/arm/mach-ixp4xx/miccpt-pci.c b/arch/arm/mach-ixp4xx/miccpt-pci.c
new file mode 100644
index 0000000..6bd67dd
--- /dev/null
+++ b/arch/arm/mach-ixp4xx/miccpt-pci.c
@@ -0,0 +1,78 @@
+/*
+ * arch/arm/mach-ixp4xx/miccpt-pci.c
+ *
+ * MICCPT board-level PCI initialization
+ *
+ * Copyright (C) 2002 Intel Corporation.
+ * Copyright (C) 2003-2004 MontaVista Software, Inc.
+ * Copyright (C) 2006 OMICRON electronics GmbH
+ *
+ * Author: Michael Jochum <michael.jochum@omicron.at>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/irq.h>
+#include <asm/mach/pci.h>
+#include <asm/irq.h>
+#include <mach/hardware.h>
+#include <asm/mach-types.h>
+
+#define MAX_DEV		4
+#define IRQ_LINES	4
+
+/* PCI controller GPIO to IRQ pin mappings */
+#define INTA		1
+#define INTB		2
+#define INTC		3
+#define INTD		4
+
+
+void __init miccpt_pci_preinit(void)
+{
+	set_irq_type(IXP4XX_GPIO_IRQ(INTA), IRQ_TYPE_LEVEL_LOW);
+	set_irq_type(IXP4XX_GPIO_IRQ(INTB), IRQ_TYPE_LEVEL_LOW);
+	set_irq_type(IXP4XX_GPIO_IRQ(INTC), IRQ_TYPE_LEVEL_LOW);
+	set_irq_type(IXP4XX_GPIO_IRQ(INTD), IRQ_TYPE_LEVEL_LOW);
+	ixp4xx_pci_preinit();
+}
+
+static int __init miccpt_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
+{
+	static int pci_irq_table[IRQ_LINES] = {
+		IXP4XX_GPIO_IRQ(INTA),
+		IXP4XX_GPIO_IRQ(INTB),
+		IXP4XX_GPIO_IRQ(INTC),
+		IXP4XX_GPIO_IRQ(INTD)
+	};
+
+	if (slot >= 1 && slot <= MAX_DEV && pin >= 1 && pin <= IRQ_LINES)
+		return pci_irq_table[(slot + pin - 2) % 4];
+
+	return -1;
+}
+
+struct hw_pci miccpt_pci __initdata = {
+	.nr_controllers = 1,
+	.preinit	= miccpt_pci_preinit,
+	.swizzle	= pci_std_swizzle,
+	.setup		= ixp4xx_setup,
+	.scan		= ixp4xx_scan_bus,
+	.map_irq	= miccpt_map_irq,
+};
+
+int __init miccpt_pci_init(void)
+{
+	if (machine_is_miccpt())
+		pci_common_init(&miccpt_pci);
+	return 0;
+}
+
+subsys_initcall(miccpt_pci_init);
diff --git a/arch/arm/mach-ixp4xx/miccpt-setup.c b/arch/arm/mach-ixp4xx/miccpt-setup.c
new file mode 100644
index 0000000..07b8bc1
--- /dev/null
+++ b/arch/arm/mach-ixp4xx/miccpt-setup.c
@@ -0,0 +1,221 @@
+/*
+ * arch/arm/mach-ixp4xx/miccpt-setup.c
+ *
+ * miccpt board-setup
+ *
+ * based nslu2-setup.c, ixdp425-setup.c:
+ *      Copyright (C) 2003-2004 MontaVista Software, Inc.
+ *
+ * Author: Michael Jochum <michael.jochum AT omicron.at>
+ *      Copyright (C) 2006 OMICRON electronics GmbH
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
+static struct resource miccpt_flash_resources[] = {
+	[0] = {
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct mtd_partition miccpt_partitions[] = {
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
+		.size =		MTDPART_SIZ_FULL,
+		.offset =	0x00200000
+	}
+};
+
+static struct flash_platform_data miccpt_flash_data[2] = {
+	{
+		.map_name	= "cfi_probe",
+		.parts		= miccpt_partitions,
+		.nr_parts	= ARRAY_SIZE(miccpt_partitions),
+	}, {
+		.map_name	= "cfi_probe",
+		.parts		= NULL,
+		.nr_parts	= 0,
+	}
+};
+
+static struct platform_device miccpt_flash_device[2] = {
+	{
+		.name		= "IXP4XX-Flash",
+		.id		= 0,
+		.dev = {
+			.platform_data = &miccpt_flash_data[0],
+		},
+		.resource = &miccpt_flash_resources[0],
+		.num_resources = 1,
+	},
+	{
+		.name		= "IXP4XX-Flash",
+		.id		= 1,
+		.dev = {
+			.platform_data = &miccpt_flash_data[1],
+		},
+		.resource = &miccpt_flash_resources[1],
+		.num_resources = 1,
+	},
+};
+
+
+/* Swap UART's - MICCPT board has the console on UART2. The following
+ * configuration is used:
+ *      ttyS0 .. UART2
+ *      ttyS1 .. UART1
+ * This way standard images can be used with the kernel that expect
+ * the console on ttyS0.
+ */
+static struct resource miccpt_uart_resources[] = {
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
+static struct plat_serial8250_port miccpt_uart_data[] = {
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
+static struct platform_device miccpt_uart = {
+	.name			= "serial8250",
+	.id			= PLAT8250_DEV_PLATFORM,
+	.dev.platform_data	= miccpt_uart_data,
+	.num_resources		= 2,
+	.resource		= miccpt_uart_resources,
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
+static struct platform_device *miccpt_devices[] __initdata = {
+	&miccpt_flash_device[0],
+	&ixdp425_eth[0],
+	&ixdp425_eth[1],
+};
+
+
+static void __init miccpt_init(void)
+{
+	ixp4xx_sys_init();
+
+	/* 16MiB Boot Flash */
+	miccpt_flash_resources[0].start = IXP4XX_EXP_BUS_BASE(0);
+	miccpt_flash_resources[0].end =
+		IXP4XX_EXP_BUS_BASE(0) + ixp4xx_exp_bus_size - 1;
+
+	/* 32 MiB Data Flash */
+	miccpt_flash_resources[1].start = IXP4XX_EXP_BUS_BASE(2);
+	miccpt_flash_resources[1].end =
+		IXP4XX_EXP_BUS_BASE(2) + 2 * ixp4xx_exp_bus_size - 1;
+
+	/* Have this first in order to see debug messages, and so that
+	 * it does *not* get removed if platform_add_devices fails!
+	 */
+	(void)platform_device_register(&miccpt_uart);
+
+	platform_add_devices(miccpt_devices, ARRAY_SIZE(miccpt_devices));
+}
+
+
+MACHINE_START(MICCPT, "Omicron MICCPT")
+	.phys_io	= IXP4XX_PERIPHERAL_BASE_PHYS,
+	.io_pg_offst	= ((IXP4XX_PERIPHERAL_BASE_VIRT) >> 18) & 0xFFFC,
+	.boot_params    = 0x100,
+	.map_io		= ixp4xx_map_io,
+	.init_irq	= ixp4xx_init_irq,
+	.timer          = &ixp4xx_timer,
+	.init_machine	= miccpt_init,
+MACHINE_END
-- 
1.6.3.3
