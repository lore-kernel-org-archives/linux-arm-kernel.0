From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 10 Mar 2014 21:51:01 +0100
Subject: [PATCH v2 3/3] net: cpsw: simplify phy_ethtool_get_wol call
In-Reply-To: <1394484661-4554-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1394413270-7169-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1394484661-4554-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1394484661-4554-4-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With phy_ethtool_get_wol now clearing struct ethtool_wolinfo, we can
simplify routines calling it.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Changelog:
v1->v2:
- initial

Cc: David Miller <davem@davemloft.net>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/net/ethernet/ti/cpsw.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index bde63e3af96f..06950c75cb2f 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -1726,12 +1726,7 @@ static void cpsw_get_wol(struct net_device *ndev, struct ethtool_wolinfo *wol)
 {
 	struct cpsw_priv *priv = netdev_priv(ndev);
 	int slave_no = cpsw_slave_index(priv);
-
-	wol->supported = 0;
-	wol->wolopts = 0;
-
-	if (priv->slaves[slave_no].phy)
-		phy_ethtool_get_wol(priv->slaves[slave_no].phy, wol);
+	phy_ethtool_get_wol(priv->slaves[slave_no].phy, wol);
 }
 
 static int cpsw_set_wol(struct net_device *ndev, struct ethtool_wolinfo *wol)
-- 
1.8.5.3
