From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 21 Mar 2013 17:59:17 +0100
Subject: [PATCH v3 4/7] arm: mach-dove: convert to use mvebu-mbus driver
In-Reply-To: <1363885160-6870-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1363885160-6870-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1363885160-6870-5-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit migrates the mach-dove platforms to use the mvebu-mbus
driver and therefore removes the Dove-specific addr-map code.

The dove_init_early() function now initializes the mvebu-mbus driver
by calling mvebu_mbus_init().

The address decoding windows are now registered in the
dove_setup_cpu_wins() function. It is worth noting that the four PCIe
address decoding windows will ultimately no longer have to be
registered here: it will be done automatically by the PCIe driver once
Dove has been migrated to use the upcoming mvebu PCIe driver.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/Kconfig                       |    1 +
 arch/arm/mach-dove/Makefile            |    2 +-
 arch/arm/mach-dove/addr-map.c          |  125 --------------------------------
 arch/arm/mach-dove/board-dt.c          |    2 +-
 arch/arm/mach-dove/common.c            |   39 +++++++++-
 arch/arm/mach-dove/common.h            |    2 +-
 arch/arm/mach-dove/include/mach/dove.h |    5 ++
 arch/arm/plat-orion/Makefile           |    1 -
 8 files changed, 47 insertions(+), 130 deletions(-)
 delete mode 100644 arch/arm/mach-dove/addr-map.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 544767b..d18a141 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -564,6 +564,7 @@ config ARCH_DOVE
 	select PINCTRL_DOVE
 	select PLAT_ORION_LEGACY
 	select USB_ARCH_HAS_EHCI
+	select MVEBU_MBUS
 	help
 	  Support for the Marvell Dove SoC 88AP510
 
diff --git a/arch/arm/mach-dove/Makefile b/arch/arm/mach-dove/Makefile
index 3f0a858..4d9d2ff 100644
--- a/arch/arm/mach-dove/Makefile
+++ b/arch/arm/mach-dove/Makefile
@@ -1,4 +1,4 @@
-obj-y				+= common.o addr-map.o irq.o
+obj-y				+= common.o irq.o
 obj-$(CONFIG_DOVE_LEGACY)	+= mpp.o
 obj-$(CONFIG_PCI)		+= pcie.o
 obj-$(CONFIG_MACH_DOVE_DB)	+= dove-db-setup.o
