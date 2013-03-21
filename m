From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 21 Mar 2013 17:59:19 +0100
Subject: [PATCH v3 6/7] arm: mach-mv78xx0: convert to use the mvebu-mbus driver
In-Reply-To: <1363885160-6870-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1363885160-6870-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1363885160-6870-7-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit convers the mach-mv78xx0 sub-architecture to use the
mvebu-mbus driver. We simply have to call mvebu_mbus_init() in the
->init_early() function, and modify the PCIe code so that it uses the
new functions provided by mvebu-mbus to create the needed PCIe
windows.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/Kconfig                             |    1 +
 arch/arm/mach-mv78xx0/Makefile               |    2 +-
 arch/arm/mach-mv78xx0/addr-map.c             |   93 --------------------------
 arch/arm/mach-mv78xx0/common.c               |   10 ++-
 arch/arm/mach-mv78xx0/include/mach/mv78xx0.h |    9 ++-
 arch/arm/mach-mv78xx0/pcie.c                 |   21 +++---
 arch/arm/plat-orion/Makefile                 |    2 -
 include/linux/mbus.h                         |    3 +
 8 files changed, 33 insertions(+), 108 deletions(-)
 delete mode 100644 arch/arm/mach-mv78xx0/addr-map.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e8caf60..882f8a8 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -590,6 +590,7 @@ config ARCH_MV78XX0
 	select GENERIC_CLOCKEVENTS
 	select PCI
 	select PLAT_ORION_LEGACY
+	select MVEBU_MBUS
 	help
 	  Support for the following Marvell MV78xx0 series SoCs:
 	  MV781x0, MV782x0.
diff --git a/arch/arm/mach-mv78xx0/Makefile b/arch/arm/mach-mv78xx0/Makefile
index 67a13f9..7cd0463 100644
--- a/arch/arm/mach-mv78xx0/Makefile
+++ b/arch/arm/mach-mv78xx0/Makefile
@@ -1,4 +1,4 @@
-obj-y				+= common.o addr-map.o mpp.o irq.o pcie.o
+obj-y				+= common.o mpp.o irq.o pcie.o
 obj-$(CONFIG_MACH_DB78X00_BP)	+= db78x00-bp-setup.o
 obj-$(CONFIG_MACH_RD78X00_MASA)	+= rd78x00-masa-setup.o
 obj-$(CONFIG_MACH_TERASTATION_WXL) += buffalo-wxl-setup.o
