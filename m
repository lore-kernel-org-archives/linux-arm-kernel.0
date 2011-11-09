From: phorton@bitbox.co.uk (Peter Horton)
Date: Wed, 9 Nov 2011 12:44:11 +0000
Subject: [PATCH] iMX28 Ethernet driver fix
Message-ID: <20111109124411.GA31046@axolotl.localnet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix driver to correctly handle cloned SKBs. Currently any clones
of the transmit SKBs get endian-swapped by the driver. This breaks
the ATA-over-Ethernet driver for example.

Signed-off-by: Peter Horton <phorton@bitbox.co.uk>
---
 drivers/net/ethernet/freescale/fec.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.c b/drivers/net/ethernet/freescale/fec.c
index 1124ce0..aff1fa9 100644
--- a/drivers/net/ethernet/freescale/fec.c
+++ b/drivers/net/ethernet/freescale/fec.c
@@ -312,8 +312,14 @@ fec_enet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
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
