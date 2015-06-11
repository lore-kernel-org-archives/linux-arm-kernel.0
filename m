From: gerg@uclinux.org (gerg at uclinux.org)
Date: Thu, 11 Jun 2015 13:19:24 +1000
Subject: [PATCH] ARM: mvebu: pass the coherency availability information at
 init time
Message-ID: <1433992764-12753-1-git-send-email-gerg@uclinux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Greg Ungerer <gerg@uclinux.org>

This patch is specifically meant to be applied to stable tree linux-3.10.y.

IO coherency should not be used on the Armada 370 SoC, due to all
the necessary pre-requisites for reliable operation not being met
(such as write allocate cache policy, shareable pages, SMP bit set).

Commit e55355453600a33bb5ca4f71f2d7214875f3b061 ("ARM: mvebu: disable
I/O coherency on non-SMP situations on Armada 370/375/38x/XP") was
intended to disable IO coherency for the Armada 370. However it only
disables the CPU side IO coherency. The mbus driver (drivers/bus/
mvebu-mbus.c) still passes the IO coherency attributes through the
dram chip selects and onto driver memory window attributes. It
does this based on looking directly into the device tree (looking
for "marvell,coherency-fabric").

To fix we pass the coherency availability information (whether enabled
or not) to the mbus driver at init time. This is done in the same way
that it was done for mainline kernels in commit
5686a1e5aa436c49187a60052d5885fb1f541ce6 ("bus: mvebu: pass the
coherency availability information at init time").

Having the IO coherency enabled on the Armada 370 SoC causes rare
unreliable system behavior. It is not easy to consistently reproduce
problems caused by this. Best method I have seen is heavy network
load resulting in kernel dumps due to corrupted memory.

Signed-off-by: Greg Ungerer <gerg@uclinux.org>
Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-dove/common.c         |  2 +-
 arch/arm/mach-kirkwood/common.c     |  2 +-
 arch/arm/mach-mv78xx0/common.c      |  4 ++--
 arch/arm/mach-mvebu/armada-370-xp.c |  3 ++-
 arch/arm/mach-mvebu/coherency.c     | 15 +++++++++++++++
 arch/arm/mach-mvebu/coherency.h     |  1 +
 arch/arm/mach-orion5x/common.c      |  2 +-
 drivers/bus/mvebu-mbus.c            |  5 ++---
 include/linux/mbus.h                |  2 +-
 9 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
index e2b5da0..8d4f5dc 100644
--- a/arch/arm/mach-dove/common.c
+++ b/arch/arm/mach-dove/common.c
@@ -226,7 +226,7 @@ void __init dove_init_early(void)
 	orion_time_set_base(TIMER_VIRT_BASE);
 	mvebu_mbus_init("marvell,dove-mbus",
 			BRIDGE_WINS_BASE, BRIDGE_WINS_SZ,
-			DOVE_MC_WINS_BASE, DOVE_MC_WINS_SZ);
+			DOVE_MC_WINS_BASE, DOVE_MC_WINS_SZ, 0);
 }
 
 static int __init dove_find_tclk(void)
diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index f389228..4f6831e 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -530,7 +530,7 @@ void __init kirkwood_init_early(void)
 
 	mvebu_mbus_init("marvell,kirkwood-mbus",
 			BRIDGE_WINS_BASE, BRIDGE_WINS_SZ,
-			DDR_WINDOW_CPU_BASE, DDR_WINDOW_CPU_SZ);
+			DDR_WINDOW_CPU_BASE, DDR_WINDOW_CPU_SZ, 0);
 }
 
 int kirkwood_tclk;
diff --git a/arch/arm/mach-mv78xx0/common.c b/arch/arm/mach-mv78xx0/common.c
index 749a7f8..4722c98 100644
--- a/arch/arm/mach-mv78xx0/common.c
+++ b/arch/arm/mach-mv78xx0/common.c
@@ -337,11 +337,11 @@ void __init mv78xx0_init_early(void)
 	if (mv78xx0_core_index() == 0)
 		mvebu_mbus_init("marvell,mv78xx0-mbus",
 				BRIDGE_WINS_CPU0_BASE, BRIDGE_WINS_SZ,
-				DDR_WINDOW_CPU0_BASE, DDR_WINDOW_CPU_SZ);
+				DDR_WINDOW_CPU0_BASE, DDR_WINDOW_CPU_SZ, 0);
 	else
 		mvebu_mbus_init("marvell,mv78xx0-mbus",
 				BRIDGE_WINS_CPU1_BASE, BRIDGE_WINS_SZ,
-				DDR_WINDOW_CPU1_BASE, DDR_WINDOW_CPU_SZ);
+				DDR_WINDOW_CPU1_BASE, DDR_WINDOW_CPU_SZ, 0);
 }
 
 void __init_refok mv78xx0_timer_init(void)
