From: tyler@opensourcefoundries.com (tyler at opensourcefoundries.com)
Date: Thu, 30 Nov 2017 12:14:34 -0800
Subject: [PATCH 8/8] PCIe: imx6: imx7d: add support for phy refclk source
In-Reply-To: <20171130201434.14122-1-tyler@opensourcefoundries.com>
References: <20171130201434.14122-1-tyler@opensourcefoundries.com>
Message-ID: <20171130201434.14122-9-tyler@opensourcefoundries.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tyler Baker <tyler@opensourcefoundries.com>

In the i.MX7D the PCIe PHY can use either externel oscillator or
internal PLL as a reference clock source.
Add support for the PHY Reference Clock source including
device tree property phy-ref-clk.
External oscillator is used as a default reference clock source.

Signed-off-by: Tyler Baker <tyler@opensourcefoundries.com>
Signed-off-by: Ilya Ledvich <ilya@compulab.co.il>
---
 drivers/pci/dwc/pci-imx6.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/dwc/pci-imx6.c b/drivers/pci/dwc/pci-imx6.c
index b734835..e935db4 100644
--- a/drivers/pci/dwc/pci-imx6.c
+++ b/drivers/pci/dwc/pci-imx6.c
@@ -45,6 +45,7 @@ enum imx6_pcie_variants {
 struct imx6_pcie {
 	struct dw_pcie		*pci;
 	int			reset_gpio;
+	u32			phy_refclk;
 	bool			gpio_active_high;
 	struct clk		*pcie_bus;
 	struct clk		*pcie_phy;
@@ -474,7 +475,7 @@ static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
 	switch (imx6_pcie->variant) {
 	case IMX7D:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL, 0);
+				   BIT(5), imx6_pcie->phy_refclk ? BIT(5) : 0);
 		break;
 	case IMX6SX:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
@@ -733,6 +734,11 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	if (IS_ERR(pci->dbi_base))
 		return PTR_ERR(pci->dbi_base);
 
+	/* Fetch PHY Reference Clock */
+	if (of_property_read_u32(node, "phy-ref-clk", &imx6_pcie->phy_refclk))
+		imx6_pcie->phy_refclk = 0;
+	pr_info("%s: phy_refclk = %d\n", __func__, imx6_pcie->phy_refclk);
+
 	/* Fetch GPIOs */
 	imx6_pcie->reset_gpio = of_get_named_gpio(node, "reset-gpio", 0);
 	imx6_pcie->gpio_active_high = of_property_read_bool(node,
-- 
2.9.3
