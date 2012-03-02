From: robherring2@gmail.com (Rob Herring)
Date: Thu,  1 Mar 2012 21:13:34 -0600
Subject: [PATCH v3 22/30] ARM: tegra: use fixed PCI i/o mapping
In-Reply-To: <1330658022-14559-1-git-send-email-robherring2@gmail.com>
References: <1330658022-14559-1-git-send-email-robherring2@gmail.com>
Message-ID: <1330658022-14559-23-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Colin Cross <ccross@android.com>
Cc: Olof Johansson <olof@lixom.net>
Acked-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/Kconfig                         |    1 -
 arch/arm/mach-tegra/include/mach/io.h    |   46 ------------------------------
 arch/arm/mach-tegra/include/mach/iomap.h |    3 ++
 arch/arm/mach-tegra/io.c                 |    2 +
 arch/arm/mach-tegra/pcie.c               |   41 ++------------------------
 5 files changed, 9 insertions(+), 84 deletions(-)
 delete mode 100644 arch/arm/mach-tegra/include/mach/io.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ae016cd..c98861f2 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -660,7 +660,6 @@ config ARCH_TEGRA
 	select HAVE_SCHED_CLOCK
 	select HAVE_SMP
 	select MIGHT_HAVE_CACHE_L2X0
-	select NEED_MACH_IO_H if PCI
 	select ARCH_HAS_CPUFREQ
 	help
 	  This enables support for NVIDIA Tegra based systems (Tegra APX,
diff --git a/arch/arm/mach-tegra/include/mach/io.h b/arch/arm/mach-tegra/include/mach/io.h
deleted file mode 100644
index fe700f9..0000000
--- a/arch/arm/mach-tegra/include/mach/io.h
+++ /dev/null
@@ -1,46 +0,0 @@
-/*
- * arch/arm/mach-tegra/include/mach/io.h
- *
- * Copyright (C) 2010 Google, Inc.
- *
- * Author:
- *	Colin Cross <ccross@google.com>
- *	Erik Gilling <konkers@google.com>
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
-#ifndef __MACH_TEGRA_IO_H
-#define __MACH_TEGRA_IO_H
-
-#define IO_SPACE_LIMIT 0xffff
-
-#ifndef __ASSEMBLER__
-
-#ifdef CONFIG_TEGRA_PCI
-extern void __iomem *tegra_pcie_io_base;
-
-static inline void __iomem *__io(unsigned long addr)
-{
-	return tegra_pcie_io_base + (addr & IO_SPACE_LIMIT);
-}
-#else
-static inline void __iomem *__io(unsigned long addr)
-{
-	return (void __iomem *)addr;
-}
-#endif
-
-#define __io(a)         __io(a)
-
-#endif
-
-#endif
diff --git a/arch/arm/mach-tegra/include/mach/iomap.h b/arch/arm/mach-tegra/include/mach/iomap.h
index 082b4d1..e2b700a 100644
--- a/arch/arm/mach-tegra/include/mach/iomap.h
+++ b/arch/arm/mach-tegra/include/mach/iomap.h
@@ -303,6 +303,9 @@
 #define IO_APB_VIRT	IOMEM(0xFE300000)
 #define IO_APB_SIZE	SZ_1M
 
+#define TEGRA_PCIE_BASE		0x80000000
+#define TEGRA_PCIE_IO_BASE	(TEGRA_PCIE_BASE + SZ_4M)
+
 #define IO_TO_VIRT_BETWEEN(p, st, sz)	((p) >= (st) && (p) < ((st) + (sz)))
 #define IO_TO_VIRT_XLATE(p, pst, vst)	(((p) - (pst) + (vst)))
 
diff --git a/arch/arm/mach-tegra/io.c b/arch/arm/mach-tegra/io.c
index 58b4baf..7a29e10 100644
--- a/arch/arm/mach-tegra/io.c
+++ b/arch/arm/mach-tegra/io.c
@@ -26,6 +26,7 @@
 
 #include <asm/page.h>
 #include <asm/mach/map.h>
+#include <asm/mach/pci.h>
 #include <mach/iomap.h>
 
 #include "board.h"
@@ -59,5 +60,6 @@ static struct map_desc tegra_io_desc[] __initdata = {
 
 void __init tegra_map_common_io(void)
 {
+	pci_map_io_single(TEGRA_PCIE_IO_BASE);
 	iotable_init(tegra_io_desc, ARRAY_SIZE(tegra_io_desc));
 }
diff --git a/arch/arm/mach-tegra/pcie.c b/arch/arm/mach-tegra/pcie.c
index af8b634..442af44 100644
--- a/arch/arm/mach-tegra/pcie.c
+++ b/arch/arm/mach-tegra/pcie.c
@@ -171,8 +171,6 @@ static void __iomem *reg_pmc_base = IO_ADDRESS(TEGRA_PMC_BASE);
  * 0x90000000 - 0x9fffffff - non-prefetchable memory
  * 0xa0000000 - 0xbfffffff - prefetchable memory
  */
-#define TEGRA_PCIE_BASE		0x80000000
-
 #define PCIE_REGS_SZ		SZ_16K
 #define PCIE_CFG_OFF		PCIE_REGS_SZ
 #define PCIE_CFG_SZ		SZ_1M
@@ -180,8 +178,6 @@ static void __iomem *reg_pmc_base = IO_ADDRESS(TEGRA_PMC_BASE);
 #define PCIE_EXT_CFG_SZ		SZ_1M
 #define PCIE_IOMAP_SZ		(PCIE_REGS_SZ + PCIE_CFG_SZ + PCIE_EXT_CFG_SZ)
 
-#define MMIO_BASE		(TEGRA_PCIE_BASE + SZ_4M)
-#define MMIO_SIZE		SZ_64K
 #define MEM_BASE_0		(TEGRA_PCIE_BASE + SZ_256M)
 #define MEM_SIZE_0		SZ_128M
 #define MEM_BASE_1		(MEM_BASE_0 + MEM_SIZE_0)
@@ -223,17 +219,7 @@ struct tegra_pcie_info {
 	struct clk		*pll_e;
 };
 
-static struct tegra_pcie_info tegra_pcie = {
-	.res_mmio = {
-		.name = "PCI IO",
-		.start = MMIO_BASE,
-		.end = MMIO_BASE + MMIO_SIZE - 1,
-		.flags = IORESOURCE_MEM,
-	},
-};
-
-void __iomem *tegra_pcie_io_base;
-EXPORT_SYMBOL(tegra_pcie_io_base);
+static struct tegra_pcie_info tegra_pcie;
 
 static inline void afi_writel(u32 value, unsigned long offset)
 {
@@ -542,8 +528,8 @@ static void tegra_pcie_setup_translations(void)
 
 	/* Bar 2: downstream IO bar */
 	fpci_bar = ((__u32)0xfdfc << 16);
-	size = MMIO_SIZE;
-	axi_address = MMIO_BASE;
+	size = SZ_64K;
+	axi_address = TEGRA_PCIE_IO_BASE;
 	afi_writel(axi_address, AFI_AXI_BAR2_START);
 	afi_writel(size >> 12, AFI_AXI_BAR2_SZ);
 	afi_writel(fpci_bar, AFI_FPCI_BAR2);
@@ -771,7 +757,6 @@ static void tegra_pcie_clocks_put(void)
 
 static int __init tegra_pcie_get_resources(void)
 {
-	struct resource *res_mmio = &tegra_pcie.res_mmio;
 	int err;
 
 	err = tegra_pcie_clocks_get();
@@ -793,34 +778,16 @@ static int __init tegra_pcie_get_resources(void)
 		goto err_map_reg;
 	}
 
-	err = request_resource(&iomem_resource, res_mmio);
-	if (err) {
-		pr_err("PCIE: Failed to request resources: %d\n", err);
-		goto err_req_io;
-	}
-
-	tegra_pcie_io_base = ioremap_nocache(res_mmio->start,
-					     resource_size(res_mmio));
-	if (tegra_pcie_io_base == NULL) {
-		pr_err("PCIE: Failed to map IO\n");
-		err = -ENOMEM;
-		goto err_map_io;
-	}
-
 	err = request_irq(INT_PCIE_INTR, tegra_pcie_isr,
 			  IRQF_SHARED, "PCIE", &tegra_pcie);
 	if (err) {
 		pr_err("PCIE: Failed to register IRQ: %d\n", err);
-		goto err_irq;
+		goto err_req_io;
 	}
 	set_irq_flags(INT_PCIE_INTR, IRQF_VALID);
 
 	return 0;
 
-err_irq:
-	iounmap(tegra_pcie_io_base);
-err_map_io:
-	release_resource(&tegra_pcie.res_mmio);
 err_req_io:
 	iounmap(tegra_pcie.regs);
 err_map_reg:
-- 
1.7.5.4
