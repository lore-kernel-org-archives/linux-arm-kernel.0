From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 21 Mar 2013 17:59:15 +0100
Subject: [PATCH v3 2/7] arm: mach-mvebu: convert to use mvebu-mbus driver
In-Reply-To: <1363885160-6870-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1363885160-6870-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1363885160-6870-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The changes needed to migrate the mach-mvebu (Armada 370 and Armada
XP) to the mvebu-mbus driver are fairly minimal, since not many
devices currently supported on those SoCs use address decoding
windows. The only one being the BootROM window, used to bring up
secondary CPUs.

However, this BootROM window needed for SMP brings an important
requirement: the mvebu-mbus driver must be initialized at the
->early_init() time, otherwise the BootROM window cannot be setup
early enough to be ready before the secondary CPUs are started.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-xp.dtsi |    5 --
 arch/arm/mach-mvebu/Kconfig          |    1 +
 arch/arm/mach-mvebu/Makefile         |    2 +-
 arch/arm/mach-mvebu/addr-map.c       |  137 ----------------------------------
 arch/arm/mach-mvebu/armada-370-xp.c  |   18 +++++
 arch/arm/mach-mvebu/armada-370-xp.h  |    6 ++
 arch/arm/mach-mvebu/platsmp.c        |    2 +
 arch/arm/plat-orion/Makefile         |    1 -
 8 files changed, 28 insertions(+), 144 deletions(-)
 delete mode 100644 arch/arm/mach-mvebu/addr-map.c

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 6f1acc7..38aaa3f 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -74,11 +74,6 @@
 			       clocks = <&coreclk 2>;
 		};
 
-		addr-decoding at d0020000 {
-			compatible = "marvell,armada-addr-decoding-controller";
-			reg = <0xd0020000 0x258>;
-		};
-
 		sata at d00a0000 {
 			compatible = "marvell,orion-sata";
 			reg = <0xd00a0000 0x2400>;
diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index 440b13e..c3715a5 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -13,6 +13,7 @@ config ARCH_MVEBU
 	select MVEBU_CLK_CORE
 	select MVEBU_CLK_CPU
 	select MVEBU_CLK_GATING
+	select MVEBU_MBUS
 
 if ARCH_MVEBU
 
diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
index da93bcb..ba769e0 100644
--- a/arch/arm/mach-mvebu/Makefile
+++ b/arch/arm/mach-mvebu/Makefile
@@ -5,6 +5,6 @@ AFLAGS_coherency_ll.o		:= -Wa,-march=armv7-a
 
 obj-y				 += system-controller.o
 obj-$(CONFIG_MACH_ARMADA_370_XP) += armada-370-xp.o
-obj-$(CONFIG_ARCH_MVEBU)	 += addr-map.o coherency.o coherency_ll.o pmsu.o irq-armada-370-xp.o 
+obj-$(CONFIG_ARCH_MVEBU)	 += coherency.o coherency_ll.o pmsu.o irq-armada-370-xp.o
 obj-$(CONFIG_SMP)                += platsmp.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)        += hotplug.o
