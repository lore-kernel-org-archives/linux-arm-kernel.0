From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue,  8 Mar 2016 13:57:06 +0100
Subject: [PATCH net 3/3] net: mvneta: fix error messages in mvneta_port_down
 function
In-Reply-To: <1457441826-6100-1-git-send-email-gregory.clement@free-electrons.com>
References: <1457441826-6100-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1457441826-6100-4-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dmitri Epshtein <dima@marvell.com>

This commit corrects error printing when shutting down the port. Also
magic numbers are replaced by existing macros.

Signed-off-by: Dmitri Epshtein <dima@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 2ee05cebea75..225d933259c0 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -873,14 +873,14 @@ static void mvneta_port_down(struct mvneta_port *pp)
 	do {
 		if (count++ >= MVNETA_RX_DISABLE_TIMEOUT_MSEC) {
 			netdev_warn(pp->dev,
-				    "TIMEOUT for RX stopped ! rx_queue_cmd: 0x08%x\n",
+				    "TIMEOUT for RX stopped ! rx_queue_cmd: 0x%08x\n",
 				    val);
 			break;
 		}
 		mdelay(1);
 
 		val = mvreg_read(pp, MVNETA_RXQ_CMD);
-	} while (val & 0xff);
+	} while (val & MVNETA_RXQ_ENABLE_MASK);
 
 	/* Stop Tx port activity. Check port Tx activity. Issue stop
 	 * command for active channels only
@@ -905,14 +905,14 @@ static void mvneta_port_down(struct mvneta_port *pp)
 		/* Check TX Command reg that all Txqs are stopped */
 		val = mvreg_read(pp, MVNETA_TXQ_CMD);
 
-	} while (val & 0xff);
+	} while (val & MVNETA_TXQ_ENABLE_MASK);
 
 	/* Double check to verify that TX FIFO is empty */
 	count = 0;
 	do {
 		if (count++ >= MVNETA_TX_FIFO_EMPTY_TIMEOUT) {
 			netdev_warn(pp->dev,
-				    "TX FIFO empty timeout status=0x08%x\n",
+				    "TX FIFO empty timeout status=0x%08x\n",
 				    val);
 			break;
 		}
-- 
2.5.0
