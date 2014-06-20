From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 20 Jun 2014 13:13:35 +0100
Subject: [PATCH RFC 22/30] net: fec: quiesce packet processing when taking
 link down in fec_enet_adjust_link()
In-Reply-To: <20140620121118.GR32514@n2100.arm.linux.org.uk>
References: <20140620121118.GR32514@n2100.arm.linux.org.uk>
Message-ID: <E1WxxhH-0005YH-Iz@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the link goes down, the adjust_link method will be called, but
there is no synchronisation to ensure that we won't be processing some
last remaining packets via the NAPI handlers while performing a reset of
the device.

Add the necessary synchronisation to ensure that packet processing
is complete before we stop and reset the FEC.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/freescale/fec_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 466268fffadd..b2b8aff3f73c 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1530,7 +1530,11 @@ static void fec_enet_adjust_link(struct net_device *ndev)
 		}
 	} else {
 		if (fep->link) {
+			napi_disable(&fep->napi);
+			netif_tx_lock_bh(ndev);
 			fec_stop(ndev);
+			netif_tx_unlock_bh(ndev);
+			napi_enable(&fep->napi);
 			fep->link = phy_dev->link;
 			status_change = 1;
 		}
-- 
1.8.3.1