diff --git a/arch/arm/mach-dove/addr-map.c b/arch/arm/mach-dove/addr-map.c
deleted file mode 100644
index 2a06c01..0000000
--- a/arch/arm/mach-dove/addr-map.c
+++ /dev/null
@@ -1,125 +0,0 @@
-/*
- * arch/arm/mach-dove/addr-map.c
- *
- * Address map functions for Marvell Dove 88AP510 SoC
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
-#include <asm/mach/arch.h>
-#include <asm/setup.h>
-#include <mach/dove.h>
-#include <plat/addr-map.h>
-#include "common.h"
-
-/*
- * Generic Address Decode Windows bit settings
- */
-#define TARGET_DDR		0x0
-#define TARGET_BOOTROM		0x1
-#define TARGET_CESA		0x3
-#define TARGET_PCIE0		0x4
-#define TARGET_PCIE1		0x8
-#define TARGET_SCRATCHPAD	0xd
-
-#define ATTR_CESA		0x01
-#define ATTR_BOOTROM		0xfd
-#define ATTR_DEV_SPI0_ROM	0xfe
-#define ATTR_DEV_SPI1_ROM	0xfb
-#define ATTR_PCIE_IO		0xe0
-#define ATTR_PCIE_MEM		0xe8
-#define ATTR_SCRATCHPAD		0x0
-
-static inline void __iomem *ddr_map_sc(int i)
-{
-	return (void __iomem *)(DOVE_MC_VIRT_BASE + 0x100 + ((i) << 4));
-}
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
-	{ 0, DOVE_PCIE0_IO_PHYS_BASE, DOVE_PCIE0_IO_SIZE,
-	  TARGET_PCIE0, ATTR_PCIE_IO, DOVE_PCIE0_IO_BUS_BASE
-	},
-	{ 1, DOVE_PCIE1_IO_PHYS_BASE, DOVE_PCIE1_IO_SIZE,
-	  TARGET_PCIE1, ATTR_PCIE_IO, DOVE_PCIE1_IO_BUS_BASE
-	},
-	{ 2, DOVE_PCIE0_MEM_PHYS_BASE, DOVE_PCIE0_MEM_SIZE,
-	  TARGET_PCIE0, ATTR_PCIE_MEM, -1
-	},
-	{ 3, DOVE_PCIE1_MEM_PHYS_BASE, DOVE_PCIE1_MEM_SIZE,
-	  TARGET_PCIE1, ATTR_PCIE_MEM, -1
-	},
-	/*
-	 * Window for CESA engine.
-	 */
-	{ 4, DOVE_CESA_PHYS_BASE, DOVE_CESA_SIZE,
-	  TARGET_CESA, ATTR_CESA, -1
-	},
-	/*
-	 * Window to the BootROM for Standby and Sleep Resume
-	 */
-	{ 5, DOVE_BOOTROM_PHYS_BASE, DOVE_BOOTROM_SIZE,
-	  TARGET_BOOTROM, ATTR_BOOTROM, -1
-	},
-	/*
-	 * Window to the PMU Scratch Pad space
-	 */
-	{ 6, DOVE_SCRATCHPAD_PHYS_BASE, DOVE_SCRATCHPAD_SIZE,
-	  TARGET_SCRATCHPAD, ATTR_SCRATCHPAD, -1
-	},
-	/* End marker */
-	{ -1, 0, 0, 0, 0, 0 }
-};
-
-void __init dove_setup_cpu_mbus(void)
-{
-	int i;
-	int cs;
-
-	/*
-	 * Disable, clear and configure windows.
-	 */
-	orion_config_wins(&addr_map_cfg, addr_map_info);
-
-	/*
-	 * Setup MBUS dram target info.
-	 */
-	orion_mbus_dram_info.mbus_dram_target_id = TARGET_DDR;
-
-	for (i = 0, cs = 0; i < 2; i++) {
-		u32 map = readl(ddr_map_sc(i));
-
-		/*
-		 * Chip select enabled?
-		 */
-		if (map & 1) {
-			struct mbus_dram_window *w;
-
-			w = &orion_mbus_dram_info.cs[cs++];
-			w->cs_index = i;
-			w->mbus_attr = 0; /* CS address decoding done inside */
-					  /* the DDR controller, no need to  */
-					  /* provide attributes */
-			w->base = map & 0xff800000;
-			w->size = 0x100000 << (((map & 0x000f0000) >> 16) - 4);
-		}
-	}
-	orion_mbus_dram_info.num_cs = cs;
-}
diff --git a/arch/arm/mach-dove/board-dt.c b/arch/arm/mach-dove/board-dt.c
index fbde1dd..0b14280 100644
--- a/arch/arm/mach-dove/board-dt.c
+++ b/arch/arm/mach-dove/board-dt.c
@@ -64,7 +64,7 @@ static void __init dove_dt_init(void)
 #ifdef CONFIG_CACHE_TAUROS2
 	tauros2_init(0);
 #endif
-	dove_setup_cpu_mbus();
+	dove_setup_cpu_wins();
 
 	/* Setup root of clk tree */
 	dove_of_clk_init();
diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
index c6b3b2b..e2b5da0 100644
--- a/arch/arm/mach-dove/common.c
+++ b/arch/arm/mach-dove/common.c
@@ -224,6 +224,9 @@ void __init dove_i2c_init(void)
 void __init dove_init_early(void)
 {
 	orion_time_set_base(TIMER_VIRT_BASE);
+	mvebu_mbus_init("marvell,dove-mbus",
+			BRIDGE_WINS_BASE, BRIDGE_WINS_SZ,
+			DOVE_MC_WINS_BASE, DOVE_MC_WINS_SZ);
 }
 
 static int __init dove_find_tclk(void)
@@ -326,6 +329,40 @@ void __init dove_sdio1_init(void)
 	platform_device_register(&dove_sdio1);
 }
 
