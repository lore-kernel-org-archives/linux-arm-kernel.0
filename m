From: labbott@redhat.com (Laura Abbott)
Date: Fri, 17 Mar 2017 17:54:46 -0700
Subject: [RFC PATCHv2 14/21] staging: android: ion: Stop butchering the DMA
 address
In-Reply-To: <1489798493-16600-1-git-send-email-labbott@redhat.com>
References: <1489798493-16600-1-git-send-email-labbott@redhat.com>
Message-ID: <1489798493-16600-15-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Now that we have proper caching, stop setting the DMA address manually.
It should be set after properly calling dma_map.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 drivers/staging/android/ion/ion.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index 3d979ef5..65638f5 100644
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -81,8 +81,7 @@ static struct ion_buffer *ion_buffer_create(struct ion_heap *heap,
 {
 	struct ion_buffer *buffer;
 	struct sg_table *table;
-	struct scatterlist *sg;
-	int i, ret;
+	int ret;
 
 	buffer = kzalloc(sizeof(*buffer), GFP_KERNEL);
 	if (!buffer)
@@ -119,20 +118,6 @@ static struct ion_buffer *ion_buffer_create(struct ion_heap *heap,
 	INIT_LIST_HEAD(&buffer->vmas);
 	INIT_LIST_HEAD(&buffer->attachments);
 	mutex_init(&buffer->lock);
-	/*
-	 * this will set up dma addresses for the sglist -- it is not
-	 * technically correct as per the dma api -- a specific
-	 * device isn't really taking ownership here.  However, in practice on
-	 * our systems the only dma_address space is physical addresses.
-	 * Additionally, we can't afford the overhead of invalidating every
-	 * allocation via dma_map_sg. The implicit contract here is that
-	 * memory coming from the heaps is ready for dma, ie if it has a
-	 * cached mapping that mapping has been invalidated
-	 */
-	for_each_sg(buffer->sg_table->sgl, sg, buffer->sg_table->nents, i) {
-		sg_dma_address(sg) = sg_phys(sg);
-		sg_dma_len(sg) = sg->length;
-	}
 	mutex_lock(&dev->buffer_lock);
 	ion_buffer_add(dev, buffer);
 	mutex_unlock(&dev->buffer_lock);
-- 
2.7.4
