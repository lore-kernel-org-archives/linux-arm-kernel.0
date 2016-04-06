From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Tue,  5 Apr 2016 19:25:57 -0700
Subject: [PATCH net-next V3 11/16] net: fec: clear cbd_sc after transmission
 to help with debugging
In-Reply-To: <1459909562-22865-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1459909562-22865-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <1459909562-22865-12-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the tx queue is dumped, it is easier to see that this
entry is idle if cbd_sc is cleared after transmission.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

---
v3: change commit message
---
 drivers/net/ethernet/freescale/fec_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index a2a9dca..f96ea97 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1164,6 +1164,8 @@ static void fec_txq(struct net_device *ndev, struct fec_enet_priv_tx_q *txq)
 			}
 			break;
 		}
+		bdp->cbd_sc = cpu_to_fec16((bdp == txq->bd.last) ?
+					   BD_SC_WRAP : 0);
 
 		index = fec_enet_get_bd_index(bdp, &txq->bd);
 
-- 
2.5.0
