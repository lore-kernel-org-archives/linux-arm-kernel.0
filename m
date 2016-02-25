From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Wed, 24 Feb 2016 17:36:49 -0700
Subject: [PATCH net-next V2 06/16] net: fec: don't clear all rx queue bits
 when just one is being checked
In-Reply-To: <1456360619-24390-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1456360619-24390-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <1456360619-24390-7-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

FEC_ENET_RXF is 3 separate bits, we only check one queue
at a time. So, when the last queue is being checked, it is
bad to remove the interrupt on the 1st queue.

Also, since this is now done in the napi
routine and not the interrupt, it is not needed.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 610cf6c..791f385 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1338,8 +1338,6 @@ static int fec_rxq(struct net_device *ndev, struct fec_enet_private *fep,
 			break;
 		pkt_received++;
 
-		writel(FEC_ENET_RXF, fep->hwp + FEC_IEVENT);
-
 		/* Check for errors. */
 		status ^= BD_ENET_RX_LAST;
 		if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH | BD_ENET_RX_NO |
-- 
2.5.0
