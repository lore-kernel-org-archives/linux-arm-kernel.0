From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  4 Mar 2015 20:33:00 +0100
Subject: [RFC PATCH 06/18] ARM: msm: fix mach/msm_iomap.h inclusions
In-Reply-To: <1425497592-1831064-1-git-send-email-arnd@arndb.de>
References: <1425497592-1831064-1-git-send-email-arnd@arndb.de>
Message-ID: <1425497592-1831064-7-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mach/msm_iomap.h header is broken for files that need to
be built for multiple SoCs, because it includes mutually
exclusive headers for each variant.

This removes the #ifdef and the multiplexer and includes the
correct files in all places directly. To do this, we also have
to split up the io.c file and move the contents into the per-soc
files.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-msm/Makefile                      |   4 -
 arch/arm/mach-msm/board-halibut.c               |   2 +-
 arch/arm/mach-msm/board-msm7x30.c               |   2 +-
 arch/arm/mach-msm/board-trout.c                 |   2 +-
 arch/arm/mach-msm/devices-msm7x00.c             |  58 ++++++++
 arch/arm/mach-msm/devices-msm7x30.c             |  31 +++-
 arch/arm/mach-msm/devices-qsd8x50.c             |  48 +++++++
 arch/arm/mach-msm/include/mach/msm_iomap-7x00.h |   2 -
 arch/arm/mach-msm/include/mach/msm_iomap-7x30.h |   2 -
 arch/arm/mach-msm/include/mach/msm_iomap-8x50.h |   1 -
 arch/arm/mach-msm/include/mach/msm_iomap.h      |  24 ++--
 arch/arm/mach-msm/io.c                          | 182 ------------------------
 12 files changed, 154 insertions(+), 204 deletions(-)
 delete mode 100644 arch/arm/mach-msm/io.c

diff --git a/arch/arm/mach-msm/Makefile b/arch/arm/mach-msm/Makefile
index 2fb46dc0ead8..bab22a179c47 100644
--- a/arch/arm/mach-msm/Makefile
+++ b/arch/arm/mach-msm/Makefile
@@ -7,10 +7,6 @@ obj-$(CONFIG_ARCH_QSD8X50) += sirc.o
 
 obj-$(CONFIG_MSM_PROC_COMM) += proc_comm.o clock-pcom.o vreg.o
 
-obj-$(CONFIG_ARCH_MSM7X00A) += io.o
-obj-$(CONFIG_ARCH_MSM7X30) += io.o
-obj-$(CONFIG_ARCH_QSD8X50) += io.o
-
 obj-$(CONFIG_MSM_SMD) += smd.o smd_debug.o
 obj-$(CONFIG_MSM_SMD) += last_radio_log.o
 
diff --git a/arch/arm/mach-msm/board-halibut.c b/arch/arm/mach-msm/board-halibut.c
index 61bfe584a9d7..1b62427ad5ed 100644
--- a/arch/arm/mach-msm/board-halibut.c
+++ b/arch/arm/mach-msm/board-halibut.c
@@ -29,7 +29,7 @@
 #include <asm/setup.h>
 
 #include <mach/irqs.h>
-#include <mach/msm_iomap.h>
+#include <mach/msm_iomap-7x00.h>
 
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
diff --git a/arch/arm/mach-msm/board-msm7x30.c b/arch/arm/mach-msm/board-msm7x30.c
index 44a5bdbf0ee7..e19109f69096 100644
--- a/arch/arm/mach-msm/board-msm7x30.c
+++ b/arch/arm/mach-msm/board-msm7x30.c
@@ -31,7 +31,7 @@
 #include <asm/setup.h>
 
 #include <mach/clk.h>
-#include <mach/msm_iomap.h>
+#include <mach/msm_iomap-7x30.h>
 
 #include <mach/vreg.h>
 #include "devices.h"
diff --git a/arch/arm/mach-msm/board-trout.c b/arch/arm/mach-msm/board-trout.c
index ba3edd3a46cb..7c1b06fa9a76 100644
--- a/arch/arm/mach-msm/board-trout.c
+++ b/arch/arm/mach-msm/board-trout.c
@@ -28,7 +28,7 @@
 #include <asm/setup.h>
 
 #include <mach/hardware.h>
-#include <mach/msm_iomap.h>
+#include <mach/msm_iomap-7x00.h>
 
 #include "devices.h"
 #include "board-trout.h"