diff --git a/arch/arm/mach-mv78xx0/addr-map.c b/arch/arm/mach-mv78xx0/addr-map.c
deleted file mode 100644
index 26e9876..0000000
--- a/arch/arm/mach-mv78xx0/addr-map.c
+++ /dev/null
@@ -1,93 +0,0 @@
-/*
- * arch/arm/mach-mv78xx0/addr-map.c
- *
- * Address map functions for Marvell MV78xx0 SoCs
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
-#include <plat/addr-map.h>
-#include <mach/mv78xx0.h>
-#include "common.h"
-
-/*
- * Generic Address Decode Windows bit settings
- */
-#define TARGET_DEV_BUS		1
-#define TARGET_PCIE0		4
-#define TARGET_PCIE1		8
-#define TARGET_PCIE(i)		((i) ? TARGET_PCIE1 : TARGET_PCIE0)
-#define ATTR_DEV_SPI_ROM	0x1f
-#define ATTR_DEV_BOOT		0x2f
-#define ATTR_DEV_CS3		0x37
-#define ATTR_DEV_CS2		0x3b
-#define ATTR_DEV_CS1		0x3d
-#define ATTR_DEV_CS0		0x3e
-#define ATTR_PCIE_IO(l)		(0xf0 & ~(0x10 << (l)))
-#define ATTR_PCIE_MEM(l)	(0xf8 & ~(0x10 << (l)))
-
-/*
- * CPU Address Decode Windows registers
- */
-#define WIN0_OFF(n)		(BRIDGE_VIRT_BASE + 0x0000 + ((n) << 4))
-#define WIN8_OFF(n)		(BRIDGE_VIRT_BASE + 0x0900 + (((n) - 8) << 4))
-
-static void __init __iomem *win_cfg_base(const struct orion_addr_map_cfg *cfg, int win)
-{
-	/*
-	 * Find the control register base address for this window.
-	 *
-	 * BRIDGE_VIRT_BASE points to the right (CPU0's or CPU1's)
-	 * MBUS bridge depending on which CPU core we're running on,
-	 * so we don't need to take that into account here.
-	 */
-
-	return (win < 8) ? WIN0_OFF(win) : WIN8_OFF(win);
-}
-
-/*
- * Description of the windows needed by the platform code
- */
-static struct orion_addr_map_cfg addr_map_cfg __initdata = {
-	.num_wins = 14,
-	.remappable_wins = 8,
-	.win_cfg_base = win_cfg_base,
-};
-
-void __init mv78xx0_setup_cpu_mbus(void)
-{
-	/*
-	 * Disable, clear and configure windows.
-	 */
-	orion_config_wins(&addr_map_cfg, NULL);
-
-	/*
-	 * Setup MBUS dram target info.
-	 */
-	if (mv78xx0_core_index() == 0)
-		orion_setup_cpu_mbus_target(&addr_map_cfg,
-					    (void __iomem *) DDR_WINDOW_CPU0_BASE);
-	else
-		orion_setup_cpu_mbus_target(&addr_map_cfg,
-					    (void __iomem *) DDR_WINDOW_CPU1_BASE);
-}
-
-void __init mv78xx0_setup_pcie_io_win(int window, u32 base, u32 size,
-				      int maj, int min)
-{
-	orion_setup_cpu_win(&addr_map_cfg, window, base, size,
-			    TARGET_PCIE(maj), ATTR_PCIE_IO(min), 0);
-}
-
-void __init mv78xx0_setup_pcie_mem_win(int window, u32 base, u32 size,
-				       int maj, int min)
-{
-	orion_setup_cpu_win(&addr_map_cfg, window, base, size,
-			    TARGET_PCIE(maj), ATTR_PCIE_MEM(min), -1);
-}
diff --git a/arch/arm/mach-mv78xx0/common.c b/arch/arm/mach-mv78xx0/common.c
index 0efa144..749a7f8 100644
--- a/arch/arm/mach-mv78xx0/common.c
+++ b/arch/arm/mach-mv78xx0/common.c
@@ -334,6 +334,14 @@ void __init mv78xx0_uart3_init(void)
 void __init mv78xx0_init_early(void)
 {
 	orion_time_set_base(TIMER_VIRT_BASE);
+	if (mv78xx0_core_index() == 0)
+		mvebu_mbus_init("marvell,mv78xx0-mbus",
+				BRIDGE_WINS_CPU0_BASE, BRIDGE_WINS_SZ,
+				DDR_WINDOW_CPU0_BASE, DDR_WINDOW_CPU_SZ);
+	else
+		mvebu_mbus_init("marvell,mv78xx0-mbus",
+				BRIDGE_WINS_CPU1_BASE, BRIDGE_WINS_SZ,
+				DDR_WINDOW_CPU1_BASE, DDR_WINDOW_CPU_SZ);
 }
 
 void __init_refok mv78xx0_timer_init(void)
@@ -397,8 +405,6 @@ void __init mv78xx0_init(void)
 	printk("HCLK = %dMHz, ", (hclk + 499999) / 1000000);
 	printk("TCLK = %dMHz\n", (get_tclk() + 499999) / 1000000);
 
-	mv78xx0_setup_cpu_mbus();
-
 #ifdef CONFIG_CACHE_FEROCEON_L2
 	feroceon_l2_init(is_l2_writethrough());
 #endif
diff --git a/arch/arm/mach-mv78xx0/include/mach/mv78xx0.h b/arch/arm/mach-mv78xx0/include/mach/mv78xx0.h
index 46200a1..723748d 100644
--- a/arch/arm/mach-mv78xx0/include/mach/mv78xx0.h
+++ b/arch/arm/mach-mv78xx0/include/mach/mv78xx0.h
@@ -60,13 +60,18 @@
  */
 #define BRIDGE_VIRT_BASE	(MV78XX0_CORE_REGS_VIRT_BASE)
 #define BRIDGE_PHYS_BASE	(MV78XX0_CORE_REGS_PHYS_BASE)
+#define  BRIDGE_WINS_CPU0_BASE  (MV78XX0_CORE0_REGS_PHYS_BASE)
+#define  BRIDGE_WINS_CPU1_BASE  (MV78XX0_CORE1_REGS_PHYS_BASE)
+#define  BRIDGE_WINS_SZ         (0xA000)
 
 /*
  * Register Map
  */
 #define DDR_VIRT_BASE		(MV78XX0_REGS_VIRT_BASE + 0x00000)