+void __init dove_setup_cpu_wins(void)
+{
+	/*
+	 * The PCIe windows will no longer be statically allocated
+	 * here once Dove is migrated to the pci-mvebu driver.
+	 */
+	mvebu_mbus_add_window_remap_flags("pcie0.0",
+					  DOVE_PCIE0_IO_PHYS_BASE,
+					  DOVE_PCIE0_IO_SIZE,
+					  DOVE_PCIE0_IO_BUS_BASE,
+					  MVEBU_MBUS_PCI_IO);
+	mvebu_mbus_add_window_remap_flags("pcie1.0",
+					  DOVE_PCIE1_IO_PHYS_BASE,
+					  DOVE_PCIE1_IO_SIZE,
+					  DOVE_PCIE1_IO_BUS_BASE,
+					  MVEBU_MBUS_PCI_IO);
+	mvebu_mbus_add_window_remap_flags("pcie0.0",
+					  DOVE_PCIE0_MEM_PHYS_BASE,
+					  DOVE_PCIE0_MEM_SIZE,
+					  MVEBU_MBUS_NO_REMAP,
+					  MVEBU_MBUS_PCI_MEM);
+	mvebu_mbus_add_window_remap_flags("pcie1.0",
+					  DOVE_PCIE1_MEM_PHYS_BASE,
+					  DOVE_PCIE1_MEM_SIZE,
+					  MVEBU_MBUS_NO_REMAP,
+					  MVEBU_MBUS_PCI_MEM);
+	mvebu_mbus_add_window("cesa", DOVE_CESA_PHYS_BASE,
+			      DOVE_CESA_SIZE);
+	mvebu_mbus_add_window("bootrom", DOVE_BOOTROM_PHYS_BASE,
+			      DOVE_BOOTROM_SIZE);
+	mvebu_mbus_add_window("scratchpad", DOVE_SCRATCHPAD_PHYS_BASE,
+			      DOVE_SCRATCHPAD_SIZE);
+}
+
 void __init dove_init(void)
 {
 	pr_info("Dove 88AP510 SoC, TCLK = %d MHz.\n",
@@ -334,7 +371,7 @@ void __init dove_init(void)
 #ifdef CONFIG_CACHE_TAUROS2
 	tauros2_init(0);
 #endif
-	dove_setup_cpu_mbus();
+	dove_setup_cpu_wins();
 
 	/* Setup root of clk tree */
 	dove_clk_init();
diff --git a/arch/arm/mach-dove/common.h b/arch/arm/mach-dove/common.h
index ee59fba..e863479 100644
--- a/arch/arm/mach-dove/common.h
+++ b/arch/arm/mach-dove/common.h
@@ -23,7 +23,7 @@ void dove_map_io(void);
 void dove_init(void);
 void dove_init_early(void);
 void dove_init_irq(void);
-void dove_setup_cpu_mbus(void);
+void dove_setup_cpu_wins(void);
 void dove_ge00_init(struct mv643xx_eth_platform_data *eth_data);
 void dove_sata_init(struct mv_sata_platform_data *sata_data);
 #ifdef CONFIG_PCI
diff --git a/arch/arm/mach-dove/include/mach/dove.h b/arch/arm/mach-dove/include/mach/dove.h
index 661725e..0c4b35f 100644
--- a/arch/arm/mach-dove/include/mach/dove.h
+++ b/arch/arm/mach-dove/include/mach/dove.h
@@ -77,6 +77,8 @@
 /* North-South Bridge */
 #define BRIDGE_VIRT_BASE	(DOVE_SB_REGS_VIRT_BASE + 0x20000)
 #define BRIDGE_PHYS_BASE	(DOVE_SB_REGS_PHYS_BASE + 0x20000)
+#define  BRIDGE_WINS_BASE       (BRIDGE_PHYS_BASE)
+#define  BRIDGE_WINS_SZ         (0x80)
 
 /* Cryptographic Engine */
 #define DOVE_CRYPT_PHYS_BASE	(DOVE_SB_REGS_PHYS_BASE + 0x30000)
@@ -168,6 +170,9 @@
 #define  DOVE_SSP_CLOCK_ENABLE		(1 << 1)
 #define  DOVE_SSP_BPB_CLOCK_SRC_SSP	(1 << 11)
 /* Memory Controller */
+#define DOVE_MC_PHYS_BASE       (DOVE_NB_REGS_PHYS_BASE + 0x00000)
+#define  DOVE_MC_WINS_BASE      (DOVE_MC_PHYS_BASE + 0x100)
+#define  DOVE_MC_WINS_SZ        (0x8)
 #define DOVE_MC_VIRT_BASE	(DOVE_NB_REGS_VIRT_BASE + 0x00000)
 
 /* LCD Controller */
diff --git a/arch/arm/plat-orion/Makefile b/arch/arm/plat-orion/Makefile
index 58db16d..9fd843e 100644
--- a/arch/arm/plat-orion/Makefile
+++ b/arch/arm/plat-orion/Makefile
@@ -3,7 +3,6 @@
 #
 ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include
 
-obj-$(CONFIG_ARCH_DOVE)           += addr-map.o
 obj-$(CONFIG_ARCH_ORION5X)        += addr-map.o
 obj-$(CONFIG_ARCH_MV78XX0)        += addr-map.o
 
-- 
1.7.9.5
