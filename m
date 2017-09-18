From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Mon, 18 Sep 2017 10:04:22 +0200
Subject: [PATCH 3/3] phy: mvebu-cp110-comphy: explicitly set the pipe selector
In-Reply-To: <20170918080422.28972-1-antoine.tenart@free-electrons.com>
References: <20170918080422.28972-1-antoine.tenart@free-electrons.com>
Message-ID: <20170918080422.28972-3-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pipe selector is used to select some modes (such as USB or PCIe).
Otherwise it must be set to 0 (or "unconnected"). This patch does this
to ensure it is not set to an incompatible value when using the
supported modes (SGMII, 10GKR).

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 drivers/phy/marvell/phy-mvebu-cp110-comphy.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/phy/marvell/phy-mvebu-cp110-comphy.c b/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
index 365f0abf5a2f..d3ea824b7ed0 100644
--- a/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
+++ b/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
@@ -111,6 +111,8 @@
 #define     MVEBU_COMPHY_CONF6_40B		BIT(18)
 #define MVEBU_COMPHY_SELECTOR			0x1140
 #define     MVEBU_COMPHY_SELECTOR_PHY(n)	((n) * 0x4)
+#define MVEBU_COMPHY_PIPE_SELECTOR		0x1144
+#define     MVEBU_COMPHY_PIPE_SELECTOR_PIPE(n)	((n) * 0x4)
 
 #define MVEBU_COMPHY_LANES	6
 #define MVEBU_COMPHY_PORTS	3
@@ -474,6 +476,10 @@ static int mvebu_comphy_power_on(struct phy *phy)
 	if (mux < 0)
 		return -ENOTSUPP;
 
+	regmap_read(priv->regmap, MVEBU_COMPHY_PIPE_SELECTOR, &val);
+	val &= ~(0xf << MVEBU_COMPHY_PIPE_SELECTOR_PIPE(lane->id));
+	regmap_write(priv->regmap, MVEBU_COMPHY_PIPE_SELECTOR, val);
+
 	regmap_read(priv->regmap, MVEBU_COMPHY_SELECTOR, &val);
 	val &= ~(0xf << MVEBU_COMPHY_SELECTOR_PHY(lane->id));
 	val |= mux << MVEBU_COMPHY_SELECTOR_PHY(lane->id);
@@ -525,6 +531,10 @@ static int mvebu_comphy_power_off(struct phy *phy)
 	val &= ~(0xf << MVEBU_COMPHY_SELECTOR_PHY(lane->id));
 	regmap_write(priv->regmap, MVEBU_COMPHY_SELECTOR, val);
 
+	regmap_read(priv->regmap, MVEBU_COMPHY_PIPE_SELECTOR, &val);
+	val &= ~(0xf << MVEBU_COMPHY_PIPE_SELECTOR_PIPE(lane->id));
+	regmap_write(priv->regmap, MVEBU_COMPHY_PIPE_SELECTOR, val);
+
 	return 0;
 }
 
-- 
2.13.5
