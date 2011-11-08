From: phorton@bitbox.co.uk (Peter Horton)
Date: Tue, 8 Nov 2011 11:17:49 +0000
Subject: [PATCH] iMX28 Ethernet driver fix
Message-ID: <20111108111749.GA30638@axolotl.localnet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix driver to correctly handle cloned SKBs. Currently any clones
of the transmit SKBs get endian-swapped by the driver. This breaks
the ATA-over-Ethernet driver for example.

Signed-off-by: Peter Horton <phorton@bitbox.co.uk>
---
 drivers/net/fec.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/net/fec.c b/drivers/net/fec.c
index c46ccb1..6455483 100644
--- a/drivers/net/fec.c
+++ b/drivers/net/fec.c
@@ -302,8 +302,14 @@ fec_enet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	 * On some FEC implementations data must be aligned on
 	 * 4-byte boundaries. Use bounce buffers to copy data
 	 * and get it aligned. Ugh.
+	 *
+	 * We also have to use the bounce buffers if we need
+	 * to do the endian swap (see below) on a cloned buffer.
 	 */
-	if (((unsigned long) bufaddr) & FEC_ALIGNMENT) {
+	if ((((unsigned long) bufaddr) & FEC_ALIGNMENT) ||
+		((id_entry->driver_data & FEC_QUIRK_SWAP_FRAME) &&
+		skb_cloned(skb)))
+	{
 		unsigned int index;
 		index = bdp - fep->tx_bd_base;
 		memcpy(fep->tx_bounce[index], skb->data, skb->len);
-- 
1.7.2.5
