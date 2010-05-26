From: hjk@linutronix.de (Hans J. Koch)
Date: Wed, 26 May 2010 19:52:42 +0200
Subject: [PATCH 6/7 v6] Add common platform devices for TCC8xxx SoCs
In-Reply-To: <20100526174240.GC2006@bluebox.local>
References: <20100526174240.GC2006@bluebox.local>
Message-ID: <20100526175241.GI2006@bluebox.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces a first set of platform devices for integrated
peripherals of TCC8xxx processors. Drivers for these devices are
available and will be posted in a second step.

Signed-off-by: "Hans J. Koch" <hjk@linutronix.de>
---
 arch/arm/mach-tcc8k/Makefile  |    2 +-
 arch/arm/mach-tcc8k/devices.c |  238 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 239 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-tcc8k/devices.c

diff --git a/arch/arm/mach-tcc8k/Makefile b/arch/arm/mach-tcc8k/Makefile
index 09552e2..e8a1134 100644
--- a/arch/arm/mach-tcc8k/Makefile
+++ b/arch/arm/mach-tcc8k/Makefile
@@ -3,5 +3,5 @@
 #
 
 # Common support
-obj-y += clock.o irq.o time.o io.o
+obj-y += clock.o irq.o time.o io.o devices.o
 
diff --git a/arch/arm/mach-tcc8k/devices.c b/arch/arm/mach-tcc8k/devices.c
new file mode 100644
index 0000000..c73a115
--- /dev/null
+++ b/arch/arm/mach-tcc8k/devices.c
@@ -0,0 +1,238 @@
+/*
+ * linux/arch/arm/mach-tcc8k/devices.c
+ *
+ * Copyright (C) Telechips, Inc.
+ * Copyright (C) 2009 Hans J. Koch <hjk@linutronix.de>
+ *
+ * Licensed under the terms of GPL v2.
+ *
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include <asm/mach/map.h>
+
+#include <mach/tcc8k-regs.h>
+#include <mach/irqs.h>
+
+static u64 tcc8k_dmamask = DMA_BIT_MASK(32);
+
+#ifdef CONFIG_MTD_NAND_TCC
+/* NAND controller */
+static struct resource tcc_nand_resources[] = {
+	{
+		.start	= (resource_size_t)NFC_BASE,
+		.end	= (resource_size_t)NFC_BASE + 0x7f,
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= INT_NFC,
+		.end	= INT_NFC,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device tcc_nand_device = {
+	.name = "tcc_nand",
+	.id = 0,
+	.num_resources = ARRAY_SIZE(tcc_nand_resources),
+	.resource = tcc_nand_resources,
+};
+#endif
+
+#ifdef CONFIG_MMC_TCC8K
+/* MMC controller */
+static struct resource tcc8k_mmc0_resource[] = {
+	{
+		.start = INT_SD0,
+		.end   = INT_SD0,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+static struct resource tcc8k_mmc1_resource[] = {
+	{
+		.start = INT_SD1,
+		.end   = INT_SD1,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device tcc8k_mmc0_device = {
+	.name		= "tcc-mmc",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(tcc8k_mmc0_resource),
+	.resource	= tcc8k_mmc0_resource,
+	.dev		= {
+		.dma_mask		= &tcc8k_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	}
+};
+
+struct platform_device tcc8k_mmc1_device = {
+	.name		= "tcc-mmc",
+	.id		= 1,
+	.num_resources	= ARRAY_SIZE(tcc8k_mmc1_resource),
+	.resource	= tcc8k_mmc1_resource,
+	.dev		= {
+		.dma_mask		= &tcc8k_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	}
+};
+
+static inline void tcc8k_init_mmc(void)
+{
+	u32 reg = __raw_readl(GPIOPS_BASE + GPIOPS_FS1_OFFS);
+
+	reg |= GPIOPS_FS1_SDH0_BITS | GPIOPS_FS1_SDH1_BITS;
+	__raw_writel(reg, GPIOPS_BASE + GPIOPS_FS1_OFFS);
+
+	platform_device_register(&tcc8k_mmc0_device);
+	platform_device_register(&tcc8k_mmc1_device);
+}
+#else
+static inline void tcc8k_init_mmc(void) { }
+#endif
+
+#ifdef CONFIG_USB_OHCI_HCD
+static int tcc8k_ohci_init(struct device *dev)
+{
+	u32 reg;
+
+	/* Use GPIO PK19 as VBUS control output */
+	reg = __raw_readl(GPIOPK_BASE + GPIOPK_FS0_OFFS);
+	reg &= ~(1 << 19);
+	__raw_writel(reg, GPIOPK_BASE + GPIOPK_FS0_OFFS);
+	reg = __raw_readl(GPIOPK_BASE + GPIOPK_FS1_OFFS);
+	reg &= ~(1 << 19);
+	__raw_writel(reg, GPIOPK_BASE + GPIOPK_FS1_OFFS);
+
+	reg = __raw_readl(GPIOPK_BASE + GPIOPK_DOE_OFFS);
+	reg |= (1 << 19);
+	__raw_writel(reg, GPIOPK_BASE + GPIOPK_DOE_OFFS);
+	/* Turn on VBUS */
+	reg = __raw_readl(GPIOPK_BASE + GPIOPK_DAT_OFFS);
+	reg |= (1 << 19);
+	__raw_writel(reg, GPIOPK_BASE + GPIOPK_DAT_OFFS);
+
+	return 0;
+}
+
+static struct resource tcc8k_ohci0_resources[] = {
+	[0] = {
+		.start = (resource_size_t)USBH0_BASE,
+		.end   = (resource_size_t)USBH0_BASE + 0x5c,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = INT_USBH0,
+		.end   = INT_USBH0,
+		.flags = IORESOURCE_IRQ,
+	}
+};
+
+static struct resource tcc8k_ohci1_resources[] = {
+	[0] = {
+		.start = (resource_size_t)USBH1_BASE,
+		.end   = (resource_size_t)USBH1_BASE + 0x5c,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = INT_USBH1,
+		.end   = INT_USBH1,
+		.flags = IORESOURCE_IRQ,
+	}
+};
+
+static struct tccohci_platform_data tcc8k_ohci0_platform_data = {
+	.controller	= 0,
+	.port_mode	= PMM_PERPORT_MODE,
+	.init		= tcc8k_ohci_init,
+};
+
+static struct tccohci_platform_data tcc8k_ohci1_platform_data = {
+	.controller	= 1,
+	.port_mode	= PMM_PERPORT_MODE,
+	.init		= tcc8k_ohci_init,
+};
+
+static struct platform_device ohci0_device = {
+	.name = "tcc-ohci",
+	.id = 0,
+	.dev = {
+		.dma_mask = &tcc8k_dmamask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
+		.platform_data = &tcc8k_ohci0_platform_data,
+	},
+	.num_resources  = ARRAY_SIZE(tcc8k_ohci0_resources),
+	.resource       = tcc8k_ohci0_resources,
+};
+
+static struct platform_device ohci1_device = {
+	.name = "tcc-ohci",
+	.id = 1,
+	.dev = {
+		.dma_mask = &tcc8k_dmamask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
+		.platform_data = &tcc8k_ohci1_platform_data,
+	},
+	.num_resources  = ARRAY_SIZE(tcc8k_ohci1_resources),
+	.resource       = tcc8k_ohci1_resources,
+};
+
+static void __init tcc8k_init_usbhost(void)
+{
+	platform_device_register(&ohci0_device);
+	platform_device_register(&ohci1_device);
+}
+#else
+static void __init tcc8k_init_usbhost(void) { }
+#endif
+
+/* USB device controller*/
+#ifdef CONFIG_USB_GADGET_TCC8K
+static struct resource udc_resources[] = {
+	[0] = {
+		.start = INT_USBD,
+		.end   = INT_USBD,
+		.flags = IORESOURCE_IRQ,
+	},
+	[1] = {
+		.start = INT_UDMA,
+		.end   = INT_UDMA,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device tcc8k_udc_device = {
+	.name = "tcc-udc",
+	.id = 0,
+	.resource = udc_resources,
+	.num_resources = ARRAY_SIZE(udc_resources),
+	.dev = {
+		 .dma_mask = &tcc8k_dmamask,
+		 .coherent_dma_mask = DMA_BIT_MASK(32),
+	},
+};
+
+static void __init tcc8k_init_usb_gadget(void)
+{
+	platform_device_register(&tcc8k_udc_device);
+}
+#else
+static void __init tcc8k_init_usb_gadget(void) { }
+#endif	/* CONFIG_USB_GADGET_TCC83X */
+
+static int __init tcc8k_init_devices(void)
+{
+	tcc8k_init_mmc();
+	tcc8k_init_usbhost();
+	tcc8k_init_usb_gadget();
+	return 0;
+}
+
+arch_initcall(tcc8k_init_devices);
-- 
1.6.3.3
