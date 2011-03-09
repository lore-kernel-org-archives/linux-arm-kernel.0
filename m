From: jason.hui@linaro.org (Jason Liu)
Date: Wed,  9 Mar 2011 10:50:04 +0800
Subject: [PATCH] net/fec: check id_entry pointer before using it
Message-ID: <1299639004-21546-1-git-send-email-jason.hui@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The id_entry will possibly be NULL, So, need check
id_entry and make sure it not NULL before using it.

Signed-off-by: Jason Liu <r64343@freescale.com>
---
 drivers/net/fec.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/fec.c b/drivers/net/fec.c
index cd0282d..e97ee0f 100644
--- a/drivers/net/fec.c
+++ b/drivers/net/fec.c
@@ -294,7 +294,7 @@ fec_enet_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	 * the system that it's running on. As the result, driver has to
 	 * swap every frame going to and coming from the controller.
 	 */
-	if (id_entry->driver_data & FEC_QUIRK_SWAP_FRAME)
+	if (id_entry && id_entry->driver_data & FEC_QUIRK_SWAP_FRAME)
 		swap_buffer(bufaddr, skb->len);
 
 	/* Save skb pointer */
@@ -530,7 +530,7 @@ fec_enet_rx(struct net_device *dev)
 	        dma_unmap_single(NULL, bdp->cbd_bufaddr, bdp->cbd_datlen,
         			DMA_FROM_DEVICE);
 
-		if (id_entry->driver_data & FEC_QUIRK_SWAP_FRAME)
+		if (id_entry && id_entry->driver_data & FEC_QUIRK_SWAP_FRAME)
 			swap_buffer(data, pkt_len);
 
 		/* This does 16 byte alignment, exactly what we need.
@@ -809,7 +809,7 @@ static int fec_enet_mii_init(struct platform_device *pdev)
 	 * mdio interface in board design, and need to be configured by
 	 * fec0 mii_bus.
 	 */
-	if ((id_entry->driver_data & FEC_QUIRK_ENET_MAC) && pdev->id) {
+	if (id_entry && (id_entry->driver_data & FEC_QUIRK_ENET_MAC) && pdev->id) {
 		/* fec1 uses fec0 mii_bus */
 		fep->mii_bus = fec0_mii_bus;
 		return 0;
@@ -852,7 +852,7 @@ static int fec_enet_mii_init(struct platform_device *pdev)
 		goto err_out_free_mdio_irq;
 
 	/* save fec0 mii_bus */
-	if (id_entry->driver_data & FEC_QUIRK_ENET_MAC)
+	if (id_entry && id_entry->driver_data & FEC_QUIRK_ENET_MAC)
 		fec0_mii_bus = fep->mii_bus;
 
 	return 0;
@@ -1239,7 +1239,7 @@ fec_restart(struct net_device *dev, int duplex)
 	 * enet-mac reset will reset mac address registers too,
 	 * so need to reconfigure it.
 	 */
-	if (id_entry->driver_data & FEC_QUIRK_ENET_MAC) {
+	if (id_entry && id_entry->driver_data & FEC_QUIRK_ENET_MAC) {
 		memcpy(&temp_mac, dev->dev_addr, ETH_ALEN);
 		writel(cpu_to_be32(temp_mac[0]), fep->hwp + FEC_ADDR_LOW);
 		writel(cpu_to_be32(temp_mac[1]), fep->hwp + FEC_ADDR_HIGH);
@@ -1295,7 +1295,7 @@ fec_restart(struct net_device *dev, int duplex)
 	 * The phy interface and speed need to get configured
 	 * differently on enet-mac.
 	 */
-	if (id_entry->driver_data & FEC_QUIRK_ENET_MAC) {
+	if (id_entry && id_entry->driver_data & FEC_QUIRK_ENET_MAC) {
 		val = readl(fep->hwp + FEC_R_CNTRL);
 
 		/* MII or RMII */
-- 
1.7.1
