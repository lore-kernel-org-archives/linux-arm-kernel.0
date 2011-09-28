From: richardcochran@gmail.com (Richard Cochran)
Date: Wed, 28 Sep 2011 15:16:41 +0200
Subject: [PATCH 1/1] ixp4xx: support omicron ixp425 based boards
In-Reply-To: <cover.1317215339.git.richard.cochran@omicron.at>
References: <cover.1317215339.git.richard.cochran@omicron.at>
Message-ID: <2fb96724bde8bef58a5fbb1a3e523bc6118692db.1317215339.git.richard.cochran@omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds board support for the DEVIXP, the MICCPT, and the
MIC256, which are three IXP425 based boards produced by OMICRON
electronics, GmbH.

Signed-off-by: Richard Cochran <richard.cochran@omicron.at>
---
 arch/arm/mach-ixp4xx/Kconfig                   |   19 ++
 arch/arm/mach-ixp4xx/Makefile                  |    4 +
 arch/arm/mach-ixp4xx/include/mach/uncompress.h |    3 +-
 arch/arm/mach-ixp4xx/miccpt-pci.c              |   78 +++++++
 arch/arm/mach-ixp4xx/omixp-setup.c             |  273 ++++++++++++++++++++++++
 5 files changed, 376 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-ixp4xx/miccpt-pci.c
 create mode 100644 arch/arm/mach-ixp4xx/omixp-setup.c

diff --git a/arch/arm/mach-ixp4xx/Kconfig b/arch/arm/mach-ixp4xx/Kconfig
index 6f991c5..fd5e7b6 100644
--- a/arch/arm/mach-ixp4xx/Kconfig
+++ b/arch/arm/mach-ixp4xx/Kconfig
@@ -179,6 +179,25 @@ config MACH_GTWX5715
 		"High Speed" UART is n/c (as far as I can tell)
 		20 Pin ARM/Xscale JTAG interface on J2
 
+config MACH_DEVIXP
+	bool "Omicron DEVIXP"
+	help
+	  Say 'Y' here if you want your kernel to support the DEVIXP
+	  board from OMICRON electronics GmbH.
+
+config MACH_MICCPT
+	bool "Omicron MICCPT"
+	select PCI
+	help
+	  Say 'Y' here if you want your kernel to support the MICCPT
+	  board from OMICRON electronics GmbH.
+
+config MACH_MIC256
+	bool "Omicron MIC256"
+	help
+	  Say 'Y' here if you want your kernel to support the MIC256
+	  board from OMICRON electronics GmbH.
+
 comment "IXP4xx Options"
 
 config IXP4XX_INDIRECT_PCI
diff --git a/arch/arm/mach-ixp4xx/Makefile b/arch/arm/mach-ixp4xx/Makefile
index d807fc3..eded94c 100644
--- a/arch/arm/mach-ixp4xx/Makefile
+++ b/arch/arm/mach-ixp4xx/Makefile
@@ -10,6 +10,7 @@ obj-pci-$(CONFIG_MACH_AVILA)		+= avila-pci.o
 obj-pci-$(CONFIG_MACH_IXDPG425)		+= ixdpg425-pci.o
 obj-pci-$(CONFIG_ARCH_ADI_COYOTE)	+= coyote-pci.o
 obj-pci-$(CONFIG_MACH_GTWX5715)		+= gtwx5715-pci.o
+obj-pci-$(CONFIG_MACH_MICCPT)		+= miccpt-pci.o
 obj-pci-$(CONFIG_MACH_NSLU2)		+= nslu2-pci.o
 obj-pci-$(CONFIG_MACH_NAS100D)		+= nas100d-pci.o
 obj-pci-$(CONFIG_MACH_DSMG600)		+= dsmg600-pci.o
@@ -25,6 +26,9 @@ obj-$(CONFIG_MACH_AVILA)	+= avila-setup.o
 obj-$(CONFIG_MACH_IXDPG425)	+= coyote-setup.o
 obj-$(CONFIG_ARCH_ADI_COYOTE)	+= coyote-setup.o
 obj-$(CONFIG_MACH_GTWX5715)	+= gtwx5715-setup.o
+obj-$(CONFIG_MACH_DEVIXP)	+= omixp-setup.o
+obj-$(CONFIG_MACH_MICCPT)	+= omixp-setup.o
+obj-$(CONFIG_MACH_MIC256)	+= omixp-setup.o
 obj-$(CONFIG_MACH_NSLU2)	+= nslu2-setup.o
 obj-$(CONFIG_MACH_NAS100D)	+= nas100d-setup.o
 obj-$(CONFIG_MACH_DSMG600)      += dsmg600-setup.o
