From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Sun, 23 Mar 2014 01:38:41 +0100
Subject: [PATCH 3/3] ARM: Fix DMA-bounce code to allow sync from_device and
 to_device with bidirectional mappings.
In-Reply-To: <m3siq9iyt2.fsf@intrepid.localdomain> (Krzysztof Halasa's message
 of "Sun, 23 Mar 2014 00:44:09 +0100")
References: <m3siq9iyt2.fsf@intrepid.localdomain>
Message-ID: <m338i9iwa6.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is equivalent of a more generic change to lib/dma-debug.c which is
present since v2.6.33:

commit 42d53b4ff7d61487d18274ebdf1f70c1aef6f122
dma-debug: allow DMA_BIDIRECTIONAL mappings to be synced with DMA_FROM_DEVICE
and DMA_TO_DEVICE.

There is no need to perform full BIDIR sync (copying the buffers in case
of swiotlb and similar schemes) if we know that the owner (CPU or device)
hasn't altered the data.

Addresses the false-positive reported at
http://bugzilla.kernel.org/show_bug.cgi?id=14169

Signed-off-by: Krzysztof Ha?asa <khc@pm.waw.pl>

diff --git a/arch/arm/common/dmabounce.c b/arch/arm/common/dmabounce.c
index 1143c4d..b4c17cf 100644
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