diff --git a/arch/arm/mach-mvebu/addr-map.c b/arch/arm/mach-mvebu/addr-map.c
deleted file mode 100644
index ab9b3bd..0000000
--- a/arch/arm/mach-mvebu/addr-map.c
+++ /dev/null
@@ -1,137 +0,0 @@
-/*
- * Address map functions for Marvell 370 / XP SoCs
- *
- * Copyright (C) 2012 Marvell
- *
- * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
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
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <plat/addr-map.h>
-
-/*
- * Generic Address Decode Windows bit settings
- */
-#define ARMADA_XP_TARGET_DEV_BUS	1
-#define   ARMADA_XP_ATTR_DEV_BOOTROM    0x1D
-#define ARMADA_XP_TARGET_ETH1		3
-#define ARMADA_XP_TARGET_PCIE_0_2	4
-#define ARMADA_XP_TARGET_ETH0		7
-#define ARMADA_XP_TARGET_PCIE_1_3	8
-
-#define ARMADA_370_TARGET_DEV_BUS       1
-#define   ARMADA_370_ATTR_DEV_BOOTROM   0x1D
-#define ARMADA_370_TARGET_PCIE_0        4
-#define ARMADA_370_TARGET_PCIE_1        8
-
-#define ARMADA_WINDOW_8_PLUS_OFFSET       0x90
-#define ARMADA_SDRAM_ADDR_DECODING_OFFSET 0x180
-
-static const struct __initdata orion_addr_map_info
-armada_xp_addr_map_info[] = {
-	/*
-	 * Window for the BootROM, needed for SMP on Armada XP
-	 */
-	{ 0, 0xfff00000, SZ_1M, ARMADA_XP_TARGET_DEV_BUS,
-	  ARMADA_XP_ATTR_DEV_BOOTROM, -1 },
-	/* End marker */
-	{ -1, 0, 0, 0, 0, 0 },
-};
-
-static const struct __initdata orion_addr_map_info
-armada_370_addr_map_info[] = {
-	/* End marker */
-	{ -1, 0, 0, 0, 0, 0 },
-};
-
-static struct of_device_id of_addr_decoding_controller_table[] = {
-	{ .compatible = "marvell,armada-addr-decoding-controller" },
-	{ /* end of list */ },
-};
-
-static void __iomem *
-armada_cfg_base(const struct orion_addr_map_cfg *cfg, int win)
-{
-	unsigned int offset;
-
-	/* The register layout is a bit annoying and the below code
-	 * tries to cope with it.
-	 * - At offset 0x0, there are the registers for the first 8
-	 *   windows, with 4 registers of 32 bits per window (ctrl,
-	 *   base, remap low, remap high)
-	 * - Then at offset 0x80, there is a hole of 0x10 bytes for
-	 *   the internal registers base address and internal units
-	 *   sync barrier register.
-	 * - Then at offset 0x90, there the registers for 12
-	 *   windows, with only 2 registers of 32 bits per window
-	 *   (ctrl, base).
-	 */
-	if (win < 8)
-		offset = (win << 4);
-	else
-		offset = ARMADA_WINDOW_8_PLUS_OFFSET + ((win - 8) << 3);
-
-	return cfg->bridge_virt_base + offset;
-}
-
-static struct __initdata orion_addr_map_cfg addr_map_cfg = {
-	.num_wins = 20,
-	.remappable_wins = 8,
-	.win_cfg_base = armada_cfg_base,
-};
-
-static int __init armada_setup_cpu_mbus(void)
-{
-	struct device_node *np;
-	void __iomem *mbus_unit_addr_decoding_base;
-	void __iomem *sdram_addr_decoding_base;
-
-	np = of_find_matching_node(NULL, of_addr_decoding_controller_table);
-	if (!np)
-		return -ENODEV;
-
-	mbus_unit_addr_decoding_base = of_iomap(np, 0);
-	BUG_ON(!mbus_unit_addr_decoding_base);
-
-	sdram_addr_decoding_base =
-		mbus_unit_addr_decoding_base +
-		ARMADA_SDRAM_ADDR_DECODING_OFFSET;
-
-	addr_map_cfg.bridge_virt_base = mbus_unit_addr_decoding_base;
-
-	if (of_find_compatible_node(NULL, NULL, "marvell,coherency-fabric"))
-		addr_map_cfg.hw_io_coherency = 1;
-
-	/*
-	 * Disable, clear and configure windows.
-	 */
-	if (of_machine_is_compatible("marvell,armadaxp"))
-		orion_config_wins(&addr_map_cfg, armada_xp_addr_map_info);
-	else if (of_machine_is_compatible("marvell,armada370"))
-		orion_config_wins(&addr_map_cfg, armada_370_addr_map_info);
-	else {
-		pr_err("Unsupported SoC\n");
-		return -EINVAL;
-	}
-
-	/*
-	 * Setup MBUS dram target info.
-	 */
-	orion_setup_cpu_mbus_target(&addr_map_cfg,
-				    sdram_addr_decoding_base);
-	return 0;
-}
-
-/* Using a early_initcall is needed so that this initialization gets
- * done before the SMP initialization, which requires the BootROM to
- * be remapped. */
-early_initcall(armada_setup_cpu_mbus);
diff --git a/arch/arm/mach-mvebu/armada-370-xp.c b/arch/arm/mach-mvebu/armada-370-xp.c
index a5ea616d..12d3655 100644
--- a/arch/arm/mach-mvebu/armada-370-xp.c
+++ b/arch/arm/mach-mvebu/armada-370-xp.c
@@ -19,6 +19,7 @@
 #include <linux/time-armada-370-xp.h>
 #include <linux/clk/mvebu.h>
 #include <linux/dma-mapping.h>
