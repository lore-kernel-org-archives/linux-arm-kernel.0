From: mike@compulab.co.il (Mike Rapoport)
Date: Wed,  2 Mar 2011 14:34:04 +0200
Subject: [PATCH 1/3] ARM: tegra: PCIE minor code refactoring
In-Reply-To: <cover.1299068166.git.mike@compulab.co.il>
References: <cover.1299068166.git.mike@compulab.co.il>
Message-ID: <14be7b76cf6dd9e3ce6a77ed86a11525581bfaa1.1299068166.git.mike@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move tegra_pcie_power_off before tegra_pcie_power_on for clean addition
of PCIE power gating

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/mach-tegra/pcie.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-tegra/pcie.c b/arch/arm/mach-tegra/pcie.c
index 53f5fa3..6de5ef4 100644
--- a/arch/arm/mach-tegra/pcie.c
+++ b/arch/arm/mach-tegra/pcie.c
@@ -682,6 +682,15 @@ static void tegra_pcie_xclk_clamp(bool clamp)
 	pmc_writel(reg, PMC_SCRATCH42);
 }
 
+static void tegra_pcie_power_off(void)
+{
+	tegra_periph_reset_assert(tegra_pcie.pcie_xclk);
+	tegra_periph_reset_assert(tegra_pcie.afi_clk);
+	tegra_periph_reset_assert(tegra_pcie.pex_clk);
+
+	tegra_pcie_xclk_clamp(true);
+}
+
 static int tegra_pcie_power_on(void)
 {
 	tegra_pcie_xclk_clamp(true);
@@ -693,15 +702,6 @@ static int tegra_pcie_power_on(void)
 	return clk_enable(tegra_pcie.pll_e);
 }
 
-static void tegra_pcie_power_off(void)
-{
-	tegra_periph_reset_assert(tegra_pcie.pcie_xclk);
-	tegra_periph_reset_assert(tegra_pcie.afi_clk);
-	tegra_periph_reset_assert(tegra_pcie.pex_clk);
-
-	tegra_pcie_xclk_clamp(true);
-}
-
 static int tegra_pcie_clocks_get(void)
 {
 	int err;
-- 
1.7.3.1
