From: eric.auger@linaro.org (Eric Auger)
Date: Mon,  4 Apr 2016 08:07:02 +0000
Subject: [PATCH v6 7/7] dma-reserved-iommu: iommu_unmap_reserved
In-Reply-To: <1459757222-2668-1-git-send-email-eric.auger@linaro.org>
References: <1459757222-2668-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1459757222-2668-8-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce a new function whose role is to unmap all allocated
reserved IOVAs and free the reserved iova domain

Signed-off-by: Eric Auger <eric.auger@linaro.org>

---
v5 -> v6:
- use spin_lock instead of mutex

v3 -> v4:
- previously "iommu/arm-smmu: relinquish reserved resources on
  domain deletion"
---
 drivers/iommu/dma-reserved-iommu.c | 45 ++++++++++++++++++++++++++++++++++----
 include/linux/dma-reserved-iommu.h |  7 ++++++
 2 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/dma-reserved-iommu.c b/drivers/iommu/dma-reserved-iommu.c
index 3c759d9..c06c39e 100644
--- a/drivers/iommu/dma-reserved-iommu.c
+++ b/drivers/iommu/dma-reserved-iommu.c
@@ -119,20 +119,24 @@ unlock:
 }
 EXPORT_SYMBOL_GPL(iommu_alloc_reserved_iova_domain);
 
-void iommu_free_reserved_iova_domain(struct iommu_domain *domain)
+void __iommu_free_reserved_iova_domain(struct iommu_domain *domain)
 {
 	struct iova_domain *iovad =
 		(struct iova_domain *)domain->reserved_iova_cookie;
-	unsigned long flags;
 
 	if (!iovad)
 		return;
 
-	spin_lock_irqsave(&domain->reserved_lock, flags);
-
 	put_iova_domain(iovad);
 	kfree(iovad);
+}
+
+void iommu_free_reserved_iova_domain(struct iommu_domain *domain)
+{
+	unsigned long flags;
 
+	spin_lock_irqsave(&domain->reserved_lock, flags);
+	__iommu_free_reserved_iova_domain(domain);
 	spin_unlock_irqrestore(&domain->reserved_lock, flags);
 }
 EXPORT_SYMBOL_GPL(iommu_free_reserved_iova_domain);
@@ -281,4 +285,37 @@ unlock:
 EXPORT_SYMBOL_GPL(iommu_put_reserved_iova);
 
 
+static void reserved_binding_release(struct kref *kref)
+{
+	struct iommu_reserved_binding *b =
+		container_of(kref, struct iommu_reserved_binding, kref);
+	struct iommu_domain *d = b->domain;
+
+	delete_reserved_binding(d, b);
+}
+
+void iommu_unmap_reserved(struct iommu_domain *domain)
+{
+	struct rb_node *node;
+	unsigned long flags;
+
+	spin_lock_irqsave(&domain->reserved_lock, flags);
+	while ((node = rb_first(&domain->reserved_binding_list))) {
+		struct iommu_reserved_binding *b =
+			rb_entry(node, struct iommu_reserved_binding, node);
+
+		unlink_reserved_binding(domain, b);
+		spin_unlock_irqrestore(&domain->reserved_lock, flags);
+
+		while (!kref_put(&b->kref, reserved_binding_release))
+			;
+		spin_lock_irqsave(&domain->reserved_lock, flags);
+	}
+	domain->reserved_binding_list = RB_ROOT;
+	__iommu_free_reserved_iova_domain(domain);
+	spin_unlock_irqrestore(&domain->reserved_lock, flags);
+}
+EXPORT_SYMBOL_GPL(iommu_unmap_reserved);
+
+
 
diff --git a/include/linux/dma-reserved-iommu.h b/include/linux/dma-reserved-iommu.h
index dedea56..9fba930 100644
--- a/include/linux/dma-reserved-iommu.h
+++ b/include/linux/dma-reserved-iommu.h
@@ -68,6 +68,13 @@ int iommu_get_reserved_iova(struct iommu_domain *domain,
  */
 void iommu_put_reserved_iova(struct iommu_domain *domain, dma_addr_t iova);
 
+/**
+ * iommu_unmap_reserved: unmap & destroy the reserved iova bindings
+ *
+ * @domain: iommu domain handle
+ */
+void iommu_unmap_reserved(struct iommu_domain *domain);
+
 #endif	/* CONFIG_IOMMU_DMA_RESERVED */
 #endif	/* __KERNEL__ */
 #endif	/* __DMA_RESERVED_IOMMU_H */
-- 
1.9.1
