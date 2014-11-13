From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Thu, 13 Nov 2014 11:52:42 +0100
Subject: [PATCH 4/7] dmaengine: at_xdmac: fix a bug in transfer residue
 computation
In-Reply-To: <1415875965-6905-1-git-send-email-ludovic.desroches@atmel.com>
References: <1415875965-6905-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1415875965-6905-5-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cyrille Pitchen <cyrille.pitchen@atmel.com>

The total size of the transfer was wrong in at_xdmac_prep_slave_sg()
resulting in bad computation of the transfer residue by
at_xdmac_tx_status().

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/dma/at_xdmac.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index fa9d75a..bf2aacb 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -562,6 +562,7 @@ at_xdmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	struct scatterlist	*sg;
 	int			i;
 	u32			cfg;
+	unsigned int		xfer_size = 0;
 
 	if (!sgl)
 		return NULL;
@@ -637,12 +638,13 @@ at_xdmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 		dev_dbg(chan2dev(chan), "%s: add desc 0x%p to descs_list 0x%p\n",
 			 __func__, desc, first);
 		list_add_tail(&desc->desc_node, &first->descs_list);
+		xfer_size += len;
 	}
 
 	spin_unlock_bh(&atchan->lock);
 
 	first->tx_dma_desc.flags = flags;
-	first->xfer_size = sg_len;
+	first->xfer_size = xfer_size;
 	first->direction = direction;
 
 	return &first->tx_dma_desc;
-- 
2.0.3
