From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 6 Jan 2011 15:13:10 +0800
Subject: [PATCH v4 02/10] net/fec: remove the use of "index" which is legacy
In-Reply-To: <1294297998-26930-1-git-send-email-shawn.guo@freescale.com>
References: <1294297998-26930-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1294297998-26930-3-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "index" becomes legacy since fep->pdev->id starts working
to identify the instance.

Moreover, the call of fec_enet_init(ndev, 0) always passes 0
to fep->index. This makes the following code in fec_get_mac buggy.

	/* Adjust MAC if using default MAC address */
	if (iap == fec_mac_default)
		dev->dev_addr[ETH_ALEN-1] = fec_mac_default[ETH_ALEN-1] + fep->index;

It may be the time to remove "index" and use fep->pdev->id instead.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 drivers/net/fec.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/fec.c b/drivers/net/fec.c
index 52e9ca8..47f6b3b 100644
--- a/drivers/net/fec.c
+++ b/drivers/net/fec.c
@@ -186,7 +186,6 @@ struct fec_enet_private {
 	int     mii_timeout;
 	uint    phy_speed;
 	phy_interface_t	phy_interface;
-	int	index;
 	int	link;
 	int	full_duplex;
 	struct	completion mdio_done;
@@ -566,7 +565,7 @@ static void __inline__ fec_get_mac(struct net_device *dev)
 
 	/* Adjust MAC if using default MAC address */
 	if (iap == fec_mac_default)
-		 dev->dev_addr[ETH_ALEN-1] = fec_mac_default[ETH_ALEN-1] + fep->index;
+		 dev->dev_addr[ETH_ALEN-1] = fec_mac_default[ETH_ALEN-1] + fep->pdev->id;
 }
 #endif
 
@@ -1067,9 +1066,8 @@ static const struct net_device_ops fec_netdev_ops = {
  /*
   * XXX:  We need to clean up on failure exits here.
   *
-  * index is only used in legacy code
   */
-static int fec_enet_init(struct net_device *dev, int index)
+static int fec_enet_init(struct net_device *dev)
 {
 	struct fec_enet_private *fep = netdev_priv(dev);
 	struct bufdesc *cbd_base;
@@ -1086,7 +1084,6 @@ static int fec_enet_init(struct net_device *dev, int index)
 
 	spin_lock_init(&fep->hw_lock);
 
-	fep->index = index;
 	fep->hwp = (void __iomem *)dev->base_addr;
 	fep->netdev = dev;
 
@@ -1316,7 +1313,7 @@ fec_probe(struct platform_device *pdev)
 	}
 	clk_enable(fep->clk);
 
-	ret = fec_enet_init(ndev, 0);
+	ret = fec_enet_init(ndev);
 	if (ret)
 		goto failed_init;
 
-- 
1.7.1
