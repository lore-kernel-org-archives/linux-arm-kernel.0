From: mike@compulab.co.il (Mike Rapoport)
Date: Wed,  2 Mar 2011 14:34:05 +0200
Subject: [PATCH 2/3] ARM: tegra: add PCI Express power gating
In-Reply-To: <cover.1299068166.git.mike@compulab.co.il>
References: <cover.1299068166.git.mike@compulab.co.il>
Message-ID: <44cb94cf53fb0785991972c4f24cca6d8111d465.1299068166.git.mike@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/mach-tegra/pcie.c |   22 ++++++++++++++++++++--
 1 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/pcie.c b/arch/arm/mach-tegra/pcie.c
index 6de5ef4..2941212 100644
--- a/arch/arm/mach-tegra/pcie.c
+++ b/arch/arm/mach-tegra/pcie.c
@@ -39,6 +39,7 @@
 #include <mach/pinmux.h>
 #include <mach/iomap.h>
 #include <mach/clk.h>
+#include <mach/powergate.h>
 
 /* register definitions */
 #define AFI_OFFSET	0x3800
@@ -688,13 +689,30 @@ static void tegra_pcie_power_off(void)
 	tegra_periph_reset_assert(tegra_pcie.afi_clk);
 	tegra_periph_reset_assert(tegra_pcie.pex_clk);
 
+	tegra_powergate_power_off(TEGRA_POWERGATE_PCIE);
 	tegra_pcie_xclk_clamp(true);
 }
 
-static int tegra_pcie_power_on(void)
+static int tegra_pcie_power_regate(void)
 {
+	int err;
+
+	tegra_pcie_power_off();
+
 	tegra_pcie_xclk_clamp(true);
+
 	tegra_periph_reset_assert(tegra_pcie.pcie_xclk);
+	tegra_periph_reset_assert(tegra_pcie.afi_clk);
+
+	err = tegra_powergate_sequence_power_up(TEGRA_POWERGATE_PCIE,
+						tegra_pcie.pex_clk);
+	if (err) {
+		pr_err("PCIE: powerup sequence failed: %d\n", err);
+		return err;
+	}
+
+	tegra_periph_reset_deassert(tegra_pcie.afi_clk);
+
 	tegra_pcie_xclk_clamp(false);
 
 	clk_enable(tegra_pcie.afi_clk);
@@ -759,7 +777,7 @@ static int __init tegra_pcie_get_resources(void)
 		return err;
 	}
 
-	err = tegra_pcie_power_on();
+	err = tegra_pcie_power_regate();
 	if (err) {
 		pr_err("PCIE: failed to power up: %d\n", err);
 		goto err_pwr_on;
-- 
1.7.3.1