diff --git a/arch/arm/mach-mvebu/armada-370-xp.c b/arch/arm/mach-mvebu/armada-370-xp.c
index 1c48890..4377c34 100644
--- a/arch/arm/mach-mvebu/armada-370-xp.c
+++ b/arch/arm/mach-mvebu/armada-370-xp.c
@@ -66,7 +66,8 @@ void __init armada_370_xp_init_early(void)
 			ARMADA_370_XP_MBUS_WINS_BASE,
 			ARMADA_370_XP_MBUS_WINS_SIZE,
 			ARMADA_370_XP_SDRAM_WINS_BASE,
-			ARMADA_370_XP_SDRAM_WINS_SIZE);
+			ARMADA_370_XP_SDRAM_WINS_SIZE,
+			coherency_available());
 
 #ifdef CONFIG_CACHE_L2X0
 	l2x0_of_init(0, ~0UL);
diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
index 3ee701f..ea26ebb 100644
--- a/arch/arm/mach-mvebu/coherency.c
+++ b/arch/arm/mach-mvebu/coherency.c
@@ -137,6 +137,20 @@ static struct notifier_block mvebu_hwcc_platform_nb = {
 	.notifier_call = mvebu_hwcc_platform_notifier,
 };
 
+/*
+ * Keep track of whether we have IO hardware coherency enabled or not.
+ * On Armada 370's we will not be using it for example. We need to make
+ * that available [through coherency_available()] so the mbus controller
+ * doesn't enable the IO coherency bit in the attribute bits of the
+ * chip selects.
+ */
+static int coherency_enabled;
+
+int coherency_available(void)
+{
+	return coherency_enabled;
+}
+
 int __init coherency_init(void)
 {
 	struct device_node *np;
@@ -170,6 +184,7 @@ int __init coherency_init(void)
 		coherency_base = of_iomap(np, 0);
 		coherency_cpu_base = of_iomap(np, 1);
 		set_cpu_coherent(cpu_logical_map(smp_processor_id()), 0);
+		coherency_enabled = 1;
 		bus_register_notifier(&platform_bus_type,
 					&mvebu_hwcc_platform_nb);
 	}
diff --git a/arch/arm/mach-mvebu/coherency.h b/arch/arm/mach-mvebu/coherency.h
index 2f42813..1501a4e 100644
--- a/arch/arm/mach-mvebu/coherency.h
+++ b/arch/arm/mach-mvebu/coherency.h
@@ -19,6 +19,7 @@ int coherency_get_cpu_count(void);
 #endif
 
 int set_cpu_coherent(int cpu_id, int smp_group_id);
+int coherency_available(void);
 int coherency_init(void);
 
 #endif	/* __MACH_370_XP_COHERENCY_H */
diff --git a/arch/arm/mach-orion5x/common.c b/arch/arm/mach-orion5x/common.c
index f8a6db9..04877392 100644
--- a/arch/arm/mach-orion5x/common.c
+++ b/arch/arm/mach-orion5x/common.c
@@ -213,7 +213,7 @@ void __init orion5x_init_early(void)
 		mbus_soc_name = NULL;
 	mvebu_mbus_init(mbus_soc_name, ORION5X_BRIDGE_WINS_BASE,
 			ORION5X_BRIDGE_WINS_SZ,
-			ORION5X_DDR_WINS_BASE, ORION5X_DDR_WINS_SZ);
+			ORION5X_DDR_WINS_BASE, ORION5X_DDR_WINS_SZ, 0);
 }
 
 void orion5x_setup_wins(void)
diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index 711dcf4..7c43782 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -838,7 +838,7 @@ fs_initcall(mvebu_mbus_debugfs_init);
 int __init mvebu_mbus_init(const char *soc, phys_addr_t mbuswins_phys_base,
 			   size_t mbuswins_size,
 			   phys_addr_t sdramwins_phys_base,
-			   size_t sdramwins_size)
+			   size_t sdramwins_size, int is_coherent)
 {
 	struct mvebu_mbus_state *mbus = &mbus_state;
 	const struct of_device_id *of_id;
@@ -865,8 +865,7 @@ int __init mvebu_mbus_init(const char *soc, phys_addr_t mbuswins_phys_base,
 		return -ENOMEM;
 	}
 
-	if (of_find_compatible_node(NULL, NULL, "marvell,coherency-fabric"))
-		mbus->hw_io_coherency = 1;
+	mbus->hw_io_coherency = is_coherent;
 
 	for (win = 0; win < mbus->soc->num_wins; win++)
 		mvebu_mbus_disable_window(mbus, win);
diff --git a/include/linux/mbus.h b/include/linux/mbus.h
index dba482e..e80b9c7 100644
--- a/include/linux/mbus.h
+++ b/include/linux/mbus.h
@@ -67,6 +67,6 @@ int mvebu_mbus_add_window(const char *devname, phys_addr_t base,
 int mvebu_mbus_del_window(phys_addr_t base, size_t size);
 int mvebu_mbus_init(const char *soc, phys_addr_t mbus_phys_base,
 		    size_t mbus_size, phys_addr_t sdram_phys_base,
-		    size_t sdram_size);
+		    size_t sdram_size, int is_coherent);
 
 #endif /* __LINUX_MBUS_H */
-- 
1.9.1
