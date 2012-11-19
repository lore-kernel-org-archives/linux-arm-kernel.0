From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 Nov 2012 11:04:54 +0100
Subject: [PATCH 16/30] dma: mv_xor: simplify dma_sync_single_for_cpu() calls
In-Reply-To: <1353319508-30566-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353319508-30566-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353319508-30566-17-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In mv_xor_memcpy_self_test() and mv_xor_xor_self_test(), all DMA
functions are called by passing dma_chan->device->dev as the 'device
*', except the calls to dma_sync_single_for_cpu() which uselessly goes
through mv_chan->device->pdev->dev.

Simplify this by using dma_chan->device->dev direclty in
dma_sync_single_for_cpu() calls.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/dma/mv_xor.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index a999471..b799d33 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -905,7 +905,6 @@ static int __devinit mv_xor_memcpy_self_test(struct mv_xor_device *device)
 	dma_cookie_t cookie;
 	struct dma_async_tx_descriptor *tx;
 	int err = 0;
-	struct mv_xor_chan *mv_chan;
 
 	src = kmalloc(sizeof(u8) * MV_XOR_TEST_SIZE, GFP_KERNEL);
 	if (!src)
@@ -951,8 +950,7 @@ static int __devinit mv_xor_memcpy_self_test(struct mv_xor_device *device)
 		goto free_resources;
 	}
 
-	mv_chan = to_mv_xor_chan(dma_chan);
-	dma_sync_single_for_cpu(&mv_chan->device->pdev->dev, dest_dma,
+	dma_sync_single_for_cpu(dma_chan->device->dev, dest_dma,
 				MV_XOR_TEST_SIZE, DMA_FROM_DEVICE);
 	if (memcmp(src, dest, MV_XOR_TEST_SIZE)) {
 		dev_err(dma_chan->device->dev,
@@ -984,7 +982,6 @@ mv_xor_xor_self_test(struct mv_xor_device *device)
 	u8 cmp_byte = 0;
 	u32 cmp_word;
 	int err = 0;
-	struct mv_xor_chan *mv_chan;
 
 	for (src_idx = 0; src_idx < MV_XOR_NUM_SRC_TEST; src_idx++) {
 		xor_srcs[src_idx] = alloc_page(GFP_KERNEL);
@@ -1049,8 +1046,7 @@ mv_xor_xor_self_test(struct mv_xor_device *device)
 		goto free_resources;
 	}
 
-	mv_chan = to_mv_xor_chan(dma_chan);
-	dma_sync_single_for_cpu(&mv_chan->device->pdev->dev, dest_dma,
+	dma_sync_single_for_cpu(dma_chan->device->dev, dest_dma,
 				PAGE_SIZE, DMA_FROM_DEVICE);
 	for (i = 0; i < (PAGE_SIZE / sizeof(u32)); i++) {
 		u32 *ptr = page_address(dest);
-- 
1.7.9.5
