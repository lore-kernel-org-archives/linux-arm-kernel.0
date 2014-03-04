From: simon.kagstrom@netinsight.net (Simon =?UTF-8?B?S8OlZ3N0csO2bQ==?=)
Date: Tue, 4 Mar 2014 11:32:33 +0100
Subject: BUG_ON for DMA-bounce and bidirectional mappings (e100 on IXP4xx)
Message-ID: <20140304113233.14c95fe0@marrow.netinsight.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(Sorry, sent to wrong mailing list address)

Hi!

We have a IXP4xx-based board which has an e100 NIC. During bootup, we
trigger a BUG_ON in dmabounce.c because the mapped direction doesn't
match the synced one. e100.c maps buffers bidirectional, but the sync
is done fromdevice.

Krzysztof Ha?asa sent a patch 2012-09-20 which excludes bidirectional
mappings from the sync BUG_ONs, as seen below. We need that patch for
our board to boot. The patch in full is available at

  http://patchwork.ozlabs.org/patch/185486/

This was never applied, but also received no comments. Does the patch
make sense?


For further reference, the e100 BUG_ON was discussed here a few years
ago:

  http://comments.gmane.org/gmane.linux.ports.arm.kernel/48922

there is a e100 patch there from Jesse Brandeburg which changes the
mapping, however with that patch the NIC stops receiving traffic after
a while.

Thanks,
// Simon

--- a/arch/arm/common/dmabounce.c
+++ b/arch/arm/common/dmabounce.c
@@ -375,7 +375,7 @@ static int __dmabounce_sync_for_cpu(struct device *dev, dma_addr_t addr,
 
 	off = addr - buf->safe_dma_addr;
 
-	BUG_ON(buf->direction != dir);
+	BUG_ON(buf->direction != dir && buf->direction != DMA_BIDIRECTIONAL);
 
 	dev_dbg(dev, "%s: unsafe buffer %p (dma=%#x off=%#lx) mapped to %p (dma=%#x)\n",
 		__func__, buf->ptr, virt_to_dma(dev, buf->ptr), off,
@@ -415,7 +415,7 @@ static int __dmabounce_sync_for_device(struct device *dev, dma_addr_t addr,
 
 	off = addr - buf->safe_dma_addr;
 
-	BUG_ON(buf->direction != dir);
+	BUG_ON(buf->direction != dir && buf->direction != DMA_BIDIRECTIONAL);
 
 	dev_dbg(dev, "%s: unsafe buffer %p (dma=%#x off=%#lx) mapped to %p (dma=%#x)\n",
 		__func__, buf->ptr, virt_to_dma(dev, buf->ptr), off,
