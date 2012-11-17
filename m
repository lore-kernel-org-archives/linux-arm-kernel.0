From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 17 Nov 2012 18:15:01 +0100
Subject: [PATCH] DMA: mv_xor: Add a device_control function
Message-ID: <1353172501-499-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dmatest module for DMA engines calls

device_control(dtc->chan, DMA_TERMINATE_ALL, 0);

after completing the tests. The documentation in
include/linux/dmaengine.h suggests this function is optional and
dma_async_device_register() also does not BUG_ON() when not passed a
function. However, dmatest is not the only code in the kernel
unconditionally calling device_control. So add an implementation
indicating all operations are not implemented.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---

This patch applies on top of Thomas Petazzoni big code refactor.

 drivers/dma/mv_xor.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index d645d43..c063aee 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -658,8 +658,6 @@ mv_xor_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 	dev_dbg(mv_chan_to_devp(mv_chan),
 		"%s dest: %x src %x len: %u flags: %ld\n",
 		__func__, dest, src, len, flags);
-	if (unlikely(len < MV_XOR_MIN_BYTE_COUNT))
-		return NULL;
 
 	BUG_ON(len > MV_XOR_MAX_BYTE_COUNT);
 
@@ -697,8 +695,6 @@ mv_xor_prep_dma_memset(struct dma_chan *chan, dma_addr_t dest, int value,
 	dev_dbg(mv_chan_to_devp(mv_chan),
 		"%s dest: %x len: %u flags: %ld\n",
 		__func__, dest, len, flags);
-	if (unlikely(len < MV_XOR_MIN_BYTE_COUNT))
-		return NULL;
 
 	BUG_ON(len > MV_XOR_MAX_BYTE_COUNT);
 
@@ -731,9 +727,6 @@ mv_xor_prep_dma_xor(struct dma_chan *chan, dma_addr_t dest, dma_addr_t *src,
 	struct mv_xor_desc_slot *sw_desc, *grp_start;
 	int slot_cnt;
 
-	if (unlikely(len < MV_XOR_MIN_BYTE_COUNT))
-		return NULL;
-
 	BUG_ON(len > MV_XOR_MAX_BYTE_COUNT);
 
 	dev_dbg(mv_chan_to_devp(mv_chan),
@@ -1089,6 +1082,14 @@ static int __devexit mv_xor_channel_remove(struct mv_xor_chan *mv_chan)
 	return 0;
 }
 
+/* This driver does not implement any of the optional DMA operations. */
+static int
+mv_xor_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
+	       unsigned long arg)
+{
+	return -ENOSYS;
+}
+
 static struct mv_xor_chan * __devinit
 mv_xor_channel_add(struct mv_xor_device *xordev,
 		   struct platform_device *pdev,
@@ -1129,6 +1130,7 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 	dma_dev->device_free_chan_resources = mv_xor_free_chan_resources;
 	dma_dev->device_tx_status = mv_xor_status;
 	dma_dev->device_issue_pending = mv_xor_issue_pending;
+	dma_dev->device_control = mv_xor_control;
 	dma_dev->dev = &pdev->dev;
 
 	/* set prep routines based on capability */
-- 
1.7.10.4
