From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Wed, 18 Jul 2018 18:10:51 +0200
Subject: [PATCH net-next v3 2/8] net: mvneta: fix mtu change on port without
 link
In-Reply-To: <20180718161057.28704-1-gregory.clement@bootlin.com>
References: <20180718161057.28704-1-gregory.clement@bootlin.com>
Message-ID: <20180718161057.28704-3-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yelena Krivosheev <yelena@marvell.com>

It is incorrect to enable TX/RX queues (call by mvneta_port_up()) for
port without link. Indeed MTU change for interface without link causes TX
queues to stuck.

Fixes: c5aff18204da ("net: mvneta: driver for Marvell Armada 370/XP
network unit")
Signed-off-by: Yelena Krivosheev <yelena@marvell.com>
[gregory.clement: adding Fixes tags and rewording commit log]
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index ec84db47d82d..3d1f4335b0d3 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -3196,7 +3196,6 @@ static int mvneta_change_mtu(struct net_device *dev, int mtu)
 
 	on_each_cpu(mvneta_percpu_enable, pp, true);
 	mvneta_start_dev(pp);
-	mvneta_port_up(pp);
 
 	netdev_update_features(dev);
 
-- 
2.18.0
