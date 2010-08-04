From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  4 Aug 2010 19:24:51 +0200
Subject: [PATCH 4/5] arm/realview: enable PCI for realview-eb and
	realview-pb1176
In-Reply-To: <1280942692-32079-1-git-send-email-arnd@arndb.de>
References: <1280942692-32079-1-git-send-email-arnd@arndb.de>
Message-ID: <1280942692-32079-5-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These two boards use the Xilinx PCI macro, so enable the
code and set up all the I/O windows for it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig                               |    2 +-
 arch/arm/mach-realview/include/mach/hardware.h |   14 +++++-
 arch/arm/mach-realview/include/mach/io.h       |    6 ++-
 arch/arm/mach-realview/include/mach/platform.h |   23 +++++----
 arch/arm/mach-realview/realview_eb.c           |   70 +++++++++++++++++++++++-
 arch/arm/mach-realview/realview_pb1176.c       |   68 +++++++++++++++++++++++
 arch/arm/plat-versatile/xilinx-pci.c           |    1 +
 7 files changed, 169 insertions(+), 15 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ddbcaf2..dd452ee 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1060,7 +1060,7 @@ config ISA_DMA_API
 	bool
 
 config PCI
-	bool "PCI support" if ARCH_INTEGRATOR_AP || ARCH_VERSATILE_PB || ARCH_IXP4XX || ARCH_KS8695 || MACH_ARMCORE
+	bool "PCI support" if ARCH_INTEGRATOR_AP || ARCH_VERSATILE_PB || ARCH_IXP4XX || ARCH_KS8695 || MACH_ARMCORE || ARCH_REALVIEW
 	help
 	  Find out whether you have a PCI motherboard. PCI is the name of a
 	  bus system, i.e. the way the CPU talks to the other stuff inside
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
index f05bcdf..4fcb187 100644
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
+#define __io(a)		(a + PCIO_BASE)
 #define __mem_pci(a)	(a)
 
 #endif
diff --git a/arch/arm/mach-realview/include/mach/platform.h b/arch/arm/mach-realview/include/mach/platform.h
index 1b77a27..f5a777b 100644
--- a/arch/arm/mach-realview/include/mach/platform.h
+++ b/arch/arm/mach-realview/include/mach/platform.h
@@ -172,20 +172,23 @@
 #define REALVIEW_GPIO1_BASE           0x10014000	/* GPIO port 1 */
 #define REALVIEW_GPIO2_BASE           0x10015000	/* GPIO port 2 */
 #define REALVIEW_DMC_BASE             0x10018000	/* DMC configuration */
+#define REALVIEW_PCI_CORE_BASE	      0x10019000	/* PCI map and control */
 #define REALVIEW_DMAC_BASE            0x10030000	/* DMA controller */
 
 /* PCI space */
-#define REALVIEW_PCI_BASE             0x41000000	/* PCI Interface */
-#define REALVIEW_PCI_CFG_BASE	      0x42000000
-#define REALVIEW_PCI_MEM_BASE0        0x44000000
-#define REALVIEW_PCI_MEM_BASE1        0x50000000
-#define REALVIEW_PCI_MEM_BASE2        0x60000000
+#define REALVIEW_PCI_BASE             0x61000000	/* PCI Interface */
+#define REALVIEW_PCI_CFG_BASE	      0x62000000
+#define REALVIEW_PCI_IO_BASE	      0x63000000
+#define REALVIEW_PCI_MEM_BASE0        0x64000000
+#define REALVIEW_PCI_MEM_BASE1        0x68000000
+#define REALVIEW_PCI_MEM_BASE2        0x6C000000
 /* Sizes of above maps */
