From: labbott@redhat.com (Laura Abbott)
Date: Wed, 25 May 2016 12:48:03 -0700
Subject: [RFC][PATCH 2/3] staging: ion: Add support for syncing with
 DMA_BUF_IOCTL_SYNC
In-Reply-To: <1464205684-5587-1-git-send-email-labbott@redhat.com>
References: <1464205684-5587-1-git-send-email-labbott@redhat.com>
Message-ID: <1464205684-5587-3-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



dma_buf added support for a userspace syncing ioctl. It is implemented
by calling dma_buf_begin_cpu_access and dma_buf_end_cpu_access. Ion
currently lacks cache operations on this code path. Add them for
compatibility with the dma_buf ioctl.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 drivers/staging/android/ion/ion.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index 9282d96a..2096592 100644
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -1117,6 +1117,11 @@ static int ion_dma_buf_begin_cpu_access(struct dma_buf *dmabuf,
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
 
@@ -1129,6 +1134,12 @@ static int ion_dma_buf_end_cpu_access(struct dma_buf *dmabuf,
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
 
@@ -1259,6 +1270,8 @@ static int ion_sync_for_device(struct ion_client *client, int fd)
 	struct dma_buf *dmabuf;
 	struct ion_buffer *buffer;
 
+	WARN_ONCE(1, "This API is deprecated in favor of the dma_buf ioctl\n");
+
 	dmabuf = dma_buf_get(fd);
 	if (IS_ERR(dmabuf))
 		return PTR_ERR(dmabuf);
-- 
2.5.5
