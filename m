From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri,  3 Aug 2012 16:13:53 +0200
Subject: [PATCH 1/5] arm: plat-orion: use 'void __iomem *' in addr-map code
In-Reply-To: <1344003237-13575-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1344003237-13575-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1344003237-13575-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use 'void __iomem *' instead of u32 where appropriate in the addr-map
code. It requires adding a few casts in SoC-specific addr-map.c files,
but those casts will disappear once those SoC are migrated to the
device tree, in which case the address will come from the DT instead
of from #define values.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-dove/addr-map.c               |    2 +-
 arch/arm/mach-kirkwood/addr-map.c           |    5 +++--
 arch/arm/mach-mv78xx0/addr-map.c            |    4 ++--
 arch/arm/mach-orion5x/addr-map.c            |    5 +++--
 arch/arm/plat-orion/addr-map.c              |   11 ++++-------
 arch/arm/plat-orion/include/plat/addr-map.h |    4 ++--
 6 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-dove/addr-map.c b/arch/arm/mach-dove/addr-map.c
index 2a06c01..adb428e 100644
--- a/arch/arm/mach-dove/addr-map.c
+++ b/arch/arm/mach-dove/addr-map.c
@@ -47,7 +47,7 @@ static inline void __iomem *ddr_map_sc(int i)
 static struct __initdata orion_addr_map_cfg addr_map_cfg = {
 	.num_wins = 8,
 	.remappable_wins = 4,
-	.bridge_virt_base = BRIDGE_VIRT_BASE,
+	.bridge_virt_base = (void __iomem *) BRIDGE_VIRT_BASE,
 };
 
 static const struct __initdata orion_addr_map_info addr_map_info[] = {
diff --git a/arch/arm/mach-kirkwood/addr-map.c b/arch/arm/mach-kirkwood/addr-map.c
index e9a7180..2b27de6 100644
--- a/arch/arm/mach-kirkwood/addr-map.c
+++ b/arch/arm/mach-kirkwood/addr-map.c
@@ -41,7 +41,7 @@
 static struct __initdata orion_addr_map_cfg addr_map_cfg = {
 	.num_wins = 8,
 	.remappable_wins = 4,
-	.bridge_virt_base = BRIDGE_VIRT_BASE,
+	.bridge_virt_base = (void __iomem *) BRIDGE_VIRT_BASE,
 };
 
 static const struct __initdata orion_addr_map_info addr_map_info[] = {
@@ -86,5 +86,6 @@ void __init kirkwood_setup_cpu_mbus(void)
 	/*
 	 * Setup MBUS dram target info.
 	 */
-	orion_setup_cpu_mbus_target(&addr_map_cfg, DDR_WINDOW_CPU_BASE);
+	orion_setup_cpu_mbus_target(&addr_map_cfg,
+				    (void __iomem *) DDR_WINDOW_CPU_BASE);
 }
diff --git a/arch/arm/mach-mv78xx0/addr-map.c b/arch/arm/mach-mv78xx0/addr-map.c
index 62b53d7..bac31e4 100644
--- a/arch/arm/mach-mv78xx0/addr-map.c
+++ b/arch/arm/mach-mv78xx0/addr-map.c
@@ -71,10 +71,10 @@ void __init mv78xx0_setup_cpu_mbus(void)
 	 */
 	if (mv78xx0_core_index() == 0)
 		orion_setup_cpu_mbus_target(&addr_map_cfg,
-					    DDR_WINDOW_CPU0_BASE);
+					    (void __iomem *) DDR_WINDOW_CPU0_BASE);
 	else
 		orion_setup_cpu_mbus_target(&addr_map_cfg,
-					    DDR_WINDOW_CPU1_BASE);
+					    (void __iomem *) DDR_WINDOW_CPU1_BASE);
 }
 
 void __init mv78xx0_setup_pcie_io_win(int window, u32 base, u32 size,
diff --git a/arch/arm/mach-orion5x/addr-map.c b/arch/arm/mach-orion5x/addr-map.c
index eaac83d..bfe4f10 100644
--- a/arch/arm/mach-orion5x/addr-map.c
+++ b/arch/arm/mach-orion5x/addr-map.c
@@ -79,7 +79,7 @@ static int __init cpu_win_can_remap(const struct orion_addr_map_cfg *cfg,
 static struct orion_addr_map_cfg addr_map_cfg __initdata = {
 	.num_wins = 8,
 	.cpu_win_can_remap = cpu_win_can_remap,
-	.bridge_virt_base = ORION5X_BRIDGE_VIRT_BASE,
+	.bridge_virt_base = (void __iomem *) ORION5X_BRIDGE_VIRT_BASE,
 };
 
 static const struct __initdata orion_addr_map_info addr_map_info[] = {
@@ -113,7 +113,8 @@ void __init orion5x_setup_cpu_mbus_bridge(void)
 	/*
 	 * Setup MBUS dram target info.
 	 */
-	orion_setup_cpu_mbus_target(&addr_map_cfg, ORION5X_DDR_WINDOW_CPU_BASE);
+	orion_setup_cpu_mbus_target(&addr_map_cfg,
+				    (void __iomem *) ORION5X_DDR_WINDOW_CPU_BASE);
 }
 
 void __init orion5x_setup_dev_boot_win(u32 base, u32 size)
diff --git a/arch/arm/plat-orion/addr-map.c b/arch/arm/plat-orion/addr-map.c
index 367ca89..a7b8060 100644
--- a/arch/arm/plat-orion/addr-map.c
+++ b/arch/arm/plat-orion/addr-map.c
@@ -48,7 +48,7 @@ EXPORT_SYMBOL_GPL(mv_mbus_dram_info);
 static void __init __iomem *
 orion_win_cfg_base(const struct orion_addr_map_cfg *cfg, int win)
 {
-	return (void __iomem *)(cfg->bridge_virt_base + (win << 4));
+	return cfg->bridge_virt_base + (win << 4);
 }
 
 /*
@@ -143,19 +143,16 @@ void __init orion_config_wins(struct orion_addr_map_cfg * cfg,
  * Setup MBUS dram target info.
  */
 void __init orion_setup_cpu_mbus_target(const struct orion_addr_map_cfg *cfg,
-					const u32 ddr_window_cpu_base)
+					const void __iomem *ddr_window_cpu_base)
 {
-	void __iomem *addr;
 	int i;
 	int cs;
 
 	orion_mbus_dram_info.mbus_dram_target_id = TARGET_DDR;
 
-	addr = (void __iomem *)ddr_window_cpu_base;
-
 	for (i = 0, cs = 0; i < 4; i++) {
-		u32 base = readl(addr + DDR_BASE_CS_OFF(i));
-		u32 size = readl(addr + DDR_SIZE_CS_OFF(i));
+		u32 base = readl(ddr_window_cpu_base + DDR_BASE_CS_OFF(i));
+		u32 size = readl(ddr_window_cpu_base + DDR_SIZE_CS_OFF(i));
 
 		/*
 		 * Chip select enabled?
diff --git a/arch/arm/plat-orion/include/plat/addr-map.h b/arch/arm/plat-orion/include/plat/addr-map.h
index fd556f7..0a746fd 100644
--- a/arch/arm/plat-orion/include/plat/addr-map.h
+++ b/arch/arm/plat-orion/include/plat/addr-map.h
@@ -16,7 +16,7 @@ extern struct mbus_dram_target_info orion_mbus_dram_info;
 struct orion_addr_map_cfg {
 	const int num_wins;	/* Total number of windows */
 	const int remappable_wins;
-	const u32 bridge_virt_base;
+	void __iomem * const bridge_virt_base;
 
 	/* If NULL, the default cpu_win_can_remap will be used, using
 	   the value in remappable_wins */
@@ -49,5 +49,5 @@ void __init orion_setup_cpu_win(const struct orion_addr_map_cfg *cfg,
 				const u8 attr, const int remap);
 
 void __init orion_setup_cpu_mbus_target(const struct orion_addr_map_cfg *cfg,
-					const u32 ddr_window_cpu_base);
+					const void __iomem *ddr_window_cpu_base);
 #endif
-- 
1.7.9.5
