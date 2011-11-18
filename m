From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 18 Nov 2011 07:59:29 +0100
Subject: [PATCH 1/4] [orion] Consolidate the address map setup on Orion based
 platforms.
In-Reply-To: <1321599572-705-1-git-send-email-andrew@lunn.ch>
References: <1321599572-705-1-git-send-email-andrew@lunn.ch>
Message-ID: <1321599572-705-2-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Compile tested on Dove, orion5x, mv78xx0. Boot tested on Kirkwood.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/mach-dove/addr-map.c                |  113 +++++++-----------
 arch/arm/mach-kirkwood/addr-map.c            |  138 ++++++---------------
 arch/arm/mach-mv78xx0/addr-map.c             |  102 ++++-------------
 arch/arm/mach-orion5x/addr-map.c             |  146 ++++++++---------------
 arch/arm/mach-orion5x/common.c               |    7 +-
 arch/arm/mach-orion5x/common.h               |    2 +-
 arch/arm/mach-orion5x/include/mach/orion5x.h |    2 +-
 arch/arm/plat-orion/Makefile                 |    2 +-
 arch/arm/plat-orion/addr-map.c               |  166 ++++++++++++++++++++++++++
 arch/arm/plat-orion/include/plat/addr-map.h  |   52 ++++++++
 10 files changed, 375 insertions(+), 355 deletions(-)
 create mode 100644 arch/arm/plat-orion/addr-map.c
 create mode 100644 arch/arm/plat-orion/include/plat/addr-map.h

diff --git a/arch/arm/mach-dove/addr-map.c b/arch/arm/mach-dove/addr-map.c
index 00be4fc..1584726 100644
--- a/arch/arm/mach-dove/addr-map.c
+++ b/arch/arm/mach-dove/addr-map.c
@@ -14,6 +14,7 @@
 #include <linux/io.h>
 #include <asm/mach/arch.h>
 #include <asm/setup.h>
+#include <plat/addr-map.h>
 #include "common.h"
 
 /*
@@ -34,14 +35,6 @@
 #define ATTR_PCIE_MEM		0xe8
 #define ATTR_SCRATCHPAD		0x0
 
-/*
- * CPU Address Decode Windows registers
- */
-#define WIN_CTRL(n)	(BRIDGE_VIRT_BASE + ((n) << 4) + 0x0)
-#define WIN_BASE(n)	(BRIDGE_VIRT_BASE + ((n) << 4) + 0x4)
-#define WIN_REMAP_LO(n)	(BRIDGE_VIRT_BASE + ((n) << 4) + 0x8)
-#define WIN_REMAP_HI(n)	(BRIDGE_VIRT_BASE + ((n) << 4) + 0xc)
-
 struct mbus_dram_target_info dove_mbus_dram_info;
 
 static inline void __iomem *ddr_map_sc(int i)
@@ -49,78 +42,62 @@ static inline void __iomem *ddr_map_sc(int i)
 	return (void __iomem *)(DOVE_MC_VIRT_BASE + 0x100 + ((i) << 4));
 }
 
