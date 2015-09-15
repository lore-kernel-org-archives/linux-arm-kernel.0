From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Tue, 15 Sep 2015 15:38:24 +0200
Subject: [PATCH 3/4] dmaengine: at_xdmac: fix memory leak in interleaved mode
In-Reply-To: <1442323770-20266-1-git-send-email-ludovic.desroches@atmel.com>
References: <1442323770-20266-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1442324304-20447-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In interleaved mode, when numf > 1, we have only one descriptor for the
transfer but this descriptor has to be added to the descs_list. If not,
when doing remove_xfer, the descriptor won't be put back in the
free_descs_list.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/dma/at_xdmac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 3952bff..fbd4093 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -958,6 +958,10 @@ at_xdmac_prep_interleaved(struct dma_chan *chan,
 							xt, xt->sgl);
 		for (i = 0; i < xt->numf; i++)
 			at_xdmac_increment_block_count(chan, first);
+
+		dev_dbg(chan2dev(chan), "%s: add desc 0x%p to descs_list 0x%p\n",
+			__func__, first, first);
+		list_add_tail(&first->desc_node, &first->descs_list);
 	} else {
 		for (i = 0; i < xt->frame_size; i++) {
 			size_t src_icg = 0, dst_icg = 0;
-- 
2.5.0
