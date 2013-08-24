From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Sat, 24 Aug 2013 21:21:05 +0200
Subject: [PATCH] net/cadence/macb: fix kernel Oops if no PHY were discovered
 during probe
Message-ID: <1377372065-8938-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Test the presence of a PHY device before printing attached PHY
informations.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 drivers/net/ethernet/cadence/macb.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.c b/drivers/net/ethernet/cadence/macb.c
index e866608..fd3b67f 100644
--- a/drivers/net/ethernet/cadence/macb.c
+++ b/drivers/net/ethernet/cadence/macb.c
@@ -1868,8 +1868,10 @@ static int __init macb_probe(struct platform_device *pdev)
 		    dev->irq, dev->dev_addr);
 
 	phydev = bp->phy_dev;
-	netdev_info(dev, "attached PHY driver [%s] (mii_bus:phy_addr=%s, irq=%d)\n",
-		    phydev->drv->name, dev_name(&phydev->dev), phydev->irq);
+	if (phydev)
+		netdev_info(dev, "attached PHY driver [%s] (mii_bus:phy_addr=%s, irq=%d)\n",
+			    phydev->drv->name, dev_name(&phydev->dev),
+			    phydev->irq);
 
 	return 0;
 
-- 
1.7.9.5