-static int cpu_win_can_remap(int win)
-{
-	if (win < 4)
-		return 1;
-
-	return 0;
-}
-
-static void __init setup_cpu_win(int win, u32 base, u32 size,
-				 u8 target, u8 attr, int remap)
-{
-	u32 ctrl;
-
-	base &= 0xffff0000;
-	ctrl = ((size - 1) & 0xffff0000) | (attr << 8) | (target << 4) | 1;
-
-	writel(base, WIN_BASE(win));
-	writel(ctrl, WIN_CTRL(win));
-	if (cpu_win_can_remap(win)) {
-		if (remap < 0)
-			remap = base;
-		writel(remap & 0xffff0000, WIN_REMAP_LO(win));
-		writel(0, WIN_REMAP_HI(win));
-	}
-}
-
-void __init dove_setup_cpu_mbus(void)
-{
-	int i;
-	int cs;
+/*
+ * Description of the windows needed by the platform code
+ */
+static struct __initdata orion_addr_map_cfg addr_map_cfg = {
+	.num_wins = 8,
+	.remappable_wins = 4,
+	.bridge_virt_base = BRIDGE_VIRT_BASE,
+};
 
+static const struct __initdata orion_addr_map_info addr_map_info[] = {
 	/*
-	 * First, disable and clear windows.
+	 * Windows for PCIe IO+MEM space.
 	 */
-	for (i = 0; i < 8; i++) {
-		writel(0, WIN_BASE(i));
-		writel(0, WIN_CTRL(i));
-		if (cpu_win_can_remap(i)) {
-			writel(0, WIN_REMAP_LO(i));
-			writel(0, WIN_REMAP_HI(i));
-		}
-	}
-
+	{ 0, DOVE_PCIE0_IO_PHYS_BASE, DOVE_PCIE0_IO_SIZE,
+	  TARGET_PCIE0, ATTR_PCIE_IO, DOVE_PCIE0_IO_BUS_BASE
+	},
+	{ 1, DOVE_PCIE1_IO_PHYS_BASE, DOVE_PCIE1_IO_SIZE,
+	  TARGET_PCIE1, ATTR_PCIE_IO, DOVE_PCIE1_IO_BUS_BASE
+	},
+	{ 2, DOVE_PCIE0_MEM_PHYS_BASE, DOVE_PCIE0_MEM_SIZE,
+	  TARGET_PCIE0, ATTR_PCIE_MEM, -1
+	},
+	{ 3, DOVE_PCIE1_MEM_PHYS_BASE, DOVE_PCIE1_MEM_SIZE,
+	  TARGET_PCIE1, ATTR_PCIE_MEM, -1
+	},
 	/*
-	 * Setup windows for PCIe IO+MEM space.
+	 * Window for CESA engine.
 	 */
-	setup_cpu_win(0, DOVE_PCIE0_IO_PHYS_BASE, DOVE_PCIE0_IO_SIZE,
-		      TARGET_PCIE0, ATTR_PCIE_IO, DOVE_PCIE0_IO_BUS_BASE);
-	setup_cpu_win(1, DOVE_PCIE1_IO_PHYS_BASE, DOVE_PCIE1_IO_SIZE,
-		      TARGET_PCIE1, ATTR_PCIE_IO, DOVE_PCIE1_IO_BUS_BASE);
-	setup_cpu_win(2, DOVE_PCIE0_MEM_PHYS_BASE, DOVE_PCIE0_MEM_SIZE,
-		      TARGET_PCIE0, ATTR_PCIE_MEM, -1);
-	setup_cpu_win(3, DOVE_PCIE1_MEM_PHYS_BASE, DOVE_PCIE1_MEM_SIZE,
-		      TARGET_PCIE1, ATTR_PCIE_MEM, -1);
-
+	{ 4, DOVE_CESA_PHYS_BASE, DOVE_CESA_SIZE,
+	  TARGET_CESA, ATTR_CESA, -1
+	},
 	/*
-	 * Setup window for CESA engine.
+	 * Window to the BootROM for Standby and Sleep Resume
 	 */
-	setup_cpu_win(4, DOVE_CESA_PHYS_BASE, DOVE_CESA_SIZE,
-		      TARGET_CESA, ATTR_CESA, -1);
-
+	{ 5, DOVE_BOOTROM_PHYS_BASE, DOVE_BOOTROM_SIZE,
+	  TARGET_BOOTROM, ATTR_BOOTROM, -1
+	},
 	/*
-	 * Setup the Window to the BootROM for Standby and Sleep Resume
+	 * Window to the PMU Scratch Pad space
 	 */
-	setup_cpu_win(5, DOVE_BOOTROM_PHYS_BASE, DOVE_BOOTROM_SIZE,
-		      TARGET_BOOTROM, ATTR_BOOTROM, -1);
+	{ 6, DOVE_SCRATCHPAD_PHYS_BASE, DOVE_SCRATCHPAD_SIZE,
+	  TARGET_SCRATCHPAD, ATTR_SCRATCHPAD, -1
+	},
+	/* End marker */
+	{ -1, 0, 0, 0, 0, 0 }
+};
+
+void __init dove_setup_cpu_mbus(void)
+{
+	int i;
+	int cs;
 
 	/*
-	 * Setup the Window to the PMU Scratch Pad space
+	 * Disable, clear and configure windows.
 	 */
-	setup_cpu_win(6, DOVE_SCRATCHPAD_PHYS_BASE, DOVE_SCRATCHPAD_SIZE,
-		      TARGET_SCRATCHPAD, ATTR_SCRATCHPAD, -1);
+	orion_config_wins(&addr_map_cfg, addr_map_info);
 
 	/*
 	 * Setup MBUS dram target info.
diff --git a/arch/arm/mach-kirkwood/addr-map.c b/arch/arm/mach-kirkwood/addr-map.c
index 8d03bce..935392f 100644
--- a/arch/arm/mach-kirkwood/addr-map.c
+++ b/arch/arm/mach-kirkwood/addr-map.c
@@ -13,12 +13,12 @@
 #include <linux/mbus.h>
 #include <linux/io.h>
 #include <mach/hardware.h>
+#include <plat/addr-map.h>
 #include "common.h"
 
 /*
  * Generic Address Decode Windows bit settings
  */
-#define TARGET_DDR		0
 #define TARGET_DEV_BUS		1
 #define TARGET_SRAM		3
 #define TARGET_PCIE		4
@@ -35,119 +35,59 @@
 #define ATTR_PCIE1_MEM		0xd8
 #define ATTR_SRAM		0x01
 
-/*
- * Helpers to get DDR bank info
- */
-#define DDR_BASE_CS_OFF(n)	(0x0000 + ((n) << 3))
-#define DDR_SIZE_CS_OFF(n)	(0x0004 + ((n) << 3))
+struct mbus_dram_target_info kirkwood_mbus_dram_info;
 
 /*
- * CPU Address Decode Windows registers
+ * Description of the windows needed by the platform code
  */
-#define WIN_OFF(n)		(BRIDGE_VIRT_BASE + 0x0000 + ((n) << 4))
-#define WIN_CTRL_OFF		0x0000
-#define WIN_BASE_OFF		0x0004
-#define WIN_REMAP_LO_OFF	0x0008
-#define WIN_REMAP_HI_OFF	0x000c
-
-
-struct mbus_dram_target_info kirkwood_mbus_dram_info;
-
-static int __init cpu_win_can_remap(int win)
-{
-	if (win < 4)
-		return 1;
-
-	return 0;
-}
-
-static void __init setup_cpu_win(int win, u32 base, u32 size,
-				 u8 target, u8 attr, int remap)
-{
-	void __iomem *addr = (void __iomem *)WIN_OFF(win);
-	u32 ctrl;
-
-	base &= 0xffff0000;
-	ctrl = ((size - 1) & 0xffff0000) | (attr << 8) | (target << 4) | 1;
-
-	writel(base, addr + WIN_BASE_OFF);
-	writel(ctrl, addr + WIN_CTRL_OFF);
-	if (cpu_win_can_remap(win)) {
-		if (remap < 0)
-			remap = base;
-
-		writel(remap & 0xffff0000, addr + WIN_REMAP_LO_OFF);
-		writel(0, addr + WIN_REMAP_HI_OFF);
-	}
-}
-
-void __init kirkwood_setup_cpu_mbus(void)
-{
-	void __iomem *addr;
-	int i;
-	int cs;
+static struct __initdata orion_addr_map_cfg addr_map_cfg = {
+	.num_wins = 8,
+	.remappable_wins = 4,
+	.bridge_virt_base = BRIDGE_VIRT_BASE,
+};
 
+static const struct __initdata orion_addr_map_info addr_map_info[] = {
 	/*
-	 * First, disable and clear windows.
+	 * Windows for PCIe IO+MEM space.
 	 */
-	for (i = 0; i < 8; i++) {
-		addr = (void __iomem *)WIN_OFF(i);
-
-		writel(0, addr + WIN_BASE_OFF);
-		writel(0, addr + WIN_CTRL_OFF);
-		if (cpu_win_can_remap(i)) {
-			writel(0, addr + WIN_REMAP_LO_OFF);
-			writel(0, addr + WIN_REMAP_HI_OFF);
-		}
-	}
-
+	{ 0, KIRKWOOD_PCIE_IO_PHYS_BASE, KIRKWOOD_PCIE_IO_SIZE,
+	  TARGET_PCIE, ATTR_PCIE_IO, KIRKWOOD_PCIE_IO_BUS_BASE
+	},
+	{ 1, KIRKWOOD_PCIE_MEM_PHYS_BASE, KIRKWOOD_PCIE_MEM_SIZE,
+	  TARGET_PCIE, ATTR_PCIE_MEM, KIRKWOOD_PCIE_MEM_BUS_BASE
+	},
+	{ 2, KIRKWOOD_PCIE1_IO_PHYS_BASE, KIRKWOOD_PCIE1_IO_SIZE,
+	  TARGET_PCIE, ATTR_PCIE1_IO, KIRKWOOD_PCIE1_IO_BUS_BASE
+	},
+	{ 3, KIRKWOOD_PCIE1_MEM_PHYS_BASE, KIRKWOOD_PCIE1_MEM_SIZE,
+	  TARGET_PCIE, ATTR_PCIE1_MEM, KIRKWOOD_PCIE1_MEM_BUS_BASE
+	},
 	/*
-	 * Setup windows for PCIe IO+MEM space.
+	 * Window for NAND controller.
 	 */
-	setup_cpu_win(0, KIRKWOOD_PCIE_IO_PHYS_BASE, KIRKWOOD_PCIE_IO_SIZE,
-		      TARGET_PCIE, ATTR_PCIE_IO, KIRKWOOD_PCIE_IO_BUS_BASE);
-	setup_cpu_win(1, KIRKWOOD_PCIE_MEM_PHYS_BASE, KIRKWOOD_PCIE_MEM_SIZE,
-		      TARGET_PCIE, ATTR_PCIE_MEM, KIRKWOOD_PCIE_MEM_BUS_BASE);
-	setup_cpu_win(2, KIRKWOOD_PCIE1_IO_PHYS_BASE, KIRKWOOD_PCIE1_IO_SIZE,
-		      TARGET_PCIE, ATTR_PCIE1_IO, KIRKWOOD_PCIE1_IO_BUS_BASE);
-	setup_cpu_win(3, KIRKWOOD_PCIE1_MEM_PHYS_BASE, KIRKWOOD_PCIE1_MEM_SIZE,
-		      TARGET_PCIE, ATTR_PCIE1_MEM, KIRKWOOD_PCIE1_MEM_BUS_BASE);
-
+	{ 4, KIRKWOOD_NAND_MEM_PHYS_BASE, KIRKWOOD_NAND_MEM_SIZE,
+	  TARGET_DEV_BUS, ATTR_DEV_NAND, -1
+	},
 	/*
-	 * Setup window for NAND controller.
+	 * Window for SRAM.
 	 */
-	setup_cpu_win(4, KIRKWOOD_NAND_MEM_PHYS_BASE, KIRKWOOD_NAND_MEM_SIZE,
-		      TARGET_DEV_BUS, ATTR_DEV_NAND, -1);
+	{ 5, KIRKWOOD_SRAM_PHYS_BASE, KIRKWOOD_SRAM_SIZE,
+	  TARGET_SRAM, ATTR_SRAM, -1
+	},
+	/* End marker */
+	{ -1, 0, 0, 0, 0, 0 }
+};
 
+void __init kirkwood_setup_cpu_mbus(void)
+{
 	/*
-	 * Setup window for SRAM.
+	 * Disable, clear and configure windows.
 	 */
-	setup_cpu_win(5, KIRKWOOD_SRAM_PHYS_BASE, KIRKWOOD_SRAM_SIZE,
-		      TARGET_SRAM, ATTR_SRAM, -1);
+	orion_config_wins(&addr_map_cfg, addr_map_info);
 
 	/*
 	 * Setup MBUS dram target info.
 	 */
-	kirkwood_mbus_dram_info.mbus_dram_target_id = TARGET_DDR;
-
-	addr = (void __iomem *)DDR_WINDOW_CPU_BASE;
-
-	for (i = 0, cs = 0; i < 4; i++) {
-		u32 base = readl(addr + DDR_BASE_CS_OFF(i));
-		u32 size = readl(addr + DDR_SIZE_CS_OFF(i));
-
-		/*
-		 * Chip select enabled?
-		 */
-		if (size & 1) {
-			struct mbus_dram_window *w;
-
-			w = &kirkwood_mbus_dram_info.cs[cs++];
-			w->cs_index = i;
-			w->mbus_attr = 0xf & ~(1 << i);
-			w->base = base & 0xffff0000;
-			w->size = (size | 0x0000ffff) + 1;
-		}
-	}
-	kirkwood_mbus_dram_info.num_cs = cs;
+	orion_setup_cpu_mbus_target(&addr_map_cfg, &kirkwood_mbus_dram_info,
+				    DDR_WINDOW_CPU_BASE);
 }
diff --git a/arch/arm/mach-mv78xx0/addr-map.c b/arch/arm/mach-mv78xx0/addr-map.c
index 311d5b0..6b14555 100644
--- a/arch/arm/mach-mv78xx0/addr-map.c
+++ b/arch/arm/mach-mv78xx0/addr-map.c
@@ -12,12 +12,12 @@
 #include <linux/init.h>
 #include <linux/mbus.h>
 #include <linux/io.h>
+#include <plat/addr-map.h>
 #include "common.h"
 
 /*
  * Generic Address Decode Windows bit settings
  */
-#define TARGET_DDR		0
 #define TARGET_DEV_BUS		1
 #define TARGET_PCIE0		4
 #define TARGET_PCIE1		8
@@ -32,21 +32,10 @@
 #define ATTR_PCIE_MEM(l)	(0xf8 & ~(0x10 << (l)))
 
 /*
- * Helpers to get DDR bank info
- */
-#define DDR_BASE_CS_OFF(n)	(0x0000 + ((n) << 3))
-#define DDR_SIZE_CS_OFF(n)	(0x0004 + ((n) << 3))
-
-/*
  * CPU Address Decode Windows registers
  */
 #define WIN0_OFF(n)		(BRIDGE_VIRT_BASE + 0x0000 + ((n) << 4))
 #define WIN8_OFF(n)		(BRIDGE_VIRT_BASE + 0x0900 + (((n) - 8) << 4))
-#define WIN_CTRL_OFF		0x0000
-#define WIN_BASE_OFF		0x0004
-#define WIN_REMAP_LO_OFF	0x0008
-#define WIN_REMAP_HI_OFF	0x000c
-
 
 struct mbus_dram_target_info mv78xx0_mbus_dram_info;
 
@@ -63,94 +52,45 @@ static void __init __iomem *win_cfg_base(int win)
 	return (void __iomem *)((win < 8) ? WIN0_OFF(win) : WIN8_OFF(win));
 }
 
-static int __init cpu_win_can_remap(int win)
-{
-	if (win < 8)
-		return 1;
-
-	return 0;
-}
-
-static void __init setup_cpu_win(int win, u32 base, u32 size,
-				 u8 target, u8 attr, int remap)
-{
-	void __iomem *addr = win_cfg_base(win);
-	u32 ctrl;
-
-	base &= 0xffff0000;
-	ctrl = ((size - 1) & 0xffff0000) | (attr << 8) | (target << 4) | 1;
-
-	writel(base, addr + WIN_BASE_OFF);
-	writel(ctrl, addr + WIN_CTRL_OFF);
-	if (cpu_win_can_remap(win)) {
-		if (remap < 0)
-			remap = base;
-
-		writel(remap & 0xffff0000, addr + WIN_REMAP_LO_OFF);
-		writel(0, addr + WIN_REMAP_HI_OFF);
-	}
-}
+/*
+ * Description of the windows needed by the platform code
+ */
+static struct __initdata orion_addr_map_cfg addr_map_cfg = {
+	.num_wins = 14,
+	.remappable_wins = 8,
+	.win_cfg_base = win_cfg_base,
+};
 
 void __init mv78xx0_setup_cpu_mbus(void)
 {
-	void __iomem *addr;
-	int i;
-	int cs;
-
 	/*
-	 * First, disable and clear windows.
+	 * Disable, clear and configure windows.
 	 */
-	for (i = 0; i < 14; i++) {
-		addr = win_cfg_base(i);
-
-		writel(0, addr + WIN_BASE_OFF);
-		writel(0, addr + WIN_CTRL_OFF);
-		if (cpu_win_can_remap(i)) {
-			writel(0, addr + WIN_REMAP_LO_OFF);
-			writel(0, addr + WIN_REMAP_HI_OFF);
-		}
-	}
+	orion_config_wins(&addr_map_cfg, NULL);
 
 	/*
 	 * Setup MBUS dram target info.
 	 */
-	mv78xx0_mbus_dram_info.mbus_dram_target_id = TARGET_DDR;
-
 	if (mv78xx0_core_index() == 0)
-		addr = (void __iomem *)DDR_WINDOW_CPU0_BASE;
+		orion_setup_cpu_mbus_target(&addr_map_cfg,
+					    &mv78xx0_mbus_dram_info,
+					    DDR_WINDOW_CPU0_BASE);
 	else
-		addr = (void __iomem *)DDR_WINDOW_CPU1_BASE;
-
-	for (i = 0, cs = 0; i < 4; i++) {
-		u32 base = readl(addr + DDR_BASE_CS_OFF(i));
-		u32 size = readl(addr + DDR_SIZE_CS_OFF(i));
-
-		/*
-		 * Chip select enabled?
-		 */
-		if (size & 1) {
-			struct mbus_dram_window *w;
-
-			w = &mv78xx0_mbus_dram_info.cs[cs++];
-			w->cs_index = i;
-			w->mbus_attr = 0xf & ~(1 << i);
-			w->base = base & 0xffff0000;
-			w->size = (size | 0x0000ffff) + 1;
-		}
-	}
-	mv78xx0_mbus_dram_info.num_cs = cs;
+		orion_setup_cpu_mbus_target(&addr_map_cfg,
+					    &mv78xx0_mbus_dram_info,
+					    DDR_WINDOW_CPU1_BASE);
 }
 
 void __init mv78xx0_setup_pcie_io_win(int window, u32 base, u32 size,
 				      int maj, int min)
 {
-	setup_cpu_win(window, base, size, TARGET_PCIE(maj),
-		      ATTR_PCIE_IO(min), -1);
+	orion_setup_cpu_win(&addr_map_cfg, window, base, size,
+			    TARGET_PCIE(maj), ATTR_PCIE_IO(min), -1);
 }
 
 void __init mv78xx0_setup_pcie_mem_win(int window, u32 base, u32 size,
 				       int maj, int min)
 {
-	setup_cpu_win(window, base, size, TARGET_PCIE(maj),
-		      ATTR_PCIE_MEM(min), -1);
+	orion_setup_cpu_win(&addr_map_cfg, window, base, size,
+			    TARGET_PCIE(maj), ATTR_PCIE_MEM(min), -1);
 }
diff --git a/arch/arm/mach-orion5x/addr-map.c b/arch/arm/mach-orion5x/addr-map.c
index 5ceafdc..73ceb49 100644
--- a/arch/arm/mach-orion5x/addr-map.c
+++ b/arch/arm/mach-orion5x/addr-map.c
@@ -14,8 +14,8 @@
 #include <linux/init.h>
 #include <linux/mbus.h>
 #include <linux/io.h>
-#include <linux/errno.h>
 #include <mach/hardware.h>
+#include <plat/addr-map.h>
 #include "common.h"
 
 /*
@@ -41,7 +41,6 @@
 /*
  * Generic Address Decode Windows bit settings
  */
-#define TARGET_DDR		0
 #define TARGET_DEV_BUS		1
 #define TARGET_PCI		3
 #define TARGET_PCIE		4
@@ -57,27 +56,11 @@
 #define ATTR_DEV_BOOT		0xf
 #define ATTR_SRAM		0x0
 
-/*
- * Helpers to get DDR bank info
- */
-#define ORION5X_DDR_REG(x)	(ORION5X_DDR_VIRT_BASE | (x))
-#define DDR_BASE_CS(n)		ORION5X_DDR_REG(0x1500 + ((n) << 3))
-#define DDR_SIZE_CS(n)		ORION5X_DDR_REG(0x1504 + ((n) << 3))
-
-/*
- * CPU Address Decode Windows registers
- */
-#define ORION5X_BRIDGE_REG(x)	(ORION5X_BRIDGE_VIRT_BASE | (x))
-#define CPU_WIN_CTRL(n)		ORION5X_BRIDGE_REG(0x000 | ((n) << 4))
-#define CPU_WIN_BASE(n)		ORION5X_BRIDGE_REG(0x004 | ((n) << 4))
-#define CPU_WIN_REMAP_LO(n)	ORION5X_BRIDGE_REG(0x008 | ((n) << 4))
-#define CPU_WIN_REMAP_HI(n)	ORION5X_BRIDGE_REG(0x00c | ((n) << 4))
-
-
 struct mbus_dram_target_info orion5x_mbus_dram_info;
 static int __initdata win_alloc_count;
 
-static int __init orion5x_cpu_win_can_remap(int win)
+static int __init cpu_win_can_remap(const struct orion_addr_map_cfg *cfg,
+		  const int win)
 {
 	u32 dev, rev;
 
@@ -91,116 +74,83 @@ static int __init orion5x_cpu_win_can_remap(int win)
 	return 0;
 }
 
-static int __init setup_cpu_win(int win, u32 base, u32 size,
-				 u8 target, u8 attr, int remap)
-{
-	if (win >= 8) {
-		printk(KERN_ERR "setup_cpu_win: trying to allocate "
-				"window %d\n", win);
-		return -ENOSPC;
-	}
-
-	writel(base & 0xffff0000, CPU_WIN_BASE(win));
-	writel(((size - 1) & 0xffff0000) | (attr << 8) | (target << 4) | 1,
-		CPU_WIN_CTRL(win));
-
-	if (orion5x_cpu_win_can_remap(win)) {
-		if (remap < 0)
-			remap = base;
-
-		writel(remap & 0xffff0000, CPU_WIN_REMAP_LO(win));
-		writel(0, CPU_WIN_REMAP_HI(win));
-	}
-	return 0;
-}
-
-void __init orion5x_setup_cpu_mbus_bridge(void)
-{
-	int i;
-	int cs;
+/*
+ * Description of the windows needed by the platform code
+ */
+static struct __initdata orion_addr_map_cfg addr_map_cfg = {
+	.num_wins = 8,
+	.cpu_win_can_remap = cpu_win_can_remap,
+	.bridge_virt_base = ORION5X_BRIDGE_VIRT_BASE,
+};
 
+static const struct __initdata orion_addr_map_info addr_map_info[] = {
 	/*
-	 * First, disable and clear windows.
+	 * Setup windows for PCI+PCIe IO+MEM space.
 	 */
-	for (i = 0; i < 8; i++) {
-		writel(0, CPU_WIN_BASE(i));
-		writel(0, CPU_WIN_CTRL(i));
-		if (orion5x_cpu_win_can_remap(i)) {
-			writel(0, CPU_WIN_REMAP_LO(i));
-			writel(0, CPU_WIN_REMAP_HI(i));
-		}
-	}
+	{ 0, ORION5X_PCIE_IO_PHYS_BASE, ORION5X_PCIE_IO_SIZE,
+	  TARGET_PCIE, ATTR_PCIE_IO, ORION5X_PCIE_IO_BUS_BASE
+	},
+	{ 1, ORION5X_PCI_IO_PHYS_BASE, ORION5X_PCI_IO_SIZE,
+	  TARGET_PCI, ATTR_PCI_IO, ORION5X_PCI_IO_BUS_BASE
+	},
+	{ 2, ORION5X_PCIE_MEM_PHYS_BASE, ORION5X_PCIE_MEM_SIZE,
+	  TARGET_PCIE, ATTR_PCIE_MEM, -1
+	},
+	{ 3, ORION5X_PCI_MEM_PHYS_BASE, ORION5X_PCI_MEM_SIZE,
+	  TARGET_PCI, ATTR_PCI_MEM, -1
+	},
+	/* End marker */
+	{ -1, 0, 0, 0, 0, 0 }
+};
 
+void __init orion5x_setup_cpu_mbus_bridge(void)
+{
 	/*
-	 * Setup windows for PCI+PCIe IO+MEM space.
+	 * Disable, clear and configure windows.
 	 */
-	setup_cpu_win(0, ORION5X_PCIE_IO_PHYS_BASE, ORION5X_PCIE_IO_SIZE,
-		TARGET_PCIE, ATTR_PCIE_IO, ORION5X_PCIE_IO_BUS_BASE);
-	setup_cpu_win(1, ORION5X_PCI_IO_PHYS_BASE, ORION5X_PCI_IO_SIZE,
-		TARGET_PCI, ATTR_PCI_IO, ORION5X_PCI_IO_BUS_BASE);
-	setup_cpu_win(2, ORION5X_PCIE_MEM_PHYS_BASE, ORION5X_PCIE_MEM_SIZE,
-		TARGET_PCIE, ATTR_PCIE_MEM, -1);
-	setup_cpu_win(3, ORION5X_PCI_MEM_PHYS_BASE, ORION5X_PCI_MEM_SIZE,
-		TARGET_PCI, ATTR_PCI_MEM, -1);
+	orion_config_wins(&addr_map_cfg, addr_map_info);
 	win_alloc_count = 4;
 
 	/*
 	 * Setup MBUS dram target info.
 	 */
-	orion5x_mbus_dram_info.mbus_dram_target_id = TARGET_DDR;
-
-	for (i = 0, cs = 0; i < 4; i++) {
-		u32 base = readl(DDR_BASE_CS(i));
-		u32 size = readl(DDR_SIZE_CS(i));
-
-		/*
-		 * Chip select enabled?
-		 */
-		if (size & 1) {
-			struct mbus_dram_window *w;
-
-			w = &orion5x_mbus_dram_info.cs[cs++];
-			w->cs_index = i;
-			w->mbus_attr = 0xf & ~(1 << i);
-			w->base = base & 0xffff0000;
-			w->size = (size | 0x0000ffff) + 1;
-		}
-	}
-	orion5x_mbus_dram_info.num_cs = cs;
+	orion_setup_cpu_mbus_target(&addr_map_cfg, &orion5x_mbus_dram_info,
+				    ORION5X_DDR_WINDOW_CPU_BASE);
 }
 
 void __init orion5x_setup_dev_boot_win(u32 base, u32 size)
 {
-	setup_cpu_win(win_alloc_count++, base, size,
-		      TARGET_DEV_BUS, ATTR_DEV_BOOT, -1);
+	orion_setup_cpu_win(&addr_map_cfg, win_alloc_count++, base, size,
+			    TARGET_DEV_BUS, ATTR_DEV_BOOT, -1);
 }
 
 void __init orion5x_setup_dev0_win(u32 base, u32 size)
 {
-	setup_cpu_win(win_alloc_count++, base, size,
-		      TARGET_DEV_BUS, ATTR_DEV_CS0, -1);
+	orion_setup_cpu_win(&addr_map_cfg, win_alloc_count++, base, size,
+			    TARGET_DEV_BUS, ATTR_DEV_CS0, -1);
 }
 
 void __init orion5x_setup_dev1_win(u32 base, u32 size)
 {
-	setup_cpu_win(win_alloc_count++, base, size,
-		      TARGET_DEV_BUS, ATTR_DEV_CS1, -1);
+	orion_setup_cpu_win(&addr_map_cfg, win_alloc_count++, base, size,
+			    TARGET_DEV_BUS, ATTR_DEV_CS1, -1);
 }
 
 void __init orion5x_setup_dev2_win(u32 base, u32 size)
 {
-	setup_cpu_win(win_alloc_count++, base, size,
-		      TARGET_DEV_BUS, ATTR_DEV_CS2, -1);
+	orion_setup_cpu_win(&addr_map_cfg, win_alloc_count++, base, size,
+			    TARGET_DEV_BUS, ATTR_DEV_CS2, -1);
 }
 
 void __init orion5x_setup_pcie_wa_win(u32 base, u32 size)
 {
-	setup_cpu_win(win_alloc_count++, base, size,
-		      TARGET_PCIE, ATTR_PCIE_WA, -1);
+	orion_setup_cpu_win(&addr_map_cfg, win_alloc_count++, base, size,
+			    TARGET_PCIE, ATTR_PCIE_WA, -1);
 }
 
-int __init orion5x_setup_sram_win(void)
+void __init orion5x_setup_sram_win(void)
 {
-	return setup_cpu_win(win_alloc_count++, ORION5X_SRAM_PHYS_BASE,
-			ORION5X_SRAM_SIZE, TARGET_SRAM, ATTR_SRAM, -1);
+	orion_setup_cpu_win(&addr_map_cfg, win_alloc_count++,
+			    ORION5X_SRAM_PHYS_BASE, ORION5X_SRAM_SIZE,
+			    TARGET_SRAM, ATTR_SRAM, -1);
 }
diff --git a/arch/arm/mach-orion5x/common.c b/arch/arm/mach-orion5x/common.c
index 0ab531d..ecca1e0 100644
--- a/arch/arm/mach-orion5x/common.c
+++ b/arch/arm/mach-orion5x/common.c
@@ -169,12 +169,7 @@ void __init orion5x_xor_init(void)
  ****************************************************************************/
 static void __init orion5x_crypto_init(void)
 {
-	int ret;
-
-	ret = orion5x_setup_sram_win();
-	if (ret)
-		return;
-
+	orion5x_setup_sram_win();
 	orion_crypto_init(ORION5X_CRYPTO_PHYS_BASE, ORION5X_SRAM_PHYS_BASE,
 			  SZ_8K, IRQ_ORION5X_CESA);
 }
diff --git a/arch/arm/mach-orion5x/common.h b/arch/arm/mach-orion5x/common.h
index 3e5499d..6276ca1 100644
--- a/arch/arm/mach-orion5x/common.h
+++ b/arch/arm/mach-orion5x/common.h
@@ -27,7 +27,7 @@ void orion5x_setup_dev0_win(u32 base, u32 size);
 void orion5x_setup_dev1_win(u32 base, u32 size);
 void orion5x_setup_dev2_win(u32 base, u32 size);
 void orion5x_setup_pcie_wa_win(u32 base, u32 size);
-int orion5x_setup_sram_win(void);
+void orion5x_setup_sram_win(void);
 
 void orion5x_ehci0_init(void);
 void orion5x_ehci1_init(void);
diff --git a/arch/arm/mach-orion5x/include/mach/orion5x.h b/arch/arm/mach-orion5x/include/mach/orion5x.h
index 0a28bbc..2745f5d 100644
--- a/arch/arm/mach-orion5x/include/mach/orion5x.h
+++ b/arch/arm/mach-orion5x/include/mach/orion5x.h
@@ -69,7 +69,7 @@
  ******************************************************************************/
 
 #define ORION5X_DDR_VIRT_BASE		(ORION5X_REGS_VIRT_BASE | 0x00000)
-
+#define  ORION5X_DDR_WINDOW_CPU_BASE    (ORION5X_DDR_VIRT_BASE | 0x1500)
 #define ORION5X_DEV_BUS_PHYS_BASE	(ORION5X_REGS_PHYS_BASE | 0x10000)
 #define ORION5X_DEV_BUS_VIRT_BASE	(ORION5X_REGS_VIRT_BASE | 0x10000)
 #define ORION5X_DEV_BUS_REG(x)		(ORION5X_DEV_BUS_VIRT_BASE | (x))
diff --git a/arch/arm/plat-orion/Makefile b/arch/arm/plat-orion/Makefile
index 95a5fc5..c20ce0f 100644
--- a/arch/arm/plat-orion/Makefile
+++ b/arch/arm/plat-orion/Makefile
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel.
 #
 
-obj-y	:= irq.o pcie.o time.o common.o mpp.o
+obj-y	:= irq.o pcie.o time.o common.o mpp.o addr-map.o
 obj-m	:=
 obj-n	:=
 obj-	:=
diff --git a/arch/arm/plat-orion/addr-map.c b/arch/arm/plat-orion/addr-map.c
new file mode 100644
index 0000000..d3abb34
--- /dev/null
+++ b/arch/arm/plat-orion/addr-map.c
@@ -0,0 +1,166 @@
+/*
+ * arch/arm/plat-orion/addr-map.c
+ *
+ * Address map functions for Marvell Orion based SoCs
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/mbus.h>
+#include <linux/io.h>
+#include <plat/addr-map.h>
+
+/*
+ * DDR target is the same on all Orion platforms.
+ */
+#define TARGET_DDR		0
+
+/*
+ * Helpers to get DDR bank info
+ */
+#define DDR_BASE_CS_OFF(n)	(0x0000 + ((n) << 3))
+#define DDR_SIZE_CS_OFF(n)	(0x0004 + ((n) << 3))
+
+/*
+ * CPU Address Decode Windows registers
+ */
+#define WIN_CTRL_OFF		0x0000
+#define WIN_BASE_OFF		0x0004
+#define WIN_REMAP_LO_OFF	0x0008
+#define WIN_REMAP_HI_OFF	0x000c
+
+/*
+ * Default implementation
+ */
+static void __init __iomem *
+orion_win_cfg_base(const struct orion_addr_map_cfg *cfg, int win)
+{
+	return (void __iomem *)(cfg->bridge_virt_base + (win << 4));
+}
+
+/*
+ * Default implementation
+ */
+static int __init orion_cpu_win_can_remap(const struct orion_addr_map_cfg *cfg,
+					  const int win)
+{
+	if (win < cfg->remappable_wins)
+		return 1;
+
+	return 0;
+}
+
+void __init orion_setup_cpu_win(const struct orion_addr_map_cfg *cfg,
+				const int win, const u32 base,
+				const u32 size, const u8 target,
+				const u8 attr, const int remap)
+{
+	void __iomem *addr = cfg->win_cfg_base(cfg, win);
+	u32 ctrl, base_high, remap_addr;
+
+	if (win >= cfg->num_wins) {
+		printk(KERN_ERR "setup_cpu_win: trying to allocate window "
+		       "%d when only %d allowed\n", win, cfg->num_wins);
+	}
+
+	base_high = base & 0xffff0000;
+	ctrl = ((size - 1) & 0xffff0000) | (attr << 8) | (target << 4) | 1;
+
+	writel(base_high, addr + WIN_BASE_OFF);
+	writel(ctrl, addr + WIN_CTRL_OFF);
+	if (cfg->cpu_win_can_remap(cfg, win)) {
+		if (remap < 0)
+			remap_addr = base;
+		else
+			remap_addr = remap;
+		writel(remap_addr & 0xffff0000, addr + WIN_REMAP_LO_OFF);
+		writel(0, addr + WIN_REMAP_HI_OFF);
+	}
+}
+
+/*
+ * Configure a number of windows.
+ */
+static void __init orion_setup_cpu_wins(const struct orion_addr_map_cfg * cfg,
+					const struct orion_addr_map_info *info)
+{
+	while (info->win != -1) {
+		orion_setup_cpu_win(cfg, info->win, info->base, info->size,
+				    info->target, info->attr, info->remap);
+		info++;
+	}
+}
+
+static void __init orion_disable_wins(const struct orion_addr_map_cfg * cfg)
+{
+	void __iomem *addr;
+	int i;
+
+	for (i = 0; i < cfg->num_wins; i++) {
+		addr = cfg->win_cfg_base(cfg, i);
+
+		writel(0, addr + WIN_BASE_OFF);
+		writel(0, addr + WIN_CTRL_OFF);
+		if (cfg->cpu_win_can_remap(cfg, i)) {
+			writel(0, addr + WIN_REMAP_LO_OFF);
+			writel(0, addr + WIN_REMAP_HI_OFF);
+		}
+	}
+}
+
+/*
+ * Disable, clear and configure windows.
+ */
+void __init orion_config_wins(struct orion_addr_map_cfg * cfg,
+			      const struct orion_addr_map_info *info)
+{
+	if (!cfg->cpu_win_can_remap)
+		cfg->cpu_win_can_remap = orion_cpu_win_can_remap;
+
+	if (!cfg->win_cfg_base)
+		cfg->win_cfg_base = orion_win_cfg_base;
+
+	orion_disable_wins(cfg);
+
+	if (info)
+		orion_setup_cpu_wins(cfg, info);
+}
+
+/*
+ * Setup MBUS dram target info.
+ */
+void __init orion_setup_cpu_mbus_target(const struct orion_addr_map_cfg *cfg,
+					struct mbus_dram_target_info *info,
+					const u32 ddr_window_cpu_base)
+{
+	void __iomem *addr;
+	int i;
+	int cs;
+
+	info->mbus_dram_target_id = TARGET_DDR;
+
+	addr = (void __iomem *)ddr_window_cpu_base;
+
+	for (i = 0, cs = 0; i < 4; i++) {
+		u32 base = readl(addr + DDR_BASE_CS_OFF(i));
+		u32 size = readl(addr + DDR_SIZE_CS_OFF(i));
+
+		/*
+		 * Chip select enabled?
+		 */
+		if (size & 1) {
+			struct mbus_dram_window *w;
+
+			w = &info->cs[cs++];
+			w->cs_index = i;
+			w->mbus_attr = 0xf & ~(1 << i);
+			w->base = base & 0xffff0000;
+			w->size = (size | 0x0000ffff) + 1;
+		}
+	}
+	info->num_cs = cs;
+}
diff --git a/arch/arm/plat-orion/include/plat/addr-map.h b/arch/arm/plat-orion/include/plat/addr-map.h
new file mode 100644
index 0000000..55e40f4
--- /dev/null
+++ b/arch/arm/plat-orion/include/plat/addr-map.h
@@ -0,0 +1,52 @@
+/*
+ * arch/arm/plat-orion/include/plat/addr-map.h
+ *
+ * Marvell Orion SoC address map handling.
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __PLAT_ADDR_MAP_H
+#define __PLAT_ADDR_MAP_H
+
+struct orion_addr_map_cfg {
+	const int num_wins;	/* Total number of windows */
+	const int remappable_wins;
+	const u32 bridge_virt_base;
+
+	/* If NULL, the default cpu_win_can_remap will be used, using
+	   the value in remappable_wins */
+	int (*cpu_win_can_remap) (const struct orion_addr_map_cfg *cfg,
+				  const int win);
+	/* If NULL, the default win_cfg_base will be used, using the
+	   value in bridge_virt_base */
+	void __iomem *(*win_cfg_base) (const struct orion_addr_map_cfg *cfg,
+				 const int win);
+};
+
+/*
+ * Information needed to setup one address mapping.
+ */
+struct orion_addr_map_info {
+	const int win;
+	const u32 base;
+	const u32 size;
+	const u8 target;
+	const u8 attr;
+	const int remap;
+};
+
+void __init orion_config_wins(struct orion_addr_map_cfg *cfg,
+			      const struct orion_addr_map_info *info);
+
+void __init orion_setup_cpu_win(const struct orion_addr_map_cfg *cfg,
+				const int win, const u32 base,
+				const u32 size, const u8 target,
+				const u8 attr, const int remap);
+
+void __init orion_setup_cpu_mbus_target(const struct orion_addr_map_cfg *cfg,
+					struct mbus_dram_target_info *info,
+					const u32 ddr_window_cpu_base);
+#endif
-- 
1.7.2.5
