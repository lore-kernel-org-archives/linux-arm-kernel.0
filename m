From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 17 Jan 2014 21:24:45 +0800
Subject: [PATCH net-next v3 6/8] net: stmmac: Deprecate snps,
 phy-addr and auto-detect PHY address
In-Reply-To: <1389965087-21971-1-git-send-email-wens@csie.org>
References: <1389965087-21971-1-git-send-email-wens@csie.org>
Message-ID: <1389965087-21971-7-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The snps,phy-addr device tree property is non-standard, and should be
removed in favor of proper phy node support. Remove it from the binding
documents and warn if the property is still used.

Most PHYs respond to address 0, but a few don't, so auto-detect PHY
address by default, to make up for the lack of explicit address selection.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/net/stmmac.txt      | 1 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 9 ++++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/stmmac.txt b/Documentation/devicetree/bindings/net/stmmac.txt
index d132513..aefb639 100644
--- a/Documentation/devicetree/bindings/net/stmmac.txt
+++ b/Documentation/devicetree/bindings/net/stmmac.txt
@@ -12,7 +12,6 @@ Required properties:
   property
 - phy-mode: String, operation mode of the PHY interface.
   Supported values are: "mii", "rmii", "gmii", "rgmii".
-- snps,phy-addr		phy address to connect to.
 - snps,reset-gpio 	gpio number for phy reset.
 - snps,reset-active-low boolean flag to indicate if phy reset is active low.
 - snps,reset-delays-us  is triplet of delays
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 634260e..82110f1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -50,7 +50,14 @@ static int stmmac_probe_config_dt(struct platform_device *pdev,
 	if (plat->bus_id < 0)
 		plat->bus_id = 0;
 
-	of_property_read_u32(np, "snps,phy-addr", &plat->phy_addr);
+	/* Default to phy auto-detection */
+	plat->phy_addr = -1;
+
+	/* "snps,phy-addr" is not a standard property. Mark it as deprecated
+	 * and warn of its use. Remove this when phy node support is added.
+	 */
+	if (of_property_read_u32(np, "snps,phy-addr", &plat->phy_addr) == 0)
+		dev_warn(&pdev->dev, "snps,phy-addr property is deprecated\n");
 
 	plat->mdio_bus_data = devm_kzalloc(&pdev->dev,
 					   sizeof(struct stmmac_mdio_bus_data),
-- 
1.8.5.2
