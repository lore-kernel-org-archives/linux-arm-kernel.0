From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 10 Sep 2012 17:12:37 -0600
Subject: [PATCH 1/2] ARM: tegra: fix overflow in tegra20_pll_clk_round_rate()
Message-ID: <1347318758-7954-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

32-bit math isn't enough when e.g. *prate=12000000, and sel->n=1000.
Use 64-bit math to prevent this.

Cc: Prashant Gaikwad <pgaikwad@nvidia.com>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
Prashant, can you please audit all of the Tegra clock driver to see if
there are any other instances of the same issue? Thanks.
---
 arch/arm/mach-tegra/tegra20_clocks.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-tegra/tegra20_clocks.c b/arch/arm/mach-tegra/tegra20_clocks.c
index ee6922b..e2a43e4 100644
--- a/arch/arm/mach-tegra/tegra20_clocks.c
+++ b/arch/arm/mach-tegra/tegra20_clocks.c
@@ -798,7 +798,7 @@ static long tegra20_pll_clk_round_rate(struct clk_hw *hw, unsigned long rate,
 	struct clk_tegra *c = to_clk_tegra(hw);
 	const struct clk_pll_freq_table *sel;
 	unsigned long input_rate = *prate;
-	unsigned long output_rate = *prate;
+	u64 output_rate = *prate;
 	int mul;
 	int div;
 
-- 
1.7.0.4
