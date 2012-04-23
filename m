From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Mon, 23 Apr 2012 11:31:49 +0300
Subject: [PATCH] ARM: tegra: Initialize pll_p_out1
Message-ID: <1335169910-29403-1-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pll_a uses pll_p_out1 as its parent. Therefore this clock needs to be
initialized to make sure pll_a has a known input clock. Failure to do so
will cause the system to crash early in the bootup.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>

--

Changes in v2:

* moved pll_p_out1 initialization to early_init to make it similar to the
  tegra20 code.
---
 arch/arm/mach-tegra/common.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
index c50f2ee..654a457 100644
--- a/arch/arm/mach-tegra/common.c
+++ b/arch/arm/mach-tegra/common.c
@@ -95,6 +95,17 @@ static __initdata struct tegra_clk_init_table tegra20_clk_init_table[] = {
 };
 #endif
 
+#ifdef CONFIG_ARCH_TEGRA_3x_SOC
+static __initdata struct tegra_clk_init_table tegra30_clk_init_table[] = {
+	/* name		parent		rate		enabled */
+	{ "clk_m",	NULL,		0,		true },
+	{ "pll_p",	"clk_m",	408000000,	true },
+	{ "pll_p_out1",	"pll_p",	9600000,	true },
+	{ NULL,		NULL,		0,		0},
+};
+#endif
+
+
 static void __init tegra_init_cache(u32 tag_latency, u32 data_latency)
 {
 #ifdef CONFIG_CACHE_L2X0
@@ -129,6 +140,7 @@ void __init tegra30_init_early(void)
 {
 	tegra_init_fuse();
 	tegra30_init_clocks();
+	tegra_clk_init_from_table(tegra30_clk_init_table);
 	tegra_init_cache(0x441, 0x551);
 	tegra_pmc_init();
 	tegra_powergate_init();
-- 
1.7.7.rc0.72.g4b5ea.dirty
