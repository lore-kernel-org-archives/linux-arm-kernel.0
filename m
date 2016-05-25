From: labbott@redhat.com (Laura Abbott)
Date: Wed, 25 May 2016 12:48:04 -0700
Subject: [RFC][PATCH 3/3] staging: ion: Add dma_map/dma_unmap calls to dma_buf
 calls
In-Reply-To: <1464205684-5587-1-git-send-email-labbott@redhat.com>
References: <1464205684-5587-1-git-send-email-labbott@redhat.com>
Message-ID: <1464205684-5587-4-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



The .map_dma_buf/.unmap_dma_buf function calls are designed for buffer
users to perform DMA accesses. Ion doesn't call into the lower DMA
layer currently. This may leave mapping incomplete for devices with
more complex topologies (e.g. IOMMUs). Add the appropriate dma_map
calls to the dma_buf call backs.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 drivers/staging/android/ion/ion.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index 2096592..52dbea4 100644
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -980,7 +980,18 @@ static struct sg_table *ion_map_dma_buf(struct dma_buf_attachment *attachment,
 	struct dma_buf *dmabuf = attachment->dmabuf;
 	struct ion_buffer *buffer = dmabuf->priv;
 
+	/* Necessary but not sufficient: This is for userspace */
 	ion_buffer_sync_for_device(buffer, attachment->dev, direction);
+
+	/* The rest of this is for the standard mappings */
+	buffer->sg_table->nents = dma_map_sg(attachment->dev,
+					buffer->sg_table->sgl,
+					buffer->sg_table->orig_nents,
+					direction);
+
+	if (!buffer->sg_table->nents)
+		return ERR_PTR(-EIO);
+
 	return buffer->sg_table;
 }
 
@@ -988,6 +999,7 @@ static void ion_unmap_dma_buf(struct dma_buf_attachment *attachment,
 			      struct sg_table *table,
 			      enum dma_data_direction direction)
 {
+	dma_unmap_sg(attachment->dev, table->sgl, table->nents, direction);
 }
 
 static int ion_vm_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
-- 
2.5.5
