From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 24 Jun 2016 08:37:03 -0600
Subject: [PATCH] pci: tegra: actually program REFCLK_CFG* on recent SoCs
Message-ID: <20160624143703.13231-1-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

On recent SoCs, tegra_pcie_phy_enable() isn't called; but instead
tegra_pcie_enable_controller() calls tegra_xusb_phy_enable(). However,
part of tegra_pcie_phy_enable() needs to happen in all cases. Move that
code to tegra_pcie_port_enable() instead.

For reference, NVIDIA's downstream Linux kernel performs this operation
in tegra_pcie_enable_rp_features(), which is called immediately after
tegra_pcie_port_enable(). Since that function doesn't exist in the mainline
driver, we'll just add it to the tail of tegra_pcie_port_enable() instead.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 drivers/pci/host/pci-tegra.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 74887fedc3d4..2ec64a9e7943 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -541,12 +541,13 @@ static void tegra_pcie_port_reset(struct tegra_pcie_port *port)
 
 static void tegra_pcie_port_enable(struct tegra_pcie_port *port)
 {
-	const struct tegra_pcie_soc_data *soc = port->pcie->soc_data;
+	struct tegra_pcie *pcie = port->pcie;
+	const struct tegra_pcie_soc_data *soc = pcie->soc_data;
 	unsigned long ctrl = tegra_pcie_port_get_pex_ctrl(port);
 	unsigned long value;
 
 	/* enable reference clock */
-	value = afi_readl(port->pcie, ctrl);
+	value = afi_readl(pcie, ctrl);
 	value |= AFI_PEX_CTRL_REFCLK_EN;
 
 	if (soc->has_pex_clkreq_en)
@@ -554,9 +555,14 @@ static void tegra_pcie_port_enable(struct tegra_pcie_port *port)
 
 	value |= AFI_PEX_CTRL_OVERRIDE_EN;
 
-	afi_writel(port->pcie, value, ctrl);
+	afi_writel(pcie, value, ctrl);
 
 	tegra_pcie_port_reset(port);
+
+	/* Configure the reference clock driver */
+	pads_writel(pcie, soc->pads_refclk_cfg0, PADS_REFCLK_CFG0);
+	if (soc->num_ports > 2)
+		pads_writel(pcie, soc->pads_refclk_cfg1, PADS_REFCLK_CFG1);
 }
 
 static void tegra_pcie_port_disable(struct tegra_pcie_port *port)
@@ -831,11 +837,6 @@ static int tegra_pcie_phy_enable(struct tegra_pcie *pcie)
 	value |= PADS_PLL_CTL_RST_B4SM;
 	pads_writel(pcie, value, soc->pads_pll_ctl);
 
-	/* Configure the reference clock driver */
-	pads_writel(pcie, soc->pads_refclk_cfg0, PADS_REFCLK_CFG0);
-	if (soc->num_ports > 2)
-		pads_writel(pcie, soc->pads_refclk_cfg1, PADS_REFCLK_CFG1);
-
 	/* wait for the PLL to lock */
 	err = tegra_pcie_pll_wait(pcie, 500);
 	if (err < 0) {
-- 
2.9.0
