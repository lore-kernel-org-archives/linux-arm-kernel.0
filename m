From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 08 Jul 2014 00:22:39 +0100
Subject: [PATCH A 02/12] net: fec: fix ethtool set_pauseparam duplex bug
In-Reply-To: <20140707232148.GG21766@n2100.arm.linux.org.uk>
References: <20140707232148.GG21766@n2100.arm.linux.org.uk>
Message-ID: <E1X4IF5-0004wl-3p@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Setting the pause parameters causes a running network interface to be
restarted.  However, the restart forces the FEC into half-duplex mode,
whether or not the remote end is in half-duplex mode.  Misconfigured
duplex mode is a known source of problems on a link.

Fix this by always preserving the duplex mode on configuration changes.

Acked-by: Fugang Duan <B38611@freescale.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/freescale/fec_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index a91fe68030e6..045ea71f2b59 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1897,7 +1897,7 @@ static int fec_enet_set_pauseparam(struct net_device *ndev,
 		phy_start_aneg(fep->phy_dev);
 	}
 	if (netif_running(ndev))
-		fec_restart(ndev, 0);
+		fec_restart(ndev, fep->full_duplex);
 
 	return 0;
 }
-- 
1.8.3.1
