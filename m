From: josephl@nvidia.com (Joseph Lo)
Date: Fri, 17 Aug 2012 14:51:21 +0800
Subject: [PATCH] ARM: tegra: clocks: separate tegra_clk_32k_ops from Tegra20
 and Tegra30
Message-ID: <1345186281-3859-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the tegra20 and tegra30 share the same symbol for
tegra_clk_32k_ops. This will cause a compile error when building
a tegra20-only kernel image. Add tegra_clk_32k_ops for tegra20 and
modify tegra30_clk_32k_ops for tegra30.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/mach-tegra/tegra20_clocks.c      |   10 ++++++++++
 arch/arm/mach-tegra/tegra30_clocks.c      |    2 +-
 arch/arm/mach-tegra/tegra30_clocks.h      |    2 +-
 arch/arm/mach-tegra/tegra30_clocks_data.c |    2 +-
 4 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-tegra/tegra20_clocks.c b/arch/arm/mach-tegra/tegra20_clocks.c
index b073396..ee6922b 100644
--- a/arch/arm/mach-tegra/tegra20_clocks.c
+++ b/arch/arm/mach-tegra/tegra20_clocks.c
@@ -240,6 +240,16 @@ static int clk_div16_get_divider(unsigned long parent_rate, unsigned long rate)
 	return divider_u16 - 1;
 }
 
+static unsigned long tegra_clk_fixed_recalc_rate(struct clk_hw *hw,
+		unsigned long parent_rate)
+{
+	return to_clk_tegra(hw)->fixed_rate;
+}
+
+struct clk_ops tegra_clk_32k_ops = {
+	.recalc_rate = tegra_clk_fixed_recalc_rate,
+};
+
 /* clk_m functions */
 static unsigned long tegra20_clk_m_recalc_rate(struct clk_hw *hw,
 			unsigned long prate)
diff --git a/arch/arm/mach-tegra/tegra30_clocks.c b/arch/arm/mach-tegra/tegra30_clocks.c
index b2d0864..7dad44d 100644
--- a/arch/arm/mach-tegra/tegra30_clocks.c
+++ b/arch/arm/mach-tegra/tegra30_clocks.c
@@ -489,7 +489,7 @@ static unsigned long tegra30_clk_fixed_recalc_rate(struct clk_hw *hw,
 	return to_clk_tegra(hw)->fixed_rate;
 }
 
-struct clk_ops tegra_clk_32k_ops = {
+struct clk_ops tegra30_clk_32k_ops = {
 	.recalc_rate = tegra30_clk_fixed_recalc_rate,
 };
 
diff --git a/arch/arm/mach-tegra/tegra30_clocks.h b/arch/arm/mach-tegra/tegra30_clocks.h
index aeb4e96..b08b8d9 100644
--- a/arch/arm/mach-tegra/tegra30_clocks.h
+++ b/arch/arm/mach-tegra/tegra30_clocks.h
@@ -17,7 +17,7 @@
 #ifndef __MACH_TEGRA30_CLOCK_H
 #define __MACH_TEGRA30_CLOCK_H
 
-extern struct clk_ops tegra_clk_32k_ops;
+extern struct clk_ops tegra30_clk_32k_ops;
 extern struct clk_ops tegra30_clk_m_ops;
 extern struct clk_ops tegra_clk_m_div_ops;
 extern struct clk_ops tegra_pll_ref_ops;
diff --git a/arch/arm/mach-tegra/tegra30_clocks_data.c b/arch/arm/mach-tegra/tegra30_clocks_data.c
index dad1b2f..2271ac1 100644
--- a/arch/arm/mach-tegra/tegra30_clocks_data.c
+++ b/arch/arm/mach-tegra/tegra30_clocks_data.c
@@ -58,7 +58,7 @@ static struct clk_tegra tegra_clk_32k_hw = {
 static struct clk tegra_clk_32k = {
 	.name = "clk_32k",
 	.hw = &tegra_clk_32k_hw.hw,
-	.ops = &tegra_clk_32k_ops,
+	.ops = &tegra30_clk_32k_ops,
 	.flags = CLK_IS_ROOT,
 };
 
-- 
1.7.0.4
