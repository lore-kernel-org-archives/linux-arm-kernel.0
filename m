From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Sun,  2 Jul 2017 14:31:59 +0200
Subject: [PATCH 6/6] net: stmmac: revert "support future possible different
 internal phy mode"
In-Reply-To: <20170702123159.6939-1-clabbe.montjoie@gmail.com>
References: <20170702123159.6939-1-clabbe.montjoie@gmail.com>
Message-ID: <20170702123159.6939-7-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since internal phy-mode is reserved for non-xMII protocol we cannot use
it with dwmac-sun8i
This reverts commit 1c2fa5f84683 ("net: stmmac: support future possible different internal phy mode")

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 6c2d1da05588..fffd6d5fc907 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -638,7 +638,7 @@ static int sun8i_dwmac_set_syscon(struct stmmac_priv *priv)
 {
 	struct sunxi_priv_data *gmac = priv->plat->bsp_priv;
 	struct device_node *node = priv->device->of_node;
-	int ret, phy_interface;
+	int ret;
 	u32 reg, val;
 
 	regmap_read(gmac->regmap, SYSCON_EMAC_REG, &val);
@@ -718,11 +718,7 @@ static int sun8i_dwmac_set_syscon(struct stmmac_priv *priv)
 	if (gmac->variant->support_rmii)
 		reg &= ~SYSCON_RMII_EN;
 
-	phy_interface = priv->plat->interface;
-	/* if PHY is internal, select the mode (xMII) used by the SoC */
-	if (gmac->use_internal_phy)
-		phy_interface = gmac->variant->internal_phy;
-	switch (phy_interface) {
+	switch (priv->plat->interface) {
 	case PHY_INTERFACE_MODE_MII:
 		/* default */
 		break;
@@ -936,7 +932,7 @@ static int sun8i_dwmac_probe(struct platform_device *pdev)
 	}
 
 	plat_dat->interface = of_get_phy_mode(dev->of_node);
-	if (plat_dat->interface == PHY_INTERFACE_MODE_INTERNAL) {
+	if (plat_dat->interface == gmac->variant->internal_phy) {
 		dev_info(&pdev->dev, "Will use internal PHY\n");
 		gmac->use_internal_phy = true;
 		gmac->ephy_clk = of_clk_get(plat_dat->phy_node, 0);
-- 
2.13.0
