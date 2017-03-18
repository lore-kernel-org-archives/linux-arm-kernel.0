From: labbott@redhat.com (Laura Abbott)
Date: Fri, 17 Mar 2017 17:54:37 -0700
Subject: [RFC PATCHv2 05/21] staging: android: ion: Duplicate sg_table
In-Reply-To: <1489798493-16600-1-git-send-email-labbott@redhat.com>
References: <1489798493-16600-1-git-send-email-labbott@redhat.com>
Message-ID: <1489798493-16600-6-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Ion currently returns a single sg_table on each dma_map call. This is
incorrect for later usage.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 drivers/staging/android/ion/ion.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index c2adfe1..7dcb8a9 100644
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -800,6 +800,32 @@ static void ion_buffer_sync_for_device(struct ion_buffer *buffer,
 				       struct device *dev,
 				       enum dma_data_direction direction);
 
+static struct sg_table *dup_sg_table(struct sg_table *table)
+{
+	struct sg_table *new_table;
+	int ret, i;
+	struct scatterlist *sg, *new_sg;
+
+	new_table = kzalloc(sizeof(*new_table), GFP_KERNEL);
+	if (!new_table)
+		return ERR_PTR(-ENOMEM);
+
+	ret = sg_alloc_table(new_table, table->nents, GFP_KERNEL);
+	if (ret) {
+		kfree(new_table);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	new_sg = new_table->sgl;
+	for_each_sg(table->sgl, sg, table->nents, i) {
+		memcpy(new_sg, sg, sizeof(*sg));
+		sg->dma_address = 0;
+		new_sg = sg_next(new_sg);
+	}
+
+	return new_table;
+}
+
 static struct sg_table *ion_map_dma_buf(struct dma_buf_attachment *attachment,
 					enum dma_data_direction direction)
 {
@@ -807,13 +833,15 @@ static struct sg_table *ion_map_dma_buf(struct dma_buf_attachment *attachment,
 	struct ion_buffer *buffer = dmabuf->priv;
 
 	ion_buffer_sync_for_device(buffer, attachment->dev, direction);
-	return buffer->sg_table;
+	return dup_sg_table(buffer->sg_table);
 }
 
 static void ion_unmap_dma_buf(struct dma_buf_attachment *attachment,
 			      struct sg_table *table,
 			      enum dma_data_direction direction)
 {
+	sg_free_table(table);
+	kfree(table);
 }
 
 void ion_pages_sync_for_device(struct device *dev, struct page *page,
-- 
2.7.4
