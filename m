From: saeed@marvell.com (Saeed Bishara)
Date: Wed,  9 Jun 2010 11:51:23 +0300
Subject: [PATCH 1/2 v2] mv643xx_eth: use sw csum for big packets
In-Reply-To: <FCBE654890C0334289D0AD3AF4EF009F9FAC75A69C@IL-MB01.marvell.com>
References: <FCBE654890C0334289D0AD3AF4EF009F9FAC75A69C@IL-MB01.marvell.com>
Message-ID: <1276073483-17208-1-git-send-email-saeed@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some controllers (KW, Dove) limits the TX IP/layer4 checksum offloading to a max size.

Signed-off-by: Saeed Bishara <saeed@marvell.com>
---
 drivers/net/mv643xx_eth.c   |    7 ++++++-
 include/linux/mv643xx_eth.h |    5 +++++
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/drivers/net/mv643xx_eth.c b/drivers/net/mv643xx_eth.c
index e345ec8..2d0e06b 100644
--- a/drivers/net/mv643xx_eth.c
+++ b/drivers/net/mv643xx_eth.c
@@ -289,6 +289,7 @@ struct mv643xx_eth_shared_private {
 	unsigned int t_clk;
 	int extended_rx_coal_limit;
 	int tx_bw_control;
+	int tx_csum_limit;
 };
 
 #define TX_BW_CONTROL_ABSENT		0
@@ -782,7 +783,8 @@ static int txq_submit_skb(struct tx_queue *txq, struct sk_buff *skb)
 		       skb->protocol != htons(ETH_P_8021Q));
 
 		tag_bytes = (void *)ip_hdr(skb) - (void *)skb->data - ETH_HLEN;
-		if (unlikely(tag_bytes & ~12)) {
+		if (unlikely(tag_bytes & ~12) ||
+			skb->len > mp->shared->tx_csum_limit) {
 			if (skb_checksum_help(skb) == 0)
 				goto no_csum;
 			kfree_skb(skb);
@@ -2666,6 +2668,9 @@ static int mv643xx_eth_shared_probe(struct platform_device *pdev)
 	 * Detect hardware parameters.
 	 */
 	msp->t_clk = (pd != NULL && pd->t_clk != 0) ? pd->t_clk : 133000000;
+	msp->tx_csum_limit = pd->tx_csum_limit ? pd->tx_csum_limit : 9 * 1024;
+	/* add header count so we can compare against skb->len */
+	msp->tx_csum_limit += ETH_HLEN;
 	infer_hw_params(msp);
 
 	platform_set_drvdata(pdev, msp);
diff --git a/include/linux/mv643xx_eth.h b/include/linux/mv643xx_eth.h
index cbbbe9b..30b0c4e 100644
--- a/include/linux/mv643xx_eth.h
+++ b/include/linux/mv643xx_eth.h
@@ -19,6 +19,11 @@ struct mv643xx_eth_shared_platform_data {
 	struct mbus_dram_target_info	*dram;
 	struct platform_device	*shared_smi;
 	unsigned int		t_clk;
+	/*
+	 * Max packet size for Tx IP/Layer 4 checksum, when set to 0, default
+	 * limit of 9KiB will be used.
+	 */
+	int			tx_csum_limit;
 };
 
 #define MV643XX_ETH_PHY_ADDR_DEFAULT	0
-- 
1.6.0.4
