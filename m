From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 21 Mar 2013 17:59:16 +0100
Subject: [PATCH v3 3/7] arm: mach-kirkwood: convert to use mvebu-mbus driver
In-Reply-To: <1363885160-6870-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1363885160-6870-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1363885160-6870-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit migrates the mach-kirkwood platforms to use the mvebu-mbus
driver and therefore removes the Kirkwood-specific addr-map code.

The kirkwood_init_early() function is now responsible for initializing
the mvebu-mbus driver by calling mvebu_mbus_init().

The address decoding windows are now registered in the
kirkwood_setup_wins() function. It is worth noting that the four PCIe
address decoding windows will ultimately no longer have to be
registered here: it will be done automatically by the PCIe driver once
Kirkwood has been migrated to use the upcoming mvebu PCIe driver.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/Kconfig                               |    1 +
 arch/arm/mach-kirkwood/Makefile                |    2 +-
 arch/arm/mach-kirkwood/addr-map.c              |   91 ------------------------
 arch/arm/mach-kirkwood/board-dt.c              |    2 +-
 arch/arm/mach-kirkwood/common.c                |   38 +++++++++-
 arch/arm/mach-kirkwood/common.h                |    2 +-
 arch/arm/mach-kirkwood/include/mach/kirkwood.h |    7 +-
 arch/arm/mach-kirkwood/pcie.c                  |    1 -
 arch/arm/plat-orion/Makefile                   |    1 -
 9 files changed, 45 insertions(+), 100 deletions(-)
 delete mode 100644 arch/arm/mach-kirkwood/addr-map.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5b71469..544767b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -577,6 +577,7 @@ config ARCH_KIRKWOOD
 	select PINCTRL
 	select PINCTRL_KIRKWOOD
 	select PLAT_ORION_LEGACY
+	select MVEBU_MBUS
 	help
 	  Support for the following Marvell Kirkwood series SoCs:
 	  88F6180, 88F6192 and 88F6281.
diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
index 4cc4bee..d805f80 100644
--- a/arch/arm/mach-kirkwood/Makefile
+++ b/arch/arm/mach-kirkwood/Makefile
@@ -1,4 +1,4 @@
-obj-y				+= common.o addr-map.o irq.o pcie.o mpp.o
+obj-y				+= common.o irq.o pcie.o mpp.o
 
 obj-$(CONFIG_MACH_DB88F6281_BP)		+= db88f6281-bp-setup.o
 obj-$(CONFIG_MACH_RD88F6192_NAS)	+= rd88f6192-nas-setup.o
