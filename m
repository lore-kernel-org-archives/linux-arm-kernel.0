From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Tue, 17 Aug 2010 01:31:07 +0200
Subject: E100: another PCI problem on IXP4xx (guess all ARM)
Message-ID: <m3r5hygmo4.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I also found another PCI issue: e100 driver (to be precise, my own fix
to e100: 6ff9c2e7fa8ca63a575792534b63c5092099c286) doesn't play nice
with dma-mapping BIDIRECTIONAL direction checks. How about copying
42d53b4ff7d61487d18274ebdf1f70c1aef6f122 to ARM?

I know E100 isn't exactly designed as per DMA-API document, but given
the inner workings of cache management and DMA bouncing code, this is
the only workable solution (well, maybe using that other descriptor ring
mode is another).

Comments?

ARM: fix DMA-bounce code to allow sync from_device and to_device with
bidirectional mappings.

Signed-off-by: Krzysztof Ha?asa <khc@pm.waw.pl>

diff --git a/arch/arm/common/dmabounce.c b/arch/arm/common/dmabounce.c
index cc0a932..7c6ad2b 100644
--- a/arch/arm/common/dmabounce.c
+++ b/arch/arm/common/dmabounce.c
@@ -402,7 +402,7 @@ int dmabounce_sync_for_cpu(struct device *dev, dma_addr_t addr,
 	if (!buf)
 		return 1;
 
-	BUG_ON(buf->direction != dir);
+	BUG_ON(buf->direction != dir && buf->direction != DMA_BIDIRECTIONAL);
 
 	dev_dbg(dev, "%s: unsafe buffer %p (dma=%#x) mapped to %p (dma=%#x)\n",
 		__func__, buf->ptr, virt_to_dma(dev, buf->ptr),
@@ -431,7 +431,7 @@ int dmabounce_sync_for_device(struct device *dev, dma_addr_t addr,
 	if (!buf)
 		return 1;
 
-	BUG_ON(buf->direction != dir);
+	BUG_ON(buf->direction != dir && buf->direction != DMA_BIDIRECTIONAL);
 
 	dev_dbg(dev, "%s: unsafe buffer %p (dma=%#x) mapped to %p (dma=%#x)\n",
 		__func__, buf->ptr, virt_to_dma(dev, buf->ptr),


-- 
Krzysztof Halasa
