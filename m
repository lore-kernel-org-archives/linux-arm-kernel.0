From: stefan@agner.ch (Stefan Agner)
Date: Sun, 22 Mar 2015 00:51:08 +0100
Subject: [PATCH] dmaengine: ste_dma40: fix implicit conversion
Message-ID: <1426981868-1988-1-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The function d40_prep_sg takes the type enum dma_transfer_direction
as second last parameter. However, the memcpy calls pass DMA_NONE
which is of type enum dma_data_direction. Fix this by passing the
actual transfer direction DMA_MEM_TO_MEM.

This does not change the actual code flow since only the transfer
direction DMA_MEM_TO_DEV and DMA_DEV_TO_MEM are actually used in the
function d40_prep_sg.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
This was uncovered by a LLVM/clang warnings:
drivers/dma/ste_dma40.c:2505:48: warning: implicit conversion from enumeration type 'enum dma_data_direction' to different enumeration type 'enum dma_transfer_direction'
      [-Wenum-conversion]
        return d40_prep_sg(chan, &src_sg, &dst_sg, 1, DMA_NONE, dma_flags);
               ~~~~~~~~~~~                            ^~~~~~~~
drivers/dma/ste_dma40.c:2517:54: warning: implicit conversion from enumeration type 'enum dma_data_direction' to different enumeration type 'enum dma_transfer_direction'
      [-Wenum-conversion]
        return d40_prep_sg(chan, src_sg, dst_sg, src_nents, DMA_NONE, dma_flags);
               ~~~~~~~~~~~                                  ^~~~~~~~

 drivers/dma/ste_dma40.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 15d4946..ace03dc 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -2502,7 +2502,8 @@ static struct dma_async_tx_descriptor *d40_prep_memcpy(struct dma_chan *chan,
 	sg_dma_len(&dst_sg) = size;
 	sg_dma_len(&src_sg) = size;
 
-	return d40_prep_sg(chan, &src_sg, &dst_sg, 1, DMA_NONE, dma_flags);
+	return d40_prep_sg(chan, &src_sg, &dst_sg, 1,
+			   DMA_MEM_TO_MEM, dma_flags);
 }
 
 static struct dma_async_tx_descriptor *
@@ -2514,7 +2515,8 @@ d40_prep_memcpy_sg(struct dma_chan *chan,
 	if (dst_nents != src_nents)
 		return NULL;
 
-	return d40_prep_sg(chan, src_sg, dst_sg, src_nents, DMA_NONE, dma_flags);
+	return d40_prep_sg(chan, src_sg, dst_sg, src_nents,
+			   DMA_MEM_TO_MEM, dma_flags);
 }
 
 static struct dma_async_tx_descriptor *
-- 
2.3.3
