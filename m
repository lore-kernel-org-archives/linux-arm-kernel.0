From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 2 Dec 2015 17:10:16 +0100
Subject: [PATCH] dmaengine: at_xdmac: fix bad behavior in interleaved mode
Message-ID: <1449072616-22377-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sylvain ETIENNE <Sylvain.ETIENNE@ingenico.com>

When performing interleaved transfers with numf > 1, an extra line is
copied. The mbr.bc field is incremented once too often. The length of
the block is (BLEN+1) microblocks.

Signed-off-by: Sylvain ETIENNE <Sylvain.ETIENNE@ingenico.com>
Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Fixes: 4e5385784e69 ("dmaengine: at_xdmac: handle numf > 1")
---
 drivers/dma/at_xdmac.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 7f039de..c8faaa5 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -965,7 +965,9 @@ at_xdmac_prep_interleaved(struct dma_chan *chan,
 							NULL,
 							src_addr, dst_addr,
 							xt, xt->sgl);
-		for (i = 0; i < xt->numf; i++)
+
+		/* Length of the block is (BLEN+1) microblocks. */
+		for (i = 0; i < xt->numf - 1; i++)
 			at_xdmac_increment_block_count(chan, first);
 
 		dev_dbg(chan2dev(chan), "%s: add desc 0x%p to descs_list 0x%p\n",
-- 
2.5.0
