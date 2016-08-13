From: isubramanian@apm.com (Iyappan Subramanian)
Date: Fri, 12 Aug 2016 22:05:47 -0700
Subject: [PATCH net-next v2 11/12] drivers: net: xgene: Fix backward
 compatibility
In-Reply-To: <1471064748-28033-1-git-send-email-isubramanian@apm.com>
References: <1471064748-28033-1-git-send-email-isubramanian@apm.com>
Message-ID: <1471064748-28033-12-git-send-email-isubramanian@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the backward compatibility on handling phy_connect(), by
iterating over the phy-handle, when new DT is used with older kernel.

Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
---
 drivers/net/ethernet/apm/xgene/xgene_enet_hw.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/apm/xgene/xgene_enet_hw.c b/drivers/net/ethernet/apm/xgene/xgene_enet_hw.c
index 18bb955..321fb19 100644
--- a/drivers/net/ethernet/apm/xgene/xgene_enet_hw.c
+++ b/drivers/net/ethernet/apm/xgene/xgene_enet_hw.c
@@ -761,18 +761,18 @@ int xgene_enet_phy_connect(struct net_device *ndev)
 	if (dev->of_node) {
 		for (i = 0 ; i < 2; i++) {
 			np = of_parse_phandle(dev->of_node, "phy-handle", i);
-			if (np)
-				break;
-		}
 
-		if (!np) {
-			netdev_dbg(ndev, "No phy-handle found in DT\n");
-			return -ENODEV;
+			if (!np)
+				continue;
+
+			phy_dev = of_phy_connect(ndev, np,
+						 &xgene_enet_adjust_link,
+						 0, pdata->phy_mode);
+			of_node_put(np);
+			if (phy_dev)
+				break;
 		}
 
-		phy_dev = of_phy_connect(ndev, np, &xgene_enet_adjust_link,
-					 0, pdata->phy_mode);
-		of_node_put(np);
 		if (!phy_dev) {
 			netdev_err(ndev, "Could not connect to PHY\n");
 			return -ENODEV;
-- 
1.9.1
