From: romain.perier@gmail.com (Romain Perier)
Date: Wed, 10 Sep 2014 07:51:13 +0000
Subject: [PATCH v1] net: ethernet: arc: Don't free Rockchip resources before
 disconnect from phy
Message-ID: <1410335473-23573-1-git-send-email-romain.perier@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Free resources before being disconnected from phy and calling core driver is
wrong and should not happen. It avoids a delay of 4-5s caused by the timeout of
phy_disconnect().

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 drivers/net/ethernet/arc/emac_rockchip.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/arc/emac_rockchip.c b/drivers/net/ethernet/arc/emac_rockchip.c
index 51d0585..c31c740 100644
--- a/drivers/net/ethernet/arc/emac_rockchip.c
+++ b/drivers/net/ethernet/arc/emac_rockchip.c
@@ -202,12 +202,13 @@ static int emac_rockchip_remove(struct platform_device *pdev)
 	struct rockchip_priv_data *priv = netdev_priv(ndev);
 	int err;
 
+	err = arc_emac_remove(ndev);
+
 	clk_disable_unprepare(priv->refclk);
 
 	if (priv->regulator)
 		regulator_disable(priv->regulator);
 
-	err = arc_emac_remove(ndev);
 	free_netdev(ndev);
 	return err;
 }
-- 
1.9.1
