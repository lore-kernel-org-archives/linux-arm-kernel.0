From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu,  6 Mar 2014 17:46:28 +0100
Subject: [PATCH 03/10] bus: mvebu: pass the coherency availability information
 at init time
In-Reply-To: <1394124395-20030-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1394124395-20030-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1394124395-20030-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
---
 arch/arm/mach-kirkwood/board-dt.c |  2 +-
 arch/arm/mach-mvebu/board-v7.c    |  2 +-
 drivers/bus/mvebu-mbus.c          | 11 +++--------
 include/linux/mbus.h              |  2 +-
 4 files changed, 6 insertions(+), 11 deletions(-)

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
 
diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
index 95ca216..e5d4f69 100644
--- a/arch/arm/mach-mvebu/board-v7.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@ -62,7 +62,7 @@ static void __init mvebu_timer_and_clk_init(void)
 	of_clk_init(NULL);
 	clocksource_of_init();
 	coherency_init();
-	BUG_ON(mvebu_mbus_dt_init());
+	BUG_ON(mvebu_mbus_dt_init(coherency_available()));
 #ifdef CONFIG_CACHE_L2X0
 	l2x0_of_init(0, ~0UL);
 #endif
diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index 725c461..67710b8 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -694,7 +694,6 @@ static int __init mvebu_mbus_common_init(struct mvebu_mbus_state *mbus,
 					 phys_addr_t sdramwins_phys_base,
 					 size_t sdramwins_size)
 {
-	struct device_node *np;
 	int win;
 
 	mbus->mbuswins_base = ioremap(mbuswins_phys_base, mbuswins_size);
@@ -707,12 +706,6 @@ static int __init mvebu_mbus_common_init(struct mvebu_mbus_state *mbus,
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
 
@@ -882,7 +875,7 @@ static void __init mvebu_mbus_get_pcie_resources(struct device_node *np,
 	}
 }
 
-int __init mvebu_mbus_dt_init(void)
+int __init mvebu_mbus_dt_init(bool is_coherent)
 {
 	struct resource mbuswins_res, sdramwins_res;
 	struct device_node *np, *controller;
@@ -921,6 +914,8 @@ int __init mvebu_mbus_dt_init(void)
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
1.8.3.2
