From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Oct 2010 18:10:56 +0200
Subject: [PATCH 6/7] arm/realview: enable PCI for realview-eb and
	realview-pb1176
In-Reply-To: <1287072657-32477-1-git-send-email-arnd@arndb.de>
References: <1287072657-32477-1-git-send-email-arnd@arndb.de>
Message-ID: <1287072657-32477-7-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These two boards use the Xilinx PCI macro, so enable the
code and set up all the I/O windows for it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig                                   |    2 +-
 arch/arm/mach-realview/include/mach/board-eb.h     |   19 ++++
 arch/arm/mach-realview/include/mach/board-pb1176.h |    1 +
 arch/arm/mach-realview/include/mach/hardware.h     |   14 +++-
 arch/arm/mach-realview/include/mach/io.h           |    6 +-
 arch/arm/mach-realview/include/mach/irqs-eb.h      |    5 +
 arch/arm/mach-realview/include/mach/irqs-pb1176.h  |    5 +-
 arch/arm/mach-realview/realview_eb.c               |   84 ++++++++++++++++-
 arch/arm/mach-realview/realview_pb1176.c           |  102 ++++++++++++++++++++
 9 files changed, 232 insertions(+), 6 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5bf08c7..8533bbe 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1146,7 +1146,7 @@ config ISA_DMA_API
 	bool
 
 config PCI
-	bool "PCI support" if ARCH_INTEGRATOR_AP || ARCH_VERSATILE_PB || ARCH_IXP4XX || ARCH_KS8695 || MACH_ARMCORE || ARCH_CNS3XXX
+	bool "PCI support" if ARCH_INTEGRATOR_AP || ARCH_VERSATILE_PB || ARCH_IXP4XX || ARCH_KS8695 || MACH_ARMCORE || ARCH_CNS3XXX || ARCH_REALVIEW
 	help
 	  Find out whether you have a PCI motherboard. PCI is the name of a
 	  bus system, i.e. the way the CPU talks to the other stuff inside
diff --git a/arch/arm/mach-realview/include/mach/board-eb.h b/arch/arm/mach-realview/include/mach/board-eb.h
index 794a8d9..7510516 100644
--- a/arch/arm/mach-realview/include/mach/board-eb.h
+++ b/arch/arm/mach-realview/include/mach/board-eb.h
@@ -36,6 +36,7 @@
 #define REALVIEW_EB_TIMER2_3_BASE	0x10012000	/* Timer 2 and 3 */
 #define REALVIEW_EB_GPIO0_BASE		0x10013000	/* GPIO port 0 */
 #define REALVIEW_EB_RTC_BASE		0x10017000	/* Real Time Clock */
+#define REALVIEW_EB_PCI_CORE_BASE	0x10019000	/* PCI map and control */
 #define REALVIEW_EB_CLCD_BASE		0x10020000	/* CLCD */
 #define REALVIEW_EB_GIC_CPU_BASE	0x10040000	/* Generic interrupt controller CPU interface */
 #define REALVIEW_EB_GIC_DIST_BASE	0x10041000	/* Generic interrupt controller distributor */
@@ -63,6 +64,24 @@
 #endif
 
 /*
+ * PCI regions
+ */
+#define REALVIEW_EB_PCI_BASE		0x60000000 /* PCI self config */
+#define REALVIEW_EB_PCI_CFG_BASE	0x61000000 /* PCI config */
+#define REALVIEW_EB_PCI_IO_BASE0	0x62000000 /* PCI IO region */
+#define REALVIEW_EB_PCI_MEM_BASE0	0x63000000 /* Memory region 1 */
+#define REALVIEW_EB_PCI_MEM_BASE1	0x64000000 /* Memory region 2 */
+#define REALVIEW_EB_PCI_MEM_BASE2	0x68000000 /* Memory region 3 */
+
+#define REALVIEW_EB_PCI_BASE_SIZE	0x01000000 /* 16MB */
+#define REALVIEW_EB_PCI_CFG_BASE_SIZE	0x01000000 /* 16MB */
+#define REALVIEW_EB_PCI_IO_BASE0_SIZE	0x01000000 /* 16MB */
+#define REALVIEW_EB_PCI_MEM_BASE0_SIZE	0x01000000 /* 16MB */
+#define REALVIEW_EB_PCI_MEM_BASE1_SIZE	0x04000000 /* 64MB */
+#define REALVIEW_EB_PCI_MEM_BASE2_SIZE	0x08000000 /* 128MB */
+
+
+/*
  * Core tile identification (REALVIEW_SYS_PROCID)
  */
 #define REALVIEW_EB_PROC_MASK		0xFF000000
