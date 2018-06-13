From: radhey.shyam.pandey@xilinx.com (Radhey Shyam Pandey)
Date: Wed, 13 Jun 2018 12:05:17 +0530
Subject: [PATCH 2/4] net: emaclite: Fix MDIO bus unregister bug
In-Reply-To: <1528871719-1681-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1528871719-1681-1-git-send-email-radhey.shyam.pandey@xilinx.com>
Message-ID: <1528871719-1681-3-git-send-email-radhey.shyam.pandey@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since 'has_mdio' flag is not used,sequence insmod->rmmod-> insmod
leads to failure as MDIO unregister doesn't happen in .remove().
Fix it by checking MII bus pointer instead.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/net/ethernet/xilinx/xilinx_emaclite.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index 37989ce..06eb6c8 100644
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -1191,7 +1191,7 @@ static int xemaclite_of_remove(struct platform_device *of_dev)
 	struct net_local *lp = netdev_priv(ndev);
 
 	/* Un-register the mii_bus, if configured */
-	if (lp->has_mdio) {
+	if (lp->mii_bus) {
 		mdiobus_unregister(lp->mii_bus);
 		mdiobus_free(lp->mii_bus);
 		lp->mii_bus = NULL;
-- 
1.7.1
