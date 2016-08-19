From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Fri, 19 Aug 2016 18:18:10 +0530
Subject: [PATCH 1/2] net: phy: Add error checks in the driver
Message-ID: <1471610891-13353-1-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the necessary error checks in the driver.

Reported-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
---
 drivers/net/phy/xilinx_gmii2rgmii.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/xilinx_gmii2rgmii.c b/drivers/net/phy/xilinx_gmii2rgmii.c
index e7a20ec..7336fd0 100644
--- a/drivers/net/phy/xilinx_gmii2rgmii.c
+++ b/drivers/net/phy/xilinx_gmii2rgmii.c
@@ -39,11 +39,16 @@ struct gmii2rgmii {
 static int xgmiitorgmii_read_status(struct phy_device *phydev)
 {
 	struct gmii2rgmii *priv = phydev->priv;
-	u16 val = 0;
+	int err, val = 0;
 
-	priv->phy_drv->read_status(phydev);
+	err = priv->phy_drv->read_status(phydev);
+	if (err < 0)
+		return err;
 
 	val = mdiobus_read(phydev->mdio.bus, priv->addr, XILINX_GMII2RGMII_REG);
+	if (val < 0)
+		return val;
+
 	val &= XILINX_GMII2RGMII_SPEED_MASK;
 
 	if (phydev->speed == SPEED_1000)
@@ -53,7 +58,10 @@ static int xgmiitorgmii_read_status(struct phy_device *phydev)
 	else
 		val |= BMCR_SPEED10;
 
-	mdiobus_write(phydev->mdio.bus, priv->addr, XILINX_GMII2RGMII_REG, val);
+	err = mdiobus_write(phydev->mdio.bus, priv->addr, XILINX_GMII2RGMII_REG,
+			    val);
+	if (err < 0)
+		return err;
 
 	return 0;
 }
-- 
2.1.2