diff --git a/arch/arm/mach-realview/include/mach/board-pb1176.h b/arch/arm/mach-realview/include/mach/board-pb1176.h
index 002ab5d..b11a159 100644
--- a/arch/arm/mach-realview/include/mach/board-pb1176.h
+++ b/arch/arm/mach-realview/include/mach/board-pb1176.h
@@ -27,6 +27,7 @@
  * Peripheral addresses
  */
 #define REALVIEW_PB1176_UART4_BASE		0x10009000 /* UART 4 */
+#define REALVIEW_PB1176_PCI_CORE_BASE		0x10019000 /* PCI map and control */
 #define REALVIEW_PB1176_SCTL_BASE		0x10100000 /* System controller */
 #define REALVIEW_PB1176_SMC_BASE		0x10111000 /* SMC */
 #define REALVIEW_PB1176_DMC_BASE		0x10109000 /* DMC configuration */
diff --git a/arch/arm/mach-realview/include/mach/hardware.h b/arch/arm/mach-realview/include/mach/hardware.h
index 8a638d1..ff60011 100644
--- a/arch/arm/mach-realview/include/mach/hardware.h
+++ b/arch/arm/mach-realview/include/mach/hardware.h
@@ -37,6 +37,18 @@
 #else
 #define IO_ADDRESS(x)		(x)
 #endif
-#define __io_address(n)		__io(IO_ADDRESS(n))
+#define __io_address(n)		((void __iomem *)(IO_ADDRESS(n)))
+
+/*
+ * PCI space virtual addresses
+ */
+#define REALVIEW_PCI_VIRT_BASE		(void __iomem *)0xf8000000ul
+#define REALVIEW_PCI_CFG_VIRT_BASE	(void __iomem *)0xf9000000ul
+#define REALVIEW_PCI_IO_VIRT_BASE	(void __iomem *)PCIO_BASE
+
+#define PCIBIOS_MIN_IO			0x00001000
+#define PCIBIOS_MIN_MEM			0x00000000
+
+#define pcibios_assign_all_busses()     1
 
 #endif
diff --git a/arch/arm/mach-realview/include/mach/io.h b/arch/arm/mach-realview/include/mach/io.h
index f05bcdf..14304f9 100644
--- a/arch/arm/mach-realview/include/mach/io.h
+++ b/arch/arm/mach-realview/include/mach/io.h
@@ -20,9 +20,11 @@
 #ifndef __ASM_ARM_ARCH_IO_H
 #define __ASM_ARM_ARCH_IO_H
 
-#define IO_SPACE_LIMIT 0xffffffff
+#define PCIO_BASE	(void __iomem *)0xfa000000ul
+#define PCIO_SIZE	0x00100000ul
+#define IO_SPACE_LIMIT  (PCIO_SIZE - 1)
 
-#define __io(a)		__typesafe_io(a)
+#define __io(a)		((a) + PCIO_BASE)
 #define __mem_pci(a)	(a)
 
 #endif