diff --git a/arch/arm/mach-ixp4xx/include/mach/uncompress.h b/arch/arm/mach-ixp4xx/include/mach/uncompress.h
index 219d7c1..eb945a9 100644
--- a/arch/arm/mach-ixp4xx/include/mach/uncompress.h
+++ b/arch/arm/mach-ixp4xx/include/mach/uncompress.h
@@ -41,7 +41,8 @@ static __inline__ void __arch_decomp_setup(unsigned long arch_id)
 	 * Some boards are using UART2 as console
 	 */
 	if (machine_is_adi_coyote() || machine_is_gtwx5715() ||
-			 machine_is_gateway7001() || machine_is_wg302v2())
+	    machine_is_gateway7001() || machine_is_wg302v2() ||
+	    machine_is_devixp() || machine_is_miccpt() || machine_is_mic256())
 		uart_base = (volatile u32*) IXP4XX_UART2_BASE_PHYS;
 	else
 		uart_base = (volatile u32*) IXP4XX_UART1_BASE_PHYS;
diff --git a/arch/arm/mach-ixp4xx/miccpt-pci.c b/arch/arm/mach-ixp4xx/miccpt-pci.c
new file mode 100644
index 0000000..ca0bae7
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
+	irq_set_irq_type(IXP4XX_GPIO_IRQ(INTA), IRQ_TYPE_LEVEL_LOW);
+	irq_set_irq_type(IXP4XX_GPIO_IRQ(INTB), IRQ_TYPE_LEVEL_LOW);
+	irq_set_irq_type(IXP4XX_GPIO_IRQ(INTC), IRQ_TYPE_LEVEL_LOW);
+	irq_set_irq_type(IXP4XX_GPIO_IRQ(INTD), IRQ_TYPE_LEVEL_LOW);
+	ixp4xx_pci_preinit();
+}
+
+static int __init miccpt_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
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
diff --git a/arch/arm/mach-ixp4xx/omixp-setup.c b/arch/arm/mach-ixp4xx/omixp-setup.c
new file mode 100644
index 0000000..4dfdc69
--- /dev/null
+++ b/arch/arm/mach-ixp4xx/omixp-setup.c
@@ -0,0 +1,273 @@
+/*
+ * arch/arm/mach-ixp4xx/omixp-setup.c
+ *
+ * omicron ixp4xx board setup
+ *      Copyright (C) 2009 OMICRON electronics GmbH
+ *
+ * based nslu2-setup.c, ixdp425-setup.c:
+ *      Copyright (C) 2003-2004 MontaVista Software, Inc.
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
+static struct resource omixp_flash_resources[] = {
+	{
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct mtd_partition omixp_partitions[] = {
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
+		.offset =	0x00200000,
+	}, {
+		.name =		"Persistent Storage",
+		.size =		0x00200000,
+		.offset =	0x00E00000,
+	},
+};
+
+static struct flash_platform_data omixp_flash_data[] = {
+	{
+		.map_name	= "cfi_probe",
+		.parts		= omixp_partitions,
+		.nr_parts	= ARRAY_SIZE(omixp_partitions),
+	}, {
+		.map_name	= "cfi_probe",
+		.parts		= NULL,
+		.nr_parts	= 0,
+	},
+};
+
+static struct platform_device omixp_flash_device[] = {
+	{
+		.name		= "IXP4XX-Flash",
+		.id		= 0,
+		.dev = {
+			.platform_data = &omixp_flash_data[0],
+		},
+		.resource = &omixp_flash_resources[0],
+		.num_resources = 1,
+	}, {
+		.name		= "IXP4XX-Flash",
+		.id		= 1,
+		.dev = {
+			.platform_data = &omixp_flash_data[1],
+		},
+		.resource = &omixp_flash_resources[1],
+		.num_resources = 1,
+	},
+};
+
+/* Swap UART's - These boards have the console on UART2. The following
+ * configuration is used:
+ *      ttyS0 .. UART2
+ *      ttyS1 .. UART1
+ * This way standard images can be used with the kernel that expect
+ * the console on ttyS0.
+ */
+static struct resource omixp_uart_resources[] = {
+	{
+		.start		= IXP4XX_UART2_BASE_PHYS,
+		.end		= IXP4XX_UART2_BASE_PHYS + 0x0fff,
+		.flags		= IORESOURCE_MEM,
+	}, {
+		.start		= IXP4XX_UART1_BASE_PHYS,
+		.end		= IXP4XX_UART1_BASE_PHYS + 0x0fff,
+		.flags		= IORESOURCE_MEM,
+	},
+};
+
+static struct plat_serial8250_port omixp_uart_data[] = {
+	{
+		.mapbase	= IXP4XX_UART2_BASE_PHYS,
+		.membase	= (char *)IXP4XX_UART2_BASE_VIRT + REG_OFFSET,
+		.irq		= IRQ_IXP4XX_UART2,
+		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
+		.iotype		= UPIO_MEM,
+		.regshift	= 2,
+		.uartclk	= IXP4XX_UART_XTAL,
+	}, {
+		.mapbase	= IXP4XX_UART1_BASE_PHYS,
+		.membase	= (char *)IXP4XX_UART1_BASE_VIRT + REG_OFFSET,
+		.irq		= IRQ_IXP4XX_UART1,
+		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
+		.iotype		= UPIO_MEM,
+		.regshift	= 2,
+		.uartclk	= IXP4XX_UART_XTAL,
+	}, {
+		/* list termination */
+	}
+};
+
+static struct platform_device omixp_uart = {
+	.name			= "serial8250",
+	.id			= PLAT8250_DEV_PLATFORM,
+	.dev.platform_data	= omixp_uart_data,
+	.num_resources		= 2,
+	.resource		= omixp_uart_resources,
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
+	},
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
+	},
+};
+
+
+static struct platform_device *devixp_pldev[] __initdata = {
+	&omixp_uart,
+	&omixp_flash_device[0],
+	&ixdp425_eth[0],
+	&ixdp425_eth[1],
+};
+
+static struct platform_device *mic256_pldev[] __initdata = {
+	&omixp_uart,
+	&omixp_flash_device[0],
+	&mic256_leds,
+	&ixdp425_eth[0],
+	&ixdp425_eth[1],
+};
+
+static struct platform_device *miccpt_pldev[] __initdata = {
+	&omixp_uart,
+	&omixp_flash_device[0],
+	&omixp_flash_device[1],
+	&ixdp425_eth[0],
+	&ixdp425_eth[1],
+};
+
+static void __init omixp_init(void)
+{
+	ixp4xx_sys_init();
+
+	/* 16MiB Boot Flash */
+	omixp_flash_resources[0].start = IXP4XX_EXP_BUS_BASE(0);
+	omixp_flash_resources[0].end   = IXP4XX_EXP_BUS_END(0);
+
+	/* 32 MiB Data Flash */
+	omixp_flash_resources[1].start = IXP4XX_EXP_BUS_BASE(2);
+	omixp_flash_resources[1].end   = IXP4XX_EXP_BUS_END(2);
+
+	if (machine_is_devixp())
+		platform_add_devices(devixp_pldev, ARRAY_SIZE(devixp_pldev));
+	else if (machine_is_miccpt())
+		platform_add_devices(miccpt_pldev, ARRAY_SIZE(miccpt_pldev));
+	else if (machine_is_mic256())
+		platform_add_devices(mic256_pldev, ARRAY_SIZE(mic256_pldev));
+}
+
+#ifdef CONFIG_MACH_DEVIXP
+MACHINE_START(DEVIXP, "Omicron DEVIXP")
+	.boot_params    = 0x100,
+	.map_io		= ixp4xx_map_io,
+	.init_irq	= ixp4xx_init_irq,
+	.timer          = &ixp4xx_timer,
+	.init_machine	= omixp_init,
+MACHINE_END
+#endif
+
+#ifdef CONFIG_MACH_MICCPT
+MACHINE_START(MICCPT, "Omicron MICCPT")
+	.boot_params    = 0x100,
+	.map_io		= ixp4xx_map_io,
+	.init_irq	= ixp4xx_init_irq,
+	.timer          = &ixp4xx_timer,
+	.init_machine	= omixp_init,
+#if defined(CONFIG_PCI)
+	.dma_zone_size	= SZ_64M,
+#endif
+MACHINE_END
+#endif
+
+#ifdef CONFIG_MACH_MIC256
+MACHINE_START(MIC256, "Omicron MIC256")
+	.boot_params    = 0x100,
+	.map_io		= ixp4xx_map_io,
+	.init_irq	= ixp4xx_init_irq,
+	.timer          = &ixp4xx_timer,
+	.init_machine	= omixp_init,
+MACHINE_END
+#endif
-- 
1.7.2.5
