From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Tue, 27 Jun 2017 11:28:01 +0200
Subject: [PATCH 1/6] net: stmmac: support future possible different internal
 phy mode
Message-ID: <20170627092806.28181-1-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current way to find if the phy is internal is to compare DT phy-mode
and emac_variant/internal_phy.
But it will negate a possible future SoC where an external PHY use the
same phy mode than the internal one.

By using phy-mode = "internal" we permit to have an external PHY with
the same mode than the internal one.

Reported-by: Andr? Przywara <andre.przywara@arm.com>
Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index fffd6d5fc907..6c2d1da05588 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -638,7 +638,7 @@ static int sun8i_dwmac_set_syscon(struct stmmac_priv *priv)
 {
 	struct sunxi_priv_data *gmac = priv->plat->bsp_priv;
 	struct device_node *node = priv->device->of_node;
-	int ret;
+	int ret, phy_interface;
 	u32 reg, val;
 
 	regmap_read(gmac->regmap, SYSCON_EMAC_REG, &val);
@@ -718,7 +718,11 @@ static int sun8i_dwmac_set_syscon(struct stmmac_priv *priv)
 	if (gmac->variant->support_rmii)
 		reg &= ~SYSCON_RMII_EN;
 
-	switch (priv->plat->interface) {
+	phy_interface = priv->plat->interface;
+	/* if PHY is internal, select the mode (xMII) used by the SoC */
+	if (gmac->use_internal_phy)
+		phy_interface = gmac->variant->internal_phy;
+	switch (phy_interface) {
 	case PHY_INTERFACE_MODE_MII:
 		/* default */
 		break;
@@ -932,7 +936,7 @@ static int sun8i_dwmac_probe(struct platform_device *pdev)
 	}
 
 	plat_dat->interface = of_get_phy_mode(dev->of_node);
-	if (plat_dat->interface == gmac->variant->internal_phy) {
+	if (plat_dat->interface == PHY_INTERFACE_MODE_INTERNAL) {
 		dev_info(&pdev->dev, "Will use internal PHY\n");
 		gmac->use_internal_phy = true;
 		gmac->ephy_clk = of_clk_get(plat_dat->phy_node, 0);
-- 
2.13.0