-#define REALVIEW_PCI_BASE_SIZE	       0x01000000
-#define REALVIEW_PCI_CFG_BASE_SIZE    0x02000000
-#define REALVIEW_PCI_MEM_BASE0_SIZE   0x0c000000	/* 32Mb */
-#define REALVIEW_PCI_MEM_BASE1_SIZE   0x10000000	/* 256Mb */
-#define REALVIEW_PCI_MEM_BASE2_SIZE   0x10000000	/* 256Mb */
+#define REALVIEW_PCI_BASE_SIZE	      0x01000000
+#define REALVIEW_PCI_CFG_BASE_SIZE    0x01000000
+#define REALVIEW_PCI_IO_BASE_SIZE     0x01000000
+#define REALVIEW_PCI_MEM_BASE0_SIZE   0x04000000	/* 64Mb */
+#define REALVIEW_PCI_MEM_BASE1_SIZE   0x04000000	/* 64Mb */
+#define REALVIEW_PCI_MEM_BASE2_SIZE   0x04000000	/* 64Mb */
 
 #define REALVIEW_SDRAM67_BASE         0x70000000	/* SDRAM banks 6 and 7 */
 #define REALVIEW_LT_BASE              0x80000000	/* Logic Tile expansion */
diff --git a/arch/arm/mach-realview/realview_eb.c b/arch/arm/mach-realview/realview_eb.c
index 991c1f8..7e59eae 100644
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
 
@@ -452,6 +476,49 @@ static void realview_eb_reset(char mode)
 		__raw_writel(0x0008, reset_ctrl);
 }
 
