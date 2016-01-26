From: eric.auger@linaro.org (Eric Auger)
Date: Tue, 26 Jan 2016 13:12:41 +0000
Subject: [PATCH 03/10] vfio_iommu_type1: add reserved binding RB tree
 management
In-Reply-To: <1453813968-2024-1-git-send-email-eric.auger@linaro.org>
References: <1453813968-2024-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1453813968-2024-4-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Legacy dma_list is just used to insert the reserved iova region and
check mapping of reserved iova happens in this window. As opposed to
other vfio_dma slots, the reserved one is not necessarily mapped.

We will need to track which host physical addresses are mapped to
reserved IOVA. In that prospect we introduce a new RB tree indexed
by physical address. This reverse RB tree only is used for reserved
IOVA bindings. It belongs to a given iommu domain.

It is expected this RB tree will contain very few bindings. Those
generally correspond to single page mapping one MSI frame (at least
for ARM, containing the GICv2m frame or ITS GITS_TRANSLATER frame.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
---
 drivers/vfio/vfio_iommu_type1.c | 63 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index c5b57e1..32438d9 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -56,6 +56,7 @@ MODULE_PARM_DESC(disable_hugepages,
 struct vfio_iommu {
 	struct list_head	domain_list;
 	struct mutex		lock;
+	/* rb tree indexed by IOVA */
 	struct rb_root		dma_list;
 	bool			v2;
 	bool			nesting;
@@ -65,6 +66,8 @@ struct vfio_domain {
 	struct iommu_domain	*domain;
 	struct list_head	next;
 	struct list_head	group_list;
+	/* rb tree indexed by PA, for reserved bindings only */
+	struct rb_root		reserved_binding_list;
 	int			prot;		/* IOMMU_CACHE */
 	bool			fgsp;		/* Fine-grained super pages */
 };
@@ -77,11 +80,70 @@ struct vfio_dma {
 	int			prot;		/* IOMMU_READ/WRITE */
 };
 
+struct vfio_reserved_binding {
+	struct kref 		kref;
+	struct rb_node		node;
+	struct vfio_domain	*domain;
+	phys_addr_t		addr;
+	dma_addr_t		iova;
+	size_t			size;
+};
+
 struct vfio_group {
 	struct iommu_group	*iommu_group;
 	struct list_head	next;
 };
 
+/* Reserved binding RB-tree manipulation */
+
+static struct vfio_reserved_binding *vfio_find_reserved_binding(
+				    struct vfio_domain *d,
+				    phys_addr_t start, size_t size)
+{
+	struct rb_node *node = d->reserved_binding_list.rb_node;
+
+	while (node) {
+		struct vfio_reserved_binding *binding =
+			rb_entry(node, struct vfio_reserved_binding, node);
+
+		if (start + size <= binding->addr)
+			node = node->rb_left;
+		else if (start >= binding->addr + binding->size)
+			node = node->rb_right;
+		else
+			return binding;
+	}
+
+	return NULL;
+}
+
+static void vfio_link_reserved_binding(struct vfio_domain *d,
+				       struct vfio_reserved_binding *new)
+{
+	struct rb_node **link = &d->reserved_binding_list.rb_node;
+	struct rb_node *parent = NULL;
+	struct vfio_reserved_binding *binding;
+
+	while (*link) {
+		parent = *link;
+		binding = rb_entry(parent, struct vfio_reserved_binding, node);
+
+		if (new->addr + new->size <= binding->addr)
+			link = &(*link)->rb_left;
+		else
+			link = &(*link)->rb_right;
+	}
+
+	rb_link_node(&new->node, parent, link);
+	rb_insert_color(&new->node, &d->reserved_binding_list);
+}
+
+static void vfio_unlink_reserved_binding(struct vfio_domain *d,
+					 struct vfio_reserved_binding *old)
+{
+	rb_erase(&old->node, &d->reserved_binding_list);
+}
+
 /*
  * This code handles mapping and unmapping of user data buffers
  * into DMA'ble space using the IOMMU
@@ -784,6 +846,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 		ret = -ENOMEM;
 		goto out_free;
 	}
+	domain->reserved_binding_list = RB_ROOT;
 
 	group->iommu_group = iommu_group;
 
-- 
1.9.1
