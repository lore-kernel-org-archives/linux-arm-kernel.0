From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 18 Nov 2012 11:44:56 +0100
Subject: [PATCH v2 1/2] DMA: mv_xor: Add a device_control function
Message-ID: <1353235498-22638-1-git-send-email-andrew@lunn.ch>
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

This patch depends on the refactoring/DT patches from Thomas.

 drivers/dma/mv_xor.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index d645d43..944d7fe 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1089,6 +1089,14 @@ static int __devexit mv_xor_channel_remove(struct mv_xor_chan *mv_chan)
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
@@ -1129,6 +1137,7 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 	dma_dev->device_free_chan_resources = mv_xor_free_chan_resources;
 	dma_dev->device_tx_status = mv_xor_status;
 	dma_dev->device_issue_pending = mv_xor_issue_pending;
+	dma_dev->device_control = mv_xor_control;
 	dma_dev->dev = &pdev->dev;
 
 	/* set prep routines based on capability */
-- 
1.7.10.4
