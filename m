From: icenowy@aosc.io (Icenowy Zheng)
Date: Sat, 17 Jun 2017 22:07:36 +0800
Subject: [PATCH 3/4] net-next: stmmac: dwmac-sun8i: force EPHY clock freq to
 24MHz
In-Reply-To: <20170617140737.41951-1-icenowy@aosc.io>
References: <20170617140737.41951-1-icenowy@aosc.io>
Message-ID: <20170617140737.41951-4-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The EPHY control part of the EMAC syscon register has a bit called
CLK_SEL. On the datasheet it says that if it's 0 the EPHY clock is 25MHz
and if it's 1 the clock is 24MHz.

However, according to the datasheets, no Allwinner SoC with EPHY has any
extra xtal input pins for the EPHY, and the system xtal is 24MHz.

That means the EPHY is not possible to get a 25MHz xtal input, and thus
the frequency can only be 24MHz.

It doesn't matter on H3 as the default value of H3 is 24MHz, however on
V3s the default value is wrongly set to 25MHz, which prevented the EPHY
from working properly.

Force the EPHY clock frequency to 24MHz.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 54f93ee53ef7..61ce3b54f0c6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -185,6 +185,7 @@ static const struct emac_variant emac_variant_a64 = {
 
 /* H3 specific bits for EPHY */
 #define H3_EPHY_ADDR_SHIFT	20
+#define H3_EPHY_CLK_SEL		BIT(18) /* 1: 24MHz, 0: 25MHz */
 #define H3_EPHY_LED_POL		BIT(17) /* 1: active low, 0: active high */
 #define H3_EPHY_SHUTDOWN	BIT(16) /* 1: shutdown, 0: power up */
 #define H3_EPHY_SELECT		BIT(15) /* 1: internal PHY, 0: external PHY */
@@ -656,6 +657,9 @@ static int sun8i_dwmac_set_syscon(struct stmmac_priv *priv)
 			else
 				reg &= ~H3_EPHY_LED_POL;
 
+			/* Force EPHY xtal frequency to 24MHz. */
+			reg |= H3_EPHY_CLK_SEL;
+
 			ret = of_mdio_parse_addr(priv->device,
 						 priv->plat->phy_node);
 			if (ret < 0) {
-- 
2.13.0