diff --git a/arch/arm/mach-realview/include/mach/irqs-eb.h b/arch/arm/mach-realview/include/mach/irqs-eb.h
index 204d537..1511518 100644
--- a/arch/arm/mach-realview/include/mach/irqs-eb.h
+++ b/arch/arm/mach-realview/include/mach/irqs-eb.h
@@ -59,6 +59,11 @@
 #define IRQ_EB_TSPEN		(IRQ_EB_GIC_START + 30)		/* Touchscreen pen */
 #define IRQ_EB_TSKPAD		(IRQ_EB_GIC_START + 31)		/* Touchscreen keypad */
 
+#define IRQ_EB_PCI0		(IRQ_EB_GIC_START + 48)		/* PCI IntA */
+#define IRQ_EB_PCI1		(IRQ_EB_GIC_START + 49)		/* PCI IntB */
+#define IRQ_EB_PCI2		(IRQ_EB_GIC_START + 50)		/* PCI IntC */
+#define IRQ_EB_PCI3		(IRQ_EB_GIC_START + 51)		/* PCI IntD */
+
 /*
  * RealView EB + ARM11MPCore interrupt sources (primary GIC on the core tile)
  */
diff --git a/arch/arm/mach-realview/include/mach/irqs-pb1176.h b/arch/arm/mach-realview/include/mach/irqs-pb1176.h
index 5c3c625..cf92425 100644
--- a/arch/arm/mach-realview/include/mach/irqs-pb1176.h
+++ b/arch/arm/mach-realview/include/mach/irqs-pb1176.h
@@ -63,7 +63,10 @@
 #define IRQ_PB1176_GPIO2	(IRQ_PB1176_GIC_START + 9)
 #define IRQ_PB1176_ETH		(IRQ_PB1176_GIC_START + 10)	/* Ethernet controller */
 #define IRQ_PB1176_USB		(IRQ_PB1176_GIC_START + 11)	/* USB controller */
-
+#define IRQ_PB1176_PCI_INTA	(IRQ_PB1176_GIC_START + 12)	/* PCI IntA */
+#define IRQ_PB1176_PCI_INTB	(IRQ_PB1176_GIC_START + 13)	/* PCI IntB */
+#define IRQ_PB1176_PCI_INTC	(IRQ_PB1176_GIC_START + 14)	/* PCI IntC */
+#define IRQ_PB1176_PCI_INTD	(IRQ_PB1176_GIC_START + 15)	/* PCI IntD */
 #define IRQ_PB1176_PISMO	(IRQ_PB1176_GIC_START + 16)
 
 #define IRQ_PB1176_AACI		(IRQ_PB1176_GIC_START + 19)	/* Audio Codec */
diff --git a/arch/arm/mach-realview/realview_eb.c b/arch/arm/mach-realview/realview_eb.c
index 991c1f8..5e4e119 100644
--- a/arch/arm/mach-realview/realview_eb.c
+++ b/arch/arm/mach-realview/realview_eb.c
@@ -44,6 +44,7 @@
 
 #include <mach/board-eb.h>
 #include <mach/irqs.h>
+#include <plat/xilinx-pci.h>
 
 #include "core.h"
 
@@ -85,7 +86,30 @@ static struct map_desc realview_eb_io_desc[] __initdata = {
 		.pfn		= __phys_to_pfn(REALVIEW_EB_UART0_BASE),
 		.length		= SZ_4K,
 		.type		= MT_DEVICE,
-	}
+	},
+#endif
+#ifdef CONFIG_PCI
+	{
+		.virtual	= IO_ADDRESS(REALVIEW_PCI_CORE_BASE),
+		.pfn		= __phys_to_pfn(REALVIEW_PCI_CORE_BASE),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE
+	}, {
+		.virtual	=  (unsigned long)REALVIEW_PCI_VIRT_BASE,
+		.pfn		= __phys_to_pfn(REALVIEW_PCI_BASE),
+		.length		= REALVIEW_PCI_BASE_SIZE,
+		.type		= MT_DEVICE
+	}, {
+		.virtual	=  (unsigned long)REALVIEW_PCI_CFG_VIRT_BASE,
+		.pfn		= __phys_to_pfn(REALVIEW_PCI_CFG_BASE),
+		.length		= REALVIEW_PCI_CFG_BASE_SIZE,
+		.type		= MT_DEVICE
+	}, {
+		.virtual	=  (unsigned long)REALVIEW_PCI_IO_VIRT_BASE,
+		.pfn		= __phys_to_pfn(REALVIEW_PCI_IO_BASE),
+		.length		= REALVIEW_PCI_IO_BASE_SIZE,
+		.type		= MT_DEVICE
+	},
 #endif
 };
 
