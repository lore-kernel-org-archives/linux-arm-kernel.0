From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 Nov 2012 11:05:08 +0100
Subject: [PATCH 30/30] dma: mv_xor: Add a device_control function
In-Reply-To: <1353319508-30566-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353319508-30566-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353319508-30566-31-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Lunn <andrew@lunn.ch>

The dmatest module for DMA engines calls

device_control(dtc->chan, DMA_TERMINATE_ALL, 0);

after completing the tests. The documentation in
include/linux/dmaengine.h suggests this function is optional and
dma_async_device_register() also does not BUG_ON() when not passed a
function. However, dmatest is not the only code in the kernel
unconditionally calling device_control. So add an implementation
indicating all operations are not implemented.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/dma/mv_xor.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 97c8611f..f450fe8 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1070,6 +1070,14 @@ out:
 	return err;
 }
 
+/* This driver does not implement any of the optional DMA operations. */
+static int
+mv_xor_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
+	       unsigned long arg)
+{
+	return -ENOSYS;
+}
+
 static int mv_xor_channel_remove(struct mv_xor_chan *mv_chan)
 {
 	struct dma_chan *chan, *_chan;
@@ -1130,6 +1138,7 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 	dma_dev->device_free_chan_resources = mv_xor_free_chan_resources;
 	dma_dev->device_tx_status = mv_xor_status;
 	dma_dev->device_issue_pending = mv_xor_issue_pending;
+	dma_dev->device_control = mv_xor_control;
 	dma_dev->dev = &pdev->dev;
 
 	/* set prep routines based on capability */
-- 
1.7.9.5
