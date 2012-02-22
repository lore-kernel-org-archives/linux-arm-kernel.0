From: christian.riesch@omicron.at (Christian Riesch)
Date: Wed, 22 Feb 2012 17:26:51 +0100
Subject: [RFC PATCH] davinci_emac: Do not accidentally free all rx dma
 descriptors during init
Message-ID: <1329928011-32746-1-git-send-email-christian.riesch@omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes a regression that was introduced by

commit 0a5f38467765ee15478db90d81e40c269c8dda20
davinci_emac: Add Carrier Link OK check in Davinci RX Handler

Said commit adds a check whether the carrier link is ok. If the link is
not ok, the skb is freed and no new dma descriptor added to the rx dma
channel. This causes trouble during initialization when the carrier
status has not yet been updated. If a lot of packets are received while
netif_carrier_ok returns false, all dma descriptors are freed and the
rx dma transfer is stopped.

To reproduce the bug, flood ping the davinci board while doing
ifconfig eth0 down
ifconfig eth0 up
on the board.

After that, the rx path stops working and the overrun value reported
by ifconfig is counting up.

This patch reverts commit 0a5f38467765ee15478db90d81e40c269c8dda20
and instead issues warnings only if cpdma_chan_submit returns -ENOMEM.

Signed-off-by: Christian Riesch <christian.riesch@omicron.at>
Cc: Hegde, Vinay <vinay.hegde@ti.com>
Cc: Cyril Chemparathy <cyril@ti.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---

Hi,
This patch fixes the initialization problem that I described. However
I am not sure if it correctly fixes the problem that was addressed
by the original patch, 0a5f38467765ee15478db90d81e40c269c8dda20.
Thanks for your comments!
Regards, Christian

 drivers/net/ethernet/ti/davinci_emac.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
index 4fa0bcb..4b2f545 100644
--- a/drivers/net/ethernet/ti/davinci_emac.c
+++ b/drivers/net/ethernet/ti/davinci_emac.c
@@ -1009,7 +1009,7 @@ static void emac_rx_handler(void *token, int len, int status)
 	int			ret;
 
 	/* free and bail if we are shutting down */
-	if (unlikely(!netif_running(ndev) || !netif_carrier_ok(ndev))) {
+	if (unlikely(!netif_running(ndev))) {
 		dev_kfree_skb_any(skb);
 		return;
 	}
@@ -1038,7 +1038,9 @@ static void emac_rx_handler(void *token, int len, int status)
 recycle:
 	ret = cpdma_chan_submit(priv->rxchan, skb, skb->data,
 			skb_tailroom(skb), GFP_KERNEL);
-	if (WARN_ON(ret < 0))
+
+	WARN_ON(ret == -ENOMEM);
+	if (unlikely(ret < 0))
 		dev_kfree_skb_any(skb);
 }
 
-- 
1.7.0.4