-#define  DDR_WINDOW_CPU0_BASE	(DDR_VIRT_BASE + 0x1500)
-#define  DDR_WINDOW_CPU1_BASE	(DDR_VIRT_BASE + 0x1570)
+#define DDR_PHYS_BASE           (MV78XX0_REGS_PHYS_BASE + 0x00000)
+#define  DDR_WINDOW_CPU0_BASE	(DDR_PHYS_BASE + 0x1500)
+#define  DDR_WINDOW_CPU1_BASE	(DDR_PHYS_BASE + 0x1570)
+#define  DDR_WINDOW_CPU_SZ      (0x20)
 
 #define DEV_BUS_PHYS_BASE	(MV78XX0_REGS_PHYS_BASE + 0x10000)
 #define DEV_BUS_VIRT_BASE	(MV78XX0_REGS_VIRT_BASE + 0x10000)
diff --git a/arch/arm/mach-mv78xx0/pcie.c b/arch/arm/mach-mv78xx0/pcie.c
index ee8c0b5..dc26a65 100644
--- a/arch/arm/mach-mv78xx0/pcie.c
+++ b/arch/arm/mach-mv78xx0/pcie.c
@@ -10,11 +10,11 @@
 
 #include <linux/kernel.h>
 #include <linux/pci.h>
+#include <linux/mbus.h>
 #include <video/vga.h>
 #include <asm/irq.h>
 #include <asm/mach/pci.h>
 #include <plat/pcie.h>
-#include <plat/addr-map.h>
 #include <mach/mv78xx0.h>
 #include "common.h"
 
@@ -54,7 +54,6 @@ static void __init mv78xx0_pcie_preinit(void)
 	int i;
 	u32 size_each;
 	u32 start;
-	int win = 0;
 
 	pcie_io_space.name = "PCIe I/O Space";
 	pcie_io_space.start = MV78XX0_PCIE_IO_PHYS_BASE(0);
@@ -72,6 +71,7 @@ static void __init mv78xx0_pcie_preinit(void)
 	start = MV78XX0_PCIE_MEM_PHYS_BASE;
 	for (i = 0; i < num_pcie_ports; i++) {
 		struct pcie_port *pp = pcie_port + i;
+		char winname[MVEBU_MBUS_MAX_WINNAME_SZ];
 
 		snprintf(pp->mem_space_name, sizeof(pp->mem_space_name),
 			"PCIe %d.%d MEM", pp->maj, pp->min);
@@ -85,12 +85,17 @@ static void __init mv78xx0_pcie_preinit(void)
 		if (request_resource(&iomem_resource, &pp->res))
 			panic("can't allocate PCIe MEM sub-space");
 
-		mv78xx0_setup_pcie_mem_win(win + i + 8, pp->res.start,
-					   resource_size(&pp->res),
-					   pp->maj, pp->min);
-
-		mv78xx0_setup_pcie_io_win(win + i, i * SZ_64K, SZ_64K,
-					  pp->maj, pp->min);
+		snprintf(winname, sizeof(winname), "pcie%d.%d",
+			 pp->maj, pp->min);
+
+		mvebu_mbus_add_window_remap_flags(winname,
+						  pp->res.start,
+						  resource_size(&pp->res),
+						  MVEBU_MBUS_NO_REMAP,
+						  MVEBU_MBUS_PCI_MEM);
+		mvebu_mbus_add_window_remap_flags(winname,
+						  i * SZ_64K, SZ_64K,
+						  0, MVEBU_MBUS_PCI_IO);
 	}
 }
 
diff --git a/arch/arm/plat-orion/Makefile b/arch/arm/plat-orion/Makefile
index 09711cd..2eca54b 100644
--- a/arch/arm/plat-orion/Makefile
+++ b/arch/arm/plat-orion/Makefile
@@ -3,8 +3,6 @@
 #
 ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include
 
-obj-$(CONFIG_ARCH_MV78XX0)        += addr-map.o
-
 orion-gpio-$(CONFIG_GENERIC_GPIO) += gpio.o
 obj-$(CONFIG_PLAT_ORION_LEGACY)   += irq.o pcie.o time.o common.o mpp.o
 obj-$(CONFIG_PLAT_ORION_LEGACY)   += $(orion-gpio-y)
diff --git a/include/linux/mbus.h b/include/linux/mbus.h
index 462eb97..dba482e 100644
--- a/include/linux/mbus.h
+++ b/include/linux/mbus.h
@@ -43,6 +43,9 @@ struct mbus_dram_target_info
  */
 #define MVEBU_MBUS_NO_REMAP (0xffffffff)
 
+/* Maximum size of a mbus window name */
+#define MVEBU_MBUS_MAX_WINNAME_SZ 32
+
 /*
  * The Marvell mbus is to be found only on SOCs from the Orion family
  * at the moment.  Provide a dummy stub for other architectures.
-- 
1.7.9.5
