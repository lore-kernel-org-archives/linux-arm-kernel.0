From: gerg@uclinux.org (Greg Ungerer)
Date: Tue, 30 Jun 2015 23:52:54 +1000
Subject: [PATCH for 3.14.y] bus: mvebu: pass the coherency availability
 information at init time
Message-ID: <1435672374-29209-1-git-send-email-gerg@uclinux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 5686a1e5aa436c49187a60052d5885fb1f541ce6 upstream.

Until now, the mvebu-mbus was guessing by itself whether hardware I/O
coherency was available or not by poking into the Device Tree to see
if the coherency fabric Device Tree node was present or not.

However, on some upcoming SoCs, the presence or absence of the
coherency fabric DT node isn't sufficient: in CONFIG_SMP, the
coherency can be enabled, but not in !CONFIG_SMP.

In order to clean this up, the mvebu_mbus_dt_init() function is
extended to get a boolean argument telling whether coherency is
enabled or not. Therefore, the logic to decide whether coherency is
available or not now belongs to the core SoC code instead of the
mvebu-mbus driver itself, which is much better.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Link: https://lkml.kernel.org/r/1397483228-25625-4-git-send-email-thomas.petazzoni at free-electrons.com
Signed-off-by: Jason Cooper <jason@lakedaemon.net>

[ Greg Ungerer: back ported to linux-3.14.y
  Back port necessary due to large code differences in affected files.
  This change in combination with commit e553554536 ("ARM: mvebu: disable
  I/O coherency on non-SMP situations on Armada 370/375/38x/XP") is
  critical to the hardware I/O coherency being set correctly by both the
  mbus driver and all peripheral hardware drivers. Without this change
  drivers will incorrectly enable I/O coherency window attributes and
  this causes rare unreliable system behavior including oops. ]

Signed-off-by: Greg Ungerer <gerg@uclinux.org>
---
 arch/arm/mach-dove/board-dt.c       |  2 +-
 arch/arm/mach-kirkwood/board-dt.c   |  2 +-
 arch/arm/mach-mvebu/armada-370-xp.c |  2 +-
 arch/arm/mach-mvebu/coherency.c     | 15 +++++++++++++++
 arch/arm/mach-mvebu/coherency.h     |  1 +
 drivers/bus/mvebu-mbus.c            | 11 +++--------
 include/linux/mbus.h                |  2 +-
 7 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-dove/board-dt.c b/arch/arm/mach-dove/board-dt.c
index 49fa9ab..7a7a09a5 100644
--- a/arch/arm/mach-dove/board-dt.c
+++ b/arch/arm/mach-dove/board-dt.c
@@ -26,7 +26,7 @@ static void __init dove_dt_init(void)
 #ifdef CONFIG_CACHE_TAUROS2
 	tauros2_init(0);
 #endif
-	BUG_ON(mvebu_mbus_dt_init());
+	BUG_ON(mvebu_mbus_dt_init(false));
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index 7818815..79e629d 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -116,7 +116,7 @@ static void __init kirkwood_dt_init(void)
 	 */
 	writel(readl(CPU_CONFIG) & ~CPU_CONFIG_ERROR_PROP, CPU_CONFIG);
 
-	BUG_ON(mvebu_mbus_dt_init());
+	BUG_ON(mvebu_mbus_dt_init(false));
 
 	kirkwood_l2_init();
 
diff --git a/arch/arm/mach-mvebu/armada-370-xp.c b/arch/arm/mach-mvebu/armada-370-xp.c
index f6c9d1d..79c3766a 100644
--- a/arch/arm/mach-mvebu/armada-370-xp.c
+++ b/arch/arm/mach-mvebu/armada-370-xp.c
@@ -41,7 +41,7 @@ static void __init armada_370_xp_timer_and_clk_init(void)
 	of_clk_init(NULL);
 	clocksource_of_init();
 	coherency_init();
-	BUG_ON(mvebu_mbus_dt_init());
+	BUG_ON(mvebu_mbus_dt_init(coherency_available()));
 #ifdef CONFIG_CACHE_L2X0
 	l2x0_of_init(0, ~0UL);
 #endif
diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
index c295c10..49bad4d 100644
--- a/arch/arm/mach-mvebu/coherency.c
+++ b/arch/arm/mach-mvebu/coherency.c
@@ -121,6 +121,20 @@ static struct notifier_block mvebu_hwcc_platform_nb = {
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
@@ -164,6 +178,7 @@ int __init coherency_init(void)
 		coherency_base = of_iomap(np, 0);
 		coherency_cpu_base = of_iomap(np, 1);
 		set_cpu_coherent(cpu_logical_map(smp_processor_id()), 0);
+		coherency_enabled = 1;
 		of_node_put(np);
 	}
 
diff --git a/arch/arm/mach-mvebu/coherency.h b/arch/arm/mach-mvebu/coherency.h
index 760226c..63e18c6 100644
--- a/arch/arm/mach-mvebu/coherency.h
+++ b/arch/arm/mach-mvebu/coherency.h
@@ -17,6 +17,7 @@
 extern unsigned long coherency_phys_base;
 
 int set_cpu_coherent(unsigned int cpu_id, int smp_group_id);
+int coherency_available(void);
 int coherency_init(void);
 
 #endif	/* __MACH_370_XP_COHERENCY_H */
diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index e990dee..1aa0130 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -701,7 +701,6 @@ static int __init mvebu_mbus_common_init(struct mvebu_mbus_state *mbus,
 					 phys_addr_t sdramwins_phys_base,
 					 size_t sdramwins_size)
 {
-	struct device_node *np;
 	int win;
 
 	mbus->mbuswins_base = ioremap(mbuswins_phys_base, mbuswins_size);
@@ -714,12 +713,6 @@ static int __init mvebu_mbus_common_init(struct mvebu_mbus_state *mbus,
 		return -ENOMEM;
 	}
 
-	np = of_find_compatible_node(NULL, NULL, "marvell,coherency-fabric");
-	if (np) {
-		mbus->hw_io_coherency = 1;
-		of_node_put(np);
-	}
-
 	for (win = 0; win < mbus->soc->num_wins; win++)
 		mvebu_mbus_disable_window(mbus, win);
 
@@ -889,7 +882,7 @@ static void __init mvebu_mbus_get_pcie_resources(struct device_node *np,
 	}
 }
 
-int __init mvebu_mbus_dt_init(void)
+int __init mvebu_mbus_dt_init(bool is_coherent)
 {
 	struct resource mbuswins_res, sdramwins_res;
 	struct device_node *np, *controller;
@@ -928,6 +921,8 @@ int __init mvebu_mbus_dt_init(void)
 		return -EINVAL;
 	}
 
+	mbus_state.hw_io_coherency = is_coherent;
+
 	/* Get optional pcie-{mem,io}-aperture properties */
 	mvebu_mbus_get_pcie_resources(np, &mbus_state.pcie_mem_aperture,
 					  &mbus_state.pcie_io_aperture);
diff --git a/include/linux/mbus.h b/include/linux/mbus.h
index 345b8c5..550c88f 100644
--- a/include/linux/mbus.h
+++ b/include/linux/mbus.h
@@ -73,6 +73,6 @@ int mvebu_mbus_del_window(phys_addr_t base, size_t size);
 int mvebu_mbus_init(const char *soc, phys_addr_t mbus_phys_base,
 		    size_t mbus_size, phys_addr_t sdram_phys_base,
 		    size_t sdram_size);
-int mvebu_mbus_dt_init(void);
+int mvebu_mbus_dt_init(bool is_coherent);
 
 #endif /* __LINUX_MBUS_H */
-- 
1.9.1