diff --git a/arch/arm/mach-kirkwood/addr-map.c b/arch/arm/mach-kirkwood/addr-map.c
deleted file mode 100644
index 8f0d162..0000000
--- a/arch/arm/mach-kirkwood/addr-map.c
+++ /dev/null
@@ -1,91 +0,0 @@
-/*
- * arch/arm/mach-kirkwood/addr-map.c
- *
- * Address map functions for Marvell Kirkwood SoCs
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/mbus.h>
-#include <linux/io.h>
-#include <mach/hardware.h>
-#include <plat/addr-map.h>
-#include "common.h"
-
-/*
- * Generic Address Decode Windows bit settings
- */
-#define TARGET_DEV_BUS		1
-#define TARGET_SRAM		3
-#define TARGET_PCIE		4
-#define ATTR_DEV_SPI_ROM	0x1e
-#define ATTR_DEV_BOOT		0x1d
-#define ATTR_DEV_NAND		0x2f
-#define ATTR_DEV_CS3		0x37
-#define ATTR_DEV_CS2		0x3b
-#define ATTR_DEV_CS1		0x3d
-#define ATTR_DEV_CS0		0x3e
-#define ATTR_PCIE_IO		0xe0
-#define ATTR_PCIE_MEM		0xe8
-#define ATTR_PCIE1_IO		0xd0
-#define ATTR_PCIE1_MEM		0xd8
-#define ATTR_SRAM		0x01
-
-/*
- * Description of the windows needed by the platform code
- */
-static struct __initdata orion_addr_map_cfg addr_map_cfg = {
-	.num_wins = 8,
-	.remappable_wins = 4,
-	.bridge_virt_base = BRIDGE_VIRT_BASE,
-};
-
-static const struct __initdata orion_addr_map_info addr_map_info[] = {
-	/*
-	 * Windows for PCIe IO+MEM space.
-	 */
-	{ 0, KIRKWOOD_PCIE_IO_PHYS_BASE, KIRKWOOD_PCIE_IO_SIZE,
-	  TARGET_PCIE, ATTR_PCIE_IO, KIRKWOOD_PCIE_IO_BUS_BASE
-	},
-	{ 1, KIRKWOOD_PCIE_MEM_PHYS_BASE, KIRKWOOD_PCIE_MEM_SIZE,
-	  TARGET_PCIE, ATTR_PCIE_MEM, KIRKWOOD_PCIE_MEM_BUS_BASE
-	},
-	{ 2, KIRKWOOD_PCIE1_IO_PHYS_BASE, KIRKWOOD_PCIE1_IO_SIZE,
-	  TARGET_PCIE, ATTR_PCIE1_IO, KIRKWOOD_PCIE1_IO_BUS_BASE
-	},
-	{ 3, KIRKWOOD_PCIE1_MEM_PHYS_BASE, KIRKWOOD_PCIE1_MEM_SIZE,
-	  TARGET_PCIE, ATTR_PCIE1_MEM, KIRKWOOD_PCIE1_MEM_BUS_BASE
-	},
-	/*
-	 * Window for NAND controller.
-	 */
-	{ 4, KIRKWOOD_NAND_MEM_PHYS_BASE, KIRKWOOD_NAND_MEM_SIZE,
-	  TARGET_DEV_BUS, ATTR_DEV_NAND, -1
-	},
-	/*
-	 * Window for SRAM.
-	 */
-	{ 5, KIRKWOOD_SRAM_PHYS_BASE, KIRKWOOD_SRAM_SIZE,
-	  TARGET_SRAM, ATTR_SRAM, -1
-	},
-	/* End marker */
-	{ -1, 0, 0, 0, 0, 0 }
-};
-
-void __init kirkwood_setup_cpu_mbus(void)
-{
-	/*
-	 * Disable, clear and configure windows.
-	 */
-	orion_config_wins(&addr_map_cfg, addr_map_info);
-
-	/*
-	 * Setup MBUS dram target info.
-	 */
-	orion_setup_cpu_mbus_target(&addr_map_cfg,
-				    (void __iomem *) DDR_WINDOW_CPU_BASE);
-}
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index 2e73e9d..ea49476 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -82,7 +82,7 @@ static void __init kirkwood_dt_init(void)
 	 */
 	writel(readl(CPU_CONFIG) & ~CPU_CONFIG_ERROR_PROP, CPU_CONFIG);
 
-	kirkwood_setup_cpu_mbus();
+	kirkwood_setup_wins();
 
 	kirkwood_l2_init();
 
diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index 49792a0..c2cae69 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -33,7 +33,6 @@
 #include <linux/platform_data/usb-ehci-orion.h>
 #include <plat/common.h>
 #include <plat/time.h>
-#include <plat/addr-map.h>
 #include <linux/platform_data/dma-mv_xor.h>
 #include "common.h"
 
@@ -535,6 +534,9 @@ void __init kirkwood_init_early(void)
 	 * the allocations won't fail.
 	 */
 	init_dma_coherent_pool_size(SZ_1M);
+	mvebu_mbus_init("marvell,kirkwood-mbus",
+			BRIDGE_WINS_BASE, BRIDGE_WINS_SZ,
+			DDR_WINDOW_CPU_BASE, DDR_WINDOW_CPU_SZ);
 }
 
 int kirkwood_tclk;
@@ -650,6 +652,38 @@ char * __init kirkwood_id(void)
 	}
 }
 