diff --git a/arch/arm/mach-msm/devices-msm7x00.c b/arch/arm/mach-msm/devices-msm7x00.c
index aa3feeb96414..dc0ea895568b 100644
--- a/arch/arm/mach-msm/devices-msm7x00.c
+++ b/arch/arm/mach-msm/devices-msm7x00.c
@@ -16,9 +16,11 @@
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/clkdev.h>
+#include <asm/mach/map.h>
 
 #include <mach/irqs.h>
 #include <mach/msm_iomap.h>
+#include <mach/msm_iomap-7x00.h>
 #include "devices.h"
 
 #include <asm/mach/flash.h>
@@ -29,6 +31,62 @@
 #include "clock-pcom.h"
 #include <linux/platform_data/mmc-msm_sdcc.h>
 
+static struct map_desc msm_io_desc[] __initdata = {
+	MSM_DEVICE_TYPE(VIC, MT_DEVICE_NONSHARED),
+	MSM_CHIP_DEVICE_TYPE(CSR, MSM7X00, MT_DEVICE_NONSHARED),
+	MSM_DEVICE_TYPE(DMOV, MT_DEVICE_NONSHARED),
+	MSM_CHIP_DEVICE_TYPE(GPIO1, MSM7X00, MT_DEVICE_NONSHARED),
+	MSM_CHIP_DEVICE_TYPE(GPIO2, MSM7X00, MT_DEVICE_NONSHARED),
+	MSM_DEVICE_TYPE(CLK_CTL, MT_DEVICE_NONSHARED),
+	{
+		.virtual =  (unsigned long) MSM_SHARED_RAM_BASE,
+		.pfn = __phys_to_pfn(MSM_SHARED_RAM_PHYS),
+		.length =   MSM_SHARED_RAM_SIZE,
+		.type =     MT_DEVICE,
+	},
+#if defined(CONFIG_DEBUG_MSM_UART)
+	{
+		/* Must be last: virtual and pfn filled in by debug_ll_addr() */
+		.length = SZ_4K,
+		.type = MT_DEVICE_NONSHARED,
+	}
+#endif
+};
+
+void __init msm_map_common_io(void)
+{
+	size_t size = ARRAY_SIZE(msm_io_desc);
+
+	/* Make sure the peripheral register window is closed, since
+	 * we will use PTE flags (TEX[1]=1,B=0,C=1) to determine which
+	 * pages are peripheral interface or not.
+	 */
+	asm("mcr p15, 0, %0, c15, c2, 4" : : "r" (0));
+#if defined(CONFIG_DEBUG_MSM_UART)
+#ifdef CONFIG_MMU
+	debug_ll_addr(&msm_io_desc[size - 1].pfn,
+		      &msm_io_desc[size - 1].virtual);
+#endif
+	msm_io_desc[size - 1].pfn = __phys_to_pfn(msm_io_desc[size - 1].pfn);
+#endif
+	iotable_init(msm_io_desc, size);
+}
+
+void __iomem *__msm_ioremap_caller(phys_addr_t phys_addr, size_t size,
+				   unsigned int mtype, void *caller)
+{
+	if (mtype == MT_DEVICE) {
+		/* The peripherals in the 88000000 - D0000000 range
+		 * are only accessible by type MT_DEVICE_NONSHARED.
+		 * Adjust mtype as necessary to make this "just work."
+		 */
+		if ((phys_addr >= 0x88000000) && (phys_addr < 0xD0000000))
+			mtype = MT_DEVICE_NONSHARED;
+	}
+
+	return __arm_ioremap_caller(phys_addr, size, mtype, caller);
+}
+
 static struct resource msm_gpio_resources[] = {
 	{
 		.start	= 32 + 0,
diff --git a/arch/arm/mach-msm/devices-msm7x30.c b/arch/arm/mach-msm/devices-msm7x30.c
index 5a0705b55321..824e0d86b93f 100644
--- a/arch/arm/mach-msm/devices-msm7x30.c
+++ b/arch/arm/mach-msm/devices-msm7x30.c
@@ -18,8 +18,9 @@
 
 #include <linux/dma-mapping.h>
 #include <linux/clkdev.h>
+#include <asm/mach/map.h>
 #include <mach/irqs.h>
-#include <mach/msm_iomap.h>
+#include <mach/msm_iomap-7x30.h>
 
 #include "devices.h"
 #include "smd_private.h"
@@ -32,6 +33,34 @@
 
 #include <linux/platform_data/mmc-msm_sdcc.h>
 
+static struct map_desc msm7x30_io_desc[] __initdata = {
+	MSM_DEVICE(VIC),
+	MSM_CHIP_DEVICE(CSR, MSM7X30),
+	MSM_DEVICE(DMOV),
+	MSM_CHIP_DEVICE(GPIO1, MSM7X30),
+	MSM_CHIP_DEVICE(GPIO2, MSM7X30),
+	MSM_DEVICE(CLK_CTL),
+	MSM_DEVICE(CLK_CTL_SH2),
+	MSM_DEVICE(AD5),
+	MSM_DEVICE(MDC),
+	MSM_DEVICE(ACC),
+	MSM_DEVICE(SAW),
+	MSM_DEVICE(GCC),
+	MSM_DEVICE(TCSR),
+	{
+		.virtual =  (unsigned long) MSM_SHARED_RAM_BASE,
+		.pfn = __phys_to_pfn(MSM_SHARED_RAM_PHYS),
+		.length =   MSM_SHARED_RAM_SIZE,
+		.type =     MT_DEVICE,
+	},
+};
+
+void __init msm_map_msm7x30_io(void)
+{
+	debug_ll_io_init();
+	iotable_init(msm7x30_io_desc, ARRAY_SIZE(msm7x30_io_desc));
+}
+
 static struct resource msm_gpio_resources[] = {
 	{
 		.start	= 32 + 18,
diff --git a/arch/arm/mach-msm/devices-qsd8x50.c b/arch/arm/mach-msm/devices-qsd8x50.c
index 6db025cef825..f80a8efee126 100644
--- a/arch/arm/mach-msm/devices-qsd8x50.c
+++ b/arch/arm/mach-msm/devices-qsd8x50.c
@@ -17,9 +17,11 @@
 #include <linux/platform_device.h>
 #include <linux/clkdev.h>
 #include <linux/dma-mapping.h>
+#include <asm/mach/map.h>
 
 #include <mach/irqs.h>
 #include <mach/msm_iomap.h>
+#include <mach/msm_iomap-8x50.h>
 
 #include "devices.h"
 #include "common.h"
@@ -30,6 +32,52 @@
 #include "clock.h"
 #include "clock-pcom.h"
 
+static struct map_desc qsd8x50_io_desc[] __initdata = {
+	MSM_DEVICE(VIC),
+	MSM_CHIP_DEVICE(CSR, QSD8X50),
+	MSM_DEVICE(DMOV),
+	MSM_CHIP_DEVICE(GPIO1, QSD8X50),
+	MSM_CHIP_DEVICE(GPIO2, QSD8X50),
+	MSM_DEVICE(CLK_CTL),
+	MSM_DEVICE(SIRC),
+	MSM_DEVICE(SCPLL),
+	MSM_DEVICE(AD5),
+	MSM_DEVICE(MDC),
+};
+
+static struct map_desc qsd8x50_io_desc_rev_other[] __initdata = {
+	{
+		.virtual =  (unsigned long) MSM_SHARED_RAM_BASE,
+		.pfn = __phys_to_pfn(MSM_SHARED_RAM_PHYS_REV_OTHER),
+		.length =   MSM_SHARED_RAM_SIZE,
+		.type =     MT_DEVICE,
+	},
+};
+
+void __init msm_map_qsd8x50_io(void)
+{
+	debug_ll_io_init();
+	iotable_init(qsd8x50_io_desc, ARRAY_SIZE(qsd8x50_io_desc));
+	iotable_init(qsd8x50_io_desc_rev_other, ARRAY_SIZE(qsd8x50_io_desc_rev_other));
+}
+#ifdef CONFIG_MSM_SOC_REV_A
+static struct map_desc qsd8x50_io_desc_rev_a[] __initdata = {
+	{
+		.virtual =  (unsigned long) MSM_SHARED_RAM_BASE,
+		.pfn = __phys_to_pfn(MSM_SHARED_RAM_PHYS_REV_A),
+		.length =   MSM_SHARED_RAM_SIZE,
+		.type =     MT_DEVICE,
+	},
+};
+
+void __init msm_map_qsd8x50_io_rev_a(void)
+{
+	debug_ll_io_init();
+	iotable_init(qsd8x50_io_desc, ARRAY_SIZE(qsd8x50_io_desc));
+	iotable_init(qsd8x50_io_desc_rev_a, ARRAY_SIZE(qsd8x50_io_desc_rev_a));
+}
+#endif /* CONFIG_MSM_SOC_REV_A */
+
 static struct resource msm_gpio_resources[] = {
 	{
 		.start	= 64 + 165 + 9,
diff --git a/arch/arm/mach-msm/include/mach/msm_iomap-7x00.h b/arch/arm/mach-msm/include/mach/msm_iomap-7x00.h
index 67dc0e98b958..27c7f5c0e708 100644
--- a/arch/arm/mach-msm/include/mach/msm_iomap-7x00.h
+++ b/arch/arm/mach-msm/include/mach/msm_iomap-7x00.h
@@ -38,7 +38,6 @@
  *
  */
 
-#define MSM_VIC_BASE          IOMEM(0xE0000000)
 #define MSM_VIC_PHYS          0xC0000000
 #define MSM_VIC_SIZE          SZ_4K
 
@@ -59,7 +58,6 @@
 #define MSM_CLK_CTL_PHYS      0xA8600000
 #define MSM_CLK_CTL_SIZE      SZ_4K
 
-#define MSM_SHARED_RAM_BASE   IOMEM(0xE0100000)
 #define MSM_SHARED_RAM_PHYS   0x01F00000
 #define MSM_SHARED_RAM_SIZE   SZ_1M
 
diff --git a/arch/arm/mach-msm/include/mach/msm_iomap-7x30.h b/arch/arm/mach-msm/include/mach/msm_iomap-7x30.h
index 198202c267c8..759a20a093c9 100644
--- a/arch/arm/mach-msm/include/mach/msm_iomap-7x30.h
+++ b/arch/arm/mach-msm/include/mach/msm_iomap-7x30.h
@@ -35,7 +35,6 @@
  *
  */
 
-#define MSM_VIC_BASE          IOMEM(0xE0000000)
 #define MSM_VIC_PHYS          0xC0080000
 #define MSM_VIC_SIZE          SZ_4K
 
@@ -76,7 +75,6 @@
 #define MSM_TCSR_PHYS	      0xAB600000
 #define MSM_TCSR_SIZE	      SZ_4K
 
-#define MSM_SHARED_RAM_BASE   IOMEM(0xE0100000)
 #define MSM_SHARED_RAM_PHYS   0x00100000
 #define MSM_SHARED_RAM_SIZE   SZ_1M
 
diff --git a/arch/arm/mach-msm/include/mach/msm_iomap-8x50.h b/arch/arm/mach-msm/include/mach/msm_iomap-8x50.h
index f9f4a9ccb747..f7b7f44341f5 100644
--- a/arch/arm/mach-msm/include/mach/msm_iomap-8x50.h
+++ b/arch/arm/mach-msm/include/mach/msm_iomap-8x50.h
@@ -35,7 +35,6 @@
  *
  */
 
-#define MSM_VIC_BASE          IOMEM(0xE0000000)
 #define MSM_VIC_PHYS          0xAC000000
 #define MSM_VIC_SIZE          SZ_4K
 
diff --git a/arch/arm/mach-msm/include/mach/msm_iomap.h b/arch/arm/mach-msm/include/mach/msm_iomap.h
index 0e4f49157684..5f3c43e417dd 100644
--- a/arch/arm/mach-msm/include/mach/msm_iomap.h
+++ b/arch/arm/mach-msm/include/mach/msm_iomap.h
@@ -25,6 +25,19 @@
 
 #include <asm/sizes.h>
 
+#define MSM_CHIP_DEVICE_TYPE(name, chip, mem_type) {			      \
+		.virtual = (unsigned long) MSM_##name##_BASE, \
+		.pfn = __phys_to_pfn(chip##_##name##_PHYS), \
+		.length = chip##_##name##_SIZE, \
+		.type = mem_type, \
+	 }
+
+#define MSM_DEVICE_TYPE(name, mem_type) \
+		MSM_CHIP_DEVICE_TYPE(name, MSM, mem_type)
+#define MSM_CHIP_DEVICE(name, chip) \
+		MSM_CHIP_DEVICE_TYPE(name, chip, MT_DEVICE)
+#define MSM_DEVICE(name) MSM_CHIP_DEVICE(name, MSM)
+
 /* Physical base address and size of peripherals.
  * Ordered by the virtual base addresses they will be mapped at.
  *
@@ -37,17 +50,10 @@
  *
  */
 
-#if defined(CONFIG_ARCH_MSM7X30)
-#include "msm_iomap-7x30.h"
-#elif defined(CONFIG_ARCH_QSD8X50)
-#include "msm_iomap-8x50.h"
-#else
-#include "msm_iomap-7x00.h"
-#endif
-
 /* Virtual addresses shared across all MSM targets. */
+#define MSM_VIC_BASE		IOMEM(0xE0000000)
 #define MSM_CSR_BASE		IOMEM(0xE0001000)
 #define MSM_GPIO1_BASE		IOMEM(0xE0003000)
 #define MSM_GPIO2_BASE		IOMEM(0xE0004000)
-
+#define MSM_SHARED_RAM_BASE	IOMEM(0xE0100000)
 #endif
diff --git a/arch/arm/mach-msm/io.c b/arch/arm/mach-msm/io.c
deleted file mode 100644
index ea7dc16fbb13..000000000000
--- a/arch/arm/mach-msm/io.c
+++ /dev/null
@@ -1,182 +0,0 @@
-/* arch/arm/mach-msm/io.c
- *
- * MSM7K, QSD io support
- *
- * Copyright (C) 2007 Google, Inc.
- * Copyright (c) 2008-2011, Code Aurora Forum. All rights reserved.
- * Author: Brian Swetland <swetland@google.com>
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-
-#include <linux/kernel.h>
-#include <linux/bug.h>
-#include <linux/init.h>
-#include <linux/io.h>
-#include <linux/export.h>
-
-#include <mach/hardware.h>
-#include <asm/page.h>
-#include <mach/msm_iomap.h>
-#include <asm/mach/map.h>
-
-#include "common.h"
-
-#define MSM_CHIP_DEVICE_TYPE(name, chip, mem_type) {			      \
-		.virtual = (unsigned long) MSM_##name##_BASE, \
-		.pfn = __phys_to_pfn(chip##_##name##_PHYS), \
-		.length = chip##_##name##_SIZE, \
-		.type = mem_type, \
-	 }
-
-#define MSM_DEVICE_TYPE(name, mem_type) \
-		MSM_CHIP_DEVICE_TYPE(name, MSM, mem_type)
-#define MSM_CHIP_DEVICE(name, chip) \
-		MSM_CHIP_DEVICE_TYPE(name, chip, MT_DEVICE)
-#define MSM_DEVICE(name) MSM_CHIP_DEVICE(name, MSM)
-
-#if defined(CONFIG_ARCH_MSM7X00A)
-static struct map_desc msm_io_desc[] __initdata = {
-	MSM_DEVICE_TYPE(VIC, MT_DEVICE_NONSHARED),
-	MSM_CHIP_DEVICE_TYPE(CSR, MSM7X00, MT_DEVICE_NONSHARED),
-	MSM_DEVICE_TYPE(DMOV, MT_DEVICE_NONSHARED),
-	MSM_CHIP_DEVICE_TYPE(GPIO1, MSM7X00, MT_DEVICE_NONSHARED),
-	MSM_CHIP_DEVICE_TYPE(GPIO2, MSM7X00, MT_DEVICE_NONSHARED),
-	MSM_DEVICE_TYPE(CLK_CTL, MT_DEVICE_NONSHARED),
-	{
-		.virtual =  (unsigned long) MSM_SHARED_RAM_BASE,
-		.pfn = __phys_to_pfn(MSM_SHARED_RAM_PHYS),
-		.length =   MSM_SHARED_RAM_SIZE,
-		.type =     MT_DEVICE,
-	},
-#if defined(CONFIG_DEBUG_MSM_UART)
-	{
-		/* Must be last: virtual and pfn filled in by debug_ll_addr() */
-		.length = SZ_4K,
-		.type = MT_DEVICE_NONSHARED,
-	}
-#endif
-};
-
-void __init msm_map_common_io(void)
-{
-	size_t size = ARRAY_SIZE(msm_io_desc);
-
-	/* Make sure the peripheral register window is closed, since
-	 * we will use PTE flags (TEX[1]=1,B=0,C=1) to determine which
-	 * pages are peripheral interface or not.
-	 */
-	asm("mcr p15, 0, %0, c15, c2, 4" : : "r" (0));
-#if defined(CONFIG_DEBUG_MSM_UART)
-#ifdef CONFIG_MMU
-	debug_ll_addr(&msm_io_desc[size - 1].pfn,
-		      &msm_io_desc[size - 1].virtual);
-#endif
-	msm_io_desc[size - 1].pfn = __phys_to_pfn(msm_io_desc[size - 1].pfn);
-#endif
-	iotable_init(msm_io_desc, size);
-}
-#endif
-
-#ifdef CONFIG_ARCH_QSD8X50
-static struct map_desc qsd8x50_io_desc[] __initdata = {
-	MSM_DEVICE(VIC),
-	MSM_CHIP_DEVICE(CSR, QSD8X50),
-	MSM_DEVICE(DMOV),
-	MSM_CHIP_DEVICE(GPIO1, QSD8X50),
-	MSM_CHIP_DEVICE(GPIO2, QSD8X50),
-	MSM_DEVICE(CLK_CTL),
-	MSM_DEVICE(SIRC),
-	MSM_DEVICE(SCPLL),
-	MSM_DEVICE(AD5),
-	MSM_DEVICE(MDC),
-};
-
-static struct map_desc qsd8x50_io_desc_rev_other[] __initdata = {
-	{
-		.virtual =  (unsigned long) MSM_SHARED_RAM_BASE,
-		.pfn = __phys_to_pfn(MSM_SHARED_RAM_PHYS_REV_OTHER),
-		.length =   MSM_SHARED_RAM_SIZE,
-		.type =     MT_DEVICE,
-	},
-};
-
-void __init msm_map_qsd8x50_io(void)
-{
-	debug_ll_io_init();
-	iotable_init(qsd8x50_io_desc, ARRAY_SIZE(qsd8x50_io_desc));
-	iotable_init(qsd8x50_io_desc_rev_other, ARRAY_SIZE(qsd8x50_io_desc_rev_other));
-}
-#ifdef CONFIG_MSM_SOC_REV_A
-static struct map_desc qsd8x50_io_desc_rev_a[] __initdata = {
-	{
-		.virtual =  (unsigned long) MSM_SHARED_RAM_BASE,
-		.pfn = __phys_to_pfn(MSM_SHARED_RAM_PHYS_REV_A),
-		.length =   MSM_SHARED_RAM_SIZE,
-		.type =     MT_DEVICE,
-	},
-};
-
-void __init msm_map_qsd8x50_io_rev_a(void)
-{
-	debug_ll_io_init();
-	iotable_init(qsd8x50_io_desc, ARRAY_SIZE(qsd8x50_io_desc));
-	iotable_init(qsd8x50_io_desc_rev_a, ARRAY_SIZE(qsd8x50_io_desc_rev_a));
-}
-#endif /* CONFIG_MSM_SOC_REV_A */
-#endif /* CONFIG_ARCH_QSD8X50 */
-
-#ifdef CONFIG_ARCH_MSM7X30
-static struct map_desc msm7x30_io_desc[] __initdata = {
-	MSM_DEVICE(VIC),
-	MSM_CHIP_DEVICE(CSR, MSM7X30),
-	MSM_DEVICE(DMOV),
-	MSM_CHIP_DEVICE(GPIO1, MSM7X30),
-	MSM_CHIP_DEVICE(GPIO2, MSM7X30),
-	MSM_DEVICE(CLK_CTL),
-	MSM_DEVICE(CLK_CTL_SH2),
-	MSM_DEVICE(AD5),
-	MSM_DEVICE(MDC),
-	MSM_DEVICE(ACC),
-	MSM_DEVICE(SAW),
-	MSM_DEVICE(GCC),
-	MSM_DEVICE(TCSR),
-	{
-		.virtual =  (unsigned long) MSM_SHARED_RAM_BASE,
-		.pfn = __phys_to_pfn(MSM_SHARED_RAM_PHYS),
-		.length =   MSM_SHARED_RAM_SIZE,
-		.type =     MT_DEVICE,
-	},
-};
-
-void __init msm_map_msm7x30_io(void)
-{
-	debug_ll_io_init();
-	iotable_init(msm7x30_io_desc, ARRAY_SIZE(msm7x30_io_desc));
-}
-#endif /* CONFIG_ARCH_MSM7X30 */
-
-#ifdef CONFIG_ARCH_MSM7X00A
-void __iomem *__msm_ioremap_caller(phys_addr_t phys_addr, size_t size,
-				   unsigned int mtype, void *caller)
-{
-	if (mtype == MT_DEVICE) {
-		/* The peripherals in the 88000000 - D0000000 range
-		 * are only accessible by type MT_DEVICE_NONSHARED.
-		 * Adjust mtype as necessary to make this "just work."
-		 */
-		if ((phys_addr >= 0x88000000) && (phys_addr < 0xD0000000))
-			mtype = MT_DEVICE_NONSHARED;
-	}
-
-	return __arm_ioremap_caller(phys_addr, size, mtype, caller);
-}
-#endif
-- 
2.1.0.rc2
