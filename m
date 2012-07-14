From: robherring2@gmail.com (Rob Herring)
Date: Fri, 13 Jul 2012 21:04:00 -0500
Subject: [PATCH v2 04/15] ARM: tegra: use fixed PCI i/o mapping
In-Reply-To: <1342231451-28861-1-git-send-email-robherring2@gmail.com>
References: <1342231451-28861-1-git-send-email-robherring2@gmail.com>
Message-ID: <1342231451-28861-5-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Move tegra PCI to fixed i/o mapping and remove io.h.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Colin Cross <ccross@android.com>
Cc: Olof Johansson <olof@lixom.net>
Acked-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/Kconfig                         |    1 -
 arch/arm/mach-tegra/include/mach/io.h    |   46 ---------------
 arch/arm/mach-tegra/include/mach/iomap.h |    3 +
 arch/arm/mach-tegra/pcie.c               |   95 +++++++-----------------------
 4 files changed, 25 insertions(+), 120 deletions(-)
 delete mode 100644 arch/arm/mach-tegra/include/mach/io.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 8fb7e4a..ac446e3 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -644,7 +644,6 @@ config ARCH_TEGRA
 	select HAVE_CLK
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
index 7e76da7..fee3a94 100644
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
 
diff --git a/arch/arm/mach-tegra/pcie.c b/arch/arm/mach-tegra/pcie.c
index 0e09137..1ee7f5b 100644
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
@@ -204,10 +200,9 @@ struct tegra_pcie_port {
 
 	bool			link_up;
 
-	char			io_space_name[16];
 	char			mem_space_name[16];
 	char			prefetch_space_name[20];
-	struct resource		res[3];
+	struct resource		res[2];
 };
 
 struct tegra_pcie_info {
@@ -223,17 +218,7 @@ struct tegra_pcie_info {
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
@@ -391,24 +376,7 @@ static int tegra_pcie_setup(int nr, struct pci_sys_data *sys)
 	pp = tegra_pcie.port + nr;
 	pp->root_bus_nr = sys->busnr;
 
-	/*
-	 * IORESOURCE_IO
-	 */
-	snprintf(pp->io_space_name, sizeof(pp->io_space_name),
-		 "PCIe %d I/O", pp->index);
-	pp->io_space_name[sizeof(pp->io_space_name) - 1] = 0;
-	pp->res[0].name = pp->io_space_name;
-	if (pp->index == 0) {
-		pp->res[0].start = PCIBIOS_MIN_IO;
-		pp->res[0].end = pp->res[0].start + SZ_32K - 1;
-	} else {
-		pp->res[0].start = PCIBIOS_MIN_IO + SZ_32K;
-		pp->res[0].end = IO_SPACE_LIMIT;
-	}
-	pp->res[0].flags = IORESOURCE_IO;
-	if (request_resource(&ioport_resource, &pp->res[0]))
-		panic("Request PCIe IO resource failed\n");
-	pci_add_resource_offset(&sys->resources, &pp->res[0], sys->io_offset);
+	pci_ioremap_io(nr * SZ_64K, TEGRA_PCIE_IO_BASE);
 
 	/*
 	 * IORESOURCE_MEM
@@ -416,18 +384,18 @@ static int tegra_pcie_setup(int nr, struct pci_sys_data *sys)
 	snprintf(pp->mem_space_name, sizeof(pp->mem_space_name),
 		 "PCIe %d MEM", pp->index);
 	pp->mem_space_name[sizeof(pp->mem_space_name) - 1] = 0;
-	pp->res[1].name = pp->mem_space_name;
+	pp->res[0].name = pp->mem_space_name;
 	if (pp->index == 0) {
-		pp->res[1].start = MEM_BASE_0;
-		pp->res[1].end = pp->res[1].start + MEM_SIZE_0 - 1;
+		pp->res[0].start = MEM_BASE_0;
+		pp->res[0].end = pp->res[0].start + MEM_SIZE_0 - 1;
 	} else {
-		pp->res[1].start = MEM_BASE_1;
-		pp->res[1].end = pp->res[1].start + MEM_SIZE_1 - 1;
+		pp->res[0].start = MEM_BASE_1;
+		pp->res[0].end = pp->res[0].start + MEM_SIZE_1 - 1;
 	}
-	pp->res[1].flags = IORESOURCE_MEM;
-	if (request_resource(&iomem_resource, &pp->res[1]))
+	pp->res[0].flags = IORESOURCE_MEM;
+	if (request_resource(&iomem_resource, &pp->res[0]))
 		panic("Request PCIe Memory resource failed\n");
-	pci_add_resource_offset(&sys->resources, &pp->res[1], sys->mem_offset);
+	pci_add_resource_offset(&sys->resources, &pp->res[0], sys->mem_offset);
 
 	/*
 	 * IORESOURCE_MEM | IORESOURCE_PREFETCH
@@ -435,18 +403,18 @@ static int tegra_pcie_setup(int nr, struct pci_sys_data *sys)
 	snprintf(pp->prefetch_space_name, sizeof(pp->prefetch_space_name),
 		 "PCIe %d PREFETCH MEM", pp->index);
 	pp->prefetch_space_name[sizeof(pp->prefetch_space_name) - 1] = 0;
-	pp->res[2].name = pp->prefetch_space_name;
+	pp->res[1].name = pp->prefetch_space_name;
 	if (pp->index == 0) {
-		pp->res[2].start = PREFETCH_MEM_BASE_0;
-		pp->res[2].end = pp->res[2].start + PREFETCH_MEM_SIZE_0 - 1;
+		pp->res[1].start = PREFETCH_MEM_BASE_0;
+		pp->res[1].end = pp->res[2].start + PREFETCH_MEM_SIZE_0 - 1;
 	} else {
-		pp->res[2].start = PREFETCH_MEM_BASE_1;
-		pp->res[2].end = pp->res[2].start + PREFETCH_MEM_SIZE_1 - 1;
+		pp->res[1].start = PREFETCH_MEM_BASE_1;
+		pp->res[1].end = pp->res[1].start + PREFETCH_MEM_SIZE_1 - 1;
 	}
-	pp->res[2].flags = IORESOURCE_MEM | IORESOURCE_PREFETCH;
-	if (request_resource(&iomem_resource, &pp->res[2]))
+	pp->res[1].flags = IORESOURCE_MEM | IORESOURCE_PREFETCH;
+	if (request_resource(&iomem_resource, &pp->res[1]))
 		panic("Request PCIe Prefetch Memory resource failed\n");
-	pci_add_resource_offset(&sys->resources, &pp->res[2], sys->mem_offset);
+	pci_add_resource_offset(&sys->resources, &pp->res[1], sys->mem_offset);
 
 	return 1;
 }
@@ -541,8 +509,8 @@ static void tegra_pcie_setup_translations(void)
 
 	/* Bar 2: downstream IO bar */
 	fpci_bar = ((__u32)0xfdfc << 16);
-	size = MMIO_SIZE;
-	axi_address = MMIO_BASE;
+	size = SZ_128K;
+	axi_address = TEGRA_PCIE_IO_BASE;
 	afi_writel(axi_address, AFI_AXI_BAR2_START);
 	afi_writel(size >> 12, AFI_AXI_BAR2_SZ);
 	afi_writel(fpci_bar, AFI_FPCI_BAR2);
@@ -776,7 +744,6 @@ static void tegra_pcie_clocks_put(void)
 
 static int __init tegra_pcie_get_resources(void)
 {
-	struct resource *res_mmio = &tegra_pcie.res_mmio;
 	int err;
 
 	err = tegra_pcie_clocks_get();
@@ -798,34 +765,16 @@ static int __init tegra_pcie_get_resources(void)
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
1.7.9.5