+void __init kirkwood_setup_wins(void)
+{
+	/*
+	 * The PCIe windows will no longer be statically allocated
+	 * here once Kirkwood is migrated to the pci-mvebu driver.
+	 */
+	mvebu_mbus_add_window_remap_flags("pcie0.0",
+					  KIRKWOOD_PCIE_IO_PHYS_BASE,
+					  KIRKWOOD_PCIE_IO_SIZE,
+					  KIRKWOOD_PCIE_IO_BUS_BASE,
+					  MVEBU_MBUS_PCI_IO);
+	mvebu_mbus_add_window_remap_flags("pcie0.0",
+					  KIRKWOOD_PCIE_MEM_PHYS_BASE,
+					  KIRKWOOD_PCIE_MEM_SIZE,
+					  MVEBU_MBUS_NO_REMAP,
+					  MVEBU_MBUS_PCI_MEM);
+	mvebu_mbus_add_window_remap_flags("pcie1.0",
+					  KIRKWOOD_PCIE1_IO_PHYS_BASE,
+					  KIRKWOOD_PCIE1_IO_SIZE,
+					  KIRKWOOD_PCIE1_IO_BUS_BASE,
+					  MVEBU_MBUS_PCI_IO);
+	mvebu_mbus_add_window_remap_flags("pcie1.0",
+					  KIRKWOOD_PCIE1_MEM_PHYS_BASE,
+					  KIRKWOOD_PCIE1_MEM_SIZE,
+					  MVEBU_MBUS_NO_REMAP,
+					  MVEBU_MBUS_PCI_MEM);
+	mvebu_mbus_add_window("nand", KIRKWOOD_NAND_MEM_PHYS_BASE,
+			      KIRKWOOD_NAND_MEM_SIZE);
+	mvebu_mbus_add_window("sram", KIRKWOOD_SRAM_PHYS_BASE,
+			      KIRKWOOD_SRAM_SIZE);
+}
+
 void __init kirkwood_l2_init(void)
 {
 #ifdef CONFIG_CACHE_FEROCEON_L2
@@ -675,7 +709,7 @@ void __init kirkwood_init(void)
 	 */
 	writel(readl(CPU_CONFIG) & ~CPU_CONFIG_ERROR_PROP, CPU_CONFIG);
 
-	kirkwood_setup_cpu_mbus();
+	kirkwood_setup_wins();
 
 	kirkwood_l2_init();
 
diff --git a/arch/arm/mach-kirkwood/common.h b/arch/arm/mach-kirkwood/common.h
index 5ed7056..e24f743 100644
--- a/arch/arm/mach-kirkwood/common.h
+++ b/arch/arm/mach-kirkwood/common.h
@@ -30,7 +30,7 @@ void kirkwood_init(void);
 void kirkwood_init_early(void);
 void kirkwood_init_irq(void);
 
-void kirkwood_setup_cpu_mbus(void);
+void kirkwood_setup_wins(void);
 
 void kirkwood_enable_pcie(void);
 void kirkwood_pcie_id(u32 *dev, u32 *rev);
diff --git a/arch/arm/mach-kirkwood/include/mach/kirkwood.h b/arch/arm/mach-kirkwood/include/mach/kirkwood.h
index a05563a..92976ce 100644
--- a/arch/arm/mach-kirkwood/include/mach/kirkwood.h
+++ b/arch/arm/mach-kirkwood/include/mach/kirkwood.h
@@ -60,8 +60,9 @@
  * Register Map
  */
 #define DDR_VIRT_BASE		(KIRKWOOD_REGS_VIRT_BASE + 0x00000)
-#define DDR_PHYS_BASE		(KIRKWOOD_REGS_PHYS_BASE + 0x00000)
-#define  DDR_WINDOW_CPU_BASE	(DDR_VIRT_BASE + 0x1500)
+#define DDR_PHYS_BASE           (KIRKWOOD_REGS_PHYS_BASE + 0x00000)
+#define  DDR_WINDOW_CPU_BASE    (DDR_PHYS_BASE + 0x1500)
+#define  DDR_WINDOW_CPU_SZ      (0x20)
 #define DDR_OPERATION_BASE	(DDR_PHYS_BASE + 0x1418)
 
 #define DEV_BUS_PHYS_BASE	(KIRKWOOD_REGS_PHYS_BASE + 0x10000)
@@ -80,6 +81,8 @@
 
 #define BRIDGE_VIRT_BASE	(KIRKWOOD_REGS_VIRT_BASE + 0x20000)
 #define BRIDGE_PHYS_BASE	(KIRKWOOD_REGS_PHYS_BASE + 0x20000)
+#define  BRIDGE_WINS_BASE       (BRIDGE_PHYS_BASE)
+#define  BRIDGE_WINS_SZ         (0x80)
 
 #define CRYPTO_PHYS_BASE	(KIRKWOOD_REGS_PHYS_BASE + 0x30000)
 
diff --git a/arch/arm/mach-kirkwood/pcie.c b/arch/arm/mach-kirkwood/pcie.c
index d96ad4c..7f43e6c 100644
--- a/arch/arm/mach-kirkwood/pcie.c
+++ b/arch/arm/mach-kirkwood/pcie.c
@@ -17,7 +17,6 @@
 #include <asm/mach/pci.h>
 #include <plat/pcie.h>
 #include <mach/bridge-regs.h>
-#include <plat/addr-map.h>
 #include "common.h"
 
 static void kirkwood_enable_pcie_clk(const char *port)
diff --git a/arch/arm/plat-orion/Makefile b/arch/arm/plat-orion/Makefile
index 6cfc89f..58db16d 100644
--- a/arch/arm/plat-orion/Makefile
+++ b/arch/arm/plat-orion/Makefile
@@ -3,7 +3,6 @@
 #
 ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include
 
-obj-$(CONFIG_ARCH_KIRKWOOD)       += addr-map.o
 obj-$(CONFIG_ARCH_DOVE)           += addr-map.o
 obj-$(CONFIG_ARCH_ORION5X)        += addr-map.o
 obj-$(CONFIG_ARCH_MV78XX0)        += addr-map.o
-- 
1.7.9.5
