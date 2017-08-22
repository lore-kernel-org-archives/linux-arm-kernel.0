From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue, 22 Aug 2017 19:08:23 +0200
Subject: [PATCH net-next v2 03/10] net: mvpp2: move the mii configuration in
 the ndo_open path
In-Reply-To: <20170822170830.32413-1-antoine.tenart@free-electrons.com>
References: <20170822170830.32413-1-antoine.tenart@free-electrons.com>
Message-ID: <20170822170830.32413-4-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves the mii configuration in the ndo_open path, to allow handling
different mii configurations later and to switch between these
configurations at runtime.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Tested-by: Marcin Wojtas <mw@semihalf.com>
---
 drivers/net/ethernet/marvell/mvpp2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
index 03b7ced1082f..087eb793ab4d 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -5987,6 +5987,7 @@ static void mvpp2_start_dev(struct mvpp2_port *port)
 	/* Enable interrupts on all CPUs */
 	mvpp2_interrupts_enable(port);
 
+	mvpp2_port_mii_set(port);
 	mvpp2_port_enable(port);
 	phy_start(ndev->phydev);
 	netif_tx_start_all_queues(port->dev);
@@ -6949,7 +6950,6 @@ static int mvpp2_port_probe(struct platform_device *pdev,
 		goto err_free_stats;
 	}
 
-	mvpp2_port_mii_set(port);
 	mvpp2_port_periodic_xon_disable(port);
 
 	if (priv->hw_version == MVPP21)
-- 
2.13.5
