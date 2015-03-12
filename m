From: vinceh@nvidia.com (Vince Hsu)
Date: Thu, 12 Mar 2015 20:15:14 +0800
Subject: [PATCH v2 13/17] PCI: tegra: remove the power sequence from driver
In-Reply-To: <1426162518-7405-1-git-send-email-vinceh@nvidia.com>
References: <1426162518-7405-1-git-send-email-vinceh@nvidia.com>
Message-ID: <1426162518-7405-14-git-send-email-vinceh@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have the generic PM domain support for Tegra SoCs now. So remove the
duplicated power sequence here.

Signed-off-by: Vince Hsu <vinceh@nvidia.com>
---
v2: enable pex clock when powering on

 drivers/pci/host/pci-tegra.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 00e92720d7f7..b1e2794d6dfa 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -931,12 +931,6 @@ static void tegra_pcie_power_off(struct tegra_pcie *pcie)
 	if (err < 0)
 		dev_warn(pcie->dev, "failed to power off PHY: %d\n", err);
 
-	reset_control_assert(pcie->pcie_xrst);
-	reset_control_assert(pcie->afi_rst);
-	reset_control_assert(pcie->pex_rst);
-
-	tegra_powergate_power_off(TEGRA_POWERGATE_PCIE);
-
 	err = regulator_bulk_disable(pcie->num_supplies, pcie->supplies);
 	if (err < 0)
 		dev_warn(pcie->dev, "failed to disable regulators: %d\n", err);
@@ -947,27 +941,17 @@ static int tegra_pcie_power_on(struct tegra_pcie *pcie)
 	const struct tegra_pcie_soc_data *soc = pcie->soc_data;
 	int err;
 
-	reset_control_assert(pcie->pcie_xrst);
-	reset_control_assert(pcie->afi_rst);
-	reset_control_assert(pcie->pex_rst);
-
-	tegra_powergate_power_off(TEGRA_POWERGATE_PCIE);
-
 	/* enable regulators */
 	err = regulator_bulk_enable(pcie->num_supplies, pcie->supplies);
 	if (err < 0)
 		dev_err(pcie->dev, "failed to enable regulators: %d\n", err);
 
-	err = tegra_powergate_sequence_power_up(TEGRA_POWERGATE_PCIE,
-						pcie->pex_clk,
-						pcie->pex_rst);
-	if (err) {
-		dev_err(pcie->dev, "powerup sequence failed: %d\n", err);
+	err = clk_prepare_enable(pcie->pex_clk);
+	if (err < 0) {
+		dev_err(pcie->dev, "failed to enable PEX clock: %d\n", err);
 		return err;
 	}
 
-	reset_control_deassert(pcie->afi_rst);
-
 	err = clk_prepare_enable(pcie->afi_clk);
 	if (err < 0) {
 		dev_err(pcie->dev, "failed to enable AFI clock: %d\n", err);
-- 
2.1.4
