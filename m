From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:37:05 +0100
Subject: [PATCH 072/222] net:fec: reorder ethtool ops to match order in struct
 declaration
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeRF-0007Hx-0p@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows us to merge two separate preprocessor conditionals together.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/freescale/fec_main.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index b151eaf3b500..875c0ca55c5a 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1639,21 +1639,19 @@ static int fec_enet_nway_reset(struct net_device *dev)
 }
 
 static const struct ethtool_ops fec_enet_ethtool_ops = {
-#if !defined(CONFIG_M5272)
-	.get_pauseparam		= fec_enet_get_pauseparam,
-	.set_pauseparam		= fec_enet_set_pauseparam,
-#endif
 	.get_settings		= fec_enet_get_settings,
 	.set_settings		= fec_enet_set_settings,
 	.get_drvinfo		= fec_enet_get_drvinfo,
-	.get_link		= ethtool_op_get_link,
-	.get_ts_info		= fec_enet_get_ts_info,
 	.nway_reset		= fec_enet_nway_reset,
+	.get_link		= ethtool_op_get_link,
 #ifndef CONFIG_M5272
-	.get_ethtool_stats	= fec_enet_get_ethtool_stats,
+	.get_pauseparam		= fec_enet_get_pauseparam,
+	.set_pauseparam		= fec_enet_set_pauseparam,
 	.get_strings		= fec_enet_get_strings,
+	.get_ethtool_stats	= fec_enet_get_ethtool_stats,
 	.get_sset_count		= fec_enet_get_sset_count,
 #endif
+	.get_ts_info		= fec_enet_get_ts_info,
 };
 
 static int fec_enet_ioctl(struct net_device *ndev, struct ifreq *rq, int cmd)
-- 
1.8.3.1
