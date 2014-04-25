From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:39:07 +0100
Subject: [PATCH 096/222] net:fec: add barrier to transmit path to ensure
 proper ordering
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeTD-0007Jb-KE@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ensure that the writes to the descriptor data is visible to the hardware
before the descriptor is handed over to the hardware.

Having discussed this with Will Deacon, we need a wmb() between writing
the descriptor data and handing the descriptor over to the hardware.
The corresponding rmb() is in the ethernet hardware.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/freescale/fec_main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index d5ad0c70e6a0..2d9a6493b33b 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -436,6 +436,13 @@ fec_enet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 		}
 	}
 
+	/*
+	 * We need the preceding stores to the descriptor to complete
+	 * before updating the status field, which hands it over to the
+	 * hardware.  The corresponding rmb() is "in the hardware".
+	 */
+	wmb();
+
 	/* Send it on its way.  Tell FEC it's ready, interrupt when done,
 	 * it's the last BD of the frame, and to put the CRC on the end.
 	 */
-- 
1.8.3.1
