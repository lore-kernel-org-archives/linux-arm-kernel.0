From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 18 Sep 2017 11:16:26 +0300
Subject: [PATCH v2] dmaengine: edma: Align the memcpy acnt array size with the
 transfer
Message-ID: <20170918081626.12878-1-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?Memory to Memory transfers does not have any special alignment needs
regarding to acnt array size, but if one of the areas are in memory mapped
regions (like PCIe memory), we need to make sure that the acnt array size
is aligned with the mem copy parameters.

Before "dmaengine: edma: Optimize memcpy operation" change the memcpy was set
up in a different way: acnt == number of bytes in a word based on
__ffs((src | dest | len), bcnt and ccnt for looping the necessary number of
words to comlete the trasnfer.

Instead of reverting the commit we can fix it to make sure that the ACNT size
is aligned to the traswnfer.

Fixes: df6694f80365a (dmaengine: edma: Optimize memcpy operation)
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: stable at vger.kernel.org
---
Hi,

Changes since v1:
- Added Cc and Fixes tags to the commit massage for proper Stable handling.
- Extended the commit message a bit to explain the issue a bit more.

Regards,
Peter

 drivers/dma/edma.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 14c52574262c..2f880010297d 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -1169,11 +1169,24 @@ static struct dma_async_tx_descriptor *edma_prep_dma_memcpy(
 	struct edma_desc *edesc;
 	struct device *dev = chan->device->dev;
 	struct edma_chan *echan = to_edma_chan(chan);
-	unsigned int width, pset_len;
+	unsigned int width, pset_len, array_size;
 
 	if (unlikely(!echan || !len))
 		return NULL;
 
+	/* Align the array size (acnt block) with the transfer properties */
+	switch (__ffs((src | dest | len))) {
+	case 0:
+		array_size = SZ_32K - 1;
+		break;
+	case 1:
+		array_size = SZ_32K - 2;
+		break;
+	default:
+		array_size = SZ_32K - 4;
+		break;
+	}
+
 	if (len < SZ_64K) {
 		/*
 		 * Transfer size less than 64K can be handled with one paRAM
@@ -1195,7 +1208,7 @@ static struct dma_async_tx_descriptor *edma_prep_dma_memcpy(
 		 * When the full_length is multibple of 32767 one slot can be
 		 * used to complete the transfer.
 		 */
-		width = SZ_32K - 1;
+		width = array_size;
 		pset_len = rounddown(len, width);
 		/* One slot is enough for lengths multiple of (SZ_32K -1) */
 		if (unlikely(pset_len == len))
@@ -1243,7 +1256,7 @@ static struct dma_async_tx_descriptor *edma_prep_dma_memcpy(
 		}
 		dest += pset_len;
 		src += pset_len;
-		pset_len = width = len % (SZ_32K - 1);
+		pset_len = width = len % array_size;
 
 		ret = edma_config_pset(chan, &edesc->pset[1], src, dest, 1,
 				       width, pset_len, DMA_MEM_TO_MEM);
-- 
2.14.1


Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