@@ -452,6 +476,63 @@ static void realview_eb_reset(char mode)
 		__raw_writel(0x0008, reset_ctrl);
 }
 
+#ifdef CONFIG_PCI_HOST_XILINX
+/*
+ * Realview/EB and /PB1176 use a the following base registers
+ *
+ * Usage Local Bus Memory         Base/Map registers used
+ *
+ * Self  60000000 - 60FFFFFF	  PCI selfconfig
+ * Cfg   61000000 - 61FFFFFF	  PCI config
+ * IO    62000000 - 62FFFFFF      PCI IO
+ * Mem   63000000 - 63FFFFFF      LB_BASE0/LB_MAP0,  unused
+ * Mem   64000000 - 67FFFFFF      LB_BASE1/LB_MAP1,  non-prefetch
+ * Mem   68000000 - 6FFFFFFF      LB_BASE2/LB_MAP2,  prefetch
+ */
+#define __IO_ADDRESS(n) ((void __iomem *)(unsigned long)IO_ADDRESS(n))
+static struct xilinx_pci_data realview_eb_pci = {
+	.base		= REALVIEW_PCI_VIRT_BASE,
+	.cfg_base	= REALVIEW_PCI_CFG_VIRT_BASE,
+	.io_base	= PCIO_BASE,
+	.sys_pcictl	= __IO_ADDRESS(REALVIEW_SYS_PCICTL),
+	.core_base	= __IO_ADDRESS(REALVIEW_EB_PCI_CORE_BASE),
+	.base_irq	= IRQ_EB_PCI0,
+	.irq_rotate	= 3, /* guessed, probably same as pb1176 */
+
+	/* This mapping is according to the Realview/EB user manual. */
+	.imap		= {
+		REALVIEW_EB_PCI_MEM_BASE0 & 0xff000000, /* 0x63000000 */
+		REALVIEW_EB_PCI_MEM_BASE1 & 0xfc000000, /* 0x64000000 */
+		REALVIEW_EB_PCI_MEM_BASE2 & 0xf8000000, /* 0x68000000 */
+	 },
+
+	.smap		= {
+		PHYS_OFFSET && 0xff000000, /* inbound memory BAR 0 */
+		PHYS_OFFSET && 0xff000000, /* inbound memory BAR 1 */
+		PHYS_OFFSET && 0xff000000, /* inbound IO BAR */
+	 },
+
+	.mem_spaces	= {
+		{
+			.name	= "PCI unused",
+			.start	= REALVIEW_EB_PCI_MEM_BASE0,
+			.end	= REALVIEW_EB_PCI_MEM_BASE0+REALVIEW_EB_PCI_MEM_BASE0_SIZE-1,
+			.flags	= IORESOURCE_MEM,
+		}, {
+			.name	= "PCI non-prefetchable",
+			.start	= REALVIEW_EB_PCI_MEM_BASE1,
+			.end	= REALVIEW_EB_PCI_MEM_BASE1+REALVIEW_EB_PCI_MEM_BASE1_SIZE-1,
+			.flags	= IORESOURCE_MEM,
+		}, {
+			.name	= "PCI prefetchable",
+			.start	= REALVIEW_EB_PCI_MEM_BASE2,
+			.end	= REALVIEW_EB_PCI_MEM_BASE2+REALVIEW_EB_PCI_MEM_BASE2_SIZE-1,
+			.flags	= IORESOURCE_MEM | IORESOURCE_PREFETCH,
+		},
+	},
+};
+#endif
+
 static void __init realview_eb_init(void)
 {
 	int i;
@@ -471,6 +552,7 @@ static void __init realview_eb_init(void)
 	platform_device_register(&realview_i2c_device);
 	platform_device_register(&char_lcd_device);
 	eth_device_register();
+	xilinx_pci_init(&realview_eb_pci);
 	realview_usb_register(realview_eb_isp1761_resources);
 
 	for (i = 0; i < ARRAY_SIZE(amba_devs); i++) {
diff --git a/arch/arm/mach-realview/realview_pb1176.c b/arch/arm/mach-realview/realview_pb1176.c
index d2be12e..5801102 100644
--- a/arch/arm/mach-realview/realview_pb1176.c
+++ b/arch/arm/mach-realview/realview_pb1176.c
@@ -44,6 +44,7 @@
 
 #include <mach/board-pb1176.h>
 #include <mach/irqs.h>
+#include <plat/xilinx-pci.h>
 
 #include "core.h"
 
@@ -102,6 +103,29 @@ static struct map_desc realview_pb1176_io_desc[] __initdata = {
 		.type		= MT_DEVICE,
 	},
 #endif
+#ifdef CONFIG_PCI
+	{
+		.virtual	= IO_ADDRESS(REALVIEW_PB1176_PCI_CORE_BASE),
+		.pfn		= __phys_to_pfn(REALVIEW_PB1176_PCI_CORE_BASE),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE
+	}, {
+		.virtual	=  (unsigned long)REALVIEW_PCI_VIRT_BASE,
+		.pfn		= __phys_to_pfn(REALVIEW_PB1176_PCI_BASE),
+		.length		= REALVIEW_PB1176_PCI_BASE_SIZE,
+		.type		= MT_DEVICE
+	}, {
+		.virtual	=  (unsigned long)REALVIEW_PCI_CFG_VIRT_BASE,
+		.pfn		= __phys_to_pfn(REALVIEW_PB1176_PCI_CFG_BASE),
+		.length		= REALVIEW_PB1176_PCI_CFG_BASE_SIZE,
+		.type		= MT_DEVICE
+	}, {
+		.virtual	=  (unsigned long)REALVIEW_PCI_IO_VIRT_BASE,
+		.pfn		= __phys_to_pfn(REALVIEW_PB1176_PCI_IO_BASE0),
+		.length		= REALVIEW_PB1176_PCI_IO_BASE0_SIZE,
+		.type		= MT_DEVICE
+	},
+#endif
 };
 
 static void __init realview_pb1176_map_io(void)
@@ -348,6 +372,83 @@ static void realview_pb1176_fixup(struct machine_desc *mdesc,
 	meminfo->nr_banks = 1;
 }
 
+#ifdef CONFIG_PCI_HOST_XILINX
+/*
+ * Realview/PB1176 uses the following base registers
+ *
+ * Usage Local Bus Memory         Base/Map registers used
+ *
+ * Self  60000000 - 60FFFFFF	  PCI selfconfig
+ * Cfg   61000000 - 61FFFFFF	  PCI config
+ * IO    62000000 - 62FFFFFF      PCI IO
+ * Mem   63000000 - 63FFFFFF      LB_BASE0/LB_MAP0,  unused
+ * Mem   64000000 - 67FFFFFF      LB_BASE1/LB_MAP1,  non-prefetch
+ * Mem   68000000 - 6FFFFFFF      LB_BASE2/LB_MAP2,  prefetch
+ *
+ */
+#define __IO_ADDRESS(n) ((void __iomem *)(unsigned long)IO_ADDRESS(n))
+static struct xilinx_pci_data realview_pb1176_pci = {
+	.base		= REALVIEW_PCI_VIRT_BASE,
+	.cfg_base	= REALVIEW_PCI_CFG_VIRT_BASE,
+	.io_base	= PCIO_BASE,
+	.sys_pcictl	= __IO_ADDRESS(REALVIEW_SYS_PCICTL),
+	.core_base	= __IO_ADDRESS(REALVIEW_PB1176_PCI_CORE_BASE),
+	.base_irq	= IRQ_PB1176_PCI_INTA,
+	.irq_rotate	= 3,
+#if 0
+	/*
+	 * This mapping is according to the PB1176 user manual but doesn't
+	 * seem to work.
+	 */
+	.imap		= {
+		REALVIEW_PB1176_PCI_MEM_BASE0 >> 24, /* 0x63000000 */
+		REALVIEW_PB1176_PCI_MEM_BASE1 >> 26, /* 0x64000000 */
+		REALVIEW_PB1176_PCI_MEM_BASE2 >> 27, /* 0x68000000 */
+	 },
+
+	.smap		= {
+		PHYS_OFFSET >> 24, /* inbound memory BAR 0 */
+		PHYS_OFFSET >> 24, /* inbound memory BAR 1 */
+		PHYS_OFFSET >> 24, /* inbound IO BAR */
+	 },
+#else
+	/*
+	 * This mapping is according to the Realview/EB user manual,
+	 * i.e. for another board, but apparently works to some degree.
+	 */
+	.imap		= {
+		REALVIEW_PB1176_PCI_MEM_BASE0 & 0xff000000, /* 0x63000000 */
+		REALVIEW_PB1176_PCI_MEM_BASE1 & 0xfc000000, /* 0x64000000 */
+		REALVIEW_PB1176_PCI_MEM_BASE2 & 0xf8000000, /* 0x68000000 */
+	 },
+
+	.smap		= {
+		PHYS_OFFSET && 0xff000000, /* inbound memory BAR 0 */
+		PHYS_OFFSET && 0xff000000, /* inbound memory BAR 1 */
+		PHYS_OFFSET && 0xff000000, /* inbound IO BAR */
+	 },
+#endif
+	.mem_spaces	= {
+		{
+			.name	= "PCI unused",
+			.start	= REALVIEW_PB1176_PCI_MEM_BASE0,
+			.end	= REALVIEW_PB1176_PCI_MEM_BASE0+REALVIEW_PB1176_PCI_MEM_BASE0_SIZE-1,
+			.flags	= IORESOURCE_MEM,
+		}, {
+			.name	= "PCI non-prefetchable",
+			.start	= REALVIEW_PB1176_PCI_MEM_BASE1,
+			.end	= REALVIEW_PB1176_PCI_MEM_BASE1+REALVIEW_PB1176_PCI_MEM_BASE1_SIZE-1,
+			.flags	= IORESOURCE_MEM,
+		}, {
+			.name	= "PCI prefetchable",
+			.start	= REALVIEW_PB1176_PCI_MEM_BASE2,
+			.end	= REALVIEW_PB1176_PCI_MEM_BASE2+REALVIEW_PB1176_PCI_MEM_BASE2_SIZE-1,
+			.flags	= IORESOURCE_MEM | IORESOURCE_PREFETCH,
+		},
+	},
+};
+#endif
+
 static void __init realview_pb1176_init(void)
 {
 	int i;
@@ -364,6 +465,7 @@ static void __init realview_pb1176_init(void)
 	realview_usb_register(realview_pb1176_isp1761_resources);
 	platform_device_register(&pmu_device);
 	platform_device_register(&char_lcd_device);
+	xilinx_pci_init(&realview_pb1176_pci);
 
 	for (i = 0; i < ARRAY_SIZE(amba_devs); i++) {
 		struct amba_device *d = amba_devs[i];
-- 
1.7.1
