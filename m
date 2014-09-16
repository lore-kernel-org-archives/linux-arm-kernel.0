From: Frank.Li@freescale.com (Frank.Li at freescale.com)
Date: Wed, 17 Sep 2014 01:58:07 +0800
Subject: [Patch net-next v2 1/4] net: fec: refine error handle of parser queue
 number from DT
In-Reply-To: <1410890290-11248-1-git-send-email-Frank.Li@freescale.com>
References: <1410890290-11248-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <1410890290-11248-2-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>

check tx and rx queue seperately.
fix typo, "Invalidate" and "fail".
change pr_err to pr_warn.

Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 8f8e55e..d209d2e 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -2890,23 +2890,23 @@ fec_enet_get_queue_num(struct platform_device *pdev, int *num_tx, int *num_rx)
 
 	/* parse the num of tx and rx queues */
 	err = of_property_read_u32(np, "fsl,num-tx-queues", num_tx);
-	err |= of_property_read_u32(np, "fsl,num-rx-queues", num_rx);
-	if (err) {
+	if (err)
 		*num_tx = 1;
+
+	err = of_property_read_u32(np, "fsl,num-rx-queues", num_rx);
+	if (err)
 		*num_rx = 1;
-		return;
-	}
 
 	if (*num_tx < 1 || *num_tx > FEC_ENET_MAX_TX_QS) {
-		dev_err(&pdev->dev, "Invalidate num_tx(=%d), fail back to 1\n",
-			*num_tx);
+		dev_warn(&pdev->dev, "Invalid num_tx(=%d), fall back to 1\n",
+			 *num_tx);
 		*num_tx = 1;
 		return;
 	}
 
 	if (*num_rx < 1 || *num_rx > FEC_ENET_MAX_RX_QS) {
-		dev_err(&pdev->dev, "Invalidate num_rx(=%d), fail back to 1\n",
-			*num_rx);
+		dev_warn(&pdev->dev, "Invalid num_rx(=%d), fall back to 1\n",
+			 *num_rx);
 		*num_rx = 1;
 		return;
 	}
@@ -2924,8 +2924,8 @@ fec_probe(struct platform_device *pdev)
 	const struct of_device_id *of_id;
 	static int dev_id;
 	struct device_node *np = pdev->dev.of_node, *phy_node;
-	int num_tx_qs = 1;
-	int num_rx_qs = 1;
+	int num_tx_qs;
+	int num_rx_qs;
 
 	of_id = of_match_device(fec_dt_ids, &pdev->dev);
 	if (of_id)
-- 
1.9.1
