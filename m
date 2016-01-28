From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Thu, 28 Jan 2016 14:26:02 -0700
Subject: [PATCH net-next 38/40] net: fec: recover from lost rxf_0 interrupt
In-Reply-To: <1454016364-30985-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1454016364-30985-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <1454016364-30985-39-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following is true of linux-3.14. I have not been able
to verify on mainline, because I cannot get the cpuidle
driver to work.

If gpio6 workaround is not used for interrupts, then
it is possible for the entire receive queue to become
full without an interrupt. If that happens, and the last
rxf_0 interrupt is lost, then the FEC can no longer receive
packets. However packet transmission is still fine, so the tx
watchdog will never fire. The only way to recover before this
is a ifconfig down/up. Skipping the FEC_ENET_RXF_0 check
will allow the rx queue to recover from the condition when
the next packet is transmitted.

This patch also has the advantage of increasing iperf speed.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 00c9b7e..8372d9b 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1608,9 +1608,10 @@ static int fec_enet_napi_q1(struct napi_struct *napi, int budget)
 		}
 
 		writel(events, fep->hwp + FEC_IEVENT);
-		if (events & FEC_ENET_RXF_0)
-			pkts += fec_rxq(ndev, fep, fep->rx_queue[0],
-					budget - pkts);
+		/* don't check FEC_ENET_RXF_0, to recover from a full queue
+		 * but bit clear condition
+		 */
+		pkts += fec_rxq(ndev, fep, fep->rx_queue[0], budget - pkts);
 		if (events & FEC_ENET_TXF_0)
 			fec_txq(ndev, fep, fep->tx_queue[0]);
 	} while (pkts < budget);
-- 
2.5.0
