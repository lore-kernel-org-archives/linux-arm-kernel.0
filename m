From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 Nov 2012 11:04:39 +0100
Subject: [PATCH 01/30] dma: mv_xor: use dev_(err|info|notice) instead of
 dev_printk
In-Reply-To: <1353319508-30566-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353319508-30566-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353319508-30566-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The usage of dev_printk() is deprecated, and the dev_err(), dev_info()
and dev_notice() functions should be used instead.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/dma/mv_xor.c |   60 +++++++++++++++++++++++++-------------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index e362e2b..610d0b8 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -206,9 +206,9 @@ static void mv_set_mode(struct mv_xor_chan *chan,
 		op_mode = XOR_OPERATION_MODE_MEMSET;
 		break;
 	default:
-		dev_printk(KERN_ERR, chan->device->common.dev,
-			   "error: unsupported operation %d.\n",
-			   type);
+		dev_err(chan->device->common.dev,
+			"error: unsupported operation %d.\n",
+			type);
 		BUG();
 		return;
 	}
@@ -828,28 +828,28 @@ static void mv_dump_xor_regs(struct mv_xor_chan *chan)
 	u32 val;
 
 	val = __raw_readl(XOR_CONFIG(chan));
-	dev_printk(KERN_ERR, chan->device->common.dev,
-		   "config       0x%08x.\n", val);
+	dev_err(chan->device->common.dev,
+		"config       0x%08x.\n", val);
 
 	val = __raw_readl(XOR_ACTIVATION(chan));
-	dev_printk(KERN_ERR, chan->device->common.dev,
-		   "activation   0x%08x.\n", val);
+	dev_err(chan->device->common.dev,
+		"activation   0x%08x.\n", val);
 
 	val = __raw_readl(XOR_INTR_CAUSE(chan));
-	dev_printk(KERN_ERR, chan->device->common.dev,
-		   "intr cause   0x%08x.\n", val);
+	dev_err(chan->device->common.dev,
+		"intr cause   0x%08x.\n", val);
 
 	val = __raw_readl(XOR_INTR_MASK(chan));
-	dev_printk(KERN_ERR, chan->device->common.dev,
-		   "intr mask    0x%08x.\n", val);
+	dev_err(chan->device->common.dev,
+		"intr mask    0x%08x.\n", val);
 
 	val = __raw_readl(XOR_ERROR_CAUSE(chan));
-	dev_printk(KERN_ERR, chan->device->common.dev,
-		   "error cause  0x%08x.\n", val);
+	dev_err(chan->device->common.dev,
+		"error cause  0x%08x.\n", val);
 
 	val = __raw_readl(XOR_ERROR_ADDR(chan));
-	dev_printk(KERN_ERR, chan->device->common.dev,
-		   "error addr   0x%08x.\n", val);
+	dev_err(chan->device->common.dev,
+		"error addr   0x%08x.\n", val);
 }
 
 static void mv_xor_err_interrupt_handler(struct mv_xor_chan *chan,
@@ -861,9 +861,9 @@ static void mv_xor_err_interrupt_handler(struct mv_xor_chan *chan,
 	     return;
 	}
 
-	dev_printk(KERN_ERR, chan->device->common.dev,
-		   "error on chan %d. intr cause 0x%08x.\n",
-		   chan->idx, intr_cause);
+	dev_err(chan->device->common.dev,
+		"error on chan %d. intr cause 0x%08x.\n",
+		chan->idx, intr_cause);
 
 	mv_dump_xor_regs(chan);
 	BUG();
@@ -950,8 +950,8 @@ static int __devinit mv_xor_memcpy_self_test(struct mv_xor_device *device)
 
 	if (mv_xor_status(dma_chan, cookie, NULL) !=
 	    DMA_SUCCESS) {
-		dev_printk(KERN_ERR, dma_chan->device->dev,
-			   "Self-test copy timed out, disabling\n");
+		dev_err(dma_chan->device->dev,
+			"Self-test copy timed out, disabling\n");
 		err = -ENODEV;
 		goto free_resources;
 	}
@@ -960,8 +960,8 @@ static int __devinit mv_xor_memcpy_self_test(struct mv_xor_device *device)
 	dma_sync_single_for_cpu(&mv_chan->device->pdev->dev, dest_dma,
 				MV_XOR_TEST_SIZE, DMA_FROM_DEVICE);
 	if (memcmp(src, dest, MV_XOR_TEST_SIZE)) {
-		dev_printk(KERN_ERR, dma_chan->device->dev,
-			   "Self-test copy failed compare, disabling\n");
+		dev_err(dma_chan->device->dev,
+			"Self-test copy failed compare, disabling\n");
 		err = -ENODEV;
 		goto free_resources;
 	}
@@ -1048,8 +1048,8 @@ mv_xor_xor_self_test(struct mv_xor_device *device)
 
 	if (mv_xor_status(dma_chan, cookie, NULL) !=
 	    DMA_SUCCESS) {
-		dev_printk(KERN_ERR, dma_chan->device->dev,
-			   "Self-test xor timed out, disabling\n");
+		dev_err(dma_chan->device->dev,
+			"Self-test xor timed out, disabling\n");
 		err = -ENODEV;
 		goto free_resources;
 	}
@@ -1060,10 +1060,10 @@ mv_xor_xor_self_test(struct mv_xor_device *device)
 	for (i = 0; i < (PAGE_SIZE / sizeof(u32)); i++) {
 		u32 *ptr = page_address(dest);
 		if (ptr[i] != cmp_word) {
-			dev_printk(KERN_ERR, dma_chan->device->dev,
-				   "Self-test xor failed compare, disabling."
-				   " index %d, data %x, expected %x\n", i,
-				   ptr[i], cmp_word);
+			dev_err(dma_chan->device->dev,
+				"Self-test xor failed compare, disabling."
+				" index %d, data %x, expected %x\n", i,
+				ptr[i], cmp_word);
 			err = -ENODEV;
 			goto free_resources;
 		}
@@ -1212,7 +1212,7 @@ static int __devinit mv_xor_probe(struct platform_device *pdev)
 			goto err_free_dma;
 	}
 
-	dev_printk(KERN_INFO, &pdev->dev, "Marvell XOR: "
+	dev_info(&pdev->dev, "Marvell XOR: "
 	  "( %s%s%s%s)\n",
 	  dma_has_cap(DMA_XOR, dma_dev->cap_mask) ? "xor " : "",
 	  dma_has_cap(DMA_MEMSET, dma_dev->cap_mask)  ? "fill " : "",
@@ -1275,7 +1275,7 @@ static int mv_xor_shared_probe(struct platform_device *pdev)
 	struct mv_xor_shared_private *msp;
 	struct resource *res;
 
-	dev_printk(KERN_NOTICE, &pdev->dev, "Marvell shared XOR driver\n");
+	dev_notice(&pdev->dev, "Marvell shared XOR driver\n");
 
 	msp = devm_kzalloc(&pdev->dev, sizeof(*msp), GFP_KERNEL);
 	if (!msp)
-- 
1.7.9.5
