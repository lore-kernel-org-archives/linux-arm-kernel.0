From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 Nov 2012 11:04:59 +0100
Subject: [PATCH 21/30] dma: mv_xor: use mv_xor_chan pointers as arguments to
 self-test functions
In-Reply-To: <1353319508-30566-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353319508-30566-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353319508-30566-22-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for the removal of the mv_xor_device structure, we
directly pass mv_xor_chan pointers to the self-test functions included
in the driver. These functions were anyway selecting the first (and
only channel) available in each DMA device, so the behaviour is
unchanged.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/dma/mv_xor.c |   17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index a64e30e..75a8051 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -898,7 +898,7 @@ static void mv_xor_issue_pending(struct dma_chan *chan)
  */
 #define MV_XOR_TEST_SIZE 2000
 
-static int __devinit mv_xor_memcpy_self_test(struct mv_xor_device *device)
+static int __devinit mv_xor_memcpy_self_test(struct mv_xor_chan *mv_chan)
 {
 	int i;
 	void *src, *dest;
@@ -922,10 +922,7 @@ static int __devinit mv_xor_memcpy_self_test(struct mv_xor_device *device)
 	for (i = 0; i < MV_XOR_TEST_SIZE; i++)
 		((u8 *) src)[i] = (u8)i;
 
-	/* Start copy, using first DMA channel */
-	dma_chan = container_of(device->dmadev.channels.next,
-				struct dma_chan,
-				device_node);
+	dma_chan = &mv_chan->dmachan;
 	if (mv_xor_alloc_chan_resources(dma_chan) < 1) {
 		err = -ENODEV;
 		goto out;
@@ -971,7 +968,7 @@ out:
 
 #define MV_XOR_NUM_SRC_TEST 4 /* must be <= 15 */
 static int __devinit
-mv_xor_xor_self_test(struct mv_xor_device *device)
+mv_xor_xor_self_test(struct mv_xor_chan *mv_chan)
 {
 	int i, src_idx;
 	struct page *dest;
@@ -1016,9 +1013,7 @@ mv_xor_xor_self_test(struct mv_xor_device *device)
 
 	memset(page_address(dest), 0, PAGE_SIZE);
 
-	dma_chan = container_of(device->dmadev.channels.next,
-				struct dma_chan,
-				device_node);
+	dma_chan = &mv_chan->dmachan;
 	if (mv_xor_alloc_chan_resources(dma_chan) < 1) {
 		err = -ENODEV;
 		goto out;
@@ -1183,14 +1178,14 @@ mv_xor_channel_add(struct mv_xor_private *msp,
 	list_add_tail(&mv_chan->dmachan.device_node, &dma_dev->channels);
 
 	if (dma_has_cap(DMA_MEMCPY, dma_dev->cap_mask)) {
-		ret = mv_xor_memcpy_self_test(adev);
+		ret = mv_xor_memcpy_self_test(mv_chan);
 		dev_dbg(&pdev->dev, "memcpy self test returned %d\n", ret);
 		if (ret)
 			goto err_free_dma;
 	}
 
 	if (dma_has_cap(DMA_XOR, dma_dev->cap_mask)) {
-		ret = mv_xor_xor_self_test(adev);
+		ret = mv_xor_xor_self_test(mv_chan);
 		dev_dbg(&pdev->dev, "xor self test returned %d\n", ret);
 		if (ret)
 			goto err_free_dma;
-- 
1.7.9.5
