From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:41:50 +0100
Subject: [PATCH 122/222] net:fec: avoid checking more flags than necessary in
 rx path
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeVq-0007LN-Jx@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid checking for both the receive checksumming flag and the enhanced
buffer descriptor flags - we now only set receive checksumming if we
know we have enhanced buffer descriptors.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/freescale/fec_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 7cb852991bf1..7f05866acee3 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1042,8 +1042,7 @@ fec_enet_rx(struct net_device *ndev, int budget)
 				fec_enet_hwtstamp(fep, bdp->ebd.ts,
 						  skb_hwtstamps(skb));
 
-			if (fep->flags & FEC_FLAG_BUFDESC_EX &&
-			    fep->flags & FEC_FLAG_RX_CSUM) {
+			if (fep->flags & FEC_FLAG_RX_CSUM) {
 				if (!(bdp->ebd.cbd_esc & FLAG_RX_CSUM_ERROR)) {
 					/* don't check it */
 					skb->ip_summed = CHECKSUM_UNNECESSARY;
-- 
1.8.3.1