+#include <linux/mbus.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
@@ -48,12 +49,29 @@ void __init armada_370_xp_timer_and_clk_init(void)
 
 void __init armada_370_xp_init_early(void)
 {
+	char *mbus_soc_name;
+
 	/*
 	 * Some Armada 370/XP devices allocate their coherent buffers
 	 * from atomic context. Increase size of atomic coherent pool
 	 * to make sure such the allocations won't fail.
 	 */
 	init_dma_coherent_pool_size(SZ_1M);
+
+	/*
+	 * This initialization will be replaced by a DT-based
+	 * initialization once the mvebu-mbus driver gains DT support.
+	 */
+	if (of_machine_is_compatible("marvell,armada370"))
+		mbus_soc_name = "marvell,armada370-mbus";
+	else
+		mbus_soc_name = "marvell,armadaxp-mbus";
+
+	mvebu_mbus_init(mbus_soc_name,
+			ARMADA_370_XP_MBUS_WINS_BASE,
+			ARMADA_370_XP_MBUS_WINS_SIZE,
+			ARMADA_370_XP_SDRAM_WINS_BASE,
+			ARMADA_370_XP_SDRAM_WINS_SIZE);
 }
 
 static void __init armada_370_xp_dt_init(void)
diff --git a/arch/arm/mach-mvebu/armada-370-xp.h b/arch/arm/mach-mvebu/armada-370-xp.h
index c6a7d74..9783087 100644
--- a/arch/arm/mach-mvebu/armada-370-xp.h
+++ b/arch/arm/mach-mvebu/armada-370-xp.h
@@ -19,6 +19,12 @@
 #define ARMADA_370_XP_REGS_VIRT_BASE	IOMEM(0xfeb00000)
 #define ARMADA_370_XP_REGS_SIZE		SZ_1M
 
+/* These defines can go away once mvebu-mbus has a DT binding */
+#define ARMADA_370_XP_MBUS_WINS_BASE    (ARMADA_370_XP_REGS_PHYS_BASE + 0x20000)
+#define ARMADA_370_XP_MBUS_WINS_SIZE    0x100
+#define ARMADA_370_XP_SDRAM_WINS_BASE   (ARMADA_370_XP_REGS_PHYS_BASE + 0x20180)
+#define ARMADA_370_XP_SDRAM_WINS_SIZE   0x20
+
 #ifdef CONFIG_SMP
 #include <linux/cpumask.h>
 
diff --git a/arch/arm/mach-mvebu/platsmp.c b/arch/arm/mach-mvebu/platsmp.c
index fe16aaf..875ea74 100644
--- a/arch/arm/mach-mvebu/platsmp.c
+++ b/arch/arm/mach-mvebu/platsmp.c
@@ -21,6 +21,7 @@
 #include <linux/smp.h>
 #include <linux/clk.h>
 #include <linux/of.h>
+#include <linux/mbus.h>
 #include <asm/cacheflush.h>
 #include <asm/smp_plat.h>
 #include "common.h"
@@ -109,6 +110,7 @@ void __init armada_xp_smp_prepare_cpus(unsigned int max_cpus)
 	set_secondary_cpus_clock();
 	flush_cache_all();
 	set_cpu_coherent(cpu_logical_map(smp_processor_id()), 0);
+	mvebu_mbus_add_window("bootrom", 0xfff00000, SZ_1M);
 }
 
 struct smp_operations armada_xp_smp_ops __initdata = {
diff --git a/arch/arm/plat-orion/Makefile b/arch/arm/plat-orion/Makefile
index ad97400..6cfc89f 100644
--- a/arch/arm/plat-orion/Makefile
+++ b/arch/arm/plat-orion/Makefile
@@ -3,7 +3,6 @@
 #
 ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include
 
-obj-$(CONFIG_ARCH_MVEBU)          += addr-map.o
 obj-$(CONFIG_ARCH_KIRKWOOD)       += addr-map.o
 obj-$(CONFIG_ARCH_DOVE)           += addr-map.o
 obj-$(CONFIG_ARCH_ORION5X)        += addr-map.o
-- 
1.7.9.5
