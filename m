From: eric.auger@linaro.org (Eric Auger)
Date: Tue, 26 Jan 2016 13:12:43 +0000
Subject: [PATCH 05/10] vfio/type1: attach a reserved iova domain to vfio_domain
In-Reply-To: <1453813968-2024-1-git-send-email-eric.auger@linaro.org>
References: <1453813968-2024-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1453813968-2024-6-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a reserved iova_domain to the vfio_domain struct.
This iova domain will enable to allocate iova within the reserved
iova region.

alloc_reserved_iova_domain makes possible to allocate and initialize
this iova domain. The user will be introduced in subsequent patches.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
---
 drivers/vfio/vfio_iommu_type1.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 33a9ce4..33304c0 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -36,6 +36,7 @@
 #include <linux/uaccess.h>
 #include <linux/vfio.h>
 #include <linux/workqueue.h>
+#include <linux/iova.h>
 
 #define DRIVER_VERSION  "0.2"
 #define DRIVER_AUTHOR   "Alex Williamson <alex.williamson@redhat.com>"
@@ -77,6 +78,7 @@ struct vfio_domain {
 	struct list_head	group_list;
 	/* rb tree indexed by PA, for reserved bindings only */
 	struct rb_root		reserved_binding_list;
+	struct iova_domain	*reserved_iova_domain;
 	int			prot;		/* IOMMU_CACHE */
 	bool			fgsp;		/* Fine-grained super pages */
 };
@@ -178,6 +180,41 @@ static struct vfio_dma *vfio_find_dma(struct vfio_iommu *iommu,
 	return NULL;
 }
 
+/* alloc_reserved_iova_domain: allocate an iova domain used to manage
+ * reserved iova
+ * @iova: base iova of the domain
+ * @size: size of the domain
+ * @order: iommu page size order
+ */
+static int alloc_reserved_iova_domain(struct vfio_domain *domain,
+				      dma_addr_t iova, size_t size,
+				      unsigned long order)
+{
+	unsigned long granule, mask;
+	int ret = 0;
+
+	granule = 1UL << order;
+	mask = granule - 1;
+	if (iova & mask)
+		return -EINVAL;
+	if ((!size) || (size & mask))
+		return -EINVAL;
+
+	domain->reserved_iova_domain =
+		kzalloc(sizeof(struct iova_domain), GFP_KERNEL);
+	if (!domain->reserved_iova_domain) {
+		ret = -ENOMEM;
+		goto out_free;
+	}
+	init_iova_domain(domain->reserved_iova_domain,
+			 granule, iova >> order, (iova + size - 1) >> order);
+	return ret;
+
+out_free:
+	kfree(domain->reserved_iova_domain);
+	return ret;
+}
+
 static void vfio_link_dma(struct vfio_iommu *iommu, struct vfio_dma *new)
 {
 	struct rb_node **link = &iommu->dma_list.rb_node, *parent = NULL;
-- 
1.9.1
