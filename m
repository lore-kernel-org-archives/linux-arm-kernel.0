From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Tue,  5 Apr 2016 19:25:53 -0700
Subject: [PATCH net-next V3 07/16] net: fec: don't clear all rx queue bits
 when just one is being checked
In-Reply-To: <1459909562-22865-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1459909562-22865-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <1459909562-22865-8-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

FEC_ENET_RXF is 3 separate bits, we only check one queue
at a time. So, when the last queue is being checked, it is
bad to remove the interrupt on the 1st queue.

Also, since tx/rx interrupts are now cleared in the napi
routine and not the interrupt, it is not needed here any longer.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

---
v3: change commit message
---
 drivers/net/ethernet/freescale/fec_main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 17140ea..3cd0cdf 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1339,8 +1339,6 @@ static int fec_rxq(struct net_device *ndev, struct fec_enet_priv_rx_q *rxq,
 			break;
 		pkt_received++;
 
-		writel(FEC_ENET_RXF, fep->hwp + FEC_IEVENT);
-
 		/* Check for errors. */
 		status ^= BD_ENET_RX_LAST;
 		if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH | BD_ENET_RX_NO |
-- 
2.5.0
