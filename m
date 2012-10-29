From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 29 Oct 2012 18:25:57 +0800
Subject: [PATCH V2 2/2] ARM: tegra: common: using OF api for L2 cache init
Message-ID: <1351506357-32591-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Moving L2 cache init to DT support.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V2:
* no changes
---
 arch/arm/mach-tegra/common.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
index 177f164..d2d6dbb 100644
--- a/arch/arm/mach-tegra/common.c
+++ b/arch/arm/mach-tegra/common.c
@@ -113,20 +113,17 @@ static __initdata struct tegra_clk_init_table tegra30_clk_init_table[] = {
 #endif
 
 
-static void __init tegra_init_cache(u32 tag_latency, u32 data_latency)
+static void __init tegra_init_cache(void)
 {
 #ifdef CONFIG_CACHE_L2X0
 	void __iomem *p = IO_ADDRESS(TEGRA_ARM_PERIF_BASE) + 0x3000;
 	u32 aux_ctrl, cache_type;
 
-	writel_relaxed(tag_latency, p + L2X0_TAG_LATENCY_CTRL);
-	writel_relaxed(data_latency, p + L2X0_DATA_LATENCY_CTRL);
-
 	cache_type = readl(p + L2X0_CACHE_TYPE);
 	aux_ctrl = (cache_type & 0x700) << (17-8);
 	aux_ctrl |= 0x6C000001;
 
-	l2x0_init(p, aux_ctrl, 0x8200c3fe);
+	l2x0_of_init(aux_ctrl, 0x8200c3fe);
 #endif
 
 }
@@ -138,7 +135,7 @@ void __init tegra20_init_early(void)
 	tegra_init_fuse();
 	tegra2_init_clocks();
 	tegra_clk_init_from_table(tegra20_clk_init_table);
-	tegra_init_cache(0x331, 0x441);
+	tegra_init_cache();
 	tegra_pmc_init();
 	tegra_powergate_init();
 	tegra20_hotplug_init();
@@ -151,7 +148,7 @@ void __init tegra30_init_early(void)
 	tegra_init_fuse();
 	tegra30_init_clocks();
 	tegra_clk_init_from_table(tegra30_clk_init_table);
-	tegra_init_cache(0x441, 0x551);
+	tegra_init_cache();
 	tegra_pmc_init();
 	tegra_powergate_init();
 	tegra30_hotplug_init();
-- 
1.7.0.4
