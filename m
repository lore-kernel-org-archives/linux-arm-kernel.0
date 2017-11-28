From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Tue, 28 Nov 2017 17:48:22 +0100
Subject: [PATCH] net: stmmac: dwmac-sun8i: fix allwinner,
 leds-active-low handling
Message-ID: <20171128164822.29218-1-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver expect "allwinner,leds-active-low" to be in PHY node, but
the binding doc expect it to be in MAC node.

Since all board DT use it also in MAC node, the driver need to search
allwinner,leds-active-low in MAC node.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index e5ff734d4f9b..9eb7f65d8000 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -808,8 +808,7 @@ static int sun8i_dwmac_set_syscon(struct stmmac_priv *priv)
 			 val, reg);
 
 	if (gmac->variant->soc_has_internal_phy) {
-		if (of_property_read_bool(priv->plat->phy_node,
-					  "allwinner,leds-active-low"))
+		if (of_property_read_bool(node, "allwinner,leds-active-low"))
 			reg |= H3_EPHY_LED_POL;
 		else
 			reg &= ~H3_EPHY_LED_POL;
-- 
2.13.6