+#ifdef CONFIG_PCI_HOST_XILINX
+/*
+ * Realview/AB and /PB1136 use a the following base registers
+ *
+ * Usage Local Bus Memory         Base/Map registers used
+ *
+ * Mem   64000000 - 67FFFFFF      LB_BASE0/LB_MAP0,  non prefetch
+ * Mem   68000000 - 6BFFFFFF      LB_BASE1/LB_MAP1,  prefetch
+ * Mem   6C000000 - 6FFFFFFF      LB_BASE2/LB_MAP2
+ * IO    63000000 - 63FFFFFF      PCI IO
+ * Cfg   62000000 - 62FFFFFF	  PCI config
+ *
+ */
+#define __IO_ADDRESS(n) ((void __iomem *)(unsigned long)IO_ADDRESS(n))
+static struct xilinx_pci_data realview_eb_pci = {
+	.base		= REALVIEW_PCI_VIRT_BASE,
+	.cfg_base	= REALVIEW_PCI_CFG_VIRT_BASE,
+	.io_base	= PCIO_BASE,
+	.sys_pcictl	= __IO_ADDRESS(REALVIEW_SYS_PCICTL),
+	.core_base	= __IO_ADDRESS(REALVIEW_PCI_CORE_BASE),
+	.base_irq	= IRQ_EB_GIC_START + 48,
+
+	.mem_spaces	= {
+		{
+			.name	= "PCI",
+			.start	= REALVIEW_PCI_MEM_BASE0,
+			.end	= REALVIEW_PCI_MEM_BASE0+REALVIEW_PCI_MEM_BASE0_SIZE-1,
+			.flags	= IORESOURCE_MEM,
+		}, {
+			.name	= "PCI non-prefetchable",
+			.start	= REALVIEW_PCI_MEM_BASE1,
+			.end	= REALVIEW_PCI_MEM_BASE1+REALVIEW_PCI_MEM_BASE1_SIZE-1,
+			.flags	= IORESOURCE_MEM,
+		}, {
+			.name	= "PCI prefetchable",
+			.start	= REALVIEW_PCI_MEM_BASE2,
+			.end	= REALVIEW_PCI_MEM_BASE2+REALVIEW_PCI_MEM_BASE2_SIZE-1,
+			.flags	= IORESOURCE_MEM | IORESOURCE_PREFETCH,
+		},
+	},
+};
+#endif
+
 static void __init realview_eb_init(void)
 {
 	int i;
@@ -471,6 +538,7 @@ static void __init realview_eb_init(void)
 	platform_device_register(&realview_i2c_device);
 	platform_device_register(&char_lcd_device);
 	eth_device_register();
+	xilinx_pci_init(&realview_eb_pci);
 	realview_usb_register(realview_eb_isp1761_resources);
 
 	for (i = 0; i < ARRAY_SIZE(amba_devs); i++) {
diff --git a/arch/arm/mach-realview/realview_pb1176.c b/arch/arm/mach-realview/realview_pb1176.c
index d2be12e..583fd00 100644
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
+#endif
 };
 
 static void __init realview_pb1176_map_io(void)
@@ -348,6 +372,49 @@ static void realview_pb1176_fixup(struct machine_desc *mdesc,
 	meminfo->nr_banks = 1;
 }
 
+#ifdef CONFIG_PCI_HOST_XILINX
+/*
+ * Realview/AB and /PB1136 use a the following base registers
+ *
+ * Usage Local Bus Memory         Base/Map registers used
+ *
+ * Mem   64000000 - 67FFFFFF      LB_BASE0/LB_MAP0,  non prefetch
+ * Mem   68000000 - 6BFFFFFF      LB_BASE1/LB_MAP1,  prefetch
+ * Mem   6C000000 - 6FFFFFFF      LB_BASE2/LB_MAP2
+ * IO    63000000 - 63FFFFFF      PCI IO
+ * Cfg   62000000 - 62FFFFFF	  PCI config
+ *
+ */
+#define __IO_ADDRESS(n) ((void __iomem *)(unsigned long)IO_ADDRESS(n))
+static struct xilinx_pci_data realview_pb1176_pci = {
+	.base		= REALVIEW_PCI_VIRT_BASE,
+	.cfg_base	= REALVIEW_PCI_CFG_VIRT_BASE,
+	.io_base	= PCIO_BASE,
+	.sys_pcictl	= __IO_ADDRESS(REALVIEW_SYS_PCICTL),
+	.core_base	= __IO_ADDRESS(REALVIEW_PCI_CORE_BASE),
+	.base_irq	= IRQ_EB_GIC_START + 48,
+
+	.mem_spaces	= {
+		{
+			.name	= "PCI",
+			.start	= REALVIEW_PCI_MEM_BASE0,
+			.end	= REALVIEW_PCI_MEM_BASE0+REALVIEW_PCI_MEM_BASE0_SIZE-1,
+			.flags	= IORESOURCE_MEM,
+		}, {
+			.name	= "PCI non-prefetchable",
+			.start	= REALVIEW_PCI_MEM_BASE1,
+			.end	= REALVIEW_PCI_MEM_BASE1+REALVIEW_PCI_MEM_BASE1_SIZE-1,
+			.flags	= IORESOURCE_MEM,
+		}, {
+			.name	= "PCI prefetchable",
+			.start	= REALVIEW_PCI_MEM_BASE2,
+			.end	= REALVIEW_PCI_MEM_BASE2+REALVIEW_PCI_MEM_BASE2_SIZE-1,
+			.flags	= IORESOURCE_MEM | IORESOURCE_PREFETCH,
+		},
+	},
+};
+#endif
+
 static void __init realview_pb1176_init(void)
 {
 	int i;
@@ -364,6 +431,7 @@ static void __init realview_pb1176_init(void)
 	realview_usb_register(realview_pb1176_isp1761_resources);
 	platform_device_register(&pmu_device);
 	platform_device_register(&char_lcd_device);
+	xilinx_pci_init(&realview_pb1176_pci);
 
 	for (i = 0; i < ARRAY_SIZE(amba_devs); i++) {
 		struct amba_device *d = amba_devs[i];
diff --git a/arch/arm/plat-versatile/xilinx-pci.c b/arch/arm/plat-versatile/xilinx-pci.c
index 077d24a..e0b051c 100644
--- a/arch/arm/plat-versatile/xilinx-pci.c
+++ b/arch/arm/plat-versatile/xilinx-pci.c
@@ -23,6 +23,7 @@
 #include <linux/io.h>
 
 #include <mach/hardware.h>
+#include <mach/platform.h>
 #include <asm/irq.h>
 #include <asm/system.h>
 #include <asm/mach/pci.h>
-- 
1.7.1
