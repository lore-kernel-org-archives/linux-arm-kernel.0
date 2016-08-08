From: labbott@redhat.com (Laura Abbott)
Date: Mon,  8 Aug 2016 10:49:37 -0700
Subject: [RFCv2][PATCH 5/5] staging: ion: Add support for syncing with
 DMA_BUF_IOCTL_SYNC
In-Reply-To: <1470678577-14010-1-git-send-email-labbott@redhat.com>
References: <1470678577-14010-1-git-send-email-labbott@redhat.com>
Message-ID: <1470678577-14010-6-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laura Abbott <labbott@fedoraproject.org>


dma_buf added support for a userspace syncing ioctl. It is implemented
by calling dma_buf_begin_cpu_access and dma_buf_end_cpu_access. Ion
currently lacks cache operations on this code path. Add them for
compatibility with the dma_buf ioctl.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 drivers/staging/android/ion/ion.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index 5cbe22e..8153af3 100644
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -1109,6 +1109,24 @@ static void ion_dma_buf_kunmap(struct dma_buf *dmabuf, unsigned long offset,
 {
 }
 
+static void ion_clean_buffer(struct ion_buffer *buffer)
+{
+	struct scatterlist *sg;
+	int i;
+
+	for_each_sg(buffer->sg_table->sgl, sg, buffer->sg_table->orig_nents, i)
+		kernel_force_cache_clean(sg_page(sg), sg->length);
+}
+
+static void ion_invalidate_buffer(struct ion_buffer *buffer)
+{
+	struct scatterlist *sg;
+	int i;
+
+	for_each_sg(buffer->sg_table->sgl, sg, buffer->sg_table->orig_nents, i)
+		kernel_force_cache_invalidate(sg_page(sg), sg->length);
+}
+
 static int ion_dma_buf_begin_cpu_access(struct dma_buf *dmabuf,
 					enum dma_data_direction direction)
 {
@@ -1124,6 +1142,11 @@ static int ion_dma_buf_begin_cpu_access(struct dma_buf *dmabuf,
 	mutex_lock(&buffer->lock);
 	vaddr = ion_buffer_kmap_get(buffer);
 	mutex_unlock(&buffer->lock);
+
+	if (direction != DMA_TO_DEVICE) {
+		ion_invalidate_buffer(buffer);
+	}
+
 	return PTR_ERR_OR_ZERO(vaddr);
 }
 
@@ -1136,6 +1159,12 @@ static int ion_dma_buf_end_cpu_access(struct dma_buf *dmabuf,
 	ion_buffer_kmap_put(buffer);
 	mutex_unlock(&buffer->lock);
 
+	if (direction == DMA_FROM_DEVICE) {
+		ion_invalidate_buffer(buffer);
+	} else {
+		ion_clean_buffer(buffer);
+	}
+
 	return 0;
 }
 
@@ -1266,6 +1295,8 @@ static int ion_sync_for_device(struct ion_client *client, int fd)
 	struct dma_buf *dmabuf;
 	struct ion_buffer *buffer;
 
+	WARN_ONCE(1, "This API is deprecated in favor of the dma_buf ioctl\n");
+
 	dmabuf = dma_buf_get(fd);
 	if (IS_ERR(dmabuf))
 		return PTR_ERR(dmabuf);
-- 
2.7.4
