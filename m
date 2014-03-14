From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Fri, 14 Mar 2014 09:36:32 +0200
Subject: [RFC][PATCH 1/1] ion: support multiple address space map
Message-ID: <20140314.093632.1854857348878394627.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Our H/Ws(inc. GPU) can accept a dmabuf fd which is originally
allocated via ION. GPU tries to map this buffer into  GPU address
space via ION dmabuf backend(.map_dma_buf). Our Tegra IOMMU supports
multiple address space in IOMMU. Basically each device has its own
address space assigned by IOMMU. Usually DMA API hides the existance
of IOMMU from driver code. To support this multiple IOMMU address
space, I think that at least "ion_map_dma_buf" needs to create IOMMU
mapping *per* device(address space). And I made the following patch
*experimentally*.

Is this the right solution to solve this multiple IOMMU address space?

Any comment would be really appreciated.

---8<------8<------8<------8<------8<------8<------8<------8<---
From: Hiroshi Doyu <hdoyu@nvidia.com>

Ion doesn't support multiple address space. The recent IOMMU usually
provide multiple address spaces, where a mapping depends on an address
space. An address space is bind to a device pointer passed from
attachment. Those info needs to be stored in a buffer info. If the
same buffer needs to be mapped into the same AS, the same mapping info
needs to be passed back.

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
 drivers/staging/android/ion/ion.c      | 96 +++++++++++++++++++++++++++++++++-
 drivers/staging/android/ion/ion_priv.h | 10 ++++
 2 files changed, 104 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index 0836717..e260434 100644
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -872,17 +872,109 @@ static void ion_buffer_sync_for_device(struct ion_buffer *buffer,
 static struct sg_table *ion_map_dma_buf(struct dma_buf_attachment *attachment,
 					enum dma_data_direction direction)
 {
+	int err, i, empty = -1;
+	struct dma_iommu_mapping *iommu_map;
 	struct dma_buf *dmabuf = attachment->dmabuf;
 	struct ion_buffer *buffer = dmabuf->priv;
+	unsigned int nents = buffer->sg_table->nents;
+	struct ion_mapping *map_ptr;
+	struct scatterlist *sg;
+
+	iommu_map = to_dma_iommu_mapping(attachment->dev);
+	if (!iommu_map) {
+		ion_buffer_sync_for_device(buffer, attachment->dev, direction);
+		return buffer->sg_table;
+	}
+
+	mutex_lock(&buffer->lock);
+	for (i = 0; i < ARRAY_SIZE(buffer->mapping); i++) {
+		map_ptr = &buffer->mapping[i];
+		if (!map_ptr->dev) {
+			empty = i;
+			continue;
+		}
+
+		if (to_dma_iommu_mapping(map_ptr->dev) == iommu_map) {
+			kref_get(&map_ptr->kref);
+			mutex_unlock(&buffer->lock);
+			return &map_ptr->sgt;
+		}
+	}
 
-	ion_buffer_sync_for_device(buffer, attachment->dev, direction);
-	return buffer->sg_table;
+	if (!empty) {
+		err = -ENOMEM;
+		goto err_no_space;
+	}
+
+	map_ptr = &buffer->mapping[empty];
+	err = sg_alloc_table(&map_ptr->sgt, nents, GFP_KERNEL);
+	if (err)
+		goto err_sg_alloc_table;
+
+	for_each_sg(buffer->sg_table->sgl, sg, nents, i)
+		memcpy(map_ptr->sgt.sgl + i, sg, sizeof(*sg));
+
+	nents = dma_map_sg(attachment->dev, map_ptr->sgt.sgl, nents, direction);
+	if (!nents) {
+		err = -EINVAL;
+		goto err_dma_map_sg;
+	}
+
+	kref_init(&map_ptr->kref);
+	map_ptr->dev = attachment->dev;
+	mutex_unlock(&buffer->lock);
+	return &map_ptr->sgt;
+
+err_dma_map_sg:
+	sg_free_table(&map_ptr->sgt);
+err_sg_alloc_table:
+err_no_space:
+	mutex_unlock(&buffer->lock);
+	return ERR_PTR(err);
+}
+
+static void __ion_unmap_dma_buf(struct kref *kref)
+{
+	struct ion_mapping *map_ptr;
+
+	map_ptr = container_of(kref, struct ion_mapping, kref);
+	dma_unmap_sg(map_ptr->dev, map_ptr->sgt.sgl, map_ptr->sgt.nents,
+		     DMA_BIDIRECTIONAL);
+	sg_free_table(&map_ptr->sgt);
+	memset(map_ptr, 0, sizeof(*map_ptr));
 }
 
 static void ion_unmap_dma_buf(struct dma_buf_attachment *attachment,
 			      struct sg_table *table,
 			      enum dma_data_direction direction)
 {
+	int i;
+	struct dma_iommu_mapping *iommu_map;
+	struct dma_buf *dmabuf = attachment->dmabuf;
+	struct ion_buffer *buffer = dmabuf->priv;
+	struct ion_mapping *map_ptr;
+
+	iommu_map = to_dma_iommu_mapping(attachment->dev);
+	if (!iommu_map)
+		return;
+
+	mutex_lock(&buffer->lock);
+	for (i = 0; i < ARRAY_SIZE(buffer->mapping); i++) {
+		map_ptr = &buffer->mapping[i];
+		if (!map_ptr->dev)
+			continue;
+
+		if (to_dma_iommu_mapping(map_ptr->dev) == iommu_map) {
+			kref_put(&map_ptr->kref, __ion_unmap_dma_buf);
+			mutex_unlock(&buffer->lock);
+			return;
+		}
+	}
+
+	dev_warn(attachment->dev, "Not found a map(%p)\n",
+		 to_dma_iommu_mapping(attachment->dev));
+
+	mutex_unlock(&buffer->lock);
 }
 
 void ion_pages_sync_for_device(struct device *dev, struct page *page,
diff --git a/drivers/staging/android/ion/ion_priv.h b/drivers/staging/android/ion/ion_priv.h
index 1eba3f2..441c251 100644
--- a/drivers/staging/android/ion/ion_priv.h
+++ b/drivers/staging/android/ion/ion_priv.h
@@ -26,11 +26,19 @@
 #include <linux/sched.h>
 #include <linux/shrinker.h>
 #include <linux/types.h>
+#include <linux/scatterlist.h>
 
 #include "ion.h"
 
 struct ion_buffer *ion_handle_buffer(struct ion_handle *handle);
 
+struct ion_mapping {
+	struct device *dev; /* to get a map and dma_ops */
+	struct sg_table sgt;
+	struct kref kref;
+};
+#define NUM_ION_MAPPING 5 /* FIXME: dynamically allocate more than this */
+
 /**
  * struct ion_buffer - metadata for a particular buffer
  * @ref:		refernce count
@@ -84,6 +92,8 @@ struct ion_buffer {
 	int handle_count;
 	char task_comm[TASK_COMM_LEN];
 	pid_t pid;
+
+	struct ion_mapping mapping[NUM_ION_MAPPING];
 };
 void ion_buffer_destroy(struct ion_buffer *buffer);
 
-- 
1.8.1.5
